Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F6606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gYw1KznI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yKdUl0qu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E677A40686;
	Tue, 24 Nov 2026 13:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0DXi6EcpBSx; Tue, 24 Nov 2026 13:22:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35A2D40769
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526574;
	b=TQsyyVdyIusx2TSBi906X/NRXam8yCtn41dKyx9l7OOgaLS3BiYLTi0TZlLCA+OvC/qs
	 BGfxNxEqSmSBhX2zpc3Tk8DPBttyPXG8xns32YhsGDtqPrf41sJ8XBm1UEJPuJWuGRhDo
	 610BLjieTzP59N1P02V71JrHrQ0I0eisBnGRS9WKGJjuz/+dqjX/LLzhBD2gxzga8FMkf
	 MdqY/dUfFdRdbYQdVjC2V3q8QFSCLz9GNGLTXYTYb9zToDHjBIQCcxu3z1xbbddc5B74x
	 9IwjmhPYvRe9MBjT+TJ9K1qpFfWSkx8IJlUXlO5rgGNTacbb8GSd0kD8Njl77919bfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WUgckmCiFEyGBP0TcCUPMUukDceeXTTvOHMOsE4uhQ4=;
	b=oQh4d4QZ/TEsCAL/ZSUWmFehoIl5S+kl7Yh/ktVlXKnZhGBHZR03jxUGsI6LHjmwwheE
	 swxYrKuYQMrHxbv2yqJ6AgAfmkLAKUV1eJtJwzs7iR75zTicLVXXOVwOu9CT5PrQyMOQK
	 CNoFZ06pMwOnagDr9GPL+0Hc2d9fzP3jV7tePLiao1vuW8YOib4DCWJr0FjCNBZ33FyjM
	 TBsATSL2o+FWSCke/5MvgUmS01R7K8UcxlKxZ4pExhXNmKp/BE5Ee2s2nHPh+pXyi9kYi
	 DzC0WsDmBL31SMWwweYqlmA869HmsLtKdEGUnXDlCNfo1g9D9riWn0v4t8otlnklsLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526574;
	bh=WUgckmCiFEyGBP0TcCUPMUukDceeXTTvOHMOsE4uhQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gYw1KznIBlm9Fb9KX9Wgu9cHWai7ZXjX7pY/12s8p4obCiaV6oK6e0k4C85xHGab8
	 1ekZE9At8VkAiIeciY7KRV1K3LF1tHQp8czqIsiYDmvyWHvFz6UfRNsTmb5Ct6Szz1
	 PG/vYTNvXyevsFYXV1E1WfSyaF+cExxx5y+b+OIS4iHsWVW0Lm2BduH5W6/RjXPUWK
	 c9mKRXID1rMDEv07c2a/xgswda2p59RJ4tKn+J5HsMD/ytctywlkoQ6J0usM3SG0z7
	 +cFOPsqmGomqaXYagws4/TXdov+a1uFZACAmX8lqO5klayxlygo7WRh5ewBQoPQMrv
	 fKRL4VEkQA/mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35A2D40769;
	Tue, 24 Nov 2026 13:22:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42CA8FBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29698400C8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5A4WBFH735w for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:57:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CFE2240068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=leeonion.muyu@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=yKdUl0qu
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFE2240068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:57:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9406784409; Tue, 24 Nov 2026 07:57:10 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA91839DF
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 07:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2f02ee04378so32842945ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 22:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795503422; x=1796108222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WUgckmCiFEyGBP0TcCUPMUukDceeXTTvOHMOsE4uhQ4=;
 b=yKdUl0quotxgUqkYRHw0eazZ/ncmBbLTnlxk3/oB/iYzKNPXAuoVHrEJ5hE9QTaVa/
 EyNcRav8Uh11ohzIJxiomHTxsoVVtvdSTaFxns8vjBzYux568ckrUrzC67ZkykZ1mLVK
 VyUazY5g9rDbD87yNygkIpoGtoHppdpkxMkNT+t985q5IsZMNDczl+0Nu1lG6bE92xGU
 n8p+9zu/D2MKrqOrEzeFaloWMDgXijc4YqZt92NoOR9acECH/iCQLKYOhh+y6V3AI0zk
 cndLsZAvm6m218vNyBmWNDgYXSaqKWkVUYUysd1dyXhu615+uudI9mH5r85zB3d3APm7
 J8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795503422; x=1796108222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WUgckmCiFEyGBP0TcCUPMUukDceeXTTvOHMOsE4uhQ4=;
 b=g51n/fS2anVr/3hTwa3K8EeVi49jS1TAkdB7GaW09ZN/WnnH771nRq0rDVDDM8LJw7
 96/ZWTkTqs1KxUVfZNQwMzP8za7xAIwuL5fEnruM8Sy8Afdt9SzdI5xyX0IiUut9EagN
 JPUFQfMuT3/1y6xwoodSEMNmT8Q8o8/uRtsuTn6KAIp4h66608b+hqO6HiK+ZqFgl5dd
 f4mvXbUgasyU5eRAIJ73ARJwgMvrzzCXlmdhYQ3NSWkLLQ1MFF1qEmVeUZAoK88wsFf8
 UTJPsjZWpoGYoECgr9I1vHDRevhnTu446LzH1SC/gL6PuJuVNfgMWZRchBc/MlP94xtq
 7PXw==
X-Forwarded-Encrypted: i=1;
 AL+hErFCfoSyCSqIVPuLhWsWrNXC2Dpf+8jcmy75+n8/xPpmu66j758iklAZUy+uSbHMZXQg3SBWRsA=@lists.denx.de
X-Gm-Message-State: APuU4Z8GKDrzlvfbCPkq+2E+oxD/PkqeXraVbQTfWb+mpmHhIryJSVVp
 CkrVfLidD6N12HeyDzHW2/ppARIxDc3w6PykgEZqbXxzrBA5/LlDYoOM
X-Gm-Gg: AZFdTZc/ZSurT2UgCFECELU1HNbhNslc4xjvi5j6fv87JGF5/ZV7+wXKr1ZEfw+7S1z
 zXyjj+66uJegb5UiGIcEsoW87VloN/3lE7L3YfKlYK905eYZL+HQYwyCkTxwY9IcmwNtfRvdJkU
 ETVbcjtz9a8JLDOdGXpECFfiuo4DBlWyN/lz20XYabykO3ZuTGwIsXgvKyl3HxyPS7n4ze6WUnF
 WVQ9QV1X4yH74pxOtKTXkpNvBEJf0gZLoQbYH6ZFuu3gPL6vjprgXJ4SeRPH/waPUkiK/Kd+Uy8
 MOHhlr9K6P2orCITJZRIT7rhakOJg1Ua2lOojHjkmU3bXbxsFRo0fTh28BUlenBuoOGpdYAWW4H
 jpfWiwk/baWHP7k9qcJlNS7dHG35rfmsk9fHnQppQQB2lKkqw98C1MUE//s4/G3Do7xhP0jFndw
 eT5VrUq9OD05roK47QfNOibSB9RPqsVbZAUxuKV8rmPDaaW+31+QPuHTKSmIfM8OX1VP5YLamVf
 XZLn0t/9gJ9efzZbdmCdOZr+krnNjfzKhrX3RWAHy1TmDErBTZpQnRuiYGb1STB76uN8FWb1obb
 ZdcmbLntF9hhdCZKZdVCWGosjqoM0kIRJpi4w4AVarY733xszKXzlDI=
X-Received: by 2002:a17:903:41cd:b0:2ef:efae:e8e7 with SMTP id
 d9443c01a7336-2f03eded341mr142785705ad.0.1795503421589; 
 Mon, 23 Nov 2026 22:57:01 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f105b66sm64966685ad.51.2026.11.23.22.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 22:57:01 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, palmer@dabbelt.com,
 pjw@kernel.org
Cc: mark.rutland@arm.com, alex@ghiti.fr, emil.renner.berthing@canonical.com,
 masahiroy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH 1/2] arm64: boot: emit standard LZ4 frame for Image.lz4
Date: Tue, 24 Nov 2026 14:56:49 +0800
Message-Id: <20261124065650.1968930-2-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
References: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared cmd_lz4 rule passes -l to the lz4 tool, producing the
legacy LZ4 format (magic 0x184C2102).  That is the format understood
by the kernel's own decompressor, lib/decompress_unlz4, whose users
are the self-extracting images of other architectures (all of which
compress their payloads with the *_with_size variants) and the
lz4-compressed initramfs.  An arm64 boot image is not consumed by the
kernel itself though: it is decompressed by the bootloader.

U-Boot, which supports booting compressed arm64 kernels with 'booti'
(boot/image.c image_decomp -> lib/lz4_wrapper.c ulz4fn), only accepts
the standard LZ4 frame (magic 0x184D2204) and returns
-EPROTONOSUPPORT for anything else.  Its host tooling (binman)
likewise emits standard frames.  As a result, an arm64 Image.lz4
built today cannot be decompressed by U-Boot at all.

Emit the standard LZ4 frame through a local rule, leaving the shared
cmd_lz4 untouched for the in-kernel users.

Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 arch/arm64/boot/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index d42d07667822..19b26aa83203 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -28,8 +28,15 @@ $(obj)/Image.bz2: $(obj)/Image FORCE
 $(obj)/Image.gz: $(obj)/Image FORCE
 	+$(call if_changed,gzip)
 
+# The shared cmd_lz4 passes -l, producing the legacy LZ4 format that
+# matches the kernel's own decompressor.  Image.lz4 is decompressed by
+# the bootloader though, and U-Boot only supports the standard LZ4 frame
+# format, so use a local rule that omits -l.
+quiet_cmd_lz4_std = LZ4     $@
+      cmd_lz4_std = cat $(real-prereqs) | $(LZ4) -9 - - > $@
+
 $(obj)/Image.lz4: $(obj)/Image FORCE
-	$(call if_changed,lz4)
+	$(call if_changed,lz4_std)
 
 $(obj)/Image.lzma: $(obj)/Image FORCE
 	$(call if_changed,lzma)
-- 
2.34.1

