Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E34DD3C935
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 05:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2908988FE8;
	Sun, 20 Oct 2024 07:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729400568;
	bh=360IG2jfwxFw1WTPSRZ6nJZPwpI6Mglun8En0SJ3cAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DHpASlwIbgF8V8aSk6DhFc14OAxeCAu4m5h5GATSn6MrOFTbEskf3RoXudpE5+THn
	 iOXKbgqf4izZSFWEBCXN8KON26t71yr1wfMMl7Nd8rgWmxNUC+lRqrNt7+n8f2rtKu
	 WOTBnoeY4oXrfFiGD2SsaNaR7WdtzS6XYiIwz3IQMxRLXwP92QFsXXtLeVszCbrG4N
	 SPHQ5fWAycJtUym1C6F9/0WcDEv6NW7iR2eFJItSmnJVbV/Ttl+KeJXwEK6Zg+vxqB
	 Sbz6YuQ1ssjF2a/e/vDHA2ME25tifiow4hRXkBN/t4EKOslA9EmV9Dm7oarjZgrRQp
	 RbzqjhlJDYVsg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9EE6F88DEE;
 Sun, 20 Oct 2024 07:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729400566;
 bh=360IG2jfwxFw1WTPSRZ6nJZPwpI6Mglun8En0SJ3cAg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ecoHZPpbTXR9eqAFHjl5Q4TwqMEL1eBrcS6ZhnFTP+uiHKE3aHdn31YtqroBpYQ/G
 U2j/GW7rjREEJ2qBpZIJoCln6Yp27rQgVI63DQks+VqsWrXqBqLc/j/GANaktWOnof
 G+yoMbtXSG5wq5MLDUeBaullEdhfweZQO2jKYipXnGbDvUA6/xLRebNpJheqUv8Y/7
 t4M/oa7EYqmXj1H8wnNskRdZaMH1jmX4aab7SQ1GX5juYubl7dVj6DC7jZfvnx/pzr
 G9YPaDCxoMrCD+7aVtYA+vm00d1sggm3LbDvls5K4d5m/Bs4mVOOOq/EaRHYaBP5Mt
 ZXU9Ntm63CZ7g==
Message-ID: <5ba375a1-cf1d-463c-8590-3ddf46c47f3e@denx.de>
Date: Sun, 20 Oct 2024 04:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 michal.simek@amd.com, jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-3-l.rubusch@gmail.com>
 <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
 <CAFXKEHZLwbU=w4LH4iiZeo4ycwOKjgi5YZesHHgxzy6Ac+TOUA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHZLwbU=w4LH4iiZeo4ycwOKjgi5YZesHHgxzy6Ac+TOUA@mail.gmail.com>
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

On 10/18/24 11:47 PM, Lothar Rubusch wrote:
> On Mon, Oct 14, 2024 at 8:42 PM Marek Vasut <marex@denx.de> wrote:
> 
> [...]
> 
>>> diff --git a/board/enclustra/mercury_aa1/fpga.its b/board/enclustra/mercury_aa1/fpga.its
>>> new file mode 100644
>>> index 0000000000..cb42d61fbd
>>> --- /dev/null
>>> +++ b/board/enclustra/mercury_aa1/fpga.its
>>> @@ -0,0 +1,32 @@
>>> +/dts-v1/;
>>> +
>>> +/ {
>>> +     description = "FIT image with FPGA bistream";
>>> +     #address-cells = <1>;
>>> +
>>> +     images {
>>> +             fpga-periph-1 {
>>> +                     description = "FPGA peripheral bitstream";
>>> +                     data = /incbin/("../../../bitstream.periph.rbf");
>>> +                     type = "fpga";
>>> +                     arch = "arm";
>>> +                     compression = "none";
>>> +             };
>>> +
>>> +             fpga-core-1 {
>>> +                     description = "FPGA core bitstream";
>>> +                     data = /incbin/("../../../bitstream.core.rbf");
>>> +                     type = "fpga";
>>> +                     arch = "arm";
>>> +                     compression = "none";
>>> +             };
>>> +     };
>>> +
>>> +     configurations {
>>> +             default = "config-1";
>>> +             config-1 {
>>> +                     description = "Boot with FPGA early IO release config";
>>> +                     fpga = "fpga-periph-1", "fpga-core-1";
>>> +             };
>>> +     };
>>> +};
>>
>> Can this be generated using binman instead ?
> 
> This would a oportunity for me to learn the binman tool. Great idea! I
> need to read a bit more on binman to get a better understanding. I'll
> give it a try and let you know. Thank you.

This commit might help:

5fccc2891e28 ("ARM: dts: stm32: Generate u-boot.itb using binman on DH 
STM32 DHSOM")

