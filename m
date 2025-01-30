Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09752C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836A680EE5;
	Thu, 30 Jan 2025 14:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=eurek.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=eurek.it header.i=@eurek.it header.b="Y8unBNQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17EA80EF7; Thu, 30 Jan 2025 14:49:46 +0100 (CET)
Received: from submit-3.e-mind.com (submit-3.e-mind.com [188.94.192.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C1DD80EC1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=eurek.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gianlucarenzi@eurek.it
Received: from localhost (unknown [127.0.0.1])
 by submit-3.e-mind.com (Postfix) with ESMTP id 9C36F973B34
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 13:49:43 +0000 (UTC)
Received: from submit-3.e-mind.com ([127.0.0.1])
 by localhost (submit-3.e-mind.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CHTjIjSG3Pqs for <u-boot@lists.denx.de>;
 Thu, 30 Jan 2025 14:49:43 +0100 (CET)
Received: from zmcloud-proxy2-z10.e-mind.com (unknown [192.168.102.63])
 by submit-3.e-mind.com (Postfix) with ESMTPS id 425219727DF
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:49:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zmcloud-proxy2-z10.e-mind.com (Postfix) with ESMTP id 2FEA1180571
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:49:43 +0100 (CET)
Received: from zmcloud-proxy2-z10.e-mind.com ([127.0.0.1])
 by localhost (zmcloud-proxy2-z10.e-mind.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 38aanYVoAHu6 for <u-boot@lists.denx.de>;
 Thu, 30 Jan 2025 14:49:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zmcloud-proxy2-z10.e-mind.com (Postfix) with ESMTP id 24A50180575
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:49:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmcloud-proxy2-z10.e-mind.com 24A50180575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eurek.it;
 s=3736ECE4-C506-11EE-A607-5B3F78E208B8; t=1738244983;
 bh=CeT0mPuMCnUzZzHXubvwrG8HfGorFO2X7GwLvkrrmbA=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=Y8unBNQZVs0pyo9aeEI86WpQJt+5s5VSMLlC8+/hhGl9lZWgZrfMOZbEya7z0RSZi
 Uh/qcMQM9ZNkJu2PsazEqUYtbKuvE4Ue2h8nQfRFJQTxv2JqBMSJHZrAeYfRSRycoW
 CeRChJDAGpCs58S77ThuGN7a8pvY0yKe+/wrl+06vkkZwkVdarCIKvk2g3Mdj86KOG
 vCrfKbpf7C7290keqi8S4JqFP3meRRA4R2wqxe+lqJI1Wfi0P4NzkKHb9+dKzna6hb
 jypBBhNxpoIGOjBUpnNgT5MTHQoshBel1j+6eAOg/2C+F6zSHQZvztSOvsgReSjDYu
 rpIOhjJ58/Qfg==
Received: from zmcloud-proxy2-z10.e-mind.com ([127.0.0.1])
 by localhost (zmcloud-proxy2-z10.e-mind.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iCCq1u-v_Rfl for <u-boot@lists.denx.de>;
 Thu, 30 Jan 2025 14:49:43 +0100 (CET)
Received: from [192.168.143.6] (ip-185-53-252-165.airgrid.it [185.53.252.165])
 by zmcloud-proxy2-z10.e-mind.com (Postfix) with ESMTPSA id
 1227D180571
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:49:43 +0100 (CET)
Message-ID: <1e4fd3a2-7625-4e99-a0e6-57cd8597a8b1@eurek.it>
Date: Thu, 30 Jan 2025 14:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: stm32: restrict _debug_uart_init() usage
Content-Language: en-US
To: u-boot@lists.denx.de
References: <20250130115754.398989-1-patrice.chotard@foss.st.com>
 <8a22f018-4fe7-4a10-871d-f1c768d591f7@foss.st.com>
From: Gianluca Renzi <gianlucarenzi@eurek.it>
Organization: Eurek S.R.L.
In-Reply-To: <8a22f018-4fe7-4a10-871d-f1c768d591f7@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

This is awesome!

It should be great if the same approach should be done in OPTEE and TF-A=20
too. All that stuff is using the device-tree mechanism, but the LOW=20
LEVEL CONFIGURATION (early_init and other functions) is not linear and=20
all register base and pin configuration must be done at Makefile=20
variables level.

If I recall correctly, using a different UART instead of the EVK one,=20
can cause some code to hang and configure the wrong PLL registers to=20
continue booting and printing something on the correct UART device.

On 1/30/25 14:28, Patrick DELAUNAY wrote:
> Hi,
>
> On 1/30/25 12:57, Patrice Chotard wrote:
>> Since commit 948da7773e34 ("arm: Add new config option=20
>> ARCH_VERY_EARLY_INIT")
>> debug_uart_init() is called respectively in crt0.S and crt0_64.S.
>> That means that _debug_uart_init() is called for all STM32MP platforms
>> even for those which doesn't support SPL_BUILD.
>>
>> So restrict _debug_uart_init() execution for platforms which can have
>> SPL_BUILD enabled (STM32MP1 platform only).
>>
>> It's more needed to call debug_uart_init() in stm32mp1/cpu.c.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>> =C2=A0 arch/arm/mach-stm32mp/stm32mp1/cpu.c |=C2=A0 2 --
>> =C2=A0 drivers/serial/serial_stm32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 ++++++++++++------
>> =C2=A0 2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c=20
>> b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> index cb1b84c9af9..bc410128479 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -138,8 +138,6 @@ int mach_cpu_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_CMD_STM32PROG_SER=
IAL) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (boot_mode & TA=
MP_BOOT_DEVICE_MASK) =3D=3D BOOT_SERIAL_UART)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gd->flags |=3D =
GD_FLG_SILENT | GD_FLG_DISABLE_CONSOLE;
>> -=C2=A0=C2=A0=C2=A0 else if (IS_ENABLED(CONFIG_DEBUG_UART) &&=20
>> IS_ENABLED(CONFIG_XPL_BUILD))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug_uart_init();
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> diff --git a/drivers/serial/serial_stm32.c=20
>> b/drivers/serial/serial_stm32.c
>> index 1ee58142b3f..1675a9cb9d1 100644
>> --- a/drivers/serial/serial_stm32.c
>> +++ b/drivers/serial/serial_stm32.c
>> @@ -299,13 +299,19 @@ static inline struct stm32_uart_info=20
>> *_debug_uart_info(void)
>> =C2=A0 =C2=A0 static inline void _debug_uart_init(void)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 void __iomem *base =3D (void __iomem *)CONFIG_VAL(=
DEBUG_UART_BASE);
>> -=C2=A0=C2=A0=C2=A0 struct stm32_uart_info *uart_info =3D _debug_uart_=
info();
>> +=C2=A0=C2=A0=C2=A0 void __maybe_unused __iomem *base =3D (void __iome=
m=20
>> *)CONFIG_VAL(DEBUG_UART_BASE);
>> +=C2=A0=C2=A0=C2=A0 struct stm32_uart_info *uart_info __maybe_unused =3D=
=20
>> _debug_uart_info();
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 _stm32_serial_init(base, uart_info);
>> -=C2=A0=C2=A0=C2=A0 _stm32_serial_setbrg(base, uart_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_DEBUG_UART_CLOCK,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_BAUDRATE);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * debug_uart_init() is only usable when SPL_=
BUILD is enabled
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * (STM32MP1 case only)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_DEBUG_UART) &&=20
>> IS_ENABLED(CONFIG_SPL_BUILD)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _stm32_serial_init(base, u=
art_info);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _stm32_serial_setbrg(base,=
 uart_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_DEBUG_UART_CLO=
CK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_BAUDRATE);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 =C2=A0 static inline void _debug_uart_putc(int c)
>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick
>

--=20
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212

Invito alla riservatezza:
La  presente richiesta di  quotazione tramite posta elettronica contiene
informazioni personali e riservate. E' vietato divulgarne il contenuto a
persone diverse  dal destinatario.  Si prega i riceventi non autorizzati
di  mantenere  il  riserbo,  di informare  tempestivamente  il  mittente
dell'errore di trasmissione e di eliminare quanto per  errore pervenuto,
ivi  compresi  eventuali  allegati.  La  diffusione,  distribuzione  e/o
copiatura  delle  informazioni  trasmesse da parte di qualsiasi soggetto
diverso  dal  destinatario  e' proibita, sia ai sensi dell'art. 616 c.p.
che  ai  sensi  del  D.Lgs.196/2003  e adeguamento del nuovo Regolamento
Europeo nr. 679/2016

Invitation to privacy:
This  request  for  an  e-mail  quote  includes   personal  and  private
information. Making its content known to anyone other than the recipient
is forbidden.  Unauthorized  recipients are kindly requested to maintain
secrecy,  promptly  inform  the sender of the wrong reception and delete
what   has   been  accidentally  received,  including  any  attachments.
Spreading,  distributing  and  /  or copying the provided information by
anyone  other  than  the  addressee  is  forbidden,  according  both  to
art. 616 C.P.  and  to  D.Lgs.196  /  2003  and adaptation of the new EU
Regulation n. 679/2016

 =20

