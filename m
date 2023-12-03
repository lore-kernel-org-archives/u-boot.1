Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39271C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7605587225;
	Sun,  3 Dec 2023 22:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="brk6Co3j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R7+sdIdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCD187547; Sun,  3 Dec 2023 22:01:16 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF218718E
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Sjzjj2Bvyz9svK;
 Sun,  3 Dec 2023 22:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701637273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUejAC7sIkXdkm3o1mHNMOY6JCVOeTVPna3xkNV9Tmc=;
 b=brk6Co3jqTa8/Bp4z4PiaPdYss9uAlvEDajmTXjb9ujVmY3vnSW5Pc9uxENhF0PXAxbR2Z
 PPhBL3MASaz1zwVw4V59zUtEMtDXTae5H0K6ecuPy3nrpfimq6TOVCIdjyd4csRxPSfFET
 LhnWAedm6+YnEsSMyksc444xlirPF9B26FcQYQCPc+Ir6YXrlRezKm2Nl9Mzhug4T4t7w2
 i83V1fl3FHslv7k/WkUu6QfufK3S8GjEW2asDKa2+oZaKVoI5p4T5pNn4Koopio8jFceoc
 8iWrvufOaqzz0qYG8oP2yNkNsGpD+g/8u6DnrliSxg1yUiruz/hQ6r+IsfYmgA==
Message-ID: <9dbad2ea-2439-4974-930f-ca80c6551615@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701637271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUejAC7sIkXdkm3o1mHNMOY6JCVOeTVPna3xkNV9Tmc=;
 b=R7+sdIdWZI8DmzMSQBzxcte3WHxPCfN3MraK3ezj+PjjMXDCZxQ3m71W8boc/rHAEo7Nii
 EmmQ20njQaZx8a8goFux6NUZRjmCYb4pJeNCF1lcEeq1PMs2np3wAwXBgGasWpoq2a/6AH
 eU6wAhAABcl8LCeOwqaBAUdzk5uNwiORvAKGsJnpcIc6frN3UWUgJ5h1EWAhAgXlTUouwZ
 CONtCDNtlAT8soMfS7/S8AkdKJlRwTCSNToBzkfoGkqYdOCIqnHpnn/pqL2ZLxsiIpOOBm
 xh8sz9eKiZCVms2FBptyPTFgKZBpEpW5BjB8Jf+L8UBoPs46ATrEBQSs/M3o6A==
Date: Sun, 3 Dec 2023 22:01:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Poll CD in case cyclic framework is enabled
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e548fe1e21b973e673c
X-MBO-RS-META: w6du4squxcaeaaaf6ihaot5xq11af1xm
X-Rspamd-Queue-Id: 4Sjzjj2Bvyz9svK
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

On 12/3/23 18:44, Simon Glass wrote:
> Hi Marek,
> 
> On Sat, 2 Dec 2023 at 16:41, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> In case the cyclic framework is enabled, poll the card detect of already
>> initialized cards and deinitialize them in case they are removed. Since
>> the card initialization is a longer process and card initialization is
>> done on first access to an uninitialized card anyway, avoid initializing
>> newly detected uninitialized cards in the cyclic callback.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
> 
> This is really nice!

I wonder whether we can use this cyclic stuff for USB , that's on my 
roadmap to look at . We could auto-detect new devices in the background, 
which would be tidy. And maybe do block transfers in the background ?

> Is there a remove() method where we could unregister the cyclic?

I guess I need to move this into mmc_init/mmc_deinit .
