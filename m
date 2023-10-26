Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69368C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 04:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA39A87AD1;
	Thu, 26 Oct 2023 06:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="lLZl6m/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD8187559; Thu, 26 Oct 2023 05:23:03 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9378B86F91
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yongxuan.wang@sifive.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso425328b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698290579; x=1698895379; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vg9FApGKDm1saRj+vLvro2F2eNAzps9ffPwjIpeHg6w=;
 b=lLZl6m/H3pYoTrwqxmUqeSvFdaw09MECF1g1R8Ofok9JNe9+BRfJIcbh16aUmH/6bu
 +rv6kyIfntcTzYQjH74bAvvCKz83r3T8nEy0EC3RIx3vrsNIWubff7bvKzjyMY0MRZB3
 xnpuYEAT1u5jWS8vbulzgnGOx4NqRnFKXIg7uG+Pnsl/8buRePTWJ8KOdMqzARWq6ACM
 Po087jefjsjyeOZdKrUm+O6v9/1aZhJNrZof2pmKYXgRlR6AfMLevMWO/Ljd3b1JQqNR
 VtDPBJNw6oniUA9PORPDLvleU9rfE5WsQPD2t5EEEpggyTseAwkIySIbC5ab66LdkgKL
 7VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698290579; x=1698895379;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vg9FApGKDm1saRj+vLvro2F2eNAzps9ffPwjIpeHg6w=;
 b=hjfBrm+ZLUKesEgKPrjkHwoJflWynbNzl70cajo1gcVmQkTy8DuxrrHw64j6C8UOqc
 nNDDQMl15d5MucwG3MkI9S3nPbewJ6/YDAwAjg2LC+uGMIRITBbl+SgccTNz9aJIe1mV
 0tMZmLrlqqV/qM0U9AQ0OITTOO9xBtTM2TvvKKbBDvngdPi3xdNn2KH5O70ZIJfBGvsH
 KOFpsaOHy1mFH2SRPTS2oLw1vw3xNGQOFCS5REtkr5EcgBOy3EAmA1iqlHF2b2A9A+3r
 i8f1NvPn7TAx62IgSx8HnsAhSyEEGSGkCX/be8CfyLFnRm0SwAhuiQSXhfpUHPtDOJl4
 /QcA==
X-Gm-Message-State: AOJu0Yzsz5iASY0nQdgIeoQFW857tBS0mrt7z8WpCjjc3j2JdTLYxyTn
 ib3LujdvzOKb2pvg4ordD5/FaRC5CXSFlP4iNY4uq1ErycP8HNhf7HO2/HuuzTZx8RbvmG2TPHV
 K3XpWy7QwzXDl+Iu879mAB6rmX1KbcLQmBD1R7zCeaQs+A7Ua3HzHrJcdR1sAqK9buuKqTLH7TP
 EJxg0=
X-Google-Smtp-Source: AGHT+IGX8wTOVlcOiqQNGkROscSPGHHmf0CC6NTW5LV1rK//2+kMLMmKwDEtgHF7Y8B2BBUgYmGPYw==
X-Received: by 2002:a05:6a21:66c6:b0:174:2a38:9d9c with SMTP id
 ze6-20020a056a2166c600b001742a389d9cmr8161194pzb.57.1698290579246; 
 Wed, 25 Oct 2023 20:22:59 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 15-20020a17090a000f00b0027ced921e80sm665782pja.38.2023.10.25.20.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 20:22:58 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: u-boot@lists.denx.de
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Subject: [PATCH 1/1] board: sifive: unmatched: move kernel load address to
 0x80200000
Date: Thu, 26 Oct 2023 03:22:52 +0000
Message-Id: <20231026032254.23043-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 26 Oct 2023 06:23:24 +0200
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

U-boot initially loads the kernel image to the kernel_addr_r, and
subsequently relocates it to memory address 0x80200000. Setting
kernel_addr_r to 0x80200000 can eliminate one copy operation.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 include/configs/sifive-unmatched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/sifive-unmatched.h b/include/configs/sifive-unmatched.h
index 74150b7d4b..de8bfc1123 100644
--- a/include/configs/sifive-unmatched.h
+++ b/include/configs/sifive-unmatched.h
@@ -36,7 +36,7 @@
 	"name=system,size=-,bootable,type=${type_guid_gpt_system};"
 
 #define CFG_EXTRA_ENV_SETTINGS \
-	"kernel_addr_r=0x84000000\0" \
+	"kernel_addr_r=0x80200000\0" \
 	"kernel_comp_addr_r=0x88000000\0" \
 	"kernel_comp_size=0x4000000\0" \
 	"fdt_addr_r=0x8c000000\0" \
-- 
2.17.1

