Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3493606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XBrNYAvY;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=SwLD3Nfp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCF9B81187;
	Tue, 20 Oct 2026 10:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G421eVIZ-x_V; Tue, 20 Oct 2026 10:22:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E0A9C810F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491759;
	b=gbQMgszWrZOEoZHDlyTWhl7f/c5beyL4LOvD6CZNRFwjS5lAhxlPPl7QzQjsL+L46hEu
	 HDOWLSawk5CUXycm89Nxh48/L6R2sIlLlQSL8xooQtmscWrJRRHdP+Yde21OxR3I0ZBz0
	 5PjCSHVITHUksB8xXztCglP7M05DjAMGgARC5Kw0Q+NKha+6E7RLOa9lZdT2Au6Zt8gGh
	 dhcemQcPKzS6ura79VmxcruZApIaxBbl6SUwv0pm3aRqklLOKkkhq1ZnilP3LYAYzPNmC
	 5FtjMpNgNp1b4I7nV/RSkvd7R+eRn4W58w7C/Oh4oH+EU80rRL7M8j9PrIG6A0Exl8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OkqiguWdjaIXP3CQ1TgF7ndAe7UB0MBwAWhQ68VUQBk=;
	b=cSkKQnIDh1XPVmhdOmqOfIDmOHGRPhynmQQzf1rLTZCk04LdRJoe/i4HkXa2Z/Y3NIlv
	 cUTp5dht7XrQFSJ2cXKtzYspOSLThxjILtPyGu3CiqW48/fSOSNV6ub2k3/TkmSs5Qyov
	 mNwM9+IMMXMhNRxkOiqOD6o54PwM1U+q7+eehrI4vEfHK6Svj4n3twpvsy/3WL3Uz5IxA
	 ms1QK5qSQChHRjbQ4ToEQs6cjjRxOTj31rsZEuPuWvia/uJi15H9ArPGqPhlr7GMcVTMD
	 vziUxSUXAduiYvSmIWsN+9Q+5LtnJU+EJEUD3KAp/U3kmPLqknWCO+8JEQbFB/hyd4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491759;
	bh=OkqiguWdjaIXP3CQ1TgF7ndAe7UB0MBwAWhQ68VUQBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBrNYAvYshU09eC4MqiDKMSMdQmyHhYqZvwhpcyBCRQf09pF9JlKzQC0Q8LFzjQtv
	 ePpjKCBYD83mNCF1T4qQeuucgaTnQVMPxh8PEprJ1w64fn0aVbOJ7z582WOtLNi2VC
	 bYybfNrjcILmnCjuKa09xJ11a0Xmh3MW06404vq3xRxrR5Q4YGYzI5zOgd7mId+nLk
	 Ed2Keuofnh8aK6kV1Sa+9VyqNT4Se2/Dok8Oe1OKkAJDSP5GPZL2lsDzWs0mYdvLqb
	 uMZJPGm6QDvak8H6vfSXlnZSo5K3mX8GPmaeOnSYjB/GfbEgMVf0NNpeZjBxja70tj
	 Njx2kX1OLYOFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0A9C810F8;
	Tue, 20 Oct 2026 10:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF0451E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A50554016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3j1IUvZ5ijfq for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8C9B1400FC
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491757;
 b=CkiosCxVp5mw0PhAjlvsnTVt1sxXBvkdfHAB8Ko4Hr6j7u/0qJqtRfqvfNN1lkBlsDw9
 /8XnvbkWBKvZymla4aQ0GwVAkPooZ7MZtR00fRo+0ZislLHLXsSbUP2yM4QHYVpUUzetM
 R2YaaUNMBJT4NVwZtrjbj0xS1RnOGpJwBz1IZSbMJBjKiL03NxpW4LDWe+e2wAT6VYgR2
 vFHyWFq8XJMZBhL43gPInJV8DckORXcr30fgW6fRmpcArkb7o797ZGypMmejqEUUaQ5L+
 uyaD2A8X58NEAgOQvAX2sjrkaRIITtkD9ZJtrYF71aU9HS9JKuCvITSzgC7tmAOyqOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491757;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=OkqiguWdjaIXP3CQ1TgF7ndAe7UB0MBwAWhQ68VUQBk=;
 b=FTrik6A6dXKNYbwI7AB7rsirWx4pJDbHFXP3sqRXCrxeEV3arcrrNevg5PdVDB4OmVv1
 xnYsJbDi2I3Q12G50Ytr8IUTS8BCqmnxvrrA3AABsOo37pfiIYraQWt7mBZE/oQnUYFus
 HqN6Dh6RN5kDK+rZTc8LxQbhylXw7M3oGNNx101UOHosyvei2zrCskf3dUUlWO1m88J5Q
 p8oWKYdaFobQjaKbKqX+wbEZwgwEcG9w+Nz9XOzP1kkQCzEmNGAwUMLSLqR52bt2iH4hv
 9rDYobYJPD56IhKwQvQPldNzc0WnpFJ0pzFrotrENl0jfpEDsg2TEwpqHEq3ZRoTR4w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=SwLD3Nfp; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=SwLD3Nfp
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C9B1400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:22:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C456C108937; Tue, 20 Oct 2026 12:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792491749;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=OkqiguWdjaIXP3CQ1TgF7ndAe7UB0MBwAWhQ68VUQBk=;
 b=SwLD3Nfp3kjeQUB+9ksRQZ8b29DNUJwSlMXrQmZPfAIcWFgrfWYMc4oWdm7Nd8qzD/G6k9
 Px8+eItXTFfDnuc9CvZfYk6cf644ejONRnd1wOB6tQgYorl+VBcUoo5PUal2XzzI0Fehis
 +x1ZXwxYhjr5AomuDQsSJvmd1bsqOQI/UOjueqf6Hz+N1JCjfwenK8i0zyjMyN8/8JaVp/
 /uPlqCQ82tr6wBJ3kRA+gp1CdzyVHVoLtYs3i7YsNbQHnnpkk/wUhUU503JgWT7sM93okf
 +Xf3lTtGftxZj6lLfoNJcvl30cgiInT0GkJriiocbKKXMdmDghSwhQxS2MUBfw==
Message-ID: <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
Date: Tue, 20 Oct 2026 12:22:28 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Richard Weinberger <richard@sigma-star.at>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:51 AM, Richard Weinberger wrote:
> On Dienstag, 20. Oktober 2026 11:21 Fiona Klute wrote:
>> CONFIG_ENV_WRITEABLE_LIST only restricts loading stored environment,
>> not runtime modification e.g. using "env set", while the Kconfig
>> description implied otherwise. Describe the actual behavior, and add a
>> note in the documentation.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>>   doc/develop/environment.rst | 7 +++++++
>>   env/Kconfig                 | 5 +++--
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
>> index a7ed4aab0a5..e7cf6de3586 100644
>> --- a/doc/develop/environment.rst
>> +++ b/doc/develop/environment.rst
>> @@ -89,3 +89,10 @@ an association in the static list.
>>   If CONFIG_REGEX is defined, the variable name is evaluated as a regular
>>   expression. This allows multiple variables to define the same flags without
>>   explicitly listing them all.
>> +
>> +If CONFIG_ENV_WRITEABLE_LIST is defined, only environment variables
>> +which explicitly set the 'w' writeable flag can be written from stored
>> +environment. It restricts only environment loading, not runtime
>> +modification using "env set", etc. Non-writable variables can still be
>> +written to stored environment by external tools (e.g. ``fw_setenv``
>> +from a running OS), but will be ignored when loading the environment.
>> diff --git a/env/Kconfig b/env/Kconfig
>> index c6df09a3349..70f6cca701c 100644
>> --- a/env/Kconfig
>> +++ b/env/Kconfig
>> @@ -897,8 +897,9 @@ config ENV_WRITEABLE_LIST
>>   	select ENV_APPEND
>>   	help
>>   	  If defined, only environment variables which explicitly set the 'w'
>> -	  writeable flag can be written and modified at runtime. No variables
>> -	  can be otherwise created, written or imported into the environment.
>> +	  writeable flag can be written from stored environment. This
>> +	  restricts only environment loading, not runtime modification using
>> +	  "env set", etc.
> 
> Wow, just wow.
> I always assumed that the protection applies also to "env import ..." too
> since the documentation explicitly said "written or imported into the environment".
> 
> Instead of fixing the documentation, are we sure that this isn't a serve (security)
> bug which needs addressing?
If the attacker has access to U-Boot shell, then they have unrestricted 
access to the system and it is over (the attacker can e.g. modify memory 
which can be used to circumvent other protections). For the writeable 
list to have any meaningful effect, U-Boot shell access must be disabled 
(e.g. bootdelay set to -2 or similar). The writeable list protects 
U-Boot from importing undesired data from the external environment.
