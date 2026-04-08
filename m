Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C2610F9943
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E45884129;
	Wed,  8 Apr 2026 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ppgA17LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90AE84142; Wed,  8 Apr 2026 16:51:20 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9672A84129
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7f92bde91so3913619a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775659877; x=1776264677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PEwm34KbQKlw8ITWVgf+xXytEiuP5CeGy+41YaMzwBs=;
 b=ppgA17LU4D5Pich6mZFjdCZMf9Kk77KDZUUDEpTZlg1ulmx1VNeKp/ds5LroCP2dHV
 xpP7pEqCGzVUax/t8FZnqBUti1l60ZLDER0fMeOGB4ctpZobqeTet/gg9AM7let8rqel
 6EKBDSu6Xgs2Vl5iQV965V4AmINe/bD+eOU0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775659877; x=1776264677;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PEwm34KbQKlw8ITWVgf+xXytEiuP5CeGy+41YaMzwBs=;
 b=Hj/yUMfNn9p7/og3vUpZ2DHXBkKJHEQKLRECfhFRHfP64nS5o9XxxJYCFho4m2fJOH
 uVVm1IBG4kzva97U1DJEzetSSMoI398I56+a3r80dY6wNF9Q8dNlbproApzziWtPnBBJ
 RTmq47GEHW+zE5YtUfOSjhasapdZ8lBZCxn/O1P4kn6uXBAPQ27oPusSJSfdkbGY2DmF
 v/dlw8LWRjQzrB4uN63OveSkUOQJh6nbQTQUiI1VHe9WgvMzMPoquFFsGx82sJD8qLGn
 t/3Vw8sZRD8bVtCJ3OMPXTyJbUzmZ0B8HAdu3Lay1LPb9uCMLIhrDTyoDV0AlNPXqlMC
 dgZw==
X-Gm-Message-State: AOJu0YyBVLQMu5beHxQt+QhW2u77DvDKPoRVZ6EeH/ajXU2eo8UNSfkU
 4XNOG8S8uoMUCj3Qtld6LLlVDuCx5Rg2wLrd6s3On6B8xEMKRuoTTFKm2NshkRIjJDzxJhNf4rv
 Xnuyc/Lw=
X-Gm-Gg: AeBDievrbjUG8t06SzZIsIxU6hy8cd422S4IHKs8dWj+FxZyI3cC0jQyYIwWxEY0n82
 mjHqdNTxoMqCrbWnd/rBBWJQ37FMHwsO7rswKfcObHa8Q+d+LSol8Bnup+uXUvnuAJB7AMNCynb
 o7PR2umQslMmH5rKNnlqTL4hxb2MSE40Eo9kXxin/khE1RgsI3TiUptSrPFmTBB0Hb49ix4lMeX
 F3zKOvLLuWSTdTuZJW7hjS717jsB0OEgO6gkWnzyOl9XNltRBnsl2jFSsliXMSQyMHGC3Jvwm82
 M0OwewE000U2tOTlzP9Nk9oBmRTLXzsj6eZjNYJRnOD4tJAj0TNh5R/TkKL8iR7eWheMB9SazSx
 c0PHyFrCECmwkPdyNHVJWZEfbZDGbnjLejz1c0jJRHMDCF0khYylNzZmFi2pfviHxEDVOw6+30V
 qaBLsWKj5zmLxrYsLvy/dKx+WkZLM4t8iNcu8pPqcFA27LiOWNZO8qprrbE8Iy0Cac55b6+HF8G
 Ndy+X1/kGDCz7Kvq9+aw5afyJmT4Lx719N76TsLWZg+lbU=
X-Received: by 2002:a05:6830:380c:b0:7d7:cd20:fc86 with SMTP id
 46e09a7af769-7dbb728fae0mr12718335a34.25.1775659877333; 
 Wed, 08 Apr 2026 07:51:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc081753f6sm1514644a34.6.2026.04.08.07.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:51:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260325190019.3428500-1-trini@konsulko.com>
References: <20260325190019.3428500-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: Remove redundant "xPL_SYS_MALLOC_F default y" entries
Message-Id: <177565987672.779397.14782145757143584418.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 08:51:16 -0600
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

On Wed, 25 Mar 2026 13:00:19 -0600, Tom Rini wrote:

> The symbol SPL_SYS_MALLOC_F defaults to y when visible and
> TPL_SYS_MALLOC_F defaults to y when visible and SPL_SYS_MALLOC_F is
> enabled. Remove the places from Kconfig files that had unneccsary
> "default y" for these options.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: Remove redundant "xPL_SYS_MALLOC_F default y" entries
      commit: 83df1103ef3787e7682bf8fe94c06281cb174bfc
-- 
Tom


