Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDC0CD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 02:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19CE68829E;
	Fri,  5 Apr 2024 04:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AED9881AD; Fri,  5 Apr 2024 04:11:14 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 0411387EBD
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 04:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 05 Apr 2024 11:11:07 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D0AFE20584CE;
 Fri,  5 Apr 2024 11:11:07 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Fri, 5 Apr 2024 11:11:07 +0900
Received: from [10.212.158.197] (unknown [10.212.158.197])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id 685DBB62AB;
 Fri,  5 Apr 2024 11:11:07 +0900 (JST)
Message-ID: <42c08990-e560-b8a4-2862-fbe8c1ba9133@socionext.com>
Date: Fri, 5 Apr 2024 11:11:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: dw: Use controller clock rate as maximum frequency
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
References: <20231025074951.3161356-1-hayashi.kunihiko@socionext.com>
 <CAMty3ZD3Bxh-2ragz1RcXWf44kxAue6gT-xO-5k59m-vBd0n9Q@mail.gmail.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAMty3ZD3Bxh-2ragz1RcXWf44kxAue6gT-xO-5k59m-vBd0n9Q@mail.gmail.com>
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

Hi Jagan,

On 2023/12/18 20:40, Jagan Teki wrote:
> On Wed, Oct 25, 2023 at 1:20 PM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Currently the controller driver has maximum frequency in plat->frequency
>> that is specified by "spi-max-frequency" DT property in the controller
>> node. This is special to U-Boot and doesn't exist to Linux.
>>
>>      spi {
>>          spi-max-frequency = <A>;
>>      };
>>
>> Usually the frequency should be specified by "spi-max-frequency" at the
>> slave device node.
>>
>>      spi {
>>          slave {
>>              spi-max-frequency = <B>;
>>          };
>>      };
>>
>> The final maximum frequency is set to the smaller value of the controller
>> node (A) and the slave device node (B).
>>
>> Currently, if the property in the controller node is omitted, the default
>> frequency is fixed at 500kHz. Even if the controller and the slave device
>> allow the higher frequency than 500kHz, the maximum frequency can't exceed
>> 500kHz.
>>
>> The upper limit of the maximum frequency should be determined by the clock
>> rate of the controller clock. And this patch determines the maximum
>> frequency based on the clock rate if the controller node property isn't
>> specified.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
> 
> Applied to u-boot-spi/master

Sorry for the old response,
I couldn't see this patch in the current master branch.
Could you please apply this if it is missing?

Thank you,

---
Best Regards
Kunihiko Hayashi
