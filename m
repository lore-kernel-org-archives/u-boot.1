Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBC3C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88E77812BF;
	Tue, 28 Jul 2026 09:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c_Z-P0sqBgBI; Tue, 28 Jul 2026 09:46:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A45AA8127D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785231992;
	bh=WKwZwc6exR27uBSvNBeDETqeaZC/fhWP+FumiMXhBwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SXdRZ/SrHWHBFkZxI9dXK4bzYurQifAweN/3rim4Kg2UvS5oTQPgQwnmi7O2jpq7e
	 MNGUczAwxbcK/69yzfO7ftMFNsEUHcFo4aox/jYQk5Hcp40p4fttm4s8xTrjqzxyNu
	 RMrke6ocoiZy52BH8/ad339b8czarbPmK28lV9UO0pz9VqkgeuHBUjgBcR2HHHHN2j
	 mtFaxkfBc7VU7y9zxrqpteEbkBG6ACORLpcgUbSRrg9sL5xGPr4LTnxXBYwdw+ee8C
	 1t4Fx0zY4+rQi7gauMdmvuUGx4aIoBk32sTMxBlM7kSgpZiSoE2OxKS6v3bZmPw3Ap
	 Pv6ej4zhyw11w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A45AA8127D;
	Tue, 28 Jul 2026 09:46:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 434BF45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4104D401FC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JarXy3r26InK for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:46:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4D792400EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D792400EF
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D792400EF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:46:30 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69f7af97316so5835783a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 02:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231988; x=1785836788;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WKwZwc6exR27uBSvNBeDETqeaZC/fhWP+FumiMXhBwY=;
 b=Ep9HUhohkmObsURWIvXdlhGNF4BoM5osEElpccd1UF15BbyXPWwCkZjyHDPBsFXyjF
 /dSws0nN+5wbaC9KUUV99VbvqHqU4z6OOp2IxrXY8Styvv6vecHBXywSU9Y3QD6SiL5o
 8Btp/4Hadu1zaXsJ7mNuSmENvZedWecbNIosVcktMFY9UvTFzIPjUXJ68Yc0WEcNy0QZ
 ve1fVx5jSJSg/YO8UKNuQYLvPA4uxOPdJXWt1oE7msvEa2Y1yBQxWOicAbKvbG4g4L3S
 cBIXDXbdxMvxB/SqCSatlXkIC2yeXGgtAyoAmDTaTQCkhac1PXN92/68Iq+pUiP8ICV3
 9CYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrnp7+lT820fG33uNfTOGFZuq5mdObC0533w8f68hEZF+INKpqVk+3zj3QJLoStREaKDG5lqcU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyGb8+DC5jE3iCq6SHm6jLCbw+cv4jbiRa2Syb+tVtQV3A3Oic9
 B7pG4VxximyrmM4zjBxLktm2eZnVTUD49wekGYG8PZb8U9BADGlijbtB
X-Gm-Gg: AR+sD12H3eiwSlMtwB5f80jdW6TiK6BuSzZ10wHKUVrW4XCcP1wpYH+4UUp0piYMJIs
 8IwuisRzHY1GHTak6HM6s6zm4/UQqWA8rV3+8lTn8F18QR/+1j1o5s/g9OaerBJ2lGkPzc/BaIW
 q9xtCkhNwzSne3g4dlTgJlkp0wFR/1ykZdXXj0AzkNKv6U5V/gWESH68QhXu4EBvt8e5aO+A2UV
 Mm7c207IkjQ2cYJRo+yao3Jcrv22kJ9CB53W9Al/wuiUxhdWdt36/lN+F81Y/DVpk5vWuZnO/BM
 usTJDmk1yl89fssnuETAGwrkjrW4IqttQLQDRgbENsDF98agSTs+44tQ/DU1UU53+ZnilSa3QVd
 2qBufD+pFeCfSnnXsnwtnm10flnNHMAbTKX2Mc18OS7+dESVKbKz5nZMicVLc/gEbHkr4T+5oPo
 w2zuFCIEuxu3+5W99IWYrbvUPxzdFXUW14Jth4cNuaaBCxBM8K+SOjBDYgMJ8JUjVOTZWs+QI=
X-Received: by 2002:a05:6402:1f02:b0:69a:2ee6:4c95 with SMTP id
 4fb4d7f45d1cf-6a034925818mr731103a12.0.1785231987820; 
 Tue, 28 Jul 2026 02:46:27 -0700 (PDT)
Received: from [10.0.1.42]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb594622asm3952846a12.26.2026.07.28.02.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 02:46:27 -0700 (PDT)
Message-ID: <ee20cf64-0541-4d63-b00e-6c9ac5e2382b@gmail.com>
Date: Tue, 28 Jul 2026 11:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
 <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
 <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
 <a164c15a-9331-4361-8a50-692e9855512a@gmail.com>
 <af758a22-b8c0-470a-90b8-a3ea92db1783@mailbox.org>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <af758a22-b8c0-470a-90b8-a3ea92db1783@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785231988; x=1785836788;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WKwZwc6exR27uBSvNBeDETqeaZC/fhWP+FumiMXhBwY=;
 b=sm0LzdZMlFIVlLPrHpGQzWOymNeV6cMAJH7gSHLvdJzE7y2wR0IYCsc65gx1bv3LhQ
 jtZwZ6VigeFsKGEBOJTzUGBXXNzU8uOT/010CKIU9291yhtEExOMS/vciHGbwT/w1CGE
 ihAfHjtvTGUOnT7xFZmtxeilG6GhvF6vtxBQ/zRxQfanPlrtgnT7XVpvL31wzP7a0xM9
 BCWufLcqcC3fjuhEjk0lIUyCN9fj5JNoP7JgaJb/JM3rX8LL2yvFnEDKYchdOXKPdMPR
 je0fhYh7GgdDz2qLNzNiBpLKqRMgv++gs7wthgwCCq7A6l/+3/JnORmpmVUHKVJx9zwe
 Onag==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sm0LzdZM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/26/26 08:41, Marek Vasut wrote:
> On 7/24/26 9:36 AM, Emanuele Ghidoli wrote:
> 
> Hello everyone,
> 
>>> Regarding the timer, how come the timer is initialized so late on MX7 ?
>> timer_init() called in initcall_run_f().>
>>> The Cortex-A7 should have its own ARM timer, that should be available right
>>> from the beginning. Is that ARM timer in use on your system, or does your
>>> system use GPT timer ?
>> iMX7 uses arch/arm/mach-imx/syscounter.c.
>>
>> udelay() is called in initcall_run_f(), before timer_init().
>> arch_cpu_init() (arch/arm/mach-imx/mx7/soc.c) -> imx_gpcv2_init -> udelay
>> (which runs schedule/cyclic).
> 
> Yikes.
> 
>> And this is interesting, udelay() before timer_init() leads to a 0 us delay,
>> so there is another bug.
>>
>> I have verified that removing this udelay(65) the board boots.
> Can we start the syscounter sooner ? Something like this:
> 
> diff --git a/arch/arm/include/asm/arch-mx6/sys_proto.h b/arch/arm/include/asm/
> arch-mx6/sys_proto.h
> index 7845fa8e569..5f6759a3306 100644
> --- a/arch/arm/include/asm/arch-mx6/sys_proto.h
> +++ b/arch/arm/include/asm/arch-mx6/sys_proto.h
> @@ -36,4 +36,6 @@ static inline void iomuxc_set_rgmii_io_voltage(int io_vol)
>      __raw_writel(io_vol, IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII);
>  }
> 
> +void syscounter_init(void);
> +
>  #endif /* __SYS_PROTO_IMX6_ */
> diff --git a/arch/arm/include/asm/arch-mx7/sys_proto.h b/arch/arm/include/asm/
> arch-mx7/sys_proto.h
> index 5da0037b2c6..765764cf1bc 100644
> --- a/arch/arm/include/asm/arch-mx7/sys_proto.h
> +++ b/arch/arm/include/asm/arch-mx7/sys_proto.h
> @@ -11,4 +11,6 @@ struct wdog_regs;
> 
>  void set_wdog_reset(struct wdog_regs *wdog);
> 
> +void syscounter_init(void);
> +
>  #endif /* __SYS_PROTO_IMX7_ */
> diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
> index 02df86156d4..641b5d813ea 100644
> --- a/arch/arm/mach-imx/mx6/soc.c
> +++ b/arch/arm/mach-imx/mx6/soc.c
> @@ -437,6 +437,8 @@ int arch_cpu_init(void)
>           */
>          if (mxc_get_clock(MXC_ARM_CLK) == 396000000)
>              set_ahb_rate(132000000);
> +    } else {
> +        syscounter_init();
>      }
> 
>      if (is_mx6ul()) {
> diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
> index e504c1fd52a..82d851b7817 100644
> --- a/arch/arm/mach-imx/mx7/soc.c
> +++ b/arch/arm/mach-imx/mx7/soc.c
> @@ -331,6 +331,8 @@ int arch_cpu_init(void)
> 
>      init_snvs();
> 
> +    syscounter_init();
> +
>      imx_gpcv2_init();
> 
>      enable_ca7_smp();
> diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-imx/syscounter.c
> index 96fe2c7c17b..7b902540737 100644
> --- a/arch/arm/mach-imx/syscounter.c
> +++ b/arch/arm/mach-imx/syscounter.c
> @@ -60,7 +60,7 @@ static inline unsigned long long us_to_tick(unsigned long
> long usec)
>  }
> 
>  #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) || IS_ENABLED(CONFIG_XPL_BUILD)
> -int timer_init(void)
> +void syscounter_init(void)
>  {
>      struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
>      unsigned long val, freq;
> @@ -80,6 +80,12 @@ int timer_init(void)
>      gd->arch.tbu = 0;
> 
>      gd->arch.timer_rate_hz = freq;
> +
> +    return 0;
> +}
> +
> +int timer_init(void)
> +{
>      return 0;
>  }
>  #endif

Hello Marek,
thanks for the suggestion.

It works, build and tested on Colibri iMX7.

But imx6 is obviously broken:
/home/emanuele/tdx/u-boot-build/u-boot/arch/arm/mach-imx/mx6/soc.c:441:
undefined reference to `syscounter_init'

Emanuele

