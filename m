Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62891C3ABC3
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E012181F32;
	Wed,  7 May 2025 17:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="edbd5qHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9AA8212F; Wed,  7 May 2025 17:03:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513858059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746630179; x=1747234979; i=xypron.glpk@gmx.de;
 bh=yS3dfJ5/9uy/lZj4TTpd9kFxeuWeteB1FvCoWvGPIds=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=edbd5qHk5PzF2z1qfdZzvEPPIHKVkrf/oiXwvXT7yOSwF7bIPnTIgGL8kDjtOszz
 kZ8ozaP2SVDtaQGebPkij2mlMP+OtQWpHXrzzanKVpC67gWaEaOy2cnT4WYZ4okLl
 1PtzUpZjYXsc0h/6chACSr+CV8uDWP+Cv5AfX3k+CDlmYLhAG0Rqr2Yz/ItmZrRbo
 qFXtdYLyMMJ28F7cWjFH3z9BjluF0ULhEFUc2cKu8PS3UlnutKEvlFv/sMR1Gp9vc
 atavMXC7H9CJBwGi0dZy8wxHhjgj+xipcc2Ott64uETad+aqn7WBu8paCaguUimy8
 I3EWlhOKS1LO+CMFFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.157.19.150]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1v0Wvg0JQp-00vzZG; Wed, 07
 May 2025 17:02:59 +0200
Date: Wed, 07 May 2025 17:02:56 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
CC: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 1/3] efi_loader: initrddump: use efi_uintn_t in printx
User-Agent: Thunderbird for Android
In-Reply-To: <20250507144619.3288456-2-adriano.cordova@canonical.com>
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
 <20250507144619.3288456-2-adriano.cordova@canonical.com>
Message-ID: <700D243C-61F5-415C-8506-8DB58F23E04B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SqLg0WPGaUkSwy+T2qF7wH/9FXhWHCyZ30aE+4nT+0cqzraGbJ/
 lLAKeUihnAZVQqpv4oyPNWDaYuExLcaPUwJk54vf6aSfUtdYJ+tj2ZW/IMbO+BUMEWUUZTW
 tswJg23fZcGdcsK2OyXYyfuQUGXdd2DdwVopIGtNPE09Ev6RhvCZe0fbY6/Abx6QhVnWsWA
 GPJD5Nn431bM4tJezxMoQ==
UI-OutboundReport: notjunk:1;M01:P0:MVmp+noFoIs=;drm+tVef7uoWHFnhsSKnbXUbqQo
 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
 0oJojByi3oR/Q=
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

Am 7=2E Mai 2025 16:46:17 MESZ schrieb Adriano Cordova <adrianox@gmail=2Eco=
m>:
>Use efi_uintn_t so that it also works in 32-bits=2E
>
>Signed-off-by: Adriano Cordova <adriano=2Ecordova@canonical=2Ecom>
>---
> lib/efi_loader/initrddump=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/lib/efi_loader/initrddump=2Ec b/lib/efi_loader/initrddump=2E=
c
>index 615119043d1=2E=2E8d08f7c5cd5 100644
>--- a/lib/efi_loader/initrddump=2Ec
>+++ b/lib/efi_loader/initrddump=2Ec
>@@ -99,7 +99,7 @@ static void error(u16 *string)
>  * @val:	value to print;
>  * @prec:	minimum number of digits to print
>  */
>-static void printx(u64 val, u32 prec)
>+static void printx(efi_uintn_t val, u32 prec)
> {
> 	int i;
> 	u16 c;
>@@ -342,7 +342,7 @@ static efi_status_t do_load(void)
> 		return EFI_LOAD_ERROR;
> 	}
> 	print(u"crc32: 0x");
>-	printx(crc32, 8);
>+	printx((efi_uintn_t)crc32, 8);

Why wouldn't the code work for u64 which is defined as unsigned long long?=
 That type must be supported by all EFI architectures=2E

Best regards=20

Heinrich


> 	print(u"\r\n");
>=20
> 	return EFI_SUCCESS;

