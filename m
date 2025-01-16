Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E5C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 08:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D0380283;
	Thu, 16 Jan 2025 09:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aWIc91nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829D08033D; Thu, 16 Jan 2025 09:37:08 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DDA80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 09:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso3361385e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737016624; x=1737621424;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wT93VTjLPoRWMn4Zdh5ylA3zq4qOOd25G+GzQvAleVw=;
 b=aWIc91nzYrEQV4Im2pIujHIUX9iLL3se2z1OGl5sf+FrfcgM4YsHDNcJcOM6RWtmdA
 WEOdJogPa5d/abH6hFrYnIotlnq6JPJm0ZhHwmPieqEFJfeSgPNhz5fY6AUlHkeCqZM3
 Q2pZMI9JPg/ukO/1hFqY3o13wQnB2DSD3ftOqwFNt0sPPi+2nNL6hzwp+AJQGL2ePSED
 N5DH6zCNOZtwx1YgGIyhMaY+MGYTP08D0PlTB91xmLhjMTe2fydYD8o/JO1YIb6zyGT0
 zonxpCnAgQfiDmxZ1kdRmEB7dzzCxoBWMLCpWo1BOsaaHpKiQ8iWjJlHXwMkVpqxlKFe
 Sb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737016624; x=1737621424;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT93VTjLPoRWMn4Zdh5ylA3zq4qOOd25G+GzQvAleVw=;
 b=lUqKEPth8FxKfT/aGJTf0WB54sduHg2Opl+Jm6gyQ7I61kzFOF4YKnWuBrHwplWqqd
 CGkNSyR5oZ6iamfE4TLLHpv6WnhXUiijzZbTqEKkTyDXzhlMC+rnhPbfZ8Qg0JOiVbaS
 aklwiz3Pk9zaimr+q/rE2Wp6WdrxCm11Kc1YVcMUgrgew+aO+yV/qbv6vY4KMHcafMU0
 BDqh6H5UwGO/e18uZS6R2L6dcTegLL2yBZxikuokmOcTJ0dxZNqoFgg8+994dmipm6SN
 XGepeJwT/XeQOYo56b+FqaQYnsCHeGrzPe5J++HPTv0Diy8Z5S+2ZP45Iqh7X/l9TBPk
 9oRA==
X-Gm-Message-State: AOJu0Yxrd+ehE1iDHWo+9fdLN8i3yHXYhwnpRQfciOSqfB6zylbP0LFt
 Zjz+eih72wWcGirCSKniE7It/k1xm1yK4Ou/ydG96u09nYO8156VXcmjs0L9rac=
X-Gm-Gg: ASbGncsOtZD+BzXbwU6CERpyXImz2/CB7Bv/hIGTdoyY0LYbftEVkkJqtQMcptXgxkt
 1FNuUTMrDNQTzn8Vaau3fIeGXbaLOQe8jSP6f3tIe/IwnjLod4JwLPrsDadY5O2CREU4BW76Ksg
 XrW7AsotxkjenunfQ2y069JZMHmlHn5tYHrMoVkSVU5KZmCQk8Tmwwukcmw+IzMBku/M0sKIsg3
 qBA+TVF5vxqGwfLIaPHdVkmTzK8DwEWi9TDrJSqLcZTUGooWZyhHQwnzxPu97UO3A==
X-Google-Smtp-Source: AGHT+IEFcJ0Whh05uuA/2IEJaiV+7zkOi8kAqkG1NenqvxZBwR50+s3pfYvDNQT5bMi4vLqXIUUFUw==
X-Received: by 2002:a05:600c:138f:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-436e26a88d9mr309259145e9.12.1737016623305; 
 Thu, 16 Jan 2025 00:37:03 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753bee8sm51726305e9.34.2025.01.16.00.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 00:37:02 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jon Humphreys <j-humphreys@ti.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com, Sughosh Ganu <sughosh.ganu@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
In-Reply-To: <86frmk4mhd.fsf@udb0321960.dhcp.ti.com>
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com> <86frmk4mhd.fsf@udb0321960.dhcp.ti.com>
Date: Thu, 16 Jan 2025 09:37:01 +0100
Message-ID: <87tt9z889e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Jon,

Sorry for the (very) late reply. I had some long holidays in between and
since this is a difficult topic for me, I kept pushing this to the end
of my backlog.

On mer., d=C3=A9c. 18, 2024 at 17:09, Jon Humphreys <j-humphreys@ti.com> wr=
ote:

> Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:
>
>> Hi Jonathan,
>>
>> Thank you for the patch.
>>
>> On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-humphreys@ti=
.com> wrote:
>>
>>> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
>>> variable is dynamically set when initializing the DFU entities, which is
>>> done as part of normal flow of a DFU operation.
>>>
>>> The USB DFU boot support will set it's own specific value for dfu_alt_i=
nfo
>>> before performing the DFU operation. This means that if
>>> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment variab=
le
>>> that the USB DFU boot path had set is overwritten, causing USB DFU boot=
 to
>>> fail.
>>>
>>> Likewise, if the user sets their own value for dfu_alt_info, say at the
>>> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is enabl=
ed.
>>>
>>> This patch will first check that dfu_alt_info isn't already set before
>>> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.
>>
>> To me, this is a policy change: before we could override the environment
>> via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info" is alre=
ady
>> set in the environment).
>>
>> Also, it seems that this change goes against the uefi doc which states:
>>
>> """
>> A string is defined which is to be used for populating the
>> dfu_alt_info variable. This string is used by the function
>> set_dfu_alt_info. Instead of taking the variable from the environment,
>> the capsule update feature requires that the variable be set through
>> the function, since that is more robust. Allowing the user to change
>> the location of the firmware updates is not a very secure
>> practice. Getting this information from the firmware itself is more
>> secure, assuming the firmware has been verified by a previous stage
>> boot loader.
>> """
>>
>> See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#performing=
-the-update
>>
>> Moreover, looking at various boards that implement
>> set_dfu_alt_info(), we can see different behaviours:
>>
>> Boards examples that won't override "dfu_alt_info" via
>> set_dfu_alt_info() if "dfu_alt_info" is already set via environment
>>
>> * board/xilinx/zynq/board.c
>> * board/emulation/common/qemu_dfu.c
>>
>> Boards examplesthat will always override the "dfu_alt_info" via
>> set_dfu_alt_info():
>>
>> * board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
>> * board/ti/am62px/evm.c
>>
>> Since set_dfu_alt_info() is a board specific callback, why can't this
>> logic be implemented for boards that want this behaviour change?
>
> Because I would then need to duplicate the same logic for every board that
> wanted both USB DFU boot and EFI capsules to work.  And the paramters
> passed in do not allow the function to know the use case (am I DFU booting
> or updating EFI capsules?).  See more below.

I understand that duplicating logic for every board you maintain is not
optimal, however, it gives each vendor the freedom of implementing their
policy.

I've added a couple of folks who I think could help giving their opinion on=
 EFI capsules/policy.

Heinrich, Ilias, Sugosh, do you have any opinion on this patch?

>
>>
>> Regards,
>>
>> Mattijs
>>
>>>
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>> ---
>>>  drivers/dfu/dfu.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
>>> index 756569217bb..ab8abae1d89 100644
>>> --- a/drivers/dfu/dfu.c
>>> +++ b/drivers/dfu/dfu.c
>>> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char *=
devstr)
>>>  	dfu_reinit_needed =3D false;
>>>  	dfu_alt_info_changed =3D false;
>>>=20=20
>>> +	str_env =3D env_get("dfu_alt_info");
>>>  #ifdef CONFIG_SET_DFU_ALT_INFO
>>> -	set_dfu_alt_info(interface, devstr);
>>> +	if (!str_env) {
>>> +		set_dfu_alt_info(interface, devstr);
>>> +		str_env =3D env_get("dfu_alt_info");
>>> +	}
>>>  #endif
>>> -	str_env =3D env_get("dfu_alt_info");
>>>  	if (!str_env) {
>>>  		pr_err("\"dfu_alt_info\" env variable not defined!\n");
>>>  		return -EINVAL;
>>> --=20
>>> 2.34.1
>
> Mattijs, thanks for the thorough reply.  I did wrestle a lot with how wide
> of a fix to propose for this problem, and in the end, decided on the narr=
ow
> fix of simply preventing the overwriting of the variable.
>
> Yes it is a policy change, but the policy is already unclear, inconsisten=
t,
> and confusing, IMO.
>
> For example:
> 1) EFI capsule update wants to very strictly control the dfu alt values
>    by setting it in set_dfu_alt_info(), but then any other DFU use
>    case breaks.  USB DFU boot is now broken.
> 2) The behavior the user sees wrt the dfu_alt_info env variable is very
>    confusing and non-intuitive. Take this example:
>
> =3D> env set dfu_alt_info "sf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 880=
00 100000"
> =3D> env print dfu_alt_info
> dfu_alt_info=3Dsf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000 100000
> =3D> dfu 0 list
> DFU alt settings list:
> dev: SF alt: 0 name: tiboot3.bin layout: RAW_ADDR
> dev: SF alt: 1 name: tispl.bin layout: RAW_ADDR
> dev: SF alt: 2 name: u-boot.img layout: RAW_ADDR
> =3D> env print dfu_alt_info
> dfu_alt_info=3Dsf 0:0=3Dtiboot3.bin raw 0 80000;tispl.bin raw 80000 20000=
0;u-boot.img raw 280000 400000
> =3D>
>
> As you can see, the user set's the dfu_alt_info variable according to the=
ir
> specific use case, then simply tries to list the DFU alt settings, and
> because this code goes through the dfu_init_env_entities() path, it gets
> changed to the EFI capsule settings.
>
> I was hoping to get a simpler fix in now so we can get USB DFU boot worki=
ng
> again, and we can visit the overall policy design next.  As you suggest, I
> could also push the testing of overwriting into the board specific
> set_dfu_alt_info() function, but then I need to duplicate the code in 8
> different places for the TI boards, and other vendors may still have the
> problem.

I agree that the above behaviour is confusing and I'm reconsidering to
take up this patch. I'd like some buy-in from either Heinrich, Ilias or
Sughosh on this since I'm not 100% confortable with the "policy change"

>
> Looking to the longer term solution, here are my thoughts.
> 1) We need to decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.  The on=
ly
>    reason TI boards are now setting CONFIG_SET_DFU_ALT_INFO is because EFI
>    capsule update is enabled.  Outside of a few legacy uses (I think - it
>    appears they were introduced prior to supporting multi-interface dfu a=
lt
>    strings), I think this is true for other vendor's boards as well.
> 2) Have EFI capsule support do as USB DFU boot does today, and set the
>    dfu alt string it wants used *before* initiating the DFU operation.  W=
ith
>    CONFIG_SET_DFU_ALT_INFO no longer enabled, the value it set will not g=
et
>    overridden.
> 3) Have the actual value of the dfu alt string used in the DFU operation =
be
>    passed in, rather than read from the dfu_alt_info environment variable.
>    The USB DFU and EFI capsule use case will pass in the dfu alt string
>    they want. The standard 'dfu' command can pass in the value of the
>    dfu_alt_info env variable. Note that this effectively decouples the dfu
>    command from the alt settings that USB DFU boot and EFI capsules use,
>    but I think this is what we want.
>
> This then allows both USB DFU boot and EFI capsule use cases to work as
> intended and allows the dfu command to operate on the user defined
> dfu_alt_info value.
>
> I welcome comments from those that have the history and intended behavior
> background of the DFU support :).

I do as well. I have taken over maintaince on this subsystem a year ago
and have not had much patches/work done on the subsystem. Therefore I'm
not as knowledgeable as I would have liked to be. I'm sorry about that.

>
> I also welcome comments on how to proceed for 2025.01. Should we live with
> USB DFU boot broken until we get the long term fix in, or ok with the pat=
ch
> posted here. The patch posted here does allow for a user to change EFI
> capsule's dfu alt settings, as Mattijs says, but especially given capsules
> can be authenticated, I'm not sure how this would be exploited, and if th=
at
> risk is worse that broken DFU boot.
>
> thank
> Jon
