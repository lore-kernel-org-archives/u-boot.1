Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4D2C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A750D884CA;
	Thu, 20 Jun 2024 19:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FNLgAATG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E390D884CA; Thu, 20 Jun 2024 19:12:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB6A8834D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718903507; x=1719508307; i=xypron.glpk@gmx.de;
 bh=nx+CXvXvPSCTb9BqtIVyUysPoUcssF7iqJWEtsdwob0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FNLgAATGp2eSbnMrZpuccnZvjhfUbcSk09VWYYVdxei/hgyxYAfOttlEDtyfZxzs
 m3bmvmV2sfUsn0omSRDMRbppLJLlEfqDcd6F18ccjP9nNqAxSVsC/qk2Kjv0ztuit
 TL+Mq/Hx3XPZ8MzYdpdgIkasVJp7OoYfyMd7PYSdIuioaHjjt0moXlCsaxa66GhcB
 qdTA6vlTHbsz8TvePFU6In3/qFYzdrqPXVaY+PmM2G23c7CBJsoMcemxqwC6g/RQW
 NU/TukAOq5l6iuyczl1xgtNnC+4IPu+4BVsEe5gLTqS+5MdqIUr8D52PYWtKcvutp
 NDesQQ0Pn2QU/j/zpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1sOWPM1BFn-00ubrN; Thu, 20
 Jun 2024 19:11:47 +0200
Message-ID: <171f5615-5219-4af0-8003-009ab4a4f968@gmx.de>
Date: Thu, 20 Jun 2024 19:11:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] doc: convert README.LED to .rst documentation
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
 <20240619230400.8459-10-ansuelsmth@gmail.com>
 <f9b0b4ed-d460-49ec-b965-08c669f0924b@gmx.de>
 <66740f53.050a0220.7e100.7936@mx.google.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <66740f53.050a0220.7e100.7936@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zg2YZKrKRnEyBlG1bD0afGweLsyr4SJ7N75a5pf6LGOv2g+Z/aJ
 9wy/cXd3MwuW1QPgYUB/fshHMi78xS3utKxQ+pelx7ds30oFLZkDq4tzvGoo0egM494qZJf
 KAxObO1pqJTxbcXBeh+3AxPiFM8uLdFpc1PS5sPHLp19wKakQhEb/piKYLgIyOwhphDoc8G
 7IWhxc2kPBD6h31B2ZlLQ==
UI-OutboundReport: notjunk:1;M01:P0:UPWHA09KCH8=;yUDOJvuEW475yQayMTsQ+xc3g88
 X08FXiqw6uWcAZ2S9U/FudckbnKcPF+3yfN9Pa+nXWLbEEdPKRA9rrhlZ0o9LVbeHIBMZS3sL
 jwokDMTP00iV58TqhUeVVcZqjpmswbdAibSjV563aeFnGY8ZsINb0Pd9Br6fhrriiklS4UJPk
 cyKu/+Im8rP1O9Ye9Nppm/6YApLndc3IBwyaOAIAydSUsb3jaUnajtiLY5Y2UcmZK6raQAv/r
 9Sgp+Nvc9RrvXmw+4l1TfNYZv+NBe0V8aeU5mP0OHrZy2eRZNdgpDOa+Px+4U4Ve8VQVJ2X0j
 VSj16y2M/E3UzEif9xH5TXb04wwn3zbze7X58vZNma7ornJgAXvOi0ZoquH3Nbf8cZBvCuUuz
 7zjoHk6szdUYjjH57R7QETkNh0Lwx35icTSvAXg/dyXWirGvvzxZb3Cm9+8cgMKULR3GCDrSm
 5CAJUUuBsPHCpZnKqQRzfK1JagBB9A9J1WGzdf66Z9wVuSJVcaCSCfcKOt0GR9n8B0NARB9Dn
 jcrfAz5JmvZTazgBSITGlxBMo989siPj5vCemW7EsaaEbPQmjINx78ismtf27b38yp0GuZAOt
 4XSfJPDtGzemvh+T+GQ+q58QqYilMqOkH40PoncFaFq6+NGqQyIDEgjnUq/KUGOrLDbV4UIX3
 i2SBtNTTm5yMHCbSqsLyHNuHnBWaE3nsDoge4j3frz+itcbx079KEwZj4MdeaFdg+lWGH6ZHb
 7YXXnt37TrYAWEz2qZnoBy8kQ1NOgrE7XbUf3kltDYp6PPNhhYaY8EdwGYUSKW+p36qMFdYKP
 cc6suRGh5z2hMTA2SqKNsLB2y+OjKoNxHm95vSFQsYgto=
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

On 6/20/24 06:37, Christian Marangi wrote:
> On Thu, Jun 20, 2024 at 08:13:34AM +0200, Heinrich Schuchardt wrote:
>> On 6/20/24 01:03, Christian Marangi wrote:
>>> Convert README.LED to .rst documentation and include all the relevant
>>> documentation in the status_led.h.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    doc/README.LED         |  77 --------------
>>>    doc/api/index.rst      |   1 +
>>>    doc/api/status_led.rst |  35 +++++++
>>>    include/status_led.h   | 224 ++++++++++++++++++++++++++++++++++++++=
++-
>>>    4 files changed, 256 insertions(+), 81 deletions(-)
>>>    delete mode 100644 doc/README.LED
>>>    create mode 100644 doc/api/status_led.rst
>>>
>>> diff --git a/doc/README.LED b/doc/README.LED
>>> deleted file mode 100644
>>> index c21c9d53ec3..00000000000
>>> --- a/doc/README.LED
>>> +++ /dev/null
>>> @@ -1,77 +0,0 @@
>>> -Status LED
>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -This README describes the status LED API.
>>> -
>>> -The API is defined by the include file include/status_led.h
>>> -
>>> -The first step is to enable CONFIG_LED_STATUS in menuconfig:
>>> -> Device Drivers > LED Support.
>>> -
>>> -If the LED support is only for specific board, enable
>>> -CONFIG_LED_STATUS_BOARD_SPECIFIC in the menuconfig.
>>> -
>>> -Status LEDS 0 to 5 are enabled by the following configurations at men=
uconfig:
>>> -CONFIG_STATUS_LED0, CONFIG_STATUS_LED1, ... CONFIG_STATUS_LED5
>>> -
>>> -The following should be configured for each of the enabled LEDs:
>>> -CONFIG_STATUS_LED_BIT<n>
>>> -CONFIG_STATUS_LED_STATE<n>
>>> -CONFIG_STATUS_LED_FREQ<n>
>>> -Where <n> is an integer 1 through 5 (empty for 0).
>>> -
>>> -CONFIG_STATUS_LED_BIT is passed into the __led_* functions to identif=
y which LED
>>> -is being acted on. As such, the value choose must be unique with with=
 respect to
>>> -the other CONFIG_STATUS_LED_BIT's. Mapping the value to a physical LE=
D is the
>>> -reponsiblity of the __led_* function.
>>> -
>>> -CONFIG_STATUS_LED_STATE is the initial state of the LED. It should be=
 set to one
>>> -of these values: CONFIG_LED_STATUS_OFF or CONFIG_LED_STATUS_ON.
>>> -
>>> -CONFIG_STATUS_LED_FREQ determines the LED blink frequency.
>>> -Values range from 2 to 10.
>>> -
>>> -Some other LED macros
>>> ----------------------
>>> -
>>> -CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
>>> -This must be a valid LED number (0-5).
>>> -
>>> -CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. Th=
is must be
>>> -a valid LED number (0-5). Other similar color LED's macros are
>>> -CONFIG_STATUS_LED_GREEN, CONFIG_STATUS_LED_YELLOW and CONFIG_STATUS_L=
ED_BLUE.
>>> -
>>> -General LED functions
>>> ----------------------
>>> -The following functions should be defined:
>>> -
>>> -__led_init is called once to initialize the LED to CONFIG_STATUS_LED_=
STATE.
>>> -One time start up code should be placed here.
>>> -
>>> -__led_set is called to change the state of the LED.
>>> -
>>> -__led_toggle is called to toggle the current state of the LED.
>>> -
>>> -Colour LED
>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -Colour LED's are at present only used by ARM.
>>> -
>>> -The functions names explain their purpose.
>>> -
>>> -coloured_LED_init
>>> -red_LED_on
>>> -red_LED_off
>>> -green_LED_on
>>> -green_LED_off
>>> -yellow_LED_on
>>> -yellow_LED_off
>>> -blue_LED_on
>>> -blue_LED_off
>>> -
>>> -These are weakly defined in arch/arm/lib/board.c to noops. Where appl=
icable, define
>>> -these functions in the board specific source.
>>> -
>>> -TBD : Describe older board dependent macros similar to what is done f=
or
>>> -
>>> -TBD : Describe general support via asm/status_led.h
>>> diff --git a/doc/api/index.rst b/doc/api/index.rst
>>> index 51b2013af36..d40e90801d1 100644
>>> --- a/doc/api/index.rst
>>> +++ b/doc/api/index.rst
>>> @@ -22,6 +22,7 @@ U-Boot API documentation
>>>       rng
>>>       sandbox
>>>       serial
>>> +   status_led
>>>       sysreset
>>>       timer
>>>       unicode
>>> diff --git a/doc/api/status_led.rst b/doc/api/status_led.rst
>>> new file mode 100644
>>> index 00000000000..44bbea47157
>>> --- /dev/null
>>> +++ b/doc/api/status_led.rst
>>> @@ -0,0 +1,35 @@
>>> +.. SPDX-License-Identifier: GPL-2.0+
>>> +
>>> +Status LED
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +.. kernel-doc:: include/status_led.h
>>> +   :doc: Overview
>>> +
>>> +CONFIG_STATUS_LED Description
>>> +-----------------------------
>>> +
>>> +.. kernel-doc:: include/status_led.h
>>> +   :doc: CONFIG Description
>>> +
>>> +Special Status LED Configs
>>> +--------------------------
>>> +.. kernel-doc:: include/status_led.h
>>> +   :doc: LED Status Config
>>> +
>>> +Colour Status LED Configs
>>> +-------------------------
>>> +.. kernel-doc:: include/status_led.h
>>> +   :doc: LED Colour Config
>>> +
>>> +Required API
>>> +------------
>>> +
>>> +.. kernel-doc:: include/status_led.h
>>> +   :doc: Required API
>>> +
>>> +Status LED API
>>> +--------------
>>> +
>>> +.. kernel-doc:: include/status_led.h
>>> +   :internal:
>>> diff --git a/include/status_led.h b/include/status_led.h
>>> index 7de40551621..6893d1d68e0 100644
>>> --- a/include/status_led.h
>>> +++ b/include/status_led.h
>>> @@ -4,18 +4,102 @@
>>>     * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>>>     */
>>>
>>> -/*
>>> - * The purpose of this code is to signal the operational status of a
>>> +/**
>>> + * DOC: Overview
>>> + *
>>> + * Status LED is a Low-Level way to handle LEDs to signal state of th=
e
>>
>> Status LEDs can be used to signal the operational status of a
>>
>>> + * bootloader, for example boot progress, file transfer fail, activit=
y
>>> + * of some sort like tftp transfer, mtd write/erase.
>>
>> for example boot progress, file transfer failure, or ongoing activity
>> like tftp transfer or mtd write/erase.
>>
>>> + *
>>> + * The original usage these API were to signal the operational status=
 of a
>>
>> One usage of this API is signalling the operational status ...
>>
>>>     * target which usually boots over the network; while running in
>>>     * PCBoot, a status LED is blinking. As soon as a valid BOOTP reply
>>
>> What does "PCBoot" refer to? Do you mean U-Boot?
>>
>>>     * message has been received, the LED is turned off. The Linux
>>>     * kernel, once it is running, will start blinking the LED again,
>>>     * with another frequency.
>>> + *
>>> + * Status LED require support Low Level and the board to implement
>>
>>
>>
>>> + * the specific functions to correctly works.
>>>     */
>>>
>>>    #ifndef _STATUS_LED_H_
>>>    #define	_STATUS_LED_H_
>>>
>>> +/**
>>> + * DOC: CONFIG Description
>>
>> DOC: Configuration
>>
>>> + *
>>> + * Enable `CONFIG_LED_STATUS` to support the Status LED under
>>> + * > Device Drivers > LED Support.
>>> + *
>>> + * The Status LED can be defined in various ways, but most of the tim=
e,
>>> + * specific functions will need to be defined in the board file.
>>> + * If this is the case, enable `CONFIG_LED_STATUS_BOARD_SPECIFIC`.
>>
>> CONFIG_LED_STATUS_BOARD_SPECIFIC is not used in any defconfig.
>>
>> GPIO is the typical case and board-specific the exception.
>>
>>> + *
>>> + * If the LEDs are GPIO-driven, you can use the GPIO wrapper driver
>>> + * instead of defining specific board functions.
>>> + * If this is the case, enable `CONFIG_LED_STATUS_GPIO`.
>>> + * (Note that `CONFIG_LED_STATUS_BOARD_SPECIFIC` is also required.)
>>> + *
>>> + * The Status LED allows defining up to six different LEDs, from 0 to=
 5,
>>> + * with the following configurations:
>>> + * `CONFIG_STATUS_LED`, `CONFIG_STATUS_LED1`, ..., `CONFIG_STATUS_LED=
5`.
>>> + *
>>> + * For each LED, the following options are required:
>>> + *  * `CONFIG_STATUS_LED_BIT<n>`
>>> + *  * `CONFIG_STATUS_LED_STATE<n>`
>>> + *  * `CONFIG_STATUS_LED_FREQ<n>`
>>> + *
>>> + * Where `<n>` is an integer from 1 through 5. (Note that LED 0 doesn=
't have the
>>> + * integer suffix.)
>>> + *
>>> + * `CONFIG_STATUS_LED_BIT` is passed into the `__led_*` functions to =
identify
>>> + * which LED is being acted on. The value is opaque, meaning it depen=
ds on how
>>> + * the low-level API handles this value. It can be an ID to reference=
 the LED
>>> + * internally, or in the case of the GPIO wrapper, it's the GPIO numb=
er of the LED.
>>> + * Mapping the value to a physical LED is the responsibility of the `=
__led_*` function.
>>> + *
>>> + * `CONFIG_STATUS_LED_STATE` sets the initial state of the LED. It sh=
ould be set
>>> + * to one of these values: `CONFIG_LED_STATUS_OFF` or `CONFIG_LED_STA=
TUS_ON`.
>>> + *
>>> + * `CONFIG_STATUS_LED_FREQ` determines the LED blink frequency.
>>> + * Values range from 2 to 10.
>>> + */
>>> +/**
>>> + * DOC: LED Status Config
>>> + *
>>> + * The Status LED uses two special configurations for common operatio=
ns:
>>> + *
>>> + *   * CONFIG_STATUS_LED_BOOT is the LED that lights up when the boar=
d is booting.
>>> + *   * CONFIG_STATUS_LED_ACTIVITY is the LED that lights and blinks d=
uring activity
>>> + *     (e.g., file transfer, flash write).
>>> + *
>>> + * The values set in these configurations refer to the LED ID previou=
sly set.
>>> + *
>>> + * - ``CONFIG_STATUS_LED_RED=3D0`` will refer to the option ``CONFIG_=
STATUS_LED_BIT``.
>>> + * - ``CONFIG_STATUS_LED_RED=3D1`` will refer to the option ``CONFIG_=
STATUS_LED_BIT1``.
>>> + * - ``CONFIG_STATUS_LED_RED=3D2`` will refer to the option ``CONFIG_=
STATUS_LED_BIT2``.
>>> + * - ...
>>> + */
>>> +/**
>>> + * DOC: LED Colour Config
>>> + *
>>> + * The Status LED exposes specific configurations for LEDs of differe=
nt colors.
>>> + *
>>> + * The values set in these configurations refer to the LED ID previou=
sly set.
>>> + *
>>> + * - ``CONFIG_STATUS_LED_RED=3D0`` will refer to the option ``CONFIG_=
STATUS_LED_BIT``.
>>> + * - ``CONFIG_STATUS_LED_RED=3D1`` will refer to the option ``CONFIG_=
STATUS_LED_BIT1``.
>>> + * - ``CONFIG_STATUS_LED_RED=3D2`` will refer to the option ``CONFIG_=
STATUS_LED_BIT2``.
>>> + * - ...
>>> + *
>>> + * Supported colors are:
>>> + *   * red
>>> + *   * green
>>> + *   * yellow
>>> + *   * blue
>>> + *   * white
>>> + */
>>> +
>>>    #ifdef CONFIG_LED_STATUS
>>>
>>>    #define LED_STATUS_PERIOD	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ)
>>> @@ -35,11 +119,49 @@
>>>    #define LED_STATUS_PERIOD5	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ5=
)
>>>    #endif /* CONFIG_LED_STATUS5 */
>>>
>>> +/**
>>> + * void status_led_init - Init the Status LED with all the required s=
tructs.
>>> + */
>>>    void status_led_init(void);
>>> +/**
>>> + * void status_led_tick - Blink each LED that is currently set in bli=
nking
>>> + *   mode
>>> + * @timestamp: currently unused
>>> + */
>>>    void status_led_tick(unsigned long timestamp);
>>> +/**
>>> + * void status_led_set - Set the LED ID passed as first arg to the mo=
de set
>>> + * @led: reference to the Status LED ID
>>> + * @state: state to set the LED to
>>> + *
>>> + * Modes for state arE:
>>> + *   * CONFIG_LED_STATUS_OFF (LED off)
>>> + *   * CONFIG_LED_STATUS_ON (LED on)
>>> + *   * CONFIG_LED_STATUS_BLINK (LED initially on, expected to blink)
>>> + */
>>>    void status_led_set(int led, int state);
>>> +/**
>>> + * void status_led_toggle - toggle the LED ID
>>> + * @led: reference to the Status LED ID
>>> + *
>>> + * Toggle the LED ID passed as first arg. If it's ON became OFF, if i=
t's
>>> + * OFF became ON.
>>> + */
>>>    void status_led_toggle(int led);
>>> +/**
>>> + * void status_led_activity_start - start a LED activity
>>> + * @led: reference to the Status LED ID
>>> + *
>>> + * Set the Status LED ON and start the Cyclic to make the LED blink a=
t
>>> + * the configured freq.
>>> + */
>>>    void status_led_activity_start(int led);
>>> +/**
>>> + * void status_led_activity_stop - stop a LED activity
>>> + * @led: reference to the Status LED ID
>>> + *
>>> + * Stop and free the Cyclic and turn the LED OFF.
>>
>> 'Cyclic' is and adjective and cannot stand alone. Do you mean:
>>
>> Stop and free the cyclic function and turn off the LED.
>>
>>> + */
>>>    void status_led_activity_stop(int led);
>>>
>>>    /*****  MVS v1  ***************************************************=
*******/
>>
>> We don't have 'config MVS' in any Kconfig. Please remove the dead code.
>>
>>> @@ -62,9 +184,61 @@ void status_led_activity_stop(int led);
>>>    /* led_id_t is unsigned long mask */
>>>    typedef unsigned long led_id_t;
>>>
>>> +/**
>>> + * DOC: Required API
>>> + *
>>> + * The Status LED requires the following API functions to operate cor=
rectly
>>
>> The following functions are implemented by the GPIO LED driver. If usin=
g
>> CONFIG_LED_STATUS_BOARD_SPECIFIC=3Dy, they have to be implemented by th=
e
>> board code.
>>
>
> Well CONFIG_LED_STATUS_BOARD_SPECIFIC is mandatory for these function to
> be exporsed. GPIO is just a way to provide these function using the GPIO
> common implementation. Maybe I will make it more clear but it should be
> also written at the start of the DOC.

The Linux kernel defines LEDs in the device-tree including labels. Why
do we need CONFIG_LED_STATUS_BOARD_SPECIFIC at all?

Shouldn't we eliminate all the legacy code like cmd/legacy_led.c instead
of enhancing it?

Best regards

Heinrich

>
>>> + * and compile:
>>> + *
>>> + * - ``__led_toggle``: Low-level function to toggle the LED at the sp=
ecified
>>> + *   mask.
>>> + * - ``__led_init``: Initializes the Status LED, sets up required tab=
les, and
>>> + *   configures registers.
>>> + * - ``__led_set``: Low-level function to set the state of the LED at=
 the
>>> + *   specified mask.
>>> + * - ``__led_blink``: Low-level function to set the LED to blink at t=
he
>>> + *   specified frequency.
>>> + *
>>> + * The Status LED also provides optional functions to control colored=
 LEDs.
>>
>> Do you mean
>>
>> Controlling colored LEDs requires the additional functions see :doc:
>> `Coloured LED API`.
>>
>>> + * Each supported LED color has corresponding ``_on`` and ``_off`` fu=
nctions.
>>> + *
>>> + * There is also support for ``coloured_LED_init`` for LEDs that prov=
ide
>>> + * multiple colors. (Currently, this is only used by ARM.)
>>
>> We have hundreds of ARM based boards. Could you be a bit more specific,
>> please.
>>
>
> Well the only one used is the RED colour and it's in arm/lib/crt0.S in
> the ASM code.
>
>>> + *
>>> + * Each function is weakly defined and should be implemented in the
>>> + * board-specific source file. (This does not apply to the GPIO LED w=
rapper.)
>>> + */
>>> +/**
>>> + * void __led_toggle - toggle LED at @mask
>>> + * @mask: opaque value to reference the LED
>>> + *
>>> + * Low-Level function to toggle the LED at mask.
>>> + */
>>>    extern void __led_toggle (led_id_t mask);
>>> +/**
>>> + * void __led_init - Init the LED at @mask
>>> + * @mask: opaque value to reference the LED
>>> + * @state: starting state of the LED
>>> + *
>>> + * Init the Status LED, init required tables, setup regs...
>>> + */
>>>    extern void __led_init (led_id_t mask, int state);
>>> +/**
>>> + * void __led_set - Set the LED at @mask
>>> + * @mask: opaque value to reference the LED
>>> + * @state: state to set the LED to
>>> + *
>>> + * Init the Status LED, init required tables, setup regs...
>>> + */
>>>    extern void __led_set (led_id_t mask, int state);
>>> +/**
>>> + * void __led_blink - Set the LED at @mask to HW blink
>>> + * @mask: opaque value to reference the LED
>>> + * @freq: freq to make the LED blink at
>>> + *
>>> + * Low-Level function to set the LED at HW blink by the
>>> + * passed freq.
>>> + */
>>>    void __led_blink(led_id_t mask, int freq);
>>>    #else
>>>    # error Status LED configuration missing
>>> @@ -77,20 +251,62 @@ void __led_blink(led_id_t mask, int freq);
>>>
>>>    #endif	/* CONFIG_LED_STATUS	*/
>>>
>>> -/*
>>> - * Coloured LEDs API
>>> +/**
>>> + * DOC: Coloured LED API
>>> + *
>>> + * Status LED expose optional functions to control coloured LED.
>>
>> The status LED API uses optional functions ...
>>
>>> + * Each LED color supported expose _on and _off function.
>>> + *
>>> + * There is also support for coloured_LED_init for LED that provide
>>> + * multiple colours. (currently only used by ARM)
>>
>> No clue why you refer to ARM. I found only the following files that
>> providing board specific implementations:
>>
>
> Another case of arm/lib/crt0.S
>
> These confusing thing are picked from the old txt just to not drop info
> and try to do a 1:1 conversion.
>
>> board/beagle/beagle/led.c
>> board/siemens/corvus/board.c
>>
>> Best regards
>>
>> Heinrich
>>
>>> + *
>>> + * Each function is weakly defined and should be defined in the board
>>> + * specific source. (doesn't apply for GPIO LED wrapper)
>>>     */
>>>    #ifndef	__ASSEMBLY__
>>> +/**
>>> + * void coloured_LED_init - Init multi colour LED
>>> + */
>>>    void coloured_LED_init(void);
>>> +/**
>>> + * void red_led_on - Turn LED Red on
>>> + */
>>>    void red_led_on(void);
>>> +/**
>>> + * void red_led_off - Turn LED Red off
>>> + */
>>>    void red_led_off(void);
>>> +/**
>>> + * void green_led_on - Turn LED Green on
>>> + */
>>>    void green_led_on(void);
>>> +/**
>>> + * void green_led_off - Turn LED Green off
>>> + */
>>>    void green_led_off(void);
>>> +/**
>>> + * void yellow_led_on - Turn LED Yellow on
>>> + */
>>>    void yellow_led_on(void);
>>> +/**
>>> + * void yellow_led_off - Turn LED Yellow off
>>> + */
>>>    void yellow_led_off(void);
>>> +/**
>>> + * void blue_led_on - Turn LED Blue on
>>> + */
>>>    void blue_led_on(void);
>>> +/**
>>> + * void blue_led_off - Turn LED Blue off
>>> + */
>>>    void blue_led_off(void);
>>> +/**
>>> + * void white_led_on - Turn LED White on
>>> + */
>>>    void white_led_on(void);
>>> +/**
>>> + * void white_led_off - Turn LED White off
>>> + */
>>>    void white_led_off(void);
>>>    #else
>>>    	.extern LED_init
>>
>

