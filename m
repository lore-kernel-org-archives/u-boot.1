Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD83606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AGC6rRJj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=i5h9OJRU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=hzTP63ng
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 263A880D99;
	Sun, 22 Nov 2026 14:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VY-H6XX32pXL; Sun, 22 Nov 2026 14:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF90180DA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795356229;
	b=Mz2SSXsFn7KGrSuZiCiD0VT/J+8aDlWi6TWCyR4UxWPI7UvlGibjN27EGvL5wa54XCrV
	 gpwJXkUG50AJIIye0/hdgSBipJZRI46fDR7RghciYPF8Q7LHxs811ZAPjp2uBJdAzGMUf
	 DtQWYa0DZCjumyn/Ok/sQ2702qP1w8wEj21zzdEb1LI6Kl7u035d0OywRH5WURcWXiegH
	 OGD+o6mTj8gQE5CSTS4B77OltSmUMQ9Xvs5i72ml5qFcPGOxH37ntA4rKbfFS3I0xpoin
	 YeZUBWSTRPNCVbw9az71ROyFcTnUslogFRb/AcgBnuE0OzW6xH8bCIyrJKkeDUprtDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795356229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QTR4OLfXWdT+X0NsiiFjxUZO8RHRIboTmHw4yW8PC0s=;
	b=MUVu42j4CZAxf7avU9DPuayiHR1KNrinFTlHVItm1Pqgyw4Y/QTahCIjT+OuGo42OwxN
	 sfwpk7aPZRRh4qfHSP9hIyBXGRlQVxBLddYW8WUvFgaUpnktqztMdrpSOfrVg0++LboH0
	 v9WKf+QnijGqLnz1ivKG+WvaoRFBswzNqcXlkj2at8JSRRzeskmSLqIM+pwtz/G1aJcVa
	 Br2hB2ovNg6JFeyBoYAadg3ybPXPhjSY5Lb6wb6iHoS8RZO9uaFWD4ytDEAjTSpEFIwsx
	 wMemM8SWKBIu0QsEyIyyIV+1mVOXK3uXMU0HHdx0BlJJuQY04Md/Nq7tieiPd98SR3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795356229;
	bh=QTR4OLfXWdT+X0NsiiFjxUZO8RHRIboTmHw4yW8PC0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGC6rRJjd/F192tRt7/XaqIStL0jzgz4a8vxYOoLFRs+PiLsZU/9Za+kjZiU8gHog
	 SY0bevH3qyoDLWyJtMhumT8cHB2UwTt2iLnx2Qg9NVNpDXhyjmdwALtSnHO6ZPSEHc
	 HfoTnYF47eN6XkEuqxkR8XP27NisuO01HsQIZULaSSDls4aDLom9o1P8o+ZjPr3Bu9
	 8+RXX024pqTUYHAM3fe6iEwYMNZE3hpdIfgylQYgXlJ30wPJEOPcPlyBb6dWeg8Heg
	 4yyVxo3GyUUspgkRNy1ECR+0Ugd41PrYdqN4hWvYyB+3v7UhgCYBEpXp/Exo+9ccDx
	 zUvom9ofoaPSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF90180DA4;
	Sun, 22 Nov 2026 14:03:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 72245260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63D5440627
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:03:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfilcwwTbzTi for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 14:03:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD744405F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.10;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=i5h9OJRU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=hzTP63ng
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD744405F1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=QTR4OLfXWdT+X0NsiiFjxUZO8RHRIboTmHw4yW8PC0s=; b=i5h9OJRU+DppojN3oofQ98oJe7
 roDbbC+7SIV43UkznWQXRDG1PTS4xsTDikHOvPslDYxKfwcSe0Eey7rUGgMLJOhqsUfD5iskf56rM
 zhySsqoWYxdokL4OngfmV4O3eR3rAuS3cwpXm4QGW/3MJVByJC4J8v4Jyfw0a6RPbSLw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xV8AO-00000003SK9-3oIh
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 14:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=QTR4OLfXWdT+X0NsiiFjxUZO8RHRIboTmHw4yW8PC0s=; b=hzTP63ngX3Xb3d5Z3mCQLF3Dh6
 X+eq41729/zszw7gT5XBVri8Ga/0s94mwisZEbEF/kTuT7bfI4JolqSfQtuys6zSqjkdoid5FIj1Z
 ExhEOQ3G4yTX2AXLxDcWZ52soQQSGKw/It8P6VOk366WoJKCYiQhi5ewuCq1+9DJuJZI=;
Received: from [95.251.96.187] (port=64528 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xV8AJ-00000000Lae-24NK; Sun, 22 Nov 2026 14:03:35 +0000
Date: Sun, 22 Nov 2026 15:03:33 +0100
From: Francesco Valla <francesco@valla.it>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 regulators as bootph-all
Message-ID: <awL1l3x5U0GRhY-K@bywater>
References: <20261121-beagley-regulators-fix-v1-1-467ace9d717f@valla.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-beagley-regulators-fix-v1-1-467ace9d717f@valla.it>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c8fd8899837867293388639f0256b323
X-AntiAbuse: ID - c8fd8899837867293388639f0256b323
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xV8AO-00000003SK9-3oIh-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Sat, Nov 21, 2026 at 10:35:13PM +0100, Francesco Valla wrote:
> Commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
> missing") changed the behavior of TPS65219 PMIC driver, which now fails
> to probe if the regulators sub-node is missing. This leads to a hang if
> a device marks as bootph-all the PMIC node but not the sub-nodes.
> 
> On the BeagleY-AI, this results in no further messages after TF-A in
> normal conditions or, if early debug is enabled, an explicit failure:
> 
>   spl_early_init() failed: -6
> 
>   resetting ...
>   no sysreset
>   ### ERROR ### Please RESET the board ###
> 
> With the bootph-all property added to all regulators, the boot completes
> successfully.
> 

While preparing the corrsponding patch for linux-devicetree I stumbled
upon the same done for the Beagleplay, and in particular the reply at
[1]. Should we instead drop the bootph-all tag from the PMIC driver?

> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> I'll send the corresponding fix to the kernel as soon as possible, so
> tit can be picked up at next DTS sync.
> ---
>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> index 0e810e7f492d..72f9284471e4 100644
> --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> @@ -57,6 +57,30 @@
>  	bootph-all;
>  };
>  
> +&buck1_reg {
> +	bootph-all;
> +};
> +
> +&buck2_reg {
> +	bootph-all;
> +};
> +
> +&ldo1_reg {
> +	bootph-all;
> +};
> +
> +&ldo2_reg {
> +	bootph-all;
> +};
> +
> +&ldo3_reg {
> +	bootph-all;
> +};
> +
> +&ldo4_reg {
> +	bootph-all;
> +};
> +
>  #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
>  
>  &binman {
> 
> ---
> base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
> change-id: 20261121-beagley-regulators-fix-3306a2b896f2
> 
> Best regards,
> --  
> Francesco Valla <francesco@valla.it>
> 

Regards,
Francesco

[1] https://lore.kernel.org/all/04ef3762-86d5-4d61-93f4-202f0c120433@ti.com/

