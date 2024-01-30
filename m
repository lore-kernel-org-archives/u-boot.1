Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E137C47DB3
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 03:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AFC87BEE;
	Tue, 30 Jan 2024 04:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ir9d7q5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F0187C29; Tue, 30 Jan 2024 04:11:42 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by phobos.denx.de (Postfix) with ESMTP id 3159987BCB
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bruce_suen@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 From; bh=l5o1RIX+rOsYlc3yZQs1247j1uUhpMEpMnxAx5LUgoE=; b=ir9d7q5
 m3kYcdFSVXWyKbkhMO+YNolUj0sV0GG+O1ioubrIMI+gLSQ1HJsmEINtTYZVXm4M
 BCVr6CGvyijYzHg7bdLhOlWwQlTEM7k4ERF+2gSEbqVhHzOUW168RygKLj1IATZR
 UgcIsYLId3HW6DPJFWBeAr6ntpi8MtH99Gl4=
Received: from [192.168.107.56] (unknown [113.110.215.190])
 by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wCnT6DZaLhleh_KBQ--.23367S2;
 Tue, 30 Jan 2024 11:11:22 +0800 (CST)
Message-ID: <286a15d2-b2e5-4291-8e54-516f7242812e@163.com>
Date: Tue, 30 Jan 2024 11:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, frieder.schrempf@kontron.de,
 bruce.sun@xtxtech.com
References: <20231226075812.3803-1-bruce_suen@163.com>
 <CAMty3ZDRSsR-RNapU5npfdG7CixSV3NocJ4Q0oNwv9V21THRjQ@mail.gmail.com>
From: Bruce Sun <bruce_suen@163.com>
In-Reply-To: <CAMty3ZDRSsR-RNapU5npfdG7CixSV3NocJ4Q0oNwv9V21THRjQ@mail.gmail.com>
X-CM-TRANSID: _____wCnT6DZaLhleh_KBQ--.23367S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45AF4kXFyruw4ktF47Jwb_yoW3WFgE9F
 ZYyr1DK3yDKry0qrn7JwnIqrW5C34DCF18ur12grWUurySvrnYgw1DZas0gFW8tFZrKF9x
 Kr9xZ39FkryF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_rgA5UUUUU==
X-Originating-IP: [113.110.215.190]
X-CM-SenderInfo: 5euxuvpbvxv0i6rwjhhfrp/1tbitx91KGV4HtU-hgAAsa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 1/29/2024 8:00 PM, Jagan Teki wrote:
> On Tue, Dec 26, 2023 at 1:28 PM Bruce Suen<bruce_suen@163.com>  wrote:
>> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
>> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
>> XT26Q04DXXXXX SPI NAND.
>>
>> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
>> ECC(8bit strength per 512bytes).
>>
>> Datasheet Links:
>> -http://www.xtxtech.com/download/?AId=458
>> -http://www.xtxtech.com/download/?AId=495
>>
>> Signed-off-by: Bruce Suen<bruce_suen@163.com>
>> ---
> This won't apply on my spi tree, maybe some out-of-master changes are stopping.
can you give me your spi tree? I use 
"https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git“ before.
