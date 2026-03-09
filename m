Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498CBF3C245
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C1F83BC7;
	Mon,  9 Mar 2026 13:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cVoA1uWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CC68063E; Mon,  9 Mar 2026 13:37:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31768063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773059823; x=1773664623; i=xypron.glpk@gmx.de;
 bh=oRNCKsxsenOGuiXlvPVh82zyVr7om4zW3uBV03er2to=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cVoA1uWSmLA1hbHqkAgjEzghtLHi1N0REAmiRQeT4D+vBR6jngBoMuGeVFvC5N/X
 dmSNhFuXSLhDc6zjxGRv/HkhuXi2fXAl79bGzZ1zD0rVorTSNZ/tR5ZUBNZtoezxj
 tNP1pqZurEtAnVu8ObUUCw5c57SCT3JTdgmyQ12eXDS+cMxnRrjtaTAxi7AFapf5W
 yKeFcFAXGHZFwpJ25AB6TQiGCHr8KyyXC/exIwnzJyS9zEfddxPeXLKu8NUOnYJQS
 JtvM3ylF7Ja2d3dq4lKJ+/DpdYwfNXnV6dK44kHUBkEGziUUqjgFih+0T5wmsE5nk
 G229lTJYimZJbkwWqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1vqT2D3g6V-006OFQ; Mon, 09
 Mar 2026 13:37:02 +0100
Message-ID: <f1b9f0e2-e891-4b9f-94e4-49719bd6cea2@gmx.de>
Date: Mon, 9 Mar 2026 13:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] test/py: add ECPT tests
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260305161349.2317130-5-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260305161349.2317130-5-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZTNss5jDJpOaWs2N8Tv9QOaZld5A4JM252uwn0vEBWjh4R2mN5y
 YwUfT8hvXjiVLwU4YquwXJzUTyIErt3JIwhWP0bBXSY3DS+nyxFbCX4axe9nkIT+0HlHBKr
 q5g2UeC8CFl10kYVEmRvbKVo0Gd75Z34m9y7HjVedvfGnytvPDuANsASvrbCSHMVKpDI2Yr
 n0QmJABPqCHUyKBhFANnA==
UI-OutboundReport: notjunk:1;M01:P0:XriimP4QaJ8=;TbpOkKFLrKOkv0MpEA7ussrTnlO
 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
 /VA3UQ2VgbLp+IuI+9C5yntiD4bn0
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

On 3/5/26 17:13, Vincent Stehl=C3=A9 wrote:
> Add a couple of EFI Conformance Profiles Table (ECPT) tests, which exerc=
ise
> the "efidebug ecpt" command.
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   test/py/tests/test_efi_ecpt.py | 42 ++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 test/py/tests/test_efi_ecpt.py
>=20
> diff --git a/test/py/tests/test_efi_ecpt.py b/test/py/tests/test_efi_ecp=
t.py
> new file mode 100644
> index 00000000000..5e7c79c4577
> --- /dev/null
> +++ b/test/py/tests/test_efi_ecpt.py
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +""" Unit test for the EFI Conformance Profiles Table (ECPT)
> +"""
> +
> +import pytest
> +
> +
> +@pytest.mark.buildconfigspec('cmd_efidebug')
> +@pytest.mark.buildconfigspec('efi_ecpt')
> +def test_efi_ecpt(ubman) -> None:
> +    """ Unit test for the ECPT
> +    This test assumes nothing about the ECPT contents, it just checks t=
hat the
> +    ECPT table is there and that the efidebug ecpt command does not fai=
l.
> +
> +    Args:
> +        ubman -- U-Boot console
> +    """
> +    response =3D ubman.run_command('efidebug tables')
> +    assert ('36122546-f7e7-4c8f-bd9b-eb8525b50c0b  '
> +            'EFI Conformance Profiles Table') in response
> +
> +    response =3D ubman.run_command('efidebug ecpt')
> +    assert 'Unknown command' not in response
> +    assert 'Configure UEFI environment' not in response
> +    assert 'Usage:' not in response
> +    assert 'table not present' not in response
> +
> +
> +@pytest.mark.buildconfigspec('cmd_efidebug')
> +@pytest.mark.buildconfigspec('efi_ecpt')

EFI_EBBR_2_1_CONFORMANCE depends on EFI_ECPT.

Given the next line the line above is redundant.

> +@pytest.mark.buildconfigspec('efi_ebbr_2_1_conformance')

If CONFIG_EFI_ECPT=3Dy and CONFIG_EFI_EBBR_2_1_CONFORMANCE=3Dn, we still=
=20
expect the `efidebug ecpt` command to succeed.

I would suggest to move the CONFIG_EFI_EBBR_2_1_CONFORMANCE check to=20
inside the test. This also matches that the EBBR defines more=20
conformance levels which we should add to the ECPT table.

> +def test_efi_ecpt_ebbr_2_1(ubman) -> None:
> +    """ Unit test for the ECPT, with EBBR 2.1 profile
> +    This test uses the efidebug ecpt command to dump the ECPT and check=
 that
> +    the EBBR 2.1 conformance profile is there.
> +
> +    Args:
> +        ubman -- U-Boot console
> +    """
> +    response =3D ubman.run_command('efidebug ecpt')
> +    assert ('cce33c35-74ac-4087-bce7-8b29b02eeb27  '
> +            'EFI EBBR 2.1 Conformance Profile') in response

I don't think that printing out the GUID in hexadecimal is helpful for=20
users. But that would be a change in 3/4.

Best regards

Heinrich
