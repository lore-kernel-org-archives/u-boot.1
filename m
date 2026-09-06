Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E2AC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2765540652;
	Sun,  6 Sep 2026 09:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LVdoq71qq1oc; Sun,  6 Sep 2026 09:32:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 29F874062E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788687136;
	b=PLdZWy7wgBiMXgF1hEWmRvngmtsuA4BJa+rfYbscwCkzyy940RntW0yX8B5aL14+THqQ
	 rDEKsvRq+LVPiXTyC1/dtMtK401jXTECg/zK4qdIkgoJG3LW4xysQ/5SK06erw5J2JSAB
	 bX3iIBBeTUijfxD+ImATf1mlVCvWPrNmb/AzbKwHWPYTmb5iwy5Btzig6tGmrMYis0LKw
	 DeRbxdY24IckFXZ2DNQJveXabQhWPVqppQrOG8fq+i1CSdAp2kdorB8K2GzLtSy53XufI
	 d2Ix/Ev2qPltChds/igjr7a6yH59oukV02iDkkv+RxOwO3vVaPgxRzkW3K+0Qu6xqyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788687136;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=otIN/VDMY19gFBc0/9K6y5umfrAORJ1UCQWcHIHcQsY=;
	b=RF3xLykJjwGMynyWOpo4TUJHq0yd9qK505mY66Mc2sKmYI2WJ3tdjh6IBOhIIvPvDXmc
	 h2itakqCC9Rt74pnbn1bP5UScFK1AZJY0uIIDG3lKbHVALVBkTbFb/IFq1+zJUK0sOjBA
	 7iK+VEh3y2gz2w+gfMhu9HExXXhvetTwSd2HvBTQOZv8Va51kLJfE3zKwCL/Yjn1Wx8d0
	 eKpp/ozuGY8GOH77QDerKSpW5mUOxFuMCPbTg77IBcyVra/mIplA0FgcLRvHixCtFedv2
	 AryyIvhRYepmuf8SXBBjb9E8EqHWWPF9RlEpCuo86MkbGkzRYR4YCFmFzSOSd9FEDqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788687136;
	bh=otIN/VDMY19gFBc0/9K6y5umfrAORJ1UCQWcHIHcQsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fklKIWl0C4bVdkPkW0F5DV2vfCrginqvD78et6G4KgHwp7iJDSfteBFjPD2mA0Anj
	 TsfEKBZKBjCE6nWQ2VAPtEiVA2OjMF0E0oo658t3PClpM9PUVpihdLA9hIL8/Lf5UA
	 +u9siP6bLQ1GHh5nIyzIjt8wrlPZtr3dKbQSKcThJmDDJYjkYMeTcVZpYucNeQqpNw
	 kBN0DJU4/bm8x2CO8xHZxY8LpHIKQNSuT22TYHKK74w+XddYnWhxF0dIc7RsK2hczZ
	 u0ItMviM6FiJmMCtR3ZhJKMcYvyZX5IuVkhKdJIqBLjE3mWaACzykoAcUrSE+CK/ln
	 w9Omzbs0mokSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29F874062E;
	Sun,  6 Sep 2026 09:32:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB98118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20B934008D
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O1ezeSiUGwiz for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:32:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2D8284008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788687133;
 b=cSu9KXkNNluhfr7qZj+FnXhzrGp+KNWINkcKgNT6LthQbDI7xoXnQei3fB9sSO8hyVUM
 oGo57GrDMRuLbEmb/anG/zwodb4H5aaP81mUKyqajb9rD2KPN8pmQL0J2X9gEHzpbIN8c
 1eNRj2V+ZjHxJNNNBPDf8JsWACKaA3dnXqjB6lPqAXcR2+ZbKDVArMQbOVLfW05/Yp0yR
 Cs1saHq/RXaFCU7jw4/DCb1qkgsuXwJLq51kyimAsAlRULPRO7gdi5kJ5eUfks888VySZ
 iRwO4VaeMr4Qd87YXsZ/v635P4uqWmCWnks1uK0jge7Dq7U+KuvY81eN6afJ9sbkAqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788687133;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=otIN/VDMY19gFBc0/9K6y5umfrAORJ1UCQWcHIHcQsY=;
 b=N2fW0M1+VFpKfKkmhdtZ0YV0Q+h1vDoQxQ4WUTdujPnxHlyNvou/q2s4hzXYxaNEVoiF
 RRqLaHCfOOe7ydDvV45llIv12pSA6XErgWezELdUgRNOyLYVMb9Ik0PDV3x677FXJDJBK
 w2z7+KiTSklvpFiWFDp/jh0Qnvor13txXRKUwOepsZyoQyQfxs+LEHAgIIPw5Qh+VFVQ6
 XwJXAaf8mLpXXUljDZi5+Sqh6P8vGyJUJoPJzISjSSVCD/rn5YH6K/R0JeK7HW+MKRLI6
 Y3ijVnJkfcMlQ837eNAymJCdy1AFH3jbOtzGEISFDYOUanBDWH5KB8pz68twWxtAdvw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ZW9KLFVh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ZW9KLFVh
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D8284008B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:12 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2523000a91.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788687132; x=1789291932;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=otIN/VDMY19gFBc0/9K6y5umfrAORJ1UCQWcHIHcQsY=;
 b=ZW9KLFVhCRZB0j5p3JTNrjApwDJzvHlKkTbl3Ki2SgXm+YzkjvcXETUp1GTCk9WnE1
 xL5PL0b94Ni+oNDXLDkiIW/msCvkPrQjn6Sd9i3Zm/fTAnjzxTpD31pQd01HVd+3UH0a
 yBCrpd49wbuyqz0zisIql0owjMx2J06q5t2a0vjUoX5QctZkG65MOt+ahY4WsernTR3y
 +/PtjuXE2MF9Fl/Dg0r8oDOTtg2+9ba2R7S7luKamdKNr6TzA88Y+MbV1/YSa/tvdCiJ
 lYv/0Au40Wn63f7927mA3VGc0uHmcCiD27K8kAwDQPx5EaJv/dhtRSfhEDChrtK0q/tT
 3a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788687132; x=1789291932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=otIN/VDMY19gFBc0/9K6y5umfrAORJ1UCQWcHIHcQsY=;
 b=n+HFKR7vsuZYbcC61hCBRtUcxV9Bqqui1W39R8iR8S2IGwJSMXzrJTvemh+aeufnlq
 3yM4uB8EeNz5TQKSpjRS+nNQ/GzKptGxBodqAidAqscPPm+HAfCaFqaHr9QICvSDyOQB
 M3drTpLVcSsMlFXUQif8XWc+7DcWjrnUJI6RcNNbITDQ6t1ncqnGMhlHaboV2R8WCmIN
 nk+l96rW9nXW0Axla/Ep4723EDtwFZWGFaBqN1tJFvGCouS9tcLmaIKfL10ms6Ahm0en
 ouZgOgDgyKDJl4iMo1k6VLUy2l9hDuHxu9SLrTXbwAvzjB3ciNBpFV41W8DipFrOPT05
 dkkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhEGCFtLZ0kEV2B2erxhq7nhgnOFnetkO6d/MoIzj37K7SDsZyMtyqkxZxD8VkhH5cUWLwwRw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nWw0ze7UPqow/oWJbOWnl+0YZ3zz7EpQSV97Z6JFqMaKyNIE2w
 nzWqfsnaud0/ogjUtLJli4kC+cFy4XfnqdmgsNQpHpymvdnKVuqG5PcZJuiB2rZxz1E=
X-Gm-Gg: AYBFou3N14ppEOWceCiHXW7FOqXdfkYu/m57HF7ltzakU9/XZfjR45dCaSE3aTm5BxT
 bnZ391aCq8ruTnK+7LYtH4qPj/KiSOAtRFLgrqdzInVZe5pkuEJeOKifFnM4OqttfunyNirNL8L
 Mah32WJsF/v40y7FrdNcYaVh/mtp/+VarDnfewLvelh78IIlv5n0CL98mblZhZRJMwW+fxU6GLz
 sf5PvfI1dE4lmNe7iARFk1ZemCr2591vzfbbn4zjCn5gF4qTNn7V5iahtyyKRhhXJyEh2RuhyPc
 exn1Brk3BXaNJeqDKS8ut/J2g+hG7SGI9LAZhYhhMASiMqTrZpS5HIF0GT3WicUOYY5fGK36vKz
 QGcP8QCimFHeIVdhs203cqWGsyCCOT2rqdvT4+63It6QU1+dqYwybwugIn/wmuEQ+ThMJEpIXtt
 FuRaduVCCv8d23p31hC7v4Da2U4JmLnewnzVydzFu+nXBcetfC7eqYdBZx5GZTx+Jn0ykRSRZhj
 hYHaxrn+p/0dNMQ58oIJY8eozohdaMi7GAOFVttqgW1QdPdq8kigbMxF3CAL8VGPzwjTBRuQxPX
 hQKf1jTHzEpjs0wR8fHoFXvpd9bsAV4V7gwu
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39b2624f0f4mr24454360a91.23.1788687131980; 
 Sun, 06 Sep 2026 02:32:11 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa33e96sm19210761eec.12.2026.09.06.02.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:32:11 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:31:59 +0800
Subject: [PATCH v2 1/2] pinctrl: k1: fix drive strength configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-pinctrl-v2-1-729da680092c@riscstar.com>
References: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
In-Reply-To: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
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

Fix drive strength configuration by:
- Using FIELD_PREP() to properly set the PAD_DRIVE mask bits
- Not overriding io_type with IO_TYPE_EXTERNAL for external pins
- Returning the pin number instead of 0 from pinmux_property_set
- Removing redundant zero-initialization of the mask variable

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>

---
Changes in v2:
- Update on coding style.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index a6a22eacac7b..d80878fc6e7e 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <dm/read.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -386,10 +387,14 @@ static int spacemit_pinmux_set(struct udevice *dev, unsigned int pin,
 static int spacemit_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
 {
 	u32 pin, mux;
+	int ret;
 
 	pin = spacemit_dt_get_pin(pinmux_group);
 	mux = spacemit_dt_get_pin_mux(pinmux_group);
-	return spacemit_pinmux_set(dev, pin, mux);
+	ret = spacemit_pinmux_set(dev, pin, mux);
+	if (ret < 0)
+		return ret;
+	return pin;
 }
 
 static const struct pinconf_param spacemit_pinconf_params[] = {
@@ -406,7 +411,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask = 0;
+	u32 mask;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -433,7 +438,8 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		for (i = 0; i < priv->nr_io_pins; i++) {
 			if (priv->io_pins[i].pin != pin_selector)
 				continue;
-			io_type = priv->io_pins[i].io_type;
+			if (priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
+				io_type = priv->io_pins[i].io_type;
 			break;
 		}
 		if (io_type != IO_TYPE_3V3 && io_type != IO_TYPE_1V8) {
@@ -441,7 +447,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			return -EINVAL;
 		}
 		ds = spacemit_get_drive_strength(io_type, argument);
-		clrsetbits_le32(addr, PAD_DRIVE, ds);
+		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		for (i = 0, found = false; i < priv->nr_io_pins; i++) {

-- 
2.51.0

