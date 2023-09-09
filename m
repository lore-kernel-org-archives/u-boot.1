Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41530EEB587
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 10:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC84867EA;
	Sat,  9 Sep 2023 12:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KrSO/EDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30FC864A0; Sat,  9 Sep 2023 12:50:29 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CA6867EF
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 12:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B75FEB80FC9;
 Sat,  9 Sep 2023 10:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538AEC433C8;
 Sat,  9 Sep 2023 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694256625;
 bh=fVQ3lbNdOLzdglZ0SCQUpjTBMODdDMEz7YP26bNk2qI=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=KrSO/EDlrSHs7L86XeDobY2eNFXI04N5iH4AB7lqyMYHjv1XXi7hLf6zczn7+phuP
 GgdzWK76JP70RrWIcTJaGkfHncqSgYm+bhy7dTl2lyXNy4Koy3UQGWb1WNUh60e7wk
 jN1T4KG8fRUuJCQdV3pIZ4zdNyBYTZ2OsrAmHvZ80VfDyWx15VAEXh9xUz+0KXTywL
 Nn5aO1p6wcEoPSff8teG7IEMbsJhgkWnu2lPugGqMQmEMZYUuKK3Ulnr/BCIG2jS5b
 tLW5V+1mM6srTwq3Gis0ZjqpZ/nS4qOZw4L8sIoxD+bU46STdO/7lkGTmNfYafUNja
 zLlk27/pWk2QA==
Message-ID: <6b1b5722-f609-21cd-cd24-c36a7bc9c9b6@kernel.org>
Date: Sat, 9 Sep 2023 13:50:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 01/16] arm: dts: Introduce j784s4 dts from linux kernel
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jason Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-2-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230908110551.861575-2-a-nandan@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 08/09/2023 14:05, Apurva Nandan wrote:
> Introduce the basic j784s4 SoC dts from the next-20230905 tag of the
> linux kernel.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/dts/k3-j784s4-evm.dts         |  864 +++++++++++++
>  arch/arm/dts/k3-j784s4-main.dtsi       | 1571 ++++++++++++++++++++++++
>  arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi |  703 +++++++++++
>  arch/arm/dts/k3-j784s4-thermal.dtsi    |  101 ++
>  arch/arm/dts/k3-j784s4.dtsi            |  294 +++++
>  5 files changed, 3533 insertions(+)
>  create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
>  create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4.dtsi

Shouldn't this patch come last in the series?
What about DT-binding documentation for J784S4 SoC and its modules?

-- 
cheers,
-roger
