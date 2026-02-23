Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399C5EA4FC9
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 14:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D03983D8A;
	Mon, 23 Feb 2026 15:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V6t32Aae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C7683D8A; Mon, 23 Feb 2026 15:33:37 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CB780077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so55037965e9.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771857214; x=1772462014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NXPFCZpUN7Hk5ifjxpLBETIrapd6gJH02w/cLhLizJQ=;
 b=V6t32AaesS7gCl9H3QlEnUMVTwqfd1CDBKEtt0EChV5MsKli3E+XPIRy0sh0deNFHj
 SehPugTVCrH2fVaxiv7vHZePlvNLatrV00bTA3V3pY+L1bbL660d8DasdH2osTEMsQ33
 YF6qxBaH4ezB27wJgpc5Zv8I1ByP5uYk27z7y39nANxVaryZDN7zazHehuwEb4peBn35
 6/QirlEaZ6AwLzadoOEzfEh2f1YsppVq+lSneFUC7k1KFqJta2WLk7f6fAP7Hd9/G+Dv
 +EJ2Mp5dfJ6YHLoP4Ic3gp7YA+LPuirxNOzkfkzHHWatqlxVn5VEdcD4oBDkzNTFM2RA
 bAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771857214; x=1772462014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXPFCZpUN7Hk5ifjxpLBETIrapd6gJH02w/cLhLizJQ=;
 b=KAp5KTCq4cvTHy3gmnKzgBayKskiMtT6d0i38i7pStI4F2vdi3PAHSze6+Wd8+YTrP
 t7I1ITfoB3PITS41Z2uPdvKAZGtcWXTa52+8PRgjtDfQ+k9BdKhPHLIFrGwNcS0rtBwK
 AnTppIP8SFMFmSOp7N/CBZol9DnkFxeMM3DVn9VGT20Q0qoyxk0AqkQA15WkS16IOhvg
 H6uiCYR4dmIIKasqfEUHfeUfyFKq9+QJvnXb2HdO1JDfHay1AyZSegHe8S0PdykXSwAu
 1WshiKYF3upd94yf+spaGA5kHNk3DgxoyoCU1EszLKbNNbfmh3Uw+wY7A0T535GfHUf/
 6Eww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnbuzAwS4PTlrRLU19dW1GxgmkuGAdhY2SVQ1QFjgsq8Mmg0NDT717O9Rq7sn6z3NKxg2HNXI=@lists.denx.de
X-Gm-Message-State: AOJu0YytW5Y6GFw8ZGWFCjxE8TFhRH9hq/aixLCwgZBr1tlJ1ujHuyYO
 iZg6vJZ4XzTjBsNjXKz2vpchQ7GUVbapWcpEfdMh96zzR+pRomrcrMMFccduvyBPRVs=
X-Gm-Gg: AZuq6aKiswTn5rIVW5DTOr6fJAVDCiOOK/c9KYynd9TyivIjyy0pI3uCig1Qc85IiJC
 WcadLRUxwvuIoPeu5CztmBJjwe4Z3ocgf/GeX+YB6a1inG1EglhbZTxVtQMLD5Qn85aVedEO1XD
 Q4h52qZv6His1811PPLNJvpkD/ZCTNiga/klK2uuqJtULu+UvPf8LEhTpylauQnF/ZNQ1umMiOZ
 i+IB/UeLlUMEb8bdNs+dDjC9FHhOxX7+2SrU1VofDAB6nHeWAAiwF7mX9+wAUcmmEpkfpI0XFVt
 WS9eD6RlDYV4U0nwOm4p3kpr+fY0UB948c1nHON77BQr3jCHtNUZWqSMlHfpUapvkHKzQdb9Uhs
 XvelKOJa5ebCgYNNDsCnFIYRewbB1mTUR2GJEO+xOg76kNIJ5WvmGuwhp7DL3GolHJ0Qm0Rc+bo
 THvCjsx2qG10urgu2eIHX/B8TbtAgV
X-Received: by 2002:a05:600c:1d0a:b0:483:9139:4c29 with SMTP id
 5b1f17b1804b1-483a95b58e6mr154940395e9.2.1771857213825; 
 Mon, 23 Feb 2026 06:33:33 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c048bsm282415105e9.7.2026.02.23.06.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 06:33:33 -0800 (PST)
Date: Mon, 23 Feb 2026 17:33:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 2/4] scmi: update comments for scmi_pinctrl_config_set_in()
Message-ID: <4ef79218f3f6d6530350f4ed228fc4ebd7d2801f.1771856828.git.dan.carpenter@linaro.org>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771856828.git.dan.carpenter@linaro.org>
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

