Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE173606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iYlFup4n;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=EJfUAlQ4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A1A7406A1;
	Sat, 24 Oct 2026 21:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wqENE3x7PlKQ; Sat, 24 Oct 2026 21:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3511406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792877276;
	b=jBAMjGEIdcAEY8vALdUs/gZ5PdmXMtI1ee42bmg66B4ikhEOclAi+rAOKndV4U5bpe/g
	 hWbVlyDru6mIocdKS2McfpFwgxeLZ/SySN/2ebrxDxNRAB/xFB09BlXRUSMtx2RqP1b+n
	 JyXB6QhgWZKQHbKzrplXIWi7mIGCXlGknFEV7btRx3ljrafwJPXpmzyq4uNSR9ecvEKYx
	 kbR7u6qFfVjiDSljM1xtVGVA8HLE1MiPW1zS1c/hutMdutkdJ/bEZJd6eMOLrXQPf5wr+
	 CVn0VJW/NFOzw/1g+kwBFjrLZYXiXonfWC2r8o3+ithf+a5JoYAIYUFK/DLLRw+fkjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792877276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+rUkW3yXMgAi4HUlWPL8kJLb0DASn4VImjISlkgWZlg=;
	b=XNbMPMRV5Lkx+Oyli6j1tbS6Z3mFkg+CTlTF5SUY/uOokg3IcM+7SDI4Ze3vWGERa6rO
	 l+H/eboLAD78A0kI3YvtEae9Jrt15qKypax5Ns39XrMls1HwwrhZGZQX+zbokpDLnxfok
	 1P3Wter5a8WyNaqyjq3exn6urPKAZMH/veDWqR4JqodAA4qfudF05F8549Ckvg5SKFEsI
	 lfur7EoRetAjbdYRIQ7v6csyDfiJX/hmTTd4CxtJ+/6pYHUvduusYrVKEw9EwQ7BPPjG0
	 TYUPKWO99RYNYDyB3bqepZE6uHPH2ytkGTx4aMTgAidl0g0WPh12ZP0bjVZdUWCimFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=EJfUAlQ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792877276;
	bh=+rUkW3yXMgAi4HUlWPL8kJLb0DASn4VImjISlkgWZlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYlFup4nchFFlG/Nc8tha5F+axo6KG3rsV7bu+F9t/kU5tGMEYGVa7NPWa9HvKQEC
	 O/NRz76x4OrR7KTZ55fcE7NQuMC2gYNjURJOnIq0sSq4su/i4ISK2PZZPAhSBfT7cV
	 ArVm2E893nvopSqgSBFVPKkJndzAfjpzzbSCFz7+HuXxEVE7n7beripKv/EhAWy42y
	 A8rJ4yF7Uzcv2HfZHdhyrcPwhRwY1CWrHzJ9nbLFWMLX1oxczwwkU3Eys/pCFLlamZ
	 Pf1gDnKpXRiE5HaCq3L/u+ti18q77FcN1dhE9JVdAgO66/PwFUPz43Umqq2bnJogeb
	 ycHxYxlJ8jTSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3511406A0;
	Sat, 24 Oct 2026 21:27:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D78043
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 21:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A8584069A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 21:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaq2cTp07q_S for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 21:27:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AA084056C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792877274;
 b=W9hHz7Lf1swxtvi1gqVMD4nNzqwmlYU4CMb501aDYVX7qiF8Cj/ei0fyJV7Tzt7ssjld
 Z9l1dDdGGM8evKlziN1rEaTzf26InaRC6H4VkcPdcmyK1PyS5shce4jSmhYutPjX/syiN
 PyO0Rm079FwBEBEqi0rARchUQ55EmB52yrWSw9kW46bP9dTqTZaV2PT3ZgLQt15Kz3oGd
 bG6eKGOA2ZaLu0v5yrg8FLf0FQIDS5KrSUcKsIbFQUVDCFojhPXQkS7pbsCsxLopSXNjv
 0aG1vE02ek4fJfN2noDLS3t98ws9vyRd3dHIfORbWRN06n28SIrIJSRAgK/MscxuDQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792877274;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=+rUkW3yXMgAi4HUlWPL8kJLb0DASn4VImjISlkgWZlg=;
 b=pIKb2GTElufsaMTSRiiaN4+CEUnDJSCI53tqfH4K6mLXqn9eVOj3djMMBqesDfIPgAa1
 qBrg8on913ctKBXApyUuqRakWse0iJmHvxsq0CBryuSd8HiMCc0Jgie9eAzCPuWi5lT13
 CuaDw1dVuniQ3/89yjxnG0Ooxo+mgugOFRJ5PNZ0jhaTTF3QqgWB77kGOKWUIUutxwEQX
 XSey+YheStSUbgDhosdDG1eyGZcSlPFagupo6nfhfVwgGJhLqbx/fQjzuEz+Zk3eWy9Xh
 75t0mZjdECEqMxxiHnv43sm/P69YE/PC6B2ZZMq/CNaVp2j4qSv4H/WqZsFnnT2+29A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=EJfUAlQ4; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=EJfUAlQ4
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AA084056C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 21:27:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 89D2210B0BA; Sat, 24 Oct 2026 23:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792877268;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+rUkW3yXMgAi4HUlWPL8kJLb0DASn4VImjISlkgWZlg=;
 b=EJfUAlQ4GfbaYPXuwbvnFebsSu1yxEV85dup1BfkuS0bssNYohnn+EGYmf1J3ZGNog7fc6
 WDaxVLNe9T5IDp4Vx4+qw36oHlmkIMwhJjSBYDwGNTzWig5+L4oZsxorVo1r2zGqDtZD5c
 1Ya012Ue3qzKEs0OZQ6stviR7j1O9/q/mFNn64OzLcWfTWlAF8L97+FM7T43dgkXelA3t/
 l1lRkKmHB0RXIl4V9KrK7IOF3e7Hp9DffzwzFTGug+ZYPnUeCRmLoNp/commaDmywHNCOa
 YDkQq7ZmMeYfPaCassHLLX88G2XWibVyuPHAvF4yCM6XOjduxEG8Fn4ju3DQeg==
Message-ID: <120d8b95-ed6b-41e8-802c-bfcc11962105@nabladev.com>
Date: Sat, 24 Oct 2026 23:27:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Alexander Koch <akoch@initse.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R <vigneshr@ti.com>
References: <20260611224544.210172-1-marex@nabladev.com>
 <20261024142353.GA29423@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261024142353.GA29423@bill-the-cat>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 4:23 PM, Tom Rini wrote:

Hello Tom,

>> From: Alexander Koch <akoch@initse.com>
>>
>> Indent SF: just like other boot time messages. Change the original indent:
>>
>> "
>> DRAM:  3.5 GiB
>> Core:  310 devices, 34 uclasses, devicetree: separate
>> SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>> "
>>
>> to the fixed indent:
>>
>> "
>> DRAM:  3.5 GiB
>> Core:  310 devices, 34 uclasses, devicetree: separate
>> SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>>      ^^^
>> "
>>
>> No functional change.
>>
>> Signed-off-by: Alexander Koch <akoch@initse.com>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>> Cc: Alexander Koch <akoch@initse.com>
>> Cc: David Lechner <dlechner@baylibre.com>
>> Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Cc: u-boot@lists.denx.de
>> ---
> 
> Sorry for the delay on this patch. It breaks the tests which expect the
> current spacing:
> https://git.u-boot-project.org/u-boot/u-boot/-/jobs/124896#L292
I've sent V2 now with that fixed.
