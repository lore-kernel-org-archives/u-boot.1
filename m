Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB72C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACFE384D57;
	Thu, 16 Jul 2026 03:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kY8GzAhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1585684CCF; Thu, 16 Jul 2026 03:08:58 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D098A84CCF
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 03:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso2256553a34.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784164134; x=1784768934; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rd4FPvtmWaQPH0eb1+wmqKL2Bqv6yj+mDP9M4138yyY=;
 b=kY8GzAhXNpEfp/1bmgiHe5ezVbzZa2ZoyDk8HooBAJivz2NFuSPwXoEW3yX0yOdWcs
 7B6bjMnL+IoY7KR5Fv5A08XD2s7u+D/drLH0ceYa4VMb/0vUMkolpvRW6ceOncdqKIq4
 GSdn2HMuQM51bTeWszlFW0feRd74WH6x5BGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784164134; x=1784768934;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rd4FPvtmWaQPH0eb1+wmqKL2Bqv6yj+mDP9M4138yyY=;
 b=sRnOxhkxYyYjP8ML0u+Vf1eC5hoe8jpc/po0O8YrWN0o4T4CdsUuMiAMrQAbpr3gnB
 8DcPuWJ6022y5sXHG0ZJ9WDJG4pnTYZjO8h3CkseTH+MoeaeC9ZZZiY+drrEMxSMBzl+
 VmsJ6PDbObthavllEjLGDPSQmv+p/bt6ieujlPdy53sku057J58VuGN/+xBI+qxwdV1T
 7tbjxQ7sWQpzrdZTR8s2WtuZiWpjfwFnVPxzyVtoiI0b8XoXCRR96GX1dFsrAuYL2Qjn
 MkGWVJAwPPk2YR8O4e3rJBULwnz7FF8HXz1xW66P53OeojTBDklNsFbsYAh1/pYJZG2+
 cRZQ==
X-Gm-Message-State: AOJu0YwQb+pcqNdLOMWGQbzmt2EYdT9to2X2Cf/Za3fh/OtNQAay3Adz
 K7JGW8hQDwurZYPDnNBX+61+dW4fZ/ixaD3HrOCpmrfwR0j5Ex1rthddqgdNqbbbTRY=
X-Gm-Gg: AfdE7cklr+ovepLsNKp0soeVxfOjAuQNII4+EHrzE9jTQcisDybtjBvs08Zi0InnY/x
 M9N5TVGjkyZ2dqminzI4KbZSeu4eQuQKRxORM5nvI3XA0TC5YkxDJMoZKc0V8XDQ5NcIG43JvLd
 HRDGAtLuE2VzgdCdal3T8RgCHTVtCBTuqNvxwAyRsgIBCvb54Bgw/uxERQ2Z/xS7eAaE8l+v4aP
 bRdMUqFvC3gGevG3aQcksV7gDHbsf0VFUu0UCF/y70MeOaj2baNCHDyJAXd32yOdabVmnjDBGTZ
 ZHbkABciG5afKdt79r2X6fnUAAbGLCab1EqfpT5JSzpoyxjkRbwl7uSmN+KFSz7hci6HSjMOpr5
 3kz5Ai3KC663iBy7WkWsY55wRwcPoQr44pZLzn67XepdzzeRT52Es3A8E/mgwQu2/wXI+NP5Kbi
 bLbtKBTLTqy7CRznEWU2Lxha79mSLpoXeKKAFfyP4LDuCGGVW8qNJCYA23mlcHgcAvdQUHF7Zl0
 bLIRTk21lT5dut+8cRvP2XVzw==
X-Received: by 2002:a05:6820:211:b0:6a3:d77e:725a with SMTP id
 006d021491bc7-6a3d9f277d3mr3361154eaf.20.1784164134471; 
 Wed, 15 Jul 2026 18:08:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a38e9bc8casm11503854eaf.2.2026.07.15.18.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 18:08:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20260708-fix-beagle-v1-1-c9b5393e6d23@bootlin.com>
References: <20260708-fix-beagle-v1-1-c9b5393e6d23@bootlin.com>
Subject: Re: [PATCH] clk: ti: Use CPU ticks to count timeout
Message-Id: <178416413311.164922.17708860920401879107.b4-ty@konsulko.com>
Date: Wed, 15 Jul 2026 19:08:53 -0600
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

On Wed, 08 Jul 2026 10:38:10 +0200, Bastien Curutchet wrote:

> readl_relaxed_poll_timeout() relies on timers. On the beaglebone black,
> the timer used by readl_relaxed_poll_timeout() depends on this clock
> driver. So we have a sort of circular dependency [enable_clock ->
> timer_init -> enable_clock -> timer_init]. It leads to a
> division-per-zero during the second timer_init() and the beaglebone
> fails to boot with following message:
> | CPU  : AM335X-GP rev 2.1
> | Model: TI AM335x BeagleBone Black
> | DRAM:  512 MiB
> | ### ERROR ### Please RESET the board ###
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] clk: ti: Use CPU ticks to count timeout
      commit: d23b9d4f6ac76223d1354c7241790fb1b6d21fa5
-- 
Tom


