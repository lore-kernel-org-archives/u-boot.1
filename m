Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA060A261B
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lJt52KFO;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=s3w4h+Dh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23DF760711;
	Wed, 18 Nov 2026 16:27:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doxN9E5_cAeT; Wed, 18 Nov 2026 16:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C81B60853
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019269;
	b=JFIHFDO+9NBDUgPoVtbAhpnFa94PUrJ212IKF/H3SPq1ak9/WAmQpMdSCO11kbhKHqTq
	 eHN3ZNE+bxmJeAsgRs44vCZj4NLCNT/u1O51C28klDkn4TyyYDSxtxtTLWG+5KtddPSAx
	 lhzUoFWvHiR26P/LJw2dmc93Xug3qEayZWeecvpHIziuKWBQ4Wd1gLMfwsmL2FFT8DpX9
	 7HPhND169qDnCVIKH2ytZZ+mku0/pau5C1bSpfMQXT5yNorRil99yaCF78qUsE6OXtf3P
	 +VwLLBDjGamP0grZqGGCh5tLmaoXakGJgvAhZBCzcV6C/mn5RvV6yQf+oXBpeLt8fww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lw5FOIbUTOBBiyJTrzzmI98X4DUGTlf2hnFEZpSZSWU=;
	b=QL4tg4Thn7KM0kZg/WfECJR/0fSIpEklvD7zqNy68GttVbMg6xghfqtE/T5PrO02w//K
	 90gTGdg3Zsgo1K1c20Lnr5mcp7XsZ4ojnkuGA7he30Aa3EeXAusscu97UYnyPJqnAECAb
	 gwSp5FYd25QWD7gvemGQmbE5jpm+ERFHj8T5fD+QTqflLhnZ1HXfODABTCPGTZaq8u83S
	 6OPr2yTo07ZtghbwONuKabsfGilrcf/EhtIRCM6Z7RWsBmPBuUuHpqGHeVESiMrVDG7ia
	 Ai0UhQJqYQjuCVKM9GupPV/tQZ0InahP/cy0lNFgwLpYJpHHftlTHyLXUP9IFavjKng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795019269;
	bh=lw5FOIbUTOBBiyJTrzzmI98X4DUGTlf2hnFEZpSZSWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJt52KFOvzxFwr7HCQU01pQ5iexHEHH2NGJGmYUXHAKGeS0B78FRxHHIe2AUbz69d
	 roijDsQGqHsfheCUbYFCfe5jbc8MbWAJ2HMlqNG3kxUH6Wqx8nDnjYfN0vvPsh4+4a
	 8h0BN4u/R/q/jz6OEFrIxUSOChLtKLE0OSj+uulxTX6wmrFIC5dbpE/QsVInYmB0dU
	 iWFK6HgmfznbbLKEIU2ThBXKhX+n6B9Di5EdHQ+5Cz5a9Y1Y8TDOcCDTMMmTlZ9WxH
	 mEa5otzjIMTSKyHGnV58WXVKCMBUWmHXPhPcilT96c756Abkv+Zaff8yet/iwrmk4i
	 RvwJFoG/ONTpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C81B60853;
	Wed, 18 Nov 2026 16:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CCCCA0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED6454082F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpvDy6ciEgvK for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7117740807
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=s3w4h+Dh
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7117740807
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:27:45 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3AA273F2DA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795019263;
 bh=lw5FOIbUTOBBiyJTrzzmI98X4DUGTlf2hnFEZpSZSWU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=s3w4h+DhtFgXKar8T3o8S5tom1pUfy6aKCHBmonu3/eRjZ1wD97/34RRGWKP0gawV
 8aaQ7VVPQxhJlOiWtq67Dx2y38VkGHWRkMsmlQ8sigW9RnjFKCNcLvMymTCwt/jrAj
 oHZoVghaL1MuzGZCDvKrZnnvXfBja6Tr0fIMELzFTx04kVD6afY9vG8K5ERo2s062N
 uLzTSJjgYovgEMWy8gpyG1dwTFRzq46L7J9j/lSxG6pweem538XxrL1Q8/bK1A7tJj
 2433MLCPoubB3nH7yo7xS/fV69Nd7B+lF4nxD/G6jzjTeC2qm9Lt2Ip4pTOgo8TDWR
 66HLnRaTYaVPvQCFFehxIWz5ok8cN5rnlocLQj3YuIysuqwDuETKM3451pErS6IBnB
 1K2UPTavs/f6SsnGOKKtaV9YWypxpnwKnCrwoZWebckSWnX3lLs7umWRIgbTdBBAqW
 huRAyjR/QmMy5tgqKYG9m1k8jB5h0UAJlR465Gw5CFq4LwIpz8tNNOutm19QVllvyK
 6XbyqK2evIWHBsb0AEem9B5qA1pI8Eg07sshp5oNoZZ14+jgelmYKcR4PkO8D/bR+K
 qSNiV6gQsjiNcRai1e3Cd7pEhZ6dYhA0yYch23Ns4xGxvnpX+NutWhGlLPqCZiaxU/
 YFAae3b4PMriniGH7719lj00=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so14743465e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019263; x=1795624063;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lw5FOIbUTOBBiyJTrzzmI98X4DUGTlf2hnFEZpSZSWU=;
 b=SiIXLA28ar20I/cR19d2jijyrGuIvbhMkf9rbD2FaAeiFSNjh5pzIlk4Ny+Dqm36p4
 XiIUyOu/18o8Sz/hc1eBs/CjXNL2kzxXF4rrtRwcXCa8wYe0iaJtYkbQl/YlNgvcfMoA
 PvRzhMrkTyeMnOfNzWDfyRBT/2yj7Fz8COotN+848KSatUpTOf7MSKTC/toADgc/AZFf
 2hV4+OH3Qa9q5uQ/pQvmE+GYo1P1TYTkN11XzKay2tZJswQ5kqCPvpUAHkVaZFCLq/EO
 2Yn4xNPmPQmqzmntgAiElfwKCvioU4ynkMA39ZpcVhHlCb3fJJW1ZYHgGGBjFmfiKi1J
 gTgA==
X-Forwarded-Encrypted: i=1;
 AL+hErHsPe7rKalimtnp+BJ7143gGptyJMcVTjYs1kwa62UB+zfgGUBYTzAMcsevvJNzUTjxZMv8ZX8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9BnOYac5T4Nau4iNAGw4OqKQ4imdeV88QH2Zj7hieh86LKpKUf
 9LIv2hrpYkDY764TrrpwMN1pme7xIDM1c1n5iSZqJnA+B80ACY3vHRNyaOrc8Me4tF82RGTyS9n
 cdjsVogqzK2oj/tflF5bIdIZaFaFwhfAfoTCtCvotmputyqEAjEc88U7Lf7gorgbNX92GR/3USr
 Q9aAYo9Nv1MQ==
X-Gm-Gg: AYBFou2alwpAMUwh1wp5j+f0IyT5qR5H0JKoVLTxthpKXXfkbrmxWvi0KSCCEkYCbCt
 lpyu0MW1Dp5OoUNnbeJhI08J+xpKnksQq8KTh+AiIJfz0SHypc87KH7oEy5g5TnFoewJH6Qbhe1
 X3TlUTlEu+QcNawgR6MrUZ5lt077WddDL3J8E1L3Rp+5m8pcaxZES0oaR0beeCbb0VLyN5oz0jY
 1QuihLksAt/lYTaN7DvH2UKWN+dnydx5AYuf13fnPeebwOsCljqREQHWlXyKELti28TVoExAxN8
 gGacEw0wgRWjNIFWBGiv/dLKzO9vbItUZ+UpO3HgSYHI76YYI/qkJB6QJSfrTkaNMAdwzNSI5OL
 JZ8/SzKjKLmOfrv1ifu1T/Zmn0kLl8hDFKPctiO7VJm19Q7Q9rLY3DJv+LigdDhr9lOCgxPkkwV
 bayP3ERAZ0O7OwO+Y4C2Z4VKlt/rDMzRYzYTEXJy3KWTR1fTBfOkic/hUua8b5kCOcMVoEpIfPf
 g==
X-Received: by 2002:a05:600d:82e8:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb7da18d83mr55098145e9.9.1795019262822; 
 Wed, 18 Nov 2026 08:27:42 -0800 (PST)
X-Received: by 2002:a05:600d:82e8:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb7da18d83mr55097745e9.9.1795019262470; 
 Wed, 18 Nov 2026 08:27:42 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:a017:1403:86b3:9a38?
 ([2a02:908:1242:30e0:a017:1403:86b3:9a38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e57664esm35349995e9.1.2026.11.18.08.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:27:41 -0800 (PST)
Message-ID: <763ce829-d9f2-42e4-b6ae-5a2ddf5117e2@canonical.com>
Date: Wed, 18 Nov 2026 17:27:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe: pass the initrd to EFI applications
To: Tim Surber <me@timsurber.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <2113981400.38169.1794275897389@app.mailbox.org>
 <DMYG3PDX1XU2.1CEBB4VRVJHNC@pigmoral.tech>
 <cdd58082-06b2-4581-abbd-0e585b928291@gmx.de>
 <CAC_iWjK=P+qbzcDxPfGco6zBSS1DgxOkSAsDY8LLCs6YndXYXQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjK=P+qbzcDxPfGco6zBSS1DgxOkSAsDY8LLCs6YndXYXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 17:24, Ilias Apalodimas wrote:
> Hi Heinrich and Tim
> 
> [...]
> 
>>>
>>
>> Hello Aswin, hello Junhui,
>>
>> Function label_boot() is called by this call sequence:
>> extlinux_boot->pxe_process->handle_pxe_menu->label_boot
>>
>> But also by bls_boot() and extlinux_pxe_boot->pxe_process.
>>
>> The description of 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI
>> applications") sounded like it would only concern network booting via
>> boot method PXE and not other boot methods like extlinux and bls and
>> specifically not booting from block devices.
>>
>> The extlinux boot method before 841abbc6d561 booted via the Linux legacy
>> entry point and not via EFI.
>>
>> If a change of the bls and extlinux boot methods is intended, this
>> should be clearly communicated.

One unintended change is that the extlinux fdtoverlay parameter (see 
CONFIG_OF_LIBFDT_OVERLAY) in extlinux.conf will be ignored for EFI binaries.

> 
> I agree we should fix the original patch and intention. However, Tim's
> patch enhances functionality and seems irrelevant to the breakage, it
> just happens to fix it, although we still priotarize EFI instead of
> extlinux for example.
> 
> I'll have a closer look at the patch tomorrow, but I don't see
> anything wrong with it.
> 
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich

