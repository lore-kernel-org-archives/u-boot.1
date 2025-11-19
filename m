Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFFBCF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C1683F4F;
	Wed, 19 Nov 2025 10:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Gw+QsdzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58138397D; Wed, 19 Nov 2025 08:13:01 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAF083979
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 08:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC25D10B0D6; Wed, 19 Nov 2025 08:12:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763536378;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=p8jxLqeitU1rTX9e6ZGvSO8qr5WX1wJIuF7N5MYLU4Y=;
 b=Gw+QsdzP1rdwEg8cPmOHVv6cBNcZN/ubavpZmg0rW7EG5yYl2/f5wjIF60lv6dy0cJP3y3
 viwJq8CD+XdUdtfHYfjQRUGmEpxrzy7GGb9Rw27225OAsRxD0fJpW14j/AM/tOj+j2iG2+
 1QusRnQAmPK64hTd1OjIJeymk4NIc74RjR9yXcDo3iueIUnJMeexNEDzYRXAD0yuQrOWfn
 N8nGRisFuB0L/0iiDKWqReYERZ/270PdJHue49c9POYqPsy+1BUsfwCvwIRdkK0hT9Kvcq
 hT8GjV+IlCKE6sexDONHSiHLXnRf2tvSfOGvObboyYy+49+9l3wIvV1BmqVDQg==
Message-ID: <0c5c5ab6-f16d-1a1b-be5b-84b04179b41d@nabladev.com>
Date: Wed, 19 Nov 2025 08:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/6] lib: sm3: implement U-Boot parts
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
References: <20251118043042.27726-1-hs@nabladev.com>
 <20251118043042.27726-4-hs@nabladev.com>
 <75a1e7a9-3a66-49ca-92d4-75dbecd7ff4a@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <75a1e7a9-3a66-49ca-92d4-75dbecd7ff4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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

Hello Quentin,

On 18.11.25 11:30, Quentin Schulz wrote:
> Hi Heiko,
> 
> On 11/18/25 5:30 AM, Heiko Schocher wrote:
>> add the U-Boot specific parts for the SM3 hash
>> implementation:
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> Changes in v3:
>> New in version 3 as Ilias recommended to split linux
>> and U-boot changes.
>>
>>   MAINTAINERS          |   1 +
>>   boot/Kconfig         |   1 +
>>   cmd/Kconfig          |  15 ++++++
>>   cmd/Makefile         |   1 +
>>   cmd/sm3sum.c         |  48 +++++++++++++++++
> 
> Please add some doc for the new command in doc/usage/cmd/.
> 
> [...]

Thanks for this hint, of course!

> 
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 5b9c13d85e7..8e3efff2bee 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -264,6 +264,21 @@ config CMD_SBI
>>       help
>>         Display information about the SBI implementation.
>> +config CMD_SM3SUM
>> +    bool "sm3sum"
>> +    select SM3
>> +    select HASH
>> +    help
>> +      Compute SM3 checksum.
>> +      add SM3 hash functionality
>> +
> 
> Spurious second line?

I think, I added this line, because of checkpatch warning!
But as the other hash commands have also only one line...

If it is okay to ignore the checkpatch warning, I remove that
line.

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
