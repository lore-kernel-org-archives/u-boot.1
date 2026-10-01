Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12566CA5FDD
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D094A40C9C;
	Thu,  1 Oct 2026 21:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJb7SESV5nG8; Thu,  1 Oct 2026 21:24:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EB92940C8D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889892;
	b=VcSsMJxQLBNmwBOB58bNWy7bTNyNpaGXv0/1LXU/lw7N2n1EcEhTDClkFPZaumnR8jmE
	 83oNyzE8Pvc67K3a+o6eTuGATMkO8Jo+kG931xgVIYvuPfacsI0DJtv9/O95U+2pPmPqM
	 kPp2WtVozzP65hUWDD8NzNT/I5uAv3dmc1KMLctZRbMXon30aCiuJoIlOMnxCLgqBXaW5
	 vA84d0xamY4MeQOumSnKx0e5DkW4F/Cd13mKVb1aA8xNXfb2c/t+QchfusQt229pJ19Gx
	 cd5zwmdFRa2kiX4YMCLheTvZIuUkJUTSeRvDlVjDvnVxFe6hVJL1de+58D+QE3G9Lqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8slH5UHXrK+9I+e4YvkjcC0hO1EYpLieaAUQKoYUhU8=;
	b=PVHBauh4akSLOa/rg/ylsnaVrG2d1XslTVVFbRifWDa/E8jJydavtFGYDixqLv6bbbMj
	 HcGpqPE1RyfMOYDayqFLn0ipylAYIMFOa42VQooPlRQnE+9UxrmfGO780BXWK/wsYkKGD
	 IvGXppTXValrx9RYESwSGKRR7uBpJxzn62hBBqs1D35nDIcgUSx7eCsda1Yu2mLSgvqWb
	 zSnHpk7ncsDpd600Ga94CowXqRgLvT394nDBbwdA37ZIyGC/dDolbB/lEUFxgfP0wnGam
	 +H8BxEZZLT28ePWmtXtIcmQ3o5dk1JP7WXrT1/47cqjMnHtUPzA8fI/wFrIWL72TEmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889892;
	bh=8slH5UHXrK+9I+e4YvkjcC0hO1EYpLieaAUQKoYUhU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nu+lbcE5kqVOljrikRTbk/D3vlaiZf5OC5JzsYo07Ko8Au0N0C09aZDSPXDjO5eEJ
	 Xifds4f7DmBCTq9EfKkW0nhX2R1Fx3l/nv6C5Ylq5JA0D1ytTT9ZvI7SLR+28bLH1m
	 2VHJcXMHsS8AEfdrwONzPe6G+0xs6gJvALyh9k5WbzbtAEpYLYY8tW7BgATqcziTZx
	 trxFF+8jHkcQqDDIw5IKzHjHAzlMXXwInFUPthglgmnAv1H3ZfRfc9dCrGE2KvDOQ+
	 kn6u37d3YmlbO1k7j+t00bN4XjRsB6nj9rx0LRAPqQ9RJReDhQ+RcdAsIZNOG7TJgp
	 1QVJBqxC39iGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB92940C8D;
	Thu,  1 Oct 2026 21:24:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC6F432A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE48340062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnYO-wbd2Kue for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2EA1840022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887519;
 b=B3Pjik3mqj9P6KxWeRbbuTsJUzRbu5UwR7K26m064Qi3VW/mh0NA2L/OYkmljuzXj6vg
 vsLzxoJ6867Aunv3T2RaztlMiMc/kBcgNqZgmnzSRWwlF9pO5kShAMc3U53Nan1RaYFu0
 0ypZLs1UhmG8qurUTMjh1Mw9qQhWgZIqyp4gZ+LMFpuD8+cD6IL6f1yD44OCxIyi/JPWQ
 379Pqq3P8SmvTZIFsfKhcdy7nwcn1NGmIDw2CL5nzS/EO90Mk4hkxO6Oy6IZOnbN6sxKi
 /F1y2GVZ7nf7iROndqPSQ+MiVw3gMlWJfV9h5Fh9xoGGVvAxzHNFzN8h51jnnqVX8kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887519;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=8slH5UHXrK+9I+e4YvkjcC0hO1EYpLieaAUQKoYUhU8=;
 b=nTmAuaG82JTcUQEAA1yjYdtx2wMARX27hDMuNiXlCKf+CMgVNbgF5uGLcRIVla6+Q4Ht
 Hhe/u8EHT8CBh7e8ISLLztZSzkFZZhgNz+l1WmBWG4IDSZ7nO5nPLJPtPIQZM2SlxC8R0
 SwEV4NAQ6KPdoTnEZGiezfbKwY2XfP4qn7QiMCcUkKJzsq1jT8e86pyYyvjOIYqwaq4dE
 jl1iGmmVIKVRX2XdbrTUoPRuabloOspFWTA2diks5Vu90YLiikJlTDKLqOgv71wj9npHE
 sGknXaDoS8KrQydVe9+eRnpFPV2nvu6kZ3MiXGU7+csRDpw+osztkDGm3h8uvrv2b3w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pmsDGt1J; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=lqing2013@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pmsDGt1J
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EA1840022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:18 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-3a4c8262465so2515154a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887518; x=1791492318;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8slH5UHXrK+9I+e4YvkjcC0hO1EYpLieaAUQKoYUhU8=;
 b=pmsDGt1JzkfFoiXWvXH5z6IKcuc7TWHmyWTWaB1yQquhjaw02lTuRo600Uka9YAnX0
 b2hF9wg9vtLNyXXEwvo+jG+D+lORp/LzSNr0hPjNvfPkmZRuiFWcXIBUBZcZP906HuRj
 0WUxrbNJ0RSFNxvkokiEQ+mqlMrLMhGkMeIPduSWGHntoGYWgkz6cscOBmFI2l0eXC3s
 jmlWG/1N9p0LykNqa2Yso8Aq9frxT5PzYyphgjUZurH+kw4QO36wA/UcTZ2vu+wo+a9Y
 LiJ1/BkCFAPNCN/mVORTA6RkES/Bl0bYm9kqZCKkANzszPdZ8UySzyUDppku7fvwDy6N
 pmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887518; x=1791492318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8slH5UHXrK+9I+e4YvkjcC0hO1EYpLieaAUQKoYUhU8=;
 b=XOeKEdPRNcvXKkg2pf2FoRPqcmm3GlJykLvqHLlFzumLzawML9bF4phT6CzEuROQy9
 BDZWh5hNujGWHgmBd6nd38zO8BKRDSMWbvPTXOjAlT31jeBXQkrMpxtTNCEF74GszgB6
 Ff1ZlqWTYCAeqhrJ67ME087hUKtMnzlmyq46sBlEcwhaejInmsmpDJmVxWhr9Ws1a88O
 HNXRv39qCaVLwnncuNDFEzLyQnnGLKiOQ1O2KNS/tYRgmR6k5+qy118VLHF55Tr3B7ie
 LUMmqKn4enSwkkAZeLuxcvuQJYXA6x7Sv5XWeN5ue12TxgKDgMQI8Akm3jOeBUKl2Cil
 lkkQ==
X-Gm-Message-State: AFq9FYI0cPUojTTE/Orlys0+sZRaHDBDkixw2CdmU+Z4C/8Vlv4MSlt5
 Dh5Au4ua935pIAsY9GAvV/j7ypkPjpesKC+t85VEk98eSd/269uYF1PDEBhKTAIb9hZ3mw==
X-Gm-Gg: AYBFou2n/O85/p+X/VR3EYENL0vR3Kp8BDyRKxr0NLYjEmw2IcvTKlPDCP+hFzD3uf8
 yp5iiVi4D9XJo7tW2cQ8wl1mbKLhxW05xa2a2C7g1DTGeGsVGt9c2wQMXSfVZuLvTeudWK6LpI2
 q06KyUbpJZfABOtqUBR5j7X58AqvjZbPpCDUjoOzsENhBt/qaFxxPyjl8DLeRo/aaU9aYCvDyt3
 eMvSzU6O/Pnw364OjThDxFjqMJ4Ck4+PvbItTSwQIO84nyyI3dqNpi+aJYmwz4yOIFDPzK9fn7o
 pDoVoUUJQt7E+e7BEBKntsun0YU2YPXNhABkonBz+lE45MWN9GKHFqoMcilEK9R/fJfUlfqdv+i
 4o6iVhc6qA6bbe8Ub3gL8RQZl8ZzBi+3G0gTdpR4gD0TBGuOaSNVA/D7WkCh2ze57oG82b8wHYt
 sEsFW1PDnFY857JvstV2SR6B5V85FwIt4JC75Sa7gq+qi+xmdPd6z87TDqnB/+nrRz58YJzxyVs
 OGGvgOCWBeW5M7/vVt1JHBFxambK1B623x70A==
X-Received: by 2002:a17:90b:1c12:b0:3a4:9f7f:8cc1 with SMTP id
 98e67ed59e1d1-3a6ce75d149mr688602a91.24.1790887517895; 
 Thu, 01 Oct 2026 13:45:17 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:17 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/9] boot: image: skip FDT reservation replay after the fdt
 step
Date: Fri,  2 Oct 2026 04:44:49 +0800
Message-ID: <91ebffa79f9c5a6d3ab0d05d35fe5f113cfe3555.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

boot_fdt_add_mem_rsv_regions() removes the ranges described by
gd->fdt_blob (the U-Boot control device tree) before adding those of
the new blob. It runs both in the BOOTM_STATE_FDT step and again from
image_setup_linux() during BOOTM_STATE_OS_PREP.

In a stepped boot (bootm fdt followed by bootm prep) the second call
still sees gd->fdt_blob pointing at the control device tree, so it
frees the control tree's ranges a second time. LMB tracks plain ranges,
not their owner, so this also drops parts of the OS device tree's
reservations before re-adding them; the re-add then fails with -EEXIST
for the LMB_NOMAP regions. On Xiaomi crux this lost 128 KiB of the
XBL/AOP reservation at 0x85f20000-0x85f3ffff.

Only add the reservations when the separate FDT step has not run.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 boot/image-board.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 67938fdd200..70af28b8a46 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -918,7 +918,14 @@ int image_setup_linux(struct bootm_headers *images)
 	/* This function cannot be called without lmb support */
 	if (!CONFIG_IS_ENABLED(LMB))
 		return -EFAULT;
-	if (CONFIG_IS_ENABLED(OF_LIBFDT))
+	/*
+	 * The separate "bootm fdt" state reserves these regions before FDT
+	 * relocation. Don't process them again during prep: gd->fdt_blob still
+	 * names the control FDT, so a second pass can free part of the Linux
+	 * FDT's reservations before trying to add them again.
+	 */
+	if (CONFIG_IS_ENABLED(OF_LIBFDT) &&
+	    !(images->state & BOOTM_STATE_FDT))
 		boot_fdt_add_mem_rsv_regions(*of_flat_tree);
 
 	if (IS_ENABLED(CONFIG_SYS_BOOT_GET_CMDLINE)) {
-- 
2.50.1 (Apple Git-155)

