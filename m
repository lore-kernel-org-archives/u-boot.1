Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0591CCF34B2
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88DBD83D3C;
	Wed, 19 Nov 2025 15:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jvFFPjf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 287A383EDE; Wed, 19 Nov 2025 15:35:03 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4653383946
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c704bdd57aso2886715a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763562895; x=1764167695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+3H0BPilzKbd4v2CniTKw4O1g+dLWCmH4Sa8OzSaB+g=;
 b=jvFFPjf8baA17D54yNph8Q6j5glD6C1TgFnzLA3Wsb4yiDeyGlo/VUMW5ZwAcJNwUT
 aJpigQ4EJoA3LiNPGZwtxqVYhy9duNzMX1J+VKdlPpiG2b/Jp5t5VedNwIzCnDz1BQdz
 WAAlSeW67BxDpEmXILPdMqTdt2zPVL+GOkI8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763562895; x=1764167695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3H0BPilzKbd4v2CniTKw4O1g+dLWCmH4Sa8OzSaB+g=;
 b=po+T3alu7wgkqZWTvghWV0QEQc2SmhKyOGeHv5rbfdLgTY5aVMWFNChI/6KlhIB1zK
 xpIFhFmAQHztqT7NxYGFsoz/EKasYpm6NS6opGvH7strrTcDGk6QsgwiyWz2GlX1cTYx
 BaJ0cewsS/2PMpxYalSdIM6RAhCWDzb1LxJeUL3SnYCTIOoOV0idSoIyCduz52fTK8aW
 McgCt//SyjqO9aMy1Op93nWg5BF5CZo499c0kOaCH0OrnK4oyfWGq+0Q+ORfpoKG7mhf
 aEMvAzZZLgP0xEiQiROYdHkEvruaCR1xfDqYZEajN1rnLi1UKxWZaecAMbD/Nfxvy8ix
 VYBQ==
X-Gm-Message-State: AOJu0YxgtXRzU/sByduxcZSgQs7tu7dK9YwLPfv9vnyDUqoObFZ7jv9U
 Er/nIeIXwC+tB5zXafYPMSpGfeY1FMJykdaUQ101z5sWC2AsSNqmCMq9PKexlm9XX+K1QAG3o3u
 zTljz+OvqQw==
X-Gm-Gg: ASbGnctHr+tklQYySngvqLaCiDYSPFvxLAEw9r7tiKvQJNaXQJiSYskIRRrQyyViXx0
 6UDdRbEm0s2i3mr8eEPPTi3lD5lH2UmE3QoH9Q59e9DxWOzksbqGs8eFHM3bJFJIGPpzFcu9oVS
 5NVTcKOvApFYzFOgGAmbhmJm02fSu9K2xhC1SepzijSP2m92k6L4e6jmLL/FuF6I9bQnNT712mM
 tpDZ8CwnHzp9TwiA61MmC9Ey7iHPbb2hvW2emkSjb9Fr1RoItZZg2v1x3hN5CQfP/yMX1y1xMbx
 qmHv7QZmNGnoxFZ+PlVXWOCn2dcNH3vN3wrTAsmyNpoVxJEKIPluZaeEyoVIH67IdT6aTj/dqXO
 PHYudk49I79BZROTWrfGIvWZ2JyVuuChHQaKJWN1Ac8MQEH0+xyu8XsOiW0xP/i+oYYxwvFyChb
 KjCWFGeqYRW3feb7Mp83Ne46DXbD1tFsRKURB9Dvmpu6p1ttLzA57SlhXsTNqwW4QqsOVuwqHxX
 w==
X-Google-Smtp-Source: AGHT+IHlaKKmUOsZ0PZ6uCiwbk2Jfu75DOVgNSHlMVxxg5E1Xcs73dK/vP23ZesZq0PDsuYWxm/brg==
X-Received: by 2002:a05:6808:3a10:b0:450:d120:fe4e with SMTP id
 5614622812f47-450d1210137mr4965522b6e.27.1763562894989; 
 Wed, 19 Nov 2025 06:34:54 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cfa332sm6244004eaf.7.2025.11.19.06.34.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:34:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH for next] Docker: Update QEMU to 10.1.x
Date: Wed, 19 Nov 2025 08:34:53 -0600
Message-ID: <20251119143453.838989-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The current release of QEMU is 10.1.2 and we should be tracking at least
that new currently, to help find and fix emulation problems. This will
make it smaller of a change when we move to 10.1.3 which will re-enable
sifive_unleashed_sdcard testing again.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 58f2a28daa0f..79f2cabbc354 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -220,7 +220,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v10.0.2 && \
+	git checkout v10.1.2 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-- 
2.43.0

