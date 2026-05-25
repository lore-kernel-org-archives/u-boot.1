Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD746CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C4F8489D;
	Mon, 25 May 2026 17:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i262Zx9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D6F8489D; Mon, 25 May 2026 17:07:02 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1DA84862
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so1015061266b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721619; cv=none;
 d=google.com; s=arc-20240605;
 b=CECZRa/d2olwBr+TLDc4U9SAI/wd5AwfwG1y3MyJH0VKIvnyBLZem5bHpB1mkb6kyP
 K5AxLZTWOAEK7qsu/B2XlMRGNDMadr1owMeWM3VianE5KDVrsjz0AMD5UUCVpwlVyelA
 XCAShvrnUMvBrNR6ovouQ0MBxU86ii5bN/fEdISOjiXCMbKv8Zy/VvWXBHn53dPtIsUW
 U3eJipHq5bb+zYtpZZg67STcgDWgmdND9iiIBaeGRBGZVBSOkc+4rcJUhoXTLBxiWSP6
 DYfSR2qy/+sF+GJiNrsL69KUIIe40XJM9gexLs+H+QElL2X/SmyJaljwcfpUOQ9odvAn
 GkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZXA/AjVE8V+zQ4OVzWiQEqtXbTPqSDz04+WGMc0TMBU=;
 fh=HutExdD7PrK+G3IraSbqvg1S8VpM6rmLyq0QcANyX9U=;
 b=MbA3rOFj/2lm6UWeGqDuGBJp0B1fy5eXojyLrj/lqMaMvqQhgFJ6AzH9ckaSiU9/Xu
 lhyJBUmLDyd6zQDfxhan0DiRAcgWeaK6tcuyeIG1nnt34AY/Tm2RAlHo2wCxW4r8g2v3
 RwDtrK3j/lr/kzOsDfGYbo+9KWoV9mZ8Vi0WLqN3jH6k6293Rv2jXN9tiAUALlUvzSXx
 Qz712mbiwIoilZOpgGIptLb8aNhuLN1Y6C9oF+djSWRztnoPKHmFmVzYTIMfLoLArz6E
 eZVevtKSO/hLXGwAQn19DFNuJVvqrUUwhMzNWorafRyC4/XA+VQrOtyAqHiYRQs+PWug
 lTlw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721619; x=1780326419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXA/AjVE8V+zQ4OVzWiQEqtXbTPqSDz04+WGMc0TMBU=;
 b=i262Zx9WVgEHSHCi/wQFV7rbxw8StP2rF6nmREzWEYpmu1DYQUE2gxYQMD8WFVXoDp
 O0HeXBHvYrePGGftFQ30d6UkqBXUxLWF21RgRkWXAEBI/DFgwl1ISGCctM5nRWfboRsW
 3hS9R7A7JVyWxcCwb40+RCwk21Pl9MgPsQLmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721619; x=1780326419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXA/AjVE8V+zQ4OVzWiQEqtXbTPqSDz04+WGMc0TMBU=;
 b=HYEEM0oIpoRt2+2YfCa2smycyjq9mLIhuPYnQQDhbmE4Ygw0xK38c3Vx8yS+AXD4Uq
 W8vzBFdL8SLpg/+t3seZxsCCikJoOYKz2afIgB5ShN1J92LWLT1njLjSqusD4GfhiH6B
 MTLUr4ZweiUQkdZhWLkpV/isdm2e9hhxOORky+MrEqHU4h2USZRX6j+dupfs8vkXzbka
 8AtAwr/Wt5IUVwuwWS2ZEX9Qoa/oT7c8m5A4AtklJS2uziepTMtkmnNo7CHZ5mLoOJOH
 Qk9tVVocbUpS+G7ZWntigdWPnNcj0+puXyOXyBkjEJz8Uz6q8AMr5Kuw/ct+ou25dyse
 wbsA==
X-Gm-Message-State: AOJu0YzmBNm/IgC9EgePUFgYy9Js3jrvg9NJUHegUupYT9/fAQkbSO/v
 Pa8Tc0sy7vYa57bs2RHIR0ME01p2hI2dvommk08o3mlr7yaPuWjJtTlHrRutc7xuf6wsw/gEeuf
 DIUWkvJ65F+r3iMjkOyLZ89yRFNsIbg/bV+VyG2kN
X-Gm-Gg: Acq92OEv7YQHNVHjrJYVEHXsg2ZB7x4z5CDb4wPKGNCYesWMWjIetfIAHLR8BI8RPDq
 7kkbjjMiGwRj3TUqnYv0HzHolxvl21rfdaZ00e4WhALMbJ9o2ye4TQEbEyozyYITXDDAxIkiT9C
 P1kqDy0tMMZoqo6PSfH4wmO3yN4ruW8rbV9gTu56JFOyFD83hIQZD4CZpGoz4aB678RvB8Rw1Yv
 AiUvSiJNpP3FWkiUAxpV4rvtGB2uV22U81IsRzPN+x+Z+auMS8NTm1hpmLWoMkUdHAH0qfL4xx+
 EYfilA==
X-Received: by 2002:a17:907:c003:b0:bd5:7a3:a593 with SMTP id
 a640c23a62f3a-bdd2b0d6a45mr940199466b.46.1779721619415; Mon, 25 May 2026
 08:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:06:47 -0600
X-Gm-Features: AVHnY4JLFhYYFow_wgRO884Y0oLbopPn2CDUI_NUfxHYYKbUnGdRFZMREI27EqM
Message-ID: <CAFLszTj42qJBKnO2Q2YSuLEEOBseD_AaLQZB9SzMZjKTUTLHyg@mail.gmail.com>
Subject: Re: [PATCH] drivers: serial: Fix dev_read_addr error check
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-21T17:52:39, Francois Berder <fberder@outlook.fr> wrote:
> drivers: serial: Fix dev_read_addr error check
>
> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> drivers/serial/serial_sh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
