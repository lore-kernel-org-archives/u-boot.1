Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1442C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7073E80C7B;
	Thu, 20 Aug 2026 13:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkqIbFxzI_ko; Thu, 20 Aug 2026 13:08:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787231284;
	bh=TXl99Fdf+kdzsa5sbJmMB4jVzMIwuvGdbTgNwPVb21Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u6LxBdbfvgI33Nj3pKcHKPn6LS/rOfdt0xqfyCPpwmlCGCky/JLVFMll0r4knTJSy
	 As+ngmawj/pIzic0rmAzSfYmNFAK2s+FiLNPFhurt4dAemcmlZW5yY576xffuFCzKr
	 BsXogpnPrwBGoWQV5Kq1t5SAw1Pqqt2pEeLD/EJ0CY9c5Nufa/oco/EH8rtfIqC/yv
	 ZfM/bxKqZqnmRm/ZIkZgRFIUOFC8adjQUum5NkJDGYiO7RlY6JzxFt36cHPi7jc5yw
	 bUxVkcBV7NaSlGefH3wSUBmjEl1Zx7Tkx9/Up3mCzgTbEOUQ1QLcpb1T6U5juUWsFT
	 g4SaKwzGMgBiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5B1080C9D;
	Thu, 20 Aug 2026 13:08:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FD0839E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65E5E40291
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVfO1Q_wx6YS for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 13:08:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=SurZD3nU
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12FFF40051
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:00 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B3C753FCA9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787231277;
 bh=TXl99Fdf+kdzsa5sbJmMB4jVzMIwuvGdbTgNwPVb21Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SurZD3nUlKAHLwvJ3dRUvQpS3YFLGz94R/PTSRvcoAsitkidspoGmgwcRqACK3d1D
 fKj9nOcfa2RJQXL61L8dADcLgeKQSuUQM+tMbbv4v1ORW3P7J+GlbfXNHc3TRjg1b9
 6NcT6GZ4xc3J6V40xkeKtigxegcXesH9nsqx73ETbz+PvWYkamysCYHXXA5YHU7eV1
 jqX7B0OB9vp85LpVpCH+A1IfYRk8KQIAPCTEWomlxCQeSTmwGO0p8iEIa7RPzY5ce0
 z12yI0kfmTvnr0ICDAluJN+S3k8OE1rbigsZen4YG8g88w+3r3xqYWj1z5x0UY6QqZ
 YcUVd200f7c7p8QeWn9ECzGWd2b9/xVq5yTaqfV/IwXDSFpAXqN7BsMVZ9DpIV/2ky
 Ipo2Anv6AYJYKRNIEzSrKmzHozDSbKAyW12bNL4LibN8T8XV5S+dU+yHA/0rMEu3b+
 njGoPI2a7nW79pA0+7of5ukHL5HpqX6rl1p2mPgvCM1LJxIyEAF4NPpglSUdDRZNAE
 432MGTTv3NNZYjV0iCYwHTQrhnwdZa1RQKTVgOsvfS0aPiXqx9wI1/n2Bk7WTsrwKB
 9PQRKFVwD/HMFuUjMUgbJf1wQTcNn2wL3wLqEhcxdFKW5Q9jO1fYBiAheCFEVrXQTV
 HjHh3IORPrjFBV6VeHQ0veZI=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f753a0aa0so1363227f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231277; x=1787836077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXl99Fdf+kdzsa5sbJmMB4jVzMIwuvGdbTgNwPVb21Y=;
 b=jgm0IPGjYg4CrabMBP+1Xnw1ZJmMRjZd7k9bBviBaDqsrAk1Es6Dky4rn5TxeIS6xq
 syRGrYnF0rTY5JzI3EzKf7BJ0nS3jMWiO40HPLEGAxpIY9DvNu4pkHiQB2adJ5Yw16Ju
 D3JhBLsQaMRy64V3dcxKgScrq615j/4XOfTNb9pTwjpOxs/2S9D2hO+gLyfxy1IEJHvc
 wWmAQB2CrVbRqpH5nJHV9nVpq+EeDbWhM3dbwiofvzM98Fw8K91lwYHRSx3+CxkDXX4s
 y3f9Q8MwvKWhhvcV6hyAErcICfUtbJT+XZEw3wPiEUt6rvx4XBr0dQ+wOyvTsOC/DSu1
 FAHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqty/NOPbaDkufSfWcPTtMWItWgmlfDCbV3OYprjqJGUC7wfEWOntDiB8qqT+w3DD/8eWCCJi8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz33yl01XC4O8d6DECZem4ncSivmJzzGKfCyJm9lG8351Zi1adW
 FVQoR8ihupQe9ILmzN+LKJ8GjyuOSAGJRxwrz5iQbwGS7RfEFKy5gSGeseTFL1BxShYZOMeTq+g
 2dYviWu7Xo1JgwklvWoGE1028PBxZ10t4pN3/SIw7El52VUHp+U2qoMtpoRPhSgAQ4NHI/SsEyZ
 UFMEGeZPY6UA==
X-Gm-Gg: AR+sD13evu46fw16/D3dIz/BuLPFbKFFD+BfxLqGqi3FC1e3uB5tRFbl/X8t49iVard
 Wvmf2kEOZNqEq1aC5oP15v1bIslAAO1x1kbJ8wV7XsntUO4ti2f9sBKzvugYtAjVjg0gt9lCOif
 SirHrLoqj4VNiJRR1nKNkbg640b1GFgj49vZqZf6vdDLpVjbCvX3+3pAQ88B/I7jyPMNB6mV2im
 G8JGiUmWoAGLYGDKRlaci9TblNBznRJsYVwHaQKhrLp9hz0aTqEftOeMFscDGY80b25UFpNy/Ec
 ZABC+hlUMmOP2mD4iViNvRK6/TOO2PBUUvo5dqO40BoP2MzdbL5xK8W36nxTWObpoLBHlLseZZM
 XnH3d4/mEAz2M6f7plHngHRow6w34g8pcZZqMwfURY2Bp932UHjx+odY=
X-Received: by 2002:a05:600c:3586:b0:499:a660:f926 with SMTP id
 5b1f17b1804b1-499aa1a2806mr234501585e9.11.1787231277319; 
 Thu, 20 Aug 2026 06:07:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3586:b0:499:a660:f926 with SMTP id
 5b1f17b1804b1-499aa1a2806mr234500795e9.11.1787231276914; 
 Thu, 20 Aug 2026 06:07:56 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:cba:879e:28f0:3c57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm183722785e9.2.2026.08.20.06.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:07:56 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] efi_loader: fix GetRng() implementation
Date: Thu, 20 Aug 2026 15:07:44 +0200
Message-ID: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Use EFI_PRINT() instead of debug() to correctly indent the message.

The return value of platform_get_rng_device() is efi_status_t.
It does not fit into an integer variable ret. Use variable status.

We already write a debug message in platform_get_rng_device().
We should not repeat ourselves.

The RNG device was available when registering the protocol. When it is no
longer available in GetRng(), this is a device error and not an unsupported
algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
return value of GetRng().

Heinrich Schuchardt (2):
  efi_loader: in platform_get_rng_device() use EFI_PRINT()
  efi_loader: consider type of platform_get_rng_device() return value

 lib/efi_loader/efi_rng.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.53.0

