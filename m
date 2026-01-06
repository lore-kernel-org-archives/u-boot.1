Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B54C47BFB
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B962583F86;
	Tue,  6 Jan 2026 15:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zCwxGE5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A62783F8F; Tue,  6 Jan 2026 15:09:15 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0794F83F6A
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so9272725e9.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767708542; x=1768313342; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+B5JP6yYmyr3HzBmVOdTnJj8Bnd+wmwrTQymo+IZy40=;
 b=zCwxGE5U2SapqZBY16y4CSVBsqSewO1dCf8BZ5S24Ter+ucOnXOCn1c5f0/KEhiAtu
 fmbjhLtMwrWhrPYpTfC0K7XHqJWalGcWXQ+5/EjWDzS304ul/e78PUSIsL/r6GpvDF/T
 yC4j9g7DC1YR90P1U+jUFmdRx6Sl9qrZd/k2EG5qS/wBZ4aboCe8EuEUfchjT8vKBTRE
 pOEJynCKGnrKvF1MKXN80vLGceZfsK8njG3HGYLVq99rIU0y9BHaVHP8jIV7A53SwOq8
 vffRaYaiWmspojNmAns4/K5hfbTMefL+J7xN1BgPARPAUdEEyuBLcQmBNj316kCk9bNF
 Pl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767708542; x=1768313342;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+B5JP6yYmyr3HzBmVOdTnJj8Bnd+wmwrTQymo+IZy40=;
 b=awqrQ7SGMd1DBtBSCkaM7SNhulBetgaX3Zd1LbcemDMJBC4+An9RzXdkeFQTBXkAIa
 C6inhdnBhKK73nB4wCnEyZty4/M74UsWEKuMNkgJc9Dl0RIE7YWP4eakDzgLpfUPJPnm
 +cJ/m/fFqKj4HjKbtUchFXL36e7DR1TbSB7OoESH3j9TtFecmL4RiW2gyocib+u7H9Yw
 zKKGoaMxBOL6STnIl2kmEEHh9JAI/ZFsmbaxXYzZUU3O/LWgBophTxjPwztQJrHiI48V
 4ETFl0eFID54k3Pj8kbFFLwFkjPVlbNFaiKiQo3y02l79F0O7B/XxaR02f2X9U7IilX0
 5ifA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWMwR8bOYt/Pg+tdjwvk7JSL0DfRZLiBoIXXW/fVof72rdGq63AsTeUwzfrekgHSDD2HEQ7b0=@lists.denx.de
X-Gm-Message-State: AOJu0YyUYopKYzSuzcGDRY28aoUEazqIoeqqicW5AcWpHsa+wouVZcb+
 1swAeLvY2MS9SyeyqafYse5eAAoTuSlOK6Mme12oHfQyoUJhWbjU/Ufes+syz9nO7J8=
X-Gm-Gg: AY/fxX6AtY92wKUJSv4pvlxobcXA6Op4gC48D8AiJbWSydnetTgu7M1w5Z40nJT21BJ
 P3BK1eanRfh+P2KMRpKJHjLNJorX4REz3TnAhri+Z3Jj0lPfeFuYHvx/Y+c7mLgPVVWCOMMK8fR
 sboBBy+Sa8Z1bI4+6Pua9VxLZrgPEKNetEvQWqqo36hopNW/13K3bdjoAzsfsCu1jAuJk9mhiis
 EvMTOkPkPEifJN5/HGG+NJBIacaWimA5xXPHd/HcKDSbisOsAbHPZYLNvwBSSwoIhFOf+Qa9qSg
 gjiwTT1/388F3rg4dETgopud3y2ikRprH9yaBR03sK6mYBUc7BgR/Md6i0+C0ttUxiVeYtZVw3a
 DkMpxDl1s5O8MY+8uIfEn8bjyJD1Dltwe3jaJSHM4g+SKGgoxL1TFiGDE0sS1ggx4CoKNlZ88Hl
 TOuAiAOZQdzh2qQGSZ4ewc9GrhRzWcvePMC4nUHDFLy97M96yoBXdmyfe+aUafCNk=
X-Google-Smtp-Source: AGHT+IEYxmZBrSjRh6AL/s+/plEjyrW4rclS1Mgo6xGW92skxQPpFHbrsriTbJt6pDGq9LqBIj9TQw==
X-Received: by 2002:a05:600c:548b:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-47d7f098a69mr34247535e9.24.1767708541532; 
 Tue, 06 Jan 2026 06:09:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f703a8csm44548025e9.13.2026.01.06.06.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 06:09:01 -0800 (PST)
Message-ID: <67576082-d8b0-419e-8365-0f6294fe0ffc@linaro.org>
Date: Tue, 6 Jan 2026 15:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/5] ufs: rockchip: Enable SDRAM-only DMA quirk
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <me@ziyao.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Huan Zhou <me@per1cycle.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Joseph Chen <chenjh@rock-chips.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
 <20260106-rk3576-ufs-v3-3-bfe259fd6d17@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260106-rk3576-ufs-v3-3-bfe259fd6d17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 06 Jan 2026 15:10:54 +0100
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/6/26 14:57, Alexey Charkov wrote:
> Rockchip RK3576 can boot fully from UFS, but as part of the boot
> process the SPL needs to place part of the ATF code into PMU SRAM,
> which is outside the SDRAM range that the UFSHC can access.
> 
> Enable a quirk to force bounce operation for this case.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   drivers/ufs/Kconfig        | 1 +
>   drivers/ufs/ufs-rockchip.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 6c75bb2a0790..2543b5d47c04 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
>   config UFS_ROCKCHIP
>   	bool "Rockchip specific hooks to UFS controller platform driver"
>   	depends on UFS
> +	select BOUNCE_BUFFER
>   	help
>   	  This selects the Rockchip specific additions to UFSHCD platform driver.
>   
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387da..699460fc4d15 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -153,6 +153,7 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
>   		return err;
>   	}
>   
> +	hba->quirks |= UFSHCD_QUIRK_DMA_SDRAM_ONLY;

So you really want to enable this quirk for non-SPL builds aswell ?

Neil

>   	host->hba = hba;
>   
>   	return 0;
> 

