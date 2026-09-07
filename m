Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4C9C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 09:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CDAB80C46;
	Mon,  7 Sep 2026 09:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3gHjVYVidLV; Mon,  7 Sep 2026 09:09:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8421980BCF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788772179;
	b=JF6nMDQ5XEvT3vSdfA5LgbW2ytjvLbmKBMJMpW2BOO0UgMGoQqPLStyc04rUkjSQAMDa
	 ECxCNw6lMvKC/uwhlSJIjK8cJ7vfkJdKUrKCoU7mNyXoODfGN6OXDKQ+OtcC0CIbd1FC7
	 g4brl+QlNCbY8im0rhG4o/pgfDygMDgAVQUYwF+Yb1Qkcu2ptpxHzhn2e9q0pmT2E/Mew
	 eCyye/4+x/pfe9Q6arQOnb66k+R2XZYIHBQQaBT1z2pheKqeetRwbikpxvRHME6NdsSWT
	 rJiwCkqNXTD0rMeu3cnz+UG2++nRCWJJCgu2Imn1Jz+ryul2QVZWJqY4XbVwTwpkHiQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788772179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FTEkfBH+NEjmrEJCh7H6uvxBwDymNG5wAJTr0d7ZctU=;
	b=gAQz/Q5GdhByJ27zS4/oQS3D/oNd6sKhLiFvIc57K68WU6tOZAiWf/SG3XyO5XeHTtNo
	 78hRQUbgl3ZTxer/5/MwvYFHNkFxtJBC0kme9JqtPxuHeQ4vypHzBxF5t5EvxN9ylRS8z
	 25OMNA+PqlQtkb/s/ojUfzhG2l2JBEUkNgqdbGM4cfj9Sx51yQkrUJGXd5R+qH//+0KuV
	 HndMChV8v0fL1pFD6hhB0lkj/WnYBvXja9TZiQk7zz4CYM7cMPuxoL77WXqAptrfErQTY
	 wV7FpUeIY577ZfhNgGCGzMWFZPRzB9tRcZzFK2wkOs/8h6C3cmI6dHWVCMxDpMfjQuA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=BxuJ9epD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788772179;
	bh=FTEkfBH+NEjmrEJCh7H6uvxBwDymNG5wAJTr0d7ZctU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDD6LURKByH0Ls288jOCx2wYCUcp/8xWJWr93YadkbAQUsPn5CVxalu/0QcwrR/IF
	 PM3dY4Kz6PZwzwBJ/LnXnhUWk12wqRb9KHnrhcoxbDe6FV/ROdGLnCRPz3XpbhjEXQ
	 uZq9Pei9yZbr9pDyOvxY/Oboq5KfbmFxU+rHCGXpt32qyXtEx+276e79ynLxf7QeDK
	 CFKQ2MCOTOz6eHhGY4Fa22W9d08NHjunr7ixKfmRsjqMyAP3uFYfZ6MHpAbrP8B8Qi
	 0+0qL2R/Mi850279cQASeN3RRaKO1NCO3p+dbhktCPUraLysi5o8QPnHJBmUPZcOxc
	 0EYtdaVBXGHtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8421980BCF;
	Mon,  7 Sep 2026 09:09:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 38EBBA48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DBA680BCF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:09:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7dU3zZbdq0e for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 09:09:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E0BBF80B80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788772177;
 b=goSc4rVhyaZNGnrgKVrKWxw8oX/pGxQar9nOwdop0eIw5eGI1qNuohsp3B4/gPg8E84u
 u9CQ0TlT3Ywhp5FzO1g4gQdVGNUIMquMoeRHq7dVH/mMYMaNNhZruL+JfqsFNV4cxTEvB
 FsBQTkDv58Mlw4MRJ+RY8SogPooZ1+W+onaW9jEEbssnF6mterhC8n2+fdAW1eiQricET
 5A5zPPuw7KnHTb06JMdSn8bmvuVvt0ZDEBKGRj4dDYHAdXSU2jGj4m0204w6o96MdYH5f
 9r7xzLNmj55+K0WYzvyHYdz2EZysvhfxoUzLhx6u48v9zDawkx7rb9EW34WOCPeTsPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788772177;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=FTEkfBH+NEjmrEJCh7H6uvxBwDymNG5wAJTr0d7ZctU=;
 b=gma5rlqbcVhi08cR5AfHsvTl3rdF38CbLNxbQrD50c03+szYtd2vVvY8cmnU5GM6Vjs0
 yOl6+dMZ6yivMdQKkVNZRwqE1QvTESLo0qvTW/xdFqbWfpXrzqUuVG2QrK4SINTQ9+yoV
 HpsmErEH4d3+2X4rnPbgrI15RHsIg2cXZ9vUeGgRY3unoJg6FGN0LT6inOMS/0hEkM7FM
 nKQs+wiMvpOXYTuJ8OMKWVq65kDczf+CsgJRRCj8ZWvbVan4IaRefNWWrSFIhUXTlQL8u
 DdyFHHakLmFvTjoE4r5rbIaGYoiTLC89zw+HHWTSoR/0FI5ajFcFsyzxxiyJm0zZdfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=BxuJ9epD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=BxuJ9epD
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0BBF80B80
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788772166; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bDLH3iGAiH8Wi9T915yI2RAZjpXZ5A9QHgxs9ighsHpV6/1jR+xfPypz5lnwEU0qzVmaHjJ7EiFaaIreNr8+91xKXQyTBVfFRfxrppaExI9nG3ZVYMjyi98i3EguRpsj1QWk1ue4HLr7gm4afT91Wqj1FGre/daf1HeDuKacm8Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788772166;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FTEkfBH+NEjmrEJCh7H6uvxBwDymNG5wAJTr0d7ZctU=; 
 b=JBTn9BUuWMxCiEhWAg3Be7hFoG1pK1WeN9bNPlZRkTezIjS3qC8L2CNGPw1AR7Uw7qVBuw7arxXxq3GfkCoq+8cdiSjX8CuwiFGKdK9cWitUW6T9lAaHSKEWquX9wvlVRKrYLC2R5sOFAJOnvqqZshB5c7lRu1YvnS8iMrH6NXQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788772166; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=FTEkfBH+NEjmrEJCh7H6uvxBwDymNG5wAJTr0d7ZctU=;
 b=BxuJ9epDQQqxEMZH/sfnH0jtPHCEt92FJeQFU01wy3vYGiWb3XG9QCwY3N1kd3cn
 3FIOeTssq/O7WEIFgH3c0/ZA6f6GC5bYVbMgShrPO5Vk+2h1eihmzUMEDpTfPK660On
 L5ig4usrEOCh9s1tGUiJJRcUHsbtETZkGKBg9vag=
Received: by mx.zohomail.com with SMTPS id 1788772164416269.7155741210422;
 Mon, 7 Sep 2026 02:09:24 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:09:18 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: timer: Fix M-Mode timer
Message-ID: <ap5_PoYJjvvb4yOj@pie>
References: <20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me>
 <apsZY2QgTXuJUivy@pie>
 <37844d7d5ff5ff7e391cdc226ad58884621c9271.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37844d7d5ff5ff7e391cdc226ad58884621c9271.camel@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.762.58
X-ZohoMailClient: External
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

On Mon, Sep 07, 2026 at 10:22:54AM +0300, Nikita Shubin wrote:
> Hi Yao Zi,
> 
> > https://lore.kernel.org/all/Z7dMY_GqLHsC-5gl@pie.lan/
> 
> > TIME CSR only when Zicntr extension exists,
> 
> Indeed, also TIME CSR obviously is available for M-Mode in that case.
> 
> > - Remove the timer-binding code in drivers/cpu/riscv_cpu.c
> 
> There is a caveat that, we have "riscv,timer" compatible which is
> defined in documentation, but never used anywhere.

Yes, I later noticed this.

> So we must manually instantiate it somewhere. May be it's a good idea
> to move it into `riscv_cpu_setup()`, we can also check extension there
> (in case they specified in dts for those who rely on it).

We already have similar logic in riscv_cpu.c, but I have concerns for it,

- Instantiate the timer in riscv_cpu.c is quite surprising
- This prevents timer-uclass.c from probing the timer driver ahead of
  time when udelay(), and etc. is called.

  For example, a specific board might want to make use of udelay() in
  board_init_f(); if we only instantiate the timer in riscv_cpu.c, the
  board code must manually bind the CPU, or the timer isn't available.

> > - Correct help text and comments for riscv_timer.c, just like what
> has
> > been done in this patch.
> 
> Agree.
> 
> > - Rename RISCV_SMODE_TIMER_FREQ to RISCV_EARLY_TIMER_FREQ, clean up
> >  preprocessor instructions that limit some functions to S-Mode only.
> >  They shouldn't be S-mode only stuff.
> 
> Agree. But still RISCV_SMODE_TIMER_FREQ/RISCV_MMODE_TIMER_FREQ in
> theory might differ, if, for example we are switching clock source
> somewhere in SPL phase.

Yes, you're right. And in case that S-Mode timer (TIME CSR) is emulated
by M-mode firmware, they might not derive from the clock source at all.

> > - For future RISC-V cores that are capable of reading timestamp from
> >  TIME CSR, we could either register the compatible string of its
> timer
> >  to riscv_timer.c (T-Head case, the underlying CLINT isn't a real
> >  SSTC-capable device) or add a "riscv,timer" node.
> 
> > +	{ .compatible = "thead,c900-clint" },
> 
> I think Zicntr is orthogonal to a particular CLINT implementation.
> There might be some cases when MMIO access is compatible with some
> existing CLINT implementations, but the hart lacks Zicntr.

Yes. But T-Head's CLINT is kind of special, it lacks of a MTIME
register, but only exports the timer through the TIMER CSR in HART...
which is different from SiFive's implementation. I think in this case
it's not valuable to split the HART implementation and CLINT
implementation, and discuss them separately.

Anyway, you're not required to fix all these issues up to get this
patch merged :)

Thanks,
Yao Zi
