Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7879C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D32588CF1;
	Wed,  7 Aug 2024 15:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KnojS7gf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E94D88CEE; Wed,  7 Aug 2024 15:46:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBED88B7E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 15:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723038363; x=1723643163; i=xypron.glpk@gmx.de;
 bh=oo4q3NtIUDthbOf0iQ+zOEZjiSTPfIzrFdFD+I0vkYs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KnojS7gf50VHy6IrOULWnA4VsGJYuv4dmx8znyqBAk6hx85/sXmgP/WXJ7BYcJWQ
 h5VcpkXE2NjsK4IAqVhEi9iBs1fHBG3Gp0gq3YqFFeqh9RFR3zFhY0hNEF0iLBds2
 QIZjHzaYnodDbdfbMvwq+7WksO70HurWPrtDFYLVN4tC4sygSNa3IDrf0YzRA6b17
 qekV5DDMo/8JLCHSPEIGerqaasnhwjIsW+oxm4zSkYOwMGSgnmhoqvrDHhLR7fQbw
 0mL3fQKS7RU1GjCknl/0g8SyPGRnQuspebGpuIBq5+alr6PvLHkaB9w/VFuqYHqBf
 YRBBXcQ4sxpbXU77xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1sTxlP39Gu-003EQD; Wed, 07
 Aug 2024 15:46:03 +0200
Message-ID: <f12c4ec1-e2b9-44c4-987d-c1bffb47da1b@gmx.de>
Date: Wed, 7 Aug 2024 15:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: enable efidebug and EFI http boot on QEMU aarch64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anton.Antonov@arm.com, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de
References: <20240807130010.407399-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240807130010.407399-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Nj90lU+G94e4IYm5HH0c5MMR6QgJMKkELt0eO/kQBNg1D7V7tO
 rWnKv8zghY9rYt8AGWDw5ADeUN2aBTS5X8zXpv/eqMKWXGCbxHNQ3sIZGWTQfrBYraOtkAR
 j0nZLxR83Gwwu8vfB4srRQSlUk6UmxjsUWmUoruLKPyevTCPuLv9/vmTAnQY8mR2TddZFl6
 zVuhYq0kHDZg0lxXbJLRw==
UI-OutboundReport: notjunk:1;M01:P0:1bFoHcmM+aI=;lpJ63MKosWW4ERQsOPdTldq5abj
 yQDRm7iGDo014U5Nfz0WrKjI0KGIsxc5zXu2bwGS6lL8syzhtF7G63lRUDdh0MYkRDAEU8aN+
 frSlOlw0vHNI+TX6Y4DSPW5Qn28xLzpWHBNj8H6Z1ru+W2P8FZzJ7ThrhSoTMBbAAR5BOXPCT
 jtsMZKhKg3OYLTtptcRbR08ClFYD+uT1fO0u9yXK/VwGAv3vzcIMFslij4VaRzigPg2tENnTz
 bka5np5/aSOB4jBIF7oLC3XTIYoMNbyQwKxeCpyo3G4tKok3dSf3WWRDWDD197P39X2iTxF8D
 N1UXTG/sd1/8usU3JKyaccJTA6qHAlkIxdH7oCHuAZSIMm52tvaAbRE9AkA4p4XCXX4u79t4h
 2gWBAUAidxtQUo9hqxesN4niIkbC1NWOWI8VqviL8aKoDromoXs6eDVsKp8ClPigt5frER8ik
 SXHnqM7s595UniPMAna5+kXQbIDiu7dWKF/WYtxxRNpfMWHyRA9pOj/TNPNoxNM6Eo8SYg1lA
 GZuhM9AfB0AMlgRSTenNKffRj4TqlUvBiL61wQWkZ+R2NkaoiYtqhXO3p4CZquUwbX6yTUjzx
 nhdQzDr/lcQB4JP23xthW2SQFU+cpQvwR1MEUPB1K4wP6YLDGeyPVfVkRmtFsYT2HzSmRqKQJ
 GZPZzu3brWDpxtdHpUhYZhgnopL/Omg6tI3EO373zHqT3gfE5OYnAwClPonuYbHjAPImco509
 C7sZgz1BUPoRQsO3tyHPsxF8jUO00iq0SwctAJ0Pk4R0SIAhosjLELKHSK7LfaB6mr2bN5CfW
 P1zcQ5P60CekSZr6a55i7Kdp33OrwEYfo3Rb5kQdsRylQ=
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

On 07.08.24 15:00, Ilias Apalodimas wrote:
> EFI HTTP is a useful option to have by default and is working reliably o=
n
> QEMU. Let's enable it by default, since we have no size limitations.
> While at it enable 'efidebug' as well, which is currently needed to
> configure the EFI HTTP boot options.

Should this be added to the efconfig command in future?

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   configs/qemu_arm64_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 7e166f439087..088ba39f18e1 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -33,6 +33,7 @@ CONFIG_CMD_NVEDIT_EFI=3Dy
>   CONFIG_CMD_DFU=3Dy
>   CONFIG_CMD_MTD=3Dy
>   CONFIG_CMD_PCI=3Dy
> +CONFIG_CMD_EFIDEBUG=3Dy
>   CONFIG_CMD_TPM=3Dy
>   CONFIG_CMD_MTDPARTS=3Dy
>   CONFIG_ENV_IS_IN_FLASH=3Dy
> @@ -68,3 +69,4 @@ CONFIG_USB_EHCI_HCD=3Dy
>   CONFIG_USB_EHCI_PCI=3Dy
>   CONFIG_SEMIHOSTING=3Dy
>   CONFIG_TPM=3Dy
> +CONFIG_EFI_HTTP_BOOT=3Dy

