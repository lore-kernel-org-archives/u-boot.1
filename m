Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA566CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 13:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E817F86F44;
	Wed, 18 Oct 2023 15:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ub4PZs2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 590C886E6B; Wed, 18 Oct 2023 15:14:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6C882BBF
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 15:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697634878; x=1698239678; i=xypron.glpk@gmx.de;
 bh=ikd7HGLY9PLx7tXBv8fOsvGQULfIoPUrpBN91eVNbgc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ub4PZs2OA12QmKb+ywL2RTV1epvmoo2ytRqMX9ObgkJPX0ej99GhrDQX/JHF2BrL/J6R2GOJEYj
 rjvNkINuQMD6ose5HjPeGBSarJrdXvo/vXil+jGZjiHc3a5QWV5p++HPzb7heSjQG1SjvGUxdP+VN
 uZKiJbTIL3M9NsSkSizjIx4RUFoV5sHYfIsaemg2ByPVs68XyksGWh6rvcb/ZwEJC+f0bj8GexMqm
 3gKyV/1izFw30rvfXMOch3X/rNR8ybBqTc6LfDdX6KqmYTqW210zFCA/NhwfNdEHgdQxp4Tx4C3kb
 2e9J+aDp/OgxtxdSxjXKOzxV1Ai7EWloNhNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1qk3xP3GWv-0097N9; Wed, 18
 Oct 2023 15:14:38 +0200
Message-ID: <e1d4ae7e-2a48-432b-8895-0f469af39b4e@gmx.de>
Date: Wed, 18 Oct 2023 15:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/32] cmd: Add a few more dependencies on CMDLINE
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-5-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231016222835.596572-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yG9ngGFC17E38Et0Vys1LJKxrb3hEgTS/HIYAMyry5tMNx4Oz3j
 QOdTik7r/Jk6cWH89Dzee28ZM7X9PvTXUTrNQ/j4RtX0y/6UAvFr9jSPIohgXAhUxi8ZqGA
 FNbWMpBgfWCV6KLPcC7Q7IzpK8US87kjRo2jB0BRKlV2V9g3Tv30lqZGOBJjXBhCAao3VpQ
 5yFShRES5BJHdwwCPsDOg==
UI-OutboundReport: notjunk:1;M01:P0:J5tnwBCcZmM=;VwhXEviXZgEWEsXLE80rtb0DF9t
 Hj6g8hc8ohRuqAL35y4X4Pco8YRMqyRliPtgXMKJ3VD2ZZCHM4+7rBd1jwYDOX8MHzQrOFrTW
 JPM8yKzQiubwm/hLS14gR2QNOgnAaWbRpbH9lRRi/SWznHDF9g0gN8sAh1cpkszdQRfGdlDIk
 qWxYMGGWSXwh5EETdkCG1XzysLbXemTto86isbRr7LnQbIPtcTBc8yLAf1kdDOJOvlddlWtVM
 hQTPDJdcVn8miNMBhH6d3GxHqlZ/eMOjdkowCnQyeRJrPW4UU2k6zMBWcIp0QUaau2r8SapfY
 ilyIWFwmrZY5v+WCepm9QIJDZiR/C891+hrb0DySBQTe2okOoKhNqW/PiH/tVSVTKJAHi3ruw
 Lv+QvHme2J4ysCO8uZrWDBWPkZPVrcIyzNlVlm1aKVi5RIQtslUjb6olp050ZOKCX6pihR/5H
 q+hjAhxo+yPp4a0CAtoeJR5PJqMPYCzRRZ83JOiKeBf6deVKDYx5X06AMZLsSqpTnnPI1kYzP
 DET+enT3kZGIJhZcTBa1lDfNy4Y4LJGakzRPJ9j6lGzisV58aiWOirhaxEYz8ima2Nom2bdmk
 ZFdepBFOPrOqbhhxpknDJZbjBm18Mo6mc5KySSoId/m1f3hEFFLGSKs9cwk5qWprcJUrInI2q
 kW7qfp1PExYx8crQcqFholAmpEYD8nnLY/+dmWTVlVSQQNiKISfx1rhU2qecxx+Cn3RdmN8Rp
 NUfu1+UjSM+9pVMFWH6MsixP4Tr3OJc5AQu0yMY9AMTpwwWAokxZ+Jm5VZzObMEZtDVJDOwNc
 SyA24PzU3whNB1teGW0WAcQnorhPoQXuy7WXlGyrY/wVmmX/focjK3f2xqVcSihFcLObR9hST
 UVXvOPV4oh8LWAJ+UOR59CM5e2BR8n81hA/uUHebMmjZcOJpzCnjj58SDJmIegThNvFkU9Ov6
 mQgsOxaRchcGonmwuRvUUh5Lp5U=
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

On 10/17/23 00:27, Simon Glass wrote:
> Add this to some more commands to avoid build errors with sandbox.
>
> Note that this is a temporary solution to expose more problems. A later
> patch puts these behind an 'if CMDLINE'
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Add an explation as to why this patch is here
>
>   cmd/Kconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5bc0a92d57ad..00a7f84bce99 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -231,6 +231,7 @@ menu "Boot commands"
>
>   config CMD_BOOTD
>   	bool "bootd"
> +	depends on CMDLINE

Why don't we simply use a single "if" for all commands?
Adding the same dependency to 200+ commands does not feel right.

If there is any CONFIG_CMD* that is needed without CMDLINE, then that
code should move to lib/ or drivers/.

Best regards

Heinrich

>   	default y
>   	help
>   	  Run the command stored in the environment "bootcmd", i.e.
> @@ -420,6 +421,7 @@ source lib/efi_selftest/Kconfig
>
>   config CMD_BOOTMENU
>   	bool "bootmenu"
> +	depends on CMDLINE
>   	select MENU
>   	select CHARSET
>   	help
> @@ -486,6 +488,7 @@ config CMD_GO
>
>   config CMD_RUN
>   	bool "run"
> +	depends on CMDLINE
>   	default y
>   	help
>   	  Run the command in the given environment variable.
> @@ -576,6 +579,7 @@ menu "Environment commands"
>
>   config CMD_ASKENV
>   	bool "ask for env variable"
> +	depends on CMDLINE
>   	help
>   	  Ask for environment variable
>
> @@ -2132,6 +2136,7 @@ config CMD_EFICONFIG
>
>   config CMD_EXCEPTION
>   	bool "exception - raise exception"
> +	depends on CMDLINE
>   	depends on ARM || RISCV || SANDBOX || X86
>   	help
>   	  Enable the 'exception' command which allows to raise an exception.
> @@ -2238,6 +2243,7 @@ config CMD_SYSBOOT
>
>   config CMD_QFW
>   	bool "qfw"
> +	depends on CMDLINE
>   	select QFW
>   	help
>   	  This provides access to the QEMU firmware interface.  The main

