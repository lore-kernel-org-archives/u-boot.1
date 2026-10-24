Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002EE606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sozoII1B;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=skBPbrWO;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=/9fE33lo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C71EA40718;
	Sat, 24 Oct 2026 18:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1COrm_KTryG; Sat, 24 Oct 2026 18:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DC5F40720
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792865223;
	b=WhNEGlWOVyK5RgQXKoX1P9bDLtlsctVfXT7/V5Q/LMTgm0unwpHyR1wrDksPzrbzsXq4
	 EK02gWLFyUHRFnW956VyC5IpiEMAZvaYCU89aIKFjKJ9qd3rpMqPUKhTXTBgK7ccKJeEh
	 zEnrEeEpHgzuWOELxRCNoAuK+o74T/GSVSdzGoh6cw9bSwmG7XXhjSdnLRbMhukyUsylv
	 9xO8Q1m4icZ7blyawMqgqwYMjZAAmG+xziApNe9fiGBjDV5FvTc+Op90d3HCmf8eSL2Wl
	 +EpMv8qZcYp3eGxdd6U2SisX6b5PhPWR1QzBbiXwRoMT6HTfeT/OvGqbAgLabzLw2nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792865223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zs1OLKLUIN0blL2HeYjkoQ2lnn+Onv5JuPYR6lnuVQ0=;
	b=oYy6ExuobEihNxgpcnR8cG8no4/3adMc3O7BI+mLbfqdjxDCmBSh17dJIQn9QZndOjQV
	 LEDZpE9zdj+/WWT2W+6uZSDDm5cUJaunXKCu3+xWp+cY5JtedcwkrvQdA33g2ZH7K/c8E
	 bzg8j0BXVlZDj+4VL5eXMnsGdPpIOA4jyKBmtlG7QN5YtDMP9ENAOYJK8EwdY5DEm2lkU
	 fT+sg4G0hLvumAqJ9Kmuuc6+uJO1MdwSecefzJ4Km/8PeGvoBRyvztYUKYYOXK7tbOQ+g
	 NI9vYC3dbDM1MZphMlVLPPqZhJEjHRrYETEhJxEH/dCN1eXpRtKeAno43rYMKAQbYLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792865223;
	bh=Zs1OLKLUIN0blL2HeYjkoQ2lnn+Onv5JuPYR6lnuVQ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sozoII1Bk1UPei/ewARhWJXGP+htroWRLrGSMSEohRJqnvH2xMGD2mEbeMg7yQJV4
	 1s0PZQI1BZi91TAW8A6SZ2+TWjyz3DFWQcMV5kbvzSGAaBYJlxUbPxeWgG2KPS6OKg
	 Mefjm8c9Al5bXxdXoLQOtmNaz1VBAYrwgCEnDMY6Vp55zZy8BnuWDq/Fx6uywiRi3t
	 B+i99dFCOdKcsucUVTYDIUlYA8WydobmD1iZxTKyc8BlQYmgRycYD4ogcwQAfxNTms
	 96gRXvNs3n2/ONIVhLy6tVIU9uzs+AF3RsoniWMjgSnPPTmsrHuzn4AkP0qQ6/r2oj
	 GOZz7sJn5YsSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DC5F40720;
	Sat, 24 Oct 2026 18:07:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B153F4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A331360644
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0XhvISyS2jc for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9218A60643
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792865221;
 b=RR+gCkg48OoY+mDO5roScIup4VgE7eqrZAsrwAg37kju5Ly56Ge4UNlGsYYCRuKzLeUt
 VHNODCwTg/EG0LxuWywtHjOkNCK5pinA5VL3o8p0fLJ89ogCdH/z5+ZOuBOu4LbvgQIMf
 Iq6ckcF/GCpLRoRJBtO8iLyUrP/oRNdAuPkswvAuao9m4+LQExgdlNdltDDtvepKkJ334
 MyzBV0q1FRCHRGwbltDKHuriwLDdF6LLdvy/jMMC1UW+LTtDdo/gYw6LvARYVpPvL03Lr
 bPZ0wvyFOLQezQI5oDueDJhqw3MMJ1Tjx2nGPQwfDJyrFvprUqfuE73JmsYgc8cE7Fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792865221;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=Zs1OLKLUIN0blL2HeYjkoQ2lnn+Onv5JuPYR6lnuVQ0=;
 b=smWv5pe4fSpGSQChO+kUoToCV8w9EWeXREtKFO15HH28E6SlMysRke/kfaBvYTaF+tsv
 3SIg2Md8+aWbmmtqPCbQOJ5tkGU2mbRUej2a3w+Q2i5wkw1hzfQea4tjKgSoZwkrzsm9U
 X1sYIyNNPmMpe11hjv5L9asjzzO2P+qOUmaH4/RW/c4/OWQwANQJ71nAGNRe8jbVyM+3b
 01OmJv77DBFgF30x7m5QS9igyyc3B93v2+MLDTAAQZBD/mWPwnhX17ezjcOKlS2kB14pT
 BoHhb6Ye21/yz6spBGHVPbx7zQyw2kfhFD/Ih5358ayIF56u0dbHA50NC3SBj6R3+ig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=skBPbrWO; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="/9fE33lo"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=skBPbrWO; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=/9fE33lo
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9218A60643
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792865218; bh=Zs1OLKLUIN0blL2HeYjkoQ2
 lnn+Onv5JuPYR6lnuVQ0=; b=skBPbrWO7ySCQxRgO4dk4z+SQSjkPfJxx6cU/g9otYtALRYFZ0
 yTQjWAStY7NI8EMXA1vMN0tT0U/zdNKF2fCZRf9AxYlueQeF8xQh8q25aVERpfY8BRMvsy4NpBw
 U/F6ujjmSXzqnn9zgmai9XsmftfpOSGo5jAWkHGDNW6r8hjWIo9e2f0s3CTWuT3p2bo+XcfyEG0
 sfIRmQyZB6GkZ+r1F4/mjzt/tTjtU6Bc7rilnDwitubWdqLGuvWjStY4eTBt0nUuiSXLqJKLbfy
 m89DggnxEgzfa4rSJTD9Qcuwab0Sdg58i7oOtBn6H6pBM+IhFpTmN+2zv91mN84ZOAA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792865218; bh=Zs1OLKLUIN0blL2HeYjkoQ2
 lnn+Onv5JuPYR6lnuVQ0=; b=/9fE33loH1X4rcmqXWVxOoJLQzhbGhATu5a03QKgc7g8sYh6Zk
 prKTsZc5SwcHlpW8Ck/ml+rZBV2UB9KEIGBA==;
Date: Sat, 24 Oct 2026 19:06:58 +0100
From: Bradley Morgan <brads@mainlining.org>
To: brads@mainlining.org
CC: peng.fan@oss.nxp.com, trini@konsulko.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add mpc8 regex to match drivers
In-Reply-To: <B8F2A8F5-5D41-4249-BFBA-4E52F59E5EC8@mainlining.org>
References: <B8F2A8F5-5D41-4249-BFBA-4E52F59E5EC8@mainlining.org>
Message-ID: <1DB350C4-057C-4296-8694-DED937593CBE@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24 October 2026 19:03:19 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>On 24 October 2026 19:00:47 BST, Bradley Morgan <brads@mainlining.org>
>wrote:
>>The POWERPC entry only covers arch/powerpc/, leaving mpc8 drivers
>>and headers under drivers/ and include/ unrouted.
>>
>>So to fix this problem, adding a N: regex for mpc8 would be a good idea
>>
>>Signed-off-by: Bradley Morgan <brads@mainlining.org>
>>---
>>NOTE: This sits on top of pengs PR,
>>If you dont pick his series,
>conflicts
>>shall happen!!
>
>My series! Sorry! :(

Second note! No idea wether to merge it into the? custodian tree.

So I sent it to lore to let Tom and peng decide wether I merge it, or tom
merges it, or whatever

>
>>---
>>MAINTAINERS | 1 +
>>1 file changed, 1 insertion(+)
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 1d331ce92d1..050b48eeac3 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -1453,6 +1453,7 @@ POWERPC
>> M:	Bradley Morgan <brads@mainlining.org>
>> S:	Maintained
>> F:	arch/powerpc/
>>+N:	mpc8
>> 
>> POWERPC MPC8XX
>> M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>>
>
>--- Thanks!

--- Thanks!
