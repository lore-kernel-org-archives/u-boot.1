Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC3FCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 18:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C9486D2D;
	Mon, 16 Oct 2023 20:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lP3xZmoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D4686DE3; Mon, 16 Oct 2023 20:14:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55753867F6
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 20:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697480060; x=1698084860; i=xypron.glpk@gmx.de;
 bh=l5ttqy3IjtNmbSBVjg/oVLjqnMu3qxbILgVoAei6UA0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lP3xZmoLQeSpe74PXBNHhkL8lr15P9DwVNXyQANHDsQF0wJIRSg9MsGfauY0ZNdn7Z4HCZtodjp
 BQlgFvB98cDCXQxNHm532SpedG6C7U8g6LiTLWkEJWoiPXOhKk9kl9DbnRWfXCi3bFqmjwb2jnBsr
 4/pl2fX6SeiNjvWNcHkETqFZp176JcHORuvMeDQxj/YjPjYusomHIzBztxEL78t86kisXjm6Z3xho
 tVJ+oG/hqi20JspVnCBoNmJFFBws/wD96PFvegND4Nw8oMLvlSlaf8I0JZ88Qbpwchk3t5iPpwF2A
 d2x195a/QhOqDM8ZJtVFsHNeuv7k8vtibyhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1r8bNe3Z7V-00IyvE; Mon, 16
 Oct 2023 20:14:19 +0200
Message-ID: <c7018872-cd6a-4668-a556-814f1c7d2557@gmx.de>
Date: Mon, 16 Oct 2023 20:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] cmd: test_enter_suspend: Add test_enter_suspend
 command
Content-Language: en-US, de-DE
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
 u-kumar1@ti.com, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>,
 u-boot@lists.denx.de
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-10-thomas.richard@bootlin.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231016141135.325698-10-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G62OFaKfpgFN4QqMZwP4Sty6eVpTIvYnfVEe5VhFNrqCtE6zhDu
 qHcqRajqIICiAFAYuOTyXoVMxlV8sD89qhYswv6SOtOay0afCqsvkoCTDufz4CxDLkHJhHn
 IEAC4MqX8vQfr0cJRzeTA6C+5dSP/g5DgwBPTMgv2yJuEd+Ig7PJ8693BDzWj4xk855xp3z
 rdIDFNwNkvWFQY8poRP2g==
UI-OutboundReport: notjunk:1;M01:P0:a0HdGznbnW8=;cSDXz7ZWzbCnuxIHHVkY8QcxPbm
 NyvwGhmHR+CMiYTKNvPtYHDkLKzHnJX4Ycd1YKDWftOJe6nmLRNCNlgRi8Q5KYH3z82T9qHC1
 t38irgjT1ehf09JFoWimRMTsLs9ey+yYx6KyCIzFFY3Agi8BmupCDMNYRpK6diSSsAqnSm5yW
 PYsOrgeCm8rhWkzn39aGK/Kjsz66zFwJOCbB30NKNdjG54yOlbSKYaIfN7+8fOxVRYnLshjYy
 I0iVZhS3efXu5eA4Q25UjH4BmMvQQ+Xfgm0f/YGBL+DPOk7JaIYvI8CU13j9yE/NTymoLNcs+
 CZfAujc/cdVVmt4VydGGR+F1q93Cg+0QDgZLbaSN7IXQiwxqcVkfovWQ9Uc3rGqTwEA2KuZMo
 nqP3kafwItvGujUQBFEYCq1Jp/rkhMyjDnFmImXHRy5xiY5ccBtKOogZuqa8miMbbUcV8hWEV
 HA3VQipL97sSseFCoev97rguPHASQlPDfJzO6FLTvrVZuEZghjSm3qV4CaNk7Wfr1hLxRlEn5
 xsQrapCyHctqoQQbbZmx27scGEQU7xJhuU16LbJlJ0EWmRT3Uv+JxfSRE8mPsKztGGxCARiwO
 +sgY6hD/MfqXKpZAjGBmKYRolORIKjXPaNMzgIZi0FbN2s+IlGtQbnI4Td/MQRkhIxaH+g/5f
 pHx06wYa1/XmQAPpDC6DPZR0NbQV20RUfDEQ4XuQ2ACWKi12GCETCDZt6VyBhINF40X03nLQ5
 u3mB22lolCFFTD7uVOoKLrjtsMqiBb/LhtGwNtM52ZhYAJCvYG8wL1W8oWfJ00LASfsIuBdjq
 HgF04cGmIX2V2hcgYV4mZJ24bU9NYfIKsTaU4GZOQjn7t+hhabHv8lvFHO8MpjDSg9LbXftk9
 nWfeK7cpa3HVnd+sjzEDflu+VUoWIWxwbakBXmYQBlI6wRiHDfdUxpQrjpXV/SciMZQrnyUrj
 jDpwFT8SiqXhI4etoEOUm1D0jxM=
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

On 10/16/23 16:11, Thomas Richard wrote:
> From: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> Add test_enter_suspend command using PSCI.
> This command is only to test suspend sequence from U-Boot.
> The resume will not work.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>
> ---
>
>   cmd/Kconfig             |  7 +++++++
>   cmd/boot.c              |  8 ++++++++
>   drivers/firmware/psci.c | 23 +++++++++++++++++++++++
>   include/command.h       |  2 ++
>   4 files changed, 40 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 43ca10f69c..54e7d4b0e6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1450,6 +1450,13 @@ config CMD_POWEROFF
>   	help
>   	  Poweroff/Shutdown the system
>
> +config CMD_TEST_ENTER_SUSPEND
> +	bool "test enter suspend"
> +	depends on ARM
> +	select ARM_SMCCC
> +	help
> +	  Command to test the suspend sequence (only for test)
> +
>   config CMD_READ
>   	bool "read - Read binary data from a partition"
>   	help
> diff --git a/cmd/boot.c b/cmd/boot.c
> index 14839c1ced..609c07a5a5 100644
> --- a/cmd/boot.c
> +++ b/cmd/boot.c
> @@ -70,3 +70,11 @@ U_BOOT_CMD(
>   	""
>   );
>   #endif
> +
> +#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
> +U_BOOT_CMD(
> +	test_enter_suspend, 1, 0, do_test_enter_suspend,
> +	"Test the enter SUSPEND sequence of the device",
> +	""
> +);
> +#endif
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c6b9efab41..591ad1869d 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -23,6 +23,9 @@
>   #include <linux/libfdt.h>
>   #include <linux/printk.h>
>   #include <linux/psci.h>
> +#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
> +#include <cpu_func.h>
> +#endif
>
>   #define DRIVER_NAME "psci"
>
> @@ -303,6 +306,26 @@ int do_poweroff(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
>   }
>   #endif
>
> +#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
> +int do_test_enter_suspend(struct cmd_tbl *cmdtp, int flag, int argc, ch=
ar *const argv[])
> +{
> +	do_psci_probe();
> +
> +	puts("suspend ...\n");
> +	puts("disable dcache\n");
> +
> +	dcache_disable();
> +
> +	/* ARM_PSCI_1_0_FN64_SYSTEM_SUSPEND */
> +	invoke_psci_fn(PSCI_0_2_FN64(14), (unsigned long)do_test_enter_suspend=
, 0, 0);

Suspend exists on other architectures, too. E.g. OpenSBI provides an
implementation for RISC-V. It would be preferable to add suspend as a
value to enum enum sysreset_t. Then that functionality can be
implemented in sysreset_psci.c sysreset_sbi.c, and others.

The command should simply be called 'suspend'.

Best regards

Heinrich

> +
> +	dcache_enable();
> +
> +	log_err("Suspend failed or not supported on this platform\n");
> +	return CMD_RET_FAILURE;
> +}
> +#endif
> +
>   static const struct udevice_id psci_of_match[] =3D {
>   	{ .compatible =3D "arm,psci" },
>   	{ .compatible =3D "arm,psci-0.2" },
> diff --git a/include/command.h b/include/command.h
> index c4e3170967..0126da6b37 100644
> --- a/include/command.h
> +++ b/include/command.h
> @@ -177,6 +177,8 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int ar=
gc,
>   	     char *const argv[]);
>   int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc,
>   		char *const argv[]);
> +int do_test_enter_suspend(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[]);
>
>   unsigned long do_go_exec(ulong (*entry)(int, char * const []), int arg=
c,
>   			 char *const argv[]);

