Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69F1E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8D780325;
	Mon,  9 Feb 2026 19:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ywG3H25g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF618341A; Mon,  9 Feb 2026 19:45:07 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBAD80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so3260694f8f.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770662703; x=1771267503; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWXSoWI3XNqVxzkhVccgILKsQY+ghyeTGa/YNiEaRDQ=;
 b=ywG3H25gN8m91B0Puvd/c4K9tV6zbr6GVqYqGDFAOx6m4rEL9NzFYaO0ZpgObZvKPC
 /SpLDbh8IRrCuGFMR5BLDFag8AaerLwHxYE5g6dwRK0hmEzMd8RQ5QvHmdV29Mn9pzst
 iVS5A296qS81Dd2JSjN8wJhwFhYKYz3YRMoxeYnNKXlpfmzf1mJCqsbqf5fDx9t/hR91
 k2BoR53pYvUwofxghp2PLD9RpLgNsUFUhbPHLj3pvXeZ+KDp1O+VxKCk8aeJ6FhmF/29
 2+JaJTNn/jIGu/HTbYpjlcBSpJnNVhH4sgEUTiJqFjuSgateSONXPLSUmE1jGHmp26Bp
 of/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662703; x=1771267503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AWXSoWI3XNqVxzkhVccgILKsQY+ghyeTGa/YNiEaRDQ=;
 b=w1k8xNqga48yMUoEAW5lflvXfytIynNfzKt356DotATjjeVx21SL5Ru9Y/EQSs41Uk
 nRtSF6oaOfM1bTxCCaLxFae07+Vud6UuR/HO9hS0T/9sBcps6b4/AVW9lvFz+MeoguU7
 hiefykKezN6FLf+6VWsa9u6vvFb1OHcU0AtyzsiH9ry04aPNYG4PYx7/Ou8H4M419ac7
 ryZmgN6lQ9DYdou3quf6WhNadeCAx7xGzX8dbiFZrV5vTUqPxOy60XOlrSprr3NRZfzT
 jf81qZzbIeHCZT4DX3YrJuGMSzCQFQ5j0/f2x1JhuNcFucYiEziFiLkcBDqjVfx0RaHG
 QDkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMXO5IYNsUgJi269iYC9IlH+k0saJI8oFdaQTTonJgarSYfr/8GR20epuzzlzMcrU0RSfQhZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwgCvGDL78l1DE98AWiSqZT1jt+clQkQzGbIbEDsQvJIu3QU8NP
 lkiWiKSK6KShPSOIExylzkO887Y+vePSgrISG50EMaSZcsyiDmjphdXur8MP7rITPvI=
X-Gm-Gg: AZuq6aIjUSlWg2WbeEYG+Jne45W3v5NJQ+6G5BRZ4D2p2l2DbcZY+19wQ52TQkvZkfs
 ExXjpKXimdWaksGJoQ4JWMs20Vh0yLvsaK58acpLPy2iHPbj8U7esRmxC5RGxDv0voFMkp10ek4
 2DOKh4+WNnHSUJmKES8ln6i9pT2pLmtxaxOSJ50x2/8IW4wPFY7hL0JJooticUJ4G1vwgYwoEJE
 mn01FeC14rSBhWbqAnA/dwF9zNift8ddqAK8EuWlXU1vME8aELcpSfufj496OYTJRCCn9sIpQvc
 Rqyy+ABY6bHN58qqcfcoAtK35A42g2NNtOZzKeP5vDp/foYmKUmVZUC87sJkiv1Zy2I6qc+M5BJ
 BtGMVJQiknZlEA8oGatMLlywGJCr4MU1mgMxo3jqHrIwUwNZmnJGRjuI0+ZCGeqXmXv7Wvx9Cyz
 yS8gl0/74zRtuwTnRfhVb+x38C0PZE58W4QPGn2Ck/4FUyQk57QA6a3yF28fuv
X-Received: by 2002:a05:6000:200c:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-437791a3644mr713010f8f.21.1770662702959; 
 Mon, 09 Feb 2026 10:45:02 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2110sm28835138f8f.3.2026.02.09.10.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 10:45:02 -0800 (PST)
Message-ID: <6f12cae7-1dd3-4367-83d0-d35624dbfa4d@linaro.org>
Date: Mon, 9 Feb 2026 19:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 28/01/2026 12:43, Marek Vasut wrote:
> On 1/28/26 5:41 AM, Heinrich Schuchardt wrote:
>> Am 28. Januar 2026 00:48:40 MEZ schrieb Marek Vasut
>> <marek.vasut+renesas@mailbox.org>:
>>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top
>>> even from
>>> same bank"). These are based on incorrect premise of the first
>>> commit, that
>>> "U-Boot does not use memory above ram_top". While U-Boot itself
>>> indeed does
>>> not and should not use memory above ram_top, user can perfectly well use
>>> that memory from the U-Boot shell, for example to load content in there.
>>>
>>> Currently, attempt to use that memory to load large image using TFTP
>>> ends
>>> with "TFTP error: trying to overwrite reserved memory...". With this
>>> change
>>> in place, the memory can be used again.
>>
>> IIRC there are drivers that have issues with memory above 4 GiB and
>> boards that artificially set ram_top to 4 GiB to work around these
>> issues.
> 
> I thought I had all of those solved, but apparently not, please read on.
> 
>> We need to carefully consider why the reverted patch was introduced.
> 
> I didn't find much on either commit. I believe the premise on which the
> original patch was introduced is wrong, cf this commit message. We
> should allow U-Boot to access the memory above ram_top, we should not
> allow U-Boot to use it for its data structures because of the possible
> 32bit DMA limitations.
> 
>> Why does your board use a 4GiB ram_top and not place ram_top at the
>> physical top?
> Originally, I thought it was only a remnant from the past which kept U-
> Boot and all its data structures, stack, heap in the first DRAM bank in
> 32bit space, so I tried to remove that. It turns out there are still a
> couple of problems that have to be solved to make it possible to
> relocate U-Boot fully into the 64bit space.
> 
> The first one is the standard parsing of DRAM size / ram_top / DRAM
> banks order in common/board_f.c , which probably hides a lot of issues
> on various boards, pretty much what you wrote above. In short,
> dram_init() only sets up gd->ram_base and gd->ram_size , which is often
> the first continuous DRAM bank which is in 32bit space. The follow up
> setup_dest_addr() uses that information to set up U-Boot relocation
> address at the end of that first continuous bank. And then
> dram_init_banksize() parses the rest of the DRAM banks into gd->bd (gd-
>>bd is set up after setup_dest_addr() is called, in reserve_board()).
> 
> This above is fixable and I already have some clean up patches for that,
> which I implemented while writing this email.
> 
> But then I found out, that the ravb ethernet driver also has 32bit
> limited DMA, which breaks if I relocate U-Boot to the 64bit range. It
> worked thus far, because U-Boot was in 32bit space, so were mallocated
> DMA descriptors, so was the net_pkt_buf[] array (which is in .data
> section). I didn't find any other breakage thus far.
> 
> Which means, before we can really start switching boards to relocate to
> 64bit space, we need to find all these remaining 32bit limitation sites
> and fix them first. And to do that, we would need some way to force
> allocation from 32bit space for drivers which need that ... do we
> already have such a thing ? I couldn't find anything.

For some (non-upstream) Qualcomm drivers we have just used lmb with
LMB_ALLOC_MAX and passed in 4GB as the max address, it would be nice to
have a wrapper function for this.

Maybe this would just cause a whole bunch of other issues but perhaps it
would be easiest to have a config option to place the malloc arena in
32-bit memory rather than always directly below U-Boot? Then again I
imagine this is something that has been bikeshed in the past...

*casey grumbles something about making relocation optional and merging
the f/r init sequences for most boards*

-- 
// Casey (she/her)

