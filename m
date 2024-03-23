Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DB9C54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 05:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2137A87A00;
	Sat, 23 Mar 2024 06:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711170349;
	bh=4iKZGfLSG73PnQnxxm2deRtJjKwivL0M6fW9DKkzOVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=a7fDiZlULlgRUXS938RZMFncH4tHKxOij0Xyo2mpdAxQUOHbaU/qe7j7dSJgWIhzj
	 fGcSntLEG7hnhV4VzT4ynulKsId2SJg88MS5v0Bz+Os+FP7/27HAq8+t0h+RdqD0ag
	 XGWrxS7ROUvzzixmk4+2Re7+gpttePHF0QSwNMInmUOXWBFSUdPVxyE3iJMf94abmu
	 6+gJYUn8PeF6m9M2+fRBTiH17Vfz4nzgzV1P+ra8qUng0E/q9zvQzS1Dcy5U6fm9g2
	 JTHQ5CvgiPMA/bmLdjwrDIWcUdZFDtoUqWwCiL5eLojSbiOyeyuJTOsoq7BB9qCaJt
	 HvzgxCAJEtE4A==
Received: from [192.168.1.107] (82-131-203-241.pool.digikabel.hu
 [82.131.203.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 88994879CC;
 Sat, 23 Mar 2024 06:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711170347;
 bh=4iKZGfLSG73PnQnxxm2deRtJjKwivL0M6fW9DKkzOVU=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=QbJ5KsUi4y2RI2zudnJ2+MnhIupNE4jm9WIvcsIU9qW1f458hK1BpzgWIXloJPUIi
 Jr5Bs3dTkVgUXIPmiK7eucUoYmEyt0sg2WdklPtWPplnME88X0dSrgm1/eFTd1j4bA
 laPjdhBWnn8vfdaN3E37pJwthkvZSQdEyonNBPCeO3m9yGmKCWal94RrD90ofFCDMc
 c6zrANCR67D9Dg+EWH+lu1NLS619zOXUOmO80HiOKV5qagPl9990u7jNXAatpvQ3gZ
 7QtTZgwPaAqwh9o2ztlxqlEaturQTx5sMGSJcTfazjUHEkaOE0IPSkujDUlrjEXeN+
 BC1BFSRvq47Yg==
Message-ID: <580da97d-4107-c645-8eff-eb4462771f6d@denx.de>
Date: Sat, 23 Mar 2024 06:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 5/6] disk: support UBI partitions
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
 <20240306134906.1179285-6-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240306134906.1179285-6-avromanov@salutedevices.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexey,

On 06.03.24 14:49, Alexey Romanov wrote:
> UBI partition is abstraction over UBI volumes.
> Can be used by UBI block device.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/mtd/ubi/Makefile |  1 +
>   drivers/mtd/ubi/part.c   | 99 ++++++++++++++++++++++++++++++++++++++++
>   include/part.h           |  2 +
>   3 files changed, 102 insertions(+)
>   create mode 100644 drivers/mtd/ubi/part.c
> 
> diff --git a/drivers/mtd/ubi/Makefile b/drivers/mtd/ubi/Makefile
> index 67b1a05348..e443f3585e 100644
> --- a/drivers/mtd/ubi/Makefile
> +++ b/drivers/mtd/ubi/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_MTD_UBI_FASTMAP) += fastmap.o
>   obj-y += misc.o
>   obj-y += debug.o
>   obj-$(CONFIG_BLK) += block.o
> +obj-y += part.o

May it is good to have this as an Kconfig option? So boards which
do not use UBI block will save code size...

Beside of this:

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
