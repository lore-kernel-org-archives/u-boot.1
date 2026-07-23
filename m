Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03345C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 07:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A843F60724;
	Thu, 23 Jul 2026 07:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YoC3GCRO_Z-u; Thu, 23 Jul 2026 07:39:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B66460708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784792399;
	bh=9AfqzHU79cKPkv5ouMlVJKlF/WYjAb/zhlBs9/1XBZQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ekG3Worr6pfJaiZJB+b3jRv4VhzpHJT/ANYUVS/thCB+TQyeMNCAkAnCy4x4uTV2G
	 MuxnIDyfZLD+r3wd35nFHbN4AKW5e9yOzyGAhzJHYh3MK3h0qJb8k+SRIM7hbKAZzw
	 EfsZ2yezIvr+HYn/puYEaoie2XFBAQbf6xaRVcaRCpu3hxOj8TKlQgdR0jIvCcI2h1
	 ZSbgcjcD5aOdUMDRiLKoJFO2q9vACEHdPo2u0KjQKa9XG52NJg/3i/9TpJ1wW4WqOU
	 5UZB9IYHgjelrmJyohoGchIJTDivnXTo2v5GQB3Rdgeb2P+euEro0hcw9EFfM0K3/O
	 XjCvIYX6gmZNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B66460708;
	Thu, 23 Jul 2026 07:39:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 640EA2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A0F180DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Et5YIJwq1vAu for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 07:39:57 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=bastien.curutchet@bootlin.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E7E3B80DB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7E3B80DB5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7E3B80DB5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:39:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED63846A4; Thu, 23 Jul 2026 09:39:54 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2171883E76
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 09:39:52 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A54BB4E40F00;
 Thu, 23 Jul 2026 07:39:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 78C9E602B8;
 Thu, 23 Jul 2026 07:39:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8421311C10108; 
 Thu, 23 Jul 2026 09:39:48 +0200 (CEST)
Message-ID: <a3ca27b1-9100-4de1-864e-4928ea6c601d@bootlin.com>
Date: Thu, 23 Jul 2026 09:39:47 +0200
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
 <b22d644a-6d11-4ac8-9a38-82fd8ce5d5fb@bootlin.com>
 <6051fd86-9f84-4a43-9788-1fa07510c4c0@amd.com>
 <1002cb3a-5f11-4d25-93de-f7965256903f@bootlin.com>
 <1d8f89c2-3247-4897-a5a9-76fb4fd7c421@amd.com>
Content-Language: en-US
In-Reply-To: <1d8f89c2-3247-4897-a5a9-76fb4fd7c421@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784792390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=9AfqzHU79cKPkv5ouMlVJKlF/WYjAb/zhlBs9/1XBZQ=;
 b=yvrpXM9xzWzK1kkMXMZiI1ewGI3ikG2sQ6WgNoonfO8zdO0YS87GSVPHJjTpviB+hXrTng
 6i+9pZNUAbqO6e/Uhq/XJYRNbGzsPlE0MTQpVnnRQjKHXuyBFmn5N6snVpxBQVsEZr7iTd
 SbxtrC2Fr/ZvMnN8afkHqNVRRXGRGbtQBeWjU5LOM6I0OEtLNz269//K2nG7foFCm6UYfa
 f/MWekRBeWICuSjlOv3/DJK1rLwc2CWANL48iFVHxoIDcOZJfacyVn13kxq/qeSTyyKZVS
 VEUUuyBQ0c1zMbuoaTn40seooKhqiwrAkQq9kqy+fhJK/XzgrKGYT3mJIvLe7w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=yvrpXM9x
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bastien.curutchet@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yvrpXM9x"; 
 dkim-atps=neutral
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
From: Bastien Curutchet via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Love,

On 7/22/26 2:32 PM, Kumar, Love wrote:
> Hi Bastien,
> 
> On 7/17/2026 8:21 PM, Bastien Curutchet wrote:
>> Hi Love
>>
>> On 7/13/26 3:52 PM, Kumar, Love wrote:
>>> Hi Bastien,
>>>
>>> On 7/13/2026 3:18 PM, Bastien Curutchet wrote:
>>>> Hi Love,
>>>>
>>>> On 7/11/26 8:36 AM, Kumar, Love wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On 7/9/2026 11:23 AM, Michal Simek wrote:
>>>>>> Hi Love,
>>>>>>
>>>>>> On 7/2/26 15:08, Bastien Curutchet wrote:
>>>>>>> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
>>>>>>> - flagging the most hideous parts (where Micron on-die ECC support is
>>>>>>>       hardcoded)
>>>>>>> - enabling DT support, eg. for reading the ECC configuration
>>>>>>> - fixing software ECC support
>>>>>>> - aligning the software ECC OOB layout to the rest of the world and
>>>>>>>       allow a working interoperability in Linux.
>>>>>>>
>>>>>>> I then added a patch to fix writes when soft ECC is on.
>>>>>>>
>>>>>>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>>>>>>> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
>>>>>>> ---
>>>>>>> Changes in v3:
>>>>>>> - Add patch 6 to fix write issues in soft ECC.
>>>>>>> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>>>>>>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>>>>>>
>>>>>>> ---
>>>>>>> Bastien Curutchet (DAVE.eu) (1):
>>>>>>>           mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
>>>>>>>
>>>>>>> Miquel Raynal (DAVE.eu) (5):
>>>>>>>           mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>>>>>>           mtd: rawnand: zynq: Add comments about very bad practices
>>>>>>>           mtd: rawnand: zynq: Make sure an of node is attached
>>>>>>>           mtd: rawnand: zynq: Do not fail the probe for no reason
>>>>>>>           mtd: rawnand: zynq: Fix Software ECC engine support
>>>>>>>
>>>>>>>      drivers/mtd/nand/raw/nand_base.c |   6 +-
>>>>>>>      drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>>>>>>      2 files changed, 32 insertions(+), 89 deletions(-)
>>>>>>> ---
>>>>>>> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
>>>>>>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>>>>>>
>>>>>>> Best regards,
>>>>>>
>>>>>> Please test this series.
>>>>>
>>>>> We are again seeing the NAND write issue with zynq-zc770-xm011 board.
>>>>>
>>>>> Below is the log snippet:
>>>>>
>>>>> Zynq> nand write 0x80000 0x0 0x126f80
>>>>> nand write 0x80000 0x0 0x126f80
>>>>> NAND write: device 0 offset 0x0, size 0x126f80
>>>>> NAND write to offset 0 failed -5
>>>>>
>>>> The exact same command works in my setup:
>>>>
>>>> ```
>>>> Zynq> nand write 0x80000 0x0 0x126f80
>>>>
>>>> NAND write: device 0 offset 0x0, size 0x126f80
>>>>    1208192 bytes written: OK
>>>> ```
>>>>
>>>> Can you please share your device-tree / defconfig ? I'd like to dig into this a bit.
>>>>
>>>> I'd also be interested in seeing the output of 'mtd list' and 'nand info' on your side.
>>>
>>> I have used the xilinx_zynq_virt_defconfig with zynq-zc770-xm011 DT.
>>> Below are the log snippets for 'nand info' and 'mtd list' commands:
>>>    Zynq> nand info
>>>    Device 0: nand0, sector size 128 KiB
>>>     Page size         2048 b
>>>     OOB size            64 b
>>>     Erase size      131072 b
>>>     ecc strength         0 bits
>>>     ecc step size     2048 b
>>>     subpagesize       2048 b
>>>     options       0x40000000
>>>     bbt options   0x00028000
>>>    Zynq> mtd list
>>> List of MTD devices:
>>> * nand0
>>>     - type: NAND flash
>>>     - block size: 0x20000 bytes
>>>     - min I/O: 0x800 bytes
>>>     - OOB size: 64 bytes
>>>     - OOB available: 38 bytes
>>>     - 0x000000000000-0x000008000000 : "nand0"
>>>        - 0x000000000000-0x000001000000 : "nand-fsbl-uboot"
>>>        - 0x000001000000-0x000003000000 : "nand-linux"
>>>        - 0x000003000000-0x000003200000 : "nand-rootfs"
>>> Zynq>
>>>
>>
>> Thank for these information.
>>
>> Have you explicitly enabled the soft ECC ? I don't find the nand-ecc-mode property in the upstream zynq-zc770-xm011 DT.
>>
> 
> Yes, tested it by explicitly enabling it with `nand-ecc-mode = "soft";` in zynq-zc770-xm011 DT, observed the same behavior - NAND write fails. Same issue was observed without enabling ecc mode as well.
> 
> ```
> Zynq> nand write 0x80000 0x0 0x80000
> 
> NAND write: device 0 offset 0x0, size 0x80000
> NAND write to offset 0 failed -5
> 0 bytes written: ERROR
> Zynq>
> ```
> 
> Am I missing any other configurations?
> 
I don't see any other configuration you'd be missing.

I had this error once with ECC-soft enabled but that was because I had 
forgotten to do a prior erase


Best regards,
Bastien
