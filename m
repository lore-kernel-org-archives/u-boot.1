Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC42CC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 21:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B1A880AE;
	Wed, 26 Jun 2024 23:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="lNTw1g64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA418826B; Wed, 26 Jun 2024 23:16:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A125C87D43
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 23:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1719436598; x=1720041398; i=frank-w@public-files.de;
 bh=DpQv7fqQmPqyyzWB9ywfaDo77ezhtq8IJVZAq+6uIY8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lNTw1g64/Q4SKs6h4Y9Qjyk2V+RsnC2ZSplFZIHN7w8wqKuGSqa5Prdii68pbygV
 44MtNVttCCLyheZdnFG05aseKFtNgnkMWiyh4fALYzhYi8lWn8w3aVV72EQ9U1HIm
 rB6rDVPOuRAKtAPoI3MNU+iENKaEQjBUnBLqw5kWh+mIRalXCFyrAyF5XOVzOuVVc
 rAlEq+JyD74d9jZzfFV9OhDvbKmtiw5PCryFcppQnP4CkZIN1ztqmRObPvylUL9+8
 8EUk1QL0u53xraMYMchI6ZBW8fQDxPgG7dJm6vDjyaF7/DjO3ROELhw0s1TCfPB95
 vubdn4EqDnxF/envWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.144.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1silap09ZJ-00dNlN; Wed, 26
 Jun 2024 23:16:38 +0200
Date: Wed, 26 Jun 2024 23:16:38 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mediatek: fix ram init for mt7622 (decrease to 1G)
User-Agent: K-9 Mail for Android
In-Reply-To: <20240615093456.95856-1-linux@fw-web.de>
References: <20240615093456.95856-1-linux@fw-web.de>
Message-ID: <5FB36B12-AE76-47FE-AEFC-76A47A5B57C7@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YAQ5AAxgOBuCgApc4syrY5YNfy62tK6tcY12CusToDLA55pFzIT
 sqMrYPvey/Vs2FvMFt66xYmrspkLp4Q1Lme7gTMJW/KDgzXfxQJaV1bcT9iVQRAfLyzHNgN
 rK1/wKhGSsdy9Uxok9+U3s4jahPRDTffclBdhT3oq+B0WZG7k41VGa1nSUtb0ksPkWuZszm
 xQNfI6B1bsSbbe3goLWIA==
UI-OutboundReport: notjunk:1;M01:P0:7yqqrs4+cdQ=;KmaUaaEvfig+rAjsHKDTPPXBIQl
 kXfVGobsIDFyZMJKh7Lvu++gerYhOBnPesW+gRnOSvk9oLfJbe0ky5Z10xeIyTNuUAFqm3EL5
 IbR7icAEPaE394omZ3L6ns20LhdvinGuvCzw0TJuuuUAhDG/Nnb+smfng7rMx6r2M7ZXYHWlt
 Ny3ARuQ/EPsICcjUmX+hWufxgQ4QfCQR8zsDUbvb3Qf9fBMjbMkPRbzD4lhAHV2ZEXQatMKaV
 qq0gD/llhD31LoC4eFVm8/ie1b91at9KKkzduqCP5lxNBuYcIeTlNOht3AW/b/sklJYpGIabs
 KOHnhuWaWQPlT5d3sqYYhIjoMv04u3TC0CSSYYFNC7ma3vcLKFZmWbD+Gaqx6b1kadZBitzno
 ugJ+O5D93cEhLvNrEay+nWLIoqbqjOa2CjDcTifO/EpoYw3pd3UAZYy9MgwH9sV/8kIaegNO5
 /kO2/TXF3I3lAUgK8MYRsJgeeTfS6TIi3YF4F5u24Y5bgiogXUZwDhZop9wuX5Rlk+KMjHbW+
 L5JcCZPoe6j5Inz6GohqV4io4t0wJiSHKn+I8YyxdXmXCE/W5zIxyI+AdEk/SwfwaQ69qnigr
 +Mz/bJ/U0Vu7G848qbxzPhSZrKfjcDXdEIpfbwHE2oej4mX3eTigUcTJewMPsvttOvfZGodcw
 KN0PZgPIqjy+36saDIAxvmqNS0cdZOKz1Zfr5y5fasDHU4z5djujfXTIVKEw1f0CKwE07AjyN
 NqHcvdv/fK7fMIFTbQ3HMLr5vsNwbyacXc8fTxnxJDIYf8zl0g7czlgC78pVhVI8xIjkzYigz
 NColb+Mf5OLNvG7OvyzRufzheGIiMQ2VHXilT/K78OqyI=
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 15=2E Juni 2024 11:34:56 MESZ schrieb Frank Wunderlich <linux@fw-web=2Ed=
e>:
>From: Frank Wunderlich <frank-w@public-files=2Ede>
>
>RAM init on mt7622 based bananapi R64 is broken since v2023=2E10=2E
>
>Increasing the mem-map does not help here, so i reduced the maximum
>available ram in get_ram_size call from 2G to 1G (board has only 1G)=2E
>
>Fixes: 5fd6d4c7b3ad ("arm: mediatek: retrieve ram_base from dts node for =
armv8 platform")
>Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>---
> arch/arm/mach-mediatek/mt7622/init=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm/mach-mediatek/mt7622/init=2Ec b/arch/arm/mach-media=
tek/mt7622/init=2Ec
>index 00d3eb9ce7a4=2E=2E1f32ff947dcd 100644
>--- a/arch/arm/mach-mediatek/mt7622/init=2Ec
>+++ b/arch/arm/mach-mediatek/mt7622/init=2Ec
>@@ -28,7 +28,7 @@ int dram_init(void)
> 	if (ret)
> 		return ret;
>=20
>-	gd->ram_size =3D get_ram_size((void *)gd->ram_base, SZ_2G);
>+	gd->ram_size =3D get_ram_size((void *)gd->ram_base, SZ_1G);
>=20
> 	return 0;
> }

Hi Tom,

Can you pick this fix for 2024=2E7?


regards Frank
