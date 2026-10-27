Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18903606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gZVT7vpR;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HpmhOOII
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6811440583;
	Tue, 27 Oct 2026 06:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhQftuHO2_nc; Tue, 27 Oct 2026 06:48:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86B464057E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083708;
	b=YMubueuItS9z0UpuOHT6STnstbef1Is/LvuGU0Kr6rhY2jmXJSo8UawV6vw2GMYrrN1s
	 DT+8aoE+SEj4/2WsgbOARKxefVTvd4U6VtcRwu5wbYtfowlnbHl4axdn56DckT8TD1F4b
	 F1HWbNGplRGukyr6dX0AuYY3jKBrKGziJYXQL+Y5bxqGHQWENsryzlU2kDVbHyjfPi/wE
	 irI586KHu6gA2veee7ZztUrriHNKZREaRBm8W1RLcuciDw2DbRqk460H1CBJ7FTrl1hWX
	 GKRZtuZxMkKGa9OWgbZnpS1DOjkpV/rhECy6/EVhUmru3VOfW2Qj7QQPuLt69hmyBpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J4cG/fjCQLI6WGK5vJH0aJfSpiFkLvjf0i7Uo3gVftM=;
	b=PXQIkQWACZFvGYRSJOMfBqc0NlIiWYexToLK815D35pF7vh0phQJPEtKqdgNCE1HCdxC
	 7Q2l/M1l5ass2r3zF24GWne4UNrynB3HhUtFltGllJGwEeQrH85Wx5d0ccrJa4xZUB17r
	 4vOb76TKx0KASMHn2TcIX45e7uIC5Wv/x6K9aZfRvQUPIa2N6/3EP/z8N9kUVUrwpWMs0
	 1f1UUEnpSKxm6Z8NCFqnavBO6UnMDBYpmPLta7cYOJ+8wNS6wf6v0/eIRaRXFf8zhGvy0
	 gFb+NP9UIsG8943jF04q2zm+uM25gqz1lfFRefrF1jQ05AqewcfK4u5NRv13CqsqJTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HpmhOOII;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793083708;
	bh=J4cG/fjCQLI6WGK5vJH0aJfSpiFkLvjf0i7Uo3gVftM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZVT7vpRkEmnUhR3bU905KN7GN1VIjOWiEKz73731zj2Jy0lFzxJKn2WHsvmufICt
	 pvNFbiSVssv1YAnJa89hAuXEHd3basLQ/B2qceBghQuL2R0QRglMnfsvyVXU90X9nk
	 3DUE+8JZMJjMBZ9jqsyrOI6Ga18tOSbAla2vpIi5GOGorX0SdFu7lLdVGZ4BgQ6k7K
	 6W1msis216WyZM+Xl2/Kz5+IHfbRb9bR/z6IRJmrnH6oPeEjObbsl6NIQXdeckR657
	 lkIBajRR2+jkHRPKr4cF5Xpx1e1hKCWA11clTpdAMHL+Fkh8f8QHQPEH9fhEbM2CEB
	 DdYGZJx3nZqAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86B464057E;
	Tue, 27 Oct 2026 06:48:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 52D0D120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 446F04057E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJBU2MOcQt7k for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 06:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B17554057D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083706;
 b=eEyBgNZcJq6y63T1v3/y0p0FD+v5ll0QI6IwvNpSNXZLt7+T3UGRBCU71HnULkuXdRyW
 /S1epo1K1GhbExdvW7sYD3rpN3w8K38OxucXp9QxGPvcDS/Z7Wm7b6urp135q9PaCKUSd
 ik+/J9YeJ38TPkCOiwgfWaQYnV+GRXKU5O0qmsh8mTnvfIf3Ea2WaDvVFFsIlvYjHi3xd
 gjE6olskyCSpZsBJlGMlufVnWS3YQarrkOcM6hO5IgHVi26wKVo1Z3n+WvR1MF55+pB8V
 eYs2mZTksNuR2pPsKNW5bG1dCcOasugsadb2FbzCbatPlfnKQvIz6gAd+098Icd3cjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083706;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=J4cG/fjCQLI6WGK5vJH0aJfSpiFkLvjf0i7Uo3gVftM=;
 b=dtGPfoFWoC9jdJI2R+pH88wE9i76t/0mg7vb6Vyxe+O7e9TObnA0lGytCueL0F4w5adI
 nJw9M/DImw1nduYJaKI1qdOxTHArK0ruy4bWhU8t3UlFkfTP6f/BKz/pHcExMhYe6LDVQ
 MWiUg1IKT4LKaBGRgleChS0O0sWN60b77GQ4DKoGd9XrP+amIt2HD4M6Za9TO1Xea/nak
 tKWDB7g5Arnw4Y5BY/iZffckzuGA6OUMdUod2Zoc7nF2v8nqSnojr25AwlQQa51Xb2d0P
 DxBiUNSeS3nYoFZMcoLA1+/jrEy+QmwamnNWHtqPA2VLkfAsxXW3qe5wydeTtuK1uag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=HpmhOOII; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=HpmhOOII
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B17554057D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:48:25 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jDLfr6nTHzKn9c;
 Tue, 27 Oct 2026 07:48:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793083700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4cG/fjCQLI6WGK5vJH0aJfSpiFkLvjf0i7Uo3gVftM=;
 b=HpmhOOIIiUk2jC+UIkMkCock1BhCUxjb5/cE+4cH/qbbipr3cc0R6iyb0+W3X+FWyS0MxI
 KEVMpv/l2UM0oC1q9uggr2O5azkMBe4lh3reyoksnESZ2DYhmqPsG2nJ7dtwN8mcTwm55z
 fyLcmx7VFV+3oLbCEDyHBEPi4I8TVVElP4x83VLv4TkCcfJqud43OV0b0u5fuUIQF0X8cO
 V/XYJlgqkcueCDyeL8qTpootgD5uwobhc0fiEuLMom2osO3KuwPitLK+NPNXZ6iBluKT5z
 uXglY68aTA+gqmnsIt8XSIY3VLzjDX/t2XZ++NWf/PMQnlkGxQKWmGVd7x1cag==
Message-ID: <a46f0761-1493-485e-a7d6-ad0380d360eb@mailbox.org>
Date: Tue, 27 Oct 2026 03:31:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: lwip: Make timeout configurable outside of TFTP
 loop
To: James Hilliard <james.hilliard1@gmail.com>,
 "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
 <CADvTj4owSzHUg2xMqqw3uW_XFKbFXjN3bU48COrtxxgVzXaH_w@mail.gmail.com>
 <67a6e9cf-8ead-4efa-b943-68c856b307f4@mailbox.org>
 <CADvTj4r_aOjNN3a_Eyp=6T8DU0hL8baTrJaMQKV9vkADfHow_A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CADvTj4r_aOjNN3a_Eyp=6T8DU0hL8baTrJaMQKV9vkADfHow_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 47de7097ed68597a264
X-MBO-RS-META: 5a6k3bncz6bprhnwezxjqc7jeeqfxzg6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 2:23 AM, James Hilliard wrote:
> On Mon, Oct 26, 2026 at 6:47 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 10/27/26 12:59 AM, James Hilliard wrote:
>>> On Mon, Oct 26, 2026 at 3:28 PM Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> Make timeout configurable outside of the TFTP loop invocation, and store
>>>> the timeout in TFTP context. This is a preparatory patch for porting of
>>>> the DFU TFTP to LwIP, which requires a different timeout than the LwIP
>>>> default one.
>>>
>>> There seems to be substantial overlap between this series and one I
>>> recently sent, maybe take a look?:
>>> https://lore.kernel.org/all/20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com/
>> That seems to be quite intrusive, is all that necessary to get the DFU
>> TFTP working with LWIP ?
> 
> This is more just a bunch of general TFTP LWIP fixes, it's not exactly DFU
> specific, although I think a number of the issues had DFU implications.
> 
>> Also, are all the LWIP changes being upstreamed back into LWIP or are we
>> starting to grow U-Boot specific LWIP fork that would be hard to sync
>> back with upstream LWIP ?
> 
> I think I had posted a few upstream a while back but don't think I really
> got any response, is LWIP upstream not particularly active?

+CC Simon
