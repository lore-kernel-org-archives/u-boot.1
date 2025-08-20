Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08249CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7694881E13;
	Wed, 20 Aug 2025 22:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DAXAQiV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 847AD82E34; Wed, 20 Aug 2025 22:19:40 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A6608006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c6d8m0tXPz9v0k;
 Wed, 20 Aug 2025 22:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755721176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPPqHLYaCTcV1JrFtroIBLXyY21jDJ4Qpou6lw3mF/k=;
 b=DAXAQiV493HqYLR6cwCGagZBIqcWOknJ7+APjNHh5RmaQexWrJ9cbpOIH/qLvOfMofiWAu
 huI5IAwOP97m1p1ak7MTt6K/ShVpVC0gFc5lAN0eqxdtuM+TE4fVjrwetFbbBy4eiHfA4k
 14dvBrMYWml4OOVCHtwfIK80DKKoepycFhPil8EtWvSPkyT00o5/YObR+aGqPIfByOc9sU
 d8JaEUXi4lAO2/sRKOuWdQR5s+CImC2BDRraqI0wyvieSBEHXO6T2tfw23uhVvkyl6eCPV
 9MLlzRRxEJMVe45vPo3VDPkor1LqPuXq9aUbetgwNRRtDAZYbyuXTh9GwXx52g==
Message-ID: <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
Date: Wed, 20 Aug 2025 22:19:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 61d066a3d80862d886f
X-MBO-RS-META: 4npt1zifp5nxnxs9sdae8brmws6r9mc9
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

On 8/20/25 1:35 PM, Ravulapalli, Naresh Kumar wrote:
> Hi Marek
> 
> On 20-Aug-25 4:56 PM, Marek Vasut wrote:
>>
>> On 8/20/25 1:20 PM, Ravulapalli, Naresh Kumar wrote:
>>> Hi Marek
>>>
>>> On 20-Aug-25 2:27 PM, Marek Vasut wrote:
>>>>
>>>> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>>>>> Enhanced the generic firmware loader to support QSPI RAW partition
>>>>> loading. This would enable FPGA configuration bitstream loading
>>>>> from QSPI RAW partition to program FPGA.
>>>>>
>>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>>> Signed-off-by: Naresh Kumar Ravulapalli
>>>>> <nareshkumar.ravulapalli@altera.com>
>>>>
>>>> Why not load from UBI on SPI NOR ?
>>>
>>> It is to avoid the storage overhead for metadata and management
>>> for devices with flash constraints.
>>
>> What about data integrity , iirc UBI gives you built-in checksums.
>>
> 
> Agree, UBI supports bad block management and other advantages. But
> the objective here is to support RAW partition for flash constraint
> devices.
How is integrity of the data in flash handled in this case ?
