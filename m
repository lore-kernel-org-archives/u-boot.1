Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB660892F2
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fu7UgYK3;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RgGuvK2J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53C2F60662;
	Mon, 19 Oct 2026 15:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5uNK64TbcSi1; Mon, 19 Oct 2026 15:30:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60E74605D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423820;
	b=ep1RaumBzIACnYeB+JLzK/DbaXCFlC1Rl5PMZdrC8YE6QHWwiSh8GClG0U8/W89GgHBY
	 iWGpfy2c3tqq08EQrln6SDHsY//9+cBRdkYOUVvBcrUIy9npwoKLxlXuRuWad6vGg5wwO
	 Ku82i5YZ8GDa/nRPaAL7q82xQM/1TUr2LiybPFSGetFPwxeJTi+whTNCY7JGESW4RWZme
	 1CtFMYQ0y+HQEIjosD/bboS8JDlfuTxVT3HfozPilS0CLg6pFNxshSCw3QzrZq7V3MaGI
	 /hHmxoR5DCPQC2Q44ziXpweLyYNfAV4KhZyoIUaKAZJmBqyCluRjylG66uSgrg2tboQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LSjiKqBvXSWMDquIrVQk0jbNp+ygh7YqJ35VkDMU+iM=;
	b=tTQ9GRQ6AlcUpEAzzsYqzuafLpa/vGULQiMOV29zPOS+NnssIVO86mmQRg3Y/+KRalIb
	 pIDU2OXgFacArC4BHpEw/wSQffqyDAbzBLLWL0i2IW2F1QSIYnjGEEUiuAceQ9ml5Z2Zz
	 1GRiNmIR6t9eANtU6PYT86CIS02adYQ5Z3xAjC91UgtKLTm39f+gz9CrzLN+aPGSyZvcz
	 zwbs7bwKHYIdDFlmEHsjC/k7JNxwGTh1lZoiGzXR0wsuC80WIvAy9tg1KsX67CVvavg30
	 5qmkyOoSirFU2WiWtk4dk9NUfS7mDpCJLm4cvDY871ANVE3gsejNDzBHv7TPA2oNu3g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423820;
	bh=LSjiKqBvXSWMDquIrVQk0jbNp+ygh7YqJ35VkDMU+iM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fu7UgYK3kH52MtKuqSFSzHd2gjzv1Gcg/LJ3fuCCBRLz7SzJdFt9o/KpAOtuXONV2
	 wODiDdTP+FPwgjUIO8ga1H0LaTWP2nsUPSA5Aa8pZvqlareOdN/KUX161bDC3Hl3Xz
	 EteS4opq1xuw5Hx5+jsAxG5Da0jfCLDACDmRRJ19U0TN1wu9oqcq0ZeKs6Yu/ik3CT
	 IrGc1yoPbUCpAgGjpe1dEauakmcb9ly6RFKjgLEYW0zRuDEcJsE2BLvZLh9JVJq7L5
	 IZ8v213bHzEDcXpbNlbXhf5bWitGsNRJsXK+Xdl5NmunosvOd+Z6L3fp1I5YtaMkhr
	 uxCguCnfSAm2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60E74605D9;
	Mon, 19 Oct 2026 15:30:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A718E12F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D38E400F9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGIKaW6gOM-1 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 41D71400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423817;
 b=QTFIuFCDIHApOz8S71D02ko84Yw6aln4YBfrpeaczy1zZjBnDGUdGQZDbNpn3BXalr7f
 bbWPEVgDDWye6nVoUlwZSoaJwTnWikTbdS2Bkm6YMpmv7x6xq/meRiGEW5vxEvOIxucDZ
 Tm3c+XZ1cPGBnKozugCgcPjnHUmVrtgArylggfZnyUNbl2E3RCTNDkd5+agft+5KTbgsn
 qas3BFsql1tK/C0aZ9EfT1P5Gk6LMJzatHZVtYynENkPDJoAOV6U+tDC3C5SZ5/PPKDBZ
 bdyZjycuAeTtbyUdCO5kWFxusqEMtrd/Avr01XKGkHvsbeSfqn28e2TPvMJVjiq62lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=LSjiKqBvXSWMDquIrVQk0jbNp+ygh7YqJ35VkDMU+iM=;
 b=OUJrKnT12AEouNuTQSpuBrowZuhkXZieLNz0HxNgEHHzk4GjA60jWGA0jVgVOyJUaaZr
 FUErQDE+rg0FTFglDeA0kHnHJHnC4mgVi6Td7vDpJ/Ug9nXJVHwCV5kepdlX9hykyiOy2
 3Cs5M8/bpQpH79iAKOxwA8A1KjqdVMK7tWufbk6tGs+LkCLh/UKAiGblZZEXxYKJ+KPGY
 fQou+L7DjNCwX1kxgXv9lYG4Sf4TfbAcGspZbVqwEHV3/qKj1v9XuifpLJZ6CNHrNdj36
 nor8n4yssWbskZ9UpI+ZNpapS09nBiFaAOjNIrSTYsy+gyJGD5+EAcZ86g0o4UN0lWA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RgGuvK2J; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RgGuvK2J
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41D71400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:30:16 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so617472f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792423814; x=1793028614;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LSjiKqBvXSWMDquIrVQk0jbNp+ygh7YqJ35VkDMU+iM=;
 b=RgGuvK2JYnYVOF48fNl5RNvuU5kyUJfyMEqmW1YbaKF4C5vguaD6PCeJjoGmkQucv/
 9hDy9REtYPd8mfiTq37i5PdN3TCfHuOdZ8oFKlrkSUDQ7gKQLJJQpMAgPgEICNOxWI9C
 r0GqHpTOwjEVSiIYoZQko4YvLt+Ri/8+lVxFtN9iEmyJBRKR9rRFAQ/tnpuRniqpMf9o
 IrrMiyFnNiJwl5G5CM6eav9c3XH+bgf9I35ykFFSt+03FekSm4k7V8S2hevwnexv517v
 TkSJVabwt83DMyMWBNAglIWprCU0Dpq17X48PWFM+nlku0KA/P4RJyCYbHq/Q1Hbk8ai
 6kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792423814; x=1793028614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LSjiKqBvXSWMDquIrVQk0jbNp+ygh7YqJ35VkDMU+iM=;
 b=AXoBD0DyEqa5aroY/bmKk8JwTOb+gCxSRaVKbnqr4HqG6vlueu8LxbbCthPNXM8tGD
 3wdjI6F+qJGGHbr8+0Zp50CQwEvZQDMfEhzruSvjVKI3TJCIr/OJ4RhqD+n/kB1sR7nx
 A5g4iAeyYSy64RboEVJ9i9x48TPVek6KT8zl5I2jFYjzuZLgJSqdjqExHqsWeKodZwU9
 rameJa2RuNO3iR/ypBQi4Mmaa6ZAEgxrJ/x4ESu3CfUI6v3TnZgmC5uT3/pM4fl2pbQf
 BSk2+9FZJHy51zc4trdV3qxhYwRFX/XF1offfMKKy8JNYGFwZKgAUDshVJnhz0jOFpWt
 Ps5w==
X-Gm-Message-State: AFq9FYI27RQR10zkYNZB6pg4cjgiGZbBTEOY9hJFyhBwzHjy/zMwYHQK
 zXM53GWcNWfylNjsJOFwbsCUlvKGQfvLPXixXXxAEp/9fDH2dw73WGWx1n0sbSOTE408Gb/Ovq4
 LXUYG57g=
X-Gm-Gg: AYBFou3AuvFHg3InN7Gn8gh04yTDWtZ8j4Uh6xKhrvAYF67HH4TYu54tzlmBgk16hxs
 kNLl+yA985IiAfrN8YnMi0X9OIID1l2jBQtDlIqD1X1nl9Ut22lZrNOrwJ3O2/eQg0RvWvNsP41
 WN9cIornzy25kAWL3i12DF3DepVt2hs/Ui6KFX2J1SrtV9/WnirCxDFP7sgxYyn9k6i4k9bMmOu
 uNLYot+v1w/kXagyPWzNjfFpXmJs3Ae22G+McPbzMQ8gWRNsFYMKjR3tE4aW3oTX1FU8yo0semh
 /eH9AYgRIP6uFxQ+8gAQTAkmn402yGcczI7m/i16Q2l2wrvYpHjq6wugfUEvIRvqq4nYHR9Yluv
 6sTQGn7v8wWvGJs7njVyZIa5teT1pd9g7FVTnw150aLE2ctyyVGsp0qyB4reDNHQVScoQvy+6oB
 VGxzr/T/a9zTfmjoi3zUAF4Il4uPkm7opansCeYbQIQlKq0lhvtfpfpJRocv5ZBIRgjQfvX36Mm
 PTNxXcL9hSDvFdintrTbXJYPK7wcry9HcbFfHl10gIPZ1M8qW8uG/NdHtI7sPYmGm+1k89uexCU
 E+YfjscEVQmgfju16qpHj6wY16JqlObf8fdE6JexEyR9C3BIOORMD1+3MjADEX3J9Gt6VoIT2aj
 40NuDMGjbF3M1wVnH7XyRSKGQSc/u7gCrqODWhBVcpjLU+YLjTnvCEs3YU2rXGJ+pIIRhuLp05k
 1/RzZmhs2Ua//A+BuGERSZbt1PSsfVfn/EPaqGxUCuMqJyHajyRWur2VSNfblo+KohrNiLz4kll
 kXwPMGIwP9vJU2zekXR9vYY6ntnsV9C+cWnM9EysUV+h0HreBbIySMrMQHxNVNZLYcyPRi+
X-Received: by 2002:a05:6000:4b05:b0:48e:c0:9441 with SMTP id
 ffacd0b85a97d-48e07f9d7c1mr17074820f8f.29.1792423814180; 
 Mon, 19 Oct 2026 08:30:14 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8d1esm24608068f8f.39.2026.10.19.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:30:12 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org
Subject: Pull request for tpm-next-19102026
Date: Mon, 19 Oct 2026 18:30:03 +0300
Message-ID: <20261019153003.3719755-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A few addition for the TPM tree

The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:

  Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/tpm-next-19102026

for you to fetch changes up to 5f6a4efb1842cb5d3193cd17bebc29748e106f71:

  tpm: Fix the size of the random data in tpm2_get_random() (2026-10-19 09:56:01 +0300)

The CI https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/1615 is passing
Please pull!
/Ilias

----------------------------------------------------------------
We don't currently run selftests on the TPM, which make the device
usable, unless some kind of measured boot is required, either via
bootm of the EFI subsystem.
Michael had cases where he wanted to probe the TPM earlier. Some boards
already called tpm autostart in the board specific env files. With this
a new event guarded by a Kconfig option can run the selftests and make
the TPM usable regardless of measured boot.

There's also a fix for tpm2_get_random() which reads the size of the
returned random bytes with the "w" format of unpack_byte_string().
That format stores a u16, but data_size was declared u32. The upper half
kept whatever was on the stack, so the data_size > this_bytes check
sometimes failed with TPM_LIB_ERROR.

----------------------------------------------------------------
Hung-Chun Tseng (1):
      tpm: Fix the size of the random data in tpm2_get_random()

Michael Haener (3):
      tpm: Add an option to start the TPM during init
      tpm: Add tests for CONFIG_TPM_AUTOSTART
      xilinx: Use CONFIG_TPM_AUTOSTART on Kria

 board/xilinx/zynqmp/zynqmp_kria.env  |  4 +--
 configs/sandbox_defconfig            |  1 +
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 doc/usage/measured_boot.rst          | 18 ++++++++++++++
 include/tpm_api.h                    | 10 ++++++++
 lib/Kconfig                          | 19 ++++++++++++++
 lib/Makefile                         |  1 +
 lib/tpm-v2.c                         |  2 +-
 lib/tpm_autostart.c                  | 48 ++++++++++++++++++++++++++++++++++++
 test/dm/tpm.c                        | 47 +++++++++++++++++++++++++++++++++++
 test/py/tests/test_event_dump.py     |  1 +
 11 files changed, 148 insertions(+), 4 deletions(-)
 create mode 100644 lib/tpm_autostart.c
