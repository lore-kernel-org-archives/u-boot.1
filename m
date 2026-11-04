Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7459606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lpVRo83h;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hRksZTJL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D48B80DFD;
	Wed,  4 Nov 2026 08:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kULCXbBOfDKQ; Wed,  4 Nov 2026 08:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 97FA980DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793780412;
	b=UmZUQn/FeVIasfJV5m+OzbSQUMVhEw5W3fXyPWnJlkYwgiZ2uXPTIcoIgZHY3YBProY4
	 R2kNcoTy0Jv4nUoQEw9eJ7w8rabrEk1eCNFF8M+E7deAYt3CK3wv4btRwKfabYBOLDOzp
	 JVM/5a7IuA6RVXIL5wEeDe2H0ncpmnKaB2fSbrk1DFGuy7K8iyW9w+wvmTbP5xASTD81y
	 qvvbOg3/VVJ7lFobn+d0FwhFXxsqgHkffTQMd1YboxgNSZJ/8ArkNe0lHcpgUkEZRdHWH
	 FEol7NrGQKGuF8fG/iUZg+lhapMr5PXU/nQb/tRG4OzP3bgwbj3N5GEZHwH08VaWpsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793780412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xZaHmKd6Yda0IbqZJBxmEd/XQby+gNMV40MD/bwMRgE=;
	b=S1yvCpxHqBjjb0AUVvnhLWxOHAPLJtUsJMox78CzG8ab3dZk9jHDPmZjv2ZhM21/ScV/
	 /ITuZ5NPzV6PQYbYJwfMZ4yVnJmljxBvLsrl8tij1bFm5xLy2paunSi8tu6GoeDrcC8/M
	 5da0Ltu+8tXpshFasyPxZmhlFb6u80N+xA64CkOWrTk/RAFlift5iU5ptKhihHPl9BW9n
	 MO9O6LORMmOWoV9GKEfTW64SE4mBa0Wu1iwqtnDzucru0r9ou+5VryhA3blRkbvMIPC2G
	 8SNPbeyUPzs+rS6BvrQm77m5Lr/YoKebTwblU+gh7mIUVngu/CGtfy+0dEVXPMzulvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793780412;
	bh=xZaHmKd6Yda0IbqZJBxmEd/XQby+gNMV40MD/bwMRgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lpVRo83hjyTXJri9G9llEuDChMXowbP4D2IoXgph/SDTIFw/Ij1hrz5cA6Jg7FYbx
	 F3rVUw7xyZUXCR0ff9ReyrnKVcWVjLd9sB8L9fpSSiWpuELNHkAA0iKkqZ87pKAaX+
	 9dvsM8rus67Ymyobl0vlIKZ2Yd8nRpTny/2o5pwLEfO6tgTvXV9oqMAQUeYCaQbvyO
	 vn/R5IooU7hygwRPbG3JtHmw4GyufiWX8P4wBuDeqV45yAFJuLg1/BFmmHA7xlGmHS
	 iEx67+3ZuR7nCx0vcNlYwjiHU120K2yCjig2XDNEkxDP759nT7FPcqKNQCSKgmArMW
	 SHEnbq0z06alQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97FA980DB0;
	Wed,  4 Nov 2026 08:20:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22A519C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08A4E40652
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2mYqcd9lrne for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20B774063E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793780410;
 b=MPO1sjO2rlGUIFr0SOC6tCAEa/9XqjuufKprHwoq6k1rOBDHCmtphcaF3Wq8SbEgj8R5
 pmXq3jbMn7RA66zz4xmLTu7dnSWB6JyJMynSLVDuO5/Nr2zneDvN91vwlULbeuvv521PC
 sLegOnWdsGizrFmmxK3u0Z9IDv70qOFz63pi7vN5HSIx5/AWodCaX6yupUFhbnZXVp9fN
 p3LcMllWRv8GcaMEX4Z++tD9lGAfZIs8aVLyj1MAaZOGcJ+0kzBba8GpN0DHQxbvK6x+3
 bicPHJSDQEX1ZTKruF1UYLjTIZUpU6rYrmpoi4uJRY02LqO/zJHAnCPNvA5oL0buN3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793780410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=xZaHmKd6Yda0IbqZJBxmEd/XQby+gNMV40MD/bwMRgE=;
 b=j8kWeF5fKSps1JoP5U1O1ruvaVDiRYJAwT2okwJ6+qcpR8TbWsDA+c2gQMU44KwL6ttE
 M7E4l+d69IVt2TBGUJbMQuzRDYDkmLpJ/L08dkCWFB6YSFWPawP99fsPQAm+RTI2zTrxj
 wFaGOGDXxAAq+6fnZ5FmqVdOZd35D4MMEjH/E3fA8XSfNYbVuJWmPVvbSNCUhFAJTNe4E
 7Ee3ubsk9fcfFtgzeMYj2XEZhLAUaYwzdeMgihehFcX0hLzX9afFRH0vxHYJuFcQOeBz2
 ld/RYJ3eqdx7isEyARmAxDcDX6BNjN5Q+DZjwLO3B10w3+X9nHwM2Nd0GWz2ueXgZQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hRksZTJL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hRksZTJL
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20B774063E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:20:08 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso307788f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793780406; x=1794385206;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xZaHmKd6Yda0IbqZJBxmEd/XQby+gNMV40MD/bwMRgE=;
 b=hRksZTJLayDswdz/VzBaTMoRfcb9mshuWENwXaKymnRjVwjq/bX8FKbusl3tALZmqm
 qSzIh/OKpg/LtB0IFEpN3dzLWstpwmz/5Ngx/MGwdph9TjVFaSv7O1nJKU95qTxWweEH
 OXQb5KpmFif43k90ipT7vRkHqqMcw33/JSSQnLKvs7fcCL7ccf400BsfRYhK6JqwkSJC
 DJXMEMmRO/AGkJ1VO8+M75kE43POyWAxO0ew2eVU+iT+RaJZaJ7AJzDW/38fvVxD2Oq5
 L5Qh1/+/Q8jI8uQxHrlxousCgelrkCxQ7vSXB29IGG/OQeeNc4nTaIccfvt7nm+hpq1x
 DCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793780406; x=1794385206;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZaHmKd6Yda0IbqZJBxmEd/XQby+gNMV40MD/bwMRgE=;
 b=NLigIOBICCNCVEtkOHqTuywsqS21sbRFXFZCyRVkaprZG0SRxFlkCYWwyqTiMtVV0N
 NeJyw+WOuWh2Pl2/dne7R/5CgkhmxuAy2NC2+ELIQI3nZREhYxycaGcAQRBrQH517KB3
 Aiq/Vf7pVgfvdxd948hQ6GI0hoXalG7b6GnwoAbIUUfIIc33DQ72CAAyNG+3QcbggOuv
 yxR1MVp5+jlRa2G8y38rjUt+GEKI91udxNkjfQCybCTqup3tmDDhTfnNEQsC6GTm1j95
 B2ah+xT6PQ0QJ+1/NP8PDmTru/YMaMKAN7mUAxmdVNO7MCfvL7vJfGw6ZfqIYxt4Ib7y
 R/9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpsU5JlDrv4NsD1Uv2o243b9WYHAgfatcPAHi2Np+39NZP1E/8VnIM4tuOVLY+Y0rsM7ZsYkI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+l57nAqetnmxFUPaRN/WDPMF/6B206eQil4wxbTG0l4tVlVAnQ
 Uv9NS+AFsyHEYFrXHRbJu8rykfeIwbzq9oNKd9dioH3FkvcU6Mfa8VYnhOCuKqu5oik=
X-Gm-Gg: AYBFou1NlP5cyL90/8RWQ3dLfQOF4hD3NmQkG8JV7cIT5L5QxWFo0CMby0NMkkF8lYA
 PoG6MGP085sAFARqUKJTQ3rHSsy0sBBr4YTJQQt+BDR9b+YF7htCtW3gILNOkb69nLGBm3UqBZV
 2wKR3AfMy3XUmwQgqZ5cxV6dyY2H+ZL+sYYqiB0MXZhFNsJB696BpXvga0Lfyk/RXBMw6nxAvIA
 +P53pGKDat23rv11w/gb6WntR2SREiJNx6LYKZm+Ixvw76PrpTD8XvXHaPjlXzyBXie5RIkiunn
 DH41sCQRXZfj/4LKfzUnzLuaKlNGWXD0iBwFevCA/MJiewR3ofu8BxY9/iPMk7hQBJouUG/ZZzY
 LzagbJqR92JhOXmcp679U/KGSCfVzT17+RS+htGNX08s4gX1k590mDBLmpOxRXHgF2CY/rmhGB+
 3ayfSy2y/md8t4dHb44dAijLpYKxt6i4YPElz127CcbEvhgkBQsfMeRCKZLUVwatAcPJyK5M+g/
 4UimGDs2THluh/FJqvIM5KLEqams/WpmTatLGWCCsjm54H7SIcJxwnk5YihD1FB/IBFIlqMibaA
 jAtk15LZgF2Z+2ncXDvpvwH215YVWJ5rmjU1zXLQ3hjVigYao7usNNT66q6fN+X0iTEE0qVQTK1
 SzQ==
X-Received: by 2002:a05:6000:40cf:b0:48d:c29e:40c3 with SMTP id
 ffacd0b85a97d-48e6e5008f5mr35710352f8f.33.1793780405957; 
 Wed, 04 Nov 2026 00:20:05 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1f100sm2458398f8f.46.2026.11.04.00.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 00:20:05 -0800 (PST)
Message-ID: <6d16f6c3-2bc3-482c-be82-463ebdd6b23a@baylibre.com>
Date: Wed, 4 Nov 2026 09:20:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: renesas: gen5-cm33: Start the generic counter
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
 <81f0a82d-0678-4229-8244-c2f505c873f6@mailbox.org>
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
In-Reply-To: <81f0a82d-0678-4229-8244-c2f505c873f6@mailbox.org>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/3/26 4:53 PM, Marek Vasut wrote:
> On 11/3/26 4:01 PM, Clément Le Goffic wrote:
>> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
>> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
>> starts it before the Cortex-R52 cores are released, so their timers never
>> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
>>
>> Only CPU in secure mode can start this counter. Zephyr on R52 has no control on
>> the CPU mode so can't start it if it is in secure mode. Start it there
>> in u-boot IPL.
>>
>> Program the counter frequency and enable it before any other
>> initialization, through the RSIP-M alias of the counter frame.
>>
>> Also fix the advertised frequency as the counter counts by H'10 every
>> clock edge of its reference clock SASYNCD1_RT_MAIN (66.666667 MHz)
>> 66.666667 * 16 = 1066.666667 -> 1066666667.
>>
>> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
>> ---
>> Changes in v2:
>> - Explain in the commit message why the RSIP-M U-Boot starts the counter
>>    and the CONFIG_SYS_CLK_FREQ change
>> - Drop the Assisted-by trailer
> Is this patch no longer generated by AI ?

Tom told me that it is discouraged to use AI + it breaks checkpatch:
https://lore.kernel.org/u-boot/20261026210850.GK646438@bill-the-cat/
Indeed I could have mention it and sharing this link.

> I will respond to V1 shortly.

Thanks!

Best regards,
Clément
