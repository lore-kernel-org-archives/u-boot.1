Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E31EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 06:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0618696B;
	Thu, 17 Aug 2023 08:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="czUhzrTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52D186A11; Thu, 17 Aug 2023 08:25:42 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060FC8693D
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=4ggx+1mkSa5MeaCAKEzKqnNzMFCjcU1uLlHTexy2IJw=;
 b=czUhzrTQ0jnUYD8taZdudNAbtZ5S7r7dc41Fi2rU6GXkLCFMeJw/eHNMqfLyxj28Zk15
 3oW1tfu+ev1iWXAmMxPEMcsjh6GeD5KIdoP3gtCjdysDeckn/W/suM0rHZBoQ7oWPeu98d
 Y9Q+XZTo1nPaBmdndZ9JhP0cQzDTWtlY8AcEX4PZTqGg8jr1tfpex3bgQM/8pd93UuxXxZ
 MGmdeGelqF9i8raap3o5fBKp3agYcFm7UIKrpl2wLR9G5xwgdj5VMYelEcTK7xfBtHT8Y1
 1CXInnM6O15NmqETSsReznacpLe/uo/8jjHVGPxrBzpUz7Ru8oiJ4Mdlf+e+aGTw==
Received: by filterdrecv-d7bbbc8bf-7m5fp with SMTP id
 filterdrecv-d7bbbc8bf-7m5fp-1-64DDBD62-1C
 2023-08-17 06:25:38.561825887 +0000 UTC m=+8491561.710795732
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id L80us4P8SV-ao96p_yAE3A Thu, 17 Aug 2023 06:25:38.193 +0000 (UTC)
Message-ID: <54280a6b-baa7-0885-26a6-0601d3a2a270@kwiboo.se>
Date: Thu, 17 Aug 2023 06:25:38 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation
References: <20230805133208.788000-1-jonas@kwiboo.se>
 <CAPnjgZ216Mm5cv=NhmPdqGiGKjzc3fte4fVAcMLYwwZhq6gbVA@mail.gmail.com>
 <CAPnjgZ0yq8-pm-HQuKy2vUK5i92zmJZwsYxHeoS-4e51ERZcNg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAPnjgZ0yq8-pm-HQuKy2vUK5i92zmJZwsYxHeoS-4e51ERZcNg@mail.gmail.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h9jyQ122dslzTLngD?=
 =?us-ascii?Q?PL96illmr8hquUcPl4frrvrJzVP2eS=2FgKy+DLTp?=
 =?us-ascii?Q?Ounis1uwaEYm4JQeHgy0NBrghJlLZQAs8VmyMYr?=
 =?us-ascii?Q?BBGWw3nLicJ472SgXoFTXWG49kil4yCjSNtXuNu?=
 =?us-ascii?Q?yYS+=2FM+VeIaplULkxY1ewC+TTNWhYbHa=2FBCc9h?=
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

On 2023-08-17 00:29, Simon Glass wrote:
> Hi Jonas,
> 
> On Tue, 8 Aug 2023 at 20:03, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Jonas,
>>
>> On Sat, 5 Aug 2023 at 07:32, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> Devices for nodes with e.g. bootph-pre-ram are initialized three times.
>>> 1. At SPL stage (always bind and probe only if used)
>>> 2. At U-Boot proper pre-reloc (always bind and probe)
>>> 3. At U-Boot proper normal (always bind and probe only if used)
>>>
>>> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
>>> with a pre-reloc status only after U-Boot proper pre-relocation stage.
>>> This prevents the device from being probed at U-Boot proper pre-reloc.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> I am not sure if U-Boot proper pre-reloc behaves like this by design and
>>> if there is some other way to signal that a device should not be probed
>>> during U-Boot proper pre-reloc stage if it has been probed at SPL stage.
>>>
>>> For my use-case I added bootph-pre-ram prop to my RK8xx device node to
>>> make the PMIC usable in SPL. However, I have no need for this device to
>>> probe at U-Boot proper pre-reloc stage just after jumping out of TF-A.
>>> And moments later bind and probe yet again at U-Boot proper normal stage.
>>>
>>> The bootph-pre-ram prop was used to have the device usable in SPL, else
>>> I could have used bootph-all or added bootph-some-ram prop to indicate
>>> use at U-Boot proper pre-reloc stage.
>>
>> This is changing how things work...we really need to have something
>> explicit to use this new behaviour. Perhaps we can augment the binding
>> in some way?
> 
> I had another look at this. The binding seems to be silent on this
> point, so I believe this patch is correct.

I agree, the documentation for binding and also for driver model make
this a little bit unclear:

"""
... Only drivers marked with DM_FLAG_PRE_RELOC or the device tree
‘bootph-all’ property are initialised prior to relocation. ...

...

It is possible to limit this to specific relocation steps, by using the
more specialized ‘bootph-pre-ram’ and ‘bootph-pre-sram’ flags in the
device tree node. For U-Boot proper you can use ‘bootph-some-ram’ which
means that it will be processed (and a driver bound) in U-Boot proper
prior to relocation, but will not be available in SPL or TPL.
"""

However the documentation for ofnode_pre_reloc contradict this a little:

"""
There are 4 settings currently in use
- bootph-some-ram: U-Boot proper pre-relocation only
- bootph-all: all phases
Existing platforms only use it to indicate nodes needed in
SPL. Should probably be replaced by bootph-pre-ram for new platforms.
- bootph-pre-ram: SPL and U-Boot pre-relocation
- bootph-pre-sram: TPL and U-Boot pre-relocation
"""

Should I send a v2 of this and drop the "and U-Boot pre-relocation" from
function doc comment? And do we need a new Kconfig option to enable or
opt-out of this new/changed/fixed behavior?

Regards,
Jonas

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> 
>>
>>>
>>>  drivers/core/ofnode.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>>> index 8df16e56af5c..ebd5a408ae58 100644
>>> --- a/drivers/core/ofnode.c
>>> +++ b/drivers/core/ofnode.c
>>> @@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
>>>          */
>>>         if (ofnode_read_bool(node, "bootph-pre-ram") ||
>>>             ofnode_read_bool(node, "bootph-pre-sram"))
>>> -               return true;
>>> +               return !!(gd->flags & GD_FLG_RELOC);
>>
>> I believe that the compiler knows how to convert 'gd->flags &
>> GD_FLG_RELOC' into a bool, so !! is not needed.
>>
>>>
>>>         if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
>>>                 /* detect and handle old tags */
>>> --
>>> 2.41.0
>>>
> 
> Regards,
> Simon

