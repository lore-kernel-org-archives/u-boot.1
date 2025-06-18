Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D7C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 23:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B696E82CCE;
	Thu, 19 Jun 2025 01:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F75882CBB; Wed, 18 Jun 2025 18:24:29 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6322E82CBC
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 18:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pom.pumba@gmail.com
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so7364507f8f.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750263866; x=1750868666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FomzvIx+1rHY1R3WltzquaF6RmrPt0M5v7vuhGZBfKE=;
 b=jgfwiVunSiQYoQs1Wa/oqGoq1J8xvb+H4Bi7Yn/3zByGGSkdJ9ts8fKoYZDnea4/ey
 dm2LV3AhM9DEknp6Y0kdLmjnJ/M6iV20dZaRi4ebib11josW/Jfrth2Fjh6mR6v2tHeu
 HMvj/jNVvSdFIrQyYTo7y4c/zxwZbO/4dpYubYisI11jWfpBDGthonTyvsrD6U2B+Qu/
 Rjv6JVGqrMcqg+5XCRJ5vcLijnQtrPvqintv6mHV7zmuyYXg790Dz7SL0JIGjlAsrxz+
 63A31tVCmOgVdpzgBI7Em6AiTOgX2N1meArpgsYELY1XGqCjIiQPx2tM2o4YkVu/0xNo
 V1fQ==
X-Gm-Message-State: AOJu0YxmeEd8XsAytpLIuwJyJituQXTXJ9DwWh1Jsed7yeuHR4EruFiY
 5Rp1ZJhvyDvsE3cLlyhh5YjbOayPRBoUHJDQQHNvrrR/W/ZGi7pUR3Zr
X-Gm-Gg: ASbGncu5eD/pnRcBgRHR4OPtdcknmGrZU52ffG3hmVBRa1WxNXf3LxZ9rVenItf5WSv
 k9BothChVseSw2MlUqjLEOj/mxhF31AnpOOf1hc4plNNyLuePdf1Sc0cbOjNasCfCsd75S+KyF4
 yyz7BMW02pK12WXlRP+4Y3WcJFZEh+af/6gFm0pi1VzMKj1aBA8/1MITyqgMJr22h9Encvu0qfM
 mVn6LrxCwQh96FJLCyM3jNJhgnskZyyBVefKLmm+UoeXjQ2gxBp2Dt1Z8b0U39GbFmGiW3yZrV3
 Bn/MOz/0AgKWfrboa9198MyLD0WOQcWNTNTj3YQziZssxNXY4rDgEt+QuIlxCrMJGS/y/KayqCS
 W6jMjwI+2pHKE8LSnEV+MRXJGzYF1da+q5xVpeMtdZIkWZDiseSJMtJA43UNLn6DCGweC3PllFq
 TN+gBUfDWQgg7EJST8Yg==
X-Google-Smtp-Source: AGHT+IEZvoUOFhrC7e0WUzX5382DiWwPo45NBBuhccmgcOd3+zC4oABgn+blrkAtnvbwnnAk+gWjBA==
X-Received: by 2002:a05:6000:22c2:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3a572e568b4mr14323856f8f.49.1750263865493; 
 Wed, 18 Jun 2025 09:24:25 -0700 (PDT)
Received: from ?IPV6:2003:e0:6f23:53cc:6065:ccf7:5e0:66a1?
 (p200300e06f2353cc6065ccf705e066a1.dip0.t-ipconnect.de.
 [2003:e0:6f23:53cc:6065:ccf7:5e0:66a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b47198sm17063854f8f.81.2025.06.18.09.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 09:24:24 -0700 (PDT)
Message-ID: <3a38f9b3-e8a1-41dc-b770-0af80b8ebc09@dietpi.com>
Date: Wed, 18 Jun 2025 18:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
 <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
 <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
 <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
Content-Language: en-GB, de-DE
From: MichaIng <micha@dietpi.com>
In-Reply-To: <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:11:17 +0200
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

Hi Quentin,

 > Please keep the ML in Cc.

Was too late for me yesterday :).

 > We currently have 137 defconfigs for Rockchip boards (git grep -l
 > ARCH_ROCKCHIP configs/ | wc -l), so not sure 3 is a reasonable 
threshold :)

I mean just for us/me, coding efforts and maintaining a patch, it is 
easier to do it right there, where it is done right now for ethaddr and 
eth1addr already for all Rockchip boards, instead of creating overrides 
for 3 particular boards. I hope an additional eth2addr is fine for now, 
until we found a better/more generic solution.

 > Now I see a possible issue in that. I believe the random MAC addresses
 > are constant across reboots for a given board since it's based on the
 > CPU ID. I am assuming we should be keeping this stable if we make the
 > thing more generic. Sunxi seems to be setting the first byte of the MAC
 > address depending on the ethernet controller index. Rockchip seems to be
 > XOR'ing the last bit of the last byte (and you were looking into
 > extending this to the 2LSB of the last byte for up to 4 addresses). So
 > we already have different expectations of how the random MAC addresses
 > need to be computed.
 >
 > We could have a generic implementation that is overridable for boards/
 > vendors or architectures (e.g. via weak symbols for example).

Yes, whatever we do, it should be a non-breaking addition, at last for 
now, just generating those MAC addresses for existing ethernet* aliases, 
which have no related variable assigned yet. And seeing the different 
approaches on getting the first/initial ethaddr to derive further ones 
from, I think a new generic method needs to work on top of an existing 
ethaddr variable, generated in current board-specific way, or defined in 
boot env/script.

I also wondered about sunxi adjusting the first byte. Since the first 
block contains also unicast/multicast bit etc, I would always prefer 
varying addresses from the back, so the same method can theoretically be 
continued for a lot more MAC addresses, before running into bits we must 
not change. We can assign already 16 MAC addresses with the last xdigit 
only, when incrementing the bitwise mask by 1 each iteration, and apply 
it on the original ethaddr each time? And as far as I can think about 
it, incrementing it further to span the second last xdigit, hence the 
whole last MAC address block, would work just the same way, able to 
handle ethernet0 - ethernet255, theoretically.

 > Not sure to understand what you want to do here or what's the issue 
sorry.
 >
 > You need also eth*addr for use in U-Boot (if you do PXE, TFTP, ping,
 > whatever involving networking) so it makes sense to have them in U-Boot
 > DT as well.

U-Boot assigns those variables to ethernet aliases on its own device 
tree as well? Would be reasonable, but for me this is minor. At least I 
did not hear from a case where someone was complaining about a random 
MAC address for network boot.

What I aim for is U-Boot assigning static MAC addresses to ethernet 
aliases defined in/for the kernel device tree, better in a more generic 
than specific way, so it does not need to be changed again each time a 
new SBC (with new SoC) with multiple onboard Ethernet adapters arrives. 
Adding the aliases to the kernel device tree is then a different topic, 
not related to U-Boot, which I however aim to achieve upstream as well. 
If U-Boot syncs these back, it allows static MAC addresses for related 
adapters in U-Boot phase as well, of course.

 > U-Boot may point to ethernet1 in kernel for example, in which case MAC
 > addresses may all get swapped between U-Boot and kernel. This is
 > theoretically possible, not sure how likely it is to happen though.

That could happpen already now with the often at least 2 aliases 
defined. I wonder whether it can cause issues with PXE boot etc. In the 
cases I know, a dedicated dtb is shipped as well, and I am not even sure 
whether the network connection remains the same between U-Boot phase and 
kernel phase? In any case, as long as any new generic MAC assignment 
does not overwrite existing eth*addr variables, and does not generate 
new/different MAC addresses for ethernet* aliases which have a related 
eth*addr variable, it should not be able to break anything, but only 
turns all those MAC addresses to static, which are otherwise random.

Best regards,

Micha (aka MichaIng)
DietPi project lead

Am 18.06.2025 um 11:49 schrieb Quentin Schulz:
> Hi Micha,
> 
> Please keep the ML in Cc.
> 
> On 6/18/25 3:05 AM, MichaIng wrote:
>> Hi Quentin,
>>
>>  > I didn't mean to suggest to have this as part of the boot script. 
>> Board
>>  > file (for me) is any file in the board/ directory which applies to a
>>  > board. See board/theobroma-systems/ringneck_px30 for example.
>>  >
>>  > There you could replace misc_init_r entirely, or define your own
>>  > rockchip_early_misc_init_r (like I do in board/theobroma-systems/
>>  > ringneck_px30/ringneck-px30.c for example) or add a
>>  > rockchip_late_misc_init_r callback after the ethernet addresses if you
>>  > want?
>>  >
>>  > That's what I was suggesting essentially.
>>
>> Ah I see. Since it affects 3 different Rockchip boards relevant for 
>> me/ us, potentially more, doing it for all Rockchip boards seems 
>> reasonable, 
> 
> We currently have 137 defconfigs for Rockchip boards (git grep -l 
> ARCH_ROCKCHIP configs/ | wc -l), so not sure 3 is a reasonable threshold :)
> 
>> at least less code in one place. I will probably start to work on the 
>> Orange Pi R2S soon, a RISC-V board with 4 Ethernet adapters, which 
>> will most likely have random MAC addresses as well. So actually I 
>> would vote for a more generic solution which works the same way on all 
>> hardware. I 
> 
> I am not too fond of how we handle the random MAC addresses in Rockchip 
> either, we should be able to make this more generic indeed.
> 
> Now I see a possible issue in that. I believe the random MAC addresses 
> are constant across reboots for a given board since it's based on the 
> CPU ID. I am assuming we should be keeping this stable if we make the 
> thing more generic. Sunxi seems to be setting the first byte of the MAC 
> address depending on the ethernet controller index. Rockchip seems to be 
> XOR'ing the last bit of the last byte (and you were looking into 
> extending this to the 2LSB of the last byte for up to 4 addresses). So 
> we already have different expectations of how the random MAC addresses 
> need to be computed.
> 
> We could have a generic implementation that is overridable for boards/ 
> vendors or architectures (e.g. via weak symbols for example).
> 
>> see the argument to not bloat the environment with often unused 
>> variables, so makes sense to generate those MAC addresses on demand only.
>>
>> As you mention misc_init_r, I see sunxi boards override/use it to do 
>> it more that way: check for aliases ethernet0-4 in a loop, and 
>> generate an eth*addr variable only if the alias exist, and the 
>> variable does not: https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Fboard%2Fsunxi%2Fboard.c%23L776- 
>> L795&data=05%7C02%7Cquentin.schulz%40cherry.de%7C464204d1dfa844099a4208ddae0443dc%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638858055555459309%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FD%2Fr88eFxZY%2Bf%2FMafL6AftJVswiA4uVClC1Hqn3xM1M%3D&reserved=0
>> But since it generates variables, I assume it is called before boot 
>> scripts and hence is based on the ethernet* aliases defined in U- 
>> Boot's device tree, rather than the kernel device tree, right? I mean 
>> I aim to 
> 
> Yes. Remember that some boards do use U-Boot DTB as kernel DTB as well, 
> so it's not that easy of a shortcut for everything supported by U-Boot.
> 
>> send Linux patches to add those to respective device trees as well, 
>> if/ once this U-Boot patch gets merged, and those might be synced back 
>> into U-Boot device trees. But since this is all done on/for the kernel 
>> device tree, I would prefer it to depend on kernel dtb aliases only.
>>
> 
> Not sure to understand what you want to do here or what's the issue sorry.
> 
> You need also eth*addr for use in U-Boot (if you do PXE, TFTP, ping, 
> whatever involving networking) so it makes sense to have them in U-Boot 
> DT as well.
> 
> You can anticipate ethernet aliases being in DT of future Linux kernel 
> releases by adding a temporary -u-boot.dtsi with a few properties in / 
> chosen/aliases matching the ones in the Linux kernel. Once synced you 
> can remove them. Note that obviously unless your system uses the exact 
> same binary for U-Boot DTB and kernel DTB, you cannot guarantee that the 
> aliases will point to the same controllers for example, so ethernet2 in 
> U-Boot may point to ethernet1 in kernel for example, in which case MAC 
> addresses may all get swapped between U-Boot and kernel. This is 
> theoretically possible, not sure how likely it is to happen though.
> 
>> Wouldn't it be possible to generate and generate and apply the MAC 
>> addresses [here](https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Fboot%2Ffdt_support.c%23L645- 
>> L664&data=05%7C02%7Cquentin.schulz%40cherry.de%7C464204d1dfa844099a4208ddae0443dc%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638858055555480725%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zes5ZQmR4du9dygIIf6HLT2cVO5yWR2b5dwbaLzpWDA%3D&reserved=0), hence for all actually existing aliases, and only as fallback if the respective eth*addr variable is not set?
>> If the method for obtaining the first ethaddr differs between boards, 
>> it could still rely on an existing ethaddr variable, to derive 
>> different MAC addresses for each ethernet* alias index in a consistent 
>> way.
>>
> 
> I guess. I would rather have a fallback whenever env_get(mac) doesn't 
> return successfully, in which case you can attempt to generate one 
> randomly based on some callback. This would cover the case when you have 
> a kernel DT with etherent aliases not present in U-Boot DT, this is 
> reasonable for boards with adapters covered by Device Tree Overlays for 
> example, which don't need to necessarily be applied on U-Boot DTB.
> 
> Cheers,
> Quentin
> 

