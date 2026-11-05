Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD0606D828
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IZYoICiU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EhEpuROz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E036B810F1;
	Thu,  5 Nov 2026 15:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-e5FkhEuZhm; Thu,  5 Nov 2026 15:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CFF2C80BC4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793893039;
	b=Zcp12km/DeOg0fCLoI5IpGUlEacQ+Yo5QSyy1pCDtdm2jmGEXBF0Jel9R5iXQWcTlJj0
	 wgPmKMvUbKCwZgODOxAAj4U1YtkIEqwSawGZ1SqT+Dg0X7FGkwh5URXK6h8EsYGwgUyFj
	 rd/XtuiWMj+UxHcmYQI0JJij0jlU7TdJBoZXsBfc/+Bij9SlPNAowzKSMEGC3hWfNKY9e
	 +Z6KLRzkndMipcj6jB5MnWX5Yw2+P0vQWGyU6qLFxbd7wFcjO13AXQLTcLfbhfCcBmFz4
	 bnTX4dLYUeuk3rOBrNBBePWxdAebi439IsyqYRgUuBTr5SccYgXAiXdWCEawzZf6oYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793893039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bdFrpdLxoB4aAzNVJJf4jm1NkDBMimgM+MvnRlKEGQA=;
	b=O34TFsJoqCt02NmArwu05NIGK6aFW98Mll87DS7zzMFeMPpczzl1T33dfnjHK4/Wm7XS
	 l2os2y1P9gZhdwnQRjlyLfq4HCKLDk7JYqWx68qhGUvIKsafT7sPTi0H9td7llwwLJ3zN
	 2xhcl3Ggs+NUWFas5e8Dr4FOPgy5dgEuZ6ECdLj2jYqaZSvEQucj8s+BN89OlFVToslHs
	 yRzoznBqcXrMEuPY7REaUAtuDqg+dV08Enqhree5Bp6lTcBmK0mZtoaPfDTVixq5m/SGz
	 75ySSl6hxfBRRNHsJY2vaUBLZeMYEMu0DyC0AoIjTA9+jL7dxLC9DBEr9dyy0DX5+gQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793893039;
	bh=bdFrpdLxoB4aAzNVJJf4jm1NkDBMimgM+MvnRlKEGQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZYoICiULFZDLxjjrqMGx51PMrYjqAQwPpdcuCi5XNZopm4F+lHPzXDvEkTQhNXGT
	 DuiPbmYbTJl3QZpKjCrczV1z8rPaQhqa3ut99tHMmHCnmVYtcW046t9C7UTjjh67NQ
	 zQWesVe9EKtxrY/th3EvH0V+ILDg05NsAzroypQxfwfhADrHC88qja0yOz3ZRetl9t
	 RdIg3PlEJciCm3Zcfv4EMg41y/HcCIQIXTQNUK4wroseG9VOGKgUjDZGcR7mWB3Pu2
	 Y+mFMECxd+YZpSdVnfc2QwOFtzL5NOqSPI8uakrp7t/J2J/Jla+/TGD8dEgkM2avVw
	 LW60ey2lvd1rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFF2C80BC4;
	Thu,  5 Nov 2026 15:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9334FB00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83E434087C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34DslOYuSNV4 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 15:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00D9D40877
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::9;
 helo=mail-wm2-x09.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EhEpuROz
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00D9D40877
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:37:13 +0000 (UTC)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-4a1bc9520fdso5396435e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793893031; x=1794497831;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bdFrpdLxoB4aAzNVJJf4jm1NkDBMimgM+MvnRlKEGQA=;
 b=EhEpuROz5E6+UGWLJgSBaFttCjJboDg91ys9Ihc5lZzO/AJG2e6ZGEQlJGZi4gPBui
 PS2ZXzd83jHdgpDj+3kXCQUnFoiot5Q73/6QRy+R4XxJv9uWj4JNr6orYl0odgLu7Lx+
 7y4khwFgdTsxUMxvS0EYjGycl70siYv/ugCn3dHEoRW8dMico13jQQMr3nixQsFhTGFm
 qapCUvYjdYtBWU5kH3orR/mFfiTRziG5h1smBedaX4PsIrMCUK86ekQMz+kS7mAAAkHQ
 Zp+pUmRNAS6/EdqPrFxHzLt8fjAXRvqN+RI3lbAw3PmTMtTXUMrmUv2YXWtZAPw0BvfW
 F4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793893031; x=1794497831;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bdFrpdLxoB4aAzNVJJf4jm1NkDBMimgM+MvnRlKEGQA=;
 b=TUnjBHLgZR1uforb+NLFe/9+pTQ5KxWxcOomUWn9RRa5EILDWrTz3wZtQ/AKH9pVrq
 AsG/ulJy7I/06STbK8yJ6QaZtbNGudYxoxOfC5hrrKIOaJY/JexiTlvu4PGO89nO/5nV
 xGWf8TtEBXHNeVaPZjadzR3dtC0p+PD7l32gatsFgf6JHcluk7MRR9wzJgxK7PB731Pf
 EmS+1PYgGNKM8VHF4ajWVfLx0P1tq1jWHeGzR7970ikyPKgE2tnNLhZ378wNz+F1lhDq
 NFwj7rJauwnt8yzhRvzShRlwcqJNDAWnia0Xl1oqglGpCPFknXrI7KB1n64Tr1C0Vta3
 lGsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVqHkqoLDr3pfzwHuy1MVfJIohHjQ3R+S+sm5gEAkKfHaDUgdx1QCERDK4aMEhwfUX82kkk2Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8NT5kk1Nwqu5lCYOopZ3y1J6/za9DoAGqvvYz9gfkQ5Hc70u/J
 H7k9iADLRdbel2FeT8iJCuIy0UEki8ma2Zc9Ymk4VbZbnkDTTzkH5txOR3w7lebjTgI=
X-Gm-Gg: AYBFou3iQLotJ7NlhLHxb8yZAPmkBI46gX8pFfgJC7LYwIk/ZVIsLkQRgYerDte+sZp
 c+0qiYH9H70yYlcKnnTARlIDAgYMtIX8tJ8H7n1KyK+pBMrIErwjqiKvUt803vxrR83WkAXjt/L
 QJKAkwPBdLLYo0heteBJU/vI5dLDBlp4kqIeDAkdiokfJ4CRGxFftZbcen1pjGi/VCV62VOebKW
 VWtVtphPtlcn7pF5M5moX8DDilEjKfeljw/zAVtx07m8PXrJ22dUgCvimwiU2FebrPO5zBPVOcy
 Ao6fu2IL+gS47kOcsPGxZfELnAuHybXHIeFZOdS8jhbJHQF92mbacrTT+Ye0Q7rpAUnMeb3q39d
 87mT9MtnpxHMGR0ygPdWSgSN2O3QjyuGJRuQYAx1O+iv/iMAXHphaQZRj5lMzYvKv3kR13WZUYk
 UZzG7bsvqEt/CqU08V/9CrSj35/Eq5lDir2fGa0ZwFWkczYOFHR2IuaNbo7xPT2yaqodJkHi3FQ
 +33HDZdM4qe00cs185SmQ2/Q6LaxyhBoL9KmMjRcV2OaksyTwykPyx6QXwEbTmZsvlbcp8g/V+D
 rJ4/lNW1hs/KhwfOscTuVvLkDRTMREo82J7WcdxZqSKJf/P1y1Qw12UCZCekjI0OefH6CmhTrzU
 pivKrjzVNrcQC/Q==
X-Received: by 2002:a05:600c:a49:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4ac177539eamr445004075e9.14.1793893031231; 
 Thu, 05 Nov 2026 07:37:11 -0800 (PST)
Received: from [192.168.1.37] (p5b29ebc8.dip0.t-ipconnect.de. [91.41.235.200])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56fca22f4sm120869025e9.13.2026.11.05.07.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 07:37:10 -0800 (PST)
Message-ID: <46f06b0b-33ec-4114-8975-84922604aca6@linaro.org>
Date: Thu, 5 Nov 2026 16:37:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Qualcomm Firehose flashing protocol support in U-Boot
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 ricardo.salveti@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 andersson@kernel.org, nicolas.dechesne@oss.qualcomm.com
References: <CAPzfCAaR_oeEQW61U9Pf0ahS3pBm=tcMPbDeXQeoKffMB_vWQQ@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAPzfCAaR_oeEQW61U9Pf0ahS3pBm=tcMPbDeXQeoKffMB_vWQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+u-boot-qcom list

On 04/11/2026 16:57, Igor Opaniuk wrote:
> Hi all,
> 
> I'd like to run an idea past the U-Boot community before writing any code.
> It touches the USB gadget layer, block devices and a protocol U-Boot
> has never spoken, and I'm sure your feedback can save us from wrong
> turns early on.
> 
> Some background first. Every Qualcomm SoC has an Emergency Download
> (EDL) mode in its boot ROM (PBL). It is entered when no valid
> bootloader is found, or on request (button, test point, reboot
> reason). In EDL the SoC enumerates on USB as 05c6:9008 and speaks
> Sahara, a simple protocol for uploading an image into On-Chip RAM. The host
> uses Sahara to upload a "programmer", a SoC-specific
> Qualcomm binary (prog_firehose_*.elf) that sets up DDR and storage
> and then serves Firehose. Firehose is the actual flashing protocol:
> the host sends small XML commands (<configure>, <program>, <read>,
> <erase>, <patch>, ...) over USB bulk, the device answers with
> <response value="ACK|NAK"/> and <log/>, and sector data goes in raw
> binary between them. This is how Qualcomm boards are flashed in the
> factory and unbricked in the field with qdl [1].
> 
> We are moving Qualcomm boards to an open boot stack: after the stock
> XBL, TF-A (BL2/BL31), OP-TEE and U-Boot replace the proprietary TZ
> and UEFI stages. The Arduino UNO Q (QRB2210) PoC boots this way,
> and the platform support is going upstream in each project. With
> U-Boot in the boot chain anyway, we'd like to reuse it as the
> programmer image too, instead of shipping a separate closed one. The
> code that boots the board would then also flash it.
> 
> Hence this RFC, before I write the code: would a Firehose server in
> U-Boot (a "firehose" command) be welcome
> U-Boot community, so that the existing host tools can flash a board with
> U-Boot as the programmer?
> 
> Why not fastboot: Firehose works on raw storage, not on named
> partitions. It addresses any physical partition or UFS LUN by sector,
> creates the GPT from scratch (rawprogram/patch XML, sized to the
> device), provisions UFS, reads back and verifies with SHA-256, and
> selects the boot partition. Qualcomm's build and factory flows already
> produce these XML files, so a board flashes the same way from EDL or
> from U-Boot.
> 
> Two ways in:
> 1. Recovery, as snagrecover does it: the PBL loads a DDR-init-only XBL
>    over Sahara, that XBL loads U-Boot, and U-Boot runs the Firehose "server".
> 2. From an installed U-Boot, like ums:
>      => firehose 0
> and then on the host machine:
>      $ qdl --storage emmc <devprg image> rawprogram0.xml patch0.xml
> 
> The first version covers configure/program/read/erase/patch/
> getsha256digest/power over the blk API, with eMMC hardware partitions
> as physical partitions. UFS provisioning would come later.
> 
> Main concern is XML. Firehose only needs one element per document,
> with attributes and no nesting:
>   <?xml version="1.0" ?><data><program A="v" ... /></data>
> I'd write a small in-place parser for exactly this subset (about 150
> lines, input capped at 4 KiB, sandbox tests with malformed input)
> instead of importing a library.
> 
> Questions:
> 1. Is a Firehose server acceptable next to ums/fastboot/rockusb?
> 2. Is a subset parser like this OK, or would you prefer a generic
>    one in lib/?

Sounds great, dfu/uuu are also similar in goal. Having U-Boot images we
can boot through EDL in any form is a huge step. A firehose command
sounds like the right approach.

Please be aware that patch descriptions, cover letters, etc should be
written by hand, LLM prose is noisy and hard to parse, it often leaks
irrelevant context.

> 
> 
> Thank you for your comments
> 
> Best regards,
> Igor
> 
> [1] https://github.com/linux-msm/qdl

-- 
// Casey (she/her)

