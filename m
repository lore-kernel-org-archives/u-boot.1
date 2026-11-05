Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F4606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PXV1QgJI;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RcnmLugb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C4456084E;
	Thu,  5 Nov 2026 09:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTnTJeVFKb_f; Thu,  5 Nov 2026 09:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D8B3607D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793869826;
	b=bZdBS6Tn3xSnc+2fPr0prOJLb66B/yE8UvO0DHbbyIA09gwHAB2lrsYZZxvv4ev/58kV
	 lZCxavWkfjOHq6YCiwons8urWSYbd61Zp72pMYcqwxchTOEeBPCDKdl+X5dU7cFq6gLlo
	 YZvzED2bDLw9sO7IR3nYmWEoyiGikj8vgiajehAvRhmHeMp4CXNUuSp2CbrD5XLeUC+Uu
	 AOHeKNXYLgmgyN4WfxnKq8k2IADivyiI92GJ3wUifVIhy5SOX5enKqWRQyby2j1EumAC2
	 KZCR+mcC7JjQKVOy08znjip0i5tZqOQDm2OCaKjtyAHZ1ep3kJu1PPm1dOoJ/7RH5VA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793869826;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lL/eQGdV4q13ggbMyWchIsRvJuW+baOsPp0gdnHuQW4=;
	b=P3oLOvw3VTcY9JV7ctBsiEPLsy342ZLzPoB9iMh20SDkvGM68IiIMXXWvBWqcWBSV4Ko
	 cskC2UzUL043QcbiHPN7HrDMcvpGHyXr8G+L/lGwWjrl2Hqy/4kL412aFLy04vY7JlTn6
	 n9U2HAUTskGaulejCJlcwd4NCWxb9f+f/ETr7jgKLDHQsW0Sgb3RK4laL8//ReMS2sYm8
	 FFA516j9Mjvzp82b6QMSPzkOkzcaWPi1shbDFzHhVBQpLYQzFnDKd+Om9l11Y6omaJxGV
	 +sbVift9GY66MSxhbRmTgY+C/HeI6izF+l+DydkO53ZOAqhPNfjDeJ5Kg6Vy4AXUf0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793869826;
	bh=lL/eQGdV4q13ggbMyWchIsRvJuW+baOsPp0gdnHuQW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PXV1QgJIn3hh/d3AumYoKQ/gGIAV/BCrfu69lzGpcoBYXJanieiDVVCgryDWwgdfT
	 FonjHkv44VrgGsDuiF4GcwMHAH+z8GcTrC0aAajkKiM18LYh9K2SxkuXB8cRawJ4Jl
	 rKm75ip4JCjGvf7nIgwseC3trzHhEBy0QcajDU1GUTRxCLQ4ZofFwaIKLGbfA/qXWH
	 WbWMA2LfYNwe2Deyu4baLP5J+YkX774TCgK0kH1tF3vLjhsXFFXo72PsJaFD3U2KVy
	 5J6ydpA47ahA6tiug505SIfk7V/XobM/k1ztBpdTYwi7zvA2Y1hvxHzADYgqQbqsb4
	 QYBh++i5ixGvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D8B3607D5;
	Thu,  5 Nov 2026 09:10:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A49A31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E40A4810F1
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVr7qDDI7bk0 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EA78810EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RcnmLugb
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EA78810EC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:10:21 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1085154f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 01:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793869819; x=1794474619;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lL/eQGdV4q13ggbMyWchIsRvJuW+baOsPp0gdnHuQW4=;
 b=RcnmLugbniFBNc3Plu3cs718rsGsMtns5q00kBhK22C/Z3gSIxZRkcP2Yxh/2uA/+s
 utnmcoFndr6IF3r2qd0bAwFNLh4oY3oNjr2sraqXJvri9SdfyOwrS0b/uX6FT2pOdzVt
 PrrE+fJsBp8u3umsqd1wxYogjDAMPC0HJt+NFUOuZm9J27A0LurCM3hfL/ThMvqHumh8
 5L7Jr/RIFdhh5/JLzstP2ctM5v59+fnmtfEtx+xBNE7b9EgdCkvkafnvACc45PxB6xnx
 CpVUbSSS/DMAkMmAjq3wqeVhwyoL+12iWUGUkZsv124o1CT0RRHghnpLllj43BlMFl96
 VOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869819; x=1794474619;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lL/eQGdV4q13ggbMyWchIsRvJuW+baOsPp0gdnHuQW4=;
 b=V6OOVcbwo9jqC/kDO4Zu4XDA52h4HZTTTmN43Uu6f4VdPZM1WKWo+IZnZKgMcze9EZ
 f1KC9ucSsQIxD8yQypY0jcEcYL535b8v44fwShtmDbJJSUJ+grDKZ+KoK5dOk5iowoa9
 3XEmLPrJE4YU/FAneevEkd4fCYq7daH+9+Sfcv9dDgXHJcy4MC/BJD019YxG/A+ekJVU
 WgtmB5HmLtvaAjROyLZ8gqgSoQ0V+WBZQvHsGJAS8otttbU3HdPK23y/IDOQ878g3TEa
 Sr+pMtHBRmGNXKNOrI8TaIp53MOVniNwBQWQCfvqkZmU3xe0xRqxFHFKpK4BDKNGUTjm
 IRdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkDNRP8qYTofEZSlWPUcpeVpyYHl9eeP/MTBkzPuLOH+XFqkk7d8LrPzFrTqe2GLCSPt0/At4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/qcG7wf6UfvhYTXqCbln3OB4wkon8R1ei1tncYzYrulse57Bzk
 XUZULlgj56Ybb5HY5D6lIxm7IRTkcUbeMYqmjklCb1RVPcrCSmAO0Z9CA9UmdatprbI=
X-Gm-Gg: AYBFou2ovNUr4zwmle8XVbPZOUfnlhfFmfdcnAFxXjBWsq6YhTU/YYEx7rqvRH5oNOP
 3iMbjXcGbwOK52J27LQhndlVjJ6/zioL5e+66BMjKYbrlQtxG1gO33aQAfh7zuJlzMqQmnzEuep
 4/tr2nQkDBSE2AZE8nc6hgnHFCCdXvSCO4KIryQgQ/PpnHeyi8NmU1sJ9pvcj2aiANrg+qxPdeX
 Z7eZABSy8Z26Z2SA1OCPWEjx5swSBJrNPNb4Qe61K1B1Isl5x2xU60z7yX9kjUt5W/1b9YeDPU+
 9CeztUoO0ljL/BhJ+JeB6hFIJEjHMhPNyswjKxL1ifQQGjaq43g9AIxgOeyNCh7l2j9ABXjcFM6
 q6YCHqc9MqEi+lqxIol3L658Tm8C85tOANEDZ91C4rVvJGPF5JvYVOKgMXMxjDtdNP/dD3xDayg
 O5PO56+SdbjcokZ/bEOgt21Bb6H7yaw/ovyV8RifkRy3bKie+Xi3saG0zAwH/IALm4RN8I2t+We
 4JGZHCe3/LPnytHz6wGsmCQHiacd8c8anLlcrDg9iJ7v/kTRm8jOvdY4LOTMfetPTJKdTYEOef9
 LioHT4TRGC5n69fqM9lE2Eci3+1ch/3zAxs9G4Eg/DUL7PH49pRg8rN9
X-Received: by 2002:a05:6000:200b:b0:48f:fcac:a5e2 with SMTP id
 ffacd0b85a97d-48ffcaca675mr7978671f8f.38.1793869819236; 
 Thu, 05 Nov 2026 01:10:19 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd40csm8734958f8f.13.2026.11.05.01.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 01:10:18 -0800 (PST)
Message-ID: <a937a8b2-a7a6-4fa0-aab4-9185c17c020a@baylibre.com>
Date: Thu, 5 Nov 2026 10:10:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: renesas: gen5-cm33: Start the generic counter
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
 <81f0a82d-0678-4229-8244-c2f505c873f6@mailbox.org>
 <6d16f6c3-2bc3-482c-be82-463ebdd6b23a@baylibre.com>
 <216ea2af-4cfd-4cae-aadf-358ad4133071@mailbox.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <216ea2af-4cfd-4cae-aadf-358ad4133071@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

>>>> Changes in v2:
>>>> - Explain in the commit message why the RSIP-M U-Boot starts the counter
>>>>     and the CONFIG_SYS_CLK_FREQ change
>>>> - Drop the Assisted-by trailer
>>> Is this patch no longer generated by AI ?
>>
>> Tom told me that it is discouraged to use AI + it breaks checkpatch:
>> https://lore.kernel.org/u-boot/20261026210850.GK646438@bill-the-cat/
>> Indeed I could have mention it and sharing this link.
> Is this still generated code ?

Yes, the code is unchanged since v1. I wrote it with the assistance of my LLM.
I dropped the trailer after Tom's comment on my env erase series [1].
I reviewed and tested it on the board, and I take responsibility for it.

Best regards,
Clément
