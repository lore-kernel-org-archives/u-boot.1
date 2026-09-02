Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D423C624DB
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 21:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD68D80D8A;
	Wed,  2 Sep 2026 21:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lU_lq2EAefD; Wed,  2 Sep 2026 21:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 88B9480DCB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788386339;
	b=G0M3yQo+Xl//jR88JchScEe/OLn1MN10AnzwyJogOr8m/rSPMwyO7cnsl+qUimlY7b0L
	 I9IEK3FKWFlRmsDzXBp/ZuZ8ImEbcv3QWbLM/B5rsehEggNKbV5qx4JinzJ8rjxWReVvI
	 tUx16UoNO9p6g5VcmWhxJN55Eb1d65Mz7f+NXgUWxa6Cdtg1UqUdiuKdUNgTxvM5jllAy
	 7xGfDtHHgqfJZ70sVNPNunGHGWc0DXCfYs5PSLZqNUBI//7ud7PK05OVqB+8ZcMU9+0Mg
	 voHXXMrGpACBItgbT8XdAcoYp8LV2jy1CGl9+f7s2kCh+IMxZ9+Zg2LoX4AuHV8J6aA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788386339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Dq/r8zKizDhqHk8MKPp+FwoJ5gR0w0JSSPd3x5b+YO4=;
	b=kCktT6D3s+qxWiu7+ISShlD4Kh4GaP+rfEezL5Ww/Za4q40hmWd0sPDEM+8ZMxWa1bLI
	 69X+oia5NUzsGEGH3lkoubcuwcdCSeSA1+mA+sG8OYUfeiRBy1xbkEXKTbDC6O3hh7ngZ
	 it4EUiezNKjcKDwK3hR4AnmrmM/Hm6IX8jDIOFCYLtFJtQrRNLIHoDOua3J3J26IsxHcM
	 1TsNpNt0SfNvkminTiTOlsOU59puoye265RIu/qgqAljLF77vEhm5aKEUCaJOdBxsSCT7
	 UTCsehSyEIHsB76WpAManl8D6ZbnxS+JeKMSclICLrU/S/4ISSI8IkAav1upOaZyMHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788386339;
	bh=Dq/r8zKizDhqHk8MKPp+FwoJ5gR0w0JSSPd3x5b+YO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdBao2LyxCs/GjiZZizLRHwM4795cx0fLZkUQiqvbTnRFUPKLYdqhzcTjMh4XDGao
	 EBZgbi1JuHLW7hzAMb4ifpAqFDsG3Crt82kK/ujmhHwda4Vf6VtXw1r9IBBgxuSOHt
	 xQjqvepzmEhaXvYP4HSSb7FR78x93GhpD8BIElJs4l1aoqkGI54X8iS370UpqfOQxr
	 soMMWImU0kNtcu4wDgt1nWtgEaZ7ExOt/IJi32cwWwwpX8Wx9OpAoZ+ljWpVBxa8+E
	 +pCJ+MYwwOvG1iT0FP8aUNBULzeIntVUTa1syG4qlCH/clCM+wADYeJCWbCPPLHTNY
	 Gvu46PMZGWexA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88B9480DCB;
	Wed,  2 Sep 2026 21:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2EB7230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8D90401B0
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4t-_O-dtKv5b for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 21:23:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7DA76401A3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788384233;
 b=r6WtFVYf0Id+oMsnJVw7nXoBkFmbDi8ZoSUfLUYRU7vs8s1SEn2E/mWbjSjFy7VO1iQI
 Hru4uWyI90iQz41k8UampQsAS7ZdBMVvR8d2pXWBkpecfvAgawkNfLtn6grb+4Tr9TGgM
 Qz4jHsIZbjUhAqoPf07iKlbDA2MMoqveVvyi6V+NivhOMp5T6W2nHt5mrh5GoAu04a6u+
 PzWGnacS8zhY94qMPKaZ80eCmM2EzrsFtGxCsXqJTxuJJ4pupIGD7gj8qIi1Gxw+S+BmO
 ihzA1LySub9ZOM710ZsBuxbv1snRiXREgHroXp+eQv5Hv62j0QxM/rz08vqjFamg5lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788384233;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Dq/r8zKizDhqHk8MKPp+FwoJ5gR0w0JSSPd3x5b+YO4=;
 b=YzYyQGUIb9Ucw2lnDLAL1MnxHmIxLmHi55K00AJzAFrUMejU+rJbwDyOA2IojSa1o/db
 qDy/N2JlNGOAZxK/abJpUUpYNZeRFqI9rMkovZxRFcBj77RfViOExUfQ8BfZusr/2C06k
 neHIGg83SvvbzcS4A3LzK9vI2CJMNtjgFjoraJzntXwU/gdknxuNrQdTHrx903BZVdaoL
 kAFvaVBwOAEjujb1fvH4vjcZ5m0O7sqzEAfHp1MSE1Jo7HKqf4wxdwJp3b3cBrn1bOVHb
 TTRE5818jMUUHzIV2YwgrPADU6m4wUJFvOFmKmv37RNt3OWlmRuuCnF3lrV7QdTnrYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=binarly.io; 
 dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=NSkWosNo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=NSkWosNo
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DA76401A3
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:52 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-9384cb251fbso102910885a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1788384232; x=1788989032;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dq/r8zKizDhqHk8MKPp+FwoJ5gR0w0JSSPd3x5b+YO4=;
 b=NSkWosNoH5EdAjdF9G0DfdkBpNHkpZxMXbqPIKBlB92il9UJdzS9EHI3mBY38yy5j8
 ilCq5qaMzTWJQS5ph5o/t6oLUiXPNYhsER6Z29EOdWVinqrIKLSTWKeH6IQfxrvPm8tX
 8t4B+a0FAxdjeyGPGOHymHkIXQHM+LuEai3V7KByQ6bMLG+ROjBrLtT0QpXoqzPQz/9l
 7ct1PGh0VzcCFL3tA9FSUGYaoX/+510ympgH63Kb72qm6zc5A3mKapwhAhCf2sJLColG
 Ig9ux/WF09kW4ottLIzxVCD4gaRyLbRHD/UjwojnV8RrU6RcaULwDJPsX7KpbOIriAe8
 u9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384232; x=1788989032;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dq/r8zKizDhqHk8MKPp+FwoJ5gR0w0JSSPd3x5b+YO4=;
 b=q1g/7gonf6+5QZJ/L/mHhpMl90r5q/V2dZRSHKTzbxJfcx7xurE1ovYNZRi7tiFcCw
 6pfK39wubSDi6zfSbEAsvnZLztZifaM0Tzi7qEAWqBheod8booPRDfKjgKpfm1h0L3k2
 kwFD1qRyxwoZHI3NO1tWOg5A6ifq9DE2TNL4UgJ8k0ZXRj3EiY8WjJAY1/bhYZ/Zup97
 Xdy9grH0sj0OGzIQGDt0uvabGiO4KhTzaAoRzlOsOw4cuvvdYc+V1rmT5EB1c2gWJy+h
 woN302fcEivntJlvJGgF29uqj2J8GJEAw/1fs4MMesQn+Nq/uz72Z0Fakd14eWbSwQVH
 +/fQ==
X-Gm-Message-State: AFuF++mVDFhfJMwAbAzYtJuSEWCtUmVazqPPqIvofzsF+tMGjwyp5qya
 DNY7s9rxqeRH0kHgE/ctjuWG/At9p7vohOmD/Jcr3Vx4povAI1NQO2ELpz+WDkHqX8k=
X-Gm-Gg: AYBFou3uoDn78Y/oN+jDjp9RrGJHZxERR2oIx9qa38QbmH7eAPQ8rVIlnXH8nGzdRle
 PnVcsYzHDd50zBEmvvOn+ZibOIVQCVhGlCfdSpM+qnEVhXWZ7rFLzU0LPn246qb1EfHYEOtyT61
 fZPZGYd2xtA+tNQ5aQQRRGU1Lffao4KSOjnpaYhRXPw4of22mNaREqk4G+9EHV3sx1VEEiVG82c
 cHe6T/YSd6G8XU9PMJYgjesUTUubFxuQdgJbs/fJcQdE7SQ8oYyafX159z3Zu6B+27aYcPcjFng
 hTYKcsu6MWrxbmM6ZYJR1ddCd6S0X9GeFx7KMNO5DzVGHrqe3SMjM9JIVjzZH0GSN8fseiGyWNU
 onFvAL+Lqhz6uLxQ0nFTwApe/xrG39c6SgUFkHm36S3Vzljwb99OPBzmAM9+ZtriSc9J5l6sWc1
 hMUNmoyU6g8EjUR1hwjpQaCcy9UuTvxb61lz1k0+O1rXCyuolHj2D9DSa5ANvXotQWhpadWCSnT
 88djxyIP7i+paH2
X-Received: by 2002:a05:620a:4151:b0:939:fa7:8df8 with SMTP id
 af79cd13be357-93960de3a2bmr975692685a.11.1788384231465; 
 Wed, 02 Sep 2026 14:23:51 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm19948755e9.13.2026.09.02.14.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 14:23:50 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 02 Sep 2026 22:23:25 +0100
Subject: [PATCH v4 3/4] spl: fit: Harden external-data offset and size
 arithmetic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-b4-fit-ext-data-hardening-v4-3-a884a5de96ea@binarly.io>
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
In-Reply-To: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788384226; l=11937;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=LLN5b/zePKV/AyOx2/3Y++SIHaIC/O16JqBV4iP/9Bg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNY+pMH0KAoRsTPYMLZvmqs/ykuvl35YPF4w6bjb094CbBRJjtaMNZ7NudswSOpu2+GTGhVTbIm
 ChAM+JAa6yAU=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Wed, 02 Sep 2026 21:58:52 +0000
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

The data-offset, data-position and data-size FIT properties are
excluded from the configuration signature, so they are attacker
controlled even when signature verification succeeds. The offset and
size arithmetic in load_simple_fit() can wrap on hostile values:

 - adding the external-data base offset to data-offset can wrap past
   UINT32_MAX,
 - get_aligned_image_size() adds the block-alignment overhead and
   rounds up to the block length, which can wrap past ULONG_MAX,
 - adding the FIT's device offset to the aligned external-data offset
   can wrap past ULONG_MAX.

Make get_aligned_image_size() return the aligned size through an out
parameter and fail with -EOVERFLOW when the computation would wrap,
check the two offset additions explicitly, and compare the
block-aligned size (the amount info->read() actually transfers)
against max_size before reading. Do the same for the FIT header read
in spl_simple_fit_read().

Signed-off-by: Anton Ivanov <anton@binarly.io>
Reviewed-by: Simon Glass <sjg@chromium.org>

---
Changed since v3: the new diagnostics use log_debug() instead of
printf(), which compiles out in a non-debug SPL build.

Code size, from buildman -S in the u-boot-gitlab-ci-runner container
(gcc 14.2.0). The 413 boards that build spl_fit.c cover seven
combinations of CONFIG_SPL_LOAD_BLOCK (BLK), CONFIG_SPL_FIT_SIGNATURE
(SIG) and bitness, one board each below. SPL only; U-Boot proper is
unchanged:

  BLK SIG bit  board                      text  rodata  data    all
   y   n   32  am335x_evm                  +24     -49    -4    -29
   y   y   32  firefly-rk3288              +20     -49     0    -29
   n   n   32  am335x_evm_spiboot           +4     -49     0    -45
   n   y   32  evb-ast2600                  -8     -49     0    -57
   y   n   64  imx8mm_evk                  +16     -49     0    -33
   y   y   64  orangepi-5-ultra-rk3588     +28     -49     0    -21
   n   n   64  r8a779g0_whitehawk            0     -49     0    -49

The rodata drop is the "FIT image too large" printf() this patch
removes.
---
 common/spl/spl_fit.c  | 98 +++++++++++++++++++++++++++++----------------------
 test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 43 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 9b16f91cc6f..65934674b6c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -175,22 +175,32 @@ static int spl_fit_get_image_node(const struct spl_fit_info *ctx,
 	return node;
 }
 
-static int get_aligned_image_offset(struct spl_load_info *info, int offset)
+static u32 get_aligned_image_offset(struct spl_load_info *info, u32 offset)
 {
 	return ALIGN_DOWN(offset, spl_get_bl_len(info));
 }
 
-static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
+static u32 get_aligned_image_overhead(struct spl_load_info *info, u32 offset)
 {
 	return offset & (spl_get_bl_len(info) - 1);
 }
 
-static int get_aligned_image_size(struct spl_load_info *info, int data_size,
-				  int offset)
+static int get_aligned_image_size(struct spl_load_info *info, ulong data_size,
+				  u32 offset, ulong *aligned_size)
 {
-	data_size = data_size + get_aligned_image_overhead(info, offset);
+	u32 overhead = get_aligned_image_overhead(info, offset);
 
-	return ALIGN(data_size, spl_get_bl_len(info));
+	if (data_size > ULONG_MAX - overhead)
+		return -EOVERFLOW;
+	data_size += overhead;
+
+	if (data_size > ULONG_MAX - (spl_get_bl_len(info) - 1))
+		return -EOVERFLOW;
+	data_size = ALIGN(data_size, spl_get_bl_len(info));
+
+	*aligned_size = data_size;
+
+	return 0;
 }
 
 /**
@@ -223,17 +233,16 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	ulong load_addr;
 	void *load_ptr;
 	void *src;
-	ulong overhead;
 	uint8_t image_comp = -1, type = -1;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
+	int ret;
 
 	log_debug("starting\n");
 	if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
 	    xpl_get_phase(info) != IH_PHASE_NONE) {
 		enum image_phase_t phase;
-		int ret;
 
 		ret = fit_image_get_phase(fit, node, &phase);
 		/* if the image is for any phase, let's use it */
@@ -273,13 +282,19 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
-		log_debug("read offset %x = offset from fit %lx\n",
-			  offset, (ulong)offset + ctx->ext_data_offset);
+		/* The resulting offset cannot exceed UINT32_MAX */
+		if (ctx->ext_data_offset > UINT32_MAX - offset) {
+			log_debug("Invalid external data offset: %u\n", offset);
+			return -EINVAL;
+		}
+		log_debug("read offset %x = offset from fit %x\n", offset,
+			  (u32)(offset + ctx->ext_data_offset));
 		offset += ctx->ext_data_offset;
 		external_data = true;
 	}
 
 	if (external_data) {
+		u32 aligned_offset;
 		ulong read_offset;
 		void *src_ptr;
 
@@ -300,16 +315,26 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		 * controlled even after fit_config_verify() succeeds. The
 		 * image hash is only verified after the device read below, so
 		 * an oversized value has to be rejected here.
-		 *
-		 * Bail out before get_aligned_image_size() runs on a hostile
-		 * len: that helper does its arithmetic in int and would
-		 * invoke signed-integer overflow on a value close to or above
-		 * INT_MAX. The block-aligned check further down is the
-		 * mathematically binding one, since size is len rounded up to
-		 * the device block length.
 		 */
-		if ((ulong)len > max_size)
-			goto too_big;
+		ret = get_aligned_image_size(info, len, offset, &size);
+		if (ret) {
+			log_debug("Invalid external data size: %u\n", len);
+			return ret;
+		}
+
+		if (size > max_size) {
+			log_debug("Image too large: aligned size %lu, max %lu (data-size %u)\n",
+				  size, max_size, len);
+			return -EFBIG;
+		}
+
+		aligned_offset = get_aligned_image_offset(info, offset);
+		if (aligned_offset > ULONG_MAX - fit_offset) {
+			log_debug("Invalid aligned external data offset: %u\n",
+				  aligned_offset);
+			return -EINVAL;
+		}
+		read_offset = fit_offset + aligned_offset;
 
 		if (spl_decompression_enabled() &&
 		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
@@ -318,19 +343,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
 		length = len;
 
-		overhead = get_aligned_image_overhead(info, offset);
-		size = get_aligned_image_size(info, length, offset);
-		read_offset = fit_offset + get_aligned_image_offset(info,
-							    offset);
-
-		/*
-		 * info->read() transfers the block-aligned size into the
-		 * destination, so this is the bound that actually matters;
-		 * len was rejected above only to keep this computation safe.
-		 */
-		if (size > max_size)
-			goto too_big;
-
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
@@ -339,7 +351,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 
 		debug("External data: dst=%p, offset=%x, size=%lx\n",
 		      src_ptr, offset, (unsigned long)length);
-		src = src_ptr + overhead;
+		src = src_ptr + get_aligned_image_overhead(info, offset);
 	} else {
 		/* Embedded data */
 		if (fit_image_get_emb_data(fit, node, &data, &length)) {
@@ -401,11 +413,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	upl_add_image(fit, node, load_addr, length);
 
 	return 0;
-
-too_big:
-	printf("%s: FIT image too large (data-size %u, max %lu)\n",
-	       __func__, (u32)len, max_size);
-	return -EFBIG;
 }
 
 static bool os_takes_devicetree(uint8_t os)
@@ -737,8 +744,9 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 			       struct spl_load_info *info, ulong offset,
 			       const void *fit_header)
 {
-	unsigned long count, size;
+	unsigned long aligned_size, count, size;
 	void *buf;
+	int ret;
 
 	/*
 	 * For FIT with external data, figure out where the external images
@@ -756,8 +764,12 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 * For FIT with data embedded, data is loaded as part of FIT image.
 	 * For FIT with external data, data is not loaded in this step.
 	 */
-	size = get_aligned_image_size(info, size, 0);
-	buf = board_spl_fit_buffer_addr(size, size, 1);
+	ret = get_aligned_image_size(info, size, 0, &aligned_size);
+	if (ret) {
+		log_debug("Invalid FIT size: %lu\n", size);
+		return ret;
+	}
+	buf = board_spl_fit_buffer_addr(aligned_size, aligned_size, 1);
 	if (!buf) {
 		/*
 		 * We assume that none of the board will ever use 0x0 as a
@@ -767,7 +779,7 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 		return -EIO;
 	}
 
-	count = info->read(info, offset, size, buf);
+	count = info->read(info, offset, aligned_size, buf);
 	if (!count) {
 		/*
 		 * FIT could not be read. This means we should free the
@@ -800,7 +812,7 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 
 	ctx->fit = buf;
 	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
-	      offset, size, buf, count);
+	      offset, aligned_size, buf, count);
 
 	return 0;
 }
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 49bfce15c08..557362ba113 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -426,6 +426,63 @@ static int spl_test_fit_external_oversize(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_fit_external_oversize, 0);
 
+/*
+ * A data-offset which wraps past UINT32_MAX once the external-data base
+ * offset is added must be rejected before it is used as a read offset.
+ */
+static int spl_test_fit_data_offset_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0xffffffff, 1,
+				  spl_test_read, 0, -EINVAL);
+}
+SPL_TEST(spl_test_fit_data_offset_overflow, 0);
+
+/*
+ * A data-size whose block-aligned read size wraps past ULONG_MAX must be
+ * rejected. Since data-size is a 32-bit property, the wrap is only reachable
+ * when ulong is 32 bits wide, so skip the test on other targets.
+ */
+static int spl_test_fit_data_size_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL) || sizeof(ulong) != 4)
+		return -EAGAIN;
+
+	return check_fit_ext_prop(uts, FIT_DATA_SIZE_PROP, 0xffffffff, 2,
+				  spl_test_read, 0, -EOVERFLOW);
+}
+SPL_TEST(spl_test_fit_data_size_overflow, 0);
+
+/* Device offset the reader pretends the FIT was loaded from */
+static ulong spl_test_fit_offset;
+
+static ulong spl_test_read_fit_offset(struct spl_load_info *load, ulong sector,
+				      ulong count, void *buf)
+{
+	return spl_test_read(load, sector - spl_test_fit_offset, count, buf);
+}
+
+/*
+ * An aligned external-data offset which wraps past ULONG_MAX once the FIT's
+ * offset on the device is added must be rejected before it is used as a read
+ * offset.
+ */
+static int spl_test_fit_read_offset_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	/* So that ULONG_MAX - fit_offset < the aligned external-data offset */
+	spl_test_fit_offset = ULONG_MAX - 0xfff;
+
+	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0x1000, 1,
+				  spl_test_read_fit_offset, spl_test_fit_offset,
+				  -EINVAL);
+}
+SPL_TEST(spl_test_fit_read_offset_overflow, 0);
+
 /*
  * LZMA is too complex to generate on the fly, so let's use some data I put in
  * the oven^H^H^H^H compressed earlier

-- 
2.55.0

