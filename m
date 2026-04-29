Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D49FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AFF846E2;
	Wed, 29 Apr 2026 08:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IXGb7FcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3ADC846E7; Wed, 29 Apr 2026 08:08:28 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D73AE83FB5
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 620BF114E88; Wed, 29 Apr 2026 08:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777442905;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Pb/8Xj8Z0n+dgCfgQhz9gRgK0hJZcj2p/+EuR1QwQZA=;
 b=IXGb7FcRnmFndqmuGdFTXBCDf7L0Qi3VBJ2Cz9BZXJPP/61z/5hlYOfqF7ovJL2cSZHJkf
 yi5Co4nkvfYUgugJ4ZmuD0C1VG4x3ovjKgGg/L2Bry8NHOrRYGggl6CTvM6JhvCw3q9+xc
 eEW8KfqS7SdAtQC+E73xuLX4AD8GW0Fl9HDCiEdc4pF0Wxzqc3t3QMWFchPTSdzjbRAxDn
 EP+tki07S9x04o0/HOwRfHEJ38b4PrS2kwWaFFMXL+Y69q0wnc7BinK/JoCXl3sqKNyIbs
 DaMNf2UqF8uxXl/Ru2l/otXADWOLTQn7Fu+8wBClxZ3/zaDB0pXn8CYYNvev+w==
Message-ID: <26477419-5e85-c1da-738b-80dee4dbd73e@nabladev.com>
Date: Wed, 29 Apr 2026 08:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] arm: dts: a10: Correct i2c scl falling time
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Wojciech Szamocki
 <wojciech.szamocki@nokia.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
 <11ad4489fcd6747099ee82feac2e4613df26192c.1777439293.git.dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <11ad4489fcd6747099ee82feac2e4613df26192c.1777439293.git.dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Dinesh,

On 29.04.26 07:11, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> The value set for i2c-scl-falling-time-ns in Linux DTS is not
> compatible for the i2c driver in U-Boot. The value is updated
> to the max value specified in the HW spec.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
> 
> diff --git a/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi
> index 56d50ecee30..4857939ce1a 100644
> --- a/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_arria10_socdk-u-boot.dtsi
> @@ -12,6 +12,11 @@
>   	};
>   };
>   
> +&i2c1 {
> +	/* Max value set according to HW spec */
> +	i2c-scl-falling-time-ns = <300>;
> +};
> +
>   &uart1 {
>   	bootph-all;
>   };
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
