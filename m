Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18537CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DC584869;
	Sat, 30 May 2026 20:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gli8CpIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5837846B4; Sat, 30 May 2026 20:37:05 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E2D84671
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so51431a34.1
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166222; x=1780771022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEOvqhZ9hDm2lSVEXX3lQUPVLBYjIu6nT6savO18h0A=;
 b=Gli8CpIvGwisKf0ZQk98HmPK7Ax/gIeEXaBb92o7wOUv/IzNx1RJzfbkb1Ha+Ydfp7
 XPvTEM3zBrdUIONGsF9jucvko+aUHAxqUsGG+vQcYwt6mJ7Qj6dxYgaOxew/rbCGxRkT
 l2kFRgKpXUw57LLZiAmIgc3XEXqhmwD2eOblM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166222; x=1780771022;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WEOvqhZ9hDm2lSVEXX3lQUPVLBYjIu6nT6savO18h0A=;
 b=DwrNTxEgRfawfb9c8BMRaARy9mSx24j5akSPA4IFFxbzpoHkea2GGPhKj7yCytbTVl
 kcSY+FbwbDZhCyK8H5k1K1+kvLdFrNpvIPtWsV13JVGcEuh5/UDBrnR7CwoStDX1h3YM
 hsVPb7Saoobl6LCu8ljiKphVvAA5MzyjVHAvaTD8GQOXtxAoKSgrcX4akxG1P/VS1775
 RtwCyCJj+z8ZMX6RXuTcNveV0wweLJUytRdFnAwtiZONM8M4VeK8xGoyVDySOrOXigl0
 1X4ZLxuUZL0/MMdF+qw4918MLsTXi0ZhcMFYdS6WfE5pL0SI8lcVCkoyQH6lr2XiUP1L
 Nw4g==
X-Gm-Message-State: AOJu0Yzw3XK+hIfDB7K9rMDIzI2RMIHJ4dxjGRckl0M3td1Vk0TwFhIB
 Mohq3cTXBHkCLIjz1nVPvUESE/771xEIroAlpbFWuyjnGAfnr3/2wH/Dc+cm7hTOAzo=
X-Gm-Gg: Acq92OEKebnT+/TCVzdEYOz4277Ft9v94UCyHzMkVUAHPqzh1j2N8T1IUh7gBQr9alN
 rssG5Fn0uUp2ZZcdvn7b/s+JXWFd4Gdu305qWPcCauPB/iJxT80yt6Xhtciex7PjnTnkDNXvsjk
 ol7n4pTaZdiyXkCKn80gVdN6OvOqBoSxa7AtMDG7bNbs4zFqGZwlt4PVwTjDl5yvuqvNedEgm3N
 8sjzKF3VwJn7SD8ipzCVQDJA2auEaxNds1MGPWIk0vD8aE3PByxBl+yHQv1r33ipi+D9cA5dpBI
 TsPQ+LkuGFWMn5KQA94mcTrO+p7B+aPrAo6IivI0L+WXdmJOco/zE3gosKjlYqdiHMTy0LbA1bO
 Ev44MGJsmltS/rDP2wwcjQ/o3k3tJQylvLBEn47sVb4Bf6mlBWlj9mRTyw1Ji0Xv4C0VYhTu5YH
 7rxXkhmLmP8gab+wQTdw6XutnsqRagTyXyTRk/ou7GKW4Fua7SUcCKsF/N4EhyfvNnBQkx6+vhf
 q1VjsnJ0TdRicPTFBPAjqt/4lne2o+KEjfmIqaDV1p1l7r4TRRHnMveUGaCF7pmfQ==
X-Received: by 2002:a05:6830:2404:b0:7dc:e53a:638 with SMTP id
 46e09a7af769-7e6a1d68e9dmr2748596a34.8.1780166222445; 
 Sat, 30 May 2026 11:37:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:37:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alexey Charkov <alchark@flipper.net>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260512-font6x8-v2-1-26e6e7eededb@flipper.net>
References: <20260512-font6x8-v2-1-26e6e7eededb@flipper.net>
Subject: Re: [PATCH v2] video console: add 6x8 console font from linux
Message-Id: <178016622160.1038765.1747150264796840413.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:37:01 -0600
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

On Tue, 12 May 2026 23:31:50 +0400, Alexey Charkov wrote:

> Small screens on the order of 256x144 pixels can't fit much text at 8x16,
> and 4x6 is virtually illegible, so add an in-between 6x8 font from Linux.
> 
> Font data obtained from lib/fonts/font_6x8.c in the Linux kernel at commit
> db65872b38dc ("lib/fonts: Remove internal symbols and macros from public
> header file")
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] video console: add 6x8 console font from linux
      commit: 5cf4b1428485048bed4b53ed600c17bae016dd8c
-- 
Tom


