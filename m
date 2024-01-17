Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54986C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 12:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE4B878A5;
	Wed, 17 Jan 2024 13:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="GA/bMEsJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0kR6sUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27ED4879E5; Wed, 17 Jan 2024 13:44:30 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1501A87186
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 13:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Wed, 17 Jan 2024 13:44:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1705495467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Qz5mzbjo4hpyolKUpNtvs1Onf+1+cEcdMrkVsfyTg=;
 b=GA/bMEsJvcANM+F7tVjQLh+lZV0H1QsDV3k28D7/2clPDU0AoCuunFyVvPe2Ih8B1VyyCe
 Gl9ZUpz4W3/23CHxQFnWFs1T7ncF6Gp5M20/Fu9bo2VsrdIM545ek8jtBVajf9u6CS5OI3
 ZCGPkB0QDdYLU4lo38GzUbdqPtOimDJRpgPlu9V4m7VdzPu0K55ycJqP4E6Ng/XTWoWvw8
 +nJ4aDg/W0cXCoUdO4+G5tk5do3XCUrfuUsl0c175pSRR+wnUPWT+Zv/Fgtl4FsqhR8lep
 UESX25ieG+iQm6xNvU9KuCrG6ZVYMoCUHF2nV52C/H7rYfe05mcRl1HPBsXQEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1705495467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Qz5mzbjo4hpyolKUpNtvs1Onf+1+cEcdMrkVsfyTg=;
 b=M0kR6sUzOMBwMWqaHovXVi89HHggRFSqDlzd40ua3o1V17io294pxiOyKwm6fpG8BvGI8V
 Ms3qN6N9vfnBhQAA==
From: Nam Cao <namcao@linutronix.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] riscv: dts: starfive: add regulator device
Message-ID: <20240117134424.208d251b@namcao>
In-Reply-To: <811391b298858a02cbaae0dfafb92073b701e7d1.1705489598.git.namcao@linutronix.de>
References: <811391b298858a02cbaae0dfafb92073b701e7d1.1705489598.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 17 Jan 2024 12:15:25 +0100 Nam Cao <namcao@linutronix.de> wrote:

> Add the axp15060 regulator device. OpenSBI uses this device to perform
> board reset and shutdown.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> index e94f9fe826..388d29727f 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -127,6 +127,11 @@
>  	pinctrl-0 = <&i2c5_pins>;
>  	status = "okay";
>  
> +	pmic@36 {
> +		compatible = "stf,axp15060-regulator";

I should mention that Linux is using the string "x-powers,axp15060" for the
same device, but OpenSBI is using this one. So I'm not entirely sure which
one should I use here in U-Boot. If we use Linux's string, then OpenSBI
needs to be changed.

> +		reg = <0x36>;
> +	};
> +
>  	eeprom@50 {
>  		compatible = "atmel,24c04";
>  		reg = <0x50>;

