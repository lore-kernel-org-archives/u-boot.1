Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D3606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aos8aozH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JdIcsVFI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31F21608B0;
	Thu, 26 Nov 2026 05:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVa8vwvXI_sd; Thu, 26 Nov 2026 05:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 772E3606DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669314;
	b=qEL3kGkvsuB6cUKsUHCP040j1VprH3akQtZJLwwMMQdsuZqz3zn67TBdoS6XUf77UtU5
	 aqZPcrxPOxuVfS4gfdHnx+FofPGeDjaboFd875JpHomwZj7aPGXu/lsUO2GcGXTZKpfC+
	 cdSOPAMuxObOQPBYYKZavXkIib8hlMdcOhH7eevUeToNG6rOJ+VVj2D1P1rYf0vK55u3X
	 2C49BX1nTs6aZ0RtWHWRB1y34lvQRjrCsnesrhfNitoipz0VAc7VvOeNSndPDGnF2sXAH
	 dwccPW6Mwfsz5sGsb7Z6h6ghdd4CU6G31uCuwzYgmIh0Rkk1ObyWxHA+QrjAlBEE0RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669314;
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
	bh=gg7ZA0AgmY4MI2TnL0if+FhDda8V2LVarU+EtpFSpPQ=;
	b=l04Ql02U8bX5Z1Leh163NKO5cEIkTt6bCPPyIZZPkzYLYdIo+MMY3F+g2A4AVnTeuEiO
	 AylXYs83aogmPHFEF9pROgq0CDfM9lqvwZgHe66g660uyu9/FnyM0Lnuc9K3LV22Np74z
	 z6TUSmwjqVmIevg7xPEN+1YYy1LK1fuRTgwcXwT88tiexODgEDx0XaT6Nbxkjj+c+jZ8N
	 Cpb2YZpj8pQXgckncQR8XsCQJtTZ0f/wVOgNywOXYLymHwY+YcmPc3SVBa0JLoss3X0UZ
	 0dRgu2JjvJdxddB6VE8EfhJR1qPNP5SE4DJLXoCcVVVG8spebxTXAGcTihOD0hSyVRg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795669314;
	bh=gg7ZA0AgmY4MI2TnL0if+FhDda8V2LVarU+EtpFSpPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aos8aozHOXFToQjQ7UlF0qWbEWIbqIS2FOGI5bG+ivafF70I0c7SZ1YC5F+aZ5gVf
	 i0mMBuyxUCfzuhzxZ5CkCX+EZHCUqDIEiIoUVKD2ytkKH6fbD+fwL4NAGrAE4yZ5EM
	 tneVdNYr87RySYnB4pPbayU1KopMLPmKg24+d63wm6NDbgVM+H8MBnJj4SLwbheL1x
	 LK6xSBfc98vCZ/FJw9YEMjgxuSzQ2EQ3Dn3WnD5PjRsaL/JYvS66cq3bNds6hkqR5R
	 w7X+wn8b54w6ixZefIdTFm+O6zYk04Bj50O4R+lR9+g/uzGohRhCPa2ekYPgBjgCeo
	 va30FEkuBcCSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 772E3606DA;
	Thu, 26 Nov 2026 05:01:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01B2443
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC303809B4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3y7UX39J_la for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 03:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9A8680865
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leeonion.muyu@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=JdIcsVFI
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9A8680865
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DF183108; Thu, 26 Nov 2026 04:03:12 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBAA83B4B
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 04:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8b3577deeb0so3008505b3a.3
 for <u-boot@lists.denx.de>; Wed, 25 Nov 2026 19:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795662183; x=1796266983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gg7ZA0AgmY4MI2TnL0if+FhDda8V2LVarU+EtpFSpPQ=;
 b=JdIcsVFIdM+U9B/hWUAUOaCV3FDL6WlfI/HWGr0SH10E5dP4mgpLt0V7hX7nn9DxQY
 yt7nIFTAiSKFbSlRkpRWtpL7O6GAO8OTkDHm1WtHMHPaHH5FlpxUlTiBQLMGEg/4KPIO
 UUQQozR3r/hgtu0hbUyw+88l6+sAMClStfpwWQFP6p8HI36Tmzlc+Oz7+IQ4nzCH8BVD
 Oh5gGelCicrMjTUl4Hs04PKgIaZu0HBEMH6rSm8LZEDEqUHsfTl9nitJcKtdnlgk/bMY
 aMvYLxVsuJhthhLl7DdzCWhWwaHSQKqJTSp6UemtQXC9A4o/Y9mpmP1QQZpU104Qbqld
 ViFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662183; x=1796266983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gg7ZA0AgmY4MI2TnL0if+FhDda8V2LVarU+EtpFSpPQ=;
 b=Lodx4OYdO+LxUd7SmTerJbtiaNyVmPjftBV2RlwkRcdzspFAV1+NdvjGFWa2Cw3shc
 o2rAVeViClVydmudPkTTeDgsv8czxFg2XA5kKkjPxNb9vm8LbTu+nE7FropBveDk4jL1
 KNMZStbAbL9Fhf6o1kNpXwzno7BwLBNg9rs731ACUvLMC4AkC7lGcqNm/sZ01bgHBNmh
 YNBBVtOneFDxpab2O+xvxJaywzjNmDYBpGiT0EB5yjK+5bcZA9yEN7D0hu0nGMUYaiIj
 rxPyhusxxHPSERu9Zs/MsnyC0ni3IwR2HT7XXC5W5CgB7wHbpWQhNNXJco3TIgDUb6jT
 xCoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF/hQ3gwsOF2qI5VbFcx6NxoSy15U0EPEJJdPwMVPxMW+tMFeg0DdGIDVU/w5yLJOfGkbbsqH0=@lists.denx.de
X-Gm-Message-State: APuU4Z/vZM1a/KZSkuilC+sJW3zNZOVRBmat2PL3uxCYadFZMvWMo93Y
 fhhQZpwg59X2VHeynxClRLXF6H55+Bd8stgbuS/WBxasQVUW+Gg9u+B+TPLBq5iz
X-Gm-Gg: AZFdTZfHx+H6xzrU+lM7TogHnSiNZ9ubMqOPvN7BpX8BTeyMCgtauGzH6jY67z4gGBW
 vFrsF5hHqTIQEmX/94enOVG+Knjs3fCR2zCmXu/tC1RPJ4799vCNnImqyv974gU1O8TAv5E9CJP
 f8zDTCTPXx1cC8NxuzJZBgPdDwXhPBMG/6YMFTy5p0fl7It8fZ3ry4IwnpVqBIRzYd/kDZg9njj
 M/NABnCqOnqcYaqhw/RazA1D7qUM3adbFtqPrGzB8IVNNZjypQv3BIduLx6T4YU8C99OThsfNCd
 eocVzDsBNeTk1pg4p4LF5jhxmJPlQoEfHehPDuEjriwLAnzX7nPaWxMPHdLv0SVZ6taPCN/EsqV
 SWHWuBA5bdc6WWv9GCG1qzD7J9UBeHfpxLjpI7qux9obswUA83jk2skbLQt4kd9awYsSySck9aN
 WyuhY1iUY6fLbalOVLQsI+UaFSNke0MXlJ3YVBKlQy6XgFET9twAycq3pdjvc+7IIS+lWRLFUpV
 ffg9QF9TYmbf3hqQEd5jbaoGlkLfYFsv/KS0or/se9YRsfltBz8zH8lcJtNkZgtbSEWNGTVs5rU
 6CT5528g0sFWAuoC3/VSuV/yoUuzT4LSA3S1dxXyg44BnTaElQBoiJA=
X-Received: by 2002:a05:6a00:348f:b0:88d:3f61:20e9 with SMTP id
 d2e1a72fcca58-8c87d124ee2mr14999598b3a.48.1795662183040; 
 Wed, 25 Nov 2026 19:03:03 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c908a56acfsm9231474b3a.23.2026.11.25.19.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:03:02 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, palmer@dabbelt.com,
 pjw@kernel.org
Cc: cyan@meta.com, mark.rutland@arm.com, alex@ghiti.fr,
 emil.renner.berthing@canonical.com, masahiroy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH v2 1/2] arm64: boot: emit standard LZ4 frame for Image.lz4
Date: Thu, 26 Nov 2026 11:02:32 +0800
Message-Id: <20261126030233.2546274-2-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126030233.2546274-1-leeonion.muyu@gmail.com>
References: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
 <20261126030233.2546274-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 Nov 2026 05:01:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared cmd_lz4 rule passes -l to the lz4 tool, producing the
legacy LZ4 format (magic 0x184C2102).  That is the format understood
by the kernel's own decompressor, lib/decompress_unlz4, whose users
are the self-extracting images of other architectures (all of which
compress their payloads with the *_with_size variants) and the
lz4-compressed initramfs.  An arm64 boot image is not consumed by
the kernel itself though: it is decompressed by the bootloader.

U-Boot, which supports booting compressed arm64 kernels with 'booti'
(boot/image.c image_decomp -> lib/lz4_wrapper.c ulz4fn), only accepts
the standard LZ4 frame (magic 0x184D2204) and returns
-EPROTONOSUPPORT for anything else.  Its host tooling (binman)
likewise emits standard frames.  As a result, an arm64 Image.lz4
built today cannot be decompressed by U-Boot at all.

Emit the standard frame through a local rule, leaving the shared
cmd_lz4 untouched for the in-kernel users.

Also pass -BI so the blocks stay independent regardless of what the
lz4 CLI defaults to in the future; deployed U-Boot decoders reject
linked blocks, and lz4 is considering linked blocks as a future
CLI default.  -BI was introduced in lz4 v1.9.0 - older lz4 versions
reject the flag but already default to independent blocks, so the
rule probes for -BI support first.  With current lz4 versions the
output is unchanged.

Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 arch/arm64/boot/Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index d42d07667822..eb28967469b4 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -28,8 +28,20 @@ $(obj)/Image.bz2: $(obj)/Image FORCE
 $(obj)/Image.gz: $(obj)/Image FORCE
 	+$(call if_changed,gzip)
 
+# U-Boot only accepts standard LZ4 frames with independent blocks;
+# probe -BI first because lz4 < 1.9.0 rejects the flag but already
+# defaults to independent blocks.
+ifeq ($(shell $(LZ4) -BI -V >/dev/null 2>&1 && echo y),y)
+  lz4-bi-flag := -BI
+else
+  lz4-bi-flag :=
+endif
+
+quiet_cmd_lz4_std = LZ4     $@
+      cmd_lz4_std = cat $(real-prereqs) | $(LZ4) $(lz4-bi-flag) -9 - - > $@
+
 $(obj)/Image.lz4: $(obj)/Image FORCE
-	$(call if_changed,lz4)
+	$(call if_changed,lz4_std)
 
 $(obj)/Image.lzma: $(obj)/Image FORCE
 	$(call if_changed,lzma)
-- 
2.34.1

