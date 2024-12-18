Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4667E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 23:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E973802EF;
	Thu, 19 Dec 2024 00:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e3t+55so";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B208022B; Thu, 19 Dec 2024 00:09:44 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F5080241
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 00:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIN9ZBn4189587
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 17:09:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734563375;
 bh=WFnUuO/gcMwsgq0jqhB3kRymMD52888Mt9CMuSLJ70s=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=e3t+55soBiXzJXg/ppImtsmlDpyImUoMlC9cCbvNKxewZq6J5UmmDjlIeRp+jUsQa
 cOTKfi66PiVE2KuvzU0Ok71oCVaxMLBWhBiA3qQE9dG0rZpF07tr83O+164hzBV/hg
 PJKPwW8df//R+8i6lFk8FvF4W2yvas9IP5aqp27s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIN9Zu8027462
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 17:09:35 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 17:09:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 17:09:34 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIN9YMZ103787;
 Wed, 18 Dec 2024 17:09:34 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
In-Reply-To: <87ed25w4xm.fsf@baylibre.com>
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com>
Date: Wed, 18 Dec 2024 17:09:34 -0600
Message-ID: <86frmk4mhd.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:

> Hi Jonathan,
>
> Thank you for the patch.
>
> On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-humphreys@ti.=
com> wrote:
>
>> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
>> variable is dynamically set when initializing the DFU entities, which is
>> done as part of normal flow of a DFU operation.
>>
>> The USB DFU boot support will set it's own specific value for dfu_alt_in=
fo
>> before performing the DFU operation. This means that if
>> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment variable
>> that the USB DFU boot path had set is overwritten, causing USB DFU boot =
to
>> fail.
>>
>> Likewise, if the user sets their own value for dfu_alt_info, say at the
>> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is enable=
d.
>>
>> This patch will first check that dfu_alt_info isn't already set before
>> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.
>
> To me, this is a policy change: before we could override the environment
> via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info" is alrea=
dy
> set in the environment).
>
> Also, it seems that this change goes against the uefi doc which states:
>
> """
> A string is defined which is to be used for populating the
> dfu_alt_info variable. This string is used by the function
> set_dfu_alt_info. Instead of taking the variable from the environment,
> the capsule update feature requires that the variable be set through
> the function, since that is more robust. Allowing the user to change
> the location of the firmware updates is not a very secure
> practice. Getting this information from the firmware itself is more
> secure, assuming the firmware has been verified by a previous stage
> boot loader.
> """
>
> See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#performing-=
the-update
>
> Moreover, looking at various boards that implement
> set_dfu_alt_info(), we can see different behaviours:
>
> Boards examples that won't override "dfu_alt_info" via
> set_dfu_alt_info() if "dfu_alt_info" is already set via environment
>
> * board/xilinx/zynq/board.c
> * board/emulation/common/qemu_dfu.c
>
> Boards examplesthat will always override the "dfu_alt_info" via
> set_dfu_alt_info():
>
> * board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> * board/ti/am62px/evm.c
>
> Since set_dfu_alt_info() is a board specific callback, why can't this
> logic be implemented for boards that want this behaviour change?

Because I would then need to duplicate the same logic for every board that
wanted both USB DFU boot and EFI capsules to work.  And the paramters
passed in do not allow the function to know the use case (am I DFU booting
or updating EFI capsules?).  See more below.

>
> Regards,
>
> Mattijs
>
>>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>  drivers/dfu/dfu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
>> index 756569217bb..ab8abae1d89 100644
>> --- a/drivers/dfu/dfu.c
>> +++ b/drivers/dfu/dfu.c
>> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char *d=
evstr)
>>  	dfu_reinit_needed =3D false;
>>  	dfu_alt_info_changed =3D false;
>>=20=20
>> +	str_env =3D env_get("dfu_alt_info");
>>  #ifdef CONFIG_SET_DFU_ALT_INFO
>> -	set_dfu_alt_info(interface, devstr);
>> +	if (!str_env) {
>> +		set_dfu_alt_info(interface, devstr);
>> +		str_env =3D env_get("dfu_alt_info");
>> +	}
>>  #endif
>> -	str_env =3D env_get("dfu_alt_info");
>>  	if (!str_env) {
>>  		pr_err("\"dfu_alt_info\" env variable not defined!\n");
>>  		return -EINVAL;
>> --=20
>> 2.34.1

Mattijs, thanks for the thorough reply.  I did wrestle a lot with how wide
of a fix to propose for this problem, and in the end, decided on the narrow
fix of simply preventing the overwriting of the variable.

Yes it is a policy change, but the policy is already unclear, inconsistent,
and confusing, IMO.

For example:
1) EFI capsule update wants to very strictly control the dfu alt values
   by setting it in set_dfu_alt_info(), but then any other DFU use
   case breaks.  USB DFU boot is now broken.
2) The behavior the user sees wrt the dfu_alt_info env variable is very
   confusing and non-intuitive. Take this example:

=3D> env set dfu_alt_info "sf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000=
 100000"
=3D> env print dfu_alt_info
dfu_alt_info=3Dsf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000 100000
=3D> dfu 0 list
DFU alt settings list:
dev: SF alt: 0 name: tiboot3.bin layout: RAW_ADDR
dev: SF alt: 1 name: tispl.bin layout: RAW_ADDR
dev: SF alt: 2 name: u-boot.img layout: RAW_ADDR
=3D> env print dfu_alt_info
dfu_alt_info=3Dsf 0:0=3Dtiboot3.bin raw 0 80000;tispl.bin raw 80000 200000;=
u-boot.img raw 280000 400000
=3D>

As you can see, the user set's the dfu_alt_info variable according to their
specific use case, then simply tries to list the DFU alt settings, and
because this code goes through the dfu_init_env_entities() path, it gets
changed to the EFI capsule settings.

I was hoping to get a simpler fix in now so we can get USB DFU boot working
again, and we can visit the overall policy design next.  As you suggest, I
could also push the testing of overwriting into the board specific
set_dfu_alt_info() function, but then I need to duplicate the code in 8
different places for the TI boards, and other vendors may still have the
problem.

Looking to the longer term solution, here are my thoughts.
1) We need to decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.  The only
   reason TI boards are now setting CONFIG_SET_DFU_ALT_INFO is because EFI
   capsule update is enabled.  Outside of a few legacy uses (I think - it
   appears they were introduced prior to supporting multi-interface dfu alt
   strings), I think this is true for other vendor's boards as well.
2) Have EFI capsule support do as USB DFU boot does today, and set the
   dfu alt string it wants used *before* initiating the DFU operation.  With
   CONFIG_SET_DFU_ALT_INFO no longer enabled, the value it set will not get
   overridden.
3) Have the actual value of the dfu alt string used in the DFU operation be
   passed in, rather than read from the dfu_alt_info environment variable.
   The USB DFU and EFI capsule use case will pass in the dfu alt string
   they want. The standard 'dfu' command can pass in the value of the
   dfu_alt_info env variable. Note that this effectively decouples the dfu
   command from the alt settings that USB DFU boot and EFI capsules use,
   but I think this is what we want.

This then allows both USB DFU boot and EFI capsule use cases to work as
intended and allows the dfu command to operate on the user defined
dfu_alt_info value.

I welcome comments from those that have the history and intended behavior
background of the DFU support :).

I also welcome comments on how to proceed for 2025.01. Should we live with
USB DFU boot broken until we get the long term fix in, or ok with the patch
posted here. The patch posted here does allow for a user to change EFI
capsule's dfu alt settings, as Mattijs says, but especially given capsules
can be authenticated, I'm not sure how this would be exploited, and if that
risk is worse that broken DFU boot.

thank
Jon
