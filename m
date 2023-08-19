Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCD6EE499C
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 03:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 793778687F;
	Sat, 19 Aug 2023 05:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VHUWw05V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1AD869C1; Sat, 19 Aug 2023 05:53:47 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDD886751
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 05:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E5C53FAD4
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 03:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692417223;
 bh=ZD1H4jhgkkTADDjkqhShjwN9sw++WlLYk8l5+Ys9jiM=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=VHUWw05V+x3OS6Tr3yMqg+06h1lDIDmrbRIKmyFhVdswScda77XtKEwpC1lrKDH1p
 ih5j8oXgkiDgk+qdGVzdWRLzGeFKixj5wZhqkDxBMlNkztP3/EZLAP1YU149mBhq9A
 IBS8G0CYnpD0rGJC7O5RGvkU1RE89Zr2DoqDFADlJzVYCfies2KUHMAtNfbyyIiP13
 ELRPxxOSdpUuHRcyRANn52Q71ZX1M1oQjaAEVKgz+6Kbw8ERIjsq4YPptq6lnCYpmf
 SDJ3JjzI/Kcor1oOE9JEsdzXVqV2i9nAw5xaxJirzwRanfUPhCODEg98GA6oExZ7mL
 VHKyU9oLXABfw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe517ca810so10525845e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 20:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692417223; x=1693022023;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZD1H4jhgkkTADDjkqhShjwN9sw++WlLYk8l5+Ys9jiM=;
 b=GQYww+fnI5F+TRKFek9NQFoC4rFZ/b3KRXpv0s3FcQtxru8UzPTcDqj8VkN5qJU/GE
 5+vNiEUpZMNKeX2WF3fQvJ1YEcLycd6xbdkIrLJ3I2RhS+9tQdQLhNmueDkt6nkOYkAp
 EZstr/bVfYnzAMYSHEG6n8G7vtogobrqTZb6HpyBqcbcqO7QpNFRfwPmgVA3Q1RCNHz6
 XD3pRKR2+FVfl1rbvjRbQD3kd7FBGcBii1OHLD8Nt5sck+3+PSLdxiDmk9w8ptuYU8I0
 4QRebwUOmR0fK/es+CCtsf+GlJLL0Ge/BEce9x5jYdTC8pQXLs7v+/fWN3lgGYwGHRoh
 hJvg==
X-Gm-Message-State: AOJu0YxNUR/rpttHHZ2HRR9Umb56NiRn+w7rlXv2ZiaPLaiOqYNeRS/o
 IMS/1J3ix/G12hhaz37bi9DGBI6sTp4WUC0AJy+QXIe6KRTx73I/GZmlIGN5k2Cblsk3tY9ncJr
 WhzEohCmTLUNdSQzqZALTIIMVBtxHAp8=
X-Received: by 2002:a7b:c7c3:0:b0:3fe:795:712a with SMTP id
 z3-20020a7bc7c3000000b003fe0795712amr646333wmk.27.1692417223148; 
 Fri, 18 Aug 2023 20:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5+0mrg1gqe3aj0F0f87trzGdyDt+XcrpzEF2vXuHbbfj6H7xqGXu1jMsKEm+3hZb1g0SdYw==
X-Received: by 2002:a7b:c7c3:0:b0:3fe:795:712a with SMTP id
 z3-20020a7bc7c3000000b003fe0795712amr646322wmk.27.1692417222639; 
 Fri, 18 Aug 2023 20:53:42 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003fc01495383sm8364959wml.6.2023.08.18.20.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 20:53:38 -0700 (PDT)
Message-ID: <bfc45c31-83b8-1011-7832-eff51452b2dd@canonical.com>
Date: Sat, 19 Aug 2023 05:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Puhan Zhou <puh4n.zhou@gmail.com>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request doc-2023-10-rc3-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Tom,

The following changes since commit e34efcf51df86eb2b07d9deb171596940586c666:

   rockchip: rk3566-anbernic-rgxx3: Rename defconfig to include SoC name 
(2023-08-18 10:25:03 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/doc-2023-10-rc3-2

for you to fetch changes up to 951d63000e2daf8b128139cfed343fe2b2da5a93:

   doc: csf_examples: csf.sh: Remove unneeded export ATF_LOAD_ADDR line 
(2023-08-19 04:12:53 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17431

----------------------------------------------------------------
Pull request doc-2023-10-rc3-2

Documentation:

* csf_examples: csf.sh: Remove unneeded export ATF_LOAD_ADDR line
* printf() codes: correct format specifier for unsigned int
* Fix typos in clk.h, irq.h.
* Correct description of proftool

Other:

* Quieten test for erofs filesystem presence
* spl: don't assume NVMe partition 1 exists

----------------------------------------------------------------
Fabio Estevam (1):
       doc: csf_examples: csf.sh: Remove unneeded export ATF_LOAD_ADDR line

Heinrich Schuchardt (1):
       spl: don't assume NVMe partition 1 exists

Paul Barker (2):
       clk: Fix typo in header comment
       irq: Fix typo in header comment

Puhan Zhou (1):
       docs: fix wrong usage of proftool

Siddharth Vadapalli (1):
       doc: printf() codes: Fix format specifier for unsigned int

Simon Glass (1):
       fs/erofs: Quieten test for filesystem presence

  common/spl/spl_blk_fs.c                | 6 ------
  doc/develop/printf.rst                 | 6 +++---
  doc/develop/trace.rst                  | 6 +++---
  doc/imx/habv4/csf_examples/mx8m/csf.sh | 1 -
  fs/erofs/super.c                       | 4 ++--
  include/clk-uclass.h                   | 2 +-
  include/irq.h                          | 2 +-
  7 files changed, 10 insertions(+), 17 deletions(-)
