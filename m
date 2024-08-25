Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40599C52D6F
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 00:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F288852B;
	Sun, 25 Aug 2024 02:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724545734;
	bh=/oiimgHXeN7vYYczsAFnFLdxAwaZa7QPyp7fL8hbLCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1tMzcjmw6U7lN9IDb4HqKWA9yGQB157Y2XJl3WrruYBACAo+J1fBYhSsYhnAz+ca
	 NVgs1ITv9Pv2NPzZwZgQwLbvpHHti9x1mZm6Pgw7m+jjWE9Sr/eUa5ewll/kd2JAGI
	 WgzCGoxrQnbVB2VCdZRVcbXKp9Dqu6OGV0fNCKvEiJUwn8naR2LLnvUTDQwU0VXWbm
	 kxbS35JEOCSaW4a8nVLat53UB3azPx0GE9mee8P0QLlrYCmINFluhwiqC/eEzK7PXu
	 V7RXXAcrhue7CuQPTf8FBapIS8V0Da61Feo1HKjhTOrIFN3eqafPMemGvz8snj4Y4W
	 dXgLkXCdodG3g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F051A88498;
 Sun, 25 Aug 2024 02:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724545734;
 bh=/oiimgHXeN7vYYczsAFnFLdxAwaZa7QPyp7fL8hbLCU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ULz5eF70vPNq/bh6BVJE77kYEM1XhevnJFt0cGn5Z0BmHCrQSks9iLcbagAu+QK9H
 rwIQafkfPGif3oM4d2ruLo5Zk4zrHy2KoxDrdGSlR51FkSc8mlUkEZ4XYhDv93QBBr
 pbToW6izBqkrzQUWQgZzWCh+XKKXwROdfmpCgY9Bkpmy0fKdmUX1ub9AqSUJBXPPKw
 qS37alKGcW4EDkE2wCvJpMI48GdYfHcW6AsDPzIR6URyeDlsdeSnXKI3dudP9KxmCg
 LFomuqPG9Mgdz4CA87V5InxJOIkwmwyxX+vwSd3P2Jizc9/mPYZm+INKoJaevn1Iur
 35dGCEp0cOvfw==
Message-ID: <19a4f9fd-81c7-4ff7-a202-8f0f0c5857a9@denx.de>
Date: Sun, 25 Aug 2024 02:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20240304161607.82759-1-marex@denx.de>
 <CAMty3ZB=s5ZNhgHZ2Q8vbzcvFCdO=62xHSY+dAeyr=y3ujkgWA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAMty3ZB=s5ZNhgHZ2Q8vbzcvFCdO=62xHSY+dAeyr=y3ujkgWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/24/24 6:05 PM, Jagan Teki wrote:
> On Mon, Mar 4, 2024 at 9:46 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Some Winbond SPI NORs have special SR3 register which is
>> used among other things to control whether non-standard
>> "Individual Block/Sector Write Protection" (WPS bit)
>> locking scheme is activated. This non-standard locking
>> scheme is not supported by either U-Boot or Linux SPI
>> NOR stack so make sure it is disabled, otherwise the
>> SPI NOR may appear locked for no obvious reason.
>>
>> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
>> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
> 
> Applied to u-boot-spi/master

I do not see this patch in u-boot/master , was it missed ?
