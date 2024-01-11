Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F1CC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 17:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16B187930;
	Thu, 11 Jan 2024 18:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rahix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rahix.de header.i=@rahix.de header.b="RXaymCYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7FB87751; Thu, 11 Jan 2024 18:51:51 +0100 (CET)
Received: from mail.rahix.de (rahix.de [185.170.115.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2419A87776
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 18:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=rahix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rahix@rahix.de
Authentication-Results: mail.rahix.de;
 dmarc=fail (p=none dis=none) header.from=rahix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rahix.de;
 s=a-selector; t=1704995555;
 bh=X7iDjJbKQfvZLJqf9pwbcs0c4b/g/2Hshr99uXuuZfo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=RXaymCYnjIgM06GwM9Vua1NPKhmWRbeRKDkFUnmKdvd6/pvli4nHyoRIJpNwOxLpP
 AinOvB7hQmT9fBDsORo2ziJWGQm6C+Hz+ZKSmJD7CyORv7PKyaloSzwhqxQxcHSvrR
 khRD9f7qt/NUDC4/AN+s8kg81tfwQ5vBjWeFqzYK4GaYF+AJ6B10l/FZn3P7a07PqL
 4UZ7cNGCR9GsfWQhUCXSZ/rKHixqAwCAr7IejKYV+mEGGj999xiziiug30t3c0ZeAW
 HlAKJs53bhjR4o8GFRvg3jsPwpoDNugvu5LWLjd/44q16vSzW6mutZ4NGEFEWpZs69
 q8lZYE2CHNkOw==
Message-ID: <d2bebeb244f5b6cc396e1b0b1d78edd2655c2b97.camel@rahix.de>
Subject: Re: [PATCH 1/1] test: Skip cleanup test if not built out of tree
From: rahix <rahix@rahix.de>
To: Tobias Deiminger <tdmg@linutronix.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Harald Seiler <hws@denx.de>
Date: Thu, 11 Jan 2024 18:51:47 +0100
In-Reply-To: <20240108211100.112730-2-tdmg@linutronix.de>
References: <20240108211100.112730-1-tdmg@linutronix.de>
 <20240108211100.112730-2-tdmg@linutronix.de>
Autocrypt: addr=rahix@rahix.de; prefer-encrypt=mutual;
 keydata=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
 N5eftlrXcJt5uaP+FoonOrTg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Jan 2024 18:55:45 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 2024-01-08 at 22:11 +0100, Tobias Deiminger wrote:
> 42c0e5bb054d ("test: Find leftovers after clean/mrproper") assumes out
> of tree builds. test_clean and test_mrproper fail if the assumption
> isn't met.
>=20
> However there are valid scenarios where tests run with in source builds
> (i.e., test.py --build-dir=3D.).
>=20
> Automatically skip cleanup tests in such scenarios to prevent false
> positives.
>=20
> Signed-off-by: Tobias Deiminger <tdmg@linutronix.de>

Reviewed-by: Harald Seiler <u-boot@rahix.de>

> ---
> =C2=A0test/py/tests/test_cleanup_build.py | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/test/py/tests/test_cleanup_build.py b/test/py/tests/test_cle=
anup_build.py
> index 5206ff73ec..aca90cb110 100644
> --- a/test/py/tests/test_cleanup_build.py
> +++ b/test/py/tests/test_cleanup_build.py
> @@ -17,6 +17,11 @@ import pytest
> =C2=A0@pytest.fixture
> =C2=A0def tmp_copy_of_builddir(u_boot_config, tmp_path):
> =C2=A0=C2=A0=C2=A0=C2=A0 """For each test, provide a temporary copy of th=
e initial build directory."""
> +=C2=A0=C2=A0=C2=A0 if os.path.realpath(u_boot_config.source_dir) =3D=3D =
os.path.realpath(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_boot_config.build_dir
> +=C2=A0=C2=A0=C2=A0 ):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pytest.skip("Leftover detecti=
on requires out of tree build.")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return None
> =C2=A0=C2=A0=C2=A0=C2=A0 shutil.copytree(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_boot_config.build_dir,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_path,

