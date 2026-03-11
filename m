Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640921125895
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D068405E;
	Wed, 11 Mar 2026 20:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ChvnHJcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F4D83FDB; Wed, 11 Mar 2026 20:39:46 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A822C8405E
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 20:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439b7a87fb5so176739f8f.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773257983; x=1773862783; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bmE9jJEFX11koePH3BZ9CYAe8chrJY22RKBDTMnU1c0=;
 b=ChvnHJclCJuGG7FgjW5oX88h8j2pYvR+ql8BQxbWC2Up8iBRtJG2hzbgD+C/UnUNqh
 uZk5EryPJfNCD8Me88GSfjUBAbwt7rtr7p8W0xAuo98UKc/JkzCAc3pJvCPLpvxh8hja
 TX19ib4wJiZUUugE9AxeTkKxfax+vfmYxbzhOVS2burj7mZ+IL1MKZamgU6aY/YHMrjD
 sEwzHG3zS2qFrYaTAgPEzq/t8zbLE6fGW2BqmJFV6Q9U1Laexdc/MtE28c1Umhz+z3zf
 ++V3sPtv+jFIp2nl3w+2P4idohUt198kGIAW731TIsr0Qe0NfQ08XDHaiikFuWmVVVNl
 rnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773257983; x=1773862783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmE9jJEFX11koePH3BZ9CYAe8chrJY22RKBDTMnU1c0=;
 b=uA5O0IIr2vVelhxYc++o5sE47kTWENoqTb+Ir42TFLY9XAUoqDMhzZ8rhxQ0jGcLlb
 A5L4qV/jZ9cco2A4BkMAVLy80yGbGC5rLaTCJykL7JULVRW8xCcobH7lWs2EJazdauUX
 E198PsWyd7urMXWunzZeeNLp2z3Q1XkMT0s/XxOkuUC/igwLKotQjS+psu97tHReefpo
 cXkdaBhRkuARhrurRG7NcVjBP0W0T/PJ3X9NR+XP/tN9XNmlx8HPyXkIo0+EJWcCBbd5
 Atm/icHJRYuUh4xrvn+wcd3U4ciGHawxRXkfKOd4zcATBulUBagVwEx15mRy+RPyDMOk
 G01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7jUM/WW773biI3+WqzdbG5QPmGVsNA0bEFlz3gdfsg/2gQUvzavxh3+ppKQiAbWpY6D83qiA=@lists.denx.de
X-Gm-Message-State: AOJu0YxSqajfpMDDmAk5A4MGJDVcAMVa3llTExKDETk2HcQ1ChXpu7S8
 sLYUNKvpF4HC05KQ+5GstZglMRUNN3Ei60+W3zzcFLTISt+jwvD4CWhuAL55SDk37Nc=
X-Gm-Gg: ATEYQzyesrRODTi92ybVOePXkiy2hHP7DH7/GeBlsumzbJApmrD04/4MHfKYABYiOS3
 4xFwl+T92SjSEL7qRleywU5m+BvZjzy4WXaJM9ZyiGXJHreKeFWVSSZ0bXBigEDZ2ZWcHHRAFCL
 Vbm4Ztns40qVt6SePmVpvvSFzPUpcAZirbVPakfsHGRQsl3fCmT72WqlOu0A6hFPgNGJ9tbDXic
 e1VGMDkN2Eu+cJF3vNT0AF+/7kxpMfxYQX6SQskfKEuLHTU18DYpyDubzovfdTt1lj6PV90fozB
 XrO0pGy1+oLRlRHxth8HM3VET8bJSrGv/b4WlxbcX0EfZPM5k1mElS/ihZTECXmiPL0kdmhyEnq
 b7BSANB+UPxMYQ8zxUVSxlKVvmCMC2kXVQoen1PvYGrtK2nPuj8mWtZQrVFAicZqDyc2dFZEv8f
 nyly0CtNU14L2FbAZAXnaICwmspN0K
X-Received: by 2002:a05:6000:26d2:b0:439:b79b:33cb with SMTP id
 ffacd0b85a97d-439f81f16f8mr7161417f8f.10.1773257983017; 
 Wed, 11 Mar 2026 12:39:43 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19b936sm1992701f8f.5.2026.03.11.12.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 12:39:42 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:39:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] scmi: update comments for scmi_pinctrl_config_set_in()
Message-ID: <f83cb3dbee4b6ddca7766bba174625ecec2d4376.1773256350.git.dan.carpenter@linaro.org>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773256350.git.dan.carpenter@linaro.org>
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

Delete some extra space characters to make checkpatch.pl happy:

WARNING: please, no space before tabs

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 include/scmi_protocols.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 90b1bf76d5d6..a4efadafa73c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1107,14 +1107,14 @@ struct scmi_pin_config {
  * struct scmi_pinctrl_config_set_in - Message payload for PAD_CONFIG_SET command
  * @identifier:		Identifier for the pin or group.
  * @function_id:	Identifier for the function selected to be enabled
- * 			for the selected pin or group. This field is set to
- * 			0xFFFFFFFF if no function should be enabled by the
- * 			pin or group.
+ *			for the selected pin or group. This field is set to
+ *			0xFFFFFFFF if no function should be enabled by the
+ *			pin or group.
  * @attributes:		Bits[31:11] Reserved, must be zero.
- * 			Bit[10] Function valid.
- * 			Bits[9:2] Number of configurations to set.
- * 			Bits[1:0] Selector: Whether the identifier field
- * 				  refers to a pin or a group.
+ *			Bit[10] Function valid.
+ *			Bits[9:2] Number of configurations to set.
+ *			Bits[1:0] Selector: Whether the identifier field
+ *				  refers to a pin or a group.
  * @configs:	Array of configurations.
  */
 struct scmi_pinctrl_config_set_in {
-- 
2.51.0

