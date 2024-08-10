Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6998C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 12:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA5288802;
	Sat, 10 Aug 2024 14:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="AJr+4vlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14A88884F; Sat, 10 Aug 2024 14:46:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D803D887E8
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 14:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1723293973; x=1723898773; i=frank-w@public-files.de;
 bh=vf+ETFmGDmOy4Nb/k95EXk0YwqnueveJXJygzqbjlLc=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AJr+4vlqcVhXjIJdIjHFKIvcmifclmnmxn603QwKWZ7lM9KsnBt+3F+IzYKQLDmx
 OPeRJHuOitOY5pZPZMpbL4EA9z3C2+/vDrc/VM9HZNND73/MM/heJTsY8RLTgv9Ag
 J/882VLXkbFMFWMIrk9PgwTGDraGYpCdrO6ZM+LJ7vJdDk85t24OJZxQR+ClrrW1t
 z7HdqRd0fvcNcEo6sDYFdrKt+AlDEMtp+p4Go6M0QdYwyhiqaNaSgYd8oYJXeBg4K
 /NquIW63rIsVwagSa8fzVHX7lmLEoY0RzCUzB856uA71V13GeQPYo1bR1hWf7ztfq
 jPH4qPSt8IINgWgnKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.248] ([217.61.148.248]) by web-mail.gmx.net
 (3c-app-gmx-bs48.server.lan [172.19.170.101]) (via HTTP); Sat, 10 Aug 2024
 14:46:13 +0200
MIME-Version: 1.0
Message-ID: <trinity-00962129-7461-4c79-b915-6d8a238a55bc-1723293973890@3c-app-gmx-bs48>
From: Frank Wunderlich <frank-w@public-files.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: Aw: [PATCH 8/8] clk: mediatek: mt7622: add missing A1/2SYS clock ID
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Aug 2024 14:46:13 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20240802134835.24006-9-ansuelsmth@gmail.com>
References: <20240802134835.24006-1-ansuelsmth@gmail.com>
 <20240802134835.24006-9-ansuelsmth@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:p97wPwn5nYxlxVvvuGpFRj34rpwRAkTJxZSKeVEFxKPSuhK4pizpIie7NSwxgtLQpMse2
 113vp3kzY0yXafNlugZBhW3nGmuXLMANYZPTqaGKBm8vk4p60oilhGdJ7VX5iXGacLWBzdkoGGlo
 Dtn4Vf7Oit7e5DJIBYhLZM1dy8MfJHsMsKoTmp9uS9frCUhZ0EbParcrh7aF0xTo4XmBQlk9SjOB
 p+HkurgBHhV3LydliO16omx883rmNxfaxnMT9ocfF5aT0A4jG48GXPHQ+/BWhdX0mnU3uvV9DaCW
 lo=
UI-OutboundReport: notjunk:1;M01:P0:fFEkdN/u8Ig=;hm3toSXAzE7cpULXuc+1JlS3bbV
 zsi+ge3D/6P+6crnrknjbz9/GenjH2+z1jI1/yv0I1eyOdFATtn+4chrZBk0uLH0NTbweIuRi
 bx1dJM7fIX3OGyMm+AvCkAq3LlINVHLlnRxXh8XPS6T5aJX2R/trE8/q5M3zLTWg6Ou1ggRFV
 0JSg4Wq86/zi4ZYDS97pjZwidoDSfsOu34+73vg2GKBiDTMVSAr10wmOl0SOJYmZEdnAKoTLu
 wDYz8y5ljlcUJ7djAS6R4iASHz7wUUgMDDHud4QhyAbVUrqMoaBfUGeNZMG7f09t529Qk93Vo
 mRbDDgIZtRbO7ur785FNx1uU3OCmeBdWAklcgGb6ogYmPuIt5FXryDmdmMuIB8qhRSWbEhjaP
 tSWsAFAXAmeSBmDV9u1cmCsuNjSXQxY8QSUZFUpTQ/zw1E00tV0zUEwq7sCMIBHiWRJPMXTmN
 3YLp1qwpHMGrrXo585DWLbgMEYPhaJgZrGkn4pzceULQPX6bR4Hp0wWGlB3J3Oqbyi2UVy0O4
 cf1vZ1B7Pspu/vkis0/9TxRY+W9WZYD+SaDHqbx+CFTTwBSPkNmArYo6796o5+eDdaJBSArDe
 aQixzlzp9fkAraJ24qwr9eXXHGs9VjB7OnJYNSyPaRimmd8fU/Glx/2MQVJWXTcQ9drk3ztAZ
 F+jKhZbYq+AB2uKGrgBjO6S/ekmdASWIBJzQGSg/CQ==
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

Hi

tested full series on bananapi r64

does not break downstream DTS and works with modified upstream dts

tested mmc, pci, sata, ethernet, usb

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank


> Gesendet: Freitag, 02. August 2024 um 15:48 Uhr
> Von: "Christian Marangi" <ansuelsmth@gmail.com>
> An: "Lukasz Majewski" <lukma@denx.de>, "Sean Anderson" <seanga2@gmail.co=
m>, "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediate=
k.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "GSS_MTK_Uboot_upstrea=
m" <GSS_MTK_Uboot_upstream@mediatek.com>, "Tom Rini" <trini@konsulko.com>,=
 "Christian Marangi" <ansuelsmth@gmail.com>, u-boot@lists.denx.de
> Betreff: [PATCH 8/8] clk: mediatek: mt7622: add missing A1/2SYS clock ID
>
> Add missing A1/2SYS clock ID just as a reference for OF_UPSTREAM
> support. These clocks are not defined and are not usable as current
> clock topckgen OPs doesn't support gates.
>
> These special node won't ever be used by uboot hence just add them for
> reference.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/clock/mt7622-clk.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-binding=
s/clock/mt7622-clk.h
> index cd11a1c901e..cdbcaef76eb 100644
> --- a/include/dt-bindings/clock/mt7622-clk.h
> +++ b/include/dt-bindings/clock/mt7622-clk.h
> @@ -117,6 +117,8 @@
>  #define CLK_TOP_I2S1_MCK_DIV_PD		104
>  #define CLK_TOP_I2S2_MCK_DIV_PD		105
>  #define CLK_TOP_I2S3_MCK_DIV_PD		106
> +#define CLK_TOP_A1SYS_HP_DIV_PD		107
> +#define CLK_TOP_A2SYS_HP_DIV_PD		108
>
>  /* INFRACFG */
>
> --
> 2.45.2
>
>
