Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC5DC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 06:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA687884F6;
	Thu, 20 Jun 2024 08:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JG/OcdMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7098851D; Thu, 20 Jun 2024 08:14:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66A4884A9
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 08:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718864017; x=1719468817; i=xypron.glpk@gmx.de;
 bh=8VUNlLsk9qWYO0xeldyhrUye5DyZEhafJFP37t+BiTk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JG/OcdMdRSi2nYIPAPiduaujTbOksKBJzRPN/q067zPRvSibiinGsGMDsDxpY8YZ
 5twjBmv6NACXf+rxUq+gwlpX7iQuQ/GKbOCjqLH/KyZllgWAVPUtlRG+8VICTctSh
 JkK2fFlnsFuCjo6ZD2kdY0eXje70Bgc9hMpWEwlYBafnxMXRTFGTSsSNHAr9z1g5K
 /uRBybgtbkyffjMCA8AmMykqMJn9tqNY4ho63C06yNs1LeqE8KmVw/YDul8L9w6K6
 JRmzuTifJIk5DO/5bBcTns0net+l5KIRQ6DG5JvzrsY+QyWFMAWy6a7Izg2qjgOXG
 +MDitglAGRvrC1FTGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1s2nBv47YF-00L2c0; Thu, 20
 Jun 2024 08:13:37 +0200
Message-ID: <f9b0b4ed-d460-49ec-b965-08c669f0924b@gmx.de>
Date: Thu, 20 Jun 2024 08:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] doc: convert README.LED to .rst documentation
To: Christian Marangi <ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
 <20240619230400.8459-10-ansuelsmth@gmail.com>
Content-Language: en-US
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
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240619230400.8459-10-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJKIu1vPO+j5cghNPg+Ie1rawo7LxpeMf9uG3U6QpUemjHIPIXs
 zoDTbjcBCLAL2UokFM9CkjGwafaWG2T0WtR+T+FKO+kcJV7YTx/tCoxnJucYdko3UAxYPHg
 1z8bl5qoZOwPpF1Jp2GCMUBqpH+z/pTnewoQk7Uo3RFyL0SzyoyM4XFc+LvGcbZVrMQRT2Y
 SEwTQUWL8OSb2+VVaTDAQ==
UI-OutboundReport: notjunk:1;M01:P0:zjWhQCo9eKA=;VPE2vtmaLixXSVtrodfgKCkqOi2
 Ei+SR4dU7xp2V0s0V/XbkOp+B/ZF4oQNnxAZPcnE+jITG4qnHorZezJ6peHxGQuLFCGaD+j0k
 0SMAv5ffWzgqp1L1itaBXfWBBw+PfAnPVzPZ7+TKdp0//a/oP/qXBbM00DrF/hK/04fHf/3ta
 zDA3gS/I+RR/aNmMCxGJWRAJxTwCNB3Vpxol6A6krVyYbXhCyizXthqBEs8fPGTCTaVjBK7qg
 G0ICv4IXptnWia/9DaTaYe5udmlbRoAggD7k2pcQI3UQubY0+UaYkma7R7RF8EsMJy+3pTWQa
 b7aeDU1MXeP2xnV5OTA5vztD3FFoIbrjQe7VhRzedknDNRzfPIvPCst/ewfAdyI7r+7n35qew
 VEuQdQVRKJBsyM9rOKfMyY8X4o1WVgVPEj1oyi7L3yITQzkvF8VgF/OHuNDYjFx61ZvOd5mZE
 W93OHDuDFAazRG+EFZzcGfNfvuSAW5yYq7Wnj+C+06I19rUc30H3h6ZvEa0nv5BPDNZh1+4A+
 /HvrIfr5ja+JGQbk2OcMYYozmCXeUKegBL+Yz9j0NmUBSR3NixOgnWO0geqoKShEewYj5X1iL
 sTO0SdVmdKy7O4XoZPRBes5SE81riKF9UUcPqbMAP4Py5wg8CbBsBqRe5qjGBURJ3iToNqL5p
 V2+1TdaSYmOnA+05QXXrIXhKjjvlUcumVUh1kkjOvwcPhT6/hDZMA1GvNuLWBALeODNBEA3Bc
 nX8CtrxCwEg2omcyXDpZceFYy2Ud8iw8r9kpy4NC59C2cnb2xmLEpvxJNmisbjHlXq7WUMDWA
 MPT7dKu2/dBpUzllkN3zxeBITVY5lrmAXGQ6IFPIe7UPs=
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

On 6/20/24 01:03, Christian Marangi wrote:
> Convert README.LED to .rst documentation and include all the relevant
> documentation in the status_led.h.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   doc/README.LED         |  77 --------------
>   doc/api/index.rst      |   1 +
>   doc/api/status_led.rst |  35 +++++++
>   include/status_led.h   | 224 ++++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 256 insertions(+), 81 deletions(-)
>   delete mode 100644 doc/README.LED
>   create mode 100644 doc/api/status_led.rst
>
> diff --git a/doc/README.LED b/doc/README.LED
> deleted file mode 100644
> index c21c9d53ec3..00000000000
> --- a/doc/README.LED
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -Status LED
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -This README describes the status LED API.
> -
> -The API is defined by the include file include/status_led.h
> -
> -The first step is to enable CONFIG_LED_STATUS in menuconfig:
> -> Device Drivers > LED Support.
> -
> -If the LED support is only for specific board, enable
> -CONFIG_LED_STATUS_BOARD_SPECIFIC in the menuconfig.
> -
> -Status LEDS 0 to 5 are enabled by the following configurations at menuc=
onfig:
> -CONFIG_STATUS_LED0, CONFIG_STATUS_LED1, ... CONFIG_STATUS_LED5
> -
> -The following should be configured for each of the enabled LEDs:
> -CONFIG_STATUS_LED_BIT<n>
> -CONFIG_STATUS_LED_STATE<n>
> -CONFIG_STATUS_LED_FREQ<n>
> -Where <n> is an integer 1 through 5 (empty for 0).
> -
> -CONFIG_STATUS_LED_BIT is passed into the __led_* functions to identify =
which LED
> -is being acted on. As such, the value choose must be unique with with r=
espect to
> -the other CONFIG_STATUS_LED_BIT's. Mapping the value to a physical LED =
is the
> -reponsiblity of the __led_* function.
> -
> -CONFIG_STATUS_LED_STATE is the initial state of the LED. It should be s=
et to one
> -of these values: CONFIG_LED_STATUS_OFF or CONFIG_LED_STATUS_ON.
> -
> -CONFIG_STATUS_LED_FREQ determines the LED blink frequency.
> -Values range from 2 to 10.
> -
> -Some other LED macros
> ----------------------
> -
> -CONFIG_STATUS_LED_BOOT is the LED to light when the board is booting.
> -This must be a valid LED number (0-5).
> -
> -CONFIG_STATUS_LED_RED is the red LED. It is used to signal errors. This=
 must be
> -a valid LED number (0-5). Other similar color LED's macros are
> -CONFIG_STATUS_LED_GREEN, CONFIG_STATUS_LED_YELLOW and CONFIG_STATUS_LED=
_BLUE.
> -
> -General LED functions
> ----------------------
> -The following functions should be defined:
> -
> -__led_init is called once to initialize the LED to CONFIG_STATUS_LED_ST=
ATE.
> -One time start up code should be placed here.
> -
> -__led_set is called to change the state of the LED.
> -
> -__led_toggle is called to toggle the current state of the LED.
> -
> -Colour LED
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Colour LED's are at present only used by ARM.
> -
> -The functions names explain their purpose.
> -
> -coloured_LED_init
> -red_LED_on
> -red_LED_off
> -green_LED_on
> -green_LED_off
> -yellow_LED_on
> -yellow_LED_off
> -blue_LED_on
> -blue_LED_off
> -
> -These are weakly defined in arch/arm/lib/board.c to noops. Where applic=
able, define
> -these functions in the board specific source.
> -
> -TBD : Describe older board dependent macros similar to what is done for
> -
> -TBD : Describe general support via asm/status_led.h
> diff --git a/doc/api/index.rst b/doc/api/index.rst
> index 51b2013af36..d40e90801d1 100644
> --- a/doc/api/index.rst
> +++ b/doc/api/index.rst
> @@ -22,6 +22,7 @@ U-Boot API documentation
>      rng
>      sandbox
>      serial
> +   status_led
>      sysreset
>      timer
>      unicode
> diff --git a/doc/api/status_led.rst b/doc/api/status_led.rst
> new file mode 100644
> index 00000000000..44bbea47157
> --- /dev/null
> +++ b/doc/api/status_led.rst
> @@ -0,0 +1,35 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Status LED
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/status_led.h
> +   :doc: Overview
> +
> +CONFIG_STATUS_LED Description
> +-----------------------------
> +
> +.. kernel-doc:: include/status_led.h
> +   :doc: CONFIG Description
> +
> +Special Status LED Configs
> +--------------------------
> +.. kernel-doc:: include/status_led.h
> +   :doc: LED Status Config
> +
> +Colour Status LED Configs
> +-------------------------
> +.. kernel-doc:: include/status_led.h
> +   :doc: LED Colour Config
> +
> +Required API
> +------------
> +
> +.. kernel-doc:: include/status_led.h
> +   :doc: Required API
> +
> +Status LED API
> +--------------
> +
> +.. kernel-doc:: include/status_led.h
> +   :internal:
> diff --git a/include/status_led.h b/include/status_led.h
> index 7de40551621..6893d1d68e0 100644
> --- a/include/status_led.h
> +++ b/include/status_led.h
> @@ -4,18 +4,102 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>
> -/*
> - * The purpose of this code is to signal the operational status of a
> +/**
> + * DOC: Overview
> + *
> + * Status LED is a Low-Level way to handle LEDs to signal state of the

Status LEDs can be used to signal the operational status of a

> + * bootloader, for example boot progress, file transfer fail, activity
> + * of some sort like tftp transfer, mtd write/erase.

for example boot progress, file transfer failure, or ongoing activity
like tftp transfer or mtd write/erase.

> + *
> + * The original usage these API were to signal the operational status o=
f a

One usage of this API is signalling the operational status ...

>    * target which usually boots over the network; while running in
>    * PCBoot, a status LED is blinking. As soon as a valid BOOTP reply

What does "PCBoot" refer to? Do you mean U-Boot?

>    * message has been received, the LED is turned off. The Linux
>    * kernel, once it is running, will start blinking the LED again,
>    * with another frequency.
> + *
> + * Status LED require support Low Level and the board to implement



> + * the specific functions to correctly works.
>    */
>
>   #ifndef _STATUS_LED_H_
>   #define	_STATUS_LED_H_
>
> +/**
> + * DOC: CONFIG Description

DOC: Configuration

> + *
> + * Enable `CONFIG_LED_STATUS` to support the Status LED under
> + * > Device Drivers > LED Support.
> + *
> + * The Status LED can be defined in various ways, but most of the time,
> + * specific functions will need to be defined in the board file.
> + * If this is the case, enable `CONFIG_LED_STATUS_BOARD_SPECIFIC`.

CONFIG_LED_STATUS_BOARD_SPECIFIC is not used in any defconfig.

GPIO is the typical case and board-specific the exception.

> + *
> + * If the LEDs are GPIO-driven, you can use the GPIO wrapper driver
> + * instead of defining specific board functions.
> + * If this is the case, enable `CONFIG_LED_STATUS_GPIO`.
> + * (Note that `CONFIG_LED_STATUS_BOARD_SPECIFIC` is also required.)
> + *
> + * The Status LED allows defining up to six different LEDs, from 0 to 5=
,
> + * with the following configurations:
> + * `CONFIG_STATUS_LED`, `CONFIG_STATUS_LED1`, ..., `CONFIG_STATUS_LED5`=
.
> + *
> + * For each LED, the following options are required:
> + *  * `CONFIG_STATUS_LED_BIT<n>`
> + *  * `CONFIG_STATUS_LED_STATE<n>`
> + *  * `CONFIG_STATUS_LED_FREQ<n>`
> + *
> + * Where `<n>` is an integer from 1 through 5. (Note that LED 0 doesn't=
 have the
> + * integer suffix.)
> + *
> + * `CONFIG_STATUS_LED_BIT` is passed into the `__led_*` functions to id=
entify
> + * which LED is being acted on. The value is opaque, meaning it depends=
 on how
> + * the low-level API handles this value. It can be an ID to reference t=
he LED
> + * internally, or in the case of the GPIO wrapper, it's the GPIO number=
 of the LED.
> + * Mapping the value to a physical LED is the responsibility of the `__=
led_*` function.
> + *
> + * `CONFIG_STATUS_LED_STATE` sets the initial state of the LED. It shou=
ld be set
> + * to one of these values: `CONFIG_LED_STATUS_OFF` or `CONFIG_LED_STATU=
S_ON`.
> + *
> + * `CONFIG_STATUS_LED_FREQ` determines the LED blink frequency.
> + * Values range from 2 to 10.
> + */
> +/**
> + * DOC: LED Status Config
> + *
> + * The Status LED uses two special configurations for common operations=
:
> + *
> + *   * CONFIG_STATUS_LED_BOOT is the LED that lights up when the board =
is booting.
> + *   * CONFIG_STATUS_LED_ACTIVITY is the LED that lights and blinks dur=
ing activity
> + *     (e.g., file transfer, flash write).
> + *
> + * The values set in these configurations refer to the LED ID previousl=
y set.
> + *
> + * - ``CONFIG_STATUS_LED_RED=3D0`` will refer to the option ``CONFIG_ST=
ATUS_LED_BIT``.
> + * - ``CONFIG_STATUS_LED_RED=3D1`` will refer to the option ``CONFIG_ST=
ATUS_LED_BIT1``.
> + * - ``CONFIG_STATUS_LED_RED=3D2`` will refer to the option ``CONFIG_ST=
ATUS_LED_BIT2``.
> + * - ...
> + */
> +/**
> + * DOC: LED Colour Config
> + *
> + * The Status LED exposes specific configurations for LEDs of different=
 colors.
> + *
> + * The values set in these configurations refer to the LED ID previousl=
y set.
> + *
> + * - ``CONFIG_STATUS_LED_RED=3D0`` will refer to the option ``CONFIG_ST=
ATUS_LED_BIT``.
> + * - ``CONFIG_STATUS_LED_RED=3D1`` will refer to the option ``CONFIG_ST=
ATUS_LED_BIT1``.
> + * - ``CONFIG_STATUS_LED_RED=3D2`` will refer to the option ``CONFIG_ST=
ATUS_LED_BIT2``.
> + * - ...
> + *
> + * Supported colors are:
> + *   * red
> + *   * green
> + *   * yellow
> + *   * blue
> + *   * white
> + */
> +
>   #ifdef CONFIG_LED_STATUS
>
>   #define LED_STATUS_PERIOD	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ)
> @@ -35,11 +119,49 @@
>   #define LED_STATUS_PERIOD5	(CONFIG_SYS_HZ / CONFIG_LED_STATUS_FREQ5)
>   #endif /* CONFIG_LED_STATUS5 */
>
> +/**
> + * void status_led_init - Init the Status LED with all the required str=
ucts.
> + */
>   void status_led_init(void);
> +/**
> + * void status_led_tick - Blink each LED that is currently set in blink=
ing
> + *   mode
> + * @timestamp: currently unused
> + */
>   void status_led_tick(unsigned long timestamp);
> +/**
> + * void status_led_set - Set the LED ID passed as first arg to the mode=
 set
> + * @led: reference to the Status LED ID
> + * @state: state to set the LED to
> + *
> + * Modes for state arE:
> + *   * CONFIG_LED_STATUS_OFF (LED off)
> + *   * CONFIG_LED_STATUS_ON (LED on)
> + *   * CONFIG_LED_STATUS_BLINK (LED initially on, expected to blink)
> + */
>   void status_led_set(int led, int state);
> +/**
> + * void status_led_toggle - toggle the LED ID
> + * @led: reference to the Status LED ID
> + *
> + * Toggle the LED ID passed as first arg. If it's ON became OFF, if it'=
s
> + * OFF became ON.
> + */
>   void status_led_toggle(int led);
> +/**
> + * void status_led_activity_start - start a LED activity
> + * @led: reference to the Status LED ID
> + *
> + * Set the Status LED ON and start the Cyclic to make the LED blink at
> + * the configured freq.
> + */
>   void status_led_activity_start(int led);
> +/**
> + * void status_led_activity_stop - stop a LED activity
> + * @led: reference to the Status LED ID
> + *
> + * Stop and free the Cyclic and turn the LED OFF.

'Cyclic' is and adjective and cannot stand alone. Do you mean:

Stop and free the cyclic function and turn off the LED.

> + */
>   void status_led_activity_stop(int led);
>
>   /*****  MVS v1  ******************************************************=
****/

We don't have 'config MVS' in any Kconfig. Please remove the dead code.

> @@ -62,9 +184,61 @@ void status_led_activity_stop(int led);
>   /* led_id_t is unsigned long mask */
>   typedef unsigned long led_id_t;
>
> +/**
> + * DOC: Required API
> + *
> + * The Status LED requires the following API functions to operate corre=
ctly

The following functions are implemented by the GPIO LED driver. If using
CONFIG_LED_STATUS_BOARD_SPECIFIC=3Dy, they have to be implemented by the
board code.

> + * and compile:
> + *
> + * - ``__led_toggle``: Low-level function to toggle the LED at the spec=
ified
> + *   mask.
> + * - ``__led_init``: Initializes the Status LED, sets up required table=
s, and
> + *   configures registers.
> + * - ``__led_set``: Low-level function to set the state of the LED at t=
he
> + *   specified mask.
> + * - ``__led_blink``: Low-level function to set the LED to blink at the
> + *   specified frequency.
> + *
> + * The Status LED also provides optional functions to control colored L=
EDs.

Do you mean

Controlling colored LEDs requires the additional functions see :doc:
`Coloured LED API`.

> + * Each supported LED color has corresponding ``_on`` and ``_off`` func=
tions.
> + *
> + * There is also support for ``coloured_LED_init`` for LEDs that provid=
e
> + * multiple colors. (Currently, this is only used by ARM.)

We have hundreds of ARM based boards. Could you be a bit more specific,
please.

> + *
> + * Each function is weakly defined and should be implemented in the
> + * board-specific source file. (This does not apply to the GPIO LED wra=
pper.)
> + */
> +/**
> + * void __led_toggle - toggle LED at @mask
> + * @mask: opaque value to reference the LED
> + *
> + * Low-Level function to toggle the LED at mask.
> + */
>   extern void __led_toggle (led_id_t mask);
> +/**
> + * void __led_init - Init the LED at @mask
> + * @mask: opaque value to reference the LED
> + * @state: starting state of the LED
> + *
> + * Init the Status LED, init required tables, setup regs...
> + */
>   extern void __led_init (led_id_t mask, int state);
> +/**
> + * void __led_set - Set the LED at @mask
> + * @mask: opaque value to reference the LED
> + * @state: state to set the LED to
> + *
> + * Init the Status LED, init required tables, setup regs...
> + */
>   extern void __led_set (led_id_t mask, int state);
> +/**
> + * void __led_blink - Set the LED at @mask to HW blink
> + * @mask: opaque value to reference the LED
> + * @freq: freq to make the LED blink at
> + *
> + * Low-Level function to set the LED at HW blink by the
> + * passed freq.
> + */
>   void __led_blink(led_id_t mask, int freq);
>   #else
>   # error Status LED configuration missing
> @@ -77,20 +251,62 @@ void __led_blink(led_id_t mask, int freq);
>
>   #endif	/* CONFIG_LED_STATUS	*/
>
> -/*
> - * Coloured LEDs API
> +/**
> + * DOC: Coloured LED API
> + *
> + * Status LED expose optional functions to control coloured LED.

The status LED API uses optional functions ...

> + * Each LED color supported expose _on and _off function.
> + *
> + * There is also support for coloured_LED_init for LED that provide
> + * multiple colours. (currently only used by ARM)

No clue why you refer to ARM. I found only the following files that
providing board specific implementations:

board/beagle/beagle/led.c
board/siemens/corvus/board.c

Best regards

Heinrich

> + *
> + * Each function is weakly defined and should be defined in the board
> + * specific source. (doesn't apply for GPIO LED wrapper)
>    */
>   #ifndef	__ASSEMBLY__
> +/**
> + * void coloured_LED_init - Init multi colour LED
> + */
>   void coloured_LED_init(void);
> +/**
> + * void red_led_on - Turn LED Red on
> + */
>   void red_led_on(void);
> +/**
> + * void red_led_off - Turn LED Red off
> + */
>   void red_led_off(void);
> +/**
> + * void green_led_on - Turn LED Green on
> + */
>   void green_led_on(void);
> +/**
> + * void green_led_off - Turn LED Green off
> + */
>   void green_led_off(void);
> +/**
> + * void yellow_led_on - Turn LED Yellow on
> + */
>   void yellow_led_on(void);
> +/**
> + * void yellow_led_off - Turn LED Yellow off
> + */
>   void yellow_led_off(void);
> +/**
> + * void blue_led_on - Turn LED Blue on
> + */
>   void blue_led_on(void);
> +/**
> + * void blue_led_off - Turn LED Blue off
> + */
>   void blue_led_off(void);
> +/**
> + * void white_led_on - Turn LED White on
> + */
>   void white_led_on(void);
> +/**
> + * void white_led_off - Turn LED White off
> + */
>   void white_led_off(void);
>   #else
>   	.extern LED_init

