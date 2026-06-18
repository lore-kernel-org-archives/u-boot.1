Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC35BCD98F8
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D111847C3;
	Thu, 18 Jun 2026 17:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A1984995; Thu, 18 Jun 2026 17:29:00 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21FF88460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1waEfp-0002dt-61; Thu, 18 Jun 2026 17:28:57 +0200
Message-ID: <b3e09fac-0328-4aba-a59f-4d876b9a7475@pengutronix.de>
Date: Thu, 18 Jun 2026 17:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: add missing EFI_EXIT in
 efi_disconnect_controller
To: Simon Glass <sjg@chromium.org>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello,

On 6/18/26 5:18 PM, Simon Glass wrote:
> Hi Vincent,
> 
> On Thu, 18 Jun 2026 at 16:09, Vincent Stehlé <vincent.stehle@arm.com> wrote:
>>
>> Make sure to call EFI_EXIT() in efi_disconnect_controller(), when returning
>> after having called EFI_ENTRY().
>>
>> This is inspired by a barebox fix. [1]
> 
> Hmm, does Barebox support EFI_LOADER now? I wish we could bring these
> projects back together :-)

It's not as extensive as U-Boot's yet, but it's usable for the common
boot me a distro GRUB use case. The code originated from U-Boot with
some parts heavily rewritten to fit barebox, e.g. the EFI filesystem
protocol is implemented on top of dirfds, so it reuses VFS path handling
and other such things.

The imported files have Origin-URL comments pointing back at U-Boot
including the revision they originated from, but we are still in need of
better tooling to make use of these tags.

@Vincent, I suspect a number of fixes in [1] are also applicable to
U-Boot, but I haven't checked.

[1]:
https://lore.kernel.org/barebox/20260216084758.3548990-1-a.fatoum@pengutronix.de/

Cheers,
Ahmad



> 
>>
>> Link: https://git.pengutronix.de/cgit/barebox/commit/?id=080db65e39a877b000baaf843c997a69821dfe69 [1]
>> Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole child")
>> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>  lib/efi_loader/efi_boottime.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
>> index de57823bd44..b6966652d97 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
>>                                       &number_of_children,
>>                                       &child_handle_buffer);
>>         if (r != EFI_SUCCESS)
>> -               return r;
>> +               return EFI_EXIT(r);
>>         sole_child = (number_of_children == 1);
>>
>>         if (child_handle) {
>> --
>> 2.53.0
>>
> 
> Regards,
> Simon
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

