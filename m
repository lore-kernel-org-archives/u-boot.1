Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E8CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 09:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD8A8460E;
	Wed, 20 May 2026 11:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYv8GJ/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB75846E1; Wed, 20 May 2026 11:12:28 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3BF2844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 11:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so2700872f8f.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779268346; x=1779873146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Io+Zwt7I/lTUHgyjs2/ui3ewXQ8b/bjdfiSnp68rdIg=;
 b=UYv8GJ/HBdjPBfgyvLQsSX3mbJbD+V2vqPzpzk+sM9quagzCMpY/uUKJJS9avipTA3
 93hcUMtHofB+BkoGG/Gtry0gCfoqSNBlM+YLTEEFJAll7j9g/dlRtMDP7RBd9UV5Iwd6
 gDNI7Q1Rcg/10m9PoM16RtlX16ePlEZpxSgIcmK+/XKALS2r7EawMk4UtfVxQYCSTjGy
 QQte35ApcH6imWZHVBE9T5eBQpzuaoD6WkbvhFlf4FI2owrl2F8mbGUP8/SYe25hLpoO
 xVRZFXWL653h3QAdwGjcetV9HczG3QAR2LeEYU9yWFMI/uWmjg4sbQmarZVx6x5Mj6GL
 cLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268346; x=1779873146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io+Zwt7I/lTUHgyjs2/ui3ewXQ8b/bjdfiSnp68rdIg=;
 b=pp964QDFCLvMmkJWqUXYmkvwHCmAQmqImv1ZvDB/KQRSUqf3vniefxQr7HA/m7sAJp
 nPv3V1hyoN5608r7kZOyA6zIbg8GGwdc4v9UUjcq/4xFPriTv51kNoaACIejWcx8cZ5F
 0kIMGJ3PcBV5a3oK9z8uwHOgJX8BIwVXyujMENwVy6hYJrq2A+0HW6mGKzbBsww7jp8X
 fpcYgR7JA0QujjhK6KGSBKnBFr8syZn2t7748v++qMHq3lVYILLIAkvIpCoSLhp3iWt8
 0l4MiH+UTXONQ+3z3ukpRQdqPz+1BJI5ytSrxM36/VFLbPZaeZp1fn+sDpdL8Gjl7lGn
 0sKA==
X-Gm-Message-State: AOJu0Yx/m/1NUNxVstR1dzMYyjH4ArkETTIWlvynbpAQYNEix4PBwEEs
 iiEUtcGHDZe3glO01zsG5mPprmCfv3qRL7doctF2QUdFwOUguBpbQzJu
X-Gm-Gg: Acq92OG3ra/T/pGwwPv3fnJCMWqfDSsZPmYsHcrgimS/qIVs172r0jhetIG9tptbzqc
 8AM1egp2PuXpXyVstgf3CqtThD9y00IrNkQ3s9AY/EBeXJzGoSI+6W1hMG1N3T0AQUbp5QQefTi
 0L8JM4KXTw9nwAeW5vzq4fVwV9iUD1twPzM1TvoXjxmdGMbNOdEcJQjmo+PnKI2DdWQQd+bBzCj
 c0vakUKr0fijbTwTPwyfQFjCW8CfUwArSXwY9y5PILsZIZojLfvtkG/xPEXRon+mAOiOUZOI8Sk
 NbNEyi8j3vjeew8vsKVspDH4SU8fGE3MKo63byOdyjQSgRy5Zt+bph6tH8tjEAwOgh8rZG1i4V6
 u6rpy8DEb8TexAwbvEl1Hzd9M3k7wx009sGOYw5Lx+KA7q2TRlVBlmQj8rOF4VOKx642qrLHA02
 zNaOavR63/ILTArhrvM2PamduVya3+0b+5MQ==
X-Received: by 2002:a05:6000:1247:b0:45e:6518:3299 with SMTP id
 ffacd0b85a97d-45e651832f5mr23702217f8f.5.1779268346074; 
 Wed, 20 May 2026 02:12:26 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e6a135f0csm33660416f8f.27.2026.05.20.02.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:12:25 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] ARM: tegra: tf700t: Align panel timings with Linux
Date: Wed, 20 May 2026 12:11:54 +0300
Message-ID: <20260520091155.44696-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Downstream timings provided by ASUS do not allow enough time for the
bridge to set up properly. Switch to the timings provided by the Linux
kernel's simple panel driver.

Svyatoslav Ryhel (1):
  ARM: tegra: tf700t: Align panel timings with Linux

 arch/arm/dts/tegra30-asus-tf700t.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.51.0

