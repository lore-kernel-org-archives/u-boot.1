Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E539CCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F8D83D9F;
	Wed,  8 Oct 2025 11:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DgoedrHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B4183C6C; Wed,  8 Oct 2025 11:23:42 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4F68393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so4117706f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759915420; x=1760520220; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5qN3X+lyCMiuCEz91dMeDXD6NEE1z2eR8uwgaijNdA=;
 b=DgoedrHMfu6T4QWej/WS9T8nlJ7msJ+Chg4JJomy0JDRfX87qA4r1wn527Thad8J0U
 JsPDi8oXeWNwBLMOURwHIgotufe6ZRW9V6doAKEo/Y+ge7SO3hJgK/yLCWV5AZxSo0Eo
 FiMQIPfO+b8EPe5ga8LEGRldApz3fyAwjc6mxb/5frjHIpiaNortSAKLwgaEpJpt+cQu
 bWIMUbz8IObjnkuxesQjwt4GgYVv7UZEXXBOUkDSC89mCQNG950V5i4Usa26PdSVDWm/
 q4Twla0WpDCBQAsrz60T+GlJIuboEsHfO4iFo52QCN1McPckiurt+uuDigcoutYWHmLv
 brug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759915420; x=1760520220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5qN3X+lyCMiuCEz91dMeDXD6NEE1z2eR8uwgaijNdA=;
 b=CdPnaPAmxjJMiMHiEXExsgGIbf3HoY2pWTVG0FA4EppcjNEZJ42XKt+Y0m+O2LdA+L
 doetGX1jwNEXw59HrpizIJ94EQNwTZacdHqJ7EivDrf6rD+vqdU467lvF/m4+MfC9qYV
 Y2EOk8wjIOaVsf0xJtqrqZeEnM6LFvlDY6gyGfPhbzISBiNOjfl9lrrHKQI0Ud+BrJFB
 BQYtC3Ft8O6nl5inWWqSh5toXGp7lgQz/AHar6SWXqzNPNd+jdau9DEnxXm2CfHcheq3
 gL+Xe7TBL0SpLcR308N12MoNZklYf9UTxFGmGknyx5UwYv81jUbDpaer017ooh+sjxqs
 +bUA==
X-Gm-Message-State: AOJu0YxG9K92ubleX+lq8eBwSyf+JE5LULbhNsiJxbkfIE9d8mOx1U8S
 /VvrDGyIgKGL+oILw4FmHuIfCegv+etC7m3BSmdS6pOnTbDvqFPpnsxSSKdzk8ZUku8=
X-Gm-Gg: ASbGnctuJJl/JlXkT0b9siul1ursdter+qpQnnj2WI/wz39OJlVUOI9ujH+i2PXW3Pj
 v1ucMGQoENF1txB66btLQ6vchu5Wkg/+0S4FWH/mhbIw9kGmP9RrSsJwxyMph56BKIoRFdDdaEA
 ObQg77O+okIpW/AeaJQoR6tLjTnR7jbP4759Aw93r6EjaKPj6xiRJFd3tmtJGgR1wHcs90Vjw2m
 gGmHTyJzvE+GhuWGARysiXT4SmGTXHt5v4W64F5/rYqIhA8eQ9vc85qoMzpR9youi3NTjm7jBMP
 wt2DfISyB0VxtFZYXwhrvzLAoARIlmRA/nl8kGBHVXSCwH4QJ/5mz4/by5jyRnwhwLYw4VBaY15
 S638v1MmbLRRWy/YkZC+/0aF951JejqE7jy+S6xbq7oArCsGwEEg/d/j4dW5Caar5dmSgFG3+nM
 BKMBs=
X-Google-Smtp-Source: AGHT+IHYEc7t5IIOjk1yyGOrYxHtaMx1eK3mO/0YCapg/2/Gke4gbNLatF5rD+y3COW6p2gbj+YZdg==
X-Received: by 2002:a05:6000:2c0e:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-4266e7dff05mr1555837f8f.29.1759915420467; 
 Wed, 08 Oct 2025 02:23:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:5f9f:be0f:fb04:8dc4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm28864715f8f.34.2025.10.08.02.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 02:23:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 08 Oct 2025 10:23:37 +0100
Subject: [PATCH v3 3/3] ti_sci: Pointer is never assigned to valid value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ti_sci-v3-3-5866bf84adc6@linaro.org>
References: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
In-Reply-To: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The pointer resp is declared but never assigned a value but is then
dereferenced. Fix this by assigning the pointer to the message buffer.

This issue was found by Smatch.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 534326be5ecedba1bf221d04d708b6db15f09706..6f57dcfe8de8f874318cd53372c798d182faae73 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1365,6 +1365,8 @@ static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
 	if (ret)
 		return ret;
 
+	resp = (struct ti_sci_msg_resp_get_clock_parent *)xfer->tx_message.buf;
+
 	*parent_id = resp->parent_id;
 
 	return ret;

-- 
2.47.3

