Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C091C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F9C960750;
	Tue, 25 Aug 2026 19:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XyW-iLQBK171; Tue, 25 Aug 2026 19:08:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684909;
	bh=IhXkVccWBhnV36bw5Hvu3Wo7PEkDhg0P0cblsj8Kfuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXHTpsjAuRecmOFgfEzrEZ7Hku99pS00g3WfPEh9xemqnal8wQc4+e0/Ws2F5UBlE
	 o+yRZOOPocclQAUMX7VQ/ww3ktMNnEQPYQkjS2S2/PTe1o1dAVAYaNDVxc+ay5flXb
	 Ql0XzfwWezH+DbNbU+5h82o8onnwcklGTJHrajuw1tFgY0hvX5OJMoJ7KrXMBNE4ml
	 6I8esAU7QqGco5gyLCkykBOg4YVBbDBjFoFb1wrd5PZrEbULbLWu2h94IzlZBIze11
	 8F1eNkE2Z4C136EGnAD++Eibs6KtD9Gqoug1gOWS2uLfvI3mXTDuzdZnU0u3lCcqCU
	 SdGLKJdaVwgxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6CB960758;
	Tue, 25 Aug 2026 19:08:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E46E23E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F6E4606E1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AATM7u8Thmw4 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:01:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HArElDfd
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4ED2B60604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:01:41 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so901971466b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787680899; x=1788285699;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IhXkVccWBhnV36bw5Hvu3Wo7PEkDhg0P0cblsj8Kfuc=;
 b=HArElDfd12dsYnpc5I7/YVvQE4MITqbuetC9uxXmBSzjLsCyvGUs2/QpqjTq7JVlFE
 Ze/DAcFJ4arPd5Xsla57CUYVdpi2vtHWzeP4DGxhIK2o0VRGjSvl/F5opaqWNmoX9net
 ihzrqXYu7DKT8zt7NiTWD98WhjD2X4NSNe6lJedduXuZdAvBWMx0IL4Fjhr2JVSG04Tm
 Ogl+S9xZXaylZWUsra+u1VRam8menYMHgvGSZy6ng4F7Difvob+tXez/5d0lpNayESaS
 0DkKI/abD1Q++VrEzV304qx40xZQTI8zvnB9HlkJqj3MMg9lwmv0CUryUqTyPZtV1rdc
 w0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787680899; x=1788285699;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhXkVccWBhnV36bw5Hvu3Wo7PEkDhg0P0cblsj8Kfuc=;
 b=iO0tsviJBmjs4Spf66hAcxSwa8o+U1pUcT6PqSpJbnJAoH/PkoNTih1ukdRUdlRyaK
 vXDHYhe9S0ofkaSrFecu9KVx9B6W6nuMfpSE6x1+Q2dUIaUIPVL9Ogi/2Mzbvox7hvgz
 CtzDgP1C3UDFURCZ+KpgzM1ShHc9BMtKql/4b/2hDhFI/wZP0iMdaJkKi7djSNGzxxjE
 i568BGnxjitOYk767pKdMBwySTO2Ex5CDkiAGhbCtdoP6pxRR1/6NLd7GSMuM1CZaSQo
 U/iGRWASDPuZS1onjjyr+6FeSq7DpqAf88fQSP+lYuraXrU1Gw07g4rZ/VwFGCeTQ5ow
 eEsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8eypERPZ5Lu5QlRJA4PqCDVDxhNcpYThSeC3y6gVTS8YzzWfhRFQ8MtPwYbq1/b1/GnttJk0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nwc3hecQQauBGO/OACQg2lN548OtG0gsQDQUlMlUa7OPY1UCkW
 V3es13xCq3H2x4bF/PP9516ufnpWSTgptv2sXtaJFGv1pNoiD+ndxSaS
X-Gm-Gg: AR+sD10aRdGSAT1TNzlSI6PnAz9+SkpIXjarqvk0mCur4W0ru1MaPWmmCnLtl8Ly4cr
 NqfVO4HtqpvSJYsmjHNHydgbDFQczVPhcC1vALTaW7O9cGGNs038SKlG4EIcqQjFQboTRWw0IGl
 l+G9IO1SPjy20TY1+DIChy8n5Q8mA597QnoC/ml0AIJ+rHRdN+CcADdHd/WLUlcrwPkMuoSZzss
 OFw/m7BQmmw4YWGv0QBjquk4FNP5rO2b0svYGGEL3EAwBL1k5Ayc6bsaAREemx3g7l12xDZJWDp
 efncPz8otv5ZUr1VvP4dQotM8hnZRfSKlJToMivlCM5ptEGG6sLdVCzmTmGaD/rYKtntB7O+naT
 Gxs//ypfmP0WAKUSJaKhnRu5KA8xQDcYKXI85IEG/mYy+nHUGc8wfGveyZTuvXXWh6ABY+n7r1s
 lSJLPT9bs9egp/OBJUNvEPqS/aEPI8LXQLGDf7sce/9c4nu2MgteTZq+ulLYomzvJ88gGI8iQoh
 NdEXMjCwQiMx/pvjr+/ZH8vs69x2wuFCK9pH50vQ6NDVXYKpbNkCYlUoqaSgEgBfLei+3Jyjnu/
 lwgB8NEFWqw9f5tvQnoE8DdPILa+zI9eDQJTT4RCqVxCrjaYHmf3vLKC70573pcTFtztBFQssFy
 xWNEG
X-Received: by 2002:a17:907:a890:b0:c25:254:292e with SMTP id
 a640c23a62f3a-c250ba594bfmr72259166b.0.1787680899108; 
 Tue, 25 Aug 2026 11:01:39 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:482c:2476:c212:a769?
 (2a02-8388-e6ca-5780-482c-2476-c212-a769.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:482c:2476:c212:a769])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fd00csm65935666b.15.2026.08.25.11.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 11:01:38 -0700 (PDT)
Message-ID: <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com>
Date: Tue, 25 Aug 2026 20:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com> <ao2Iqsq-Xp4dQK4c@hiagonb>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <ao2Iqsq-Xp4dQK4c@hiagonb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 19:08:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 25.08.26 14:24, Hiago De Franco wrote:
> Hi Andrei,
> 
> On Sat, Aug 22, 2026 at 11:15:10AM +0200, Andrei Lalaev wrote:
>> Hi Hiago,
>>
>> Thank you for the patches.
>>
>> From your cover letter I understood that SD card is supported.
>> However whatever I try, I always get the following error:
>>
>>     U-Boot 2026.07-00002-gbd5e3de2ed6a (Aug 22 2026 - 10:27:48 +0200)milkv_duo_256m
>>
>>     DRAM:  256 MiB
>>     Core:  20 devices, 13 uclasses, devicetree: separate
>>     MMC:   mmc@4310000: 0
>>     Loading Environment from nowhere... OK
>>     In:    serial@4140000
>>     Out:   serial@4140000
>>     Err:   serial@4140000
>>     Net:
>>     Warning: ethernet@4070000 (eth0) using random MAC address - 16:21:8c:10:cd:96
>>     eth0: ethernet@4070000
>>     Hit any key to stop autoboot: 0
>>     milkv_duo_256m# mmc info
>>     Card did not respond to voltage select! : -110
>>     milkv_duo_256m# mmc rescan
>>     Card did not respond to voltage select! : -110
>>
>>
>> I tried 2 different SD cards and got the same result.
>>
>> Am I doing something wrong, or is there something else I need to configure?
> 
> You are most likely missing this patch:
> 
> https://lore.kernel.org/all/20260507234836.284918-1-hfranco@baylibre.com/
> 
> This is needed in order to make the SD card work. This patch is already
> merged on main branch, as commit 3a4a8963aace ("mmc: cv1800b_sdhci:
> honor 'no-1-8-v' DT property").
> 
> Check this patch and let me know if it works now ;)

Thank you for your response:)

I also tried the latest main branch (so all patches are definitely included)
and had the same problem.

I guess I somehow managed to fix the problem, so below I'll describe what I did
and would like to hear your thoughts about it.


When I generated `fip.bin` using precompiled binaries from fiptool repo [1],
it started working most of the time. Previously I was using an FSBL manually generated
using official SDK [2]. However, I would still occasionally get
voltage select error and timeouts.

So I started comparing FSBL and U-boot from Sophgo (2021.10) and
I couldn't find any differences that could explain this behaviour.

Today I found out that the kernel DTS configures the SD0_CLK pin to a different value [3].
By default, we have 0x48 in IOBLK_G10_REG_SD0_CLK register, but if I set it to 0x84
like kernel does, it magically starts to work all the time.

I understand why increasing the drive strength fixed timeout issues, but I don't understand
why I don't see the same problem with the U-Boot from Sophgo (2021.10).

1 - https://github.com/sophgo/fiptool
2 - https://github.com/milkv-duo/duo-buildroot-sdk-v2/tree/main
3 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sophgo/sg2002-milkv-duo256m.dts#n68

>>
>>
>> Best regards,
>> Andrei Lalaev
> 
> Regards,
> Hiago.


-- 
Best regards,
Andrei Lalaev
