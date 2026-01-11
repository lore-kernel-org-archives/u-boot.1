Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10568D2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F2C383A41;
	Sun, 11 Jan 2026 17:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxfSO8ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0CE83A79; Sun, 11 Jan 2026 17:36:46 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB67083A3D
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b871619e7e0so6144366b.1
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149404; x=1768754204; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bSkPodM2S0KR1ix5j+VUINS0KSeR0oc4GUiSN34UEt0=;
 b=fxfSO8ETm8O/YxKGkVVbCDera5bL4OgL7uaTg+MTpf99WGFnJHBWWOa4Xw9ZmzDA0n
 7x8xN4ZY7Vnb9C08ZsizJ/IZblCVpkLz9QqoALaUP5iOOsHaHQVqJnUtkn4qzUwAY+E0
 brQ8i4ikerendkFdSGa/bpKv411+9cdGV7gI1bo6oiiGajPpyoLf6cJfUqvsecCSB9Sv
 2FxAAtQY11JW9za9iiYc/wZlbuHa36MTNGOfhiamHexkVTrMsIP8KiZ3qyCvngEIxWJR
 tO0FZBL7Mb8lGWXNlPH51dhqGLP7fsiYIu4BhfEr0jsFZl6Ro4v8GShROwtc2ZbKgiVV
 BeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149404; x=1768754204;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSkPodM2S0KR1ix5j+VUINS0KSeR0oc4GUiSN34UEt0=;
 b=Au9TvbhSGIvxa3DBcQfxj2IqQn1z/QAxHTVTrIaiJrcVcR7SxSIANJHLjhqOXS7L6z
 rqzVxAYSBAJkJND5z0spC6+A6cT+sWI2vhzapGhNLjl00KVQ9fkt+qj9yJEtnciJJ68T
 7QsCd8XB8dogXbLnsm26N2ClylLandU17QashaZGZSbJLl2kRbSCKvUTORF88gXthGyF
 k2kqvbiNNbn5F56ohoxuMkil1E4dXFpTCApXMz56xeVelvUXug0V0xTbMXhwqMk2Bgvg
 licpky1yyow8TFr47oaY+6nfw6pG6hNJTilE2gQt1Y/jSboSnhT7t0z7rlwcHd67yJoi
 Hieg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOfBdB42OtMWXRMshHJW3sLvZ9menid8FHyCnzQh40ylu5xpZe1iFnuzuLeGGkMMVFwbKbn8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/lY0cVnxEh+MvzI3+wisTHJ5CHrCyTuS+nVQgiYdZ7Z85rgXm
 N2PobJf5mmWqvp4oCowdYn8qX4UUpK3SdoJF06d4NImmwLDF/F4ZvPfD
X-Gm-Gg: AY/fxX7zBy2MgXLyagOhoMn3iMtbyFxGVA0Izo+yOIcA9+mnPfrzxqGKArPENb9yzyr
 8uat21+cOJUwAxpQXZb6VQsY//LxDKOb8i1WCXHp+NI5Jmyuu/WyYVUWco5X/o0vahjCr1H/Txf
 /7JD0NnTnEl5aprnhcXgxfi+i26u7ETXQV69cYLvLpkqkyocwyu+GiYKxM5Gf3Fd0GAjW6Bdhu+
 FBVQR5H9GjRRtz23j/xbTV8m8QF7B38I0xs1n030CLQ1eHy8A8wnGIAWGH/ApTdW4Ib1abdoVgR
 nB4cBmk4pV8xMUR2+xdSdva8mRAwc3uNoDAABRavGJNagK/BNQNRjkkGKd7p/NIhtQ4rIV+X9GJ
 CLmuwHdhs51HO97FSR0CDtvIr3pe+zbZVSun2HR0v/p9YjsHUiQtYAA9hPZb2+JbMOJIUBF92K2
 AsWA04kMH/wn8DcmcKOKWhjF+Znrh2D88gCXaF1mMtJ2rltxAWng==
X-Google-Smtp-Source: AGHT+IHNQ5A2fV8GK0IVz7zy9ICF7FszKSwRz+pFyauxa+cl+AqquDu0jwM10cCQ5RVmMbUNakgpQw==
X-Received: by 2002:a17:907:728c:b0:b76:6025:4332 with SMTP id
 a640c23a62f3a-b8445377d61mr838916466b.8.1768149403902; 
 Sun, 11 Jan 2026 08:36:43 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe6bsm1672322466b.34.2026.01.11.08.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:36:43 -0800 (PST)
Message-ID: <158c249e-b1e1-4ce6-b818-bd0bea3e902d@gmail.com>
Date: Sun, 11 Jan 2026 17:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ARM: dts: rockchip: Remove mshc aliases from RK3288
From: Johan Jonker <jbx6244@gmail.com>
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <> <663b01e8-112d-49ae-ac60-2db75dd0ea7f@gmail.com>
Content-Language: en-US
In-Reply-To: <663b01e8-112d-49ae-ac60-2db75dd0ea7f@gmail.com>
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



On 1/11/26 17:32, Johan Jonker wrote:
> The use of mshc aliases is deprecated for some while,
> so remove them from the rk3288.dtsi file.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Link: https://patch.msgid.link/3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: cafaf99e4a790f8492a034a3470f878779c8c535 ]
> 
> (cherry picked from commit faefae4ca217961a0d96a54c9618e56aa8fd37b3)
> ---

Please trash

>  dts/upstream/src/arm/rockchip/rk3288.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
> index 42d705b544ec..7e284b4fecdc 100644
> --- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
> +++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
> @@ -34,10 +34,6 @@
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
>  		i2c5 = &i2c5;
> -		mshc0 = &emmc;
> -		mshc1 = &sdmmc;
> -		mshc2 = &sdio0;
> -		mshc3 = &sdio1;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> --
> 2.39.5
> 

