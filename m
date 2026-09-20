Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1E4C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 10:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF51E80F8C;
	Sun, 20 Sep 2026 10:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UB6JFf31327l; Sun, 20 Sep 2026 10:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0EE8080F86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789900746;
	b=lgUvaWjBQvV0RCw9hGVZIAlpXW7uc7sTmA2jkFC0T2i1YzqMAgSZ150zhBWp4/iyVCqH
	 hVG3sYNYF6//iyob1UNvXJhDe198CLmGfxfwdS7SzjTBkMXikBnSbE4E8/hDZLPH8nUZF
	 1m3rx1kyEKJGDuEPMvUuF0qF3pHPfe73HIQ7f28Ik3vbQUlZTwbit8PRIYC3RORy8b0Oo
	 hGuRVANjIAU9EPd4FtrbN0ZiwyCZRp21y6vqoOBe28en+ke9DQxBe2xNcb/DJn+9/BG5i
	 2LV90mUKdRtKXvSji+Yrq1gMq8vgkgvabmHc4AoBDIiNZhyCnF+FvH//9BkHxwogLvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789900746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H7hSiFCK2QQU0TPsAau6qxvNMULXTymT3supVnEBTJo=;
	b=OnusOLjK6gjCpXgcsqAVDX+2ONl81+RTw2ry6LWSujcR1keCL9tDq9W7csH30l1de/cr
	 I5xUO1yZyLS9LjeHIe2OepVRRxM0ZiiUuKehRIYzojZrvoZgXKdtQJlpzCGbOsarVutQX
	 krQq6joxksNWB17RiEtu5k4k07f13BBykWqOcxyI7cxNbxqp6Q9r75Jg+XJ6O02m4Knhd
	 IfoQeOoHOKNyj1S0bx7tvaBIrFB5MCO24A+1OcEUwcfGCCBm+85AAI9x3HW88YOiFjnGJ
	 wc8ggpMh91fTf3c4HyqGv0DHSwN4pS9595ONcTzVg7RK68BfOOocba0hkdkrMQEHDCQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=E97lMpqC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789900746;
	bh=H7hSiFCK2QQU0TPsAau6qxvNMULXTymT3supVnEBTJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=opeDebViObuMx6mK0L8xR2u0e+MsfTa7VGyiJaJbdbKNN+9Wv7x968HUbymZI5klH
	 84fM4JEaGQBOKb9W2yeci1O2fOUjeIKDxYu5H/ryPXIS8rf5JJIcRH7VBEtm8uzyBm
	 w3youUWIWKsfCD9hE+5QEzBHtFFD4oNZYeDR+WDl1EMNX2H4SVItYo0TLrLBJWgn0U
	 477VZ9uMChwkEGR0FaCERx/zYiJaEm8EI5AEX5yHo+RqX90dPBRrjl5JdDKrqIHRnU
	 xijTO4nh0EVliaz5u2LGRl9Dti1Znh3Uum0noFQOeCit8IzTjeIlXOtcw5IodpAQlu
	 5h8VXcKyLfMDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EE8080F86;
	Sun, 20 Sep 2026 10:39:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8402924D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6965B80F76
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hFQDxs__cmBL for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 10:39:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8C9F680F78
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789900743;
 b=Uk7Gjw3edi17EBPbR1Bi6eqZIJMMCAdrwkXE+YVhMWVnCpL1BD8r3ZUcEqEeo3MVpVSz
 eiQsvzLLlHAUtoD9ev0FS3zYR6N1eS4zn/ibwfk9tfmIl1yyB17C8VR5TqlrC6Icj81SW
 gtwKc8bJYCvS4f2UmcJO+zuTmUivPmfwBpnoG3UOgz7yW1iCKsL1bW1QVxCgONxgbL0uP
 w2jTIA+WzWChC+A8Im9bQm3SGMsBECXPOKYCaphytT11S87dlNvw+iiUrnQCHj72d40fH
 FH9oZPbI1Fy42eEpAUDDrT/YRlQEfQEtu97BzF7L/LA+GyVPY87HUjHiK3kV+YIezzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789900743;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=H7hSiFCK2QQU0TPsAau6qxvNMULXTymT3supVnEBTJo=;
 b=EQCyUYuICZizCAe9TFZf6B2lvzDPgQw+fygYBZlWW1AJIJNk0J/Tl+gTkxi6+cV8ToLy
 gtpS/XZTzt2FQS4CMRsiXR40nMEKQD2xiFbIpjK5nVrI9WjVJrMDVnBjShMQPJiLy01gs
 kEOsQzinLSVNViZvyxQGV5pmJtYo3iFbak6dO3GIuDI6vHKI/alfqEL4opVef+b16nt30
 4TG62zA1rr5dpTHWZawgaJwyAFNlj9duwc+CcfYk8qRjFIk7PeeL0jdd4ThmRH2LZw9Oo
 8IAxmHcSQR4Z6RIgdP/LGYQKHCfkUrKe4svyGmdJ/mlTsQOMKXL2SKphgBJZAvoucTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=E97lMpqC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=E97lMpqC
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C9F680F78
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789900719; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T45EMLRpapgsy7y6+Ug+zv3C5fimGyGfPZFUhapiJtxdjWNEUxTwIlNW3GTsnekDdYcs4bcCc4AbKRWR+iAmgY+5MkJmxcgZnKjVyn0iZBzXXX2V+XzTgNwhVWtlxVuFEgIatuIo+vgQZe3L4z5n6mP4c5yUa63IqG8RGB8Kx1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789900719;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=H7hSiFCK2QQU0TPsAau6qxvNMULXTymT3supVnEBTJo=; 
 b=gNZvJbzIkpyicgmULEYjVF4YuvFcMilq8moHhFkb7eupbC2VfDaj4SHLa51jIKs9Zh0bGhXLc0RgSVVHx0JxFzzvKTTmkk3ryX8IOIpDASZgqbtO1YwgY7EMRsOAJqvVCMVI79FLvG/6HqCJY/xlpNKta9HHVYF2mw4RQHUWfAk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789900719; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=H7hSiFCK2QQU0TPsAau6qxvNMULXTymT3supVnEBTJo=;
 b=E97lMpqC5yUm6lkYUWB3Y3BY8ZVnozr5XlIFku+FLCm3R0hU+eB20PRmHQQ2jIMC
 jerUmEnWaU2+3TnFCz7IUuT6Gi0J0qtcT69o05N03VoozgcVGDWi6HApsOizzAhx9Cv
 Ob5rk7WLeF8zyyEbuD0gKZTg7fqxU54V8r+36NIY=
Received: by smtp.zohomail.com with SMTPS id 1789900717970970.4208406928216;
 Sun, 20 Sep 2026 03:38:37 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:38:33 +0000
From: Yao Zi <me@ziyao.cc>
To: Yixun Lan <dlan@gentoo.org>, Han Gao <gaohan@iscas.ac.cn>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH] riscv: thead: fix D-cache flushing
Message-ID: <aq-3qRad3KYZgH_x@pie>
References: <20260919-fixcmo-v1-1-0a9db1d0fa61@iscas.ac.cn>
 <20260920005609-GYA322162@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920005609-GYA322162@gentoo.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.848.60
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

On Sun, Sep 20, 2026 at 12:56:09AM +0000, Yixun Lan wrote:
> Hi Han,
> 
> 
> On 04:29 Sat 19 Sep     , Han Gao wrote:
> > Use CIPA instead of CPA to clean and invalidate cache lines. This
> > fixes stale DMA descriptors breaking USB enumeration on TH1520.
> > 
> I suspect this isn't a correct fix, there are separate functions for dcache
> flush and invalidate - flush_dcache_range() vs invalidate_dcache_range()
> 
> Better to check the USB driver, where it actually need to flush or invalidate?

Whether the USB driver needs a flush or only invalidation or not, the
current thead_cmo.c only cleans the cacheline in flush_dcache_range(),
which is wrong.

But out of curiosity, I have a look at DWC3, and found at least the call
in dwc3_ep0_start_trans() requires dwc3_flush_dcache(), which is a
wrapper over flush_dcache_range(), to really clean the cache, otherwise
the DMA data and TRB might not be visible to an incoherent DWC3.

> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Regards,
Yao Zi
