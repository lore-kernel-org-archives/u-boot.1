Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5821CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 09:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0CC849BF;
	Tue, 23 Jun 2026 11:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ChaTWPCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA22849C5; Tue, 23 Jun 2026 11:08:36 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45694848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 11:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6607e80a846so5756366d50.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782205712; cv=none;
 d=google.com; s=arc-20240605;
 b=HvrL93sKWes5l4P8dP/TjzUoyeXQ01aY2uZz9fj3DwnXshQY6fAUi+Mchfbs79H2gw
 vRjGNy1Y4b9AGNcnXMqdUe1tbwVAPY8si8ol11VhjUOZzNhAXyW9wCE00rA0OKcKV50k
 tQ3bu0vOXtShW/V17PumQ5jVb/a2BcFCkziX/EtgyfaXGTT79VUSklbMXMpOg/H+Ir97
 eyDLBUTzwVjyB8pEXU1bPDUNXh4bGIBgj9aLJjm4V/TgpOgx7WtV1JyufBpKdCY5/8mU
 7UTW8IBOpdsf4OJgTzXfsSpiKdMRac/QCPDE+H3puuIEDwxz/fq7BhzIhpo225lyevby
 JRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FRx4UAwGuCViaTAEPbpJSFRLxTxGDi+n/j4LTVE3vOk=;
 fh=ZRdZ4D3njVdb4cHwe1QMc3/+lKwhuL1r1r0zzb8V9Zc=;
 b=Py6uMGl5bvP8LHzFc8aIpC5Jn0CHyY9zk1lf+9oWzj2fi0zLvLTRlKeC2bx46sigT5
 pFCXi9UijcvyMSswLNQN/WNehyLHqnM7qRhBQC4Lk2VmMe8Wzpatmn61hYpF9+dSMF7P
 KSTcVxrRO8BkmcGvOsdzCVbHsGkEe4d1SjA5u66AP6Ok5NYg1SJ4zU/KkKpORJEjjfep
 V3urGAZ06KLjSKSe+EFYMV0vKdoJE7ETFwFNTJ0suYWhLV38Li18XnAEyfpCjzXhv+H0
 tEd05p8/FbIF1hW/oa/ObjqatvfcnjcY1I/c+4D9l/u3o35l71s1ISyAatCQfM4ge31K
 FGkw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782205712; x=1782810512; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FRx4UAwGuCViaTAEPbpJSFRLxTxGDi+n/j4LTVE3vOk=;
 b=ChaTWPCucNmYQxpsb3Ezm4Co87I0zq+NPmIpp7sTGdj0j4T9BLDNuEaL8hscrX9OY4
 UYrjWPirnkXYI6AJ9YQB+V4tTlZCgk90P6BzrozB5iku5I5o1YosrZbKGrm3ZBH5dwJo
 AJ8DHlAxVit8KZU7fMzzJ/6o1NukBJeBWTHssldyW0VSQPHQ6H9QUPF2uoUELgNCkB6J
 oy9O45RbujMss52Cs42MmOmntpX2nYU4lLsYx9Myds0dqqdnbjyM7F5GNB7SOVJru+QS
 um0fQae3Qk3ioMBs0CdfChS+kTrP2VwhOuhRlNgNa4Y1L3osr4FXEixB/uA+5Kjeq/Qv
 twsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782205712; x=1782810512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRx4UAwGuCViaTAEPbpJSFRLxTxGDi+n/j4LTVE3vOk=;
 b=C4lTbSCWnwm/46PXHPvFKgmfVIisVmDYvhFJPKy8SZtNCtUMCbBiv4CE99u132mcTD
 Fy/CGTbVfxgmz94mTrDcAk9P6iyrriwAF51Io1u08bP5k5PiteJUrqnzB8bco00khx65
 GyHLfPA8IC7oaYuub11rL4mdKmLabugdLXSWHm7VMiT1Xq3jFXK/KKTUE9vItQ3TVYKc
 FEcO0SixeQMHqkpZMRVB4aEWQXhc1sutxF97l75mMEOfmQeguaSMRI1WBAhg54lmKImf
 RM16MMsOiT1GscIm4BzDOa6bnt1ZljRHn11EGX7MaHBMWl1SEi/2rxaDd6yoRgVtlRNt
 1J1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4Nvk9h64Q1DiE3ClgCNepOV5KRcBxFohfxuaKQu9CvTLirFtJ0fBp3T9jJZR6JAUB+ru4gGE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9GKu1C++oaOyKcnV7/6em+4aWcz2fxNSh1G3z3GA4wNkjCZuR
 M6PIw+vw/KUNUBA/JnzBM7BuYinru2UZU17UZ8TixUVRSKC8Aahd9oQUmJ5ixaxYOriDg0dvTuM
 uj2BrKqIcz5RNbrqF68dIHPTxf5QaAOSl76tdUdnrfA==
X-Gm-Gg: AfdE7cnIFm/xkhL2aGFRgh6zN3hFufmikEK1Dt/yd6j8NE/1ZZHUn8gxXdCGvIAX2HK
 +KXy61CHhYkQeNiEOGD/4iJ9awer/T/9BXeGw/fRPFUkSfYX9YLuSSFOseTj4gTjTz/59Qjzd5I
 +4MD/ykPqDZLKlA68OP7gBNohYVmQb/463C4/1cosG8FeBa4Lm1d0CZhvNKiZaYOCGUTm+bfpIl
 wm3n2d1cpf2i9vimZT+BEvlB+ggrnKh/DxgPL3TXf2qgWn7Jn5ZLtVn1bZxsPPS2LHzYwQaBNCI
 9cm9fssT1B7NgeBYNG8Lkvwj14oqzCKiSZvodooLIznMGimQ8rJmRhVzMqCHp9W8/HOd4BrR3mb
 P2ok1lulbdvwLiBqA8WQnPVwyrYut2grRrfN058yyv2aarID7vE6sgPJieCp8lsh1g7YctIk72F
 qV3o8sQCgvBwdI9EnxXDu7OPc9Hef3n9hw838KcoXE86KpcSr2u6Isw0bpkADSJlxeBwLlmjPil
 CgkSFGsBZaI4AMfmbIJUW5y0xgjWtYuNtNf1FqEhM7qVHb4J1r7on/TjqjUOS/V2bAKF2zzKAXH
 l1xB4hYw4LPTUGieKeWgA4i1eCO8V7cmup+m8HsNvIs4PqAN43KK40qZ2F2X5MrVjjZLBdw=
X-Received: by 2002:a05:690e:14c4:b0:65c:5b88:84a2 with SMTP id
 956f58d0204a3-6635d4c9d8dmr998460d50.4.1782205711959; Tue, 23 Jun 2026
 02:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260612113144.458665-2-casey.connolly@linaro.org>
In-Reply-To: <20260612113144.458665-2-casey.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jun 2026 12:07:56 +0300
X-Gm-Features: AVVi8Cfgdq9wH68UgLBII6rtUAk_XTRlYClA0DJi3mUxJ2dc4jEsiYLt4kDizUg
Message-ID: <CAC_iWj+C0u3fos0LJCn0_KP9gCNQdh3vA_CCzOsGDgncOuZx_w@mail.gmail.com>
Subject: Re: [PATCH] armv8: mmu: don't panic when unmapping a page which isn't
 mapped
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 12 Jun 2026 at 14:32, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> If a caller tries to unmap a single page which is already part of an
> unmapped block, set_one_region() will panic since there isn't a valid
> block or table to contain the page. Detect this case explicitly and
> return since no action needs to be taken.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Depends on my previous series which fixes unmapping regions
>
> https://lore.kernel.org/u-boot/20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org/
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 6c85022556ad..472887b5d99b 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1003,8 +1003,13 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         int levelshift = level2shift(level);
>         u64 levelsize = 1ULL << levelshift;
>         u64 *pte = find_pte(start, level);
>
> +       /* Trying to unmap a region which is part of an already unmapped block, nothing to do */
> +       if (pte_type(pte) == PTE_TYPE_FAULT && attrs == PTE_TYPE_FAULT && size < levelsize) {
> +               return size;
> +       }
> +
>         /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
>                 if (attrs == PTE_TYPE_FAULT) {
>                         if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
> --
> 2.53.0
>
