Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6FFC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3793F87646;
	Mon, 25 Dec 2023 16:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N64ZV7oB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736CA87561; Mon, 25 Dec 2023 16:41:52 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A79C87721
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3333b46f26aso3754467f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518909; x=1704123709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsr0zJss76jKia1cvuV3LBXuFsGHY7LZmxXVF8UwBkM=;
 b=N64ZV7oBxqV1DxRAuO1gtDYURgYGWB7Bc3mHQSUmLeKih5sC+hVW/LzgnLHZbjuN5q
 as0sSEzbw0hX/OOnyACExCuKppCqQvtbXjXs2pqqHUjNkCdAaLAiTF7iFFW2zKJwsAD9
 jRbZzwpdIe4D+ND40b4aA2R+toZnjVkGfeiO7/MJMgjrWRbhK0zEp+/YkQcQG5MSjg5O
 g6jh9T1/PTnMAhXkC/S97arcIPIOR8hvQBVjAUj1CL/t9nPUHEd+dnyoHsAW2bIvxHCA
 +XGGYyEPNsTaoWELjCyLv66CwkAlMwuhaEqXZvMyzKl5NNqp6WbKn5A/i8sDFznjvjcc
 k6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518909; x=1704123709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsr0zJss76jKia1cvuV3LBXuFsGHY7LZmxXVF8UwBkM=;
 b=wuRvQsK0hXG4P/kbYvNT6lQorzMzMe579GhOkLqraKRUDaaniohdpK4gF55TILzQ1z
 5Yc7XNJOWdw5hz9iU0i+M3IACyeFMr/02JQka675SL83ynkanhJwggVnDE7LVP/mufpi
 sHNnPPGHdSBMjFJqAhUtT3zAZYx0/llus0NzNjdMuZ55oqSpNL8O9CV0C6+vuOl2S8ol
 3tQoCfk4DpDHDj+5M5ABiTr2qHUG/fAWITEUDXNIuYL+SkNMTGSLdE5YKq4XBwrwkq5y
 bdpl9WYsE5DjMZ2ZKT+V/219GJNb7MvveqfkSFWddfK8EIFGt6C6q34Aipu71lEeVZB3
 aazA==
X-Gm-Message-State: AOJu0YxFL3tTI2X3xn12bnAyKBF5ZKGDK97Ml6BSygGFzE0dpm8dB941
 NeLePwFPI3hZp5+JLRCs5u6AmN2ASQJE+q3Xy9YaIcc2efw=
X-Google-Smtp-Source: AGHT+IGg7RB7OD9sCrSpHPSZAuDHudLyv0u+udbsBTQhSSH7bZkqzTgXbiG+L2Gh+AUpAZh+ILo+nw==
X-Received: by 2002:adf:e881:0:b0:336:737d:4b93 with SMTP id
 d1-20020adfe881000000b00336737d4b93mr3233669wrm.46.1703518909253; 
 Mon, 25 Dec 2023 07:41:49 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:41:48 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 2/9] net: sandbox: fix NULL pointer derefences
Date: Mon, 25 Dec 2023 21:39:22 +0600
Message-Id: <20231225153929.8284-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

Add additional checks for NULL pointers.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/net/sandbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index 13022addb6..d91935e032 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
 	struct ethernet_hdr *eth_recv;
 	struct arp_hdr *arp_recv;
 
+	if (!priv)
+		return -EAGAIN;
+
 	if (ntohs(eth->et_protlen) != PROT_ARP)
 		return -EAGAIN;
 
-- 
2.30.2

