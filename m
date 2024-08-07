Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72108C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22CB88D55;
	Wed,  7 Aug 2024 16:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723041628;
	bh=flMV7l/ZOFmd35RGfzKj9IFeccGzAaZEO8p1wAfMk80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ArtcwVLmB1RXb0MpTt47IscJC8iwXnzzQv1756PJaOr48mjyTXx2p5GCHs6QmV9g+
	 lp+9kAoD1Skb9OdxlfVf0hsXUk25WHs1IiAa778h3xJ5ld246+6HZX+dElis1Bd9H5
	 Ja2EqV/iWd3lvH5AjKbAxUaVDmLtxEW3N2uEn8FjIKyJ79fcdMUUOQsxuIiJ66rrVl
	 sQR2BVZr2V4sT/g5aUmKfDOFcuAv1IsnR+HyTm0xBL1qDfWYlX5jMT3OEp4LzHbxJ1
	 k4rwfOZFqtXQjEqnpkaV1CIhoYSqP6n7MYKM0RdKVf21Zq5XBVBMLz4onoOpsgIyuf
	 Pnu8QM4TyFLjg==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D2B188872E;
 Wed,  7 Aug 2024 16:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723041626;
 bh=flMV7l/ZOFmd35RGfzKj9IFeccGzAaZEO8p1wAfMk80=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=NUj1L3e3So+g/oxiHglZYm74o/HoV/FAUTiSadqHf6leLUTwAnHAvUEzOYugbMPTV
 CqMDu7lLpLEd2qXvOWl3Hyybanw3P2B+uGscwBsnZVGqZE3pUAGmMvNEZWBpkbWEEF
 ADGHibnSngcp1Xc0ntgKGrJnhccVk3/7CTX2niD3lxlpnzvUeYSw8HjCkHpn6hpKDK
 J65HxebH9qEKJ6bAgPE9gO7Ik/HH54gAIENALClM0x4s3sSO62zqKiU3r2833NjjqQ
 EwDh6C+eXIqcSJAElUrnwhEFPtRcre9xQz9Qx9Du35MDyhjwbvUCTQ9EnT5crOWjxL
 08q4arKsMGS/Q==
Message-ID: <2f631eef-4886-9ef4-8dcb-09c1378ec2f1@denx.de>
Date: Wed, 7 Aug 2024 16:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCHv2 3/3] i2c: imx_lpi2c: Support read transfers longer than
 256 bytes
Content-Language: en-US
To: Fedor Ross <fedorross@gmail.com>
Cc: u-boot@lists.denx.de, Fedor Ross <fedor.ross@ifm.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
References: <20240730152529.143651-1-fedor.ross@ifm.com>
 <20240730152529.143651-3-fedor.ross@ifm.com>
 <ae537f45-a55f-fe39-bb3f-3d0fbf4603b1@denx.de>
 <CAEGWRBD3TMH-LPrXtvnuHheL=Pnzn9PCVs=6hyujDfoWjb7Jvw@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAEGWRBD3TMH-LPrXtvnuHheL=Pnzn9PCVs=6hyujDfoWjb7Jvw@mail.gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fedor,

On 07.08.24 16:13, Fedor Ross wrote:
> On Wed, Aug 7, 2024 at 12:50 PM Heiko Schocher <hs@denx.de> wrote:
> 
> Hello Heiko,
> 
>> On 30.07.24 17:25, fedorross@gmail.com wrote:
>>> From: Fedor Ross <fedor.ross@ifm.com>
>>>
>>> The TXFIFO register of LPI2C only has one byte length, and if the length
>>> of the data that needs to be read exceeds 256 bytes, it needs to be
>>> written to TXFIFO multiple times.
>>>
>>> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
>>> ---
>>> Cc: Heiko Schocher <hs@denx.de>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Marek Vasut <marex@denx.de>
>>> ---
>>>
>>> Changes in v2:
>>> - Add additional '---' below SoB line to separate Cc list. This way it
>>>     does not get included in the commit message when the patch is applied.
>>> - Prefix 'CHUNK_DATA' macro with 'LPI2C_' to namespace it.
>>> - Do bit manipulation in writel() function directly and drop the
>>>     'val = assignment' .
>>>
>>>    drivers/i2c/imx_lpi2c.c | 71 ++++++++++++++++++++++++++---------------
>>>    1 file changed, 46 insertions(+), 25 deletions(-)
>>
>> Patch breaks world build, see for example
>>
>> https://dev.azure.com/hs0298/hs/_build/results?buildId=114&view=logs&j=9261107f-b16b-528d-034d-a5b366785bfc&t=aa057498-3634-5fad-2ef8-82ed58702aca&l=1197
>>
>> Find the whole pipeline (with other patches too...)
>>
>> https://dev.azure.com/hs0298/hs/_build/results?buildId=114&view=results
>>
>> Could you take a look please?
> 
> Done.

Thanks!

> Sorry for the inconvenience.

No problem.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
