Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEFFC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 15:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25722801B0;
	Thu, 23 Jan 2025 16:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="rjGSgIok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEA880214; Thu, 23 Jan 2025 16:16:09 +0100 (CET)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B39380137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 16:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737645365; x=1737904565;
 bh=Jd9QKIx1qAlkiu1xUlBQvAgjwCBTJbdDlqB1WQk9GkI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=rjGSgIokSEhWGdKZI2JK8iAuKd3FJkm1NlGwfa5jQ1Bdi+zDk8n+c5PQPPgPje7R7
 1Kex/7b3MHj0yuBCp5yJ1qiOiZmTGy87BkrVaCL2rOlQQ9LzRKOVE2DL+c71JzwYA4
 yaMkUxzzC/NhtN0EXRsy0q0y50VJoLxa0DgSCOoctyIKTzGh/2xwWgipulwuFi1hCU
 ib9m3oHpv5SUj2mQxquKndh8eLwMuhqgHyhXS65zz0KHM80ltZDmU2KfFT+m5cT80Z
 hU3XsT5dTJHvG6MKgnmU+vaWEKuyMj7cmry9+DW7yj1MzfbiBgf3MhvUugEOzOfqBJ
 XazxBqnfONxBg==
Date: Thu, 23 Jan 2025 15:16:01 +0000
To: Simon Glass <sjg@chromium.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] mach-snapdragon: pass fdt to qcom_parse_memory
Message-ID: <1VNKkmL9nHfNP7DNQi9hMlzPAlGefQBJpZXl0ogjmz2jhXDdK1BoIPoWgrvaDp2YkhmfyxT-gicM7qXjQkLu68GL-JjiKP3wHFU_pJM_1Ho=@samcday.com>
In-Reply-To: <CAFLszTjcgo3z=4rSxZt7b8Gojy+YvnPBxP=09mrZDB6GJgjQnA@mail.gmail.com>
References: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
 <20250122-qcom-parse-memory-updates-v2-1-98dfcac821d7@samcday.com>
 <CAFLszTjcgo3z=4rSxZt7b8Gojy+YvnPBxP=09mrZDB6GJgjQnA@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 5cdd3a93b5203b523158942b9360b2d0a37b71c2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Salutations Simon,

On Thursday, 23 January 2025 at 15:37, Simon Glass <sjg@chromium.org> wrote=
:
>=20
> Hi Sam,
>=20
> On Wed, 22 Jan 2025 at 03:27, Sam Day me@samcday.com wrote:
>=20
> > commit fc37a73e6679 ("fdt: Swap the signature for
> > board_fdt_blob_setup()") introduced a subtle change to the Snapdragon
> > implementation, removing the assignment to gd->fdt_blob partway through
> > the function.
> >=20
> > This breaks qcom_parse_memory() which was also called during
> > board_fdt_blob_setup().
> >=20
> > The underlying issue here is that qcom_parse_memory is using the of_ ap=
i
> > to traverse a devicetree, which relies on the fdt_blob in global data.
> >=20
> > Rather than relying on this subtle behaviour, explicitly pass the FDT
> > that should be consulted for a /memory node.
> >=20
> > Using the OF API is typically preferable because it's easier to read,
> > but using the lower level fdt_ methods instead here doesn't add too muc=
h
> > complexity, I think.
> >=20
> > Finally, a minor tweak was made to board_fdt_blob_setup to use the
> > passed fdt blob pointer instead of gd->fdt_blob, which removes the last
> > of the references to global data in this area.
> >=20
> > Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup()=
)
> > Reviewed-by: Caleb Connolly caleb.connolly@linaro.org
> > Signed-off-by: Sam Day me@samcday.com
> > ---
> > arch/arm/mach-snapdragon/board.c | 15 ++++++++-------
> > 1 file changed, 8 insertions(+), 7 deletions(-)
>=20
>=20
> Reviewed-by: Simon Glass sjg@chromium.org
>=20
>=20
> But I'm looking forward to some form of Caleb's patch landing too[1].

Hm, this patch was intended to be a replacement for the one you linked. It'=
s
already been pulled into upstream/master. Was there something specific in t=
hat
patch that you still want to see land?

I saw your comments there today and AFAICT this patch already addressed the
desire to stop mutating gd->fdt_blob from board_fdt_blob_setup. That was
necessary in Caleb's patch because qcom_parse_memory was using of_ API meth=
ods
to scoop out /memory node info. This patch opted instead to use fdt_ and op=
erate
on the provided *fdtp directly.

Regards,
-Sam


>=20
> Regards,
> SImon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250117102734.37250=
09-2-caleb.connolly@linaro.org/
