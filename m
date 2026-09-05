Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC38C79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CB8B80D98;
	Sun,  6 Sep 2026 07:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8w3WsmjRY5FD; Sun,  6 Sep 2026 07:08:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2CC2580DDA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678527;
	b=ePxhELumYH+LeDhVWLPc7LDhIrNg4Nz1muo7FU6bRltsmzwH7uRfYeuqAXAZ5MrQNOa5
	 G7QWFHbJfOsr9Z1Xgzyny8VeaWRMNUTItmjIaoNJUDbcTbvS0uiXTOhFcQm9Ib2CVXomt
	 SyHby/fiS6JnI/OFCxaJNn21U5P9ylLPFcZpRZ6iLQbCI0in+e0XOhrmN0PSuJhHXaUlK
	 udkGfS7ZbwNAlWDG0NpJkP4OmiQWeEHPreqWSKErL1mt9lF7zmLeIkIWEeyQrHs01vGUx
	 rtRbf1Kpg6L1IWmVvjw/v4Z1U4SaL6H1ke7udpod8dtPOnDc4Do3BvEEKeUJpRPfuiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QsyNWu+Jhy0pWommSfMy424seadHbtVxI16m/Zrk+Oc=;
	b=qFGTRHvYTUABnnpdJaUa67IhD8CyuZVMT4LZ+6BcWCRIjfEaqFHW4dhcLP6c3HjppvvJ
	 vaRzncoHYj8HNxJHcq7vmEi84OVfpNqvi5+mjkNN9qFpWhY1kdHenEK/BbFYx0n0fkbRm
	 9fMTtqeO6BALXR2PAo/4jz89Dw9NCXNVsIvrosliYvlDlY5GxMpW79FhQMjkKCbp3rj0k
	 F5rye1xQC2mNtLZ4GIt3xjRMOMF7SixNB4b/N4glnQbeJVN9BFH8VRM5kYfynl48pM/Bq
	 mO3LXGemCxY/U+YRnlyPKFl7/BXg/H2oOfbv0UtbilN3uSo6Fz0pBDKTBr76bjl+KlA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qb8I0Tr2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678527;
	bh=QsyNWu+Jhy0pWommSfMy424seadHbtVxI16m/Zrk+Oc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UjTVh4pmEoyZtQ68StkhLZI8Pk+01tEHjXKf+3EyNpanFPVVfb9OMyQc4ONJCwRD7
	 GxN1XZ3G6joLbn++4QX+uZY0phNJaXKrnAjsREjbmh37bsv1Q85ZptBzKatywolX8q
	 3VBG107ZdDE850hFdRLlVc9PEMPyqD20R0tbNW5czvzsk5ueC2TSKGB2OU2mVesn+E
	 oxbmAeO12Cjnm8qYzl2WW1D/dNS7ilj1rUjqvgbkIylvqowXXVb/0RaWJW0aZIiiy8
	 uhB1z1NBynvcjO5N5s7ykkdUj/ljtSugjZxGoRI7TmZGCWtTFy4ZkdfgZtGMFH5fzA
	 opwTa3r8JqR3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CC2580DDA;
	Sun,  6 Sep 2026 07:08:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43223105
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 21:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 345DB80D09
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 21:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFju7OT39ys0 for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 21:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1346080C6A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788643112;
 b=GcYMOmNjBoIptcXrX9Z4CCu5DmrRa0aZbVHf2bFYYdhh1ajmCNiIZYNJZMu4AA7FnRzB
 ThDG710dZmWhEtuPmJuNPtJryC4wvG100aRo/b15q34v/XY4JcG4907jnAngAso5pDNoV
 88fQJeOAIktwoiHH3DrZ4H+D4qRC58LkpuS9Zfee1dCgzP9lT9NG2246AB23Vb84H0lNK
 MREmAv/AMPdTNYNhKSsxhuiuouJOanjqt5X1q+pWS7Y/DZwZO/HtRjjPRcID709wzK0+2
 iGghTZ6iK1PDOOeh6Va6fMO3nc2pZti8FvkkQTjLk0PW5X0h+IdAJ23tp4sTazWPE3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788643112;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=QsyNWu+Jhy0pWommSfMy424seadHbtVxI16m/Zrk+Oc=;
 b=jVcHY7Gj8LKuYoZVwo2o5YMJE9nD1w8RIh92GvSlMujYGhru1aEQe4ML+oZPA4b0l5aV
 B6ZTaYaDCj6xuVCd4R2RTWlbwLmm+HnMVMaIA9qoijo62Jm+amorU+Qo3uvo2g+Mz6e5j
 w+pUMa89EY9jsGXrxRMSts7J65zRCf7fYp9dHNgDlAW22NcUuz2M5qojorkE7L/il/+if
 qq+hGmzvV6WjkfF/Em3AbHJmKzRBXxEIJxGGWspLZKsfdEio3Ps4La9MSx/1cl7r9PmIn
 fKX+ERI+K/u1t++n8fsfIcqYnO9DHHVD7Nz4h1VF2Cur8q/UYHJpiXmmSJsuWe9g/qw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qb8I0Tr2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=xanmilanto@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qb8I0Tr2
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1346080C6A
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 21:18:31 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5b60bcf9051so1992234e87.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788643109; x=1789247909;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QsyNWu+Jhy0pWommSfMy424seadHbtVxI16m/Zrk+Oc=;
 b=qb8I0Tr2MDGe7Ft63dLX1O4sCo2yOuZMwyx4mVMQpEAxIcy/LAbbXkRvKpQ4ygzkP5
 QVhwmhFAbiZJmkwPnGNisiwZ7TjOr8jgasKpe0+Lq9GPU6M/aeMaHcJU7emtZkYhmF0V
 XBVOuijhjclrDjCiAm/p6OdRgu6SpBI01S9O+utfPYeDg/cpOLh97jguI5cc7UEs2CTb
 Xp/FQ+umUJbN9g4AV0CLciCCz2+orMvO59NdWMIwLGGAIdjNbqMGsDKuFCXsXtVVoElt
 mJCdIC2G0RmWYRB/1n5c9oqylvx+AqTdV1H+0yXaG5uyQSzGGPAdvpd0j3crNVNlVNq2
 mUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788643109; x=1789247909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QsyNWu+Jhy0pWommSfMy424seadHbtVxI16m/Zrk+Oc=;
 b=Lu48f4TzHphJAQ62cUDKCJz1E9q3uhGpJmkrlSb7B04/3SUZbVlbiUuuBg7tQY61wH
 HoPULewydQG2U/+CNtniCZbABoQh+JF0HlThNyX8Spb514/tReTQD3jUE6kmktya95b/
 BFGDHj2a7g+aJS59+dhSeKXclVSyKDbMu60DnWM83e0DGDACS4t4brj0EbG+j/WafeTi
 rkbeMCw6U9O/Q9L9xY4iP71Dl+uisk9FK9MMphR9Ru9ZbeXIUXdsJhsI2QGIxQrvcHVj
 RxLRTjZ7mgpnlDnM82L59A/GoCSkZYz5FVOvzOG3u1/CZZBtno6/kVmpEWUo4RLrBfj5
 1otg==
X-Gm-Message-State: AFuF++kkMvT07usw36fV6OLwccpHaFemqx5SqAwLjBQPjfoaWxTTiJ3/
 WB6YCQiHSnukmAe3xrCy7cct9tSNZwdTlL15vnuOHVIPRurqfj/HqzWRe4IzwKh/A5yRgA==
X-Gm-Gg: AYBFou2v1q1lIOgU59GV1s3vcaA1wz49YVg4lvIeCdTuLDJlK4YVvaPHyOGd58Y7pCn
 oRbNsx0g1hz1JxRkLXlkBJ09CqOlMeUCxSMJKHxQZrUXYdiYJK+19zF3SM/kCgpv+9N/uNE5oCU
 OMpLOEN/N0vqkjSY9MxFqoyPR/UfL+QTduVYE3bbc7ol1VUAxFY6s1JPF7viPYuxd1X9Gs9rRXZ
 erfPEyXCbvqvh9TJqro8fZEonTGPrJyymUpj8BqYpPBD9QF6XoSbURU3SueKgI92Y/wW4VE1ZFz
 4auby8Hkn8EDPngVMfWxWg6ngH/CRszOnq9L5xxTe5VwXAZl4fZSC6wcNiNqDIGRcFfYGpdCmhk
 ctW3KafelmqASVzTk3zDzJLAvhfNmpg578JpYgeSt6WasUlxqOASVmkkF03PreVhPfu/+OGxt+T
 i7e5Opsfk3Ca8ifFAPBLYYGC/DWsGJsuv5/f+22W/McSEVu8tMnOlI9RO0KnPBTTisLSSbz2MlK
 mGv79NPGt0kQKFBI6ouNmx1OiqnKrPENPjypkAerd6WJotDaeqD7PsN3OEyl/NANuM=
X-Received: by 2002:a05:6512:3196:b0:5b6:425:4bf0 with SMTP id
 2adb3069b0e04-5b61706bb7fmr4015745e87.33.1788643108849; 
 Sat, 05 Sep 2026 14:18:28 -0700 (PDT)
Received: from localhost.localdomain
 (static.197.252.108.65.clients.your-server.de. [65.108.252.197])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b61670537esm1278228e87.66.2026.09.05.14.18.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Sep 2026 14:18:28 -0700 (PDT)
From: Danil Bezborodov <xanmilanto@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Tom Rini <trini@konsulko.com>, Danil Bezborodov <xanmilanto@gmail.com>
Subject: [PATCH] sunxi: orangepi_zero: reduce DRAM clock to 408 MHz
Date: Sun,  6 Sep 2026 00:17:57 +0300
Message-ID: <20260905211757.60253-1-xanmilanto@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Sep 2026 07:08:42 +0000
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

The Orange Pi Zero uses a single DDR3 chip on a 16-bit bus, unlike
the Orange Pi PC family (two chips, 32-bit) whose values this
defconfig inherited. The 624 MHz clock was never validated on this
board: commit 8792a64d8770 ("sunxi: reduce Orange Pi Zero DRAM clock
speed") lowered 672 to 624 based on lima-memtester results from an
Orange Pi PC and the PC's value in the vendor U-Boot fork.

The vendor BSP configuration for this exact board
(orangepi-xunlong/external, sys_config_orangepi_zero.fex) sets
dram_clk = 408, and Armbian has shipped a 624->408 patch for this
board - and only this board among H3 Orange Pis - since 2017.

On a 512 MB H3 variant of the board, 624 MHz produces reproducible
memory corruption caught by the kernel's early_memtest; 408 MHz
matches the vendor and Armbian values.

Signed-off-by: Danil Bezborodov <xanmilanto@gmail.com>
---
 configs/orangepi_zero_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/orangepi_zero_defconfig b/configs/orangepi_zero_defconfig
index 49a1f4d0..09ce3a95 100644
--- a/configs/orangepi_zero_defconfig
+++ b/configs/orangepi_zero_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun8i-h2-plus-orangepi-zero"
-CONFIG_DRAM_CLK=624
+CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
-- 
2.50.1 (Apple Git-155)

