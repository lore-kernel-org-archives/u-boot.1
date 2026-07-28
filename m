Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0835AC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1FD56081F;
	Tue, 28 Jul 2026 06:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DA_8b3i9YhMK; Tue, 28 Jul 2026 06:56:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E6C360821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221800;
	bh=qpFSWdbF3KBpsRPhcXe4NmPCNDpukhHRTF8eU8+0a7M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGQF5RQvu9Oio2H8+UqnfEu/oA6OsLOrH72flkFepeyBCF/hi/nAqpUl7nE0Uag1b
	 dDYHcMbzegpRYFo+or+uDPl9SePHukbEeQu8ocwWr96tykqBbeZM1AErNwjTUd8TpC
	 5G6DJLt2Dd9Zg4Mh7LWcI8l3IXSALPlSpelLFYe8vaWRLxiZQ4bLWz1edvf1wq2B5s
	 7A1TwV2AZ4DS7qFA+FqH6xqM2LsK1cvToRIlHxryEYWBW/Ry9eIEG/JJ3eRdLXFW3x
	 n/Gt2rEAlrFzhhrTO8swkGUi/ObJI64H+Knv8L7o5rUcOj550W9VVZV6zTw/3l5EAm
	 owY68d7e/5FQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E6C360821;
	Tue, 28 Jul 2026 06:56:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 533E7357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45C9B6081F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6AFQX-iSVDr for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:56:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4BD0C60826
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BD0C60826
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BD0C60826
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:37 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c16111a9b8dso3807566b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221795; x=1785826595;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qpFSWdbF3KBpsRPhcXe4NmPCNDpukhHRTF8eU8+0a7M=;
 b=HSJ99Ee/5Pw17G2djE6jDZHBZVGS0ba78v/jsGCC1iImxJoPEAGtxUMiFrFL22bzPm
 Mw1Yd117SLFlzrvwZ6rWUfP3B/T8wig1Q0d0jKPy/CGiSMUjYf4KYvSqhatzSSTTV+sn
 2l8a5L8C0VKmWEVx3kCIePIPUSKasJYfmmUKjvX6x/rKuDclyS4nJ04QnOsqFLbMVD3H
 ac2oETvAv3lWF2jGLG1Ws8ZFy0C7JbylxrV5QN8BFFj6WkNOOr6iQXeWZwx3/L7pAqxr
 J7594HSSi2nxRf7kK4DoUbaIIf9V9JLYRMdjVwt+HwSzb7+NDu3sjAQ7zr6iqla+11Tq
 jo4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwTZeceB+gPU5VNSzto+jxPh9/lDTPSJmHIMciXrA+nNU/17/bitsKB+9cdoW0OC3XcRCT878=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx+5/OvOQLJqIfzvbfZtwhAbKiW4fYRfu9yY6NfeQ/L2g/ed660
 aFxCWojoZIFNI03+YLo0HqAby6ZsD7L9HzVqqkVAts8Gk/PeFtllrFRDp3GJeA==
X-Gm-Gg: AR+sD10+QL3ro5FsmeKtH79V8ZNDginDkxvdciC6zNpvAeFd7q9GouUqAR7aZd4YW88
 OahTGiLLv6cNzT8vf9EhYXECr0iH1frPfhGj5p3LSFwGnhgdonVRbNGWzeA+LNqgYqJVRyvkPuK
 KoW3+BVwA2kkkse/GtiAstoFT8RAFs8+vUNKRnjw/1o80CD3LMLHNGkKv7tSQkcBNuR6LZFd4rf
 Y/cIe8WrV24f4anw8LxCZ9PEWuTSwFVmF9G2eqYUpUPmjDi665n1napezeQ27rMwSgmWr+n2YjV
 Y3hI7ghO6FSoaRFZ9B5Q/wO0ceACt2bfn1kKYKzSZBvjmgjhuHZRudsaIR9xPWQaczDngOAkusQ
 vyj+lWdm9mNNDVg0gvCKSQ9G7GfDWYTxVgi11+673Bt/5Ul1ETn2OJgxCsv6Rzr59Va6XuMW5Tt
 +pIX8l/rXxQ5tKaO6yR1YFx1QiwCfJe2vCZuGuP4Co
X-Received: by 2002:a17:906:7951:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c1f71e86e2emr44239766b.3.1785221794865; 
 Mon, 27 Jul 2026 23:56:34 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f5e717da4sm130568366b.4.2026.07.27.23.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:56:34 -0700 (PDT)
Message-ID: <5c9acc31-33f4-4305-8858-983595ce5607@gmail.com>
Date: Tue, 28 Jul 2026 08:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 09/11] rockchip: tools: add comment section to rksd.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221795; x=1785826595;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qpFSWdbF3KBpsRPhcXe4NmPCNDpukhHRTF8eU8+0a7M=;
 b=Ji2nzakNZLibXEWsmwacpPyL5KsmDLrpiSTIKfRlLb+JIfk23O1AmA7FDVBQf8vcqY
 Zw6ERHi2xkd3IP6eYy06BVecS8aNdf5FXMT5JtX290N0hKFzXiacFIJeQwgTphouiijz
 4MC9FYPcsNzrPa7L1z7OXqIwGyDYQTbT0vo6VjtY7z3CAhf0e1s1bCVa61vYroMb6GRt
 oO9OfCH8RlJwRLglTSvJzRiwTNitD2hG9XKiJ7orG0GTr2PcclRu6t2hh/8l6LWB+KkB
 31wVa2Inv5qU/AaMGTKIogeoAdwW+kiSsTf0jHhJgW7tAjVFTknkuqy+UzKROPDVLnom
 xYEQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ji2nzakN
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

README.rockchip must be removed.
Move the rksd comment section to rksd.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 tools/rksd.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/rksd.c b/tools/rksd.c
index 7d46a1b07b3a..ea12b9cac12e 100644
--- a/tools/rksd.c
+++ b/tools/rksd.c
@@ -3,7 +3,26 @@
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rksd format
+ * rksd.c produces an image consisting of 32KB of empty space, a header and
+ * u-boot-spl-dtb.bin. The header is defined by 'struct header0_info' although
+ * most of the fields are unused by U-Boot. We just need to specify the
+ * signature, a flag and the block offset and size of the SPL image.
+ *
+ * The header occupies a single block but we pad it out to 4 blocks. The header
+ * is encoding using RC4 with the key 7c4e0304550509072d2c7b38170d1711. The SPL
+ * image can be encoded too but we don't do that.
+ *
+ * The maximum size of u-boot-spl-dtb.bin which the boot ROM will read is 32KB,
+ * or 0x40 blocks. This is a severe and annoying limitation. There may be a way
+ * around this limitation, since there is plenty of SRAM, but at present the
+ * board refuses to boot if this limit is exceeded.
+ *
+ * The image produced is padded up to a block boundary (512 bytes). It should be
+ * written to the start of an SD card using dd.
+ *
+ * Since this image is set to load U-Boot from the SD card at block offset,
+ * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, dd should be used to write
+ * u-boot-dtb.img to the SD card at that offset.
  */

 #include "imagetool.h"
--
2.39.5

