Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB17606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xSfXOoRd;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrBVjw9q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51F4D60822;
	Mon, 16 Nov 2026 18:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ToBjBI6R2vts; Mon, 16 Nov 2026 18:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77FF26081E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854391;
	b=neXMo0PXbcFqqG2DHXSp83/S9PL34ZZTWDy+5a4dUcMZ0OpYN+u5WWT37XgxHTqdKkOf
	 Q5PwPPDOSIZsl6NEta5t4v90HzpPYprTSQc1/dX2Y6t6KHWHbKZ3fHMwf76I3Ce3t3sCz
	 PIbgyOmhJqqq14h1DYaLrbRsyfMWeRhN0HjC4Sa/0RqvZyR2oQcrd4o0t0vnOaDpZfC6/
	 zDnO0rOEUsJNq2cJzShP9h6Mr3qhJG0eVebZlmUJJsZcpL1mOapYKM6MNVBHeBjegZTDN
	 UPJy6ZkamMevbHxbXEV0tu4sRZ5C1nfhj9HZu5sOibGy+nWub6tZXoMDrpYwNoQk7xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mHoFK3szNFDAXn8ZfwF5xEFujocKWP1eG2sNlrQjSUc=;
	b=td7/5+R7RWWm6KnqHOcj2EGA/ZwgPRgUs9H0kwz75dIlDUewDVvXzzHiwnPiMv9yxYW2
	 3cJ6S69KAfZYQQHKdybcWBjL1iUEVm7FtC2AM/V8NJIs64vVD4e2I8NxU8sWWaLp3iSda
	 aXT5oZe8UjDmg1dG/GCpNEHKwowZe4LgXiDLK8S3VS9LToZ0LyLhYjbH3yqUtTnrsDnOC
	 ZodE71jRGezU006NTuq5M1VKn/VEAiFv30YJwSIG6el6QQ8UsRGWw4QuaQIBhkmTItf+D
	 R7F8tNdQ6s/Z80Sc02lvzIQUQJpxMwOLsVtkab5HuS24zsiNC+myyPZzITmR6Krd6sg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854391;
	bh=mHoFK3szNFDAXn8ZfwF5xEFujocKWP1eG2sNlrQjSUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xSfXOoRdANmoXVeauBYsf/LobS5kcp7Jw4+p/sJsQVurhBrJJ5/FyfONjFpWguyh5
	 G4i9pYfXChWCwcaT3PyGhtXB9D5B/llXybb339PD4dfaBuzGTQAHaCuU4gkL+yYPqa
	 1z+VU1UjfE7GHq/VQQq14NL17yjX7HbjCmfhswxtytpJIlIPpK07qbtn/ih6c7v1l+
	 aV2iJykJBAX68neP1dwphHpvQCaLMplAEswOOSLOnCtzV5NqbF9+JVqslfA+JJj4yD
	 npco2q94Dt6qR2Oi3ZGhz5jGJtqiOSN3EfCm05xJMjy7OE61v09jvplWLZJSW3h9TG
	 6/Bdvi3wj7nqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77FF26081E;
	Mon, 16 Nov 2026 18:39:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA30670B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC79980C50
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7QEhN1ecfR0 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:39:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1BA580C2D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=JrBVjw9q
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1BA580C2D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:43 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so2456968f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794854382; x=1795459182;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mHoFK3szNFDAXn8ZfwF5xEFujocKWP1eG2sNlrQjSUc=;
 b=JrBVjw9qPTsnWC4uyjAvTqGaQPX+1WaIYgFJ2AahUqdQEM0JFm5kq5WZ/V9wQS0hKg
 bkAnOyRTdKexfD2dgHqkCRJ0cN1MwS0lvkUItmPmqk9eTFWDEJY5mk9KIMVV5KRCR4nW
 wtkO23cm3Qg+QyrB69iKvdsDANrKqiZ2MsrrfNsKfFXCMiXB75pFEpO0eCcKkUngwkHc
 j2pnEGFj6XKZqOJzX7MhdSR5UOVaAh/bwTcg3ArgJqdQGcpsS/52o9JADpf7O12EF6qM
 C97JLRqMDC4+z173Pklln4f1Jqmd5MZNiwkppc7ug8pMqVXw8kwkSkuYcumDxD+0R9Cu
 I65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854382; x=1795459182;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mHoFK3szNFDAXn8ZfwF5xEFujocKWP1eG2sNlrQjSUc=;
 b=YNzLprlqwKMxEoeKkTP5Rx2MyO1lAijNSdm1sqmUTYqoZvNyaJon09ztCBUsKhieQ7
 ftQYLLTdB9+oXH//rd2D5TrI347IOqNKzf3YwuTW8t3IV9hQSWdMgskOounEX2GRB/sn
 Yohb+dPjW7jJ2AJ7+PeCc8u6FVqNGGp+QAeeNxyJ1+m+zWeFsBI+bnmePzATFMgxTUwo
 KRbz66vOBi7KIuP9Qnkq30f/HJ8092TFPiVsJUQ+6vZTezx4mfzoe2+ITZOPI11i1wCv
 w0i1bXZnAj9V5IX5qZKhtsUWs3yL0z/3bGKcPu2jyOLutow5Re8seGRZ2NQ85Yc3T4mc
 PTww==
X-Gm-Message-State: APuU4Z+o2RljV01KjUhkyTXPoHtRT7qvdtOhIdGl5uB6ceC0rSgjaLoK
 mVINHGTy3SI9f1gca6I5sCqJ+5+UeGC8xMk8+6KcaYCItKn4xM5fNuqh
X-Gm-Gg: AZFdTZeYZV+gi0uPRhWxcxv+36W+Ng1VjtRB2FsceT1qFuN/DCm2bb7KHAsv8LHtP+F
 8xnlAAUd1iS/0LoXoPUl5mlwjUX0wsoJ5/niM/G+sII96JrgWIJ9BtTKps++ao6P3Ovb6aXClgT
 DG/xARUpc2gKvtYBJBQgUWWQIgGHn/fsOuf8d1IxLsqyULuptVjaC40orLQTv5RBSPmS5nc63rg
 bK9GaNhYPgru/AcR54qGu+6wIo2SHFjWYexjALdO6STg+tjasU52Jwv6+b2rJcBO38NTnIvcrUm
 6lFF+qyaXTNk224zn5Z+n/oYt+EnWyWivhCFGnK2VBedsPbFULWUXyQppjWHahLchI+XHHD519X
 Jb6DB7D9eAMUdIpTVYLG+cRzn6UcD0fAoYXShTXtCFbS2PPJmSsGxP3KTyIhbC3dYuqKBDH4CEX
 Cxf3EL4sJGowb0bvjy6izNPo7ZgZ8n6BeVtZteHbyqb5CzqjtRSMHw4iwUcdgMjSrfKc+bvqjKA
 bTJhGnhZlSz9ocWlsAeDyZfxKvNHGFK9y5pIPHnSxKFTniO4ZJz9b6Rt+lSZascuV82ZgI1oJZc
 nMyTbKV7AMDlBK88hm2WCOB+BEdI+4UA764JsySp
X-Received: by 2002:a05:6000:428a:b0:491:8462:20be with SMTP id
 ffacd0b85a97d-49c70de380emr26335494f8f.12.1794854381678; 
 Mon, 16 Nov 2026 10:39:41 -0800 (PST)
Received: from [127.0.1.1] ([151.71.173.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm23947618f8f.49.2026.11.16.10.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:39:41 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 16 Nov 2026 19:39:36 +0100
Subject: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
In-Reply-To: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

The PX30 and RV1126 sdram drivers support more sdram types but only
one type at a time, really. The type to support is selected through
RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
more than one of these options is selected, instead of relying on a
debatable and embedded priority order to choose the one to support
among the selected.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/sdram_px30.c   | 7 +++++++
 drivers/ram/rockchip/sdram_rv1126.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index bdb9cc9031d..14d8f2e293a 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -123,6 +123,13 @@ u32 addrmap[][8] = {
 
 struct dram_info dram_info;
 
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) + \
+	defined(CONFIG_RAM_ROCKCHIP_DDR4) + \
+	defined(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
+	defined(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
+#error "This driver only supports one DRAM configuration at a time"
+#endif
+
 struct px30_sdram_params sdram_configs[] = {
 #if defined(CONFIG_RAM_ROCKCHIP_DDR4)
 #include	"sdram-px30-ddr4-detect-333.inc"
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 3d7cd076a51..518ce307cc1 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -66,6 +66,12 @@ struct dram_info {
 
 struct dram_info dram_info;
 
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) + \
+	defined(CONFIG_RAM_ROCKCHIP_DDR4) + \
+	defined(CONFIG_RAM_ROCKCHIP_LPDDR4) > 1
+#error "This driver only supports one DRAM configuration at a time"
+#endif
+
 struct rv1126_sdram_params sdram_configs[] = {
 #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
 # include	"sdram-rv1126-lpddr4-detect-328.inc"

-- 
2.34.1

