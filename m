Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD380C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 22:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FA98033D;
	Thu, 16 Jan 2025 23:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="msEzLHLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 225558069D; Thu, 16 Jan 2025 23:02:44 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D258022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50GM2Sv1219744
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 16:02:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737064948;
 bh=vGrUyIP9ECC2QUkr8ZZVTCouC/HnhHCqgoGU7mqRjXY=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=msEzLHLO3D5TK9RstWQp0fTHV+0cArqLqPej1DuDu9Tbi30uFizeLk7YPYgTQZJS0
 X8Jhi/nMKnmVbyglw4C9CHoOdNWwrxaaa3jRmxnet4srBSvYQ2baRWwWNCA7Oz90tS
 FUqpHMk2seZuZRywoUFQJ+EA2l5J+piW2+2w/CCA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50GM2SaQ050095
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 Jan 2025 16:02:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Jan 2025 16:02:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Jan 2025 16:02:27 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50GM2Rgs117648;
 Thu, 16 Jan 2025 16:02:27 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Caleb Connolly
 <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, "Lukasz Majewski" <lukma@denx.de>,
 <s-vadapalli@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
In-Reply-To: <CADg8p94zxnHuFH=hJDkxZm=_DOGOtYusM=twRQLRteYUy-CR3Q@mail.gmail.com>
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com> <86frmk4mhd.fsf@udb0321960.dhcp.ti.com>
 <87tt9z889e.fsf@baylibre.com>
 <CADg8p94zxnHuFH=hJDkxZm=_DOGOtYusM=twRQLRteYUy-CR3Q@mail.gmail.com>
Date: Thu, 16 Jan 2025 16:02:27 -0600
Message-ID: <86a5bqpgcs.fsf@udb0321960.dhcp.ti.com>
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

Sughosh Ganu <sughosh.ganu@linaro.org> writes:

> On Thu, 16 Jan 2025 at 14:07, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Jon,
>>
>> Sorry for the (very) late reply. I had some long holidays in between and
>> since this is a difficult topic for me, I kept pushing this to the end
>> of my backlog.
>>
>> On mer., d=C3=A9c. 18, 2024 at 17:09, Jon Humphreys <j-humphreys@ti.com>=
 wrote:
>>
>> > Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:
>> >
>> >> Hi Jonathan,
>> >>
>> >> Thank you for the patch.
>> >>
>> >> On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-humphreys=
@ti.com> wrote:
>> >>
>> >>> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
>> >>> variable is dynamically set when initializing the DFU entities, whic=
h is
>> >>> done as part of normal flow of a DFU operation.
>> >>>
>> >>> The USB DFU boot support will set it's own specific value for dfu_al=
t_info
>> >>> before performing the DFU operation. This means that if
>> >>> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment var=
iable
>> >>> that the USB DFU boot path had set is overwritten, causing USB DFU b=
oot to
>> >>> fail.
>> >>>
>> >>> Likewise, if the user sets their own value for dfu_alt_info, say at =
the
>> >>> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is en=
abled.
>> >>>
>> >>> This patch will first check that dfu_alt_info isn't already set befo=
re
>> >>> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.
>> >>
>> >> To me, this is a policy change: before we could override the environm=
ent
>> >> via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info" is a=
lready
>> >> set in the environment).
>> >>
>> >> Also, it seems that this change goes against the uefi doc which state=
s:
>> >>
>> >> """
>> >> A string is defined which is to be used for populating the
>> >> dfu_alt_info variable. This string is used by the function
>> >> set_dfu_alt_info. Instead of taking the variable from the environment,
>> >> the capsule update feature requires that the variable be set through
>> >> the function, since that is more robust. Allowing the user to change
>> >> the location of the firmware updates is not a very secure
>> >> practice. Getting this information from the firmware itself is more
>> >> secure, assuming the firmware has been verified by a previous stage
>> >> boot loader.
>> >> """
>> >>
>> >> See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#perform=
ing-the-update
>> >>
>> >> Moreover, looking at various boards that implement
>> >> set_dfu_alt_info(), we can see different behaviours:
>> >>
>> >> Boards examples that won't override "dfu_alt_info" via
>> >> set_dfu_alt_info() if "dfu_alt_info" is already set via environment
>> >>
>> >> * board/xilinx/zynq/board.c
>> >> * board/emulation/common/qemu_dfu.c
>> >>
>> >> Boards examplesthat will always override the "dfu_alt_info" via
>> >> set_dfu_alt_info():
>> >>
>> >> * board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
>> >> * board/ti/am62px/evm.c
>> >>
>> >> Since set_dfu_alt_info() is a board specific callback, why can't this
>> >> logic be implemented for boards that want this behaviour change?
>> >
>> > Because I would then need to duplicate the same logic for every board =
that
>> > wanted both USB DFU boot and EFI capsules to work.  And the paramters
>> > passed in do not allow the function to know the use case (am I DFU boo=
ting
>> > or updating EFI capsules?).  See more below.
>>
>> I understand that duplicating logic for every board you maintain is not
>> optimal, however, it gives each vendor the freedom of implementing their
>> policy.
>>
>> I've added a couple of folks who I think could help giving their opinion=
 on EFI capsules/policy.
>>
>> Heinrich, Ilias, Sugosh, do you have any opinion on this patch?
>>
>> >
>> >>
>> >> Regards,
>> >>
>> >> Mattijs
>> >>
>> >>>
>> >>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> >>> ---
>> >>>  drivers/dfu/dfu.c | 7 +++++--
>> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
>> >>> index 756569217bb..ab8abae1d89 100644
>> >>> --- a/drivers/dfu/dfu.c
>> >>> +++ b/drivers/dfu/dfu.c
>> >>> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, cha=
r *devstr)
>> >>>     dfu_reinit_needed =3D false;
>> >>>     dfu_alt_info_changed =3D false;
>> >>>
>> >>> +   str_env =3D env_get("dfu_alt_info");
>> >>>  #ifdef CONFIG_SET_DFU_ALT_INFO
>> >>> -   set_dfu_alt_info(interface, devstr);
>> >>> +   if (!str_env) {
>> >>> +           set_dfu_alt_info(interface, devstr);
>> >>> +           str_env =3D env_get("dfu_alt_info");
>> >>> +   }
>> >>>  #endif
>> >>> -   str_env =3D env_get("dfu_alt_info");
>> >>>     if (!str_env) {
>> >>>             pr_err("\"dfu_alt_info\" env variable not defined!\n");
>> >>>             return -EINVAL;
>> >>> --
>> >>> 2.34.1
>> >
>> > Mattijs, thanks for the thorough reply.  I did wrestle a lot with how =
wide
>> > of a fix to propose for this problem, and in the end, decided on the n=
arrow
>> > fix of simply preventing the overwriting of the variable.
>> >
>> > Yes it is a policy change, but the policy is already unclear, inconsis=
tent,
>> > and confusing, IMO.
>> >
>> > For example:
>> > 1) EFI capsule update wants to very strictly control the dfu alt values
>> >    by setting it in set_dfu_alt_info(), but then any other DFU use
>> >    case breaks.  USB DFU boot is now broken.
>> > 2) The behavior the user sees wrt the dfu_alt_info env variable is very
>> >    confusing and non-intuitive. Take this example:
>> >
>> > =3D> env set dfu_alt_info "sf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw =
88000 100000"
>> > =3D> env print dfu_alt_info
>> > dfu_alt_info=3Dsf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000 100000
>> > =3D> dfu 0 list
>> > DFU alt settings list:
>> > dev: SF alt: 0 name: tiboot3.bin layout: RAW_ADDR
>> > dev: SF alt: 1 name: tispl.bin layout: RAW_ADDR
>> > dev: SF alt: 2 name: u-boot.img layout: RAW_ADDR
>> > =3D> env print dfu_alt_info
>> > dfu_alt_info=3Dsf 0:0=3Dtiboot3.bin raw 0 80000;tispl.bin raw 80000 20=
0000;u-boot.img raw 280000 400000
>> > =3D>
>> >
>> > As you can see, the user set's the dfu_alt_info variable according to =
their
>> > specific use case, then simply tries to list the DFU alt settings, and
>> > because this code goes through the dfu_init_env_entities() path, it ge=
ts
>> > changed to the EFI capsule settings.
>> >
>> > I was hoping to get a simpler fix in now so we can get USB DFU boot wo=
rking
>> > again, and we can visit the overall policy design next.  As you sugges=
t, I
>> > could also push the testing of overwriting into the board specific
>> > set_dfu_alt_info() function, but then I need to duplicate the code in 8
>> > different places for the TI boards, and other vendors may still have t=
he
>> > problem.
>>
>> I agree that the above behaviour is confusing and I'm reconsidering to
>> take up this patch. I'd like some buy-in from either Heinrich, Ilias or
>> Sughosh on this since I'm not 100% confortable with the "policy change"
>
> A little context here. The DFU driver already had this policy in place
> where, if the CONFIG_SET_DFU_ALT_INFO was set, the dfu_alt_info string
> would be set by U-Boot, instead of taking the user provided string. It
> was decided to use this for EFI capsule updates, as getting the string
> which determines the location of writing the update images from within
> U-Boot is more resilient than taking some user provided string.
>
>
>>
>> >
>> > Looking to the longer term solution, here are my thoughts.
>> > 1) We need to decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.  The=
 only
>> >    reason TI boards are now setting CONFIG_SET_DFU_ALT_INFO is because=
 EFI
>> >    capsule update is enabled.  Outside of a few legacy uses (I think -=
 it
>> >    appears they were introduced prior to supporting multi-interface df=
u alt
>> >    strings), I think this is true for other vendor's boards as well.
>> > 2) Have EFI capsule support do as USB DFU boot does today, and set the
>> >    dfu alt string it wants used *before* initiating the DFU operation.=
  With
>> >    CONFIG_SET_DFU_ALT_INFO no longer enabled, the value it set will no=
t get
>> >    overridden.
>> > 3) Have the actual value of the dfu alt string used in the DFU operati=
on be
>> >    passed in, rather than read from the dfu_alt_info environment varia=
ble.
>> >    The USB DFU and EFI capsule use case will pass in the dfu alt string
>> >    they want. The standard 'dfu' command can pass in the value of the
>> >    dfu_alt_info env variable. Note that this effectively decouples the=
 dfu
>> >    command from the alt settings that USB DFU boot and EFI capsules us=
e,
>> >    but I think this is what we want.
>
> I think either of 2) or 3) above can be looked at. Although not sure
> if 2) will be breaking the current DFU policy.
>
> -sughosh
>

Thanks for the comments.  I have looked into this a bit further and see 2
options we can take for the EFI capsule update use case:

1) stick with the more traditional approach and do as DFU BOOT does by
   setting the value of the dfu_alt_info env variable just before
   initiating the DFU operation. As Ilias sugggested, we could also add a
   save/restore so this is transparent to other DFU users.

2) move to a model where we explicitly pass in to the DFU operation the
   value of dfu_alt_info that we want used. In the normal/legacy DFU use
   cases, this would involve calling env_get() for the dfu_alt_info env
   variable and pass that value. I like this approach because it is
   cleaner and more explicit. However, there are many layers of function
   calls between the driver of the DFU operation (the one that would decide
   what dfu_alt_info value to use) and dfu_init_env_entities() where it is
   used, and passing this info across the function interfaces would
   involved lots of function interface updates.

I'm curious if there is apetite for 2) or should we go with the more
traditional approach in 1).

The above assumes we decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.
For platforms still setting CONFIG_SET_DFU_ALT_INFO, the presumption is that
if they override the dfu_alt_info env variable, they know what they are
doing.

Thanks
Jon

>> >
>> > This then allows both USB DFU boot and EFI capsule use cases to work as
>> > intended and allows the dfu command to operate on the user defined
>> > dfu_alt_info value.
>> >
>> > I welcome comments from those that have the history and intended behav=
ior
>> > background of the DFU support :).
>>
>> I do as well. I have taken over maintaince on this subsystem a year ago
>> and have not had much patches/work done on the subsystem. Therefore I'm
>> not as knowledgeable as I would have liked to be. I'm sorry about that.
>>
>> >
>> > I also welcome comments on how to proceed for 2025.01. Should we live =
with
>> > USB DFU boot broken until we get the long term fix in, or ok with the =
patch
>> > posted here. The patch posted here does allow for a user to change EFI
>> > capsule's dfu alt settings, as Mattijs says, but especially given caps=
ules
>> > can be authenticated, I'm not sure how this would be exploited, and if=
 that
>> > risk is worse that broken DFU boot.
>> >
>> > thank
>> > Jon
