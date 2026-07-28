Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82447C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C858608D7;
	Tue, 28 Jul 2026 13:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4DfgcqanLNo; Tue, 28 Jul 2026 13:00:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7636B608D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243604;
	bh=6iLgklbB9rgpnabiT2sJlzDJHKBuQ2w1eeMcTCCoDhM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lmrVv3R8nNLHW26Vft6o7b/N03XRsE/nbwem5n2UijERFfrty/J/dOWisB4pzmtuB
	 05By4n13FQEQwLeBWJivRkAHRd9iNkpbw6COPQAuxawHUlAh29PREAaN+uqh3VTj1P
	 PlAB9Y7RQQsOrfpPf/9dYRmMDa7q5svduG1WSe7PBx5TuwyU7uJQvDcjwtMpYJoB1i
	 CMqeaMJgK8RHsftvG1iH0Q1WbPhUCEr8yDupBCGdN56wjn+uGlK/X1MifvcylQ1oXW
	 /XEoaY47cQQeu13vl1XfIRWvgz15GgI629HFkuoVpe3Kljd4lef6hvNKLXW3Oy3VWY
	 isgY+EehuxyYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7636B608D1;
	Tue, 28 Jul 2026 13:00:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ECF48350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB6154087A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CxfaPMM1S6n for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:38:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C902B40871
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C902B40871
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C902B40871
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:09 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69f7130b47dso6184166a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224288; x=1785829088;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6iLgklbB9rgpnabiT2sJlzDJHKBuQ2w1eeMcTCCoDhM=;
 b=KEG4Q2psz4zO/oIz0yRz2FFAWCglmhg8aoCbouJy9HiI6V0EhWFRRpBgg5I3ph8YFP
 qpDFzVGYMCfmeHqZUK4E179xbYDa+GaYwi+BEdnQFv1cqi3KByc+tJWr/c0r4DwkIMmm
 S0yZQT21mUasMvh7rhSjmgA3FpBw5PlUvGrERSFSh7VW8qX2sc0q/pI1yKn1UiE9414Y
 pkjL8xQ0eRlPxL1I2VyjeK2kNT5xuPv2wVV4sk8edbaYo8ZmzArx06+EKtxhuRJmrW5A
 vDwWMOUB5lRAOHpR88aglpK98XT7hlibwI/QGL9njubECQ1u938IXgKZcfRAM1VQT/1O
 aH/A==
X-Gm-Message-State: AOJu0YzMdYqmJKxYJyUQtB8xig6Jza9E3d7Tb05ef4hbYGEeEpbMB7iJ
 5yUXH4fMFM+ZsksqaaODGBAwLuvSgR7mCXenaNGCjOAF2jT4ESiey2gHxHDkSNLQSJ4=
X-Gm-Gg: AR+sD13snJrySWnOD0bgYF6YA42t3eHfF0yoQGCOwpNmmInCyB/Ng0+RMa1CyC9pxnB
 58XXoI0yhpmD0OymyxaJ3hyX6Nzg+fe4iwcM+xqvvCRps0q/t7SeBqazzlE4mxOCNcGRPWgyHlc
 HI9JcBsn/gpa25FjbUVdleJ6xRxNTtgEGmlk71PbZk8ceMjeAHNRPI1VzS2I4mNy3lKqntj6Zc7
 nraXnTWs0Ug96BD8Wazi0HOTKyIm+gkAM3elD5W9qifO9zTh3pZDDGlPS6K/Zg5NyNURlbyjYRe
 y8p1t/dKFBS3TaEQirM6t17B3/NzDpo4pVylBeWIBTOZvexsYJCnMVdXW5zGMJkZU/aOv0oMHfU
 Xq89AWmyFwFOb09ttFuuEm5oXo63m0Cy3O7SMlEKGQWkCANbnM3191cbE1rwZRMSsNtlgxKVG2/
 zQyC79QLYi8U2Owgw593PX3qRGb+xbK8ST6w4zKymV8K+DPcH3kowthtKP2t7HqsKUbU8=
X-Received: by 2002:a05:6402:20db:b0:69f:c197:9e8e with SMTP id
 4fb4d7f45d1cf-6a034a345e5mr508896a12.14.1785224287782; 
 Tue, 28 Jul 2026 00:38:07 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb50bcfdcsm3654045a12.3.2026.07.28.00.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:38:07 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v3 0/2] tpm: bounds-check device-reported response lengths
Date: Tue, 28 Jul 2026 09:37:52 +0200
Message-Id: <20260728-tpm-trunc-resp-v3-0-8e20bcfb64c5@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBcaGoC/3XNSw7CIBgE4KsY1tLw6suV9zAuAH8sGtsGKLFpe
 nehbozG5SQz3yzIg7Pg0WG3IAfRejv0KfD9DulO9lfA9pIyYoRVpGYch/GBg5t6jR34EVeVkFx
 JZag2KI1GB8Y+N/B0fmc/qRvokJXc6KwPg5u3x0hz7y8eKSa4ZrIUUnNihDmqOYCTc6GHYrqjf
 BDZJyF+CJYI3tCmrKEtW1N9E+u6vgC5YozjBQEAAA==
X-Change-ID: 20260723-tpm-trunc-resp-664a3babf1cf
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785224288; x=1785829088;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6iLgklbB9rgpnabiT2sJlzDJHKBuQ2w1eeMcTCCoDhM=;
 b=cDwQQij7z3fKIMx8a6N2/6F9clh8ejG4YA22aVTz9YAB9MIJPRYQDOu3fliRVPRPr6
 IJ7wI5i8jj8F2HxtT5VaCScdTWn8pywmjf8GQYVQt6/RF7Z9Iu3KYihWxmMWVnMsz0Fi
 VWU0sFDdMiEulT9bL+CGehruWn5YqdSCvmN1jgFbAh3E6ZFByUm3pibPHO+ZdZJo32Ij
 oN2oV2oOD6dV6UhrSiw/vq/MvFebn7hCejN4lKf1UcIKPL5vjHzVK3jRChc25KCL8LC9
 pkAPe6J4s1l/fD8dvedsjVYPjIWeFeGxnPeRHDP53nLoGB8CiPFmLRTV8S05xL45Iqf1
 i/qw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cDwQQij7
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A TPM reply's length is taken from the device and only upper-capped, then
several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
GetCapability parser subtract a fixed header length from it, so a reply too
short underflows the subtraction into a huge memcpy; the GetCapability
parser then copies that many bytes into the caller's buffer, so a reply
longer than the buffer overruns it. Because a TPM sits on a physically
accessible bus, a cheap bus interposer (the kind used to sniff
disk-encryption keys) can inject such a reply, and on the TPM2 path this
parsing runs during measured boot, which is exactly the physical attacker
that measured boot is meant to resist.

Patch 1 checks the reported length once in tpm_sendrecv_command(), so every
command that reads a reply rejects a too-short response, and keeps a buffer
bound on the GetCapability properties query. Patch 2 adds regression tests
driving the parser with a truncated and an over-long reply through the
sandbox emulator.

Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v3:
- Rework per review: check the response length once in
  tpm_sendrecv_command() instead of at each call site, so every command
  that reads a reply is guarded. Drop the per-site lower-bound checks; keep
  the GetCapability buffer bound.
- Drop Miquel's Acked-by, as the fix changed substantially.

Changes in v2:
- Use my real name in the From and Signed-off-by (Miquel Raynal)

---
Shahriyar Jalayeri (2):
      tpm: bounds-check the device-reported response length
      test: tpm: check malformed capability responses are rejected

 drivers/tpm/tpm2_tis_sandbox.c | 28 ++++++++++++++++++++
 include/tpm-v2.h               | 10 +++++++
 lib/tpm-common.c               | 16 +++++++++---
 lib/tpm-utils.h                |  8 +++++-
 lib/tpm-v1.c                   | 59 +++++++++++++++++++++++++-----------------
 lib/tpm-v2.c                   | 52 ++++++++++++++++++++++---------------
 test/dm/tpm.c                  | 42 ++++++++++++++++++++++++++++++
 7 files changed, 166 insertions(+), 49 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260723-tpm-trunc-resp-664a3babf1cf

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

