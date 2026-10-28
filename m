Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21186606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kZZs+IQA;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=DpXYoSTH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5F3360710;
	Wed, 28 Oct 2026 22:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PzGGWD8D1Mm; Wed, 28 Oct 2026 22:35:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 428C160721
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793226953;
	b=i68uC2f8Z/E7QdHWhgLCopCoRhmzZlaSfcKJu8GhTz9n/HKd4xl8aSxerXXbrHsiobOL
	 Ihxi7plwIrCeshdbaBNnLT8n9C2kbQ76dptuwJcCbsKpJkkmIphCg/vgNSCdyh6CIQszS
	 FizimRBBD1bbkN8kZYJp92Etpx18FkJXE1TKwbZlfr1n+BO+ORN0m8NCF43c9F6MFamyA
	 /Jtto/P4g8aZsFL5oLZRVqhGG/gql69e8AEKZ3GkoOpI51yTieTyS/uOAqmNJNexIMOL7
	 PqwnWEPtwffrSpFrQTvHVTWunyM4IATwcCWrHWIqygoFB8D4tdqTJCpSP3yjqlXnb1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793226953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5WxHFOjPZMD9ylpKjBJU3APw7Q/4N9yQDmTjEygYx3w=;
	b=GIlx4aP/it+b161SJHiN5ZT+szqqsAR2lHT9OCxf0AgojPn/tdRMMz/DtL/8XcdQIe3+
	 t+2wYzavhJCLlIXAdk/aTJh0IbKYmRgt++sxOUzUhg4R7I6lubAi4Txturn6R4v3n/Vay
	 LDxLDezXRB4lhXdIIr/WrOswUOEoqhxGTZVUwG3oDze3rQeXwCM2eqF+lt2HDNb863iQh
	 2LiDXOSuSPmSgN+u+J+NsHK3yOvg5trESNhFG4/jYGF91U77Hj8vqyNCh8dw4S2FHlY7p
	 9qVZxxbWsERoxaNKOyxj8YpoZU1sYohhDI/GceribbuFReJRqxHJrVIlbnP8+rGo7Rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793226953;
	bh=5WxHFOjPZMD9ylpKjBJU3APw7Q/4N9yQDmTjEygYx3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kZZs+IQA97fSHh4YrJ2cRxD7ELYCqF/6N/2kKGyvcfNstjiWSzcAAQ7cvrNZUgCff
	 hWl0Cxn+ooXIzfux4ZWdNYvlYdmlGpcAaxkxkHBp6kaTSfdUr9ng0mnJ8FvR6CyuOi
	 N1S32tQRlLVCg5iE2tRxfNu6uo+0yRTyYf+J38vKlSqkwlKVdlG1FDnzBkVQuccpCs
	 WlYZCZWUIte931WLuPxJruIWRrUzxr7nICZ//Pqg588AVk73DkawA7sfGkDhonq9+t
	 I6TKwmYK5UrWOlMF8JtfKD6I7+VcWvuUleuPHaQ7hz1SJXG4d2oCupAR8/K1o33gjU
	 xshpQvHEzQqFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 428C160721;
	Wed, 28 Oct 2026 22:35:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C76FF2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C341C81174
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH5gpjaSz0vB for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 22:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C93B8114E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793226950;
 b=OLMC/t41V/yrzS/ddBOPrnAYd6UCh4ZE76zrf46caLjCsfMSb17azHxkc/EuwPuCHPat
 G4kABCh+HkSyq+FlMkjk+kB56tz0ZYCJX8luhIlRgQOS/UGiSw+YjsrBaBN2mjK7mNbci
 JNaI91uXV1zZ6ewlzNcnAiDVfkLidc0VkjUP7sn9IJAMhrqORgAufV+iYMRQK/e/QV6iK
 iU371Xcpj0zvJdyCxsuANlGA7g58ljDQyX0ZCM12UCIXhFTMVhDGQgDzNMsdJW3aJ4s8L
 YEfh1AbGJ1zYtKyPTA0NPFPO9SgQQCVMJj5kHIZ8oViRt1PfOmwsHBbqcCpEkKTyrkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793226950;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=5WxHFOjPZMD9ylpKjBJU3APw7Q/4N9yQDmTjEygYx3w=;
 b=bn7BvsP3jnRXSGgpVh1eRUVLVG7bFqk0A8pUEWHAD9XzZZVpYvg0rGZLP5n6MRkXh+DS
 YplKu9/iNI5sFm2xCNBJUnN8CoVhTLJeg/BuINcuhiy9GY3Xka3I9ObQYN09uvFTB5sjf
 CHkiO3Kykf6qkPBvbqw0vt4r0bT5mZgyq7rhm7gseeCcQrOwX+RY9AwG36Jg3PbnjTOLV
 z/UZ+AJLgSwIjXNGBCaU8oMouPC0X9QBAMydtNLriO0FA+Hz92Ux84Y/C5MHVLSYXcI1r
 +w6YsWN1by7+XovUtkK0AbvYq8D8oBuQicxLiyXB76LZsmbnSgHWPyQQBScnPUVfRsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DpXYoSTH; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DpXYoSTH
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C93B8114E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793226913;
 bh=5WxHFOjPZMD9ylpKjBJU3APw7Q/4N9yQDmTjEygYx3w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DpXYoSTHgNpxF9oXEIVFsLcooHHZEXx+SsgEOhbD+BfN7KH93ECCW7/ME6w7Mo3ou
 qEXN8lq3pu6PFpM6B4YVd2zU1StGHe69ToWFBnu5y4YhOSF6TTeDHObfG0Y6ipemga
 MTsTbXvR62Z2qV9LFcw35dO7zehkvGEAVKUqg2k3fNl2f7R4O3WsCU7I+ZToAPyk0S
 QDDZ1vdKUetc+3TLq800xCndew20ZFcGQzg5dOitAAaYCABRFPK6yJ7ZXF4JOzed3v
 IVR2Ch1zX+A3dMD7+rVL3CAE3iFLUcKgo7q0t+cj2/ozrsuiHtDKzYVb/7vzqFnzoG
 AkAXRgt1urm/w==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BB4BEB221C8E;
 Wed, 28 Oct 2026 23:35:11 +0100 (CET)
Message-ID: <d4fb0fd4-1452-448a-9889-30495e8f5b77@freeshell.de>
Date: Wed, 28 Oct 2026 15:35:03 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved status
 of mimsic and maplic
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20261028184526.1887640-1-e@freeshell.de>
 <20261028184526.1887640-2-e@freeshell.de>
 <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anirudh, CC: Troy Mitchell, Guodong Xu

On 10/28/26 15:01, Anirudh Srinivasan wrote:
> On Wed, Oct 28, 2026 at 11:45:05AM -0700, E Shattow wrote:
>> Linux boot stalls when probing peripherals unless OpenSBI has the
>> enabled mimsic and maplic nodes. Override these nodes so Linux can boot.
>>
>> Reported-by: Yixun Lan <dlan@kernel.org>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>> index 352e85e7de87..278b36acc79f 100644
>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>> @@ -3,4 +3,8 @@
>>   * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>   */
>>  
>> +/* Override reserved status of mimsic and maplic for OpenSBI */
>> +&mimsic { status = "okay"; };
>> +&maplic { status = "okay"; };
> 
> This should be fixed in the DT in linux. I guess you could carry this
> patch till it is fixed in linux.
> 
>> +
>>  #include "spacemit-k3-binman.dtsi"
>> -- 
>> 2.53.0
>>

The upstream commit that adds these nodes as reserved status is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56f37e391a626

Quote, "...Also add M-mode APLIC (maplic) and IMSIC (mimsic) nodes to
represent the hardware topology and ready for potential firmware usage."

When the mainline OpenSBI series lands adding SpacemiT K3 support:

https://lore.kernel.org/opensbi/20261028-spacemit-k3-v6-0-01d984f60941@linux.spacemit.com/

...then I think we could send this upstream?

Thanks for the review, -E
