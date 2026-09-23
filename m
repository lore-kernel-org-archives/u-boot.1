Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF14C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 19:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92F6F40E52;
	Wed, 23 Sep 2026 19:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXx1ziFWOTQd; Wed, 23 Sep 2026 19:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84EBE40CBA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790193502;
	b=PMmap989Atw4+1VQ7j4D9p1n+b6PYAEddODYkEKBquRTvXxIFkIncRLkxJSWYgpjcIUj
	 9on4QQPLDSIeR86Ewac5lXyn+sbLih2tmu/buHY8E5W3Fc1xzytSYr3GgyKn13rg+xdNL
	 CPdzYAUqEpsyl0X5biKSExltfiiHKaKAo8q5kxX2YKv6cHHKjcAfcf+AsiXuX4hObf+tv
	 ZsvOgUEVEgaQvaQ4dZDtMYnoNGKSX0nniNLIIPjLTIYcHd3roVUHLq7Lbpbzer4pRsk/8
	 3jtLbLpQOEr8Mjz5TAD8I6MiyWlF4O6X0OTyLiYBObT74jglG+1lREiI3Ir3RjpAdvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790193502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6mOiYDvau55TyC/L8fKhHtR3RMK/3bauTsIxlUPlVMw=;
	b=iD0o1r1aeTH6R3xDw7gqpCYHnLWVLHeBJXqhuGcZpvlurmqJPS1CaEUQifXBJNkMd7Yd
	 Nu0YF+QVqyY5vUVwxNd3uaYtthjSq+S8s9Mz13GI/kIwsUMYn5AxHcBzvWBGPmpmLWD+L
	 TJ/QOeLysFItlFoShqBN1lbH6OLqkMl0/7OZ4Kh/ohyIYqoNEXGUbZX5mnwhTTQLtuCdb
	 iMCnICUoUfIgLsAm3bBurFlgxyNi+ovvOhWHXNBMmdu6bNFk5vp+nxbNYjQpUbqz8IdvE
	 aOLt2ot6h5KPpN0wdNLIgM60PHf4Fd83KAs9GwD1Yf7qXIOh93S0heqQjQJlOsLzmZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790193502;
	bh=6mOiYDvau55TyC/L8fKhHtR3RMK/3bauTsIxlUPlVMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aEkflPwFIIrTS+QsYjmmnCUk2wIF0OX0rE5HlmTETs4ipHn/zNZy4PxOFVHQmgm5j
	 atRZP2P6Vub48eDV7imcYF6mFMLutzhFMIJL4acWmOlrtIYTTmEM9Is9n9k6a89MPC
	 buOE+NrXD2EBUuH2GlhGaWfcdT8CKh1Ox3SqSJTOMzXkY+C0drpVFIbu6+cc9e7NPs
	 RhMDHKMbXWlbEcjrJiV6yPjJw+GHq61wr59MRkwD02mQb1IUc0hr2O8AAsN8DaiqJr
	 AIjuY4tI9ojy2NgSfL0yGAGojzASkNX2wP1CnqRzs4M5YqkmPXLnJHhiqH/vzIk3j/
	 gie4fr7IBnCFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84EBE40CBA;
	Wed, 23 Sep 2026 19:58:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C68FE13B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC89260B9A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNJMozZ_3e38 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 19:58:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C6E3860B67
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790193499;
 b=AGl71jR6/u603WoX+aLaS4TPu6ACpoiot7jHYcpWkaCglqCEvCF+kHW2xK2dZBOOOqKH
 Eo5VFoUxlIzwJ3jaqrMPtp8PTz9QTc0kmZZCK3z/F47LsJHMKKQBR1gEXL1JCd9hP5zyD
 Rr7ZuCHMMyMWu6yPSZn6ja4sspAjpyzttcCDFOQ2Yr1RKXEjq4A4Bk6+pVjNh9UUmYfGh
 BZYpVk75TR5h5ResBNfpjGD6RXVIBN71pd1kI0i8FtZi7UB9uuCC89Af9npcdRvLZktob
 l9OmYK3D7QDJIUYdCSbzsmIiVqUozQ8iiIhkI0/GKjApTj9s1E6hBnYF0B4Cr6e8eYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790193499;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=6mOiYDvau55TyC/L8fKhHtR3RMK/3bauTsIxlUPlVMw=;
 b=Fia1kOUMnesRqpo10Gw/yxyvMfxX1d088OZnmR9+PRwRLZp/jCviiin7jkrA2Tqmnxgl
 eE9cksst3MKTA2gaK3kXYRuzAr0lblR8qkXRcHw1QLIeNLCLU5Ld7qOCGarPksJnypUTM
 7mUCGG5iLlg55++RKpaq/YcTS+Tr4n8Mu80lJBZUrINzGM0MXg/6hZoMHn1BKLp38ATvm
 qF6l+kEkmUKAGtKhMQhpiScTQVDW5SmrEqGj/9SpvKUhdOhVrU5escrFdeS7HNOjJL3TH
 2bEdbd6tZxYX0C2VXZ2Yrw9WyzVk6c/mWoyHLLQyZ5PRnLUq7BmE0XkVLX5Qg1iM3qg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=hzR2CsEG; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=4d8FjGrR; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=hzR2CsEG; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=4d8FjGrR
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6E3860B67
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790193490;
 x=1790798290; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=6mOiYDvau55TyC/L8fKhHtR3RMK/3bauTsIxlUPlVMw=;
 b=hzR2CsEGQxwh1kPcwjzJTSjvDqWjufjso2azi6PD2jQQQXV+zZS8gQAf0gh3ikDLauiUHHksnf8Kw
 03f80geX0yDwU7qoAt1uvBgCI8XZ9pSx5Vo8ioQx4b/5gdRSEa4rXJ20da9ISDq4wc3SZ8TDmkfHn7
 uwQOXy2tKyPq08HiyRWaZsB3N7RjGAlS9AvIKr1iNqIw21vwnC1ejbINmrDkNshorUsRlHpSWPdNQ2
 h79x3ynNyTZCNiF8FfCr5EPttdHAs56gQbqM48ga/iMOlJXbOJr8d3iWthvCQAj4Dwu+5Eo95JomDD
 VrBN9OzmB5UnL6d7rJBoUVzpcyHGBPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790193490;
 x=1790798290; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=6mOiYDvau55TyC/L8fKhHtR3RMK/3bauTsIxlUPlVMw=;
 b=4d8FjGrRSH0HNgjXrGK9+ZGksCfDl2tk9owrwoq61WiVj3uQ+KMuHzXE2mhth4kKUjBSxqa3EzBFw
 MYBoqLlDQ==
X-HalOne-ID: 18f89675-b789-11f1-bc14-7d3e33f7de26
Received: from [192.168.0.195] (unknown [41.141.178.209])
 by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 18f89675-b789-11f1-bc14-7d3e33f7de26;
 Wed, 23 Sep 2026 19:58:09 +0000 (UTC)
Message-ID: <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
Date: Wed, 23 Sep 2026 20:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com,
 dlechner@baylibre.com, hs@nabladev.com, xypron.glpk@gmx.de, heiko@sntech.de,
 raymondmaoca@gmail.com
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <20260921202435.GC858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,

On 9/21/26 21:24, Tom Rini wrote:
> On Fri, Sep 18, 2026 at 07:42:56PM +0100, Ayoub Zaki wrote:
>>
>>
>> On 9/18/26 18:53, Tom Rini wrote:
>>> This is interesting and something that does have to be on our radar. My
>>> first question is, should we not just update to a newer mbedtls release
>>> and enable their SHA3-{256,384,512} supports, and anything else we need?
>>> Then we tell people that need this that they need to move from legacy
>>> crypto support to mbedtls (where we get to leverage a wider community
>>> for security audit and response and so on). Thanks!
>>
>> Hi Tom,
>> Thanks. I agree with the long-term maintenance benefits. ML-DSA
>> requires SHAKE128 and SHAKE256 rather than just fixed-output SHA3.
>> The TF-PSA-Crypto ML-DSA integration is marked experimental in the
>> Mbed TLS 4.2 documentation.
>> For this series I would prefer to retain the Linux kernel-based
>> implementation with limited U-Boot adaptations. A migration to
>> Mbed TLS could follow as its ML-DSA support matures.
>> Would that be acceptable?
> 
> Well, a problem I see is that this is something that needs active
> maintenance to stay in sync as we don't want to miss important fixes
> here. In theory, we get that with mbedtls (even if we're behind atm...).
> 

Agreed. Importing the Linux implementation means taking responsibility 
for tracking upstream fixes. I’m willing to maintain this code, track 
changes to the Linux implementations and bring relevant fixes into 
U-Boot. I can also add a MAINTAINERS entry to make that responsibility 
explicit.
The goal is to prepare U-Boot for early adoption of post-quantum 
cryptography in secure boot, particularly FIT image signing and 
signature verification as some hardware already ships with PQC 
capabilities.
The intention is to switch to Mbed TLS as soon as it provides production 
ready ML-DSA support and the required SHAKE functionality. That timeline 
is not clear to me yet so I’d like to prepare U-Boot in the meantime.
Would this address your maintenance concern sufficiently to proceed with 
this approach?


Mit freundlichen Grüßen / Kind regards

-- 
Ayoub Zaki
Embedded Systems Consultant

Vaihinger Straße 2/1
D-71634 Ludwigsburg
Email    : ayoub.zaki@embetrix.com
Homepage : https://embetrix.com
VAT No.  : DE313902634

