Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6965CC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD3E80B9B;
	Fri, 24 Jan 2025 16:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kaPMGtHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F80C80B9C; Fri, 24 Jan 2025 16:59:27 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4432F80B9A
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB8F63F2AB
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737734362;
 bh=V9s3MXXSYTrDeL7x7JOuAzondL3/q59fPCHQxNV2S9M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kaPMGtHgUtRo3NYXxeO2l8I0YLjYhZZQljbj9H8pWDp3W0cFNpRzpw4RWJXKZ9cVT
 gHThnK3J0av8JjBr2V0hz1orf2uHSGfjWnoLYkLhjLVyahjJAAJvNMTUxDhNptivsS
 nU3sERKW5tBhg0Oddj7+hX0/eflVSBpWc5CT3sBvQM0QW7ABwvZta0Yrr96mSorkfa
 5Vbj4F/0wo4p5j5bqYhVIgYCMHRcHwxkFSPiGveNOCEvscj5v6zvVvtR0urLKTItVb
 sjCoOJM8sAZjTrE8sDp8dbDPRUCwRTzgTInM6LyqmIZkihQkb59XyE3/i0GyqR68GI
 YCKg69gMDlTMQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38634103b0dso1245962f8f.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 07:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737734362; x=1738339162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9s3MXXSYTrDeL7x7JOuAzondL3/q59fPCHQxNV2S9M=;
 b=rfEn4DydzxiwNrc0hYzDTs5cmADw0PqbVTB/BW5ugrEpnnecWwxJei7op4qk2rmJ16
 Z4R55T9dfKLIGL3t7QRS/sCJzCRVlCtBboE4LI4IFMFoAJV7PO5X2Iu5LUmWyHJVdPu0
 kJ/DdQHx6x27hFOV8yI9z3Zb82eJFP1vF9Lq0mR6IZcwBBddReO2R8R+MhNyn8nvtr+r
 hyK4fWgpUwkYppYYFNKLw/E7qRr2pX1n8wK3cJc8xkPyXT86NNkMo0N3dFpKKdpDc+FZ
 vRIWm1dbcCY9k95MQYzwcrksntXO3BluhU2Wj7CyYVxokLnZxCWEN1reuHnZql60vLk1
 FVwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpBGiyPctG3ViU1fA3okzljS8Mtn0hxGbf6puHfeYyaLiEmubnzyl1sctX6N9Y6F/RYtSJYnc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywkw/gSQhLi0PJm81CGu6oyYh7UZGoDzFosT/Zr9RG0uV9x2wY+
 llrx8MlIQXLM/eso9qH+Rp8p9RX2NAFgME/LT+iXGQ0Ml3bPnKXSxP/FImOoOr8iWq+zSm7gZ4F
 Z6JsuEzy6czmoP/izV0zPA4Y/pg6m1Wk2su3Jv/0DnWQwIOnO/n0/CtJ8vL4GIB11YhgE/S9vD+
 k=
X-Gm-Gg: ASbGncsZfsmULLigc6t4OXoFvWZIl7Ir6+9NvgiLL0BCV0pgseMCEiAX4Ea4q2SPJu+
 uSOZolFlOM1PnGtlgJSQ/sKf2M8WmtyylQoCaob3lnMspwhwcf1RpgygX0XzQjqreexKhpS8s3l
 f+XpvMd93yY6kMp/TLUUc+Iso59lduPNxQRSNcUf4Ky4nGtx0LPktY0UWlEa9iVfDuKBVXUcv+q
 xIoNP84Fb4Stm/AbQ7O5yMD8kZlaKlmWxtWrUgdcN5Ze4iJIQQlm+MRfZFOojgJm2nBsc6SToy9
 A69r8X5MNBK+V/V+eoS66oYIaoasYvpPX/CEjMA8IZuvEh6gKwDcmpca5KrBjSQ4kyesiYXP
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr26122515f8f.5.1737734362107; 
 Fri, 24 Jan 2025 07:59:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTKhKAoHdD9Bsn36Fex1WuSWfo81DRi8rEcPUWsAM5XTYJQKW+idTKJ4bjKR0zaeIdDKfhkQ==
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr26122503f8f.5.1737734361808; 
 Fri, 24 Jan 2025 07:59:21 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17630asm3079732f8f.6.2025.01.24.07.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:59:20 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: sbi: add bhype SBI implementation
Date: Fri, 24 Jan 2025 16:59:13 +0100
Message-ID: <20250124155913.158505-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Bhyve is the hypervisor used by FreeBSD.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/sbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index 5ecf56781c1..b013c8c8d4e 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -30,6 +30,7 @@ static struct sbi_imp implementations[] = {
 	{ 8, "PolarFire Hart Software Services" },
 	{ 9, "coreboot" },
 	{ 10, "oreboot" },
+	{ 11, "bhyve" },
 };
 
 static struct sbi_ext extensions[] = {
-- 
2.47.1

