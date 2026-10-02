Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45A1CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 754F08138C;
	Fri,  2 Oct 2026 14:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nuLle6AlXT2s; Fri,  2 Oct 2026 14:01:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B269581376
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949705;
	b=jEOCdQwgZCWozE0TvD5uUc8q840prqLAsFTRIIyMyOSvQiBDZJQVhwzlmtQOaKqFZnJp
	 tBw+kxrODAZwFfWnGnkGSVvpOfwHGhL6Hue7CGLwp74r5tzC8o8MiNxfZtvKQqDigBcRh
	 HwCtLv93K+p0atnKIJM0SQ0+RV2nyx13NYjfhqq7UJ7p3M4OW6PkWqoNsmhwrMKNDQEpG
	 y9iXnt3+Nsv9/sVSbykPEvc3XK4a9E1NlsGx2+A7FzPT5pQcfGkpfDbTE9+ttva770wFU
	 YWln07M/DU5dqVMrwGSWGTwrt7wGcnv8gJ7+gdl3NI130zZX+asMZYJtSFLkrpQwsYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
	b=fjZn+WtzLyi54ejQLcUGKyaM8h03OzxnzgB4MwEtWslImAk87/eK8Ntdc/CtZZt4mrBJ
	 2vXphBlE3duigbiAlG0/QsjoAyvr1LsycfaTKknJ3u+9nRrM7u3P57r8ocPZEg4UpyQtD
	 /UiyEFqQOVf9pONC/O30BTFt8L5FJoCvQndvjuJxMYCXKaj1wHKjHXp5Pom/wkfcNECNa
	 m6caqX7s64YclXJNYmjmR57jsJrfhoKHeDKGFL5YA4Sv2JRRtggkTxx7sWu2W9rpBdtpS
	 tvO3iGn1x0pwBs03p3uPCecZyCfhmKiG/Dk9rnHrsOCA8RxdATxbFPFMfej3DYY5BoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949705;
	bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hwHa0CY0C8yw7QZi4GuAEhvEoUihBbpoIxN7yZRww2Seb+5dHh6uJnsLEdPPEI+Ub
	 D+5U577E27qaai2YHrYYhPA+QZ6O6s7wuY63P2tZxqGz95NP5gPrLSNNVF4otw3uF9
	 n7hv3pWmpOG7cOVOOr6C6+Buk3HMOxla1Tohkzr6u/mOseUuDOaVk3FIIz2TuqlUBQ
	 Luku3T4ty8O7G+Egx21K5PXh8MD9CqvzpuQiUbYQcLy70pvoCOj4KS1++i1etFThgq
	 wjn8QBnDUZBvNFJoZ2P4/SpBS+OBZwWi6DECNVzA0Z0/H8XN0ui+Bccfr5MbuESVY4
	 1HflanODDAwnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B269581376;
	Fri,  2 Oct 2026 14:01:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C0EF435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EC3C40D87
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYBDVOWAbmiV for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5B07140D94
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949699;
 b=aic5KYnxAENqNCyFQYvqf9GxxqMTi0PZA5Y9q5UEmA5C14sbHGYOJomFEKhD/d79q0GC
 wuTYaK5DnUoGfQuK/PlQnPEu1wKuR2ZwaLFVc4+kCAMqv9t2HeV0Thssl77qONE7dxdmr
 UDzM3rSpfWm9g4ucgL7QmFKeUoljZ1ZbUmJxoXRdorxWr+e+DfEBVw1IOBhP+6uLXQnBQ
 DWGnrMhokZ2Qr6T6fMwll/9nBxEV8H25fJL6+J1xrZrF2D9DWaWEaod4hzgdhMhkuQPP4
 2y87Sr6IzYqGADKYi0yveQkuUP6vIH1F7uip9wdK+VU7MQHRI+rc+r1by/Zph2MlGpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949699;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
 b=MzOC1l+ClHFtPeGMi83QRI1vNlQpZUaIJN+JgiqzGGun0qE0iwzUS6aO6preHeJk/zuh
 EAKBl0kNgti53P7fIpoIGyPIvlvgyekSI8wocu6cnOVCc8QSapo2sp6H5kAvsR/CKJnnX
 vIpaLISpD8POyVdmEf3q1v9hpEOucjKB8MgsR0xoIhR2Nb6ZMXAyIjysEx/UewrcaGSAF
 4+Zm7HLcWUhafNKGL6LPxlSBYritzsYgNVR4aqoWhpWKv3UTXqvOuc6chd441VTdbHfLF
 T22O8/ZRYNqj/qNK7edbkNlqmqXBBbnUcAZmuwLgcg/MMqdRE1lLhq7vj+0ghl8gDgQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="A6/pMjn/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::d;
 helo=mail-wr2-x0d.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=A6/pMjn/
Received: from mail-wr2-x0d.google.com (mail-wr2-x0d.google.com
 [IPv6:2a00:1450:4864:30::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B07140D94
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-482f6351831so4522141f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949697; x=1791554497;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
 b=A6/pMjn/l3W+iZSEAugsbyneEsqD2NbqxTN4NMBQW/2Pn5CJSVDJIcXtztYBeEzfK5
 YsY3l6zSanExzzE6SXFr9UFXNvHxTUveu0YTn7MD20+l5MOpHgD+SAa81niQLVNozQoz
 CO/WjtGpOS8ZOFf+SMjHXTlceNgyBf3x0Gb1K/n59iJGgjTisdt+1UBduh7mJJVpZh4s
 s1zNx3IK7LsMcY/9H1ex+s/KwDMLxdLMg/ha3eU9UH5PW6Pyg8flYu8fNCw/t52hoKhO
 uGBcVUBL4jQiTFSQTBNLHPMy9DagQmZuxYGGibrH4dryzAKjdcb32NeCnBATd+05KqFT
 h7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949697; x=1791554497;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
 b=MfAyfiSRq11HSjA9lpHxRW3ZiYmMcA75dCaqLRiY7Vh4zvwUAzk20BdK8rjTIOLoD6
 ejzv5b3uNTFNzI5PTa2HJYnNN9ElbGRdQ7mkxL+fdcQ1O7LJe1a8g/hro8OLGegL7Y/Z
 Y5qj344xTDpxuowd1TLLdHxfdL1BZtjOHXYFZ04eIZnVvtRymwz7uweK7AIGNtFB7B0C
 vTE55i10cDtbFqm9WMeKMVQWLf+ImfqerQ8KEgZD1EygRFlX+028vhzCfdNn2XgJFwd6
 R3M7Q92/wrrTJVH/Zz566y/1aozF6HO9zV2PkQBPDBBuY1H7xKKLvvKCdr3eit4sjk/G
 zQJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy68fL16LRDVeK1Reedi5UCMj9tHQLz8XKUQIW9wf64tolnFneg4u7Tm/R1hoWoif0spku+K/E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL4pee4OKTl+bGFj26Qdp9XlNwAksUlkoerVwcM/wdcHt4xehb4
 1i5ib/x7IhoxkTrOKszLK4oXbs+jM+R5GubDKslMADrZv7KlTtAxjcqmoFyBUTcf53g=
X-Gm-Gg: AYBFou2ZAfvI30sEwR814l69kvFtAb+PMexSFDOMQHp5X7rSxYcDgzUqGqziSz55f0i
 Jk4pAhIR1rraRS+7qWb4NjVZOlvY3XDU1K8ggluFsZsqYAfrYAwbULaz6UlKkzn7lypjIg5wWxo
 wtEkQnSzNbVbPb0DxG60O8yjtjTJnUebxfDR4q+yQFAtzFaaw0255zaOdwiwuqz12SQf4JhyhrJ
 mFLh52K9ZPNNQVoJxo87ib8No7+OxnK9Ef5ms9B+oWslVKPj2skUQoUQANqhg9ApKSkoS3njDhR
 uZMLPb1tZ6n9kn3p3Gr5DpXmC4TXzZu1coT34QuOwlJrAlUVJaBCtEIH6WsqRF7b0SUDWDiQUgh
 u8QZL66Ucpev/E2YyLMqXCHZ5KESYID2enhaFmWzqs/DGw5CkUjVApF+Fero2l9lHwufDt6eTcw
 ZE2fNLwag7bzGOP6w+OPRBGnsHalr2VZasyV+75GiyDxU7XO0j6va5ZdLdaA4Uvt96ZnA3F3nil
 QvXVweal5wHI4kH0EOHv4Y5dLAd/IUouAsgOmQ9u3hlVUdMhYqrHRgT7uZ9FYuNvQ2Y2enffwZI
 bXpWdUneiwTyEkwBgVRRmvBfHZEhU9qfokD35M7WgMYB9C1cBex2ZIJwByxLPOYgIg==
X-Received: by 2002:a05:6000:240d:b0:48b:451:4f19 with SMTP id
 ffacd0b85a97d-48b1272dbafmr5358881f8f.51.1790949697288; 
 Fri, 02 Oct 2026 07:01:37 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:04:04 +0200
Subject: [PATCH v2 13/13] configs: mediatek: mt8366_genio_360_evk: enable
 dsi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-13-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the configuration required for the DSI pipeline on Genio 360 EVK:
video, the MediaTek DSI driver and the startek kd070fhfid078 panel which
is the default display for the Genio 360 EVK. The PHY uclass, DM_GPIO
and the fixed regulator are already enabled for the other peripherals of
the board.

Unlike the Genio 350 panel, the kd070fhfid078 drives its backlight
through the display PWM, so the PWM uclass and the MediaTek display
PWM driver are enabled as well. The backlight uclass and the generic PWM
backlight driver are "default y", so CONFIG_DM_PWM=y is enough to bring
them in.

Everything else the driver needs, the MIPI DSI PHY included, is selected
by CONFIG_VIDEO_MEDIATEK_DSI. The U-Boot logo is not enabled by a symbol
of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
CONFIG_VIDEO=y already brings it in.

CONFIG_VIDEO also turns CONFIG_CONSOLE_MUX and CONFIG_CMD_CLS on by
default. Both are turned back off: the display is only there for the
boot logo, the console stays on the serial port.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8366_genio_360_evk_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
index abc3667d566..18e67f09816 100644
--- a/configs/mt8366_genio_360_evk_defconfig
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_CONSOLE_MUX is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DM=y
@@ -20,6 +21,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+# CONFIG_CMD_CLS is not set
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_NET_LWIP=y
@@ -49,6 +51,8 @@ CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_MT6358=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MTK_DISP=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
@@ -59,5 +63,8 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MTK=y
 CONFIG_USB_MTU3=y
+CONFIG_VIDEO=y
+CONFIG_PANEL_STARTEK_KD070FHFID078=y
+CONFIG_VIDEO_MEDIATEK_DSI=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

