Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E43EEB560
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 18:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E2380275;
	Fri,  8 Sep 2023 20:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SiFaXqDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F1F86A3A; Fri,  8 Sep 2023 20:57:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB20869A4
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 20:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694199463; x=1694804263; i=xypron.glpk@gmx.de;
 bh=iNnbhPqLA6RCxz2khvFoCdyX82g73MIIARDYGDJ0/0s=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SiFaXqDS7S9z38q9YOgXdiZKYkfTK2Nm1+7VdqmTOegAlJwpzXzntwe3ZK5byKYwsV3i3Q/
 Tu6mGyPdZYSe4bP21nJXnQnoL2F7sSfBR/OSyvvIapOy8lreRtnyosDOTz6PuHDuFvoZDpM4A
 EzL0dEbhgjDBwVvPRFyz88NUdFlrZwXMVaOIpAvF3eBoO1zEfG097NIOYkKHyUeLpKNRnQLug
 3uMFtHySPoDh5eUQtXp1spahf7d+XK5j+9B1J8C8rhRRznLGazWOZBOxVMn9GhA91zTt5V21D
 WeS/4HwHvdrjeNlUiWmSqDaLNLFuhnFwp2mxZHeq3qlkKq1Nu/Gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1poEF60WcJ-00szA2; Fri, 08
 Sep 2023 20:57:43 +0200
Message-ID: <7cad48d4-7dd2-474d-b8cc-20de2e75e33b@gmx.de>
Date: Fri, 8 Sep 2023 20:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] configs: default activate CONFIG_RNG_STM32 for
 STM32MP13x platforms
Content-Language: en-US, de-DE
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <20230907162200.205602-2-gatien.chevallier@foss.st.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230907162200.205602-2-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUwrK3OKCIpIasxNACSF2yHQ84K/HKkrQry3JMY/520PJToXLfZ
 /ofajsL4UbybE7+nwHXYhsarB9frH//NZhjMD5VXLLDa33E1HKSvOEfth1Bs+JkAjdD6OO6
 V+OhcoKICWaNVZ0mSYLoYAp6HioUDHs+tp/jxmG4X6ozDQ7y8+mRGWIwYAXOtOYr/hR/PUm
 sn1Q2ZxWfohn0KqWAIMsA==
UI-OutboundReport: notjunk:1;M01:P0:pusSE8FCFY4=;3pSbsZOVWT6h8vpo+sWfvtExlxe
 UYicZA1i+X/EzT+htx+f8unxeuL0Pc+kdvCtFE1iHgK/xW6l9GJwvlonEtj6yR6wMNmkBOIDs
 HWZzDI3U7xAIx7IcdI7tRLytOIqDlW51Y1AR8lppCSyAYgbPrm6oEv/8fE4r/VQ7v74fvYmTf
 NjeLO+p8r4AB+YqQiKcwj+UQXAVX6voF8ATDba40VaSnhHRp+W4Qui5Dr98uqPkox6zxeKQ1Q
 HRqMD/aDK3TIqovBjV9OLUoOxbbnJyrqB1f4ofMWoFVXdKoqkuNDSa3VV7zNZMDi5EaJkHGxy
 NCfucKQeBqlCvWYImBs9ElIWmqb6vCKj3fzZkFsYP4h0q1z1f75ZgvgkkGHb9ZuxC4PqBtHUZ
 KxihVMnVv9xaO4FPkeJW/MgKChGmz9uGVXdmKHvwkcROqJaLEdutz2jss+9BSrMbnViPrqv7D
 SsJn87GqZh640HA62BzTMDvPWE4CVpc5Cw+wG0aXjXnAKqvMdsppfniafHmLt7XwsQDoJ04Yo
 rUkmxxdVxmHusQ8X4xot3mT/ZSmEG2L+Eyc/gMmMEExUMdSL+o3hY5Ma7Tit/P8i7ZHCAaX2p
 7inwV9b08eAJ0o+F+Gfhskh3CiUevyU7EmOj9WdePMB25AKAOk7iR8cXdmvSyMnQSnf4qwLah
 uii49dPEqvfjCV7ZTt6rq90F9a0L10gOH+T0bb2Nh5xb2oKfyaSNWHA2vGaDvgMDJzTXfpHms
 VbNdk/a9CYc53jy9FDABWZMovCvxy9D/K4FacWqHwJA2DtJjcifXPJWWd9RB4NWPRL7d3f6T3
 c0AdcfzRpzPnBu1AXMkWpHNrKIthk4VojsIZcKPEftipXRRT6n7rcIL7wB3RvcsRa5tLXWLWW
 hJYhve0Q5AG1AJz38bFPiOznTtvyDkilKYRoWBs7K4BR66PphbZDYB2vUX3Q9i46/e+uVuBb1
 bqN0kA0AZCXlWE6L+cSUSwqm/LI=
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

On 9/7/23 18:21, Gatien Chevallier wrote:
> Default embed this configuration. If OP-TEE PTA RNG is present as well,
> the priority will be given to it instead of the U-Boot driver.

Are you relying here on drivers being probed in alphabetical sequence?

Best regards

Heinrich

>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>   configs/stm32mp13_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 82b62744f6..4a899c85de 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -65,6 +65,7 @@ CONFIG_DM_REGULATOR_GPIO=3Dy
>   CONFIG_DM_REGULATOR_SCMI=3Dy
>   CONFIG_RESET_SCMI=3Dy
>   CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_STM32=3Dy
>   CONFIG_DM_RTC=3Dy
>   CONFIG_RTC_STM32=3Dy
>   CONFIG_SERIAL_RX_BUFFER=3Dy

