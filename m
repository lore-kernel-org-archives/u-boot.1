Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A03C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC6A838A0;
	Mon, 12 Jan 2026 14:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Bo3Kc0oQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4097D83CB9; Mon, 12 Jan 2026 09:36:37 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFDB83C14
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 09:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so3081405f8f.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 00:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768206994; x=1768811794; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90Or4JzG5xTqiewuaaFLRpCykZN8XVqlxqXbvsgPcaI=;
 b=Bo3Kc0oQebeHg+id+A2e/6Dtd2Qy80++LCJ+eHJvviJe4ark7hmtqINPbrof/9ZPIf
 h5QOrf6VfX6UrYSMZmk8F4n/tUawXYgsflx1HFPy5P7bBU2PC/uS1q+vveRSgo9UzW2q
 k7HESmWNtb4JGGYr+7xa9yq+6wtwczVgHi5Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768206994; x=1768811794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90Or4JzG5xTqiewuaaFLRpCykZN8XVqlxqXbvsgPcaI=;
 b=Y1GXQ8rb2t5MLM6Lq8Zpdr/CEqU9bka1H+iSh7Uj2nit+qerqyqYLJ14QrOAYsoBox
 ANxgv/YT6hl9TLbyrlP0yC1G9AXYLGg05PKag2dBJrP5yWUeyhcfj6UUgiJtyTYYtoBu
 zaxBPDF/7xNgMX0V1rgKWDwqir47QKGX1TytWvdTjLVZ6NgKkWtq+D3mAWoaYQlk8ltu
 7waSk6HuRzFg7slW9KZJLpujIT9UQtS7yTIs22st4GZvkExDXiB1OxKq/LhBZCI4k6WG
 5Gj8OC2nU+iZvzwIXs3+QLslbvvGQ+h9uLIP4dUjA3L3jswLs2PjE2oVYzjSlhYQiROG
 p8dA==
X-Gm-Message-State: AOJu0Yw6nMEpdNjVSz+8OEWxAflqz3lechddqjkepKmTvic+4TdHBbLW
 tCDJUuPAYdVv25SlciO/IAFd59QtWsyUj7rqKpx03/zYK0zOaMoTicLIvuQlXxh3w0A=
X-Gm-Gg: AY/fxX67Uh4wN7nfji0ygrahHDHgmnaMBGlCOqdBcdoGJdW/yXgtBRYIGCQ1oQmF0ON
 4moXjZI4yaeOYX+Be7cyabUv17nicolL0ATQMBMkgUeiNABYAoXU8cBLiIRtt3rgLbKKi/WdsrA
 BgAA7TkBn+Jh1VOgvQkmjA9tqidQDjGCzaBymsSuL/acgXkL6TqrqO85Mv8fnD+3PMsgH4LWI+X
 y7eckb5R3/ickJ9G1xH8dhMt0p1hRphUKVweVkSNc/d0DGv3m5ktU9+GLCGGhpUrgeIGzGQIOG0
 uGm5TxYvdK4y7P/RB12PKxu/szU7Obw32EfydR08C4xPVQJlmwYKHM49y3GwN8jvAnd2w4G3lA6
 0K76FXTBUwneVGpZH8rA7cU9MxDUuVNFFvPIzxVtG6cBLR0bvtzTECqImaKl2D30oNfgAAhqqzc
 xUtDLqS1DFdBS/P9F1VCH9nXkMOzGKi1+zi4zy1DFkUQTgwL4=
X-Google-Smtp-Source: AGHT+IG7Aaq7radxxUEgGP/RlZ0Z3OXJo95CcxT7oX3lXfiy8hpqeINvJCgsyoIZ5/i5keUL+jK5NA==
X-Received: by 2002:a05:6000:2c0e:b0:432:851d:2180 with SMTP id
 ffacd0b85a97d-432c3760f55mr19231810f8f.49.1768206994537; 
 Mon, 12 Jan 2026 00:36:34 -0800 (PST)
Received: from [10.1.14.153] (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm37084450f8f.33.2026.01.12.00.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 00:36:34 -0800 (PST)
Message-ID: <4fa188fe-2ed8-4570-b778-c4c1ad267950@streamunlimited.com>
Date: Mon, 12 Jan 2026 09:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cmd: mtd: fix read failure on default full partition
 read with bad blocks
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Radek_Dost=C3=A1l?=
 <radek.dostal@streamunlimited.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
 <722abb2d211a68f8a6867b2e03186245a443fbb9.1765892031.git.peter.suti@streamunlimited.com>
 <CAOf5uwkGN07wjgMPjpRCByUFKU2Wf0H9dm6q966GGkO3FBT9nw@mail.gmail.com>
Content-Language: en-US
From: Peter Suti <peter.suti@streamunlimited.com>
In-Reply-To: <CAOf5uwkGN07wjgMPjpRCByUFKU2Wf0H9dm6q966GGkO3FBT9nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

Hi Michael,

Thanks for the review!

On 12/20/25 09:39, Michael Nazzareno Trimarchi wrote:
>> diff --git a/cmd/mtd.c b/cmd/mtd.c
>> index 7f25144098b..1d1845bce44 100644
>> --- a/cmd/mtd.c
>> +++ b/cmd/mtd.c
>> @@ -559,8 +559,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>>
>>          /* Search for the first good block after the given offset */
>>          off = start_off;
>> -       while (mtd_block_isbad(mtd, off))
>> +       while (mtd_block_isbad(mtd, off)) {
>> +               printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);
>>                  off += mtd->erasesize;
>> +       }
> Would like to avoid adding more debug stuff or printing here.
Sure, I'll send it as a separate patch in V2 with the other debug 
commit, then upstream can decide if it's worth taking or not.
>> +                       remaining = 0;
>> +                       ret = CMD_RET_SUCCESS;
> What is the drawback to failing here, I mean you can still verify the
> integrity. GIve a script example
> where this is needed in the commit message

This behavior is similar to the raw `nand` command which adjusts the 
size of the read with adjust_size_for_badblocks().
It is explained in the cover letter.

>
>> +                       break;
>> +               }
>> +
>>                  /* Skip the block if it is bad */
>>                  if (mtd_is_aligned_with_block_size(mtd, off) &&
>>                      mtd_block_isbad(mtd, off)) {
>> +                       printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);
>>                          off += mtd->erasesize;
> This is an extra print for now, you can propose it on a separated patch
>
I'll send it as a separate patch with the other debug commit.

Best regards,
Peter
