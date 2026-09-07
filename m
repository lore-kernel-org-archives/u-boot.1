Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC7AC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECF6B405B9;
	Mon,  7 Sep 2026 13:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0bjFyKMjlyQE; Mon,  7 Sep 2026 13:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 49ABF40546
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788786183;
	b=TZrMi9FNpwUip0RdKnvlYVjF0w4sic49n4xJpWJP20U8dIJUUcdOUoNWUnrdfcMeQGGi
	 0JigpA6Z89oaaXSSpJ6iUWN3bG2K85jQsfZQQm5buqe1wexIbFg9xsElw1q5OiIBW76dd
	 CG405OkjkeTGkAi0cQRH/MzdnzxWJ+QyYkBIULG8GSkcoyOBo3YYNcwd4OoiqAM9wJtkh
	 Z1IQ4VNnHl+cxf9n+Otccm7xBphfxyQrV91AIiew+AhN94l3x9JN/R0MK0sB16uEbePoD
	 IQoK8osgNuu+DHHcR/NarDBe/FSs7ph0pjlqkX81bP2VK7XC9BMDrHqjDbmy1YnfKag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788786183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wLp55qx/C1FvF/3rcCejdOrXqYQuPFdAgs278QxEJ+U=;
	b=JkL1sCMvsofAKEwzzASIdGvs2k0zoeVYWGHjQVRKCuFk4W50AHOEfxFSu55i2GOqLbAI
	 DmVT1eNPHwNB05wAUj0AHxJ52f5luTLxTEivm2tpITdkY6BP7BgSUWILfcXo1s/gDLwVp
	 CBHJ/SF7NhAnUmGDYsFaSoacD/lJjQhTfRp92FZphxvoP4EtQBIjWm6AWBE37hAKFWNVN
	 R2DH82PtGPdpG8alyUEM1fyZswWdEdHm44DoGs+J7J7qG/71NtZkd+zdNddkxyUinj+2b
	 JHFvMsy88wv8LjKdM8TmW9pZA6DL7uCpFsoq2nKlqSN95C7woX12xNQaD5sidqBrsGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=JtRpyWdN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788786183;
	bh=wLp55qx/C1FvF/3rcCejdOrXqYQuPFdAgs278QxEJ+U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O5K1/OTt0FqG3wisNVEPUqY0nIKCRySQU+C3ZZ/D7pb0JYDX3lgN1CF9di3FbnknF
	 kP4XtlhP/kBVPFlpFZCVQmCg2WMkK/RBb3kWkmHa4sfOMRPTU2p66jfQsYHfyoYqWe
	 9nFcxTlqScRk98xPfjWuwPUhrkXOKFK0SiQFvh24vPQwZ3yF5EVuIR2QqkHakO9dU+
	 +XWMTz7Fm9i7Skg2OmJK0C8/DjCwGV/8eUfFq1KqlXMOYcQXe7g2FH7w1CAb6IJevb
	 KrWzgqo2fnx+BXpdhafF/c4hC9s04C3N8qInrHU6z93EDT3rpbSSw0/tG8muk7PrLD
	 LGc9o3GOlyDGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49ABF40546;
	Mon,  7 Sep 2026 13:03:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9A58D5F
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B58B40521
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HdEpjxfuF-bT for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 07:43:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C066C40402
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788766980;
 b=cFD4IisYT8IExRzlFUj+nLPa7Z13Rh/QPDTmhdT3ktOlgg7wl9kaTvIO1fA7bliM7geD
 peGSy+GXmC1S7w5D6ffFmOMQitjM68KARuIk7NRf8YksEiOXhrPam8ULaDEvh+LBrMEaK
 AYUTVP9rMYhvkzFHMpN6kaQ5o/cDuSXIspHOFZvfhIMQicxXaHl5OqVXxDpiFqo/6SW6b
 AhXFdWE22m/ouHz7bkt5f3q6LazVeEfxGv12Co9EnBqKage8h4kXC4tXZI+jGCTu63fwK
 PTFuUXS0OpS5XruHy5BZlwsUkqyOIrD+w+1D8ENeV32b79zO0SyUfHf3qYZ3BQ77Qtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788766980;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=wLp55qx/C1FvF/3rcCejdOrXqYQuPFdAgs278QxEJ+U=;
 b=XEL+82el97LsgDz+EgTWHdWkcWJ5TMqPV9G6I2/5WVoGKkfp7QGHwMc0/5A2ZP/uDong
 5bDGzD5S1jnjt77bY+GtmFc2PvBBWzv9Y2t2jyJQrx3Yes6cqz5P9ajMmZkhwXoODc2Ki
 Pc2yHQINIZApLg8QJriy3VjvtN+XqIfi0UCJ/Uvkvs+JSlFvtFU8FFUkrCAS1vLPyP9e1
 vD0sJ9uQqx5AXgEdF+eHKR0xFRJJg0zTmHFFTzd6abCHD+lxDC2oGE8VJzT7a16EGXeWu
 UXsP2N0WGoMV0gow5sMaCxBdogAm1Rl31hI+V5tVvvS0rhZIPOOLhMVAYW6BZT8peLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=JtRpyWdN; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=JtRpyWdN
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C066C40402
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:42:58 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F25B3F47C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788766977;
 bh=wLp55qx/C1FvF/3rcCejdOrXqYQuPFdAgs278QxEJ+U=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JtRpyWdNIH71BHW+x4z4KGx/CZzOJ0LLelnwmocjdI0BuxL0Rby6+eQlJz+Ij7Mjt
 t2KgsBXoMAMLSWlXOyvO+USNXzPFcgqX0pnSE+Ah7vgvTV4fb5HMtVhwEqyMRtLCUL
 CcJfpcplE8zl+SPMLBCn4V+GgezND2EKo6jWZ6lWkaCCOXupfbYUriUwkCBdTs1d6a
 HHqbsxF5fcTuIbIEDp5iEowveI8qswCmrVHlxiBg9xUlNoEibFGV2Tr5604QZJceT/
 +pOTMyH/RtWQ76XO2xST0pR8+Lc0Qo8qjYi9ijkDsBxcmGAh6ZQtJEQv5dqhgVSg0N
 o96WIz1MmGazvCvRqR/csIpgFDXAr1Wa8hb8LPZGQuS+eqXWa0eA/TSAEeDmKfAnwC
 OrEciTHNjTPBORlcGi2JW3EKnKFD+p+xizh8VgK0rXBHWRZSuFVoPFCNFFhCMWF0tw
 Kf+EQvDSMyr+WaXuwbui5MOpU2V5S1CR8oJ2XiQcCSbPROZ7PA6Edqn5zcdLBuBP/z
 n7NHo7JgC3pWeH4ZoZRzudOxIbnU/WV9bPrc0zOqNSr+ucUvVcGMUWNr0t2Uu5uOlL
 aI/8y3X2mI8KUmOWfTNGT7+EUpf30m8qNmdkx/iRqlgZ8wyLJW1PAjszm3D3T0Lher
 NUOAUZSa1TzK8AVYORRzH+x4=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so3372062a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 00:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766975; x=1789371775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wLp55qx/C1FvF/3rcCejdOrXqYQuPFdAgs278QxEJ+U=;
 b=l+whYxqh2ToxKC47LNkOqMrUjgcsOpto1rFG2RSiNsRulRXesxA7VSSUIFp1dROWDy
 Oq3cJKIhOsZRdndL6CSDmJusf/alpoz3cg6c/PE0z/leH3l/uIzoBAL2EqWrYoIq91xW
 qjn1EAq5njrN9qpMhxcNBE4r89AsBfcAQe94ACV9Yh5qCdI0tb+pe4WXlD6dK//Ob3US
 N3Tv61+EFkqLv/LSh9inAa/km48BPJ+omEC4CHKfD7me/xwbX3Xuld1U4/XJYCtofLoP
 R8xrK9mCp+Lg9I7bIzJpJvFnnobNlcpIq7VIEQkmBYhGUYhx47cssU3tQb+BIRAdLfQp
 poWQ==
X-Gm-Message-State: AFuF++l7UBdPKuFMKVJVKwLYTTK+QuNtmKBLyteqm14i7+MeJtZWWY71
 ACQdQwztUh1R7NVcwHAjqIgKpRuM6kubnhY2Spi7bQd9CktckSmhM6OpBek3Us3ZILwEGD6l0oc
 L1WWit93fA3YgJdkpf+bwhr27PFYflqw3zG9qrtcOKB1XW9JFSSx+d0oA7/1+RHCD44gnGEsqaZ
 Y5HpJtOOej0f5mD+Kt6Q==
X-Gm-Gg: AYBFou1kAux7L8aViHei+7CUUQnjiaVJUFrN4UwaHNOzjL12BxR6u6/NBZyA3t2kicx
 N5kqgggExmBJtetpnHv4IbuQErvIJZXpIHB2duJ34iRL/cm2cK2K8z64aWXJ/Og5RU1Br4IQ8Nm
 HrK3xDmF4yuxOyXG3wBLRVbky9jt4JggwaR3ncsNylVuYSUd5jzPQjqvQ7p9gD4nWNUTK96loqz
 RSy22uoaF1Go3wW+rP0DeG9njR+qubwnkceH3s8vwIVhLKDwdkpRINO2Mrq8wV6xBr6sl1soT/X
 2aam6ODvoqwemyrM3oR/IWBsqUhz63xhvCUT7HmuIS7JKzjsg5NA4SDVrIqRTwXHbS7wg8qi/AN
 4AjP3yeeg+zbFqYGtajbURRsTcrAnauhYkNAM7+uxcNS+6vM=
X-Received: by 2002:a05:6a00:4f85:b0:845:ba94:a56 with SMTP id
 d2e1a72fcca58-861679a6485mr28625995b3a.5.1788766974420; 
 Mon, 07 Sep 2026 00:42:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f85:b0:845:ba94:a56 with SMTP id
 d2e1a72fcca58-861679a6485mr28625761b3a.5.1788766972248; 
 Mon, 07 Sep 2026 00:42:52 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615292d875sm3974215b3a.25.2026.09.07.00.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:42:51 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] bootstd: cros: Validate keyblock_size before locating
 the preamble
Date: Mon,  7 Sep 2026 07:42:16 +0000
Message-ID: <20260907074221.3718-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 13:03:00 +0000
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

The ChromiumOS bootmeth reads the first 4KB of a kernel partition and,
after checking only the keyblock magic, uses the on-disk keyblock_size
field to locate the kernel preamble within that buffer. Nothing bounds
the value, so a corrupt or malicious partition can place the preamble
pointer far outside the allocation, and every subsequent preamble field
access is an out-of-bounds read. The values fetched this way then drive
allocation sizes and disk offsets. On sandbox, scanning such a partition
crashes U-Boot with SIGSEGV.

Patch 1 rejects the partition if the keyblock claims to be smaller than
its own header, if the preamble does not lie entirely within the probed
area, or if the computed kernel body offset falls inside the probed
area. The last condition matches what cros_read_kernel() already
requires before reading the kernel body, and also catches a
preamble_size that wraps the 32-bit sum.

Patch 2 adds four malformed kernel partitions to the ChromiumOS test
disk, one for each rejected condition: an oversized keyblock_size, an
undersized keyblock_size, an undersized kernel body offset and a
preamble_size that wraps the 32-bit sum. Without patch 1, the first
crashes the bootflow_cros test and the other three scan to spurious
ready bootflows; with it, all four partitions are rejected during
scanning and all bootstd sandbox tests pass.

Aristo Chen (2):
  bootstd: cros: Validate keyblock_size before locating the preamble
  test: bootstd: Cover invalid ChromiumOS keyblock and preamble metadata

 boot/bootmeth_cros.c     | 29 ++++++++++++++++++++++++--
 test/boot/bootflow.c     |  6 ++++++
 test/py/tests/test_ut.py | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

-- 
2.43.0

