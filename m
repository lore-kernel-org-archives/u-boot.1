Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10405CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 14:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C5784995;
	Thu, 18 Jun 2026 16:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="az/QbL54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC59849AC; Thu, 18 Jun 2026 16:23:22 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036C2848EB
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 16:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6957b74472dso1723646a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 07:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781792600; cv=none;
 d=google.com; s=arc-20240605;
 b=TLSV+dnkO2IAAK5ryp/TFvG+J86Tffn//EJQEHqZXRReaLK00Cr/EBUwcGgG0hTds5
 Pon89Wf1Nje+S9Pj/dNGHvd7kscBtr8Tkx5CyNfSSoj7ct5lXKz/VyJHuZ2xPkxcfzYT
 pFQ38k7usphiTN61DEKfcS2j0Tio5DdIv3mLv0ER3TYKymJnwuD8f7u2OWZH0WKZ8bGe
 DRhWrq5/X0dLDweAOj2U73FTiMyM3hlvHS8Pp9wljZ7EJZRqDFDISFaJh5cL1TN7EAwt
 2fCS8ig0Vl55X5aQeQdngL3VVtKT53WJxh56eFcxrpyVplG+jye+iYa96L99KJqBO+Su
 RE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MOXvth6FnpogsihCpSbms4lTGCtAxFNk/fa18//ZULs=;
 fh=zeT4p2GFBRiGZHdA2++I9y/zFaJ6OHr1SHKF4OR8CCM=;
 b=ciVrDWlof+YsPHJZIzbFxWgdUNPpXPSO+w0NfC9lRGcKB3dwjw0RHGIP/1X98DZy6R
 kZHYg/IowZRyPfac8VgMgQhR5aJQFb7W6zbZzVFtNqsLnGAo+BDKub9GgkgQr9N1HJ8k
 35iVR+uo44i1FsjcwtX3R5Sx8j3PjfN92/vF9eiiwxHPnnu1O6RYNIEoHclHrceQ/Xo0
 WQ+u9ZpWbR71bbN5TtobWeGckPt2zR+BEqVb6w2isKmZCO4DHCbLFL2JarG6adYBya15
 gMfpU3dSOfbT0wjRbAtHcpKh2ShPBZuGR9hwi/vEjrhcIh+2B9uQsqwxWCEWGezZEdKp
 e4Ww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781792600; x=1782397400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MOXvth6FnpogsihCpSbms4lTGCtAxFNk/fa18//ZULs=;
 b=az/QbL54b+cydFQjJVs8PGQ4nCP6J2wRE/Tj85FV35BS25mpIzaGeVqvA9NdzsK53o
 FJ5b+Fr7UgqlSCJOauQuHn4UZc6UsbdSCHaoE1YbABOsRRor0HfGyNKxOe+TZgvs9XET
 xX+J/HA+CywjkzgEGaAG+JcOwLSwe72aqHrGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781792600; x=1782397400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOXvth6FnpogsihCpSbms4lTGCtAxFNk/fa18//ZULs=;
 b=qQlpOe7/cqjb1fPo91SnWryAm0MhlUjkY70LxKsXjqt8Hd/MFYADT/ZRMA5oRVN7KI
 z8GLjGRTQatR7TGJBdPYLUSN/e9suPoClqbsIY9xpRYtjFEFLViewUbtzTHKkfre+pyL
 wogWG2+UMto32Xl1QA8qHByOYnj0gNtMzR54prZfMsl1vFef3Mc4n6COM+uD5tICKYgZ
 kqvNJ1+4iViW0M119/ZiecgUEne2EktTDDD0j/DA921rOlOFgYsx5zF1BmFLDiMeD+3j
 rBF6WFTx1H32ncpsA5YJWsJYS2JljXxE8sA8Z+OcrQZFiBI5IxejkZVed9b1lsofnDvl
 VoGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ858b0BttrytEPsL3Kan6f5tn3XDvL+Zs7HyKEWGTQjN4YDkOiVa4iv1FbZ8fc8GnY/CnWsntk=@lists.denx.de
X-Gm-Message-State: AOJu0YwS0nMenHAJhcUYOdr5iNvUaG79Pw0cIHPgTnSzLzVfsDIzSXX9
 0Jc7e/ImORGbXEs/AfeWHocj2tKHYZY2z5ltuTdjrUVRHVPLa05fRHa8cEK+pFKoBJp0mCor6Y1
 P6J3qTV0xLmSQghTds+q3NwqeqAhBa7cEquqLqA6OQj0UtnFEeacO0g==
X-Gm-Gg: AfdE7ckAE6OKffAEI0bFHESh3//IYPd1EjwUrCvigQ1U9oUwOMg2zCN1T2BzUMLPo5G
 0HgkfhWlldOdIeN2ARPtsmC+DbfbIOjmX/OzPQSH8OGIG2B513PEu2pn0aZYHYoNjzM6hSk7gQ1
 olH99ITRmybA+P98Yy8cxs2T+8OWlgQRWlXs41VtjxExoPKKfbqtFICQa5rfajGtlUfb6budPet
 i+egLYRd0yWLnIQiyRZV+wD8q/eh3CZ5AD71yAY/aoNzLh3LeruyJMGugLKDyXPkqvsblWacwlr
 XONrVYh0
X-Received: by 2002:a05:6402:26c3:b0:68d:235a:cdaf with SMTP id
 4fb4d7f45d1cf-695bb1a8b2amr2237373a12.5.1781792600481; Thu, 18 Jun 2026
 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260605134446.825678-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20260605134446.825678-1-alexander.stein@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 15:23:05 +0100
X-Gm-Features: AVVi8CdCSWDVCUHzDQiQAuZQbVsXa83ckg7LsGpfZJr0G1DT0-3hL_fJy6XgKDI
Message-ID: <CAFLszTiuJ0wjT_87eaAu38Va-boshfUnuxRdGTsZF8NqCkEp6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] global_data: fix type for gd_malloc_ptr()
To: alexander.stein@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On 2026-06-05T13:44:46, Alexander Stein <alexander.stein@ew.tq-group.com> wrote:
> global_data: fix type for gd_malloc_ptr()
>
> With commit 92aa3ec321b5 ("global_data: Reduce size of early-malloc vars")
> the type changes from (unsigned) long to int. But the type for default
> if SYS_MALLOC_F_LEN is unset was not changed. Remove the suffix.
> Fixes the warning:
>  common/spl/spl.c:800:23: warning: format '%x' expects argument of type
>  'unsigned int', but argument 2 has type 'long int' [-Wformat=]
>
> Fixes: 92aa3ec321b5 ("global_data: Reduce size of early-malloc vars")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>
> include/asm-generic/global_data.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
