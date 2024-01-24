Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE5EC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 23:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9F687D50;
	Thu, 25 Jan 2024 00:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s1XKJlHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6586D876A7; Thu, 25 Jan 2024 00:24:36 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7898487D50
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 00:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 99E283F6C9; 
 Wed, 24 Jan 2024 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706138673;
 bh=+n6/4j9LQ+5/5G4nMDL7t8cFmxpqFHtH/7ksUoVpSjw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=s1XKJlHK6aTVlgEmitx0pMa1vdWKdo3r4Qy8TWOPxz4xaxLPjFGTy/F2l7sdmxe7S
 leD49wgd3vPaWvRHM0Y7+2iQe8MxBSB+/5EVf5a9C4xBffOxAF6RVzY6W1Vy3uzsD7
 B0kmmXNrkVtwIUoLXUTSGSfdkvcJJFVMDnBa2UH2O+9gukKRjddzorKrb8QA3js7p9
 myDPP4Sou+CV5282CcOMwyJqUl3zRbf2LArP64G2k6+/qkyUGgi2OZnoz1BIBoK4pW
 /yISg5wvblMhPj6Lc+RZhHZXgFvLUWArNp/k5LgeEV4UidOkP8hJBU79T5H1v0PE6k
 B8HjvI5taVV3w==
Message-ID: <496ce6bb-8437-4ce5-9935-808b0e833ae4@canonical.com>
Date: Thu, 25 Jan 2024 00:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
 <20240124211658.GA493567@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240124211658.GA493567@bill-the-cat>
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

On 1/24/24 22:16, Tom Rini wrote:
> On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:
> 
>> U-Boot can either generated an SMBIOS table or copy it from a prior boot
>> stage, e.g. QEMU.
>>
>> Provide a command to display the SMBIOS information.
>>
>> Currently only type 1 and 2 are translated to human readable text.
>> Other types may be added later. Currently only a hexdump and the list of
>> strings is provided for these.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> [snip]
>> @@ -227,6 +227,13 @@ config CMD_SBI
>>   	help
>>   	  Display information about the SBI implementation.
>>   
>> +config CMD_SMBIOS
>> +	bool "smbios"
>> +	depends on SMBIOS
>> +	default y
>> +	help
>> +	  Display the SMBIOS information.
>> +
> 
> So this would be enabled (today) on 888 boards and is a bit more than a
> kilobyte. I think we can just let this be enabled as needed in
> defconfigs?
> 

As needed would be the boards where we want to run the related Python 
test. Sandbox and QEMU should be good enough?

Best regards

Heinrich
