Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18145C5B560
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3314083DEB;
	Fri, 20 Feb 2026 21:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rTPO7Wxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799C583A5E; Fri, 20 Feb 2026 21:51:23 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6111A83A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 21:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-677a11d11e0so932173eaf.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 12:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771620680; x=1772225480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0yX0vuV13Cd9CFDzLNgTj6WlDRTK/nizskszH4M4tc=;
 b=rTPO7WxpXl1MvDeyfg+ph3iN+l2EOmPaI0uPexLNaqbZPHsN5cjGQ8s3Z9YiI+xW6+
 SixrvNJCpL1cVBlg8ezO8WNmXfv04JjR8eklmHdBSoNtN29fMQ4OdS92EdeZBHGWB2F2
 DYPqjZZeutbSsrtw2Fw58uIwleG3HM4z5jNl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771620680; x=1772225480;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0yX0vuV13Cd9CFDzLNgTj6WlDRTK/nizskszH4M4tc=;
 b=oQGzRe2/u5pgsyuumm1lEf+14pvtiiFcmkVBhuoD4QAUWlBx5nwmaTZy+juF3KeT1O
 XlHVT18fadOP+Vem+/IGVwVwxvhMwO8a7bfepIa5IWT5vr0dzsXJG6F02t29qs48ms8b
 YAe1D/6sWiQpC8Daf0BqBHGv1QJNBSDE1QO6VSlDp+WSPyvsV/36L5rxYMvG3TOP9OTB
 0YJu+SoGSkrtwdB1gnwH8Z2rDOVuUkI1JTcdBCmFbQKhaK43V56dJMAevTgrGKn+AVkr
 kaTKROQsznvns4gZFrJsx4KoieKCdz9c4q1o5WdWgdWSp6Lihbn/VKXZbTV7JaSHtyk9
 URVw==
X-Gm-Message-State: AOJu0YxyomqfrWmK9p8CBeN9MgSieZdrwdcquMvk6BMXv4d17JyU4CdX
 0wrUdLWdkkTaSDOv97YeY6Xxtk/w1Pc/B6oe5CCFuyfaJj1y4Q8/BJyJbDYYNKerrWhRIjhhmPw
 964nVTAc=
X-Gm-Gg: AZuq6aJ6j8vJI4aYyV8HiDi5iaMyXRuFQxs2tJ+s2GLKBvDlhP5js92hVvUTtleCanA
 IjhTP+t1+KlAMSp+HFjK5+pfFcnJ9yhIO4uzgdccO/jEZxjA8h9KYzXUxU6D+Ha/BFkzO75X6Cq
 Vm6ucn1IqGA4y3cm/ePBDJGYnKixICaIxqgeAecmSy6/dsCAHxDkOBOmIZWIeAw9ngpqcf6diLb
 Z/y2xY/oJOjBOTkBfs/MEQMSnD768f4PFH4JoomOnNZU2SgpUiUSYbpKb3QfZt7DoAsojKjsQ53
 ervDNJeCfmpbBprI16ecglSOonUd5GPsBWBmKgv4nIfPYdw7FNHSiLaXQijUve4Fva8READ+PgQ
 AboSAkKSeqCCjtFrYFWgikP9F2gFeVPaX+r66Lrl9nE8B3nDFv4pQt8jzyzKHUHLWQS36GNX5do
 2FhhSCxVMMAFiGw6/Fm/9K0qYcvZ4JUTzwMowU551mmErjT84JS4iW3fj6GNgmADxVer408BHMl
 0Q5JUIbycN/UW1rx85ap1ryp8mF+JkEGG/uxWYchN3g7YAVq7hTDw4Popaj
X-Received: by 2002:a05:6808:10d5:b0:44d:b72e:ec1a with SMTP id
 5614622812f47-464463700dfmr843927b6e.45.1771620680078; 
 Fri, 20 Feb 2026 12:51:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfed28esm525818fac.9.2026.02.20.12.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 12:51:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@legrand.com>, Anshul Dalal <anshuld@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Dhruva Gole <d-gole@ti.com>, 
 Simon Glass <sjg@chromium.org>, Albert ARIBAUD <albert.u.boot@aribaud.net>
In-Reply-To: <20260207153330.90165-1-rwahl@gmx.de>
References: <20260207153330.90165-1-rwahl@gmx.de>
Subject: Re: [PATCH] spl: fix stack placement in spl_relocate_stack_gd()
Message-Id: <177162067898.148229.4662358075694437697.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 14:51:18 -0600
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

On Sat, 07 Feb 2026 16:33:30 +0100, Ronald Wahl wrote:

> Currently when CONFIG_SPL_STACK_R and CONFIG_SPL_SYS_MALLOC_SIMPLE is
> enabled then spl_relocate_stack_gd() will setup a layout where the stack
> lays inside the heap and grows down to heap start. Also the global data
> is part of the heap. This can lead to corruption of stack and global
> data. The current layout is:
> 
>                     0x0 +-------------+
>                         .             .
>                         .             .
>         gd->malloc_base +- - - - - - -+
>                         |             |\
>                         | HEAP/STACK  | \
>                         |             |  } SPL_STACK_R_MALLOC_SIMPLE_LEN
>       gd->start_addr_sp +- - - - - - -+ /  (gd->malloc_limit)
>                         | GLOBAL DATA |/
> CONFIG_SPL_STACK_R_ADDR +-------------+
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: fix stack placement in spl_relocate_stack_gd()
      commit: ef65b15383c99f4562539a635fe166fb4d75c0e3
-- 
Tom


