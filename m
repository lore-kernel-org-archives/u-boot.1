Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F44E65D0B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E96896FA;
	Fri, 22 Nov 2024 01:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UyhapPo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91345896F0; Fri, 22 Nov 2024 01:31:37 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F4589781
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2124a86f4cbso14935535ad.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235493; x=1732840293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRAW2cPXy3w/n1FiCM/7c/t6rNpc6WB+Ux3dV0zM2UA=;
 b=UyhapPo5jCbGnKwWJ6LxnMnWFQiKVoodX4RosDyOO8Ij7Js5c2W4candJWc/5/5Kdn
 X1/2EXkP4p7kZgNNrxgBAI6amkYCe9qRFVa8e54pHP78xGgFCg09JUZDL3ffeZnoQT4l
 xFVVgEIqtlEoIuuXC77u49Uu1yO7avJfWlSocFo6/2CquBRySdACa+l+c3wC0Qf8muOb
 x2w6PbfHo2rPccV4C8H2xa+MmnZKnlGb6j3gZuoeh4oyrMOeg1ItoKL+2UFpy99zj0vo
 3+s73aSbfKXpthyFn+e11tKuYDIw4tVbBzmaDcyPLuLHGyx3iRy0avYJcVFOz8i7wBSd
 LJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235493; x=1732840293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRAW2cPXy3w/n1FiCM/7c/t6rNpc6WB+Ux3dV0zM2UA=;
 b=HjmqcjZDBbkWmx+tS4qa7iLzdvp938SU7ZjVAqw3rk/VoraTn624ufG+dIH/nHb71A
 jHL6/+rP4eGU7iKPf+clsdd8qKVAlaIdGIK5jHRhDHxyG3+Yw9zv5Z9r7stpotXy2KoB
 kP1s4dLSeNtWyM5irsZJFyqQr3As9tsZockXfRXE9shC6eLoygw9sxDOBryOT6p4A1TW
 J7ITkRLyxmME3HwjG0+mBhdvJJp14AL68DBuYy1Ib00r1L9R3Vn5CwXAI74ZBmrDKcwm
 xmNBcyEkd/iV+OvTlcui3w9fKDvsxwlfCJOO6aiRr9UwtPe1p2o/8u2xaoudn0t0XMEk
 xtHQ==
X-Gm-Message-State: AOJu0Yx8EJaGdsoiKFOtLiPbHjSRtiYtncUk0V5lOdTo4jrzW3+t7wh8
 uhlYT4+yTC5xWKvO4lfy5kNmYVatvFrBfYorMbyB0Jn8fpk2biTV2NUBL1eB
X-Gm-Gg: ASbGncvDYAj0KNbKwDWHrfZ59K+gJrrtOUji3HFPtf/7hj5xysMivf8JIHmtyx/UyqP
 Ln9t0T+cvysQmS5JBBN9YlKoZs2lVxR3rDnKsC6Tcd016P3QiyUEX2bMRNZQUEuc9xj6J3mwiZF
 2tE2Xb6EVsZ9fp8LNBWAhF9tf7ufSsLbcIpSbCFAQcSERD2evAPYPsP7xPy6JHDfczYoaj5DEoI
 KzqUkWch4r4ux1h2kbCuPZ5VeTB7LAkozf+vCCyoiOdbiRR8SsRxndacZCiiW6Z
X-Google-Smtp-Source: AGHT+IG7XkkoPVhpb7dxm5iGJ6wLIm0uKLuIw4jgm32z3j+b/I7onAZB33EcIyks5iCHAOAKDCZ+1g==
X-Received: by 2002:a17:902:ecc9:b0:212:615f:c6 with SMTP id
 d9443c01a7336-2129f82fe3bmr9409305ad.50.1732235492804; 
 Thu, 21 Nov 2024 16:31:32 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:32 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/7] arm: mvebu: x530: Enable IPV6 support
Date: Fri, 22 Nov 2024 13:30:21 +1300
Message-ID: <20241122003058.270163-8-judge.packham@gmail.com>
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

Enable IPV6 support for the x530 board.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 configs/x530_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/x530_defconfig b/configs/x530_defconfig
index a5b1cc3f8e89..815370c90ecc 100644
--- a/configs/x530_defconfig
+++ b/configs/x530_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
+CONFIG_IPV6=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
-- 
2.47.0

