Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F35C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A3481D6C;
	Wed, 26 Mar 2025 13:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HGQjfRJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B5981D27; Wed, 26 Mar 2025 13:22:18 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276478070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso11851242a12.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742991735; x=1743596535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pTnpqgLkQOGsvd3yBRDtM2uUqak1eOUhJpP0AQvZc9I=;
 b=HGQjfRJcraVoWyBsQ9ARgTEjgXETgKoSx92wQgPKeBbhIhtQXIVfBbKqTQStG05r6W
 vDUn+x8Cdk/fj79grabbbdrwHGqw/aOrPrx8IHe+D0QBhYGALRWKD+SvjQU8/6gkpaQA
 G6Lq7XzS/rFigkNOCWg0lBzq7WlDjR8Fj/yBobKX/jdtgU7meUMBPm1qamFPWbKuUFd2
 VSZJJ90WewL6cV2yqA7SCCIi1qYjUV3jVaYy2srDdZJDiRAXDvlACNyd1nQzyKUicFw9
 jLUDXfg/n87PmI4FkYS54G6PxUhs3/zMmEValxWo0kyijScJ6zGRcpWSV6y4fdAKtiN/
 IhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742991735; x=1743596535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTnpqgLkQOGsvd3yBRDtM2uUqak1eOUhJpP0AQvZc9I=;
 b=W0jbvMKGi2pdqUH15xTE8O2pfV7jWIRrU+XNF3CVbXtPu1/PrcwyurguAs9zd7l0uI
 BvThsao0I8Yi4u6Y6CkxQcs22zpPvxJBI68i7B5dBLlDu6mgRvRpopmFy/yqsiGQY1pF
 6XgcEkTg7aVWF3lfMHHeEpb7CS0VQy2Y6gMR8KkZykr8xswqZ/eCTTIt8bDNAyfRuqBv
 nvKePTL3kmq+i7qEBNnrOuHoKYOgbpZxut/pV74I0LlWEsb1pWfoz8RlXEuQo6tFWvBY
 A49GlreVLYoJzHXyNgUkBLeycZgerwH474ZMqj6nTLHexAPl9oUKHehYtXJjKB/sodzE
 Tbsw==
X-Gm-Message-State: AOJu0YxA/QnkqiqWILQs27tso/lhR7H4s5/7EIZHJrCuydA57y7GhhKC
 qvHmc7+Jb0HV1hNLIplAgJeCNklN6Np+VFrYS05A4NXYVTSo7UKsUS6puFpXwWPq2+ELmvPjEZ8
 A
X-Gm-Gg: ASbGncsChLsJ67qjhpqBFvTfj85CtbrAiZJ+/6bxVd/QRdDaI/HH0gSsHlcvwYewR8v
 GyVjjm5X2meU3uTz1YIoH+/Q3/+cmRMYbGo1ZibfGp8cS6boCnZ7BJ2J9iqVnT9j+xuIdoYocHq
 E+GCr1CjO+8EhTWcIRGLWaXCAdNROIg3lIzSYQS89YInDRk8emwoqnEVlp/pGrkceF7aoCQmj5i
 BnAuFOnPEC8wG4gvnMgdgoj2SQK6WUxEhmwLmykZ9hz2kx66xKZfb5GS4eBAWTrtMRInkqTe6i0
 G5vijt+2jmfmYjZMw9oLVpxa/f4Ur1PaHCGLx+klu5ylXDGc+WegiCyrPqSV4N5cWSYIqkkvRc0
 pDrfGtN1vp+UdNL3ZYwa+8+DuHmrhyYndMg==
X-Google-Smtp-Source: AGHT+IE0oBOwOI0OyVfakDy3aYKuNanc+iPxNcoK8ay7dhFl9GZD0O24w2uQyFlr0PKnoY8/VXVS1A==
X-Received: by 2002:a17:907:d88:b0:ac1:e31e:de0a with SMTP id
 a640c23a62f3a-ac3f20f7101mr2325959966b.12.1742991735538; 
 Wed, 26 Mar 2025 05:22:15 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efda2fc7sm1010058466b.182.2025.03.26.05.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:22:15 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de,
	Vincent.Stehle@arm.com
Subject: Pull request for efi-master-26032025 urgent
Date: Wed, 26 Mar 2025 14:22:04 +0200
Message-ID: <20250326122208.893209-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Tom,

A last minute fix for EFI and -master

The following changes since commit 47f433d577a0e1e937c12bbdf632119f0c8b492e:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-riscv (2025-03-25 11:55:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-master-26032025

for you to fetch changes up to 4b4d24060ef5ae99c5dca12f39433edc7ccfd741:

  efi_loader: fix ipv4 device path node conversion (2025-03-26 13:05:36 +0200)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/25335 shows no
problems

Please pull
/Ilias

----------------------------------------------------------------
A last minute fix from Vincent fixing the text representation
of device paths containing IPv4 device path nodes.

A missing break; ended up printing
IPv4(5.6.7.8,TCP,UDP,0x6,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)
instead of
IPv4(5.6.7.8,TCP,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)

----------------------------------------------------------------
Vincent Stehlé (1):
      efi_loader: fix ipv4 device path node conversion

 lib/efi_loader/efi_device_path_to_text.c | 3 +++
 1 file changed, 3 insertions(+)
