Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A6BCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 09:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146F8863F8;
	Sun, 17 Sep 2023 11:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="FXdp1ZmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BB8863F9; Sun, 17 Sep 2023 11:02:13 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405F58638B
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 11:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=Riyrm8ayByY6AgwcL2b6nT9D2XuuTWfFaqv2yiPgRtU=;
 b=FXdp1ZmYpwiHknblHcDg5XvZJ/vwSc1Bn7Mf8a9G3Kc9hznPob0vNf3IO7EYtFUsoQ7t
 HvZIlXlxzZDSB8/qHKs7W5KlO1xmNZF64krOo8yd4cuuEE6yk6TazO3Ogu+eQ3bjDiRfz1
 C9FXugBY2kY7M4NRVqLR6P0q/e7sNrijMMLZGl2JoJ4x6w2hhfwtKTjMMVQnOX+vH7+f6I
 u11v1GFvCEmSscootDopcF8wvMfAZoYuFwe92xWbSoaV1RkDVXzqzZiCzddfs40H4ZYFIu
 EaXXuGZDuuBEOvETqHm0n5WgjD+El/Ubu1D2s4WGEBExNexeNFTZtRDIUp7PrpdQ==
Received: by filterdrecv-66949dbc98-lxgt8 with SMTP id
 filterdrecv-66949dbc98-lxgt8-1-6506C091-3B
 2023-09-17 09:02:09.640263812 +0000 UTC m=+157662.344707093
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id hOypw7ZaTI-SU2ZVO_wtHw Sun, 17 Sep 2023 09:02:09.344 +0000 (UTC)
Message-ID: <fe07596e-9870-fe18-f5be-f8ccebdb6852@kwiboo.se>
Date: Sun, 17 Sep 2023 09:02:09 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
Content-Language: en-US
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
 <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
 <7e069c36-fe99-3701-9572-1363b694645b@kwiboo.se>
 <047fd798-5501-42fd-a5cb-ff1d84043f96@canonical.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <047fd798-5501-42fd-a5cb-ff1d84043f96@canonical.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h6+RHAY30DkspieLi?=
 =?us-ascii?Q?GdzuEBcaQZA+l1=2F1YRMc7bl4VCVNuzMg1ik0EQ=2F?=
 =?us-ascii?Q?AB+5PcBYs2NgBWEzHjyimAtOL5=2FlaFs+CRPBbAZ?=
 =?us-ascii?Q?NO3yCNrDyby33s55WkU+UmRVNsFw+VSSXuUh8yN?=
 =?us-ascii?Q?nKtOzB2eIJDvrgD6UDmzCtSCxoEZ4KLBDdZxUO?=
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Simon Glass
 <sjg@chromium.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Chanho Park
 <chanho61.park@samsung.com>, u-boot@lists.denx.de, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

On 2023-09-17 02:00, Heinrich Schuchardt wrote:
> On 9/17/23 00:19, Jonas Karlman wrote:
>> On 2023-09-06 14:00, Heinrich Schuchardt wrote:
>>> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
>>> prefixed header. We have referring to a vendor tool (spl_tool) for this
>>> task. 'mkimage -T sfspl' can generate the prefixed file.
>>>
>>> Use binman to invoke mkimage for the generation of file
>>> spl/u-boot-spl.bin.normal.out.
>>>
>>> Update the documentation.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> Tested-by: Chanho Park <chanho61.park@samsung.com>
>>> ---
>>> v2:
>>> 	Fix a typo in a comment in tools/sfspl.c
>>> 	Add Tested-by credit
>>> ---
>>>   .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
>>>   doc/board/starfive/visionfive2.rst                 | 14 ++------------
>>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>>> index 13f69da31e..defe2b605f 100644
>>> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>>> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>>> @@ -103,4 +103,14 @@
>>>   			};
>>>   		};
>>>   	};
>>> +	u-boot-spl {
>>> +		filename = "spl/u-boot-spl.bin.normal.out";
>>> +
>>> +		mkimage {
>>> +			args = "-T sfspl";
>>> +			blob {
>>> +				filename = "spl/u-boot-spl.bin";
>>> +			};
>>> +		};
>>> +	};
>>
>> This should probably be:
>>
>> mkimage {
>> 	filename = "spl/u-boot-spl.bin.normal.out";
>> 	args = "-T sfspl";
>>
>> 	u-boot-spl {
>> 	};
>> };
> 
> @Jonas
> If I replace the node u-boot-spl by the suggested mkimage node, I get a 
> file spl/u-boot-spl.bin.normal.out which is identical to 
> spl/u-boot-spl.bin. It lacks the header that mkimage should create.

You are correct, with the multiple-images prop in binman node each
subnode is treated as an image and not as an entry type node.
See tools/binman/image.py for some description of image type.

This means we need to have a wrapping image node and cannot directly
use an entry type node at top level under binman node.

> 
> Replacing the blob node by a u-boot-spl node is possible. Whether it is 
> better readable is a matter of taste.

The u-boot-spl entry type is meant to be used for referencing the U-Boot
SPL binary and should be preferred over a plain blob entry.

I would also suggest you name the image node something other then
u-boot-spl because it was easily confused with the entry type of same
name.

E.g. something like:

spl {
	filename = "spl/u-boot-spl.bin.normal.out";

	mkimage {
		args = "-T sfspl";

		u-boot-spl {
		};
	};
};

Regards,
Jonas

> 
> @Simon:
> Could you, please, have a look at doc/develop/package/entries.rst. It 
> seems not to fully describe how binman is controlled via the device-tree.
> 
> * A blob sub-node for the mkimage node is not described.
> * A mkimage node which is not a direct subnode of binman is not mentioned.
> * Why the target filename must be outside of the mkimage node in my case 
> is not evident.
> 
> Maybe a more formal description of the schema in a yaml file would help.
> 
> Best regards
> 
> Heinrich
> 
>>
>> Regards,
>> Jonas
>>
>>>   };
>>> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
>>> index 941899a0a4..f5575ab68b 100644
>>> --- a/doc/board/starfive/visionfive2.rst
>>> +++ b/doc/board/starfive/visionfive2.rst
>>> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
>>>   	make starfive_visionfive2_defconfig
>>>   	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
>>>   
>>> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
>>> -
>>> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
>>> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
>>> -the below command:
>>> -
>>> -	./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
>>> -
>>> -More detailed description of spl_tool,please refer spl_tool documenation.
>>> -(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool
>>> -
>>> -This will generate u-boot-spl.bin.normal.out file.
>>> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
>>> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>>>   
>>>   Flashing
>>>   ~~~~~~~~
>>

