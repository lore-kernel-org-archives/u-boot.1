Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A48C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A9A84942;
	Tue, 30 Jun 2026 10:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V+XXLIlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A3B84857; Tue, 30 Jun 2026 10:13:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8477B84857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 16D833F29B
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782807185;
 bh=cgRkLnOiW6rUGId9W4whwr7F9Mni0rMVrkv5D66nBR4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V+XXLIlfGc43TWyxBoZTe5CYdnrSU+fRS/yeLWkXZOoUgnFIn72CD8uA6Qe8jpVbg
 Ms/vgvcWl6iVlIhFmlYtuEQzTET2iw1XiF6b91PNoHqSYJgrM9JFad6qpddTyJ18aD
 82/Nc28FzgylxtlpK0SnKSj7KVwq2EtQOwWfYBcw0iC5F8F0MwTQnGZMO5zeBl5rBX
 a3dqc6yJy7T0R0eyBkhURbz/eCPaE0u/hylZv2dAYkDCejbA/agUad3YHYiiDHO7eY
 SLC+CMZqBtvRFybXvrR3ZXMmY3FGa9GzR9hmb1A3byJ1qM1EWQ8bk3CKYCF9IEgLA6
 csyR9ClggLU4fjm0BLAQMVVUBjZZ5ZR0ktBrh++6qwT1WYQmxHLeiR8idvIbrv4mi1
 nqIeUHTHzf38lojqYSCG7gts6NveFbYFJHa6FBFTIs7MWHjBgeaP3H8kqQRJezDGMi
 YMXK9ZPUhL1uo18Yx+AhIHl7M3wRvRyFTHng6O5wZhkPyE0RKL7Yx//3RVT2VEAYlS
 KeF40JnSdmpwvwdDS48ow7cwMwMpkbb6t6hh/Kux/cqJFHNRysJtCMuv16nVJuDua4
 rVTvo0sUh8l+toH01kjfI1Q/oZLSqXRu+1IZkttu/Z6Saiya9fuMSFqTH+Ob2pJiwl
 5aFFCJ/gxFQBEf/GCgJJXgqA=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-492488f8583so44900045e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807184; x=1783411984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgRkLnOiW6rUGId9W4whwr7F9Mni0rMVrkv5D66nBR4=;
 b=ak9HbneMuf38IZJMMTRRwxasjTkrsL9R9cYX+wtb1RHZ/veATy4de+aznu+vRwsZBa
 HK1e5BJhyTt1hxWOsZf6wuh2zn6hJ3MBx1j5tzAf+1zZ8X3P3exFbEFMVB6+TNaNcwP2
 UAb34+uLkFCgukS2UCcXBVxFHCvmgweZJga1UXWl4xLFxBqb5haXxQue/xcbrXtiljUl
 fJfwNhzphIpKu/3PRZ9e+wCt5vtLB+w4SN+LE/7Uf2uFD8HvPwqJZwZQ+BjXcvPv4fyW
 v6ujLy6RBBuMwSmega4q+RZWPZb4dJwLN86aUTwoqO1Ls8xzTxrfAcoKvmuupaPEb5Ar
 ehKA==
X-Gm-Message-State: AOJu0YzT1bkSfFQ1Gear/wCL9k3kHUgHKCl+gFLDzL480KPSMv80aUb5
 EAWQbyvZf/wqLEpbLoeUgzttSerXcmXIMX4If+eRSqKDH8E+FTGPyb4HoHnojVbWmu6Dg39/xUW
 p+bnzAuTVCrftEEb1Y2lXbNXTRo/BelGR+PNTKMqFEs6hUnAfRWB7llVn2CooaR40mkJ7s9Y=
X-Gm-Gg: AfdE7cl1KrWJxVBIrj2E4Yib4lfwn96muZMLGUBCw/sLfbNdhIoZlAMAWrPcvlWKPpS
 /5YnS0Rd+Ga4W8GScICIhCb5f0jHwIerCawNcPNi7nzDi1hk8ouY860EqRcHxGH1l9rrVtz9be6
 1nPEIgpYwoew8NcTf6S62dHAsx/ddwkgHYnNhGt7U16eGuRDB+bdgwx+noAgvF7CyemDo1U3clJ
 DGkhExUuUZXhHoco2PSrud42aTmnVIaVGg1DT1Mvg0S8jvW8X/EFCiqYLDmgKfsG1TEy4EjpdUh
 Lk57ksarmi2wGjUez1XEGeVZLEDOHkOVpc3ywRMXZLJYFvj3hQ0WCvU0sl0yIgLr37zqBS+IDMJ
 dujU+ANQMJB/EOwRrsnu8NHpgL49IYgOrrE2XTlvqxDKKcq2RHx6lTah7ESeXF0ERFvDZSKRHuQ
 il/Xum6gaYGTfK163aVc32PcnRkXmoL60lPQ==
X-Received: by 2002:a05:600c:6384:b0:493:a91c:37e7 with SMTP id
 5b1f17b1804b1-493b82b8699mr38979175e9.28.1782807184580; 
 Tue, 30 Jun 2026 01:13:04 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:493:a91c:37e7 with SMTP id
 5b1f17b1804b1-493b82b8699mr38978815e9.28.1782807184131; 
 Tue, 30 Jun 2026 01:13:04 -0700 (PDT)
Received: from ?IPV6:2a02:3035:629:e595:43db:7f0b:35ce:552f?
 ([2a02:3035:629:e595:43db:7f0b:35ce:552f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cb62f1sm86541805e9.15.2026.06.30.01.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 01:13:03 -0700 (PDT)
Message-ID: <1ba87236-f914-4ac6-aee7-59255e23a015@canonical.com>
Date: Tue, 30 Jun 2026 10:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] efi_loader: fix buffer overrun in
 efi_sigstore_parse_siglist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
 <20260629233514.211746-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+4jPsbgEJ=eAabzMO=xZSyNM0nQxb=UbXa=HykaKJASA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+4jPsbgEJ=eAabzMO=xZSyNM0nQxb=UbXa=HykaKJASA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/30/26 08:23, Ilias Apalodimas wrote:
> Hi Heinirch,
> 
> 
> On Tue, 30 Jun 2026 at 02:35, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> In efi_sigstore_parse_siglist() sigdata is allocated. But instead of an
>> allocation matching the size of sigdata, tainted external data was used
>> to calculate the allocation size. This may lead to buffer overflows.
>>
>> * Correct the allocation size.
>> * Follow the man-page. Use the structure size as second argument for
>>    calloc.
> 
> I think the fix is correct, but the commit message might be misleading.
> Looking at the values sizeof(*sig_data) is 40b, but the
> esl->signature_size - sizeof(esd->signature_owner)) is way bigger and
> depends on the actual signature size. So I dont think something bad
> really happens apart from wasting a few bytes of memory.
> The actual point of the signature size is correctly allocated a few lines below.
> 
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> With the commit message updated
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

I am using qemu-riscv64_smode_defconfig plus these additional setting:

CONFIG_EFI_VARIABLES_PRESEED=y
CONFIG_EFI_VAR_SEED_FILE="../ubootefi.var"
CONFIG_SEMIHOSTING=y
CONFIG_FIT_SIGNATURE=y
CONFIG_EFI_SECURE_BOOT=y
CONFIG_FRAMEPOINTER=y

These are the values that I see in efi_sigstore_parse_siglist() for a 
signed binary that sbverify can validate:

esl->signature_list_size 44
esl->signature_size 16
sizeof(esd->signature_owner) 16
sizeof(*sig_data) 40

So the allocated size was 0 before the patch.
I think that matches my description.

The binary signature can be verified by sbsign.

This is the content of the certificates table in the EFI binary.

00000000  a1 09 00 00 00 02 02 00  30 82 09 95 06 09 2a 86 
|........0.....*.|
00000010  48 86 f7 0d 01 07 02 a0  82 09 86 30 82 09 82 02 
|H..........0....|
00000020  01 01 31 0f 30 0d 06 09  60 86 48 01 65 03 04 02 
|..1.0...`.H.e...|
00000030  01 05 00 30 78 06 0a 2b  06 01 04 01 82 37 02 01 
|...0x..+.....7..|
00000040  04 a0 6a 30 68 30 33 06  0a 2b 06 01 04 01 82 37 
|..j0h03..+.....7|
00000050  02 01 0f 30 25 03 01 00  a0 20 a2 1e 80 1c 00 3c  |...0%.... 
.....<|
00000060  00 3c 00 3c 00 4f 00 62  00 73 00 6f 00 6c 00 65 
|.<.<.O.b.s.o.l.e|
00000070  00 74 00 65 00 3e 00 3e  00 3e 30 31 30 0d 06 09 
|.t.e.>.>.>010...|
00000080  60 86 48 01 65 03 04 02  01 05 00 04 20 e7 83 44 
|`.H.e....... ..D|
00000090  22 21 6d 97 f6 ff d8 09  d6 d7 4f b8 ff 9c 55 37 
|"!m.......O...U7|
000000a0  fa 20 ee b0 f9 3b b7 a0  26 6e 2e f0 5b a0 82 05  |. 
...;..&n..[...|
000000b0  87 30 82 05 83 30 82 03  6b a0 03 02 01 02 02 14 
|.0...0..k.......|
000000c0  01 f0 cb a2 e7 83 e4 dc  e3 a3 b6 3b 25 f6 fb 06 
|...........;%...|
000000d0  75 b1 09 98 30 0d 06 09  2a 86 48 86 f7 0d 01 01 
|u...0...*.H.....|
000000e0  0b 05 00 30 3a 31 1a 30  18 06 03 55 04 03 0c 11 
|...0:1.0...U....|
000000f0  4d 79 20 53 65 63 75 72  65 20 42 6f 6f 74 20 43  |My Secure 
Boot C|
00000100  41 31 0f 30 0d 06 03 55  04 0a 0c 06 4d 79 20 4f 
|A1.0...U....My O|
00000110  72 67 31 0b 30 09 06 03  55 04 06 13 02 44 45 30 
|rg1.0...U....DE0|
00000120  1e 17 0d 32 36 30 36 32  39 31 38 33 37 35 39 5a 
|...260629183759Z|
00000130  17 0d 33 36 30 36 32 36  31 38 33 37 35 39 5a 30 
|..360626183759Z0|
00000140  43 31 23 30 21 06 03 55  04 03 0c 1a 4d 79 20 53 
|C1#0!..U....My S|
00000150  65 63 75 72 65 20 42 6f  6f 74 20 53 69 67 6e 69  |ecure Boot 
Signi|
00000160  6e 67 20 4b 65 79 31 0f  30 0d 06 03 55 04 0a 0c  |ng 
Key1.0...U...|
00000170  06 4d 79 20 4f 72 67 31  0b 30 09 06 03 55 04 06  |.My 
Org1.0...U..|
00000180  13 02 44 45 30 82 02 22  30 0d 06 09 2a 86 48 86 
|..DE0.."0...*.H.|
00000190  f7 0d 01 01 01 05 00 03  82 02 0f 00 30 82 02 0a 
|............0...|
000001a0  02 82 02 01 00 c6 1c 87  6a 06 5e 10 2b f8 6e 67 
|........j.^.+.ng|
000001b0  d1 99 23 0a 7c 33 63 8f  fa dc 11 b5 06 7b 3c b4 
|..#.|3c......{<.|
000001c0  27 e5 7d 68 9e 1d 35 c4  b6 1b 59 31 7b 5b b6 03 
|'.}h..5...Y1{[..|
000001d0  5f 57 68 61 dc 5f 0b f7  ba e8 77 4f 06 11 e9 3b 
|_Wha._....wO...;|
000001e0  18 c5 23 b3 9d ea cb 75  66 00 e8 8e 8e 18 7c 5d 
|..#....uf.....|]|
000001f0  71 61 03 bc c1 86 b2 62  1d 83 e8 35 28 c2 56 af 
|qa.....b...5(.V.|
00000200  e6 b2 83 16 fd 77 3a e3  bf 7b 93 82 2e 3c 23 4f 
|.....w:..{...<#O|
00000210  89 86 28 a6 bc 25 02 1b  35 94 9e 03 56 53 a0 ef 
|..(..%..5...VS..|
00000220  6f b6 5b dd 40 0c fc 5c  ec dd e2 60 f4 87 74 c5 
|o.[.@..\...`..t.|
00000230  9a 4e e5 b8 fd da 9b fa  9c d6 a7 69 7a 9e 6c 35 
|.N.........iz.l5|
00000240  82 ab db 58 65 17 ee d8  ba 17 6e 6a 4b ca 1a 4d 
|...Xe.....njK..M|
00000250  4b ed a0 d3 ad 6f f4 42  0e f7 b9 76 8d 37 09 d8 
|K....o.B...v.7..|
00000260  16 b3 fe a2 20 ab c9 64  a8 72 e4 5c d2 e6 ee 0a  |.... 
..d.r.\....|
00000270  9c 29 9d 31 79 49 c8 73  62 4d 52 ce ec 4e c0 17 
|.).1yI.sbMR..N..|
00000280  06 09 88 5c 93 8e eb 80  ca 4f ad 14 7c d0 2b 82 
|...\.....O..|.+.|
00000290  04 aa 9f f4 24 e9 f1 3d  b5 d3 4c 58 4a 9a 7f b3 
|....$..=..LXJ...|
000002a0  36 66 a1 67 c1 d2 1c 96  92 12 77 d7 b7 41 04 a2 
|6f.g......w..A..|
000002b0  1e 23 17 d1 77 b5 47 c2  a5 bb 2d 8d 64 16 35 9c 
|.#..w.G...-.d.5.|
000002c0  b9 d2 f8 31 f9 a0 41 25  93 f2 52 88 47 c9 93 a7 
|...1..A%..R.G...|
000002d0  37 6c 51 fe e6 cb f1 90  f6 f3 e8 a2 f6 27 83 10 
|7lQ..........'..|
000002e0  de a1 28 17 30 0d 6e 80  d4 67 9a 5c 8b ea a1 54 
|..(.0.n..g.\...T|
000002f0  7c 89 88 63 f7 5a 21 2b  59 b5 15 b8 16 71 4e 1f 
||..c.Z!+Y....qN.|
00000300  00 ae c8 ce 39 ba ff 8f  91 b9 57 76 4a cf a0 54 
|....9.....WvJ..T|
00000310  25 b1 6a 06 d3 43 e1 65  59 c7 3f 60 14 5f 45 e4 
|%.j..C.eY.?`._E.|
00000320  56 b3 80 04 cd fe d3 dd  bc 49 46 d6 d9 ed 78 af 
|V........IF...x.|
00000330  ec 5c ca dc e8 85 d5 a9  46 fe 94 bb 98 88 ec c8 
|.\......F.......|
00000340  24 ad b5 7b ed e7 f1 70  ac f4 42 48 bd a1 98 57 
|$..{...p..BH...W|
00000350  9d 42 29 73 45 5a 00 72  a5 d0 d8 76 dc d1 0a 09 
|.B)sEZ.r...v....|
00000360  e6 57 38 05 e5 35 f6 96  79 20 3c 61 f0 3b d5 7b  |.W8..5..y 
<a.;.{|
00000370  75 6a 20 bb 38 df 92 c4  16 dd 80 b3 f0 1a 60 da  |uj 
.8.........`.|
00000380  a6 90 f5 4a e0 9d 0b 1b  18 73 84 b0 73 9b b3 3a 
|...J.....s..s..:|
00000390  24 e1 54 83 70 30 f6 6c  b2 c9 41 24 2f f7 08 e8 
|$.T.p0.l..A$/...|
000003a0  54 1e 55 0c 8f 02 03 01  00 01 a3 78 30 76 30 0c 
|T.U........x0v0.|
000003b0  06 03 55 1d 13 01 01 ff  04 02 30 00 30 0e 06 03 
|..U.......0.0...|
000003c0  55 1d 0f 01 01 ff 04 04  03 02 07 80 30 16 06 03 
|U...........0...|
000003d0  55 1d 25 01 01 ff 04 0c  30 0a 06 08 2b 06 01 05 
|U.%.....0...+...|
000003e0  05 07 03 03 30 1d 06 03  55 1d 0e 04 16 04 14 34 
|....0...U......4|
000003f0  3c d5 b3 ca cd a4 fc 53  25 8c 7d eb b1 a6 54 99 
|<......S%.}...T.|
00000400  1c b2 a0 30 1f 06 03 55  1d 23 04 18 30 16 80 14 
|...0...U.#..0...|
00000410  51 a9 1f 87 2a 8d 36 2c  7d 8a 2f 42 4c bc 1d 5e 
|Q...*.6,}./BL..^|
00000420  f7 40 c0 df 30 0d 06 09  2a 86 48 86 f7 0d 01 01 
|.@..0...*.H.....|
00000430  0b 05 00 03 82 02 01 00  35 f2 a2 5c ba e7 66 6b 
|........5..\..fk|
00000440  ab 4c 24 3c a1 8c 99 62  61 2c 66 5c 89 4c 34 c4 
|.L$<...ba,f\.L4.|
00000450  9e 8a d5 99 d7 32 4c ff  0e f1 3a b5 f1 0b b9 10 
|.....2L...:.....|
00000460  8f 10 ba 64 64 d9 36 33  14 a2 92 60 e6 e7 b2 e0 
|...dd.63...`....|
00000470  2a 1b f8 19 1e 88 82 70  9e 65 77 ce de 52 4b b1 
|*......p.ew..RK.|
00000480  65 f6 9f 03 ba 6e 02 c1  35 82 3c 76 be 2d 14 7b 
|e....n..5.<v.-.{|
00000490  d7 1f 76 67 3d 5d 03 b2  4d 8c c7 b6 ce c3 3d 06 
|..vg=]..M.....=.|
000004a0  a4 e8 e3 ab 4d 49 ac 09  65 60 50 93 63 16 4a 40 
|....MI..e`P.c.J@|
000004b0  cc 45 8a 0b 3f 48 5c f7  fb 87 06 a9 de d6 45 a6 
|.E..?H\.......E.|
000004c0  2e 49 e5 01 e0 f1 22 23  e9 83 6e ea 16 25 b1 8e 
|.I...."#..n..%..|
000004d0  e8 8e dd 1f 3f 21 5b 27  cd d6 0f 1b 48 8c e8 43 
|....?!['....H..C|
000004e0  0b 51 c5 a2 17 d4 a6 9c  e7 bd 12 ea 77 7c 74 0b 
|.Q..........w|t.|
000004f0  8e c9 fc 8e a3 c5 6a b7  27 3f 4b 56 64 c0 d6 4f 
|......j.'?KVd..O|
00000500  a7 64 d1 93 0a 0f 80 92  54 6f 69 83 3b 3d 66 97 
|.d......Toi.;=f.|
00000510  df 6d d9 84 b0 9b 69 23  48 0f 16 36 be 69 8a a0 
|.m....i#H..6.i..|
00000520  4f bd 5f d0 1c fe f0 c6  ee 85 2a 79 ac 41 d7 7c 
|O._.......*y.A.||
00000530  8e c2 f5 31 54 7b ba 47  ee 8a 97 13 77 a2 62 24 
|...1T{.G....w.b$|
00000540  88 a7 8f e1 13 c0 4a b7  c8 8b 0b e1 80 73 13 4e 
|......J......s.N|
00000550  e0 bd c5 0d 20 eb 95 f3  b7 10 41 d1 91 27 c0 f4  |.... 
.....A..'..|
00000560  34 81 e1 73 83 b7 11 05  8a cb 99 72 f2 d1 1f 16 
|4..s.......r....|
00000570  5c 91 cb 66 e1 77 76 f5  8d 1f 22 08 9c d5 ba 4b 
|\..f.wv..."....K|
00000580  e9 b7 20 08 bb 5a 72 bf  b6 b8 04 12 15 fd cc 90  |.. 
..Zr.........|
00000590  61 22 f7 1f 38 7e 81 63  c5 84 31 3d 8c 55 7d 77 
|a"..8~.c..1=.U}w|
000005a0  ca c2 8e b3 53 4e ee 14  e0 68 f2 4e 7d 3d 0c e5 
|....SN...h.N}=..|
000005b0  eb 39 1e 05 32 40 5d 83  6d 98 c1 d6 28 76 4e 14 
|.9..2@].m...(vN.|
000005c0  25 02 80 d5 39 f1 bf 42  f0 dd 2c 82 00 00 8d c2 
|%...9..B..,.....|
000005d0  0a a8 27 c8 9b b9 c9 18  19 38 84 9c 06 a6 27 a6 
|..'......8....'.|
000005e0  94 4a 6b ff a3 3f 74 08  d5 30 95 99 97 0d 40 93 
|.Jk..?t..0....@.|
000005f0  40 21 7e 07 b8 57 d9 4e  da 0e 8d 9c 5a 18 eb 36 
|@!~..W.N....Z..6|
00000600  0d 93 84 6d 8e 26 c3 22  80 0f 81 ff 43 95 a1 31 
|...m.&."....C..1|
00000610  96 a5 92 43 ff ec 6a 3b  7e a0 f3 63 8d 4f f2 0d 
|...C..j;~..c.O..|
00000620  65 ce 94 c7 77 ec a2 0a  e2 91 db d8 8d 28 99 21 
|e...w........(.!|
00000630  b1 e2 29 c0 9b 31 9d e9  31 82 03 65 30 82 03 61 
|..)..1..1..e0..a|
00000640  02 01 01 30 52 30 3a 31  1a 30 18 06 03 55 04 03 
|...0R0:1.0...U..|
00000650  0c 11 4d 79 20 53 65 63  75 72 65 20 42 6f 6f 74  |..My Secure 
Boot|
00000660  20 43 41 31 0f 30 0d 06  03 55 04 0a 0c 06 4d 79  | 
CA1.0...U....My|
00000670  20 4f 72 67 31 0b 30 09  06 03 55 04 06 13 02 44  | 
Org1.0...U....D|
00000680  45 02 14 01 f0 cb a2 e7  83 e4 dc e3 a3 b6 3b 25 
|E.............;%|
00000690  f6 fb 06 75 b1 09 98 30  0d 06 09 60 86 48 01 65 
|...u...0...`.H.e|
000006a0  03 04 02 01 05 00 a0 81  e5 30 19 06 09 2a 86 48 
|.........0...*.H|
000006b0  86 f7 0d 01 09 03 31 0c  06 0a 2b 06 01 04 01 82 
|......1...+.....|
000006c0  37 02 01 04 30 1c 06 09  2a 86 48 86 f7 0d 01 09 
|7...0...*.H.....|
000006d0  05 31 0f 17 0d 32 36 30  36 32 39 31 39 33 36 33 
|.1...26062919363|
000006e0  32 5a 30 2f 06 09 2a 86  48 86 f7 0d 01 09 04 31 
|2Z0/..*.H......1|
000006f0  22 04 20 46 b9 37 7f 7d  65 97 de ae 3b 8d ad 71  |". 
F.7.}e...;..q|
00000700  ce d3 2b cf 11 fe 8d ce  94 14 35 18 0a 53 4d be 
|..+.......5..SM.|
00000710  8c 35 15 30 79 06 09 2a  86 48 86 f7 0d 01 09 0f 
|.5.0y..*.H......|
00000720  31 6c 30 6a 30 0b 06 09  60 86 48 01 65 03 04 01 
|1l0j0...`.H.e...|
00000730  2a 30 0b 06 09 60 86 48  01 65 03 04 01 16 30 0b 
|*0...`.H.e....0.|
00000740  06 09 60 86 48 01 65 03  04 01 02 30 0a 06 08 2a 
|..`.H.e....0...*|
00000750  86 48 86 f7 0d 03 07 30  0e 06 08 2a 86 48 86 f7 
|.H.....0...*.H..|
00000760  0d 03 02 02 02 00 80 30  0d 06 08 2a 86 48 86 f7 
|.......0...*.H..|
00000770  0d 03 02 02 01 40 30 07  06 05 2b 0e 03 02 07 30 
|.....@0...+....0|
00000780  0d 06 08 2a 86 48 86 f7  0d 03 02 02 01 28 30 0d 
|...*.H.......(0.|
00000790  06 09 2a 86 48 86 f7 0d  01 01 01 05 00 04 82 02 
|..*.H...........|
000007a0  00 91 02 8d 91 b4 dc 55  b5 c1 19 9d 7c 6c 47 f1 
|.......U....|lG.|
000007b0  7f 13 8f af 5d 49 cf f5  32 a1 8b a7 af 03 9c 9f 
|....]I..2.......|
000007c0  8f 86 c5 fc 24 60 b6 e8  e8 14 80 ee b7 a5 a7 a5 
|....$`..........|
000007d0  cc c5 68 cf 31 20 10 87  86 b7 7f 1f e9 8a e4 1f  |..h.1 
..........|
000007e0  5b 39 37 76 0b 80 ce 03  6a 16 4d b0 da 0e a6 aa 
|[97v....j.M.....|
000007f0  3d bf 78 9f cc 1c 17 58  7c 1a bf 86 de 98 29 39 
|=.x....X|.....)9|
00000800  3e c0 55 51 44 06 ef 23  9e 7f 1b d8 6d 8b 4c 10 
|>.UQD..#....m.L.|
00000810  16 13 74 78 36 7b 83 20  85 b3 d9 f1 00 02 d1 c4  |..tx6{. 
........|
00000820  e9 1a 23 7b 0c 25 a3 80  c3 63 fa e5 aa c1 b1 c9 
|..#{.%...c......|
00000830  95 1c 21 e6 28 5f d5 dc  25 ae 0c e8 74 ae 74 b8 
|..!.(_..%...t.t.|
00000840  d4 1a d0 52 5e 64 93 d5  9b 72 6f 2a 37 e1 77 32 
|...R^d...ro*7.w2|
00000850  df f6 db ee 9a b1 92 d3  47 0a 19 ab e1 f2 52 ad 
|........G.....R.|
00000860  7f 5b b7 3f b9 c1 39 34  7c 92 5d 50 a7 f5 b3 ff 
|.[.?..94|.]P....|
00000870  03 7c 15 04 c6 89 09 be  8d d9 c3 5d db f2 5b 20 
|.|.........]..[ |
00000880  6f 5e 33 ad 7c a3 c0 3a  4d 55 c7 97 1c 3b 0a ec 
|o^3.|..:MU...;..|
00000890  7e 27 1d eb b3 08 21 0a  18 47 04 5d 1b 3d 52 a6 
|~'....!..G.].=R.|
000008a0  e0 0f f2 6b 31 37 15 8a  3a 3e 0e 00 bc 7f be 9f 
|...k17..:>......|
000008b0  61 a0 a7 60 12 4a f6 d5  a1 d4 c2 e8 ce 8a bc f5 
|a..`.J..........|
000008c0  c3 23 00 ee f8 30 40 e3  9d 3b 30 88 4a 4f f8 06 
|.#...0@..;0.JO..|
000008d0  03 1e 0c 70 32 c6 28 19  ce d4 4b 1e 5c 45 a5 19 
|...p2.(...K.\E..|
000008e0  fd a6 ee 4f 4c b6 67 ce  45 57 52 bb a1 9c 26 14 
|...OL.g.EWR...&.|
000008f0  51 01 c2 49 c2 3a e4 02  41 06 db da 7d e3 c1 28 
|Q..I.:..A...}..(|
00000900  5c ef a7 d9 42 e7 85 7a  84 57 02 2a aa 4c 54 26 
|\...B..z.W.*.LT&|
00000910  7e 04 d6 65 c4 d8 08 40  cf 0e 5a 78 77 fe 6b da 
|~..e...@..Zxw.k.|
00000920  f5 aa b0 6c 26 bc 3f 01  09 68 1e 75 72 8a 6c e5 
|...l&.?..h.ur.l.|
00000930  f1 9d 4f e0 86 54 a8 86  b6 40 d9 06 95 6e d4 02 
|..O..T...@...n..|
00000940  f2 56 99 11 98 a0 4d fb  af 3b f2 b9 d1 17 cc f0 
|.V....M..;......|
00000950  a9 6c 55 8b 7e 4b 4e f5  6c cc c1 62 5e e6 cf e3 
|.lU.~KN.l..b^...|
00000960  e2 fe e5 e9 32 db 91 56  1e 6f 65 06 d5 c1 a4 cc 
|....2..V.oe.....|
00000970  ba 1f 20 6a 32 88 fa 89  93 74 92 3f a8 8a e5 3f  |.. 
j2....t.?...?|
00000980  3a 87 4e ec 59 9f c1 b4  38 67 76 14 4f 5a a4 0c 
|:.N.Y...8gv.OZ..|
00000990  0e bd 49 6f a7 e9 8b ea  e0 f7 0e 61 57 73 27 b6 
|..Io.......aWs'.|
000009a0  c9 00 00 00 00 00 00 00                           |........|

Best regards

Heinrich

> 
>> ---
>> v2:
>>          no change
>> ---
>>   lib/efi_loader/efi_signature.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
>> index 93a4f257016..6aff5c14a89 100644
>> --- a/lib/efi_loader/efi_signature.c
>> +++ b/lib/efi_loader/efi_signature.c
>> @@ -703,8 +703,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>>                          goto err;
>>                  }
>>
>> -               sig_data = calloc(esl->signature_size
>> -                                       - sizeof(esd->signature_owner), 1);
>> +               sig_data = calloc(1, sizeof(*sig_data));
>>                  if (!sig_data) {
>>                          EFI_PRINT("Out of memory\n");
>>                          goto err;
>> --
>> 2.53.0
>>

