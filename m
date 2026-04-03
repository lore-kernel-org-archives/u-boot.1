Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF9FE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15BA841C2;
	Fri,  3 Apr 2026 21:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l8RpR0T4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70368407E; Fri,  3 Apr 2026 21:47:23 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DE48413A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d9d929e27aso2003510a34.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245640; x=1775850440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfgM3/Mx0+8l16mmqSokngQDuqhtmh8AFk1Dfw5zsS4=;
 b=l8RpR0T4Nnc4JtthDoEt1xYVLzVvat+CK0rK3wHHy53Y0EuI5N14tl06bWHNQSExFQ
 Pdc3FyJ9y8ChG4xXnDHxc4OY6XgPF51lhiPYJDqA0AvRHLsaAoR3xTtFJ+CJLD5XqJpn
 zdSaUMDBpNVi4SCVU65Dd9tWWIFCB5e16vYdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245640; x=1775850440;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lfgM3/Mx0+8l16mmqSokngQDuqhtmh8AFk1Dfw5zsS4=;
 b=K8gtiRXI30+RTAo4IFuRzT0dupt1v4BKamcEkv2ej9Etl3q62A9e4+osVOzx3LSAFb
 IviBtbtQcVVEP+lN3xu8KrVIsUN4t3cu8c5ku0U4/4u6VBzcgB46vLb/8XfEblMvgWC6
 qp3U5/w6nZR5XzddZg61DuHcT6EinojTe+0k1hzSpAz14l/ahpX8mtgxxCp//IDIZ81X
 jiM4lj/ybhVd4A9+YrwUCVff7pE86RL05GMSZUF+Qfs+wkVigDCxdGLsB3Qa8LBhXG24
 vnsSuO4igxNhyw5xYhbyCjrg6z9MIi20ljPDMx+ihzwtaEPu/RGHVj5J++U5B3XbOr+j
 034A==
X-Gm-Message-State: AOJu0YyW8QMnR9N2i6BhyFKOwbyEFJ+dtVDqZiB5zurQS+YQtnLbYoq5
 XckxNjHW/NQifwAdORC7oCljI4wUG/oMz5haCGoyTho4gQ4VKz99FjucKxHg6c8ZxMg=
X-Gm-Gg: ATEYQzyGYLJxbONVm7bdNrSjhG5HFj02hLtVllZm82cA1RIEvRFy1IitrvArB9ITKvo
 7okIuXAeuJUycNEKwaB5ReeRfrd9plVF2EFp3iUroN0hlWPdL+KIkqxL7ki0T12xQMajOSQgGz0
 XXgLpB/yhu/3i9z8D81OvuGCfDqrDSe4WKnuWJ/zTIHqMENsbcRWsCbQLN8wkrN8FgzBd+eymBb
 bbzjw6Wqg3hpLD6YS1MtjCYsMBEUQ6qZ2vES/Jjbb2r2i1XhAbg0HjRnBHntoBw0PTtYDc8ioNN
 Ao9jpBBpZKjJjarm68YYWb0K1postKJwz3ULLfgTPl9aRKTW6/B4TqBEP57zk3CYTMRel2SBau0
 k+GmJ+18FQAuJ3PxreWYXFfK1SRecNudillu8hSsrnD8j+AYtlLjo8/H8mWeSm5FdExEkjGDxdc
 OE5GvnJIwTTcNPxAVXWAeRshZFMtDT0m7j4jRzT9TXuprq+7g8/8GsA5R8pjTbx41vjKg4aiqep
 ue1DRnQId/omw1fFO7YBy9f3HbNf8wt/5m9EFf5BllixNU=
X-Received: by 2002:a05:6830:67f8:b0:7d7:fb11:b669 with SMTP id
 46e09a7af769-7dbb6ee9d97mr2468430a34.1.1775245640469; 
 Fri, 03 Apr 2026 12:47:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205340.3788962-1-trini@konsulko.com>
References: <20260320205340.3788962-1-trini@konsulko.com>
Subject: Re: [PATCH] lmb: Correct dependency around CMD_BOOT[IMZ]
Message-Id: <177524563864.2281750.8874083023313779690.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 20 Mar 2026 14:53:40 -0600, Tom Rini wrote:

> The calls around lmb functions for these commands are not specific to
> SYS_BOOT_RAMDISK_HIGH but rather part of the general loading portion of
> the command itself currently. Move this dependency to the right spot.
> 
> 

Applied to u-boot/next, thanks!

[1/1] lmb: Correct dependency around CMD_BOOT[IMZ]
      commit: 5116481a7e604bf0985417f30d1a6fcbc89067b5
-- 
Tom


