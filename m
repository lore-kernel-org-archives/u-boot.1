Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCFFC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 05:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA5E8091A;
	Thu,  5 Jun 2025 07:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mnTFRyfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B58681E25; Thu,  5 Jun 2025 07:10:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4430480050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 07:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749100196; x=1749704996; i=xypron.glpk@gmx.de;
 bh=JD8PAx2BZch/+W5evzknxJB0T0w0sjxxNiypuxb/iUI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mnTFRyfFllek905AjgxlKm64lmyimcvbGhROyakuJcklMF0Pd3Q3OqWzVhOGyVlm
 l3WOw0Wv7NNqwGXLTI+3qBv1MENGLeW9tfE819BkdMpb05P0YLQhCX58zVNybGrqr
 /taH3XBQ/XkVE7KhzjsJ49BIrbH1rJsXwWxwe+oUD28TSCJqvB+Yw+h9D+7tijF5A
 QgIJ7NlBRXFeLOXXTCzuikhVJZN4CiauvtS0fMbMRRZqVtS48LwoilRdPljYacg5c
 0VIT212HqWh2qEX/ObRIKMj+Y19hpj6D+521ei20VzNLXQRzCEGo4V6oh4V7yPepX
 XkWwC7hUCBOtpZuIDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.0.66]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1us22V3TAe-014lRm; Thu, 05
 Jun 2025 07:09:56 +0200
Date: Thu, 05 Jun 2025 07:09:51 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, uboot-snps-arc@synopsys.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_09/12=5D_efi=3A_drop_volatil?=
 =?US-ASCII?Q?e_qualifier_from_=22save_gd=22_variables?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250604195612.2312979-10-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604195612.2312979-10-ravi@prevas.dk>
Message-ID: <8CDBB84E-96C5-48F0-B4AE-A8C64BB4F70C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2qCFYmtGZcYeoAoF4PO82eBefIvaElGrJx4GmMiC2FHS1qQdpg
 jt+egk9CbrKU0mIUxBn5IfGaBED9dqa46I+VblF6s/lLyLPGeV1NTxRrm3f9AEuUKk0wcne
 ydrXWw5ofXZVdGw89v1UOBvrfWQYnT2kqj2ys8kloYledB9HQPDaSlL56JrSgA3GsiU5P7r
 +ZVIu7hH7TzqWyDOrxB5Q==
UI-OutboundReport: notjunk:1;M01:P0:aoYaBcYmZYc=;qh3kpGBSm+zMvY/UWpvH5y0+Al8
 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
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

Am 4=2E Juni 2025 21:56:09 MESZ schrieb Rasmus Villemoes <ravi@prevas=2Edk>=
:
>The global gd pointer is no longer volatile-qualified, so drop that
>qualifier from these bookkeeping variables=2E
>
>Signed-off-by: Rasmus Villemoes <ravi@prevas=2Edk>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
> lib/efi_loader/efi_boottime=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/efi_boottime=2Ec b/lib/efi_loader/efi_boottim=
e=2Ec
>index 24b0e52a2a2=2E=2E754bc6a6519 100644
>--- a/lib/efi_loader/efi_boottime=2Ec
>+++ b/lib/efi_loader/efi_boottime=2Ec
>@@ -58,7 +58,7 @@ static efi_handle_t current_image;
>  * restriction so we need to manually swap its and our view of that regi=
ster on
>  * EFI callback entry/exit=2E
>  */
>-static volatile gd_t *efi_gd, *app_gd;
>+static gd_t *efi_gd, *app_gd;
> #endif
>=20
> efi_status_t efi_uninstall_protocol

