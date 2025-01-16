Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2401AC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8393C80283;
	Thu, 16 Jan 2025 15:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tUFC+NLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CEF8033D; Thu, 16 Jan 2025 15:26:59 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4E780214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14AC13F682
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737037614;
 bh=zwes33wWPmSUsJI4vRRZ3BNkKt7PaeSLMx+tVT6+A5Q=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tUFC+NLkft7tbERBMfDjm44SK/F1TYQw7JT0liv/ghxHGaG7hrWbe+kbZHo8R/17M
 YnLwaEaSH4lox37psPBDKQvJg2LIOJWDkV4awbbJxO79i0t5M0f0VXINjYY2TWJL+d
 vIgRsW4MlhzgAyCgvDY+OFBBTBU82k3YnQm+rRn/tyCa7QBB/M0kU2L9TjMS18bgYP
 qD6lHN7g1YcBEip3L2KXqU04yBw4PaO5aNYCm/nQYm6VjWYI2ZYidkRjtLdqXnaehy
 BN3XAO23ppmG4/5+NTud8XCTU0fBCkueyugoM2PcPmtGZIZgPis8QiqkW2OUmdrfqx
 4LYug4CE9I6hQ==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38bee05f396so414034f8f.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737037613; x=1737642413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwes33wWPmSUsJI4vRRZ3BNkKt7PaeSLMx+tVT6+A5Q=;
 b=KAo/E4QDkbUg0f6CfCwkMJEAlWmWT7KjVWBe4ZtK8g4k9m3M4Kh/zAnnhkeCLkIqu9
 2cUKLGQeToJQWOzI4n2X8W2JdPLKgEg/1xfsrnRPEnpEQuMdDQPcDwQZ8J08f1aby6qk
 8HKrMKsaDraQ/0vM6OvyghPWcYFaejF6JjLYXQEqGsN0rQM+UN502YkWXcS7fy4ad700
 uxo8TkATpGWl/akBmHW1KkD5dyLCkoxHg2iyDo82ifYt1g/+tWRNZHcPzkjTm4IIHNs+
 peZL1oboH6yp2nGAgpplcNsAbvEMhvHju3USWoMz3eM6eE0f9QgY5bnTkkl1hCQTV5CO
 KgKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP0X6ph2gnZCd33a9tj7dFiFcq0ev5XO2wACv5dqhl27jOHY5i/j6XKR/K8x2nArnVGy2vHu0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz64HAEYWVoGqhZJWUsXmf94cQyWLIxXirPwcd9YjsdCDj0iJrQ
 ahNZXfZ+5aTP55tdEy6zspYrC0Abi/npLV3/CdPpmQwE1H7el82FkXlBvxUZHKPwkQz2TvRgylx
 VsXXJC/GTtOPuCIEd/dpw0rtquDb3zv6kvYgClh32N1b7/00m17e0bNEH1K5j+V6kAtw=
X-Gm-Gg: ASbGncuKxL2lu2V3PqI8+GkASOPScLZWrlqqnNUfOvijhcdCmJn8jnwdMr42bSx4WBS
 IxjZfn8/iJdHHSOFoLAw0asJLSox6n8VAQzKHgznbXrOaMBIgtE13sOLb3HN9clT1r99M/aZTDe
 S/3p0FfJM/i/c1sGLf3uCQC2HkaWNrqN4BiVnhMOccqXfF5QNixS5QBGtieXU70NYv/MLpCtlZb
 V5Z79074RV2qjAIEK2U7ghEZX47IhJTPSkSngmivddzUASwZGaYY1ql67ysLTCkDNWLoIDAaho1
 ec6XG3gqNLdGF9LAfF0E0ESywxlnc+YKneF3KGrIeY7i
X-Received: by 2002:a05:6000:156d:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-38bec4f5fbdmr2527662f8f.4.1737037613686; 
 Thu, 16 Jan 2025 06:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ66zoLjYAkDkqsrmTtXg1Zso17jj+PO197b+xfA1B81n1UDJ892NfYgRNynUD0eBQuUE2Bg==
X-Received: by 2002:a05:6000:156d:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-38bec4f5fbdmr2527647f8f.4.1737037613327; 
 Thu, 16 Jan 2025 06:26:53 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79?
 ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221b7fsm16641f8f.27.2025.01.16.06.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 06:26:52 -0800 (PST)
Message-ID: <de336c7d-60f0-4a8d-a5ba-b77f36792b91@canonical.com>
Date: Thu, 16 Jan 2025 15:26:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] acpi: don't fill FADT, MADT if CONFIG_QFW_ACPI=y
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
 <CALNFmy3ca5Z_Dr=1dzK8F4_+YWK4LtzK8Pq9VdNKMKS2kjWStg@mail.gmail.com>
 <8251256c-d1d6-478c-aa2c-6dcb8f5e4c12@canonical.com>
 <CALNFmy1BLri30E8Sv_C47JKKQTqN2oWv0dyFdTGuPUXxX4v5RA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CALNFmy1BLri30E8Sv_C47JKKQTqN2oWv0dyFdTGuPUXxX4v5RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 16.01.25 15:16, Patrick Rudolph wrote:
> On Thu, Jan 16, 2025 at 2:34 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>>>> Anything wrong with the patch series send Nov 14 2024 that addressed
>>> this issue as well?
>>>
>>> Reviewed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Could you, please, provide a link?
>>>>>>> Hi Heinrich,
> here it is https://lists.denx.de/pipermail/u-boot/2024-November/571757.html
> 
> I'm fine with either solution.
> 
> Regards,
> Patrick

I was not aware of your patch, sorry.

With my patch the code size will be a bit smaller as the linker list 
entries are not generated and functions acpi_write_madt() and 
acpi_write_fadt() will be eliminated by the linker. I guess this is the 
right way forward.

Best regards

Heinrich
