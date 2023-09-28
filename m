Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827DECE7AFF
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 06:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8773286B3B;
	Thu, 28 Sep 2023 08:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GVSIcl4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C39786C5D; Thu, 28 Sep 2023 08:22:29 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E1D86D09
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 08:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 53CF6660731C;
 Thu, 28 Sep 2023 07:22:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695882146;
 bh=1UojAp0AbhaNy3MedjYSbZ7lMjvzbmtuEoM6GcuoNxo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GVSIcl4o2+NVSJn7tjsyDFUWzI23PkTloTnTK4n29gu431IXlpX7NHlxVAwHVwgLJ
 Lm2xSyMkxhnGN4HNytdZkmK0nKV0JCWbHI6O3TSP8/+Ms4qiZDbDTTkQbqx/MbzFJu
 NIwqgC7N1xoej37uDnHqc4aZFSJCOUv914/j8RM48oR6En6b+IaiwzBq6HaG5shZlX
 xpw6rlZe0eFCCINmCQRCC0HNjL0vdDzc7d7u8RWrrbNhub6jwjVQnjBObFA49lKsji
 kEQz9vXAztKLzaLW4bFZXuvKzybKPUorH9eNKEuS7XJKzwIMtHbKTh07SFu7X+52BO
 DVR56eT4cqp9A==
Message-ID: <06ce1abf-610e-d48a-096c-c9147e370ffc@collabora.com>
Date: Thu, 28 Sep 2023 09:22:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] mtd: nand: raw: atmel: Add error handling when
 rb-gpios missing
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
References: <20230922090856.920303-1-ada@thorsis.com>
 <20230922090856.920303-2-ada@thorsis.com>
 <b1d83292-c056-8759-aa33-da3e5ddf979b@collabora.com>
 <CAOf5uwmTDN4nuNgKkmj_aKWORKAErio3su9cYoA5pH-knNWJYA@mail.gmail.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <CAOf5uwmTDN4nuNgKkmj_aKWORKAErio3su9cYoA5pH-knNWJYA@mail.gmail.com>
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

On 9/23/23 19:50, Michael Nazzareno Trimarchi wrote:
> On Fri, Sep 22, 2023 at 11:40 AM Eugen Hristev
> <eugen.hristev@collabora.com> wrote:
>>
>> On 9/22/23 12:08, Alexander Dahl wrote:
>>> Adapt behaviour to Linux kernel driver.
>>>
>>> The return value of gpio_request_by_name_nodev() was not checked before,
>>> and thus in case 'rb-gpios' was missing in DT, rb.type was set to
>>> ATMEL_NAND_GPIO_RB nevertheless, leading to output like this for
>>> example (on sam9x60-curiosity with the line removed from dts):
>>>
>>>       NAND:  Could not find valid ONFI parameter page; aborting
>>>       device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
>>>       Macronix NAND 512MiB 3,3V 8-bit
>>>       512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 64
>>>       atmel-nand-controller nand-controller: NAND scan failed: -22
>>>       Failed to probe nand driver (err = -22)
>>>       Failed to initialize NAND controller. (error -22)
>>>       0 MiB
>>>
>>> Note: not having that gpio assigned in dts is possible, the driver does
>>> not override nand_chip->dev_ready() then and a generic solution is used.
>>>
>>> Fixes: 6a8dfd57220d ("nand: atmel: Add DM based NAND driver")
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>
>> Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com>
>>
>>>
>>> Notes:
>>>       v1 -> v2:
>>>
>>>       - Only issue error message if error is not ENOENT.  If the node just is
>>>         missing, move on without error message.
>>>
>>>    drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>
> Acked-by: Michael Trimarchi <michael@amarulasolutions.com>
> 


Applied to u-boot-at91/master, thanks !
