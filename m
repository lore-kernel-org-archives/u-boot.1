Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFC606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jFXAekes;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mC9/1i8P
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 659F140A73;
	Fri, 27 Nov 2026 10:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBZGQ8-txSOe; Fri, 27 Nov 2026 10:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADD5840AB3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775551;
	b=cdI+6oIYcC5TniFf0DHcx2dCebLIWczbtr84hf9ixB/pC3Vhkw3tV0qI9AUm0t/rV4r7
	 JNhdhzv61R/+5i+xUoQU2VKiyn1cTBUFHI9XrP5qVB3OCGODlleO7xuHN76ZhNoSCAwCx
	 /9YTOaeQGJ7XDgoD+f4+SKAnxmOntY5HSjxA7vQRxn816IsnPMf54twcc13yey5TdDGBF
	 Yup8X2kSz0YPQM7+muaGv199diZqoTUNMKeSpeEQXiYqRYRjNEipuwiS4s1ayb5xUZyzg
	 g4YR33ILjOEQhg5Qdi+kP1sgqie25bbN6hBu9wnjvPDM9Y0AAES2YhoIuYMXzVCb8NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TiF8rYT0SWdtDGOtPZYb9WmWABn1Ivuvxo+5RymQ3ms=;
	b=dlG1WpvIjjXB9FbypEOEROBx3t77KUOjoaTSKasSybSEwyc6dZ0DCCtCyIcEgc85Gl2u
	 rr/yEDYeCjMyMt7de2SHICRg8Ehyqn5ZVqAKh4uW3KYsJ+jHC0ARIoL1lOAfv1/t6x3vS
	 cAxKY0gEDUjquNTDJB6qcqiLp5YN7RGpJGMmsF3zQQ9icOxo3wPscqPuHapCmC5u2QwDm
	 aIU01Zr5ZWBxbdQ/UTkGzJK4eYcaz0qcinzvkGmujrpeeoikbF+1bjhrOkWiVty63PJI4
	 FBPCQNzPt9PCd0rwLEYUvjJ9RBEfboUpgtVZYUnXM+kQwCrbpLWzQvEz7kgcFQgFoLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775551;
	bh=TiF8rYT0SWdtDGOtPZYb9WmWABn1Ivuvxo+5RymQ3ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jFXAekes6HZhhkD/5fSQSVNSLgT+MvbyHkmDSzHzHQvaDH/XwVparaBNyPJHncsGA
	 KXyYBhjh1XowysXYGIN3BQXyMxJU05qDzwG6mt29mnDBrB8zr0qvtrxhFgokL0iXLX
	 Jy8FzadAlhpCXSS0vhCSxHNm0OK6oi9wN6Zq7CHEfWHl0WjGSvgbbsM9JsCv/+pb3z
	 7k+hIQdABE4zC01ZFvxbGtpvwCLm1JmjbAy8kfYMLr1DGlp/yRoN4gUEKIda2QThLq
	 84KfvEZI+vMJ/rSEoYlXxlj3usy1L3vMMy1LBtIp6lTO2HBV0r9DXEx97r52a/PvfW
	 WNGu5awS5Eu7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADD5840AB3;
	Fri, 27 Nov 2026 10:32:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D359266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3345A81235
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4tFVUIQEKIW for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9288681218
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=mC9/1i8P
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9288681218
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:28 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso16885902eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775548; x=1796380348;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TiF8rYT0SWdtDGOtPZYb9WmWABn1Ivuvxo+5RymQ3ms=;
 b=mC9/1i8PB6Wl7xoqCFL0haiKdto/djlicG+/nqbRKA7HB1YpA3yUpMMsNSfuFOszrA
 AScKmOQIWhngzVZj46liOJzw8LXJWDtFj13V+GPg34KiKE05s8UaEpZSZSWyhbEJYLQT
 jl9Wy9Ed9v+Zm93g1f4YRMzrdqfuK34K9QMWCjKiP5BxeGOzBoPPiw+2UJ+N3uabpd0t
 UPC8XPhV6EjpLYpqZTlr2qOzBJnzZnSphrEteGOTdsHSm5qSUJviT87NCWUCjTljTJWY
 qPJt/T3JnlPpIl+AgAKnYqb/57DqveFHh/Sd/xLfU3EGdjiW/MeglOMCZClrRBfHbZF6
 xR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775548; x=1796380348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TiF8rYT0SWdtDGOtPZYb9WmWABn1Ivuvxo+5RymQ3ms=;
 b=Ff3hVaHuXk45bdtMcEy2Ab5Kmva/Mp/1fProXwIZ3ts55Ghz0NN9lJQNW2cLTQlmTG
 0xL2UzT7wn1mrxrB5iYYaw67LhC01cP0Zi/YE+3otFNpioJmOKr/Cnc554bKwZxiyVM9
 uP4LYZeVGBMoLNBgPURbJbe8VkxEydqeRmSS6fo/4Hc34dSpINg/8Sv9Vqu4gaDnifFa
 wuTfrY5U029a3wBrfIzhWqrVgySlymXVsCuEjjaKVRfofepgldZexsW1JNOXmahvEM4y
 4ITdohfNpFvjkpQv0wF7M3qkL9kvGfcbQ7r6BQbppEJjPbXIxZqIwgipA0wfLeLHzK8z
 JXSQ==
X-Gm-Message-State: APuU4Z8G2WMFNXl4Gt/A6NhQVHVRTDuDIunWgB2fsBegu7T92Jgyjqxm
 pdZ66DZN4/aTHOUrLuvNRxLaGm9sDS1Dw80WOy4gFMyhDwkSxtZfy8K8TIEryQ==
X-Gm-Gg: AZFdTZf97J9bbgv8u91+s0Rak1PJBB8b9ADNMAFwzplv9qTxExEvnHW3HAI8K2K7Jqk
 Kd20FFRCuM8yAoZfdIvWhwxHIsof+WEKaxW7ZOZXxwJe9IoAZfNGp4zQEDV/vJzWa7FcRa8w86U
 33O9eYSLBbJc8xloytf7kjyqMxBvRUdHsU6lr4BZiaBUhjEZF5pc5hqJAoqv7cyoeKOoaL8263o
 NEb767tdltaua7+utA1K50BMuxqm/f3pt1qlgRcGaMr1eSALG3u+8riue4M0NIleOmD6q0oFF3C
 T6T50iCz3y3lwYfZbZw6bMvZOyHuxlCwJTzAm5ULIVKs7EmvCrLpg+Gqkimnas2jbBcbxbjsJtT
 z4HuSVI9zT4PqaNkrdpDJ1jjwznlgNqWG7Eg/Hsg47yAkIWuII6Bjixh7xi8WZo5WlR223Dmv6S
 ahDrDVQr3PSckH1pKWrOFAkIDlhbCn0CnTi046ULf6zUx2WiAtfUMvyoDxH3GEP/HvywV74g1XC
 YbRiozuaGl3OtaJI/a65X/m+b7M0wGrXv6jEk1xrlVnmwbY02BsWvMLsUJNncWEHu7VJKLbdpz/
 o6dBB/P7M2yDRT7rVTto4Y1AmY8L
X-Received: by 2002:a05:7301:416:b0:356:7ddb:2e54 with SMTP id
 5a478bee46e88-38570f27b33mr24090423eec.29.1795775547588; 
 Fri, 27 Nov 2026 02:32:27 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:32:26 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/13] riscv: dts: spacemit: k1: Support multi-DTB SPL
 images in Binman
Date: Fri, 27 Nov 2026 10:30:12 +0000
Message-ID: <20261127103030.4647-14-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When SPL multi-DTB FIT support is enabled, the build appends the
FIT image to the SPL binary instead of generating a standalone
u-boot-spl.dtb file.

The expanded Binman SPL entry expects this standalone DTB, causing
image generation to fail.

Add the no-expanded property to use the combined SPL binary directly,
allowing both single-DTB and multi-DTB SPL images to be packaged
while preserving the existing DDR firmware alignment.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/spacemit-k1-binman.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/dts/spacemit-k1-binman.dtsi b/arch/riscv/dts/spacemit-k1-binman.dtsi
index 2ff6bd2cc43..9e75c0f5f08 100644
--- a/arch/riscv/dts/spacemit-k1-binman.dtsi
+++ b/arch/riscv/dts/spacemit-k1-binman.dtsi
@@ -12,6 +12,7 @@
 		pad-byte = <0xff>;
 
 		u-boot-spl {
+			no-expanded;
 		};
 
 		ddr-fw {
-- 
2.56.1

