Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC07606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YnA36a3B;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZFJ12+D5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 730FC60B0C;
	Fri, 13 Nov 2026 15:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lyv9KP7QZ_Mo; Fri, 13 Nov 2026 15:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4DE76063F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794583573;
	b=h4OTkneI2mogGiZ6Eq0oaeDvcuCrQVqb42rGjLfB5bAQr2L9daLmAsm4U7NkPPpoRnZT
	 7ViZqMOIw6h/eZfRXofMeQFaN7SFvF0WjU/zo7Da+7ygoI/3Kq/AObLbiZexjWC2sOX3y
	 kaUQLFuRljN6/JBwa9HAH+TF+RJuZnI7MKTaj73fE2obGi53d1frB+nh8uxgra4T6Imst
	 jRlGQmjn+vxWvHmHAKh4iSF5NB1WluY43sX5H6GUrTS6S16NwaQBSHZwMEtJ+lLuAb2l5
	 t9ob+PLTdCuY0zGzog51hRxTHmr/6Vo46RdMd2Fy5SIlbDmFRqTaBT08YkEZqBK9w6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
	b=SvW2Ac/CIej/ydej5GBqI3R0F+f4bozpOWq42HMgSgdgldbn5kC5NceakfpU7bMfRG77
	 HEM8yAjCGD2+bdM2Kyv1a51itWD0drJMRnxZF7oQTQ/WmoXgx1JC8dsSO6EDvkGFHqMed
	 KZ2bTWngmdT8VuIW0yocoQo50H9Op+65mLovi4z3PhuoUgzZZcqVLSGcalIHUzJWPuKo4
	 OY3Pw2TS2LhMlScxSVRsCnv6mTbLttr2IflDS/RfLEXHZlr+5sO18I4oT2RhSUI7kSYGF
	 DW1Z5s/ewH9HdvcNyIFBrQQAC2i7G8aLbKBZLQDYpMEnIrGUB9vaPzqtufuPd93L3uA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794583573;
	bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YnA36a3BuuwT5a/emEOwEhAHbP2Scrf2GZSEa/nyh7/wfZC9jaOgPrYvY1T6whpFq
	 mRK5Tupj14iULI2SgOkJsrMuP+MY5VANcI1QmLY1zTIjPRBXTyqwlKCVxzgsikv0Ng
	 1GXZJxAxFTv0dDUm7ux/rAcS385nsi1XcvT4L/sGC21Sq0Y36TyX4CwJ+EWrlGpG91
	 erRCdyvlRUsgT9pIxgpWixuPQ3KymEQZMVgp/nDquxsIA6gzMaRi06e0s8ntH7jG9C
	 5gjARe0hzrPzL8WpmGoOIrYkkk2V0ncUBwOy8eQ5TmThZK1wG1lZGgqBz9UJRzzxGo
	 Q8phTgK4HX5Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4DE76063F;
	Fri, 13 Nov 2026 15:26:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8A762FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AD99409D3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mqyc_huMbdAv for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A99DE4095B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZFJ12+D5
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A99DE4095B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:09 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so9087015e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794583568; x=1795188368;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
 b=ZFJ12+D5o/S1I+E6S55W54RER7iPHLeX2PZJWifOj96YM1QT9NPT0YoSp/vEdM6OlD
 3xaKytf/isn6tASwzOSDiuuU8qkBBEW/J4QMr/pIbDqJ4l0ereAoXW8tro8E50YdPjy0
 gNlCy9mkDOidlZqA3uQKkBjsOl6Xu9T3xIb8ChaNQcXg73LydIa75ttwHdA2pYcSkDOp
 EG6Y7fHGbgojvJ7cF9Z5/tfnfyx62hu+X9UYNlRRmRqkpuvtujJCMOVZnNrk6887vyGT
 wN82zvtfHBYq/QBjLL+6qxzbfE3AK+J7et15TaXPGEsmhm11TLF8vWobhdlxp3lPN3jy
 cT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794583568; x=1795188368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
 b=PmJrwWa9Q1fSaJC6Z6xM4ECptbNV4Vyy0dwS0HIbgEl+SLjrbppSbpxQ7bDFXFjRz5
 PWlOYaVyJbcU+lU9UyGfaF/tbLTzh6yBmkePdu1PuDMhGhwhCuynrBnXMCbEvOhy5lJ8
 z7Q8CFV1zfLlnRqD8Rv3bAj0CgSze/yPrYChB3tIgMmVDeJZIm4/F4mY0T43rSf+2heN
 zbC0rfWHjWsrLZvzUt3ubfwtlp3ELK43PfBuRgCXvWODO51na0IklPGhpSauM3iU93Ne
 Jh+ukYjMI8DKchQ/uY6C182/Zrmk5XUNvtE8eVnfJ3Fc2CdnbB6I5A042Cvnn3JgQsgw
 bxpg==
X-Forwarded-Encrypted: i=1;
 AL+hErELdCqmS7KTskhkGvDm0iQE9OWuUoYTQxk3LjxLa06RgOF3m96XwF6kBSRPHKoDaXm2fz8BW/o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+lhfVCYX6o1q2j0YZ7/c4gUZc7e/rWYaufop0ZRoGidO3/SBFs
 yAuZiym2FrmAni0pYBkxL0jBeHrpBo5FXqQp046sgiu5AJX3mWUsx3CKfSrx0664nnc=
X-Gm-Gg: AYBFou0WSbFcXR27GuXaM7tuNiQL6V4sT+QZCOuVDJo84SdPC/Tg8xZYyPFi5gvTfnl
 hD8e5GEcPZ4247wMl8Uxd2K2PL7oBJJHDVJHwuDAuKaevSaQ/okr21xIgIUs5lJ4SoL9IwuxaFy
 TjBHiigZF61jkNaGaIpoRLCsGrDnI+VoxP69thsh/0tMJe9/w3eK8D4WRRSGtczqaWEIoVnbbFo
 DSwRnMzfuYEYHs5UMdvagjc0LarV7bNOrmTQZz7coP8xQFE70EPUr8W3KFlN6JzBtRdSZzCQ6NX
 IQdycP/a4ZKygDzg05UQ8mlsBkeqeNKGX60uD84LnZJUvLmb5Oz00saPTUtLAopS5VAOQEy5snC
 CcfWgaAmOs0hKmswpcWggHsU3pJeIWw/+PtTSOg74EQMAovbaKb8729JHOpwOVCDWrL9z4Lwk6X
 KnPtLbdSo2tgcOvdDibB91xhahwiHgQov+Nv1D6/XZEBjPG/AM30XbcUfPIthdC8Dt1IOPcHS9j
 dGHXnGyQc/v8EqPsDB60y4kC0JnoGNQKth01kcxvthXan6ShzbrT9T+L7XXaZ0SxnFNU4SXfc00
 A72U5HZvu3XBw6sUlwjRSlvCN1h1rkG9tSoMrJQtFTwxANM5c6SDnyQY8Ct0IGKBHHLmqEW4oSo
 1BOPb/o75kT3yojfowbDkLdJ7qswopWOF4rVX1v7gywPUPA==
X-Received: by 2002:a05:600c:3b93:b0:4b0:a7aa:843 with SMTP id
 5b1f17b1804b1-4bb55a683a1mr59532305e9.25.1794583567824; 
 Fri, 13 Nov 2026 07:26:07 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ace535sm70042255e9.6.2026.11.13.07.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:26:07 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 13 Nov 2026 16:25:41 +0100
Subject: [PATCH v3 5/5] configs: mt8188: enable USB host support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ccaione-upstream-mtk-g700-usb-v3-5-78b554604bbb@baylibre.com>
References: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
In-Reply-To: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs use the same USB host controller, PHY, PMIC
and onboard hub. Enable the required drivers in their shared MT8188
configuration fragment so both boards can use the USB-C PD host port.

Enable the MediaTek xHCI/MTU3 host and T-PHY drivers together with the
PMIC, regulator and onboard-hub support. Enable the USB command and
mass-storage driver to discover and read removable media using the
existing USB stack.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index cd5e68dbca3..f59bd86cb8a 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -13,16 +13,29 @@ CONFIG_BOOTSTD_FULL=y
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
+CONFIG_USB_MTU3=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set

-- 
2.56.0

