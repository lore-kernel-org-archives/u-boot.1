Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DD606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zywhMbnw;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Msq5czBD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B888A60A75;
	Thu, 29 Oct 2026 19:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvDYyakaseB9; Thu, 29 Oct 2026 19:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 049AF60A79
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793302769;
	b=mALumW3tja3udCywwt6D9xhq395t8996wQo1pnZMI+PNbMB1neY7CWzcYmK9/8s7haWf
	 D2V4WDdZxb2zDTSvrWQtBrrVkpvTdp2tRIQ8IfIV7NRJ0sfhHFoy4I+7rxFnJENkB0oZU
	 294gx4H7kL1od3CGBBUlw0Q+MvQgE+B7aP8c/zlWoIuG4kgFpOLBdjf4cwdvq1IFA2kof
	 3GMx+MW8qtaWXy/ySv+GTdCxr0mDJQUuYuGjQ/MyYLGLXKYYcrm3MDyQiQRA5IldY5EOh
	 Z3VypG/pfEBlVNfl6Z0XRThI4L2+C1CNLFxMSBWCCCsAhI+M5dKuO99g9fRHc+tE0HA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793302769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HfPa3lsbkghVmoZUTijyhY+Es1RjaR781MCPO0me/mY=;
	b=Yj1daKY/VpEdbz6uaguMKl754yR8RhLynFv0oi/cVGbwQ173/myYpiOiiDm/ZF3Ftm35
	 seY4EFLdBRziiC9TtbYNLHMLoICGJ3TxT0qKjBmb26HtEhpbU72hJppDuR4/UMm1Z/VgT
	 1rmbvutvD7+aM+ln0lIkCV1uRRmhWplVb3uli1VoGFE+KigwyF0f5x9gnyz4QD7prgB4J
	 IsmswcZTaLuiswj4cgRqrpSuyGfnD3BUZ9vkA9LH+3/+2a7ZCyzTIOtg1r9R47T6iIFN6
	 ybdvCE4Cw6rL+gBXK12ldRoCcx3smjc1tS1nqO+fb4Z4k78BL1i3akdUzIMXvhI7nwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793302769;
	bh=HfPa3lsbkghVmoZUTijyhY+Es1RjaR781MCPO0me/mY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zywhMbnwwScGZa2V0vGDF3zQXz1wg8gG4lfXUygsOuoJge882F/mAuvUj6sAxI4iw
	 UKAgTPrd5kyeAvVjRSu3iY4W19177bBL/fw8x4X1/CTsWqCKngDeaCODU3IzJf+Udp
	 cRedZ/jEU3ym7u8WzEkQHMWTCBM9x48NJ2/TY1crmGeSbljZi10cvxEOakEm2cub23
	 nT2Xy8Qghfp16vHUv7iZGgD3mTzlW0ZQ3bS8gAJBB1e/E+FWcjns5qliqRp3G764BK
	 EuPNhO9LNfDtmhmlbTc8WNMPgbuAOpBkCDD1pMndYqAkZEN4IcRCtXoA2Q+zlz2ANF
	 aNgb95UcaZxPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 049AF60A79;
	Thu, 29 Oct 2026 19:39:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 546142FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E80140048
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0S3BXD-1nUn for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 19:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 597584007B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793302760;
 b=ol3RBPc09Aj01c5hIfWN8WPe0BOHmLtt5qOmKd4Lqwg5fzxdwaOkCX0wttPn7tg+5bd7
 LpGjPbI8FLXT9vTNV0njMuePmWfc1kuHJFq8tKL0zBVJ/c7+0Zw/5wdPJDvSNKzbSJ7PK
 GGtWCez3vS1PDKjOEn/aAwFKUTNDGu8fZ5OQShSB8GvG6PxkH+HFPECC9Gkk8eWFz/O0Z
 gOwecullQN7NZ1kS0mI1cMjKLrwO1R615XootMs06um5brvVjbzCagNCGX1haJ+b5016j
 rxJz6L7HMpZiVX2YzebMKWUxm26hLMqagEFFymIzKbdFclu0yaGRPJPMrxSahh2Rl7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793302760;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=HfPa3lsbkghVmoZUTijyhY+Es1RjaR781MCPO0me/mY=;
 b=SjhsIp7lgV1MiUN4pebh1/kZv68VFqs7EEdPR4Sxs9ovztFTi5ZsytuQ8O3ZmBgPQIS/
 pF58GOyAfgddmQVaL3btrMwpHlxLQXgu+YdlQ0Ex193NySpiyy9pYM1AGI0ZfvwinvfgB
 Mv9aU30LbO8QoM3I9hNoF6C9PW1Ir/wgVYO90o5sdCarT9ItpnFvOXLpJY9Jc5kLH0vEv
 V+MvvtpeWubP32yeVZUGwCcfdbqF3zEYLKbkG6dA/9k5xGEG1kvBc6EluCPHXHeiSEwv6
 /zA22dDGBPWfmZN8ul7JP6sHN1AJCrn/ch/XOVm6zNl+KwetgJkxcdSecg7J0OXwyiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Msq5czBD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Msq5czBD
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 597584007B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:19 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso28465545e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793302758; x=1793907558;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HfPa3lsbkghVmoZUTijyhY+Es1RjaR781MCPO0me/mY=;
 b=Msq5czBDe6dk3WubfW/N5sGOJN4d2pkRXwEHRrI71vX/+JXqWUkNfJvHGQi6E2hpEY
 jrlvhEszr70oBQJEBT/WvuZgvvR3M51MDQEMK7V9UYsjWrOLNZZM0mftXRG2i1e9sjxL
 stIKirQl3XbrZlq9XNaGrickty8cuirUBkGQ4r7Uu7wQhsHIYOT0kk7Yja4v6XbQHEaq
 weZ9WMs3uo4PC11r2nQ42agW2wt5idp/abCQNiNvi+xSZX89VdZn7PeLsJJPdlC9lpe4
 Y8UwGTCNFULTaylYsNLOxJteFmy2SqsyYKxq9vIMz1tH4aLUFG+S61NnNYuvZh32PSlT
 91qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302758; x=1793907558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HfPa3lsbkghVmoZUTijyhY+Es1RjaR781MCPO0me/mY=;
 b=ncFx2PAgPMwBTI/HTDriZ6x/0jj72sAbqXheMsvMPVsO2sY8JRiP/ltPWK+UznU3w8
 ViK6GiQBjbdZ/1XVWn3fgwoiDqydSmKugdcsKFH54SP5Tly6kZ9uGGQVl0qmPzZ6B/J8
 ZbVRurv72xQwEzxKTjhGvszyDhcTAxZmDZPEfaAFsqkDUIfspx4PEuwCWN3Ux4LHL3OR
 UHd2VlM/Amw6NpVRkDMeM8zfKoPoM0RHF+NWakWtQAdwPDSLcOHLSGx/u7IAjLmcMlw5
 OUnC8GsLhmi/mgNYSBhXrCK0Bm7wNEM1+YbnvVdXgdNCfobhOL0XWmvlCu9UwXlt5ZR6
 DKmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5dZtzAG39AVZRP5dgZNchfx/gLDgBj2QcOX9pIlUraql4UmBc5CDp+7afOr1mJfGuArzlnXE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIkGJyjkZZt1VBVeDmXPbvSeKgBny6PJDpNOWg0HTGs95sYMp/r
 wY7SuHOocJnVPOPRu4ptHiI1pGWWKpedKdj85EdWAo5zRhWFxGirEE19z55I91ZV1o0OFDDEpBb
 GCKEY
X-Gm-Gg: AYBFou2IWebgZ0HipoRjbsJ/7n6O1m8riO6KMykw8/+yvR4PUmv3vb5hkTYzHPkXJHv
 DS8u877EZNAIiwj7bNBjgP/W449fNmEAHYvRGx5OHPpdD3KljGXtz6C6uDuXQAVKdDA6nyS3t7I
 hVSfudmoXIKCCSbivJoc0oJqNRomxgX5MyzPqgkmdvhttpUcXkaruxjRY7IHxwnIiyn79LlD8j7
 PBEkspvjzJdvQhyA2Xc12EibpF0rTclO+gKIK8nlEFD3LlZ0jn44yQ+mSaR3U+/3Zcc1oI++uMX
 00QYAkXvPOBU98QAoOBMirT2xkuslmiEe7YEBiNnnNeRH8mMNDz62z079vWWdD0zOXPWmCJ4PP/
 mBj5txvJF2C3b2Ylf6dpX7wuF6A2vAWAaz1vdOLpmUY+s05hkfYPPjf0wxi97Ihj4u3NtAu6OJB
 iEqpM0Zp69PtezkI7rBS3sBh1mptVVPtFiaUfXoMY4FEAdOvNUGhA2cwtIIwfXL810bqBAcn3Tj
 pZB4lbe3MCdhABUQfbZb6laGVYCT/Ow83tRHN9cxPAwXFyULDyIk3c+cgQLfrqE6NDVXK8SJy8l
 d35v1mWQyjOOoCu9Ix+wdjS7xyaA9stsCBprudByJ/IbXWJD0Uv+XjPZ/T6b2NBdtPr0/wKpMcz
 cFkV3ym5cyPc2qDtUXv0=
X-Received: by 2002:a05:600c:3b2a:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4ac14fbdd04mr92105e9.4.1793302757884; 
 Thu, 29 Oct 2026 12:39:17 -0700 (PDT)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm1987645e9.3.2026.10.29.12.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:39:17 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 29 Oct 2026 20:39:02 +0100
Subject: [PATCH 4/4] configs: mt8188: enable USB host support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ccaione-upstream-mtk-g700-usb-v1-4-6b0dda25be38@baylibre.com>
References: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
In-Reply-To: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs use the same USB host controller, PHY, PMIC
and onboard hub. Enable the required drivers in their shared MT8188
configuration fragment so both boards can use the USB-C PD host port.

Enable the MediaTek xHCI/MTU3 host and T-PHY drivers together with the
PMIC, regulator and onboard-hub support. Enable the USB command and
mass-storage driver to discover and read removable media using the
existing USB stack.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index cd5e68dbca3..26c1a972d27 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -13,16 +13,31 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
 CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6359=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_MTU3_HOST=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set

-- 
2.56.0

