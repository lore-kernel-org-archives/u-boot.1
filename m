Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D138C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 23:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BF287B8E;
	Fri, 16 Feb 2024 00:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZcnWvWov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2326D87C6D; Fri, 16 Feb 2024 00:38:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC868765B
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 00:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708040307; x=1708645107; i=xypron.glpk@gmx.de;
 bh=d2mtpUtOxg2QX2xiJNoPxUA+MaD0amgYA475PWpvkfw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=ZcnWvWovT/S/iazK+XXWLw9WOQpWsdHOSaYqEGNgl5Mq05Z3CgBJVbNabiODaSnn
 HmU8IM6x0rzHxYB+oWANwjurArfXRPJxz+t5WuK1xe8tgusxP2WPREIR9gKQGdqzq
 ftfs6iymL3hgGEy4agmlizHUBiaTiZUPVIrgWjqmykpzcEeYMk0iWgbW0iqEaleTe
 n2roRBhYMRu6IOKtkEdBEuy2Ph5T8VgZbn6u22aHNOL1cBNJo1lpJQW/EK5GvMPCL
 FTjQRt7yR4zJtIxn0xqnPem1o4O9Ay5A9tcQ0KhkhatbuOva7/9wxpY4W7vvXkHrE
 sHd/SDX/zra45Z964w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1rLjWk1IbZ-00OaV8; Fri, 16
 Feb 2024 00:38:27 +0100
Date: Fri, 16 Feb 2024 00:38:25 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
CC: ilias.apalodimas@linaro.org, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
Subject: Re: [PATCH] efi_loader: Don't carve out memory reservations too early
User-Agent: K-9 Mail for Android
In-Reply-To: <20240215232534.61854-1-kettenis@openbsd.org>
References: <20240215232534.61854-1-kettenis@openbsd.org>
Message-ID: <E6C02326-1F4B-446E-86F3-93AACE34814E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T6u9Yl7I+Wq3MqbRxLDYcZnXKBUecWYWVltcZwsx55XRBhNU9jQ
 vkeDBy7jlMxVAs5gbZoZ7dsYgykgZnOutGo8kko9vePE5opz4xqjBiHYtDmTRkglnYm0Z9q
 A8to5kuXcBaBaXDUnhjxZY1T/Xkvbpb4SJ3/AKgyHo0nkJRk+WEjuix6peW7vur+kldle0O
 BNCYDTdYg/PCB9gDYkdMg==
UI-OutboundReport: notjunk:1;M01:P0:6uJMd65sCTo=;NScDfNPbxl/y7YOMbvSmkVEYW8G
 /9BjH7YIK/X8F6y3X80dRjF82lUE6+JWyi6IpJwm9Jh5MuEdL3n+VU74df0KJwhNH8DaoX/AH
 lTVGUwwaNaMYW7JRVqUC6Uw0p/QeREZCmB4ofrjH41gw94uFxVwskiOE1zCK9AgYyJvcKaCsK
 rd4Uc3BvO5nKPCQUjFpUbsFKSAh/TNDD0Dc//OYNuLWtsbw9kjRRcBcbprpqGA5Zo9Jna3AAT
 B6MfEvC4PugjRzdEU/ymicfkWEmOoEnOeCaQFpnKtcXS5ECi0Il0YCJIWS969YNdITie1R2zC
 cNQUGPYFNNS19S8507Tzxz+T+3jJ3o6uONkUuCiWdlQpKoDuxACC+y38wQ4K9laa3ng5FstG1
 oL2ghdNWzVMluGmmflJpvlxaCaWuatvL6aZRtohoKBIFeTNU+QvYpvDGPtmsoI4rALUH7+APb
 pBuOUXLF7PxdJHzwyYayCuKiDXYYlSqj+uSpfjL6E758BLGBYatewWQUdZDyY4AXNPtmFd7r7
 5S9QA2BuWHNTwxwZa053UPJBxDodXxhsUvFBcZHBdu0gusYB98kZ99wtgZCtUO0Ku8d7zOAXu
 fkllOwvbpvwXhP99WPp6uXdv95FpKIiOM+WQvt1FjsJHvbjQwBk4uOgpzxmKwNeIgQbkWW1QM
 ZUafPtBZ6KYAn4ipyOq5BL0H7A0MlvP1HD992If+j2TCa/jHUELA47bnKmEk9ZFmVdkp2T9Ei
 8KLIqd4o5AkJ3Wwe1ajB2BhERMefgGMk6AVDjdOBQ95WAX08MI42QkomaJIHW4mzG3wENmOZ0
 eSURerL5KDbgAMB9KCyALi79kRyUreLPkeIdpTZlMwzjs=
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



Am 16=2E Februar 2024 00:25:34 MEZ schrieb Mark Kettenis <kettenis@openbsd=
=2Eorg>:
>Moving the efi_carve_out_dt_rsv() call in commit 1be415b21b2d
>("efi_loader: create memory reservations in ACPI case")
>broke boards that create additional memory reservations in
>ft_board_setup() since it is now called before those additional
>memory reservations are made=2E  This is the case for the rk3588
>boards and breaks booting OpenBSD on those boards=2E
>
>Move the call back to its original location and add a call in
>the code path used for ACPI=2E
>
>Fixes: 1be415b21b2d ("efi_loader: create memory reservations in ACPI case=
")
>Signed-off-by: Mark Kettenis <kettenis@openbsd=2Eorg>
>---
> lib/efi_loader/efi_helper=2Ec | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/lib/efi_loader/efi_helper=2Ec b/lib/efi_loader/efi_helper=2E=
c
>index 5dd9cc876e=2E=2E58761fae78 100644
>--- a/lib/efi_loader/efi_helper=2Ec
>+++ b/lib/efi_loader/efi_helper=2Ec
>@@ -456,11 +456,11 @@ efi_status_t efi_install_fdt(void *fdt)
> 		return EFI_LOAD_ERROR;
> 	}
>=20
>-	/* Create memory reservations as indicated by the device tree */
>-	efi_carve_out_dt_rsv(fdt);
>-
>-	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
>+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
>+		/* Create memory reservations as indicated by the device tree */

Imagine booting the rk3588 board with ACPI=2E Wouldn't we miss creating th=
e ft_board_setup() reservations before efi_carve_out_dt_rsv(fdt)?

Best regards

Heinrich

>+		efi_carve_out_dt_rsv(fdt);
> 		return EFI_SUCCESS;
>+	}
>=20
> 	/* Prepare device tree for payload */
> 	ret =3D copy_fdt(&fdt);
>@@ -474,6 +474,9 @@ efi_status_t efi_install_fdt(void *fdt)
> 		return EFI_LOAD_ERROR;
> 	}
>=20
>+	/* Create memory reservations as indicated by the device tree */
>+	efi_carve_out_dt_rsv(fdt);
>+
> 	efi_try_purge_kaslr_seed(fdt);
>=20
> 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
