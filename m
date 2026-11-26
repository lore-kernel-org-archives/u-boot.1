Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=un/k+sdf;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnAsDL2X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1020640850;
	Thu, 26 Nov 2026 05:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPcZ5hLPXVwC; Thu, 26 Nov 2026 05:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 319DD40849
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669316;
	b=hPVBKeP3AZQiRUHHhxYuvd3JRLjyuF7um7tJqZlsSAcieC8+2mbvZaibc4gayDeV2PzQ
	 FCxDYWptYnWVLhWVFlrC1mxHrRxaD/YkAxlIDyG6EujEjNH9R707yOqBDt5+nPvLYPhW7
	 qSIov3Ciz31os0YiB9sO8J2V3tuYYAZerbYOAlakNJRkao91YCaki+M8AutqTqoOIdcIj
	 4QTDhYnT4y1sHHGlpLnX6mP1lF2mR7015uSxtQhJZOaVTHg/RcnLvjFE9zJB5SFbTtVm2
	 qkUUz4VK23+t7aS+iEmsT6sSgqIVX5QFqc/Ui7+ft5xCrMk3YZ67VxAf5Y6cjv3B0tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669316;
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
	bh=BkTmeYNebhkrqLGwJXoMAq7CpBRUkvwi7hUAFtPicvg=;
	b=l3yaQqr4fbc82FFiovfFPeAAas1ULkpXes19KKlw+f8o71x9j+ov3GZc64kzs5vGQgZ3
	 OTfyoETqjr2PsDqZ46fX+5y3DWr+WiP6M1azfwNlnJrPB/G9qJ1x/XDGVGYYMK0A9Pwu0
	 41ailBpeYXCYLYLrtx9xgU1ErLNrXGHkvlGxx+NkJBu+nDVuIdLDMzfS56C9T/DmKcks0
	 u6IvEoADr6tPsxIfzFYFjGgWwSkhk9LVG1e+mzEBAclfLrovxi13Jt4TYjzpUhVsiRcmK
	 yH9eXN/t74B0599tQrjOwWA6Fgf++tAA4amRcyyRrinlyvnvUvaqMC7YN79wzqPL6Jg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795669316;
	bh=BkTmeYNebhkrqLGwJXoMAq7CpBRUkvwi7hUAFtPicvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=un/k+sdfyLwaV8UmyU7iyLbbpt8C7V0164ktXrxpWBB8vnqfHJcAtOAR04QBgh3b3
	 /pzRLGjcBLQ4t1FM0AF7Rn621alGN/uTqGwc0bkPSe5SJRAXsmlJE1524DJrmljDeK
	 EEFe2YD9ty8Q/iusA4O8Xx3k8cCbuWrsOdmHh85BSa2u7911h1w8jF+wk0DCz486H1
	 I66XvjAaRMOdUw7JKCGucwoutUvk7XerBOw/IK/ZZe+tDPKcTGA8hpEF/Eu9FH5s83
	 6A14Lyu9u2dHQ9TKhZ6GvE0KXGSy7VkQf9yIfq2yftBGl05MNuxOwK5BLEp43g7BAQ
	 t8XqiVGgBBK7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 319DD40849;
	Thu, 26 Nov 2026 05:01:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D97CB1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBF9360740
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBykWaYxrNuJ for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 03:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B00BC606D9
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leeonion.muyu@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rnAsDL2X
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B00BC606D9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:03:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB61483108; Thu, 26 Nov 2026 04:03:15 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A09847DF
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 04:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leeonion.muyu@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8b68e59ab33so4795936b3a.2
 for <u-boot@lists.denx.de>; Wed, 25 Nov 2026 19:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795662187; x=1796266987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BkTmeYNebhkrqLGwJXoMAq7CpBRUkvwi7hUAFtPicvg=;
 b=rnAsDL2XAlGGqyGihAShmnFnRoopTJ2AQ0qCffiupdyK/MsxtFIBQmxDrtzucUeSy6
 7jvnC4dABzJ112Mtpc8/Vtc+cOyb/y/YjJ/GsUdDlRNg0TIqHu5jvRQ+96h8DMQEwz4d
 aUhq8WgVnDGGi2sKZx/UQEng8rw1++6ehTCZzG4rep12ewtaS+Tq19Mui42oxktn8XLb
 B2HOt+mjfppNvv52tKukAznzIT97VOg82XWp0zTDEFTQNGcOM+0msFwCWt0e9fJSsKrT
 MhckHuI3T+KM8gGlp9v2OhkqV1LUfEOXlKiCphPKUnckkpYcEj2U6AxvS0TpAnavQkZC
 MGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662187; x=1796266987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BkTmeYNebhkrqLGwJXoMAq7CpBRUkvwi7hUAFtPicvg=;
 b=N7AnQrF351/1fv5KrEWk6op7jBClfKxhmIMGq30/2hDVmW2vim2HcHT4uiPQh+YHNG
 1X6dqcgRsb0oXpIkCbB+EEhB9v07JldmmCmRLbOQTWfJGzb4x5AcCJc+KWK8J81JltZs
 Yt7FE6uFyfa24qnHRD2TByZzPFK0mCmbzY2LfZPBG4I72W/TnPArqLfJkqq+EIq+BeIZ
 H2U89JTZgyQ9b1pWEXfeOGlZJsSF5U6a/DeshMTmV3biu6RZqiQfju7vGi31L65UJpRO
 +Z/nMrzMVeXda8S4ozAcc/QM077fG1m36EcWENvLJ+jkbGy8on4H1UCXe5ioZGPaQItn
 M0aQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGi6v5yq84PMbro+PeJ0iz/35uk2/5lj2q2uUu/EzWrPpDB0b2S3hndMpe5ygWw6263jrzNSBA=@lists.denx.de
X-Gm-Message-State: APuU4Z9hvYvM5CI0mTQwmzrT99YbzXUwk9bj2YgsHfXHHwC/BV/CPNY2
 lNFVYfha2n/Lrjs4XXjh/3eOz1x6kPmRGyb/KObpPlM6KQjUIHfg4Bv+
X-Gm-Gg: AZFdTZeGA0xK1NLri/QZRfUlifaUSRkj6NxA8kogUpq017fByDzFH+pYTd38xBQpBH6
 lHWpo/EHLB+Vt7/WzFnrbxiJP2d1ZdZVq3H5wejvn+p9p1TIEC6TkdQ793Shjg7goKZvTlVWc0v
 8qdEleHvIxiCQaiwYL7f2ixuAgScBSMIoh0dbZzdcV9/LDmoISte27Dxnxl3h6lWioVWdQJ62An
 J1zU0gysjuWw6y5qGGXnKf5LF4nU2Fq5g5adhcDR8x2E4IYEdIC3spP4JO5Yzn36q4SY6lOkk1G
 RlqucPweqRCsacwO+/5lneCB7pmPmecqB5Q1yOUr14k4YmHqHqkTINiz5dMjtyaIb09zqQdESMO
 FRhOMtydWb3nYWBrjFL6hw1beajtYy+5Cf4fqMWZwt4YRX3ZAmQuetDRG64tEQkcgjFNkirpkZg
 1Lka3sAUiLIOcU2gBrv/0YZ/9Qlw82me12w6+RjQrCgL59iQoZnTu7UV5iGRIQ0W1xbz42yTIRX
 l+inmtyC6nRrekLzkIlLtar1tqhig8ex/zm4QJqW1w6Qb/2zlGbGUxgFMo57YbgnnoPt7MO3C5a
 +2NEnb/xKYOXrcEYlCkdFQhN1GBTq4c/xg==
X-Received: by 2002:a05:6a00:18a0:b0:899:268e:c848 with SMTP id
 d2e1a72fcca58-8c87cc450e4mr17627128b3a.48.1795662186926; 
 Wed, 25 Nov 2026 19:03:06 -0800 (PST)
Received: from server225.. ([39.170.101.209]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c908a56acfsm9231474b3a.23.2026.11.25.19.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:03:06 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, palmer@dabbelt.com,
 pjw@kernel.org
Cc: cyan@meta.com, mark.rutland@arm.com, alex@ghiti.fr,
 emil.renner.berthing@canonical.com, masahiroy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH v2 2/2] riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Thu, 26 Nov 2026 11:02:33 +0800
Message-Id: <20261126030233.2546274-3-leeonion.muyu@gmail.com>
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

Like arm64, a compressed riscv boot image is decompressed by the
bootloader, not by the kernel itself.  The shared cmd_lz4 rule
passes -l, producing the legacy LZ4 format that only the kernel's
own decompressor understands, so U-Boot (boot/image.c image_decomp
-> lib/lz4_wrapper.c ulz4fn), which only accepts the standard LZ4
frame and returns -EPROTONOSUPPORT for anything else, cannot
decompress the Image.lz4 built today.

This matters in particular when CONFIG_KERNEL_LZ4 selects Image.lz4
as the default boot image via boot-image-$(CONFIG_KERNEL_LZ4) in
arch/riscv/Makefile.

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
 arch/riscv/boot/Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index b80a077a8e8f..ab2b1b77e21d 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -33,8 +33,20 @@ $(obj)/loader: $(obj)/loader.o $(obj)/Image $(obj)/loader.lds FORCE
 $(obj)/Image.bz2: $(obj)/Image FORCE
 	$(call if_changed,bzip2)
 
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

