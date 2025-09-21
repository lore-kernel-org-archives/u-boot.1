Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD81CAC5A7
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 15:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C6E83211;
	Sun, 21 Sep 2025 17:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=easynet.dev header.i=@easynet.dev header.b="AJgoRCPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B8E8334F; Sun, 21 Sep 2025 17:59:41 +0200 (CEST)
Received: from smtp02.easynet.dev (smtp02.easynet.dev
 [IPv6:2a00:ece1:2:10::1:111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D53E8317B
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 17:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@easynet.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=easynet.dev; s=mail;
 t=1758470378; bh=VpyrwH34+zewmiuz1evkvknGmulOFeya7RsF/q19gPA=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=AJgoRCPUIaUjcozLGQQAWOum+nz9+StDRDVC0ieuZ6Pk9h1ELmWEW/s5wXtnS5K8c
 +ouk/r/mNwYf5U2J5K9u6fRzXw/fPnCqyTV2c/Ykw/2sIfMLpm/RN2i+O5ySoNA0Fq
 S0drs34WyiS1EjRi/UwH9lDsw0cUAYEKsl9c/f7zhrvQ3/yRU+nJyApRM0oQWBMUix
 kl/TJ8Iwp/YAJnTLjvlv1L9/Ive5op8YsijaCQTDHXj143aln8MzTxSz03VAz5641R
 imkZCGwHzLnr4OhSXZj8hHrr0pmPsO862rpItfnlfOljBUQzhY9/yLeQRtjiF/2DtX
 Nb39xjRJDX4Cg==
Received: from [IPV6:2001:171b:2267:5ac1:f86e:749b:e8ed:f7dc] (unknown
 [IPv6:2001:171b:2267:5ac1:f86e:749b:e8ed:f7dc])
 (Authenticated sender: adrian@easynet.dev)
 by smtp1.easynet.dev (Postfix) with ESMTPSA id 77B3F6007F;
 Sun, 21 Sep 2025 18:59:38 +0300 (EEST)
Message-ID: <3231d65c-ee16-4dba-874e-533b0fae3c9c@easynet.dev>
Date: Sun, 21 Sep 2025 17:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix Linux reboot on MT7988 using EFI and PSCI
To: u-boot@lists.denx.de
References: <20250921155605.1592643-1-devel@easynet.dev>
Content-Language: en-US, fr, fr-CH, de-DE
Cc: frank-w@public-files.de
From: EasyNetDev <devel@easynet.dev>
Organization: Easynet Consulting SRL
In-Reply-To: <20250921155605.1592643-1-devel@easynet.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Frank W,

Hope now the patch is in correct format.

Kind regards,
Adrian

On 9/21/25 17:56, Adrian Ban wrote:
> From: EasyNetDev <devel@easynet.dev>
>
> When booting Linux Kernel with U-Boot EFI -> GRUB EFI -> Linux Kernel
> reboot is not possible using "system reboot".
>
> Adding PSCI node in devicetree fixes this issue.
>
> Signed-off-by: Adrian Ban <devel@easynet.dev>
> ---
>   arch/arm/dts/mt7988.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
> index 2d57c6f5709..e907cf89396 100644
> --- a/arch/arm/dts/mt7988.dtsi
> +++ b/arch/arm/dts/mt7988.dtsi
> @@ -51,6 +51,11 @@
>   		};
>   	};
>   
> +	psci {
> +		compatible  = "arm,psci-0.2";
> +		method      = "smc";
> +	};
> +
>   	system_clk: dummy40m {
>   		compatible = "fixed-clock";
>   		clock-frequency = <40000000>;


