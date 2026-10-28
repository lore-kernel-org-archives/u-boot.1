Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB87606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zEwvpfzR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/6PqZDn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D6FD80E34;
	Wed, 28 Oct 2026 12:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdZjvFigg3um; Wed, 28 Oct 2026 12:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6380180E2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189594;
	b=eqlTP3O72KqQIfij8I6pkH3oayGg8WIeKp5jxufxxOTUeN8mOAlVq4law+zt7hQCDfCO
	 71NmvDVAt34/rS6g4j640GoSbPv97g4HJzOw2heUAHkQ7/puS26FmR/IIfi+OMjBSBgV0
	 Na57HyaZjpKk/7l8S3MUgnWqR077NnsGlYZxHBBRfBhTYbQPbU1jRrFJWeSjVVZN3GMhe
	 9yZuk7fVko8HV7/ooUOYppJsJ1y/NNdZzGuGND1PMGC9iCdqovEletlDJxVWG2LRLTCp8
	 R2O1y+/rC5qxgO4ARkBXO+YMsPOc0rTt7d01cDRHXC0T9lNAOBbBy9iU1JBPFutHurg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pmjIJL1LYM07dD8NzW6mlPYaLgR3r67iaQH8DZM+tlc=;
	b=m5YCTV6Gayo2zSEr6VEfmiZsrv52+4w2jm394sumG/RX4HIIgh4dK02pVEpFw8bM9Pt0
	 LcrKFLZkq53tqBSQzmgMmTJK4Pfq5pyftV2CImbR5gsIInoLN7zELzbJTJHJ1tTaH0VnR
	 g4F9EfiseMPBqXeC2HTJ5jJCWCLBYdCAw3S+r5UHNj3L7aJ9W6IQzfin1P15a2LTjtAZa
	 z0DjY9+sFA5hb7FZFO1VnPPKcnmPUftLRPcSw4q6CyCmOAET3nzTrzUx7OYzR1kz4Obp/
	 kTnaeELH2diQvMRV5cfj0PCsVzx9b6ItJOfDVBw2TRBscOBBAe4PtVOxlrkQOtkdxqg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189594;
	bh=pmjIJL1LYM07dD8NzW6mlPYaLgR3r67iaQH8DZM+tlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zEwvpfzR/WS5UjxBbPLzgW1fWRPZM3XimYEdqePbre8EpjC5KK0MSEevBMPLgM4od
	 o0imvtdii2fP5b9tlr4TgrU3gHZAcVEozb75W60NwXsgke97233G28HKIRkTktDiSt
	 zvEfQii9XtE/E+xuVAl3JJr6vxIqAGp042xdymqd0RoVtnTTaiuI1j98GVDUYSMcMS
	 izZ2Uk/Qv5JGGOMHLj7kx82uguhBRqpzaV0i73ewzkyqQOzAYhiC9CXnbiGBnJ516T
	 fEW3O79tLapbBoUVQHhCouLgUNoYvHacppnM0B++Dy05PI14LOUQByrL/Ny4Q6zvSx
	 fmRrT3eJZDydA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6380180E2C;
	Wed, 28 Oct 2026 12:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7834B2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69FD5605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQL8FGRKcsYJ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8954F60699
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189591;
 b=lnT6JTsDQ3Yew3JouMr4hy6M+ORgpE5odk+A4q03YMcfBP/aAICpOqvV934Fbky9+1xa
 BWXA22/ZFx2Mn/NJFNWdVHKET8wwBwdxeKmT1OyEROr45mBsP1Hph4VeAqt4rNgaiLKj7
 ayacKeEcqobKlbCCiyq/clyeiB2asSW1ODX9q8IeQr02fMTTjl83kb194sESDctSOzw4A
 ytqDHIJrcSwlDJvMB4qo4godhKPRlgl907dznTLxugWbuWAtdsgoaoTQkB5go1/1QmZ6W
 lTyaLHxkY43OJTvXM/Ygc5qO4JW4QqY1mFDuGow0f4Y/xj7vBq/Qo7d5Dk/qXCgFQPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189591;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=pmjIJL1LYM07dD8NzW6mlPYaLgR3r67iaQH8DZM+tlc=;
 b=is1GPkA1P88US5cMQk0cX3hrCRAmjMWfRNgFiWvx7yGxKHQBNeB4056lXWvTSb5BLu0X
 aS0lumqJ2kQCAG6BNy8IxMhmv7xWuEw8SuPURTICbwCnAQZIW6rMN9M8D0W67KvTOdSAg
 0e103N2wZ3hjkb51UrdLQDlKV4LkmHIytnr34MzM/j5kvmj79+LDGHDCu8LxheHSJLNbh
 UBXyWxz6TNfMO0gIwT4D3cvvPXUGN1eZQ/TlA2tLhLfd4nJ/fqiSW7UEYOK+ZfKX0xgBD
 YNRwx/vYDXsJZHmWXlP2VR8XkAjEbuFq2vLlgoVOYBrKw9dAmfu6njPt8m4N8atgU9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="L/6PqZDn"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=L/6PqZDn
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8954F60699
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:10 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so454081f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189589; x=1793794389;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmjIJL1LYM07dD8NzW6mlPYaLgR3r67iaQH8DZM+tlc=;
 b=L/6PqZDnyt80VRZpAP4BAvUsKRx1215CMrMslsxBRviaN0/TsOIk+6DeRm/pXCyW65
 CqRv1luyOI+CdPMJ+E/vtxyDPBCwD28z4O25l3XJ2iY/ZTgmPISSMt96RAKjStFQbFlN
 J3Gjoch4lEakXjYRcGN5d7TovyCiiHFrDhOr88bKkFu19Db/LJS5qufIg1NuP9vpU10U
 Xn254skku3mdSyM2qf/XQ2WMwmYHPIEFhLbhIReGU4N3hYFLxq4Lcf0vG5GVvDH5dnnK
 KTS/drB6EIvH8PsiynHYPOaKLJZPl2Ty2rLJFtIJYhxoJI3wGSj/MyZBF0ysAk8GPxRG
 juNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189589; x=1793794389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pmjIJL1LYM07dD8NzW6mlPYaLgR3r67iaQH8DZM+tlc=;
 b=QftAJMhwdWcd85PaGPfnbA4Vj/xqe8bMbvufspUVTSlz42LqHNmzB7NTpmXhVxqkqO
 S/+czf/8wnqsB8lobL9lAJ1iC8yVWMWLDN6VSQ+f1IDk1ozce/Hc8OzGiK75HIXvhgPk
 Kz+t9JtASffDUSSh/+cG6O2EF99N+Iy7zPB6/b5kLB9gKJNeBfUuKZoDqGwhwITNzkcC
 uI//z68G4ZGA3TE7/qAQS4YleSjDo9eAjkwWDUfQtexw7A7j4PA6PUkvz8mv6iQL1g7K
 Mc88PCa4hCywxAlhN+oioJDiaZZTcHeTc7b/7nWzEGUJm3UpAbzndhhI9LsP9zNm0tCj
 yoCA==
X-Gm-Message-State: AFq9FYJKe7QoPjpRQ7Ts5HlDt6rPaZ/q5pohKR25p6/wrP5tsIo4YUZx
 dDXK9Cgjm8aqGXQr/ptCKKFx4//7I/yOvvGC1+ARcqDa4wfshPe4C7UA0LSpx6sw
X-Gm-Gg: AYBFou2GGPQq2SRw3TLdUBz0vT9Xxgc9llzCosCmUAYbjxALDbe13Fmz9tNh4M9nyjr
 +t2Q4cvaXpF8fY6xquc6FMOfNKvxWcyvPC1hxaRuAzix9KQ77xmxmuy5DioC/AgcvTEszteOzKM
 JXxShR1Nng9i9y9jpVj/9iYLBe2VDpQewbT6AEPPodHJIVmR8euhwJUw/OAUHgJsIfdnvy5BrNM
 NddAjtmNqxRxF1MXMt2fkWenprHZuqTZF+X0SdZPyPPy/02wNo44edOVxluM3dai4B1NL2oivav
 67htoveZFPWGGNFa6RL6lUU6+OR4FkCuQBUAdW8oUoogJUsDcTo+kehulmVtgQzU9GbBxcCmidm
 V2brmtOfdapsx0vMWEvcn7FuyzsvkpTepBBj/Qwgbkq0vffZ/JS/OBA27intkOp/IrzHYge9nHM
 YBPce2QgbAlVQpkzV8sxvKPzl+5KXVivZnTQVP8KLgCl/IpuVzh/PYvOLHnLbVtKsYxIoaSgudM
 vACEhuM1vMQkdKmCIo8L+m2khgUkJjw2F7SdFHzJsX5Bef6AJlpJFmkCWPY+KHjLDnWnA9oD+yp
 1BwoMzkIqW1xvekGbwAO1NBfRZC2R1+vyGNt/P6JzNjnbxQdoRcvg+NlkPwCjmJQxDcNYsQ2TRz
 w1tipSyDzkSxkOGNGXpPErXfQphioeGGlV8U3V8bevWySIyiHQD2P9tNCOb/C7MjNV/jpjcn29c
 DCiy4lez5FIEqk0xOXowdSdqw8jbrIQWDGrQ0giz5EZAKWeQCyEdS5
X-Received: by 2002:a05:6000:1087:b0:48e:4318:8854 with SMTP id
 ffacd0b85a97d-48e5d5c39aemr4358003f8f.20.1793189588938; 
 Wed, 28 Oct 2026 05:13:08 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm28113560f8f.53.2026.10.28.05.13.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:08 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] tools: kwboot: Link with libncurses on macOS
Date: Wed, 28 Oct 2026 13:12:56 +0100
Message-ID: <20261028121258.572-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121258.572-1-pepe.schlehofer@gmail.com>
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building the host tools on macOS stops at kwboot:

  ld: library 'tinfo' not found

macOS has no libtinfo. The terminfo functions that kwboot uses are in
the system libncurses, and the ncurses from Homebrew installs no
tinfo.pc for pkg-config to find. Link kwboot with -lncurses on macOS.

The darwin block above checks HOSTOS, which is no longer set since
commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1"), so check
uname directly.

Tested with "make turris_omnia_defconfig tools" on macOS 27.0.1 and
Apple clang 21. kwboot links against /usr/lib/libncurses.5.4.dylib and
boots a Turris Omnia over UART.

Fixes: e8d26e827635 ("tools: kwboot: Add support for backspace key in mini terminal")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 tools/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index fc0aa52455a..a23e8af12ca 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -221,8 +221,13 @@ HOSTCFLAGS_mkexynosspl.o := -pedantic
 
 HOSTCFLAGS_kwboot.o += -pthread
 HOSTLDLIBS_kwboot += -pthread
+# macOS has no libtinfo, its libncurses provides the terminfo functions
+ifeq ($(shell uname -s),Darwin)
+HOSTLDLIBS_kwboot += -lncurses
+else
 HOSTLDLIBS_kwboot += \
 	$(shell pkg-config --libs tinfo 2> /dev/null || echo "-ltinfo")
+endif
 
 ifdtool-objs := $(LIBFDT_OBJS) ifdtool.o
 hostprogs-always-$(CONFIG_X86) += ifdtool
-- 
2.54.0 (Apple Git-157)

