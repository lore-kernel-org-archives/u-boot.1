Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D17C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9D28882D;
	Wed, 22 May 2024 12:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="GOXZj4Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04568847C; Wed, 22 May 2024 12:14:44 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA32688476
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so65706111fa.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716372882; x=1716977682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGj1X0L1/l/ZKpNHp1ByhuZd44rVrlNpdA/rpET/dUg=;
 b=GOXZj4Uyxpi7PkumJKVT/8wi1IwF9If1URYNJK9EWyNLC0YZ4uP1P4KflOTeZLFPbT
 +V8QiHxN18VOCuT9xfwkSac9o2nSdLvU/4NTpTYjg7g1/z6eJHffOVOd04sJCtPzPrvI
 8dXwXsaRHmc0EuNSEuuxBoB8kFDMfWGMPuqnAwQPeKXql9LbzP3vpI6uEX+/Xz1rOfbK
 8/FMSc4uRMd92fAKJYwKIZyVp4ldr6mSggnkcwzkdHtwxyVk551E2rwd8/BfaNGUXPyf
 8PXOQ9QBmvbRVvNTetE/U+BZRg4vvyE291N0JLNFzm0ylDSXrlD4SingJwgjg9VBvVjb
 jbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372882; x=1716977682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGj1X0L1/l/ZKpNHp1ByhuZd44rVrlNpdA/rpET/dUg=;
 b=WHMO7YocNdMztWH+zYd4du+lIFmLmthK613SblD7AiMQNgHnK2hpY/+s2/omN+v+HV
 6qAgNy18dAoorzeDvYLWiHx/pjUsST5B2b3orFh+AaNCErAoqJXTxL457PIE6sVrs51O
 772NN614qWu6YAplW5BdIfVhORZdfsagQ/xw4DievLM/QFSlLSxXQlk5HjPUmS+Z4p21
 CZ9WBV+Rhsn5scu1LzxRnQzDEm3llOpi5sxiMjRM1/5Oi29TXedAY6RCfTHNcu6I3RtC
 FPfWd27vH2Pgj+Y8hynQgYC+kGDd6EXjU8AMWtTRQs/+/M7u1/YBpQsLTIGnkM4OZr13
 bcDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj4Hu1Nre/nFwWFv9kKL3x7gWI1S9KwV4qL+wCQ1URa9tfamSKZ4LDQF3bsdogKgavsIzseY3XBomiYLKuz+0mwmqFNw==
X-Gm-Message-State: AOJu0YxSbC2ixRUnJtpEl7ECN/cea1yIbOXJQMuA35PgeWl0349EWsr0
 hMlUzOO7q4bODH/siFs0HhMSt6bAQxSNNuWkG95ZNk62An/hE+1kF28C5iyE+yI=
X-Google-Smtp-Source: AGHT+IEXtazx+G9SA138A+5GL1hgzjtTgLC2c9Bey/DUy7YVEUAe6hsAVuZ7aieBbtvqbUhu5+FjZw==
X-Received: by 2002:a2e:8912:0:b0:2d4:5370:5e8a with SMTP id
 38308e7fff4ca-2e9494876a3mr11845571fa.22.1716372882186; 
 Wed, 22 May 2024 03:14:42 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-65.dynamic.amis.hr. [188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a5a8b634cdcsm1081502166b.93.2024.05.22.03.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:14:41 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, j4g8y7@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/5] clock: qcom: ipq4019: add missing networking resets
Date: Wed, 22 May 2024 12:13:43 +0200
Message-ID: <20240522101437.225880-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522101437.225880-1-robert.marko@sartura.hr>
References: <20240522101437.225880-1-robert.marko@sartura.hr>
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

IPQ4019 has more networking related resets that will be required for future
wired networking support, so lets add them.

This syncs the driver with Linux.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/clock-ipq4019.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index e416c9cdb0..2773bbc2d4 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -205,6 +205,12 @@ static const struct qcom_reset_map gcc_ipq4019_resets[] = {
 	[GCC_TCSR_BCR] = {0x22000, 0},
 	[GCC_MPM_BCR] = {0x24000, 0},
 	[GCC_SPDM_BCR] = {0x25000, 0},
+	[ESS_MAC1_ARES] = {0x1200C, 0},
+	[ESS_MAC2_ARES] = {0x1200C, 1},
+	[ESS_MAC3_ARES] = {0x1200C, 2},
+	[ESS_MAC4_ARES] = {0x1200C, 3},
+	[ESS_MAC5_ARES] = {0x1200C, 4},
+	[ESS_PSGMII_ARES] = {0x1200C, 5},
 };
 
 static struct msm_clk_data ipq4019_clk_data = {
-- 
2.45.1

