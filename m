Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EF4CA601E
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 00:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CED024081A;
	Sat, 10 Oct 2026 00:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aXb2TPKH1I3g; Sat, 10 Oct 2026 00:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15F654080A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791593567;
	b=HTyxTcfd+e3fA3SYDZroNPcrUzRysdTZw5heIDwjKLBScLtPij9KwEX3YbTR0gxF5txZ
	 5NAPfy98JE1Vlm9KxgHa0ETuZYyw95IMQxzAp0nExfV5Cs98PrbaOJB+qDv2u9banRbGX
	 wXBqyG823P6x7Qa/jwNLKfBvzi5M1lcZc7zAhHJ4ZoEw+QrB7gndCu+tagG4TWeTO50+8
	 iglUTo7pCIDUFYFBLgjc8mRd7AHhIbItKBWRVhlIpdhGjeuMkofJq2zvUaY9LoxZzqypj
	 B1ZCyvPPld2Rw6i8kFZyWI1P7iaDyt9w3PQLi1dPCr/zou3wDEOIyzxMm3kcGqb3JlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791593567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b3PCzdht8O1Ikni5HyUVVgwAu+kDCpsFRJI5FRY/o50=;
	b=A5S7/JbmN1UvWXS0OEzUa9i9Y6kZPAIi4UKNkyrefm6ZZXRSdpBch67pGAl1s+sUJMOk
	 AYBZ4jh9gahdnI2koCdGL+9vW/rIFrwPsWkewrrjzFpuPvJ8MvMfs5CI6ELiRWQ61os+N
	 nNeVwVwgnM8PvIJ+8m2vcpCQEIZYTewrXQAJ8QZLBoA0XKbkAeIWz447Tc2HmvK0Nbhr1
	 C9cXvYmDm22B2q4SzXg6nW9I01XP18u1+aU2b63TLbM6FlXGWKflxlX9iH4iXchW5ffVw
	 Qxc8prUIEEhJS8rwGM4YhRqDWCn8xKE0S2Rzcv/U1Rqe9yt3uwj6epyBmGtKLb4NdnA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=TyA0pgKU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791593567;
	bh=b3PCzdht8O1Ikni5HyUVVgwAu+kDCpsFRJI5FRY/o50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKSP/GIhBDa43qnej2sEZdoBtUTuWx1Tu5NwFu6VDsunQM16N1CFi43iP1tNs96A7
	 fNMA+I4KpOrtbPOTdRS7ccbBvQlChdq6SOKMaMxmE+4kwKvTt2S3y+3TgOZC/8dcJk
	 ZoCyaSKL3NcgvPEjk8ZGMAdg8E21wnPMGk671fSIn8Y3RbhtLfR8RZ966J8/taKRBL
	 1q1ietLohsKzTsSGUgULP3j2p5VV/B3xbMQw419gOLVHSkCoiFBk6ol56UyQohoeJX
	 pLp+4Js551Os3syYBrtZZlzsne0KcScCCi0EEWTv3TBrhm9Kxh8XRFMg5e2CyqDtng
	 H8Qdu+dDIS1sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15F654080A;
	Sat, 10 Oct 2026 00:52:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 478EA380
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 00:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 126DD4080A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 00:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFxHX_dHQSRL for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 00:52:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1F21407F6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791593563;
 b=ZZzxk41qRnduDu52DKcQtKC6Lrvwp3zY+VpL7FOA32RRPw2/FpjDVRdozhCG67ILmbaE
 VasclDPaTRw0h36j7ag9bVCcPnd6RX0yNU4gl0MashbaFKUEjj9Wn9elV/1faYWX0psST
 OIhXKDqBrQBpPO08KUeqi/H2nwVD7Zj+c1SYRNtJfT0Hbh5QymoQQ5vJJKT5UZE0dHL9a
 2vPZ4EPeNid5LyyH30+sMAOWSLGObpWvc6dt5f4EPiLPCYcI5kVuSrV4n6ccJWChqFNhq
 7hnk7/H8e2GlDktVP80H+x8vHvGjFbuwu+LFWD0pClZGQI6ysdZqqWjKa+CJ6Jn1Esw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791593563;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=b3PCzdht8O1Ikni5HyUVVgwAu+kDCpsFRJI5FRY/o50=;
 b=Az6pIErw7CO6F1UeC22jYXAAMMDdLTdcGg1i3iJO1ftXMy8pm7Av1/gF2wIHBs+1ZXkh
 Y2jDPDm4Z3Z02Z/eSgFiHjG7OLH3Ng7N81uGsoAm8RRrdLSQYvb/vzPRfjuUNePkrNFjO
 jmE7tPIQ0xeTCslJw+YxgzXQYu2pbvQJUJZB+Sv441Tb3Wom2t79FPHi8IcKDKd2z+0R7
 F0p5cDhhaRGqffIGjK/lGmEnbt98AX9jcL8bG6VhOHwvaoah8ytwn2agh5wfiNl6ue7z3
 oE5fh34c9BgFVho5ykp4Z5cgBiKlpCnNZ1QjeLp+IfdsOHjSTzsjihgROKHYavJu18A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=TyA0pgKU; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=TyA0pgKU
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1F21407F6
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791593540;
 bh=b3PCzdht8O1Ikni5HyUVVgwAu+kDCpsFRJI5FRY/o50=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TyA0pgKUYz9PfCKaFW61GouLdrVoWM6TYXE6Hta+J68/W1kLG7VC8ItxPp3uwh715
 P/frLiJjhjXaONY9WfUxmTv7+tgZiiW6B5etBsragNPONs9hrkohdiGVztxIB5bSz5
 xe8Abgx/31V5l1oaLFq3vaWRZ2bzvH8BWytf8SugiePbSK7FosFYRNSijOEoI48HpV
 P/s1Qav6Uco5lcBlhg3AtmDUM+MYYPCXqpvHL/btfmajgYxK3DSECb3FOOV/MvFOMo
 7ocRItGPO+3rjzcJwjorYLviKx7I7UCX+nXcIyjQ02GhjLvHToxcDdDyXKuOA7e+7k
 pJMSLxekFb6Cg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5C6BFB221CF0;
 Sat, 10 Oct 2026 02:52:19 +0200 (CEST)
Message-ID: <ab9ae53b-1939-4a68-8af0-b7b17709bded@freeshell.de>
Date: Fri, 9 Oct 2026 15:40:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: spl: Add BOOT_DEVICE_UFS
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20261009215008.2796804-1-urvashi.sharma@oss.qualcomm.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261009215008.2796804-1-urvashi.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Urvashi,

FYI: substituted for the new mailing list address in my reply; Please
check your mailman subscription and any MAINTAINERS file that
get_maintainer.pl may be acquiring from

On 10/9/26 14:50, Urvashi Sharma wrote:
> common/spl/spl_ufs.c refers to BOOT_DEVICE_UFS, which RISC-V does not
> define. Selecting CONFIG_SPL_UFS_SUPPORT therefore breaks the build.
> 
> Add the missing enum value, keeping the arm ordering.
> 
> Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/riscv/include/asm/spl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/include/asm/spl.h b/arch/riscv/include/asm/spl.h
> index 9c0bf9755c9..4eb799d2237 100644
> --- a/arch/riscv/include/asm/spl.h
> +++ b/arch/riscv/include/asm/spl.h
> @@ -27,6 +27,7 @@ enum {
>  	BOOT_DEVICE_XIP,
>  	BOOT_DEVICE_BOOTROM,
>  	BOOT_DEVICE_SMH,
> +	BOOT_DEVICE_UFS,
>  	BOOT_DEVICE_NONE
>  };
>  

Is keeping the same ordering as ARM any correct justification if making
a breaking change on RISC-V? Would this be considered an ABI change,
since U-Boot SPL might be a different boot phase than U-Boot main app?

I don't have an opinion for or against the change. Obviously it resolves
a compile-time bug.

I am wary of causing unexpected behavior for mix-and-match of mainline
u-boot and vendor forks from circa 2020/2022/2024 -era, and if we're
anyways doing something to cause unexpected behavior then may as well
have some style guide or technical justification and not "do as we've
always done it on unrelated architecture (x)".  Maybe it will just be
"do as we have always done on architecture (x)" eventually but I'd like
to hear your thoughts on this because there are in-the-wild uses of the
mix-and-match situation and a little more information would make this
change easier to discover if it does break some ABI (which is fine in my
opinion).

-E Shattow
