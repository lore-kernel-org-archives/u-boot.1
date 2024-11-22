Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8EBE65D0A
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C40896EC;
	Fri, 22 Nov 2024 01:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CVKNsPcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A7689777; Fri, 22 Nov 2024 01:31:28 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2993896FD
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21260209c68so20100525ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235483; x=1732840283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAUicIGf2emBdFSfWcPhJBlhFRNPWJ9C4Sw5DzDtFhE=;
 b=CVKNsPcQbQffqUNd9liNStXMoP4Uv+7vnh23ZcsU2plmUtYG1U4b2I3ltRZxlXHRyM
 QLPWn2uwCmztb5YFm2qz6XicFVXA4Y/1YeQO4fLk65BSW5rBtpU5Yzwy4N/TAgPpv6PP
 uxCTrri55tJ1kjmAwNEKDe7MTl55fKAn1GQoozrBPMeHGb8h8xGxJmgpd2R0aeTugHDK
 7t0j0zV4m/wZx1tKudlbSrlc5RoGkpc2TO3hHC1CPKwgVWvTCqlOnuLMqMyyyH5DzG/k
 isJMFP2zZVbOJxOUmqhfb+N4EsVOh1pS/KVUTNTyDMFbzeUVmiOXw7ZGOojqyLi9ZZMX
 J2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235483; x=1732840283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAUicIGf2emBdFSfWcPhJBlhFRNPWJ9C4Sw5DzDtFhE=;
 b=a1xvPsJdbTIgBpELvTn6YyQ81XPGagS2NOovn+yxCj3T/WWmqnoRD1dRYiJktm+S44
 FHGND8ytKxSjuFbRfvA1BIefIjo3U3NwWaj6lks7eRk8p01Dj+VcJrnZMpSPwifDZsqL
 tYlbw1jW1sWz9coHRS3GGR+/BFampHW5qb98Z5t1n0wv+h+K0lbG2cpSo8FhupRWV/K1
 u0V1byKJTajmUsEWc+2BIAGvUuHTDQmIgo4nPpHi+VOHTuZ4UZbnNkHRaxsFZscZHFuh
 p+fZmFswuoLhyK7eQYaYRUd7q2C5QriBrPYXzuwaPRy9Y9I7BQHoIPvGEyMlnJL1W64+
 q/yA==
X-Gm-Message-State: AOJu0Yz30abDXucQUEMh1NK3ISyd6jGYG9UbrFO6vQiMYGgfAwmVKVSJ
 41y6MBjWly7+wEPc3F3GUf7MqACPcHv0M/j0v9MOl9aKkY6QTTMYri38Evyc
X-Gm-Gg: ASbGncuQm5u0//9Qmk/kGRNFGzJaJGhnw7YHaZDVyHlLA9YuhSbuskiMplgXq6PmNSV
 Q9iU7HeQZfD65ERbkOWxaSeLpfFIGyNxIGtYejQaj3BxNp7jpMkFVSifLJoOSzCLAb6yssPbdpj
 Xd4WX8XS+/VFovKgyP5Dcw9Vs+z5KL1jdXZb442x+xVzLHWAsX0ZlT+20RGEA5G7PqhXAv7f8Rc
 5E3Azj+glKmuzKJa0voZnbf1tu+ZFZ3BX5ipBjnCTGokJoCP1LsmPchl1L6GOrz
X-Google-Smtp-Source: AGHT+IH4gzVFAc3imSvSSEtt32ETB2lVqaiwzRYZnMDz4oYM8J5h3ydBOlVKtNuLPHoewuEre+ac2w==
X-Received: by 2002:a17:903:2288:b0:20c:b6cf:f465 with SMTP id
 d9443c01a7336-2129fe09431mr10617525ad.6.1732235482786; 
 Thu, 21 Nov 2024 16:31:22 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:22 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/7] arm: mvebu: x240: Enable IPV6 support
Date: Fri, 22 Nov 2024 13:30:18 +1300
Message-ID: <20241122003058.270163-5-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122003058.270163-1-judge.packham@gmail.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
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

Enable IPV6 support for the x240 board.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 configs/x240_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index 5e5b467b7bac..ff64916204cc 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_IPV6=y
 CONFIG_CLK=y
 CONFIG_CLK_MVEBU=y
 CONFIG_GPIO_HOG=y
-- 
2.47.0

