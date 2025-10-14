Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B6FCCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 08:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E04C807C0;
	Tue, 14 Oct 2025 10:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FZoGh7WQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B091B82991; Tue, 14 Oct 2025 10:57:07 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE9880422
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cm7Pq6zrKz9t8d;
 Tue, 14 Oct 2025 10:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760432224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KfUr//XicS+RxAJlHGgjGEjMpZLHePjqgf29lLiINSE=;
 b=FZoGh7WQYLF1clinamRSNtL3u/jl4vBzg00dziHN3uWHCIeSQwc6ngJC5kh87zlDuPs8pj
 m+ox273HyIMAOaMnBn7rmBj376IOR3yydrIhjuVIuwVxiqWqrCfU/3M01l6xe4oP86P/14
 GYIKrASQEHbXoZy7qesVh5+I2A0ko61gMBbvrrvI0OLi9waECYhf/8hICcFCqcJ483GEjg
 kgDQaaNfZn+cJL6mQ35pC5sSOXtnlPgwI4ihL2WptEkX/s9ORU2gYOYJkX4c2/pPJ5qpIu
 DUXL5KsLqaHZ8uiIes04nYGzGTMFiyKbDPUAkhsyZ15WOkjNVkt6qvdxsRtWpw==
Message-ID: <380aa5b9-4993-44a6-b32f-9794f68b1926@mailbox.org>
Date: Tue, 14 Oct 2025 10:57:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] pci: mvebu: Unable to assign mbus windows for 2nd pcie
 controller
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20250929215006.6654-1-mibodhi@gmail.com>
 <efe2806c-820d-4fc3-aa54-7650aa6a3180@mailbox.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <efe2806c-820d-4fc3-aa54-7650aa6a3180@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3f6s8s3rrnckcn4t3ks4bs76wo1ijnxn
X-MBO-RS-ID: dcd1d137d25637f9ce6
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

On 9/30/25 14:41, Stefan Roese wrote:
> On 9/29/25 23:49, Tony Dinh wrote:
>> Correct the memory and IO mbus windows size increments in 
>> mvebu_pcie_bind.
>>
>> Currently, pcie1 controller resource_size(&mem) and resource_size(&io)
>> checks result in a failure. This is because mem.end and io.end must be
>> incremented at the end of pcie0 windows assignment.
>>
>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>> ---
>>
>>   drivers/pci/pci_mvebu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
>> index 77815513b76..3985bd59607 100644
>> --- a/drivers/pci/pci_mvebu.c
>> +++ b/drivers/pci/pci_mvebu.c
>> @@ -763,6 +763,7 @@ static int mvebu_pcie_bind(struct udevice *parent)
>>               pcie->mem.start = mem.start;
>>               pcie->mem.end = mem.start + SZ_128M - 1;
>>               mem.start += SZ_128M;
>> +            mem.end = mem.start + SZ_128M - 1;
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/master

Thanks,
Stefan

