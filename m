Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCA606A33E
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OOXFKf+U;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ih2GGxPf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C4F08174A;
	Fri, 20 Nov 2026 13:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w48GD0O0U9JI; Fri, 20 Nov 2026 13:21:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 632CC81746
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180896;
	b=eqzjPGlPkguBukTdAhluFoZBWKY9OETZxl54GNCq2d32IJkvoWtyEoWLoZgzuSsmONkn
	 o9ga3dHm/VD3rylm/ypauLrHSpxZYOShZhVOgElb1f+tMPj/CZT2O2kdeaX9pNCQ2vLIK
	 p6CzSfGOsl3aAWKYt7IlmjtKUD/NIaO2lVZLK5RzmDYHJ+eYXFOURmFv/YQLLnqxExtkK
	 oyhL94Ew+bTnEzqjy6YHccieV6VonR6WgfbR8/ES9QuTM3d368DIqJNUM5g8CF6XQQs59
	 AyerTmdnYQ4IwClPyvf0lLb/Sa9ztE0EvKJS+YvNQNFPGaSN3797hcxNS4Z4yPTQ2HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z5bOjq7MVDwyFPnKh+kSz0Zy55t/xyJ+mjUAHns5epc=;
	b=KyxHbhhY90lJ4cwHeTqsIEn3seWt7p8Iaf2W1XooZmP6Wkf+WU/oVRo1Q2sJ7SACKZ9I
	 aEfLDEPlQMchniHaTmOJaMa+qOJ/uOPkTR6cPbMOmras0txWWHDqDjReW2bDsMfMW1c1P
	 +RDfq7mETAl6cxm2kgTQjTxM+quo4MsKEcxw+Cuu5UxZMnQ+B5aWRffrVWcR9V89Ac2U7
	 6ZK8ByC21rB2EAxFxPFkWDndYY6o9kOaLEUTa4KmN38Z24eeIy2TkVM5VUMpZKWa/Uf0w
	 evwsFvm8g4DccM0xfAbTSPnvDdLqkW++RXyUr4zgMubh6iMz1JQyAAmRzsj21xPXzrw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ih2GGxPf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180896;
	bh=Z5bOjq7MVDwyFPnKh+kSz0Zy55t/xyJ+mjUAHns5epc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OOXFKf+UQP0gsqN9OpHxJKt0w1EUTEu5KTHSsWT/2S2enQoO2aQ5HWUhXnT6leJnr
	 cRYF4aYCGle8Xx5soqcFNuFO0HXcz2uMVL/sOEDQ4mV+oDcwS5VEZdWqyoTUChY+3h
	 5tpViP6u1eCp4Q9aHOUsEwEod4E0P9knwNRSWrzMgNt4Cj6sXPchIcH19dODsMlo5G
	 l0bLR5yqC+Sos4JUskB/2zvc+qDrqL4/M4DadrpxQPbPKYFBRTMkR1zVL6BAfVNtA4
	 jnxQ3dK9B/KnPqwWep3Ytxh+Chz3uCY+Yn91S0U0pO/CMB/tEIysQvhUIxpXRRUeDN
	 p4tRSsvIiU27Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 632CC81746;
	Fri, 20 Nov 2026 13:21:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91A681C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F4AD814A0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijrd42x7odLG for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B78598167A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ih2GGxPf
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B78598167A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:49 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so8573595e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173048; x=1795777848;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5bOjq7MVDwyFPnKh+kSz0Zy55t/xyJ+mjUAHns5epc=;
 b=ih2GGxPfo7phke6JlnqtH4l5/qb12GSo8FvGa9YSojprSLwcuRCLjcG6vLhJmSMwhW
 vKfdmhTXYzeAftjGLxPLl92KP9u158FV3Kq8PYjbgMsnm++BGdqOf85+Ls2gNhp0+/Uc
 Mwi/xf/770itB5qUwUEuo1ULhty8WYz/ZlRzBm8FbhMMNxzpHvSQHGJpK2ls0bQkni+W
 sbvULxYsd7z4G7qonMl79um/fIYWvjlLUwT1HJIkX/oUHr01ZMqa7jivNSP3EdpEMGjw
 E20CJy7ljHspC8Mw4q7HGaE7xHUz7xu/hN20AsVpdn1L4HEG5gdue3GGiEIqIFoX0XTC
 4Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173048; x=1795777848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5bOjq7MVDwyFPnKh+kSz0Zy55t/xyJ+mjUAHns5epc=;
 b=yoVwMV9nFumsw2hSh7/uPvxh3Wc6PIZjwK2X6wzL5DnJ+HeSTqDkPMtkCjeMVCOumf
 jTDtsU3fepOYPqieDHfpy32tnnfeQrXRY0wx03kk4VVQ37nHrOdbLg/Z1s4pnHwTYCdp
 5wKpqT4kcnMxvf1pMFZULedbyD2wIPM798z54kbCuT2V77rqlNtHA0kRf4Qab6JEG8+2
 r4iLor+PfWQfMLvNGAaMsdG5kTNvZqwtA1tJi053I3cMvgyvp5zyQVRa4Zki+bbkLLPj
 NXnIQRLYCOMEp20YOrbY2PLB7v/wUSv8emJSpPwK8IipN0LAlUqHxkcTx7xHkxXF58FY
 VrTQ==
X-Gm-Message-State: APuU4Z/9vDKFUu3W0po4YICglEgzWSfNQYUiZwilyH6sotrWedbiFu9Y
 IBfgbh+yoYYBG7GnhKptE+0NNC/JeZ8XUx/qvEyPdD9U3GO2VChzchE2
X-Gm-Gg: AYBFou1cFgnL+PwP6W5BxuZlFh3zKk5ff2DxA4LOPtYYIfPzrBEP228gYIb6kXGwV9V
 UIrxculMqBvza6dezRXXnQ2odT171iNURw6b2iyZPxMXIuhWEZ4rsXRGsaI/IHKTZvz8FHKd+kB
 qanDkWtBykfg+FHuXR7kS07VCMl7EFIFw+1+RQXIlXCMx/MltJVtwoAru2CXfr7bRCXvUS34Cl8
 pCSbRV7HWfkrCQK+p0pxix21jTm5LzX+h/+VBAiqmOp9EmaTGgl/1rln4AqSjWx71UNL5lPHU0J
 0oetuf5lu3SOMMEe4AfYNxMhHe8QOHLh0JsKZXdaDCBvKaA0RZ4P+QsSnNZ16K/B33HSc3QJSDl
 wDk+bhjQdIlQJ59yYurata81x5+DISeSzqP2L6jXWq3EUEkhN2cwcW8gefsNd7XGyfEyQ8nMb7r
 qeztXqrCQiCItx2aD9qH4UB8Wl2ehIiUoh2x7PHEj1T+62C5bswOu1w0uTrIDDJP4MzyYiGtBoH
 vYbOgoG8r93hJnrT2mgQZF8ldmQ3yx3Dp2tT9zJAjcIpDM3pMt/HN5T/eDmsrR4rmi4PWjmPGZZ
 Q93voecjRqyTJYbbUZpXPXM=
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id
 5b1f17b1804b1-4bb88805902mr58693045e9.7.1795173047533; 
 Fri, 20 Nov 2026 03:10:47 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:47 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 3/7] clk: imx: pllv3: do not touch the ENET output gate
Date: Fri, 20 Nov 2026 12:10:09 +0100
Message-ID: <20261120111037.110741-4-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120111037.110741-1-eichest@gmail.com>
References: <20261120111037.110741-1-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The PLLv3 enable and disable set and clear BM_PLL_ENABLE (bit 13) for
every PLL type. On PLL_ENET that bit is not a PLL enable but an output
gate: ENET1_125M_EN on i.MX6UL/ULL and the ENET clock output enable on
i.MX6Q/DL. Both SoC drivers already model it as their own gate clock
(enet1_ref_125m and pll6_enet, respectively), so the bit has two owners.
Enabling PLL6 for any of its other outputs turns that output on as well,
and disabling PLL6 clears it behind the gate's back.

Linux only handles the power bit for the ENET PLL. Do the same and leave
bit 13 to the SoC drivers. The PLL is still powered up and down through
BM_PLL_POWER.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/clk/imx/clk-pllv3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 8e67442844f..4a3f1d088dd 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -346,6 +346,8 @@ struct clk *imx_clk_pllv3(struct udevice *dev, enum imx_pllv3_type type,
 	case IMX_PLLV3_ENET:
 		drv_name = UBOOT_DM_CLK_IMX_PLLV3_ENET;
 		pll->ref_clock = 500000000;
+		/* Bit 13 is an output gate, modelled by the SoC driver */
+		pll->enable_bit = 0;
 		break;
 	default:
 		kfree(pll);
-- 
2.56.1

