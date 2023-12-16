Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A43BC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C4E87A7F;
	Sat, 16 Dec 2023 20:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aZ2aZg2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376B387AA2; Sat, 16 Dec 2023 20:21:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F3787A7B
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [172.25.0.170] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 51B36413C5; 
 Sat, 16 Dec 2023 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702754460;
 bh=Vqm1kPMDR7jyNd4kfqpjGT9JhkBl+CyD0W2uk/HoAIg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=aZ2aZg2ObUza+rU12W9ki4YMgdoxRFTy/dwi+0o/XqnP69AGy2PBv723s81ZhI6jt
 tre6Qet1rxuIkFykdbWMBw69DezgytUFzUVF+IKckcKq9ODQQiPywfpztwy9Y8RAAB
 vUN1Vsr9Sjw2QRfDz09ivyovnj+p34idVxur8BRFMTr65wQ6CzYk1gZ6cXGuFoywO1
 dJQ/SA3z044YUJD0NJCdjG4wEKSv9eMs61J0l2FJHC2IUGIoHiRwloAJuV3/N0OMbn
 ccE7RSulVsGflJG6hgphPS8mTmh/Au3SzRRTsZAYEGiiTvH6I4aKP3VJyIzHNWWgdF
 F++5v+JLbF+pQ==
Message-ID: <aff5eac1-3f76-4d3e-92e5-9554c5b6340a@canonical.com>
Date: Sat, 16 Dec 2023 20:20:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] acpi: support 64bit in acpi_find_table for DSDT
 and FACS
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-5-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2=Qd=u7z90nYXRXNUBK6Sdu4iDiBmT00OJMi0FU1_nbA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ2=Qd=u7z90nYXRXNUBK6Sdu4iDiBmT00OJMi0FU1_nbA@mail.gmail.com>
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

On 12/16/23 19:45, Simon Glass wrote:
> On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Use X_DSDT and X_FIRMWARE_CTRL if available.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/acpi/acpi.c | 29 ++++++++++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This could really use a test

I guess we want a test on library level separate from test/dm/acpi.c as 
this test will not be driver model related?

Best regards

Heinrich
