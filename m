Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4E606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nqLCvjTH;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Welx7cxZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 925BD80F66;
	Tue, 20 Oct 2026 19:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id re1bhaxWebTA; Tue, 20 Oct 2026 19:20:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D774480DEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792524009;
	b=IZ6U32F1lRgqJnibqybWq2tSt7jcRhQiCauY8csQ14M2iJnSjVf6c4GfAFv/XUyLEFmS
	 Vh6KtR9Qiwb11k/Ul+InSpEF/vdKn+ajLkXaGSvb7dgCDSnTxs8HE7cM45F3p7Sv+GojA
	 MkFIE0z7DDCoQA7keOeNSX37qS/WHcorW+ZqbNe0U7QKMnMXLvqV4CsX4SuRtJWop/KOO
	 +JA2SK84G3+/D5jp/Wh8XqgUkGYtcQDUEmbVINO7ZnfC9PRKVeypw+Ix2tkWVdPLVYVHk
	 m8qIPnMxvkf4IUYCVbI3Gh4XzNdJl6RXqpNmYMot5ryB8B8wiWereDp27mVIc4rvAsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792524009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=C3dea9wXVUheOJoBh3O3kmGTpo+nSr9ntb+GiTgM+o4=;
	b=EPXbZ6eVXhUyiDfTs4eEHQoIr9UbNXkdS0VIGa8UwcF210EF08+3PHw+krHVon3/lKVB
	 8cV+ftFX5SQvqx+x1jlK9V7qzVLujJ1XHSljWLXCALQgzwsrZIcmU2+1nl+Klnr9Vt4gL
	 PCXtwEqyg2pAqcruiivOLgBPOmJj4uxcvMqYIoWjxxMGC0KYNX3L4ltUjXUkOQIjwoRNw
	 z+ZBP3/tvwr3QC+DoDSQnukLvF1pdA9VTS+rXCAeKO93jwmd16BCdkF6OAhpoX6wbYnwT
	 X79s1AGEnGlV85rL6P5MK+ioxy3jHo8vOuXZLunGf05R+65r4rDWOl1+6sigPBcI1Yw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792524009;
	bh=C3dea9wXVUheOJoBh3O3kmGTpo+nSr9ntb+GiTgM+o4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nqLCvjTH8QGabqKplA7vkvhK+BVaMh37XSrTQ7puh7VqNsJ6jNglzXJ+tU9DF9AEb
	 hxuI2EY9DjgC8/Bh82tm2ZPKEH/8YIFUdu0NC0B03D8mwo8+vsRyGofqm+bsHyR8qk
	 Px9xnmy7zaYTvXNbuln/GXIyjYKtYbeapW1fpJOgmupl0RuRqowntNnDzPa7P33J0d
	 SGn5fEoELqRBF0fmEFIl5ajgTWtOJTB4bQ+pRCPAFpSu58ixjAST7JOJ1Q6SfxAUl6
	 uyPxczIUcJ+wx57S0gvkFVkwrX7GrjD72BpnS0GZrPl3ZrEJ9+m/0cpxrdI6kk69wN
	 c6Y3pBGNCp6IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D774480DEC;
	Tue, 20 Oct 2026 19:20:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 97E36380
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E067405E0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYO7HDx5a2sO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AB377405C2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792524006;
 b=tCfl1ff9BEU9lhXL0tWBw1vkQA8XoLfyPWJDt8U42FObGk6bA+uFqnxqn8nwcbRJGSMO
 CAuxOZ0VP9cpl1YXzXKfOdNlmkUs7vx/5o2T21a17m850WuTgNhhJ6WgoOBzeRwdsTHP4
 CFCbCqSNctUzcqn4YcmSeenCUwC4t84yryZmmBeAo/he/pqM+MaoMVCEbCvHER7qvVGkx
 cWibbDKTCwjF+LcmyR1nnIxtVSwOaE0DFFpUXbEQCMQM4OlNpZVsqMC3s4WzwKagsJCPf
 HH0FMn6K6Z1gIDeeAIJtlbgyYp+7ruJCmFZbjSnl3WC597kSnO+HA3JdZZsirjT+zuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792524006;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=C3dea9wXVUheOJoBh3O3kmGTpo+nSr9ntb+GiTgM+o4=;
 b=Wz8G9SJHyj9dSQZ4D6tGThEFWmonFQd8qPiIsmUDixzKJZdIOEik2bXYes19UbbgMW+E
 weHqnWlPmDBChVlBKjJKTLwH+qroeSEtwyh0JhwEjDXjoEmG3kV62eZ2kkW5H2QTnBh+Z
 oIo+kKfWklPnuiDE5VnBv0GCpkaXT0567Ql/pLBCD3JY8oV4hLYO4VNbyPJsNXRJxc08t
 IKg312czsOCZyb9joapWY/ijq//Wnvc/jhJvB982gW0C62/Mc5w9Gfc9BxtJquSfGRIVT
 YBZJ6IBWim9OSzbA08js50rN7xnMxAwZB08yh0pObmuUVIriFQ4ObG//SxywtQIoYaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Welx7cxZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Welx7cxZ
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB377405C2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:06 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7fccba9c675so1465824a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792524005; x=1793128805;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C3dea9wXVUheOJoBh3O3kmGTpo+nSr9ntb+GiTgM+o4=;
 b=Welx7cxZOKuwMTQ0s5uxWVrMb8YQIa5q8tGarQ3e0KeVDbKZNWvU5SmyrYyiEFY7QT
 50I8sIthS8Jy3Ux0SgYoo9eBM8Z12sHRlNJfX9pzlbbPnRl4LwLsf/rCyIgbkHCKu8Sf
 3ibiSyPTA+wUVFngq197WPe0LdbLKNk+PLz8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524005; x=1793128805;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C3dea9wXVUheOJoBh3O3kmGTpo+nSr9ntb+GiTgM+o4=;
 b=pGgZcTmwtElg2M/lpLeexBd8gmex9YsuU2xixRg8ssLErWvYrDVvjFXeCBnFMJtrPT
 zhrQpmQNm4+fFyBzt0/NGz8xwNRWLlciRbmpY65B2rzva+rJuDYUjfeP7ObaCmRena6B
 pGnRhA7Nhm+cslYoQmVx02oTBqocMwEZrc8un75y46az9ZyaPTRaj4HVRw0OxaqZvPxO
 yCdVX+TIoe1DwfaD5AWkg8TZeEXp9n2bD6+vTqJSUxUrKMT9obSVCgDEm7rFXKS6KN6H
 hOy2JY6NYkkzEIaXObEzRNQ/2XGoU/RsjloFdEZNGS9tQclHSfPcDWqcYYX09/c8r+B2
 IElA==
X-Gm-Message-State: AFq9FYLpag8cgv4j9hmCnwIAg70qSzjOPV0/hJyjY+18CG3fH9u75MH3
 qRWoSoBzh57+xEYNeJoJ7nmM3W9P/y5zAGlStzNc44wEZ9xUCyj2c6okvKYIQ43uOp8=
X-Gm-Gg: AYBFou2/dbhwaXkHLX3QdC2CxfhMK4fr1E+JICpN5eC5gze2xT/0gKGa1lM33T5I7Qp
 aAkWlgGKjAgWCpGHNuyPd8402SGZkwKqdNgP4kCbeJFL35A5Y8uSR202jX+zN9HMlc7YHq6785l
 /yqWsASs7WqYNorPvCOB3g1zA3yDZwLk/S+YOGg9XA8Ae82wkGTvIOB9w1yMD+WdSrrelHn5esZ
 iTf0J5KJN0eRS/qbT2zcAB++s/qPrPCZOZdzkjnASM+2bzEQ1EvfN/xUrQjgtK9nxCPqGTB7CvR
 McAZnQU9Zx8kEmNIn0m7p1LUN4HPZR6Gpp2hb5xYYMZf/lvzDCMU8pgV865WRzZuX9oXcgdtU0f
 YGkWGcRQISTVjq6ddesEhYegY0RLRWxL12fMOBoAZP/tQPJRaHPHxv8gceRrq0+vIYKoul3p/3h
 D0e18dtPWg+PWndx0QRWDhBA0CgW4cGBbgzxofS79uB+Gn5KrXu/mwnMujIZ++L305TO3Yf7lnH
 WK0W5yPBNUcPCmD2skOCwS47A6zjJhqweo/9eEp1wd5CrfgY9DYRRonf0kcclHYrvcI7bMp4lbb
 zAE6RzWjmF+I8AczSg==
X-Received: by 2002:a05:6830:6abb:b0:83f:2c3e:e157 with SMTP id
 46e09a7af769-84b7486eb5dmr1957287a34.9.1792524005118; 
 Tue, 20 Oct 2026 12:20:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cba7d4648sm347685a34.1.2026.10.20.12.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:20:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
Subject: Re: [PATCH] clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates()
Message-Id: <179252400429.1115934.12825900125476998603.b4-ty@konsulko.com>
Date: Tue, 20 Oct 2026 13:20:04 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 27 Aug 2026 14:36:29 +0200, Markus Schneider-Pargmann (TI) wrote:

> clk_set_default_parents() already ignores -ENOSYS from clk_set_parent().
> Do the same for clk_set_default_rates() and rely on the earlier setup
> clock rates.
> 
> On am437x the cpsw switch has assigned-clock-rates for the RGMII clock.
> The divider delegates to a multiplier of the DPLL that has no set_rate
> and no delegation, so it returns -ENOSYS.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates()
      commit: b39c518941a47f3608ac26d34755589fc80858c8
-- 
Tom


