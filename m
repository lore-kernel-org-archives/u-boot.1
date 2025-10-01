Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CECCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE1E83768;
	Wed,  1 Oct 2025 23:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRgp4h+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2FE836D3; Wed,  1 Oct 2025 23:29:57 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6346A836D3
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-92c4adc8bfeso26201439f.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354193; x=1759958993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZg0qN1j7/XbT3TfDfHdwZQNE/us5nwCTo257O3N05s=;
 b=aRgp4h+DUP08Ai1JqOGm2JAsWZwA27llQYIDPr7RvSFPO8ZMo4xqAUfvc6BzxNlyVG
 aDtMuHRAVpr7No6q3UYOWhxJyxAhMMoqApZ0ppgmV30pgT29OEsEs+qKoPx6GiSblWTC
 vlGp3JvsNd03kkY0mMLLDMa+H4HcncRADDD3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354193; x=1759958993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZg0qN1j7/XbT3TfDfHdwZQNE/us5nwCTo257O3N05s=;
 b=etVLA8DSMC8ms226j6xkMgy5qL43OJcrQFfGaLbi0WfiMILJ4BaBP5Gdl7CdotIlyd
 97kfHQ4AM/tEsqfcmw2qmWZOWyRvavLpdjvpx9Sm83boGQovJCUUiwx12guaDfe9DKtu
 US4WDCvhf8HQboA88vxay4ciL3x2YWRtJJzQgrqgi3g4ptptuI+P88YQgBleOjUJeAbI
 o+OKT9q2ryEOOnIQDEcSTMojof7g8DP+Y1+etFgEv0lrD/5WZIjB6UehK23noHgUW/ZO
 EYEyNWHZ0QtuX+PzCH4Fb1LtDG9afJRyxzfkBA4E8iW381lXKzO9TbcIKVJfBwy2rPGH
 sIUg==
X-Gm-Message-State: AOJu0YysCMNU/Ubs0LTCaOVVNjWRr7RgaBw8infgbLIZYQ0TCA7XP2t0
 teE3v836SseGE4gsrlr3Q0HlDiCUlaMwZFjgHPUOrVanhAS67NsXytrDNyp/uMsK/RKQUVSwDfd
 J8JR5AKlB
X-Gm-Gg: ASbGncu+ZsgZGLMcKhEppectHU1LTjpHAASH8Kdhu9KwdsGgwfozqL7Fz39Op0FZoO9
 7Bb4/HqBZqarkeChycxwB6ucESSA7HHQ1Hf8QdJ24l8fIu7+dloCwtQN51zMAfQsfV6SNVllXxa
 GylPAZAFRVC81yzaz+o+ckQnTdFxD1W+vn0xoyTz9VPUFt850JDsUvoQrmN8gvnVo+G7JFV9GOC
 OOfGnvGtplMzrT6GIOZZGrX5dLII13jICn8VK2s8XKEh2rY/F6kWOsXJ924ch2pKiR6eWg2i5GQ
 FCrpt79ibzJnWhaEF8IXyxbVFr1wyCjmw/BEmO+PW3gkZv11EMHatXUhhkSn45f2p8XqK76YeRZ
 d6IWRpDXNZsW4HISrBqLiKHU8/GBbL1yQc7L9n5Np
X-Google-Smtp-Source: AGHT+IGKpXJxtCBaeLC7da50gHYzQmAUmJht0jXnxW0LCVvF7hshlTlw1MvazhLyY3uANtPxWUgtfg==
X-Received: by 2002:a05:6e02:188d:b0:423:51e8:3694 with SMTP id
 e9e14a558f8ab-42d81612ba0mr77075575ab.11.1759354193524; 
 Wed, 01 Oct 2025 14:29:53 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/17] boot: Only run global bootmeths once each
Date: Wed,  1 Oct 2025 15:26:37 -0600
Message-ID: <20251001212649.3263574-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the methods_done flags to make sure that each global bootmeth is
only used once. For now this has no effect, since they are all processed
at the start.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 711b971c419..5080096cd11 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -354,7 +354,13 @@ static int iter_incr(struct bootflow_iter *iter)
 	}
 
 	/* Get the next boothmethod */
-	if (++iter->cur_method < iter->num_methods) {
+	for (iter->cur_method++; iter->cur_method < iter->num_methods;
+	     iter->cur_method++) {
+		/* loop until we find a global bootmeth we haven't used */
+		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global &&
+		    !bootmeth_glob_allowed(iter, iter->cur_method))
+			continue;
+
 		iter->method = iter->method_order[iter->cur_method];
 		log_debug("-> next method '%s'\n", iter->method->name);
 		return 0;
-- 
2.43.0

