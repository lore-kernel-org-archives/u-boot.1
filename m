Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0272C606B661
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ksxMNfv1;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=V9L0F5tO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE31B4098B;
	Fri, 13 Nov 2026 06:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEriupxf2lsX; Fri, 13 Nov 2026 06:44:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E7741409C6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794552258;
	b=MAJ0h3FFz7IHWnLW5Jpe2zZIYDEAEc9xzyHd26/OXOYL8K43CjDhUx2reSOQaeSbmjEB
	 FwQ+vFY9gp9TM0sns2T7gTn3F2Pgk5HTHSIYBOQAQkAB5vPWeWPmVO32nCCXLIWsb0OhL
	 hgjjeTrT6V3zk+fVeCvEJ4HnNfe/nVtBZuhBwMUAlNrjRPURsc4OxziSpCkyERz/p4n9K
	 CkAG4L4Xyb7NJONRkXEmXrNNzvxNBDHpzXj0VrIJB7hn7MlzJEp8zUJPJYymlMmCR0Tr3
	 /9OfxdVquabGmdC5cvFBis0YsqZq6PrGRNbGCEpmTuyYLrIukPY3Q7VRmYimQSPDAiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u6R1EcAFWE10M58f4axyvllm4yCydnul9mVM2TqlLUk=;
	b=R0n+/tOiF5AWEjEKQf6CKrE+WKW8iaYqZUKHahSU04MLiob2KksNalqI9BxRdjpKlO/T
	 pYjbA5mgnNo/l8U8cGr2AMLnB797ecTkFReFXHMhDQlthUNfXYfBTO6zGAH9iEx6KGaZZ
	 PyQsfbEXo6+zprNMA7N8ZZRF+Dh3bYOFEE2RfkBpcZWsMxGE7H3qKZ8MkSyqlDRSWqCK/
	 GgrE945LcFn0W5ryL9XCPyNc/ORoQxvPfJ5T0wez/fqF1efeyvKWaSWWK66V3apwah+nq
	 OPVihAQfxkPD8POlX2GNt2sat7eTFmXZVxMUl/3Ac7OsmghpzqCpaz383msqvYcyd6w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794552258;
	bh=u6R1EcAFWE10M58f4axyvllm4yCydnul9mVM2TqlLUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ksxMNfv1Xo5k1UTlQnDpR/MpxBEhEzsenIMvvS24vVggz3407Uj95dWadH55xaFgP
	 JyuCXXRYm0JrtvNd0t5PmdJdz3UW7eUdDJg6Pv4LrnA2JMsEj7L2AtHDOj506AFb0j
	 aCuuPhS+aA0IeSMgvYv31aO+yKb4RMfnJPAobkN+dYJ/wcmA213oDyaOj6yysPG+VW
	 Rs/8CVUHJe0s8RvmR/WORDevqkPA+lJH0oxiOi2dRFNJuSunzaqY2/5dcU/hNRXOCM
	 d4GesFF+4a68JfB4EnuJNiL9Erzm7uvCMS46gtROAZ5IDEi5tARvEH1Lqc4KNFaR2N
	 OngVzW8czB8SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7741409C6;
	Fri, 13 Nov 2026 06:44:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 532EFF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4525260ECA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ne9Zd9SqaTOg for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:44:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0057460EC0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=V9L0F5tO
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0057460EC0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:44:13 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jQnm84jqVzMlxL;
 Fri, 13 Nov 2026 07:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794552248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6R1EcAFWE10M58f4axyvllm4yCydnul9mVM2TqlLUk=;
 b=V9L0F5tOk8LVg7HQ3kuCiLbpSTpajY9ie7h6MyfzVYeIap4aIZt2K80mPopVL1pKf8md4C
 lvE+VR3MxGLzaALs5oEhQ6EjnDZgNDlKytIumW6t72Qn2EEZajUEJVNmGpmFd7pQZHTf+y
 X6R5mFSc2GZq2kO50MoHmGR2x24amdEOll9LA0zCQK5FhPGpFX8aeBaadG7C/a8PU7koKv
 mbcZaW9kMy9aq4oTOBbsviUxQBrqBNSvJdJ07QvpaLIrymAj7bZxAsHz4Dj95F+2t++I7N
 EBD0yQC+1vWHu+lW1V1lyP64n/P+C9d2YZrz/6K1I49AsOxk0qV1XOdx8RPw/g==
Message-ID: <3663501e-4f64-44a7-96ef-7d3b9faa79ee@mailbox.org>
Date: Thu, 12 Nov 2026 13:40:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@nabladev.com,
 alchark@flipper.net, jerome.forissier@arm.com, dlechner@baylibre.com,
 anshuld@ti.com, sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com, quentin.schulz@cherry.de,
 s-vadapalli@ti.com
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org> <avRoy3ghzzRPHWnu@monster>
 <b7fb9a05-6e03-4bfa-bed1-0d4319504d38@mailbox.org> <avWvDRPamFpE6Oh5@monster>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <avWvDRPamFpE6Oh5@monster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ourhn96adqxofpt8gp45yat3jcsqi8uk
X-MBO-RS-ID: ce79252dbc331f6f3f1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 1:20 PM, Anders Roxell wrote:

Hello Anders,

>>> I have v12 of part 2 ready, with the review comments you had on a
>>> few patches in v11 of part 2. Part 1 did not change. Do you want me
>>> to send v12? Or do you want to merge v11, and I send follow-up patches
>>> with the fixes once it is merged?
>>
>> I suspect this series is now v2027.04 material, since we passed -rc2 this
>> week. Please give others a bit of time to test and then do a v12 sometimes
>> next week -ish . Thank you.
> 
> A bit sad to miss v2027.01, but it makes sense.

Indeed, I was hoping to wrap this in 2027.01 too, but this is too big of 
a change.

> I will wait for more
> test results and send v12 part 2 mid next week.

Thank you.

-- 
Best regards,
Marek Vasut
