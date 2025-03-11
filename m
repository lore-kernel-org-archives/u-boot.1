Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC67C28B30
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBCC80FB9;
	Tue, 11 Mar 2025 14:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Tja7z3Sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E3E811C1; Tue, 11 Mar 2025 14:59:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274788003E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741701556; x=1742306356; i=xypron.glpk@gmx.de;
 bh=TOcVS0EdbsEWh7KzkkJgIzrcnifYcD8tngULgoOdnNc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Tja7z3SpWKcuWFDrWq7vEq/9XCSYI8Yd/YEPaVIyBvIyAnuh0ES2UiwyiuIUi8xb
 aDHYR9f5LAuY0fBjilOqVtvKmb5/cuqb2UMgF9Ll/QWjcIpBXxOZ65QV+++EoDdli
 QIV42cVRueP9veSzxpn3MzR6zZLkQV3y6YW8erK0N/iGVh9PrkZgD/sejHXfLGoZ9
 lVOepTh0ZBFZZiUQzT5zEM9GLRNFE+eqF0aEB0ZIDbFRNSkyJWmuAsewGYM7fnvLB
 h9rtnFMX3rpbwZISngFvXA9zRreDCoarKLf1xLqhR4ZXwGG10U317bI1R7bxl8/it
 yTmyVyeDdP13ft+xdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1tq6KA3tkn-000qBp; Tue, 11
 Mar 2025 14:59:16 +0100
Message-ID: <94b900c3-56bd-41fa-a2de-a47b21e02ee9@gmx.de>
Date: Tue, 11 Mar 2025 14:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] booti/bootm: riscv: Verify image arch type
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Janne Grunau <j@jannau.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Atish Patra <atishp@atishpatra.org>, u-boot@lists.denx.de
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
 <20250311133506.124914-4-mchitale@ventanamicro.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311133506.124914-4-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nGYr3ML0i4OVH1iEVFyGbQGQExL1PoO/+hxVihBCWvXdFK0+lvE
 oZBV+9XrWTbdKPs78oWejOj98u9EKm9mWefUZDCaooEYJGWaWe0UAwL9/M8FibgBK106IXF
 6wN46DNWhc3+lvrBGAeXfsVauBG8yT6w0pzTkWGFp/GC/8mL7MWwMOPH+LJba/PAbWZoUzk
 Wfr8sWg4Zq/CebSThRm5w==
UI-OutboundReport: notjunk:1;M01:P0:2cLYm1b3o2I=;H+LbLw+xc+hP9WQC1Q+v6TWXw9O
 MMJiiX+Bf40hiiLslsIlHSJT1KQ723gl1iRj5mJNd2cPE0v+X8hkooDDRxkG/FCXjGj74H6Fy
 6tidZKa1D0hdLwxRn2Tleh0kFODuOIClUmuQpdrLZjwzvsBA4O8MrHJnb8pHCSvp0gchTDIdL
 QmTQDrH9gin/XwKi3wwFclpKU3A+fLoRzOSpzEK5ieFn9IU2MVY0IFlqs4YKNvOLDBOjaGZyg
 JamB8khbpbuT9VCS+nxnXhpRc274Fijd+t07SuMU28E+ocnFjnNZusdzF2ZxInP7IZ4I/X6wU
 kPqn6VrxaF8NwLQmDuw7dJRs7GLHcGnWGUyvmV7hULs7VlLAahXtraJQJ6lBMtbrTQz6+yP4O
 rKvXSBFelGj8JufS1tCMUwN/Ue2CRw6lAHi5XOSb5SePYQZw+24glJYoqlc881CTn5zgvDrKF
 wQnjO+l3VG07Y/1dMBK1rY0FUuc3+yCE0aAzTp4C6N6zAPhZLm5wZTqWOsA0EhJSHv/kqPH15
 seVT0QmEM+6THuE8o02WLYSjOMHcNh00Lx7S5bJWlpx8G/2o/FiE7rKYVppozntkwum4oEDeo
 Cak8QYBMuMHsPGOHND8cvF4JfBbcBwWHJlXGV2o8wLbxaJclH36Wuq1j+4QS9wJw4EA+GNuhq
 gDNnNFkgwe1pZsDQFrGVVdoe+7pv1kn8ad8QLxv/N3RDHTVn2ibQM/g5msrNaF0tH8Nyou9QD
 Zqsv7vzLwWuqyg7QiYEj8Hz032VOkmJCAot7zvXUZGQShc3edCz4SxxOTcgzAdgsteXymUVsO
 CqxM2QZRx8yLgwdUmf1m4cBiM2EJ50ubJLEq2Wj4II0rwDQ810xt9Fkm8HW0SfHfUU6Mf4ZNq
 Zm6GelKMgYRnIVbqBZpSkzpj22o44nmR6NB62CMCMnC0t4oc2wiuRcSq7uW+zzO/EYAJg34Uz
 zexc35jC3l2dpGD1KZC+l9y+I3jNxtg34J9m3m9/KQiCpPVzUafmT1Q/m6PBLm7u9IrH+EuNW
 LB6Y1gSnSB1Sy1b7ghiunyHJRStr9rEskQvSwAU7Wp9qHvAClZ0s0BeWGOLEd/avLc6C9wKQD
 aofuVl1b3mU/uOSpMKf2Rm84pdYTgUbXi9s/20mAI+dAtu9CaBHiAbHrjlOB0Cdh9o/RPPhnH
 6OOrBvo1E71QwDTgSMcAwsI4UuAsPrSqgeBfj54+uFxvyG255bOnM8/xutaUCnEL5/zflrT08
 bOQ5tUvXqO7G/J37474kBQgqYrRhe9T8geDo1vzU3JZLyNkF+VTNyJZr06dxJDMlmQBcp3kbj
 /KeaMp5GTzW8OYCH7Nzb3czQSw0oHk4Y4nM0C32vEvB7/wejNWxeCtCuYrz6dDDPRDb/IyKFV
 oHpJHdRua8bjQ/jkzRSNIkvDDclIts6GUozqyesLaNxhvI5C8eDFcpRZ/i
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

On 11.03.25 14:35, Mayuresh Chitale wrote:
> Unlike ARM and X86, booting 32-bit images on 64-bit CPUs is currently
> not supported for Risc-V. Hence, for bootm, disallow booting a FIT
> or a legacy image that was built for an arch type which is different
> than the current arch and for booti, set the arch type to be the
> same as the current arch.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   arch/riscv/lib/bootm.c | 4 ++++
>   cmd/booti.c            | 5 ++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> index 76c610bcee0..90f71bee6a5 100644
> --- a/arch/riscv/lib/bootm.c
> +++ b/arch/riscv/lib/bootm.c
> @@ -94,6 +94,10 @@ static void boot_jump_linux(struct bootm_headers *ima=
ges, int flag)
>   	announce_and_cleanup(fake);
>
>   	if (!fake) {
> +		if (images->os.arch !=3D IH_ARCH_DEFAULT) {
> +			printf("Image arch not compatible with host arch.\n");
> +			hang();
> +		}
>   		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
>   #ifdef CONFIG_SMP
>   			ret =3D smp_call_function(images->ep,
> diff --git a/cmd/booti.c b/cmd/booti.c
> index 1a57fe91397..00921ec4a9d 100644
> --- a/cmd/booti.c
> +++ b/cmd/booti.c
> @@ -131,7 +131,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
>
>   	images.os.os =3D IH_OS_LINUX;
>   	if (IS_ENABLED(CONFIG_RISCV_SMODE))

Why do we check for S-mode here? Wouldn't checking CONFIG_RISCV be more
adequate? Think of a micro-controller with only M and U mode.

sipeed_maix_bitm_defconfig has CONFIG_RISCV_MMODE=3Dy, CONFIG_CMD_BOOTI=3D=
y.

Cf. 3cedc97479ff ("RISCV: image: Add booti support")

Otherwise looks good.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> -		images.os.arch =3D IH_ARCH_RISCV;
> +		if (IS_ENABLED(CONFIG_64BIT))
> +			images.os.arch =3D IH_ARCH_RISCV64;
> +		else
> +			images.os.arch =3D IH_ARCH_RISCV;
>   	else if (IS_ENABLED(CONFIG_ARM64))
>   		images.os.arch =3D IH_ARCH_ARM64;
>

