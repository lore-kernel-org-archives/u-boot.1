Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810A606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tAZOVdhD;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=b/EMhmsL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F39D94076A;
	Thu, 29 Oct 2026 06:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3r3YjwiAoCWL; Thu, 29 Oct 2026 06:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4076940763
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793255330;
	b=Cp80qdulk2yARzdJFEzRMpIp0okBkCb7lbWNrIp9jvzobx3Ex2l6u1RDtgVzSON9SV1N
	 u81NyXvsakASoWR/5UeMSWLcQ+eEInMigNmzlrAeqPK4SgRCrHVtTv+v/s23jdnJhRe1Y
	 FOXueA/kEAuurfk1/qMop37DXSP/0zDgYEPhDNwtkmxByMtAA7WsTNZ/YTL8y4GbuJc36
	 eAlsMkpkT0BSE6xalxrhTBjZoEZF30qMU2nSYGLQ6oBEOpqV0sQp9Gs18MqORnZDn3jgL
	 jov9hgVz5tw/fl+rfjRu9o/FdUcgC1ywJplR/lE+bt6tKOYp6CanmIeaVrFx1SrFOwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793255330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x3X/NWmhkhscJn0ipTVprLBujdF9Nyhuys6bBow4A1k=;
	b=e6CMsUPfEcvyVlpFS49k1KylIv9Pvki9UQRGnG4JnwoBhVKrqoWa/8zkdShLjsWLoqBm
	 /RDybnSUBIHwngK1T3dIQMywtOo1UXlR5Y5mZf1BoKV957O8OZd15BVZ0IDV2n3SAGGZf
	 8hT8YQmBBeNHGbDowVqlB4S2W/1se9bfKVhYO9L9g7xcPIxthSqtkt7XiOUFcqcw/QYxx
	 Yx5+9TL+b48MhyIsaKiy3/gd958ild7IlfV40TQEAXOwaW09qYzVehk1lQKzm81khLQ0G
	 RXw8o6HXYpHC6Gghj+d99X8mfeo82r0jlZp90uZ1NpiDb779qJzqzMMH0UVeCFbO3Rg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793255330;
	bh=x3X/NWmhkhscJn0ipTVprLBujdF9Nyhuys6bBow4A1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAZOVdhDniM5D5WHMcoT1SR9uAZQ4bFlUzwRYZbwaeBLy4iAaDvFYSVswItHhLi2/
	 On6ObceWGxoGxpNJubQABdLCQVeIJ4Zkal8vT9svaKzIjE9mB9v2Ia/iNAJBhhdSQd
	 Y7JvKrbmAzqNhwsvUHeLfsPBnhKQDhpV2InLPnce/p+Jv7nruwp6wJXEXGTI9t7/Lz
	 I2t9XKY3KYF8lARO44nvXsX8px5PWimD9PFI/EujD0zLq6LULeDuSsjlT0tJixh0WA
	 D8wWlWKI43n/zWTkHGtRESQJeGhVFodC2iOsv8b2Dkzq/RgkA+CV05FeHPfyjkPS+e
	 3DsCHhQ9vjtkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4076940763;
	Thu, 29 Oct 2026 06:28:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52D29120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3932F80F77
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n34ZDJeDGYNm for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:28:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28D9080F74
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793255327;
 b=iMHX5WLeUPVSqbC6hPsu2DEF2MLW5Z1KfSn/Rm5al10YW98HXidHi4o0yrEg0NljKzFT
 ZVKZXpk0xnSDgpKLxsPXpfha5hCW1w280+FXxF51fkJMVB9Y6RWRlTdDY2t6XJvjHNLf2
 d9CpiqG+Dp8Ph2xW7iCNa96HpZTDgarNXzc57iBoCef8V0f6eOsX+Y8ylpOSkXECljdDs
 L+5nSZq0zl0odYTKO5+uzW6C7Pzrhyp+XpwN9dGsp3D0Ia1uDOFQaLcRiQZsVihbRKdTv
 L/JSN4M+I5LiIMMrVtlf59i5/ZiUp6TzIfMc2V/TANFkDK9VPaRUQyp0mOMC5vHHyOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793255327;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=x3X/NWmhkhscJn0ipTVprLBujdF9Nyhuys6bBow4A1k=;
 b=OkxrQxe3ldsGqBjVipVsFFSOD5GnDvG84HuLVuzzcIA5ayhF5exFYzXWrRcjcoTbVXq5
 necS5dA26V8tOgAszF7IbiWIZj/nAjWDr8XIa/DBuRtk8CPFo3EmK1X+C9TQlnuMrBXpz
 5qOxYrT+k7/cwpx3ry2oGpfuulvtG9e+vgw+q2j/pptHvvCbWBWIddtIXHa6LrvQ96tiv
 H8ttBK2D0t1Lx94o1lHL7ynwMrejtmJh2441MDtF6ohvF6/qRU0mL45Mn+QfOqEVEkeGm
 W+R41bMtKEqE4aP/SnmG7ZBhFAkyYUVePPTQ6VSYGCVxLs969CIfxBI4xaB1R8JAD9w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="b/EMhmsL"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=b/EMhmsL
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28D9080F74
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:28:46 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jFZ7H4V6Yz8v6P;
 Thu, 29 Oct 2026 07:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793255323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3X/NWmhkhscJn0ipTVprLBujdF9Nyhuys6bBow4A1k=;
 b=b/EMhmsLSWwykbHvGTBntGQSXa3sEaltaiA7yGWC4Z47iTwu5tMJ1BpNPZdIZA/uQQ4hHz
 38oDvDE3MlzH1aqPKxzwcMZ1CE0ctbpdH1Cli9uUlZzqZhUo1OeNoil+0nW6qnu7mdlXxc
 kwC87GtsbLut2OzWpFiyDYYlm87qvAmYs9o6jUfoLdJlE6rpHDG2MF5sU+rhSNAj+cAz7F
 Xa/gYvm2NFMNDhyftcMc0jjuEGNsP2o1CGTnCmrNIx2gpfOSSA2QJw8MJk6G6YxOVwAIki
 TbLsDifEPMAANTjR0d1HUCdFcCxgMAnXdDfyTJ67E5lRU3mXTafvQUQO2wvMKA==
Message-ID: <28c467a6-2ff6-44a2-9638-aa158ccaa100@mailbox.org>
Date: Thu, 29 Oct 2026 07:28:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tools: mkimage: Simplify fit_pre_load_data() data
 types
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThhg2QQgw0q0tiY4=11Ze4gBTsQbZ=arnKD5QuaCs7nfw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszThhg2QQgw0q0tiY4=11Ze4gBTsQbZ=arnKD5QuaCs7nfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fd4840fd45d6677e285
X-MBO-RS-META: k94fffkxoctcqk58rqi15r3cp3ukjb3g
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 9:41 AM, Simon Glass wrote:

Hello Simon,

> On 2026-10-27T23:15:27, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>> tools: mkimage: Simplify fit_pre_load_data() data types
>>
>> The fdt_getprop() already returns strings, use const char *
>> and get rid of the void types and multiple type casts. No
>> functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>>   tools/image-host.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
>> diff --git a/tools/image-host.c b/tools/image-host.c
>> @@ -1721,7 +1721,7 @@ static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
>>   static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
>> -				       int pre_load_noffset, const void *key_name,
>> +				       int pre_load_noffset, const char *key_name,
>>   				       const void *algo_name)
> 
> (not sure if you missed these or decided not to do them, so here they
> are again just in case)
> 
> The 'algo_name' parameter is still const void * here, so the two (char
> *) casts in the 'Can't find valid checksum/crypto' fprintf() calls
> remain. Please can you change it to const char * too and drop those
> casts?

Fixed in V3, thanks.

>> diff --git a/tools/image-host.c b/tools/image-host.c
>> @@ -1794,10 +1794,9 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
>> -		fprintf(stderr, "The name of the algo is invalid: %s\n",
>> -			(char *)algo_name);
>> +		fprintf(stderr, "The name of the algo is invalid: %s\n", algo_name);
> 
> This line is 84 columns, so please can you keep the wrap?

I kept that, since Linux already switched to 100 wide and checkpatch in 
U-Boot is not complaining about this. And the readability of this is 
better than with the wrap.

-- 
Best regards,
Marek Vasut
