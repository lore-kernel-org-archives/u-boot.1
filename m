Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29076C982D0
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 10:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93D6060658;
	Sun, 20 Sep 2026 10:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYRV-Uc7Ppic; Sun, 20 Sep 2026 10:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A172360623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789899769;
	b=FMenO9obmVUjVhwMdTi4DMx7oOM2tcHpQNa8o0GNCUhkhsoji/E0tS5E7wKyxnmmsn3L
	 OTPk7FhShBlKxSnFmNBhH9tiFwmuGNXxyXrYMO7TKzHFR6PwSYk9qfjJMiTDrKv4xfy1W
	 ZmCy4GUoYpX/DkySmhPFss35n1EQ3faU8gFydbVuvs9f/R7ZAe6auXfHfQdCiKeZ/+7BQ
	 xAkTtHd5MaygQlm/LkMloJA61/hYBIlOL4UJnXQNWhmSZa1C8rbe8+vI3hvDXyuAUiJmI
	 htPCR1rr3RNS2/7fjyqCLiT0qVvjhznvXESvrD4KGPLDbDV7/fLrXWt4XDSs5g6o+KA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789899769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PbA/txLvGolDIIK0CeqcLK9MAg6ozzJ5ub0VRZmWRgw=;
	b=DpGH8RzHcdK/5uBNeWjhLRH1fKOGSt1OL9lhEZA3K0oPe9kj3TWotS1r0ky/PqLZxk2m
	 asQGR67yh9oE5JHMaFkYTCBrX4gS9PXcOPLafV203oMyZuU65+1VZpVfgOsYUCi5q3dBB
	 +syUUat0eEshS0ygs+Nv4ZCMhhQ3kr2GwTlDJFsET07sKkRiu01BKKMjS4ondDhvE9/vF
	 zDR3+826FIS0+CITNj2ksM0YAxBmYHkL+VtV2G18yy48cCLUBHUEkKfSnC7JAJ1rU93Wz
	 bjNEgTqrInWReJF7I73hcURgN4Bs19w7Y5znNzz/KHJ2G9bGIzxHGNBvMy7Lu7antKw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789899769;
	bh=PbA/txLvGolDIIK0CeqcLK9MAg6ozzJ5ub0VRZmWRgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XnTykQfH8fpOnixoZ3GK+qcmXRCfw5qQpppQqJP12d/NrxMETE3GUNxYnvbqwwYAC
	 EDz1lq8ZZ3MWOP+IuMLW4Py336g+gEwg+sgtqcXhUPgLQxpf6n1CopxvlUImVBh5wh
	 zZp9pam/9QrXCFyKRO3MkFoHXsnlZYvXJuyOpq7tIPY7t64ZAn2wvy2zbjctvjcQtu
	 +RmYyXCvriV7F979+9dTRqofAD6e8sxr8D5rVRzHd7oZL2LyWYwi5IZHckQs63PODO
	 fl9qo+Zo5sqm/+XincAGwBwRNnPK4uwoT71jLg1bqFtbC/6jVG0y4PelnU0ZBm7srk
	 8VYmsrT2VmILw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A172360623;
	Sun, 20 Sep 2026 10:22:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD52E371
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F32B40099
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M6HFIilh70_d for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 10:22:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A87014005A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789899768;
 b=lZ/louj5by58BDPZ0V43eHEleG9hmKY/PLkYP3GBMzi1p2cQeghAKdxLUQohWtsqiuSa
 r6VCVYoSidwks+C56C9zpEGq11xqmeyc8RplR9nwErtFXqhaNrBwQsMpuG5RdZ+whJO4u
 T5HT/OwrN0DapWDZwgsHM7xgXrrQvRNdtSwYnff7bejd/dzO0peMYC/hXoZn6CF2jac2X
 76C1BDp3vpaEFM3bgi0LpvPBEdzttLcuJuv6XlOadWQMi/Ts4Agstcfc3e400gX+48c+p
 rvkraSpoBncWKNDW1TK08DaxZi5A0yb+KKjhOZbwHvRZvkOAGilDdrL/CQ3EyjNgymw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789899768;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=PbA/txLvGolDIIK0CeqcLK9MAg6ozzJ5ub0VRZmWRgw=;
 b=TRHpWTzASwuR9y80gNGgO7EMZE2nDLlzsRvQ0yUc3Hs+zVA4kZ9eGxUTzncCRAxfweKp
 LfEL0pkV/yndRUK90shvTqcPeNN92DoCoIeha4sQfN7FcFyBEJZb4mx30E1u0w36mYOA+
 AI4sRa/6VoYk202BtWvaDfRfArJ8AvSfDrCu/LNX7sAOo5L2t1f4lA2RUzmBy2gHWD5z5
 6GsPy8AZD002SD6c4YzJXY+sCpPi1dyJh3T5sBTFJexT7CjhEP+3sqwmpGDXI0dJOI8T3
 koRTwnUY9pbcNgwSgytSpXyk+6LF3At9jO+6VgQl/5Au3JYni2FiKHGZQw9I3ICU/AA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=jsU7nixV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=jsU7nixV
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A87014005A
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 10:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789899747; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SEs0rMMHmmB12TDlAdd9GjNY1JpV+SrPPL/NhxLXxLIM/paCGXp5YlDP9FFJ8QvBjX/cQoWT7PsU+EFQDL2K1wou+kr66lYnI9w8kwByZFUlJg/dsKzlS+nT+QEuP9BLrPX56gKMmCirmYwppZeS10g/+034bxtepqpuewbzcyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789899747;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PbA/txLvGolDIIK0CeqcLK9MAg6ozzJ5ub0VRZmWRgw=; 
 b=ZLJ6seeKIhawKGv9XHNDR11IQzOzaO4kltW0yaxCyu3maMdRdAo+MgpQyu4d6E4Ma+DKUX0ZKjYpl/uVsUx5Rr4pXoMKXMpLyQ2slboUD16uzv1zciaDCnobCjtDI3q06v+elHEPNA5StwrDWdsQDR4gBat8pREiPCV0cxUtE6w=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789899747; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=PbA/txLvGolDIIK0CeqcLK9MAg6ozzJ5ub0VRZmWRgw=;
 b=jsU7nixVf5WVxvA4mzzxRMArsHXbqtxQ9D53MGvrL5ZKGuJixwpfQL0iAozRhdNn
 7Eh+Pnt+J+neNXx9Rqwdun5CD0pSgzfrkwaB5R9VjsbIAeG2d6dJXjchRbdACB4NB1J
 RYcKJCnVCqDMEiPcDqYFqr5GQ8wifbq8boV+M0EY=
Received: by smtp.zohomail.com with SMTPS id 1789899745529833.2384331814807;
 Sun, 20 Sep 2026 03:22:25 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:21:59 +0000
From: Yao Zi <me@ziyao.cc>
To: Han Gao <gaohan@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH] riscv: thead: fix D-cache flushing
Message-ID: <aq-zx89k_eDPm1X3@pie>
References: <20260919-fixcmo-v1-1-0a9db1d0fa61@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-fixcmo-v1-1-0a9db1d0fa61@iscas.ac.cn>
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

On Sat, Sep 19, 2026 at 04:29:41AM +0800, Han Gao wrote:
> Use CIPA instead of CPA to clean and invalidate cache lines. This
> fixes stale DMA descriptors breaking USB enumeration on TH1520.

I guess this issue isn't present in mainline U-Boot yet, since we don't
have USB support for TH1520 currently? If so, please omit this part in
commit message, you could mention this below the --- line.

And it would be good to mention the meaning and full form
("th.dcache.*") of CPA/CIPA here, and attach a link to the documentation
of T-Head's extensions. As a fix, this also deserves a Fixes tag.

For the fix itself, it sounds correct. I had a brief look over several
architectures' flush_dcache_range(),

- The zicbom path on RISC-V makes use of cbo.flush, per the RISC-V
  specification (Volume I, 19.6.1 Cache-Block Management Instructions),
  a flush operation atomically performs a clean operation followed by an
  invalidate operation.
- MIPS uses HIT_WRITEBACK_INV_D & HIT_WRITEBACK_INV_SD
- PowerPC implements flush_dcache_range() with dcbf, which is described
  as "those locations are written to main storage and additional
  locations in the block may be written to main storage. The block is
  invalidated in the data caches of all/this (depending on memory
  coherence) processors", matching the behavior of flush
  (clean/writeback & invalidate).
  - flush_dcache_range() is no-op on platforms other than
    MPC85xx/MPC86xx, I guess coherency is guaranteed otherwise?
- ARMv8's flush_dcache_range() is also commented as "INvalidates range
  in all levels of D-cache/unified cache"

So this fix aligns thead_cmo.c's behavior with other implementations.
With the commit message improved,

Reviewed-by: Yao Zi <me@ziyao.cc>

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

Regards,
Yao Zi
