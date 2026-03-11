Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4343112588E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D731383FEC;
	Wed, 11 Mar 2026 20:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mbTVfpnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6707883FED; Wed, 11 Mar 2026 20:39:41 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3CC83FDB
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 20:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b7a87fb5so176689f8f.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773257979; x=1773862779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dnjrG36R+BMuIFVnXjoJfNTiA6wM2weW+yEPu23ojTU=;
 b=mbTVfpnBP8sNyS7hRPCFfD8Kc3xh0LrfbeCqqEE3AukQ3z6+l3F341Y1MGLJSzzjhr
 zucsxRRh0g4HdqEGO4ABrgNXQZycVx/sCiN7NXNwBHtX2rPwe3MhxUpbLrRN7lIbZMFD
 aqwXgCJbRRAR1DzHunZQbbeL/XqtVYj1P1dYCHUVlYEWBT0wY1kw6EuaJaQqpuiVJ49n
 ws4kk9N25t/21Kw+FVT3fqr65vOMvjPCscBFf9+6Iq20EFF6mpcwdc3GcUS6ej5nTLmv
 LxzVJT+smXkNgB0t7WPcxCzRJfwuhrYElO1rwMPoK1x0DRW5vzTZ9epWp7f20N4btxnh
 SrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773257979; x=1773862779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnjrG36R+BMuIFVnXjoJfNTiA6wM2weW+yEPu23ojTU=;
 b=oAogwoaXeBjKUz9AGy7XaTCci5GVOAUNzLD9qKADx6mRcvMclglDYyzUmJ9WsXwovl
 IVQxMCSLjeNrrSdaFZmY7sgJVkiQWM1x5YaV+V1C2Kk9qdsqVo4dsEWbTapoL3/R8I4W
 UoQ0REmQF0gyeoeGZJlAcZMMjIXXQPSmRhnl54pDUkhfiqvdQ6ZTQGxK3P/N4O5qtcxj
 hPb5kPtMyCxF3cxvYbdp4FZPLQqVh19+nJnYlhgTsV9fE7+6nSUn4k3Ow7kH4V7XNoij
 D/MDHQQpENjNhcku/LLhZ1cdANxhgTiGtPj88Pdnc181llMfcbKpXUY8aBK5HOakKsiR
 2B1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCt9rcfgj4TPdm3pqzx5FuOJJBdu71tTqfss11cjZnpV5zo6FapTveiqfHRnC69iFQ9KVfphQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzO8AeidVCXPQAXsLL7UfZee86nttp0w/P2RwYHogHs8OMkYeok
 gn9m9IEjx3ajPkYpo+/xAE9EsReiODsFX3HMSh1g01e2K3lUmxd17wsqcHHIpzqgM1f4ED+eIGg
 tBPO4
X-Gm-Gg: ATEYQzzAoOCYiZQJGgu/UF95pma8s3wOUDrIt1D07RFVz+H8RLpVeyfVsglxTSIvMtd
 R5/j89q76UIvIyMmfAAoUCC49ktxzqrhOnuHf8zcPprmQzq7i0yCnVhyFVpj68dplZMPWFeGR5N
 JqurXV6JYwy2Qza5FvM8EbrcVjZ0W5AAYm+9SsvLqwT1B1MHPoT5u1hFOWc0jg6r9Mcydx+42PE
 ho1pVijWvLLnJNef027JN2izFDg3PTHQrOF3IzWPD4OLniXNBmswzEIB5hDiccWp9hPL832JdR+
 yF5yqbMClPGuFL7rRqr1DAxvzMAwDc85dY2PRpDhuFnjoyIIaOh6HPfM8sp0Q+zlLNavhQ5tJqz
 ZvTlw4WZI3DS4iMr1f3HSgwnB7xIBgSg8AE4lAd60U7xu7srsJcprsHpsE2FdIU5nCzHkWR1T/Z
 h8eE2RkySJOsfLv4Y1+SAYdh2kcHU+
X-Received: by 2002:a05:6000:4205:b0:439:c799:dbe3 with SMTP id
 ffacd0b85a97d-439f8219aa1mr7003267f8f.25.1773257978508; 
 Wed, 11 Mar 2026 12:39:38 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm1560844f8f.4.2026.03.11.12.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 12:39:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:39:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/4] scmi: pinctrl: add pinctrl message IDs
Message-ID: <9f229a384c78ef3da12defab0aefc03ee2aa7b02.1773256350.git.dan.carpenter@linaro.org>
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

Add all the pinctrl message IDs.  I renamed SCMI_MSG_PINCTRL_CONFIG_SET
to SCMI_PINCTRL_SETTINGS_CONFIGURE so the naming matches the spec better.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 2 +-
 include/scmi_protocols.h               | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 781835c68527..cf76b14d3731 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -69,7 +69,7 @@ static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 c
 	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
 
 	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
-			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+			  SCMI_PINCTRL_SETTINGS_CONFIGURE, in, out);
 
 	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret || out.status) {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ecab021b4728..90b1bf76d5d6 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1088,7 +1088,14 @@ struct scmi_voltd_level_get_out {
 
 /* SCMI Pinctrl Protocol */
 enum scmi_pinctrl_message_id {
-	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+	SCMI_PINCTRL_ATTRIBUTES = 0x3,
+	SCMI_PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	SCMI_PINCTRL_SETTINGS_GET = 0x5,
+	SCMI_PINCTRL_SETTINGS_CONFIGURE = 0x6,
+	SCMI_PINCTRL_REQUEST = 0x7,
+	SCMI_PINCTRL_RELEASE = 0x8,
+	SCMI_PINCTRL_NAME_GET = 0x9,
+	SCMI_PINCTRL_SET_PERMISSIONS = 0xA,
 };
 
 struct scmi_pin_config {
-- 
2.51.0

