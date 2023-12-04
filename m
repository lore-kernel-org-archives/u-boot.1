Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82EAC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335978759E;
	Mon,  4 Dec 2023 13:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IfelHAyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849BE875B6; Mon,  4 Dec 2023 13:07:10 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4CE8753C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50bfa5a6cffso811121e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691627; x=1702296427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsr0zJss76jKia1cvuV3LBXuFsGHY7LZmxXVF8UwBkM=;
 b=IfelHAybv+WIeFbSL3ZkzgOnkrkx/+lVdudaU+YKELDeaiCReV6utpnyv/SPm/+i2A
 7fps4U+1TqJmuUvr/lHIR10llzzYmcIMRFTl+eMHvtyGLw2PX+rawhxM7bwreZe4o6Uf
 mV4s6Z7VQF71AQEUBW/cqaW6fZ46nd8SaLh/6514TgHsQ/LElAksewMG0nNkU5uX1Eyj
 zY04me3pEkMC74Ub/141i2XN++8D3BxNIVlOFKJHh42PRDeMU1YBtiGG7y/CwITx/L/l
 /6UlA+UdOQEZAP3MxkkqSItrdNnVP/5z3ZjtbawqW1S93vQakzLjCai9ncpKcoQ85Rkd
 ZwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691627; x=1702296427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsr0zJss76jKia1cvuV3LBXuFsGHY7LZmxXVF8UwBkM=;
 b=bI7JiWCebuDwelx+kiLK6mxlVAT+HklMrm4BBB71Iy7VmVA1a1FLSlSG+CEUmQjNoU
 oauOF3MhTVyKTriGBpJTfnBkB2v9uNylKhR4KqYTLhg3T6I0bM0BsAIgp2cuH5pV6H5H
 E0s+5Fvawd2BdkNl4RH5h3p/pMb4xrePvIOupbBiOf1XZR+CVuDxuW0gcJdbQ5oD2J2T
 yDaSw9DOlo2H3WCak9nn5hriwgAx7V+qHlrPJ6mUvZFQdZIaReMZADyg6j28MnUx+VRo
 EbbAtmupcIUeaJGsmKMYzsdZB7xximdvqU7vJgyMeZwaFLXklM3TxKvDAgYekKLJ51Py
 Z3Sw==
X-Gm-Message-State: AOJu0Yy76Z7bu8rUgPraXEiPGjSOcHgkO1XsmcjaIYiAuNcC84cc1Ngt
 qOfG0k0/+ZgiDafcH7li7A56HpJ9PqWZ8XlXtVq/5g==
X-Google-Smtp-Source: AGHT+IFR/84EDSFTAzFD85+0cug/BYI37FvTad82HoY2WiKkjhgXHzavnxzGZWlex2lEZ4uGukn+iw==
X-Received: by 2002:ac2:4650:0:b0:50b:f084:7c8f with SMTP id
 s16-20020ac24650000000b0050bf0847c8fmr1049458lfo.111.1701691627314; 
 Mon, 04 Dec 2023 04:07:07 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:06 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 2/9] net: sandbox: fix NULL pointer derefences
Date: Mon,  4 Dec 2023 18:04:39 +0600
Message-Id: <20231204120446.3277-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

