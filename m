Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1D1C982D8
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0992080D7F;
	Sun, 20 Sep 2026 15:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xx0MfNcxGIfD; Sun, 20 Sep 2026 15:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4B36480D66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919336;
	b=l0vJGV5bV7qZpNvhutIeHWQawJOYFwhPldApPMJzUpFhXbp+FI207Mk6Uk6Y4NbN/XGK
	 FeOBCBcBwlqyzUfkByalJv3fGWeAFilisx6bVm8kMBRCf4HvGERARlRcfuDayeLeHLKYU
	 +Xf6uchpR7fmiG38cdi0MDVKKw+DpxLFm2zXSBhVI9qJLCqfqBfv78pTxSs2tzxrX1+rq
	 XGMDwiqiHSnK0/ibkzyDMXNuQZGnOuUY+d7WSPWVbWadPb31Eu0qw/tMhIbV/VbDGuk8S
	 gMZX11fg89RZ9zws8T6lmojpU59BijnqtveSqYiSrhsqY42gOYwDy+Ap5BqwfKN9a7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L06E4vNKxTcQAdbPR+WTFFbgedCEiURs6m0ZSJIz/KE=;
	b=pQ//5PQwpwpHBeT/QyqKOtb7fgkdjWr6sdDi2YZ8tKjpzbNGWB1qTzjD15vjw8W/CmqZ
	 SgZyOtG8nnPgWtzsqut2Vpp6UyLkM+GJLdgSjj8m0fcnihibD1JwOcfR0uLnX2Ap0H///
	 9//Ll38LCsaaieRzWqA1LsGBUtuFPUyln8puEkkbzK1SZM8CDEBQXfI6g/1+qztW8k5Mf
	 JVcM33QOGlxsF8fDST2L3J7WWdC83zNsbQGbOGexJs4wEeNyhB84wsve1qc0pogWwyh78
	 5+JMz5uUXnTdneGPUsbo+HHYiN49WvRzgqTLkmfr0YlAl0mw6A//hgbJBVa2l4FzyBQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919336;
	bh=L06E4vNKxTcQAdbPR+WTFFbgedCEiURs6m0ZSJIz/KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XiQ4e8XFbUrAyQrZELPj2xXc8ZGZbIpUU0Et93ANTe39CNsHm2vNHXFzxM3Rj4vRi
	 wgmTMRurSNcD7ncjFmjZI0Zrvlducr/WwqrCBOp2yWgYjFi9KNVBzGJxHYOUQHz8bt
	 qzboMq/K/6aqZO8aM6eHdBKvgv4ZgfKmgKl2Z9ZQ6fEQ7hsJOkbXLzA76Uz7jvYMO1
	 BATFscIh1ha1dl6/1OY+K2M+laPbcGtIniNfSSHWrftqpyjzBIMswk1lIUuMcStN4+
	 yn9wblfVrrZKxPw4D05p43nNXF4Ny6O1K++J8JOOoxOh2pgTBIKX8EembvPls/asCa
	 uDtkKVcS7rFXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B36480D66;
	Sun, 20 Sep 2026 15:48:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BB2723A
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 00:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D32840B59
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 00:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpaoTL_EjW48 for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 00:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 248E740A8E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789865774;
 b=RnlbxsEzhs6LO4N6O1fvyVY0XNwRLQcPyWxbMk/xejX/CbUNBkoYD3MrmnjmCLscsAGw
 NsvVujOUsia6KGjKfTAOOT9YzJ2O6F5QkI/r6cDemb67zYA4+w2dmMxZFcDtU3gQGKAQM
 QwScHwbJ1jQtmOz4G5dAxWC1JQOrgTJyjPFtwcNhMuuhYYRaELlpDDik+bz+0KoaFXP5Y
 zncwsnFx3p1nKLV9KfI3GhChHzCmluPIVCWhWNFmLIN+UWTp1FHteExeYt+4UaQY1VQxu
 lzztXeUYJ2ThcqRLpdNHpUHKx2Um+nVCt7GLtTWjnCYJTlI6ivX/1xhrG59Sb0LQ3QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789865774;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=L06E4vNKxTcQAdbPR+WTFFbgedCEiURs6m0ZSJIz/KE=;
 b=DwOBBL1UfF16etLtdCoaQ/0kVoqt5ySpuyC2+vgixzYlWoXSi9JJ4HQZR3Y/cJAhji+a
 4dRR1O+RMKDfl6leG4s5wtomjU5wnPJYOjkVXdREEv/9YxavM8w/tXshEb2/gUMGB2bg7
 hBiir/MxKQ5i+UWV0KEeeRSqlxhFexwxbUV1poPTG29R3KkDYGD0rQN8OFSp4HVfIx3xf
 w2j9ByiUFLCXTASuVmWtqtz/CkeLRTuzsD3hbYWfioVF+ukddqcYgu2KAMV5mD+kIW/g5
 y5XHZQDLqEa+neA2EmZReb+UWbblN/mbwtdOIXGIzJoNpNiVdYxAL8bbuBBQ5fOaRAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=fail header.from=gentoo.org; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=srs0=isyi=hm=gentoo.org=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 248E740A8E
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 00:56:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE61560136;
 Sun, 20 Sep 2026 00:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D891F000FF;
 Sun, 20 Sep 2026 00:56:11 +0000 (UTC)
Date: Sun, 20 Sep 2026 00:56:09 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH] riscv: thead: fix D-cache flushing
Message-ID: <20260920005609-GYA322162@gentoo.org>
References: <20260919-fixcmo-v1-1-0a9db1d0fa61@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-fixcmo-v1-1-0a9db1d0fa61@iscas.ac.cn>
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:48:55 +0000
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

Hi Han,


On 04:29 Sat 19 Sep     , Han Gao wrote:
> Use CIPA instead of CPA to clean and invalidate cache lines. This
> fixes stale DMA descriptors breaking USB enumeration on TH1520.
> 
I suspect this isn't a correct fix, there are separate functions for dcache
flush and invalidate - flush_dcache_range() vs invalidate_dcache_range()

Better to check the USB driver, where it actually need to flush or invalidate?

> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/lib/thead_cmo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/lib/thead_cmo.c b/arch/riscv/lib/thead_cmo.c
> index b8051e29e02b..763ff799eddd 100644
> --- a/arch/riscv/lib/thead_cmo.c
> +++ b/arch/riscv/lib/thead_cmo.c
> @@ -40,6 +40,6 @@ void flush_dcache_range(unsigned long start, unsigned long end)
>  {
>  	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
>  	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
> -		__asm__ __volatile__(DCACHE_CPA_A0);
> +		__asm__ __volatile__(DCACHE_CIPA_A0);
>  	__asm__ __volatile__(SYNC_S);
>  }
> 
> ---
> base-commit: 211de43d0f954a00a490220c1aac9db298287c40
> change-id: 20260919-fixcmo-cf56064fccd6
> 
> Best regards,
> --  
> Han Gao <gaohan@iscas.ac.cn>
> 

-- 
Yixun Lan (dlan)
