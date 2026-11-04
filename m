Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7A606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iRUB22D+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CItjcQX8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93338405F9;
	Wed,  4 Nov 2026 08:47:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AK_kMANMiYCr; Wed,  4 Nov 2026 08:47:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A889640607
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782071;
	b=CXuSyMJQa/NyXVyDlpacCmsHFWrUqd/ULSTsYxah3hhayzzgGL7haKIUhx4iONA3A/qe
	 GqZSbTAqFwmoh/2ETFoPD13AB5+wK1ftejb3P5ZiGH+PzgpZiGv49ljTPNL6S/QITK+ok
	 LKbvzCSLhF3kPm5LR6/1XeHhrBz4uJC2Gl1JjvwN47LZwMQoRTHiGvPWbNFlYzgXahcZG
	 yYghYZCwq52etMGDVa0eK8fnMhBHGlsSWk5yXO7gz9DCtPM10p0I2qHyRgAOHU6+J8RNq
	 fl1VsvLc5d7mXga5DS9v47WhM9p7X1UNSOZ2y8EC1JPFVOy/FwW1q1Cvv0BJgFYrIYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782071;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gSmWAzmFiA4cRqHqFTMBA7GyPnlry/lISDdEPNdZJjs=;
	b=YbLO8G/cSpqazn/zC5nLcstbpBHze17k7TFeebQpIXBJ0Rbp+9U/amLHqvodbqtHLpuM
	 xuuUYAf1aOCwSUmiIKDYIO74HVa7NZHHC7nJc4FIlQZEKtciYh/6S3vOez7uAoQqM/cRa
	 NhldWE3368+83m3R9Xp8j/NjTF2t6y8GMUq9yf4S0ohbUEMMnGjGZDwuteyzhdRBcp9X+
	 xKXnOc6cSna89Xdl845UJBMla7WtkdnYyB2x6XQJbUAC1DDI14hffPsQ8GK7YmLAAkPnO
	 oIv9lR2APz7FjTDW6GUAiUjkdUTPp02nhnAk6Xo1r2nN1Awf7IcVu08f6+KgftusIlw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782071;
	bh=gSmWAzmFiA4cRqHqFTMBA7GyPnlry/lISDdEPNdZJjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iRUB22D+FOcohie2mg4bhU1tykyan05m+LonGWQqFloBuNB3rGrffs1gT2IalCL3P
	 izazk3b0Boh2XFBwiXBjMDl/QkauHrNm2m/Nqa/qKjzVIPayG2NTnZEAvHDKiFAz1+
	 mVagIJDce7hGbXkGkqmsg46ZjkdgwSUbyx1asyS7Fsto+rM3kwnjPy/qr/jJRzf4vS
	 IE30ZQh6clmx3qTRyZMF5LK64+fSEatQoZo+ircSfZlh5ryDTZ7VdkFT0NFS8fgveb
	 2xJFxIAykuI20TBryYUaxblD+08IxE8BL5cgVk6BtGBRv0jCSfLxwA8jo8JsFpohzT
	 4KbzvVvY6/vzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A889640607;
	Wed,  4 Nov 2026 08:47:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76006932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BA73606E1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OriDJRqIPzGy for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83D9060642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782069;
 b=l5ko36DEGi6df0qpkHv7rosaj0rvf15IP1fWMQ2klomaVTnLsGYg095eioU3dN+JIp2x
 X8rws44si8IMo1TQonfBwW4u8Hi7uOe3rUrbGg9M/46R9LHe2m+RR2NqBxYvv4OZi0cRk
 xY4tW/d7uMtiC7pZWyQyxzcGmnmxKgTYXya+7k5ivZMKxaYCoI75YYNnuoLC1jLXFti4t
 7pC2nKkZv4Eq6wqgiJBJqnsaudNAdMxW9uZqprd9O6Ymu325KQ/cRfErhE4LPlXD8MZjh
 ETT/QBcak+lM6lbxZVQEkgF4+QcWC+vrbeAGpIkyCM0PbsardC7Bii6XIgPRv/4rQ3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782069;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=gSmWAzmFiA4cRqHqFTMBA7GyPnlry/lISDdEPNdZJjs=;
 b=G87Q3+y/oIaR0eTDCYLYHMkTFwV6gQpXAM6G5ZOxMG6rsm02Z7dPjSD090vM1qPqJD+7
 HLwVf2LIqDR7coyC8IfvKfxcAUzaLXVbZlPnxO13yutZpWNJ3umz2/TadWF7+Ge+qKLpY
 wcAK6241e0G4XuhJHftbR9NLaym2Qpj8XtnADZgCqV4pi6PfuwhSlBUoH7k0OF11hQhKE
 0zD6v5Zx3OnoZSkuoANbIomMOr60Gr/ll7gcLyTUgELX5X5I7vgcEptVj3mcG166DvCNa
 CYb8Jn8pJXyfpawhKIMya7UQebf8dnZRYWxaw9b9a1g/gPIq69iL7cOMQtLXVHoq9TQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CItjcQX8; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CItjcQX8
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83D9060642
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:47:46 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so2595605e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793782064; x=1794386864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gSmWAzmFiA4cRqHqFTMBA7GyPnlry/lISDdEPNdZJjs=;
 b=CItjcQX8lZnqTVTHvqs5YzWLtw8+mfVck1/mcgXHPnZ9qAIXQK3OuWCT8TktZ8Uq7W
 pVb8Ht9JRmtgzJJpXQtqdXbvAsT93kPSoA+/1ivC0OBI1cintNqZdjCP8bLAQdWMExey
 9aJNPEXGZVIG/pbpvqhSvSq46VUSP3wy4+sGJMGtqmUv9vuG8HBW3plY11xGbWH+mI72
 Yt8eh8TXLIvIyHm1RdoAje+ygY/AsNFT6ZVDNInakK4EAQmI0u7o4ZTJlikpVb08KgiB
 zwPzdlucpxaVTIJw3kJdD+GLgppqeczHEJg9y2gLevfrNGHHhQtODO/GFhOZzqZG2yOh
 2FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782064; x=1794386864;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gSmWAzmFiA4cRqHqFTMBA7GyPnlry/lISDdEPNdZJjs=;
 b=brEf2QHdH6IXiXYw7m9A/RQSet8NDQvR2Vre9myZhgK8aEj2jRzhzY2WkdrOveyHu9
 8iQles7r40QVvw3b/gdTITLD6PjEME6gyyKOwIRqu+m8HNLj6Hr6Pu0BO7uSTWovAs2e
 q/DNga7TS8Jux2lTmxJqhjVNECxsoT3CtmRuYXKl+YDJgOHCDKxGaXDpLo/krAkBHE8e
 lyltFFb5sH+ViaCqa22USSQ5ltR5QBJY4Q8WmX3A+8LEfbvdOvO1U7qvckp11fyJsP6+
 dVt+XBiTR+4Dj/B+ut/o1WUmLaMuvGp8Q0T9hn+3Q2cfNEJGgUMbBrnSpRqme7EE1M4E
 Tsew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwogqJ5i/Xgfz+gfL6LfDK062KKTtmePDlhKnTNOHSxV3OQKiqUsCBJ8YqsNNzOxcb0qK4095s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/TWfdJi5jnorTZwgufTT/X8aNbOLV3dDRzHZwKkqjyC4m6mTBB
 AfqmDrDxiTu4fO/ySi7NEv198Nz9uQ0vz/nwireqssUY3VQHnT9rptA0ieXrgnWcX5Y=
X-Gm-Gg: AYBFou1gnYDYUEmg/D+ZAsvEQY9CsvzJZcmNj3dSYO4N9OE427cVxTSZMNgyrPZc/0U
 PpkEb9BwQ8rGc/ury5MeIwC1/I8+rRONvajdocFfiVwWAKFCe9CBdOVwXLsYZDyDmhIp0CjX5Lj
 0NVYI5TZtRDrq91pGUeuQvDjRfXvuHhWQMBowdvqsE4NYQVx52hoPNsza4Ne1QneIZn0Q9Ljsnt
 +kC+saUookBaLABMLNRMy8U6cHKVGT6iZegqpUCcb76ONha2IkV3hGtQNbJQDiYrzKcASmiLg04
 eblyu0RbXVoAgtMqZifUwpWa2g73DbkNE6vTChnRQ5Sy4ZZGamuUq0u5gVT4X8FAVpd/T8qNxEm
 YS3J6txYc9o4ewhpk2Vagxxo43AbB/tQq1U9hPVdnlfctHcq6KKeD7jAyW65UtlXuu4K3qXTo5d
 qm6DnmygF5WSCfVLlPPAMb6iBAdU1DwcrNRLFbDmB6YOEeRKbS7EKIRSAQit8PJqE+hloX5xVbn
 UoNjewCDNR5+NvyudsBZtA9kTSVjOzITZTjgDooyepJp8US0hZHYXV5cgThGwey5+s66I73G+Jm
 863QM3hIauPPYfcXoBg/LI2sXi0d8cza4fI8VAj1t3ryiWDb/7u2IepK
X-Received: by 2002:a05:600c:348d:b0:4a1:fbf8:55c9 with SMTP id
 5b1f17b1804b1-4ac19234acbmr332295755e9.33.1793782064502; 
 Wed, 04 Nov 2026 00:47:44 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm226379575e9.14.2026.11.04.00.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 00:47:44 -0800 (PST)
Message-ID: <7fc1e0d3-c7f4-45ae-914f-d485f1ed25eb@baylibre.com>
Date: Wed, 4 Nov 2026 09:47:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: renesas: gen5-cm33: Start the generic counter
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
 <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
 <4c9fc2c7-c131-4e6e-908d-0a7e8e6ffb17@baylibre.com>
 <4e720f9a-be35-45a2-9d90-d574ca7b488a@mailbox.org>
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
In-Reply-To: <4e720f9a-be35-45a2-9d90-d574ca7b488a@mailbox.org>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/3/26 5:09 PM, Marek Vasut wrote:
> On 10/27/26 10:15 AM, Clément Le Goffic wrote:
> 
> Hello Clement,
> 
>> Thanks for the review,
>>
>> On 10/26/26 11:18 PM, Marek Vasut wrote:
>>> On 10/26/26 4:36 PM, Clément Le Goffic wrote:
>>>> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
>>>> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
>>>> starts it before the Cortex-R52 cores are released, so their timers never
>>>> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
>>>>
>>>> Program the counter frequency and enable it before any other
>>>> initialization, through the RSIP-M alias of the counter frame.
>>>
>>> Why is U-Boot on RSIP supposed to be doing this, why is Zephyr on the CR52 not doing it when it needs that counter ?
>>
>> In the Renesas SDK it is the Gen5_IPL that start it. U-boot replaces that stage.
>>  From the manual "Set bit 0 in CNTCR to 1 to start the Generic Counter when the CPU is placed in the secure mode."
>> By default R52 is in secure mode but this can change by changing AxPROT[1].
>> This mean a zephyr running on a R52 not in secure mode can't start it.
> 
> U-Boot on RSIP is not using the timer, so shouldn't SCP start the timer, since it also starts all of its users ? That way the timer is only started when it is really needed.
> 
> [...]

The SCP isn't using it either. The timer is needed by the AP and the RT cores and is always needed whichever SW component start on the system.
TFA on Ironhide even start it here (I consider to remove it once this land):
https://github.com/ARM-software/arm-trusted-firmware/blob/v2.15.0/plat/renesas/rcar_gen5/bl31_plat_setup.c#L161-L171

SCP doesn't start by itself all of its user, it is U-boot on RSIPM that sends the "start" request.
SCP is the SCMI server it just react to SCMI requests. A "start generic counter" SCMI requests doesn't exist. Hence do it here.

The generic counter is the platform counter, U-boot on RSIPM should start all what is needed for the platform to work as a bootloader would do.

Best regards,
Clément
