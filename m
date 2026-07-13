Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BCAC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 09:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4808184A5B;
	Mon, 13 Jul 2026 11:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dJu0ozr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905DF84A63; Mon, 13 Jul 2026 11:48:35 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E15D80087
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AF2034E40D87;
 Mon, 13 Jul 2026 09:48:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7B8B760341;
 Mon, 13 Jul 2026 09:48:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D414F11BD39FC; 
 Mon, 13 Jul 2026 11:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783936111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=l9XRbMgzKkh2DI39lKx0TLSrRc03u0b4SKkNoSQ8bAw=;
 b=dJu0ozr/zd0uUfT4CfLlxFRUqLsC0C5RyaZjBB12I4zJQcyBryokUnGhDQxLK+GHL2x5F5
 A+lbk/hUo343CDRJk8MTwqJSKN6yCkQngLIsnNh0m/GzK6ghzSIifGbpr/eRD8YBWABatU
 QRMOGiQn81/wOtSzg/OyheoGrx4J4MzJnE/UWDt1oJ59ADOPjcRDL+kfU3s8vjoilhsZPY
 +Or1XhlY9sQCP0xiyhH9pZ1biOMbuTXctRseUsOyvqZbUqC1j9wqyhYSMknOoKVIJg0aLR
 OipFLgURKnXDQQ8a/7FxzAkBvmsOP9euZpdNS3GV+vfkwKX6iTAF4IhaIGbT8Q==
Message-ID: <b22d644a-6d11-4ac8-9a38-82fd8ce5d5fb@bootlin.com>
Date: Mon, 13 Jul 2026 11:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
To: "Kumar, Love" <love.kumar@amd.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
 <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
 <6a9f0530-ea41-491b-b4f4-f7d03ee2fd3a@amd.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <6a9f0530-ea41-491b-b4f4-f7d03ee2fd3a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Love,

On 7/11/26 8:36 AM, Kumar, Love wrote:
> Hi Michal,
> 
> On 7/9/2026 11:23 AM, Michal Simek wrote:
>> Hi Love,
>>
>> On 7/2/26 15:08, Bastien Curutchet wrote:
>>> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
>>> - flagging the most hideous parts (where Micron on-die ECC support is
>>>     hardcoded)
>>> - enabling DT support, eg. for reading the ECC configuration
>>> - fixing software ECC support
>>> - aligning the software ECC OOB layout to the rest of the world and
>>>     allow a working interoperability in Linux.
>>>
>>> I then added a patch to fix writes when soft ECC is on.
>>>
>>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>>> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
>>> ---
>>> Changes in v3:
>>> - Add patch 6 to fix write issues in soft ECC.
>>> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
>>>
>>> Changes in v2:
>>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>>
>>> ---
>>> Bastien Curutchet (DAVE.eu) (1):
>>>         mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
>>>
>>> Miquel Raynal (DAVE.eu) (5):
>>>         mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>>         mtd: rawnand: zynq: Add comments about very bad practices
>>>         mtd: rawnand: zynq: Make sure an of node is attached
>>>         mtd: rawnand: zynq: Do not fail the probe for no reason
>>>         mtd: rawnand: zynq: Fix Software ECC engine support
>>>
>>>    drivers/mtd/nand/raw/nand_base.c |   6 +-
>>>    drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>>    2 files changed, 32 insertions(+), 89 deletions(-)
>>> ---
>>> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
>>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>>
>>> Best regards,
>>
>> Please test this series.
> 
> We are again seeing the NAND write issue with zynq-zc770-xm011 board.
> 
> Below is the log snippet:
> 
> Zynq> nand write 0x80000 0x0 0x126f80
> nand write 0x80000 0x0 0x126f80
> NAND write: device 0 offset 0x0, size 0x126f80
> NAND write to offset 0 failed -5
> 
The exact same command works in my setup:

```
Zynq> nand write 0x80000 0x0 0x126f80

NAND write: device 0 offset 0x0, size 0x126f80
  1208192 bytes written: OK
```

Can you please share your device-tree / defconfig ? I'd like to dig into 
this a bit.

I'd also be interested in seeing the output of 'mtd list' and 'nand 
info' on your side.


Best regards,
Bastien

