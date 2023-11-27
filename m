Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B91C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AB387652;
	Mon, 27 Nov 2023 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I08CgCnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA9D87657; Mon, 27 Nov 2023 14:00:51 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A2287570
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50aab20e828so5952459e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090048; x=1701694848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLaiV9HF80Rqq8fubeu6ab2vfbV1DnaWvPksOl/hwC0=;
 b=I08CgCnEfW6uDZvYrTpc+DqKwPjXcO/DG2p3vMIiaBd7fAXhVoJn5cczinlkf2itA/
 6eS+mHIhXTYHkehWFx6cuSBPjRipMd+n7NbJQnkKl0Gu1sVbIdDgKlS+tEuwPfbZ4cJ7
 DZtHNfd/xHrdxulvWGZsEndnS6eOQC2B+i79FNeajHiuT/uA2hy1cVrSDKcDztbE9rwE
 8yWDzW8rCafs0cvh1PRscotnbBouIAZDhqzzO99o7+J18jeqGouyRziC3NWqER8E2eX5
 IcIJzI8T2f1rslx8Dt7DROz4zQLGLwdQzTqtki9YMY80Njfsooegc8EX5rkvsZGnFkKy
 TwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090048; x=1701694848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLaiV9HF80Rqq8fubeu6ab2vfbV1DnaWvPksOl/hwC0=;
 b=sXnJHQ146PUg7q5PnnzlqyJtrZMtSfFqM8InHCt5BsJCl315OjhVwlzTD33SExlzUD
 mQ6r0T1T8gviMXalycHlitGKnFqhH41q2upv0cn3kB9LfiVqc5FyFieMOH7tPjLYEc4O
 KdrwQrqK3teRWtw1wW05d9966/J2POKuTxKOEBEHyV+Fk4Ig4f+wo8xUFYKnFJC0n6NB
 3mg/ZzDnNhRwXEll2+mgs4MpmVPXQ4IOIqaaIGgXLoMKxD2UWCClWEfQ3xjr72Q9/eUV
 rFcRBJgwlyaxuRVhoajwNBJagNIth4+2v0s9IBbZxbFe+FN0uJErtcsBza7YcQqLFP26
 MjfA==
X-Gm-Message-State: AOJu0Yw3NbeufR1bUw8sNsDLIl6ux3Frwnm3Emre6iqayWkybcxQ3Rsz
 0VXn/a8Sb8g/Er4b3VOfHw89tEvjIQpDQlp9Acl95A==
X-Google-Smtp-Source: AGHT+IH5EazcDb4XfylabnO8FRti2MYYZaSOgUA9+RyLV86zBbnBmMAewi6ICso52inuUSQ8Wcd98w==
X-Received: by 2002:a05:6512:3b22:b0:50a:71e1:e1d0 with SMTP id
 f34-20020a0565123b2200b0050a71e1e1d0mr9402569lfv.6.1701090048448; 
 Mon, 27 Nov 2023 05:00:48 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:48 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 17/43] net: sandbox: fix NULL pointer derefences
Date: Mon, 27 Nov 2023 18:57:00 +0600
Message-Id: <20231127125726.3735-18-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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
 drivers/net/sandbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index 13022addb6..75d32db3a9 100644
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
 
@@ -82,6 +85,8 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
 
 	/* Formulate a fake response */
 	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	if (!eth_recv)
+		return -EAGAIN;
 	memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
 	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
 	eth_recv->et_protlen = htons(PROT_ARP);
-- 
2.30.2

