Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A0ACA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51F786776;
	Fri,  1 Sep 2023 12:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693564343;
	bh=Z2EiQVaOnE7dUjocT7p3eXWy0zOrZ7orrRJgpdq7Q/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eo+ibLN7aaBWj8Nv6M8LVtEgH5lg53o1ooydwO8R47QjrIQ09Wo/vVD6rBSj2O49D
	 xCQNWhnViUwwt5SmZqG84A9e/PhSMDT3BLJ8xAgHlmrbtDrpX4Q0Aw3yMxEoQz+sLc
	 EHpCheWBlI1+hRR9Esgx09U0xT7Lzfkt8Rhmlv6rpZMDvbt00imqCIQ4Lbl8BRhxGq
	 CZRkUO0CKSbimzfkbJ1hE227jWcRUQUIdSavh27wXca1xR8Gi6IH6skobr/Ac9/oUO
	 DRYP19X7KiqD6U+06OlLxAPGLejy/SM9GpJcnET4h64CEwvYgYtjp7sO8W+h6FKhZp
	 cisIdfj65LCAw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8053A8074B;
 Fri,  1 Sep 2023 12:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693564342;
 bh=Z2EiQVaOnE7dUjocT7p3eXWy0zOrZ7orrRJgpdq7Q/o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Cg/Divgi2JnazKu7NgiHEbHc+lkemHgGsuLEK7c5othgBco5HjnrDx4Rlo9EEMlui
 S8iNcCuK9hBVkURDqzpgjSYla6iD1a1BRceAL1BVGFBNeJdlEVMjqaWA1qEItSBuOI
 9lR8WNxJc4TMnVnMcFV9J0w69aPXfGCiNdcV7dgNew22NZDgHMUWZLLhmPhdgGmDod
 z7khPxNBdRb6Y8ru9mfd9vj38rwGUNIWsz6iHfuACF+0BXjotuH+H3fhMl10LCnXnj
 RHGyLB7IqEpL7FEEnZ/UWVeeW8rPJ9WGA/NPmIXCPaoCke6k2TiDHU6RHcuVW33nma
 S+JR1m5up6qHA==
Message-ID: <8b2463ac-897d-e93e-fc92-751dcb9a70bd@denx.de>
Date: Fri, 1 Sep 2023 12:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] usb: gadget: sdp: Option to enable SDP read register
 command
To: Loic Poulain <loic.poulain@linaro.org>
Cc: lukma@denx.de, u-boot@lists.denx.de
References: <20230813083912.532982-1-loic.poulain@linaro.org>
 <a00ee265-d65f-f15b-48a0-4112b7e762dc@denx.de>
 <CAMZdPi9fupGqHhEOH_kTREUUOzmrCCZPbVbK5u5JGwRHTuMeFA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAMZdPi9fupGqHhEOH_kTREUUOzmrCCZPbVbK5u5JGwRHTuMeFA@mail.gmail.com>
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

On 9/1/23 12:03, Loic Poulain wrote:
> Hi Marek,
> 
> On Mon, 14 Aug 2023 at 01:53, Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/13/23 10:39, Loic Poulain wrote:
>>> The SDP read register command can be used to read any memory
>>> mapped address of the device (ddr, registers...). It can then
>>> be exploited by an attacker to access sensitive data/values,
>>> especially when running SDP from SPL, as SPL runs with highest
>>> privileges in ARM secure mode.
>>>
>>> Without read, SDP still useful to bootstrap and jump on (signed)
>>> blob such as u-boot with write and jump commands, but reading
>>> is optional in that case (debug purpose).
>>>
>>> NXP SoCs usually have a dedicated SDP_READ_DISABLE fuse to disable
>>> SDP read command in their ROM SDP implementation, so it seems quite
>>> reasonable to make it optional from u-boot/spl as well.
>>
>> If there is a fuse, why not read the fuse and disable READ based on that
>> fuse instead ?
> 
> Well, fuse is more a way to tune a specific ROM code here, not the software.

The way I read the commit message, when the fuse is set, the READ 
functionality should be disabled, to avoid any READs, right ?

> It would be more generic to make it a build config like other features, and one
> may purposely force SDP READ in SPL, even if disabled at ROM level. That
> said we could also introduce a weak board_sdp_read_allowed() function...
> 
> Let me know what you prefer.

I think the weak default function would be a good approach.

[...]
