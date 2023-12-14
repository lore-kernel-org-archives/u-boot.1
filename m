Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6165AC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 08:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCDD87A00;
	Thu, 14 Dec 2023 09:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q2TyWMYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563098798E; Thu, 14 Dec 2023 09:11:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB6387A3C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702541483; x=1703146283; i=xypron.glpk@gmx.de;
 bh=sPGs94aiWyTA4+ksqfgnt3+eQkTi3Y1SkbLYI+GgzU8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=q2TyWMYIB2XQ9HvEIwEAoDdQ0V0ZIKCRyotYvLJUYTl5VWSZeIGT3fLOa47kb6yb
 tbGbjNaVJaWvsVOuF2fhRbOSn5M3uS1pTxYLCGw+ebk+HhR8AnaZJ30G1gBtdY5KX
 GpDmYaYONh+0RovKlcHyhEJMUo8EDdcsYxIs0sGuofKxkIIq69jn3CvHLVCY1N7+J
 VTd86oNiJ+ggV7XydI4g9FQpsnyLhRV5hmv6l54Ga76HgMGy+9ikQdjsvY2wWfp2J
 E+zvKgLKj393CzkR/fodvIrCEGnfcSFy4DaszRo4/Jk7dqTgNfHpRNd9iB7FV4Y5N
 HuIAEzMQy9l6WUT8JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1rVDfH0Kh6-00qz4l; Thu, 14
 Dec 2023 09:11:23 +0100
Message-ID: <3f130fcc-845e-48a5-b68f-bb569ba3e165@gmx.de>
Date: Thu, 14 Dec 2023 09:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/34] video: Add a function to clear the display
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Harald Seiler <hws@denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20231002011553.463514-1-sjg@chromium.org>
 <20231002011553.463514-14-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231002011553.463514-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:77Hz4qOHKqP37v2emq5KfZtkiSYFUYR2mi0TmP9veNMpgOMbtOZ
 iKOXjGMJ6kGd2mC56XoxYaYZtsCU8QVEW1syBD+s6GXdgmcmjF2wfoebp8ku/ktPHgiFw9Z
 S9xL6KBk8qF+Ear9VZtE35f87i+8IB36fj+rsqCziCEjQ17kHKRx1ZdfL0mXHfc36fKYg10
 faSkMi2ZA6x8HAOiAirnQ==
UI-OutboundReport: notjunk:1;M01:P0:joA3wK8sdQU=;47tXDbXwYCQAanrQk/sDPZfxYQN
 Lyps6jUTfV9oA/T1j2UexHxeC86Aw+7MR42qIilduPkx2WZ/3SLgowrmDN7x7jqEK1mJ2cty/
 hiuc6fSpeOs3hrnX9FwXfgHTOnsLLtvECEw4giIGzLMP6KnSVF6hP1WdwLXT5DS9dIFXX4Y9v
 C0HyABqG3LBvxQ4NbTGYEyLUfceaCToQpELNc77hyfPVZ1c3Gwqhq2osGL2gTWWYWEYPbF4Bc
 VpB2jnxj2B7G7+EO0sNaV3V0Bvtre3D9BZ4q1AhLEZEdE6gGrpt84kXI+je5PlwJcAp0m8FT3
 Ux5cVwCOJf3+2Eszn6Q2pEG31E/wYbv7VeLKKLGvonj6Uw9okoELBgu/taXf4U2tI3bVAd+1s
 67XU1J9kVE9++SaLnLDpG/kdAC4xWG1bqAJ5qFBsgrt0pIPQDZEz/GXOZ+/SqKmb8yDuikOKB
 o9Op/PFnVEvOM9nT5F/CMsMjnGHoccGxU9pWsD5yLx9RAspUquXhJmTrNYsPpwaaTuXa811kX
 R7Nfb/PkpmT8mtflGeVju/2dJLi7kyzhJObUWRSEMhIP33Dnz0UDhefsBchTHV2lkCIy6qhIb
 GbRoXLUP2ky5lNfayDKzkhc/JRUtiDA8kq/IJ+9HlxFHja+yChhR7ADgI3HV978leMsuLUJaQ
 zQ0I330YNc2mCDYy1PnI7mDSvrzX2YmI02T/OG+5GXvgPNS4sWbTb0DjomlvYK5z6tyiKJVVq
 PtEl5rtLrFjN3m0g+ZwU65tnGTiqqrS86mMcB6fc+3ExEPpB3drFwNI3y2bpye8B1f+d4yEFF
 4L8MnIc4D6PgQtY2CkwtyeAimKE5K3dUqmaRSZGISetagSdLBeDLDno6NaPNCS0RxeWuzmqBZ
 HY6JVksGYwrqahUDQjkDq9/GrM1Bu4kF11EVxZGWCXBevxl6uVkq7K61bPn0vhF60mTGq8G1Z
 JZmClSxtOY5pVaR56PVwn30hCCU=
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

On 02.10.23 03:15, Simon Glass wrote:
> Move the code from the 'cls' command into the console file, so it can
> be called from elsewhere.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   cmd/cls.c         | 25 +++----------------------
>   common/console.c  | 31 +++++++++++++++++++++++++++++++
>   include/console.h | 10 ++++++++++
>   3 files changed, 44 insertions(+), 22 deletions(-)
>
> diff --git a/cmd/cls.c b/cmd/cls.c
> index 1125a3f81bbb..80d0558d4679 100644
> --- a/cmd/cls.c
> +++ b/cmd/cls.c
> @@ -7,33 +7,14 @@
>    */
>   #include <common.h>
>   #include <command.h>
> +#include <console.h>
>   #include <dm.h>
> -#include <video_console.h>
> -
> -#define CSI "\x1b["
>
>   static int do_video_clear(struct cmd_tbl *cmdtp, int flag, int argc,
>   			  char *const argv[])
>   {
> -	__maybe_unused struct udevice *dev;
> -
> -	/*
> -	 * Send clear screen and home
> -	 *
> -	 * FIXME(Heinrich Schuchardt <xypron.glpk@gmx.de>): This should go
> -	 * through an API and only be written to serial terminals, not video
> -	 * displays
> -	 */
> -	printf(CSI "2J" CSI "1;1H");
> -	if (IS_ENABLED(CONFIG_VIDEO_ANSI))
> -		return 0;
> -
> -	if (IS_ENABLED(CONFIG_VIDEO)) {
> -		if (uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev))
> -			return CMD_RET_FAILURE;
> -		if (vidconsole_clear_and_reset(dev))
> -			return CMD_RET_FAILURE;
> -	}
> +	if (console_clear())
> +		return CMD_RET_FAILURE;
>
>   	return CMD_RET_SUCCESS;
>   }
> diff --git a/common/console.c b/common/console.c
> index 98c3ee6ca6b8..1ffda49c87e0 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -19,12 +19,15 @@
>   #include <stdio_dev.h>
>   #include <exports.h>
>   #include <env_internal.h>
> +#include <video_console.h>
>   #include <watchdog.h>
>   #include <asm/global_data.h>
>   #include <linux/delay.h>
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> +#define CSI "\x1b["
> +
>   static int on_console(const char *name, const char *value, enum env_op=
 op,
>   	int flags)
>   {
> @@ -1010,6 +1013,34 @@ int console_init_f(void)
>   	return 0;
>   }
>
> +int console_clear(void)
> +{
> +	/*
> +	 * Send clear screen and home
> +	 *
> +	 * FIXME(Heinrich Schuchardt <xypron.glpk@gmx.de>): This should go
> +	 * through an API and only be written to serial terminals, not video
> +	 * displays
> +	 */
> +	printf(CSI "2J" CSI "1;1H");
> +	if (IS_ENABLED(CONFIG_VIDEO_ANSI))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_VIDEO)) {
> +		struct udevice *dev;
> +		int ret;
> +
> +		ret =3D uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev);
> +		if (ret)
> +			return ret;
> +		ret =3D vidconsole_clear_and_reset(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static void stdio_print_current_devices(void)
>   {
>   	char *stdinname, *stdoutname, *stderrname;
> diff --git a/include/console.h b/include/console.h
> index ceb733b5cb69..e29817e57b00 100644
> --- a/include/console.h
> +++ b/include/console.h
> @@ -156,6 +156,16 @@ int console_announce_r(void);
>    */
>   void console_puts_select_stderr(bool serial_only, const char *s);
>
> +/**
> + * console_clear() - Clear the console
> + *
> + * Uses an ANSI sequence to clear the display, failing back to clearing=
 the
> + * video display directly if !CONFIG_VIDEO_ANSI
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int console_clear(void);
> +
>   /*
>    * CONSOLE multiplexing.
>    */

