Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A230C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 00:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31C2C60674;
	Tue, 25 Aug 2026 00:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mR_w8LACbk2d; Tue, 25 Aug 2026 00:46:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787618768;
	bh=kmjko95FztuRsZxIvTX0v40s5UBrg5wK555A2+5TSO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lk38komoir4H+s0T7VpI/0nINrQ4hSeGqgqP8oW6gBLNylez3vq86AUAozhKkYmrO
	 8w4Drt4xakIDy7eZv+p2xGmgGd36saR9b27VslX3E884G6tEkQOdyqQ/2KDpW3h0Gw
	 krmfJvn96ww4zrTY9Qkdz54fRZxi8pDW60mRxiH8BNQ9nYID/nSc0WyOVeqcyS5mnM
	 5gy2IQfXoZFXYYFtpVWgk0RbEFhkjQCIzF4UwAsZ5FXtr4gTaDyN3lpXtLK0K25VE7
	 h4liHzOTuJuAK3ASYb0RcNuPnbtM85U1S4FVAVIlquyuOGymcxQBQzU/zFswKYIL7Y
	 43pPWVmsN/XDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0667460667;
	Tue, 25 Aug 2026 00:46:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1442529B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 068864005F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oE1vrVJfKPmI for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 00:46:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KI1Gx14A
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50EBC40050
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:46:03 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4518ad44e83so3604922fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787618763; x=1788223563;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kmjko95FztuRsZxIvTX0v40s5UBrg5wK555A2+5TSO8=;
 b=KI1Gx14AjNbA5th6Kii8SMFVFAKimIV+vGsZ3TaernqKBXltq6dN9sAnqvZVQRXaz9
 FwzG95rQny+N+nr9MFl5jPW8n+035gaI9CTbPE/2rSnPiDGIO2Qg1Y3F99QFl8IHfrqt
 c/S3rc7lYquK7sEdbGqrhob38a9a/sD4is7Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787618763; x=1788223563;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kmjko95FztuRsZxIvTX0v40s5UBrg5wK555A2+5TSO8=;
 b=PHubXQPaWptAaLCve+XAaPZm7q3EhiLzUMEL0/LNSiE1UZ+bMxMTUkOfn62yHNq/GO
 nKr49vOU07J6OciV8Wm3JQPBfsmcl1ht26Fr8mBfdHQeTuQrdRRULXPNTIwMyX+NFggK
 YZytZ/FoSyWuZQYt29zVL2PF68+GGLpkz8WPXjROcEDnVAZFaAklAwjbn2HSrywo4N8I
 nZzVi70CYu+eHCDg4o5dBmT1d6XNeXztkHuQc8pfSr4GvmrVLDcE7pocf/0yFBOPmZLa
 0UwbqMtvTjDtpBvDXnANDqCUE2NkpxDf6ZIBl4TjHVtTP4seBsnkhtEYrcz2YdoXDOEZ
 aGng==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLLqz2ckBxx5e8CI5JUgFJZwJo2ispMlhRQkZZ6xYlPlHx2deLBMY/Er8PQueTW7nas9E1PXc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mzU9qgbeaR5ulkCuk/t1yXs3bYSqRLvdSNIfS4DvOpEZ8YphZa
 jNYBXrCv58YsRR6r28TaEI39uJZTjTdC0Yov6Pj9fU4QSW/oJeWz5bnVc4HS2JfU0uM=
X-Gm-Gg: AR+sD11xfgmzhME9wfA5iVyGP4CnVXFoAP4mIZjA2IGyUtG64Wu3oT0rB1OOAWVJUwe
 comL8fhhpzjEJRUHUQhiSJaUETt5n9aC4l5tOuFqY4IXVGGuhCY4LOXOsiOu2Hh9UgbxNDExzfd
 qp49AsSWURBFHL9CQol6zVUMISPmSWca8GSnwl/irKSikExZZPiILhb0kHIWPRMOijpG8nryNUD
 diOQXicUBoEh3GK4BDM2uQV5MbzF417n/ihzThQ58TWXT9zBxTvVVTxiGJjlyjtmlTX1OeYkZiU
 cK86AaFeoR5grhxu8JNhVvxdg5O2BetygflIi7ONI+HUwV1FR6P7oCq7KeHaQ+LCaJ6xFPOqsnP
 X2C1y7aBmB/KbhzBi16v1U0hPnMNYdROTgQQyKAmaYpuHNf+PqFWTE7krVH05S3K0epgFe+Jq8g
 tIFNsN4eRnVM+mXH08oeisDcAnZR9XUm6BQeb4BHPxbi91FTiIXPXl9M0jdJPtBszXEEpvbRUbM
 HLNVUwJvzjh91PoZnEINsFYeDJWsm7Zno01BgyJJUfW+JO/tp7oYYFkeM/3rF5qmItq/C4pLfBM
 N2L0/bJQ4Vxm+eTnw+8=
X-Received: by 2002:a05:6870:5486:b0:44a:e7ac:b14 with SMTP id
 586e51a60fabf-4644a3f6562mr2567591fac.11.1787618762868; 
 Mon, 24 Aug 2026 17:46:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463831af959sm6502486fac.5.2026.08.24.17.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:46:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Randolph Sapp <rs@ti.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Joseph Guo <qijian.guo@nxp.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260811231650.3150771-1-jonas@kwiboo.se>
References: <20260811231650.3150771-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2 0/3] boot: image-fdt: Restore suppression of
 irrelevant ERROR message
Message-Id: <178761876177.724197.10127791800130852948.b4-ty@konsulko.com>
Date: Mon, 24 Aug 2026 18:46:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 11 Aug 2026 23:16:46 +0000, Jonas Karlman wrote:

> This series changes the returned error code for lmb_alloc_mem() and
> lmb_free() may return to help restore suppression of the verbose ERROR
> messages when FDT memreserve and reserved-memory is being processed.
> 
> Changes in v2:
> - Change lmb_alloc_mem() to return -EFAULT when region is not part of
>   the LMB memory map
> - Change lmb_free() to return -EFAULT when the region is not allocated
> - Change to use a debug message when -EFAULT is returned
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] lmb: Return -EFAULT when requested region is not part of memory map
      commit: 93e5e5f4cbefccab206a79f86e98c2c39a9d2440
[2/3] lmb: Return -EFAULT when freeing unallocated memory regions
      commit: 480644c06e202abec58543aec502f218939fff1e
[3/3] boot: image-fdt: Restore suppression of irrelevant ERROR message
      commit: 94a09715bf4c8dfdefbefcd341d0c9da04c5a6c1
-- 
Tom


