Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B8606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yVJbWFDW;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=PaVwfgQr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C438D80FF5;
	Tue, 20 Oct 2026 12:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWKiddd7R28p; Tue, 20 Oct 2026 12:53:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18DF480FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792500833;
	b=mzTDYRSVAuOc8ETEcwctigjJIx9qWfLBRf6CpSYkYF47zkDspRi22XVUbYS3PekiIzg5
	 VRgrCRnaO3Bx6Vp8eA783mUcOXuUpuy9kdIfqlgk0D0CGd3Ui7GA39RfAMkD6G4gtksrc
	 1k5enpmP2nH8kpS69nNTDr8T5ei/29TlUaI0F29CfeV9X68YmfUaS/cNJzEA2JSoDn7Fz
	 lAhqozYr99TsppdtsAoByYrCbp/faG0tkoGOxdbYO+S1sxTVZHuP+H2qa1ji+7GE80jc1
	 lh61deYHlpYeuxUhLKugv/h2jbPTvXUnEhM6UHEKfQIcJs60RViR0Ed6Eq7R9TQWxWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792500833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B/j0edgDzvMiLsbLZ3OFMZsuHbrhEK3zwuVNZdcnoGI=;
	b=em/0DBR276qfbiyz8ClXnMzcOxq2/PK0WUSUEGjkn8rOm56SESsMAnHyQPbGmRhLlZBQ
	 7In/ZfgVhTQhDq8cnkw1aEu73vCuP8pP3vAT+IOo2OeVg8XxK658bsDf39gBQdFGU4Mu4
	 ulT2DaKf2SOlKLPZk1NWjFhcYZGaCNz5b/8iBxKPAu/+6HSDME7fjYSlSvWIwY0e7xp40
	 BiyEVNpg/N2dvzfL1ATpogTQUgcxOlxTWddez3BEu3LkIrojwOSdqweaCHm2r2OvuQIy7
	 kHfzRm5p5qJv1CkG3rbZX+93zEUIGPIN/PHTrJ9lhKBjWmP5dV4mlDB2eYk2BC3VXRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=PaVwfgQr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792500833;
	bh=B/j0edgDzvMiLsbLZ3OFMZsuHbrhEK3zwuVNZdcnoGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yVJbWFDWlgAjbNSNOCck/6krbxUGCgQ41iBrP2cvv7E+P8pMMIDQaode12lGBe3xe
	 y3Q0JaL5MLgPjQTb4EdGofm1w/9gWfvoeAbdTRmVQ8f4KH739yQS0P3ePucv4SLB20
	 NtqHBT1StFlACo/5n1hYT8zhMUik7o1r3xsNAQRTPQDg+Lvt9Z/9RW2r6SgdjFhh9T
	 HrYw5nvV7mtAcBushx6UYJlQfKbyWxtmKvq72xvy9vDLVjAQzKkjSrJkxH16aZaUBU
	 Ju8JooN7/LSlgat+8DwRrzWcYz2B5DBnyWtujuVcSi5jYonp7IIbDQ0t8FoBZHMZPA
	 FY/f8W5MS5i8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18DF480FE8;
	Tue, 20 Oct 2026 12:53:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 744AE769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65CBD80FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNeYAWAtN8T6 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 12:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ECCA80FB9
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792500830;
 b=PqTy+majJwwB8aMNjIkXe76mIJ8YzOq1q5GwXsm8SW7rkI8eEZEPB0qdd9CV10ngvEIc
 qyf0d/t/aBuwIhaQ++JKR04X6nBAbw7+FtFITUdQSvNtDnHuEyOgoXiLkonIaJQpS7Nua
 LDrbzF6zrftBua58wOjjwf2BD5/DNff+MLo7/VvroJHJ6d07exHsZz8QANZP73NKxb1HY
 wCb0VB66KRB4850veXCr3pavofVptzBfCpgZUcSGZktLcxYVVTGAU5VbgA+g+AR0qAlDh
 PlSDpgu2TNWJpeiFdbFgjVzIVXgQuu7m84NNYk9hJnqu6m8EQSbowKOXWG1LMTGT20Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792500830;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=B/j0edgDzvMiLsbLZ3OFMZsuHbrhEK3zwuVNZdcnoGI=;
 b=Fp6f2EGBIwdj/Q3eaWsmfPqXFJ5pzL0PhmQpJtZRKqofUG2UNZKxuZ1uGgWRddYTgKRv
 Ftup7xioMbxaKodTkeZCb4NlJpMrmop+jT0DnNE2hhdIIMeHZNtvCfpwJhE7S95bLtSjr
 kh6ZmTeJ/5GbojkQjcNML3IBlaRxhatzYZvvq2WNXhhCf8MfNSk48BIuaVBnYUIaHgdyM
 m6dxvgRKmMWBUDiZ9fES/kwh8EM/Yf6oEvHue5tXBC48DCdzAVCa7he2XMBaf3vLNRe6K
 aUjScbI9MouhDR/JaR/Fdr/eTZx5nFfGEzrELfOoaBGW14LUhOSDpOpx1TfR+HKz/bA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=PaVwfgQr; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=PaVwfgQr
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1ECCA80FB9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:53:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7D7AB108ACE; Tue, 20 Oct 2026 14:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792500821;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=B/j0edgDzvMiLsbLZ3OFMZsuHbrhEK3zwuVNZdcnoGI=;
 b=PaVwfgQraDTjt8Su30SKWv8pWeXr/0zjo1W8ecqsZDRmPhnaB3M+SRkLorV9hAdKpGYc2Q
 arl2O11/aVo01nMtmkcF5GQY5MtN9VFqM5w09hLaI3GIqORJUKBiywZz45wlQbjvl4npoc
 FLdfsmyMPmIbnyoDfRiXQAlP/Csn+x2KLF8ERtCw2NBXuw+62S5Qa8doAqL96G9bVS5dyQ
 RfgH4n0jO8dZVmUSpxu8ID+BCtEmrSMZ0Pgi6bp+7TaZ+1b5WxOo2P2+k7CJ+yGuB/MlHR
 85CcW6YlK4S4tUPZxB8aZupv2hQigwnFjawBU44q5SftP+rfH6J3en5qNd4Fpw==
Message-ID: <87500fbd-8f56-4d40-bc22-9aa68635f1c1@nabladev.com>
Date: Tue, 20 Oct 2026 14:53:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Richard Weinberger <richard@sigma-star.at>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
 <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 2:29 PM, Richard Weinberger wrote:
> On Dienstag, 20. Oktober 2026 12:22 Marek Vasut wrote:
>>>> -	  writeable flag can be written and modified at runtime. No variables
>>>> -	  can be otherwise created, written or imported into the environment.
>>>> +	  writeable flag can be written from stored environment. This
>>>> +	  restricts only environment loading, not runtime modification using
>>>> +	  "env set", etc.
>>>
>>> Wow, just wow.
>>> I always assumed that the protection applies also to "env import ..." too
>>> since the documentation explicitly said "written or imported into the environment".
>>>
>>> Instead of fixing the documentation, are we sure that this isn't a serve (security)
>>> bug which needs addressing?
>> If the attacker has access to U-Boot shell, then they have unrestricted
>> access to the system and it is over (the attacker can e.g. modify memory
>> which can be used to circumvent other protections). For the writeable
>> list to have any meaningful effect, U-Boot shell access must be disabled
>> (e.g. bootdelay set to -2 or similar). The writeable list protects
>> U-Boot from importing undesired data from the external environment.
> 
> Well, I have a different use case in mind.
> 
> What if you have something like this in your bootcmd: "env import -t ${loadaddr} ${filesize}"
> to import variables form a file like /boot/extraEnv.txt?

How do you authenticate extraEnv.txt in this case ?

If you do not authenticate the file, then it is game over.

> I like this a lot because it allows applications to set various u-boot variables.
> And to make sure to allow only a trusted set of variables, CONFIG_ENV_WRITEABLE_LIST
> is configured to that set.
[...]
