Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C9606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j0g0zNUQ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IE9y5MDH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB7C080E37;
	Wed, 25 Nov 2026 09:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ekL7zce4C7u; Wed, 25 Nov 2026 09:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B43480E5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600334;
	b=Uw3+WF9ZxTzZjH1b8JApS4EX7wn1mbJrwXu31h0oLrlNUuSL6WMHwdccfFtnmBTEfdQX
	 85XS/Xjb2f0wTjT6mBatwVAO0CszbTAQCSW79u8ciB5EJL0ycKBoOE1YOmuTdgjcmouKi
	 KhQcEraJi00SQ+F2Dura+CKoHrI+sHGKr/1Yj+2dSNAaVcqCKV7RqEnXOWVZryn5LYP6k
	 5pbiM/AySWozLns1u0M/velPDDo3q42uBEFG/6+56YuIi08I9/NpvP8vM74EF9Aw6HHTE
	 2pxlSoRbbnYjEEkxwXxxHBzfG15dumz0/YoCPD8Fa0qETgZWU9c9aKHJB+n8I2Y2FHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UAdit6IM9bVBCs2Kdib1zvLVlRPqUZCCGKO462Yd8Xk=;
	b=cazKDJVaFfmB15LzU4YaDsxu+bT6zkH6xnWxakFSUbLsyatOr1IMGF8P8rbI4tyHRPQ+
	 UN7cwFYAMZexTZ9E+BBO4U6w3XHx4AbKQ4vRHXFdJA/IQb4qP6k3ib6hvwUkjh78TUHwk
	 I0v/HcqUSl4extq0aXQknVe+YIaUvUguIycSAs7q5MAXvRIyyIv9vqMJeF2m5wyuKyp6X
	 43xyfy4YrBJZnSl6nuFhjI9cglmflBN5hxk1TXyWm1iqwEvVTtDo9SHj0LEL1sBJX+Xyp
	 0o7ubvpaiLoMM3CMB4SgK7NTtkp+OSQOEfcAHFqJ9ROjVVznJ9a1O30SzCu1TOhPk8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795600334;
	bh=UAdit6IM9bVBCs2Kdib1zvLVlRPqUZCCGKO462Yd8Xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0g0zNUQnAXdUnMYD8nSU6BE33zTT8HruXsTzEZQ8IvTbQlz8/n8zC40VuT512u/C
	 T6CYVX86UxwPLM0TsNFfGDcrjGbtldP+Xuf1B1xdFTTVrz1h5aHwWQncLDni5/GHWY
	 nvd9qqIl0h/2bpUdyHT5d3bW2IOzPXzlDYN4MKK4wv1RmXrIluQuWZIoVicPHGjCBN
	 e2dpQjQ6mpoLxqLBttduJoJGJ9sro33Lq0h9CCosZylP5X+92CTF88Hs1V1ACEoCvE
	 TiyWGIIGB0gTAuOJSQ1N1nihTWfOx6ANI/ajWxLDnmkSd1A2gnfAcyBM9qRJX0JAM4
	 TnKNj+UuR6nhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B43480E5F;
	Wed, 25 Nov 2026 09:52:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0C2D2DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94AFE4066F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zX9UW67LNy0q for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 09:52:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8787D4066C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IE9y5MDH
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8787D4066C
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:52:10 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so3904716f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795600328; x=1796205128;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UAdit6IM9bVBCs2Kdib1zvLVlRPqUZCCGKO462Yd8Xk=;
 b=IE9y5MDHwKCGsA0UhWTdJdatJDIkUlzAO0tMK2e4VeYSDQwIffb53zMzkzgAhhzYCL
 cFfRfIq5xOGFzMqpl+uwRhg/2L1rKa8IJUFMQTf1QCb8vQhtE2fAz1DXV7W9giCBTyxv
 uOcdNt77+DcY1G6saDoqbwL/Qk6d9jy8LJw84xlYfZ33Cl16fn1eDHtENWFTq0xq4J/s
 UTbL0jweKuKO8KBc/AGFSspk3J6Wv+IeMfLbSkIeL/0kag9bbvNAotE3uu3Ka506GeEe
 7CHfua2rg9SrmiW5bfYdh2UJK5IwJw2Y4T+DaThPmBGKChKrhH5ogEzev7CqKhTRMUh9
 K/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600328; x=1796205128;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UAdit6IM9bVBCs2Kdib1zvLVlRPqUZCCGKO462Yd8Xk=;
 b=ttsGY8maif9oF56/JV2f86vQ1LU3JZmJazpzbIk0cV9U0eRTsZjfkJWtxUXL0EUrzT
 5zXhD0O8FOz21MsqfqcDnNvR9vhFD996dUUA0fA0u20PS/5S/qoVHk6Cx7/s5ykXXc0/
 ISvDDs2AsIoMT0TpSnsrbhHZezIsKr3rxA5Vk6ZQ7S9laQFxVR2cLRwKNwDcOWvr0Xk5
 2qeMv0PyO08PvUg4uOJ1vT5gPkxy7g9TZMM7qVXMPpv+jOR87RhIpJSNFUdB8xsd2Pzz
 /HYmjL3uRmsPFEEfp12nPl+3/ZjmxKHY+cR1OpYLd5Au/ZFhvlyHN2do1ez7eKA2eK36
 Dfqw==
X-Forwarded-Encrypted: i=1;
 AL+hErFWFe8qme3SjevIVXb8bR/dNszvUXGPp7x1MWgpo7JBb4rPpxuDXP0i63qWycmm+p2NGjlD1OM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9SWy97XC2jQZvuVtuCuwoTnOUGsCoj2Tm44gyH31zfESV0oO7x
 hcA5h+vqkjKSc0r7QaFvWKtncbX5n7nYoJpiEBwYVZNEIDxrSHZIgypFO+UrDVFQ+ZHzn9KDOqh
 /+2As
X-Gm-Gg: AZFdTZcJt3r5BEcF/V3Ti4miqJASpAbiKXunP/JDy0q09b9jkPmy1n7o6TV/Y7Ls3BA
 qXweKUqQO6lg7Yyc6jXC/q8lowRYiG/EUkTheeA70bA6F2ukKgFp+v9F/KN4IdsltDwnY4CLb8o
 PvPMHf7DPKQsOWoRL3ZIBOOtj/LMxkPBZVoaSgmw3aozB2EL6GpKHm/t5qazQibMJybXlSXVWYM
 SRBgtnX3eNbLpoEcWORp/3I5mRvG6rH3ptLaugqfkxN+S9xDoBvadKRvcuKkfnBlspwHYzF8OTa
 4s+NagCpHf6DdkAYBmET+tFvw/YonZ/ZRPD5x7YaBc8mkynjyIZEEQFmhdoLbKZyz5M8fsyfSPX
 P8P1oiZ0G/wHX3iRkbINhIaA99SkxWc0eFMj2dVYTjR8TYnssoB9XALDf3/ljeWlm2tzKTFtK06
 NUyZbYptthZNy6WwnQAhrXt8FduTdCZHIhNStyy7iKB6WUAsoKP2O9lc2YFdm0/JH6s0tlXhg5R
 rb81kTMnADuG27jHOIGfwqwn+oLBBcPWsqfKoOBdRuPvlKy93OW96FnZtOePyLh0onFd7FXTyG3
 G18C0GGG/W0z9N9/Tqw93nsxCVFc2Ly10QboGkG5MbNjOBJnbMug/SHM3hKGrWhA/OGk6JOVk/8
 orap0GbbwRmyWSUF2Ur98hAmzIr7nTA60SSzIUXHo/f78Xz2HRKDraJSvKOA2drI=
X-Received: by 2002:a05:6000:4b17:b0:48e:7508:bc20 with SMTP id
 ffacd0b85a97d-4abaa9769c4mr34450950f8f.2.1795600328282; 
 Wed, 25 Nov 2026 01:52:08 -0800 (PST)
Received: from ?IPV6:2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8?
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm34138645f8f.2.2026.11.25.01.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 01:52:07 -0800 (PST)
Message-ID: <dd138c18-c37d-4ecb-ab97-069d335c5174@baylibre.com>
Date: Wed, 25 Nov 2026 10:52:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm: dts: am43xx: Switch to OF_UPSTREAM
To: Judith Mendez <jm@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 "Francis, Sebin" <sebin.francis@ti.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
 <1921fbd4-94f4-45d0-b708-d327fe6631f0@ti.com>
 <d8cc5a71-8293-4efd-bec8-900c8aa8ee56@baylibre.com>
 <6449f1bd-4796-438e-bb4a-76c8f854a01a@ti.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <6449f1bd-4796-438e-bb4a-76c8f854a01a@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Judith,

On 11/17/26 22:25, Judith Mendez wrote:
> Hi Julien,
>
> On 11/17/26 3:23 AM, Julien Panis wrote:
>> Hi Judith,
>>
>> On 11/17/26 00:28, Judith Mendez wrote:
>>> Hi Markus, Julien,
>>>
>>> On 11/4/26 3:47 AM, Markus Schneider-Pargmann (TI) wrote:
>>>> Hi,
>>>>
>>>> this series does the final changes to switch on OF_UPSTREAM on am43xx.
>>>> Mainly it adds some -u-boot.dtsi files to define tick-timer and other
>>>> necessary pieces. It changes the defconfigs and removes the old
>>>> devicetrees.
>>>>
>>>> This series does not have any dependencies that are not merged.
>>>>
>>>> It was tested on am437x industrial EVM with mmc. Help testing is
>>>> appreciated.
>>>
>>>
>>> I was able to test SD boot on am437 EVM and AM437 SK boards and I see
>>> the following:
>>>
>>>
>>> EVM: https://gist.github.com/jmenti/9c494e63186ad0ddc87aacc974f47336
>>> SK: https://gist.github.com/jmenti/a5d5ca0804f6c0f94e640d5fe0b76030
>>>
>>> With signature:
>>>
>>> Retrieving file: /extlinux/../am437x-gp-evm.dtb
>>> Card did not respond to voltage select! : -110
>>> Cannot persist EFI variables without system partition
>>> Booting <NULL>
>>>
>>> and it pauses boot here for a while.
>>>
>>> Is this expected or are we missing some configuration for SD card boot?
>>>
>>> Figured id ask before testing uart +  nfs and am437 IDK board.
>>>
>>> ~ Judith
>>
>> Thank you for testing on these boards.
>>
>> The error is not expected. I do not observe this on IDK.
>>
>> Looks like the second controller (mmc3) was disabled in the old local EVM DT :
>> ```
>> &mmc3 {
>>      /* disable MMC3 as SDIO is not supported in U-Boot */
>>      status = "disabled";
>>      [...]
>> ```
>> The old SK DT never enabled mmc3 at all.
>>
>> In this v2 series, upstream DT sets status = "okay" for mmc3 in both `am437x-gp-evm.dts:870`
>> and `am437x-sk-evm.dts:690`.
>>
>> Do you observe the same issue if you disable mmc3 instead ? You can add these lines
>> to `arch/arm/dts/am437x-gp-evm-u-boot.dtsi` and `arch/arm/dts/am437x-sk- evm-u-boot.dtsi` :
>> ```
>> &mmc3 {
>>          /* SDIO WiFi module, not supported in U-Boot */
>>          status = "disabled";
>> };
>> ```
>
> It seems like:
>
> Cannot persist EFI variables without system partition
> Booting <NULL>
>
> already existing in main branch, the only issue that was introduced was:
>
> Card did not respond to voltage select! : -110
>
> which is fixed by disabling MMC2. But we cannot completely disable MMC2
> in Linux DT, so perhaps in u-boot.dtsi or maybe there is a better fix
> for this in u-boot env?
>
> Here are the three tests I ran this time:
>
> 1. AM437 EVM SD boot test on main:
> https://gist.github.com/jmenti/109212c3d186fcdc1225ac5010038844
> 2. AM437 EVM SD boot test on main with of_upstream patches:
> https://gist.github.com/jmenti/7f0eb8fb45ee110c1f522cbbded96212
> 3. AM437 EVM SD boot test on main with of_upstream patches & MMC2 disable:
> https://gist.github.com/jmenti/0f3c59d6fd41b9b810e6ecc908237827
>
> I also wonder what introduced this issue:
>
> "Booting <NULL>"
>
> Do you know?
>
> ~ Judith

IMO we should disable MMC2 in the board u-boot overrides
(`am437x-gp-evm-u-boot.dtsi` and `am437x-sk- evm-u-boot.dtsi`).
I am going to send a v3.

If "Cannot persist EFI variables without system partition" and
"Booting <NULL>" already existed in main branch, then these
messages are not related to OF_UPSTREAM switching.
I don't know what introduced these issues, but I think it should
be addressed in another series, as it seems to be a different topic.

Julien

