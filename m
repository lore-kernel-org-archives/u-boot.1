Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE788606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GJROGQEP;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=b+oZxw6I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64491402D4;
	Sat, 31 Oct 2026 13:38:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZosivbKpS2X; Sat, 31 Oct 2026 13:38:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4C77406E1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793453881;
	b=JQJYG+m9wf5URHt6w+lZt5A27FKARFZJ2Cg1/Qsz2XCfBGM/9Z7zYrCtfWYJhzaVfjLA
	 eXX5Yz2R/jHfTvcv+e8hGLIHDn+OXM9v6QoD2K5LNcgUMS+MvOos0xjLJ5mP2mTxcjI6a
	 +0e/h9QErvp1E8DQekLs01Mr81YiaHbFr2sB+Czulo6Nmsx8Y7m0+es/0XkIngIvZG+qU
	 QFSrtSxrKVBishivPqpBRz0m9DFz/iYNkmKxmPeNOSR9J85AjYnyCPnelQB5a5y1vMl4b
	 DKQqVVL8B6jG+OOAokG+0atJSkYonb6RN0ju6yKCbB1A8vkBzzgSlwtRPzUNuN72Evw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793453881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0wRKm1MpuOfUl1e1GtMIJvbSNy/pbjb8OzJEk9VVOF8=;
	b=qyIGBkzjuZReXrul+J1d4hyR7+fdf/XbBtj2GqBFnNjwIpTOGhuuTrWDySFM5ntoZ83V
	 Gc4XffNfVd5aZLotU5jdSYK4BbLR62cELwaknX3gbwPNtnKTOjJfMnCfdhsMqgxblS1L4
	 93MWlvRPtqVy2/NOpF6vkiLF5RhCyPphgOEaZwhzsOydcsbEvwFXPr2UG+cWW21ESVjH7
	 C/qZPWzdBQ3KqhDxQIm1I59nxniFXigElA89UAfZk8RkIp6LlJydSR4VcmGD2ofFeAWRN
	 LPNkPkSNCICqFsMgDs4ED0twVU2YDOOUlmpJ/gw6OxdL7RjQzHPtj7AYLN8L1+xfLaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=b+oZxw6I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793453881;
	bh=0wRKm1MpuOfUl1e1GtMIJvbSNy/pbjb8OzJEk9VVOF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJROGQEPvz3aEaKxjZdH8Z3W8aFjUWp26nwsddcJ6UCm77qI/72IN/nNmU38M3VW0
	 bZQ+VluLQIZ7gSS6PLvMKXa8Q7RtjHtWmWD+0vw3ye2ltDHEHYHShJAxvlQC4T8X7d
	 ZHhzXuac8lxneezBxuXxmog0tfz7VzA2oyAy7FfOfK8lM+DL3V25W7Jj1Rf394ag/O
	 q16lAa0vIJ+C4XLXSLLp5HXMNTZOT/fQp1IyYsLK2w0w/RbMS9FPTzaC76eSEQeIBJ
	 /KzgWTFQsNTQIVBgj0lyMqn/CbTRPsHZ7ahue1G7GqKMEdI97dVEFBzRDRinLj+0g2
	 QRhPD1VTy/9Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4C77406E1;
	Sat, 31 Oct 2026 13:38:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC7AB4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 13:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2C26406E1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 13:38:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qy5b5bif3y_I for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 13:38:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3519402D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793453880;
 b=jvcKqVGEkkiJtKPHr5dS+v+xyjxjGRP2niVMvw6iFRbMuwavSp/Zd0cozwvbS4vbvCiY
 AbaZy8U5/qzRUIflfSvSO3l9/erpeN00bRuD8e8XjjP9w4Q4YGb7uKix7DDyx3HQAnIFO
 sTKKsnVhxVA07JjtKWvkg+FYg7lNeWXWJWPqtMWUg8njVgzqV+BR+dkp8jdTu4DQ2J60v
 /cNYymeW9qzm5HDboEyvT0fnIAMYj3qsc/Iy994j4ACvNvZ+oCJgpzqNtcnE5fzynpdTW
 eHymTO17VoTUkviX18f2OkGKavxMJ8CIBDet5uCXKYxBKiYB2jmuiotBe6l4Rsd9AMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793453880;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=0wRKm1MpuOfUl1e1GtMIJvbSNy/pbjb8OzJEk9VVOF8=;
 b=ZP7M6ltSsHWIsvu9NqJ3DmdQhqUjYO05/OV1rl6/4ennC6j0oxGLACnykNWgut8ck8ib
 fh1e6KtXQ0QujB8MbeutdpLhyWzQhpA9CyRYlCas6Cj1tZWBWz9SIYGKBys8ISTz7Hslt
 C6eB1qi6oA3mYpnBj9oex1M++bWNMacmeq/l81gcg5wtraRo2M3ekcpjffBe6Sv2yikPe
 B0+h4o5NnkW8aN5/vFmi09NCYOgaawj3EwgWM/qbJGFC/oLnRlnLbuuEBCnZPtCW2qTG0
 8IlWly0gLNzBhyaTkiTjeES9z76kdOZ/TJIfs8zFswGZqmtSWGXw0x1XliG32zQlCZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=b+oZxw6I; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=b+oZxw6I
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3519402D4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 13:37:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 51DD510C1F1; Sat, 31 Oct 2026 14:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793453873;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=0wRKm1MpuOfUl1e1GtMIJvbSNy/pbjb8OzJEk9VVOF8=;
 b=b+oZxw6I9zpimDGZx3SV0BffNnjHggW2dPAGZI5s9ySK5F59tNO2/T5QiPF164IDwd1b5R
 5KgdlAPm+WUZ0Z//1ylSbdyrd8FWZ16EFlco5FE7YsSGHelc4AKTQfsA6nSEtZEdyIwQYh
 wmYr5HH5MSH2HEZu2x/zb0DI8ONUI4TOnyRSjYl5UA7GB2OvbrGPWC8vmoVZJ/mNyoY+0o
 bqzwMzjs2lR1QzB1ZSmW0V1oyUZaG9YsjMarZMqDblYjVgfN2/83LE4TSkWHssaSj431aj
 mus0uLjSXmv6pKHa1/80eD9ZNRvb4UdgNLdKEyAClhWKCRL7d/C7U6Q9ub/Zdg==
Message-ID: <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
Date: Sat, 31 Oct 2026 07:38:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: Tom Rini <trini@konsulko.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>, 
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
 <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
 <20261016000442.GG259661@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261016000442.GG259661@bill-the-cat>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/26 2:04 AM, Tom Rini wrote:
> On Thu, Oct 15, 2026 at 11:17:28PM +0200, Marek Vasut wrote:
>> On 10/12/26 12:31 AM, Tom Rini wrote:
>>
>> [...]
>>
>>>>> I believe the answer there is that we have flags to handle this problem
>>>>> generically rather than hard-coding a call in every arch's
>>>>> boot_prep_linux or similar like we had to with the old USB gadget stack.
>>>> This is shutting down host, not gadget. And I believe usb_stop() is
>>>> necessary to correctly shut down the devices on the USB bus, while the
>>>> DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so both
>>>> are needed.
>>>
>>> Host or gadget isn't the point here, it's that we used to hard-code the
>>> stop function call for the non-DM driver and now we have driver model
>>> and flags. Everything should be able to properly unwind with flags being
>>> set.
>> So what needs to be tested is whether the flags are enough to properly stop
>> devices downstream of the controller, or whether we need something more,
>> possibly equivalent of "usb stop" in the USB uclass pre_remove callback or
>> some such thing.
> 
> What more testing do we need at this point to see what
> DM-related-unwinding that usb_stop does that isn't also covered by
> adding this flag to the controllers that are missing it?
Plug two or more hubs into each other and then into the controller, then 
connect at least one USB stick into each hub, start booting and see if 
those devices get removed in the correct order (stick furthest from the 
controller first, nearest stick one before last, controller last). This 
is my concern here.
