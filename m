Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0817FC79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0B583DEB;
	Mon,  5 Jan 2026 16:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sfUjJrzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CEC83E16; Mon,  5 Jan 2026 16:19:31 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E2983D6C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso170665e9.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626368; x=1768231168; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TISMVu2W9JRaneanGWUHHhHryZBxcj2vFAnM+RiZ2N4=;
 b=sfUjJrzKHznri80BvSkSHAE+XMOhrk2on6jPD6JcYmmVo2nF2y5/wIkUtrhuCHNe0g
 0ks8VQ/lso9VaIjXPRenl8nZ8tz96adhJra/SQXQLh/nv+669ykmtp8/uuXhUOHrqJ7y
 teRQHMWe5sBiDMrqthgvSVVqfKupq7BE49a9mShXHlMaOvT+/aT6veT+wOSy7Iijq0OM
 jSGJMxDlZBIDyDTo6mZ6aCkV6ZQLQ85e05moNi5YEy6d68FlYnpv7pyRfKs3V4YIonL/
 Pd7PXYSkSqS6ME+eFzvABCWVsivYn7FaIzePfwi4Qc6LYRF+u3Pl0Gv6WTIbsP4vq+3a
 zR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626368; x=1768231168;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TISMVu2W9JRaneanGWUHHhHryZBxcj2vFAnM+RiZ2N4=;
 b=O11asjf8KpyljAUPaB7TUBO9sjUnSVn/DsBQ7Bo3EgGc1PyXzupeDIn0z7ZaJ9ZMY8
 9ImkqLNttPzkYYnwRVVO0IhLFF5exxYa1VdUIoOlW6PHwgAOIWtDppcarnVCy7or1bu7
 MCLtmh4rDBrkf2IxZS/pbtFecrp1+dwNplysUdLhpbFy+XedqkAE2KW5Gw/AudznmDO7
 4ko26qBGhb6WY34JgYOX9FI3cNimkTj1sACn2rQcMrA0PpS+bwTZ1t862p/EN94OJzMR
 ClM2iQR/3rKGr17zt1d5Tcvmycs1565G+P8rRqZ1QZLw1tprIe9m2eAL8GHdSu9Sz2C+
 xDDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxy+7sW7ohqRuSxNn4ugi+7e4mai/sAROPw8zBrg8Caq9MzJYCjdlSVOsINXLE1nbow4nCkXo=@lists.denx.de
X-Gm-Message-State: AOJu0YzcwhEBe/flh6U86fRdgMC4OyNqFbr2m5JqSm0dLA+JIqe/Gg7P
 GPrsilKbwepjMyPVuCZjsUsy4rvCIsvCMVGODV7EuSUIaj0iYv5rDqLlfYLWZFg2Lf4=
X-Gm-Gg: AY/fxX6hrfD09kr6Z1QITDMj22TqScQ8um60RDLy61GZewbsevBz1W8ta9Lm6FKU/pr
 f1H4sygVmU/CMYlXa0LMKix3Dt0cYCiRLudy04Lu+4uaxCuOus44nu63cxWRvSEAv7Kuh0V63+q
 YVkMTyo1uYk1pU5dXF7n6Vuo+qnTyX7Icfw10AjY8v2GIxW3yvEFqj65VGqZp1dbHBZZ/7NUX/q
 00tn9pk20V10C0cwRCHl4FEHCPzYnDQmk9j4e0kpFQNnxlejCy3XmQvdSTp64KcZB8oC19I6tNS
 KoS4q08RH00hokXzPaHrjA6BqkUSvHBaWCjO12VS656dHpRPRKoJC9GG+Jim3PbqAueDHdcG2aS
 Cgm+l9evPU7zS1gnG5/Lkh01MYqiCSoHen2jsZO/ThFhPxZYoo2lm5xFP5RMzxypPdtmjJtEv7l
 ZwN6uIcV2a7bZOlWimiZN4pACJr+4KkTgeUh6ByRVJXdg4VOeYKEyfMxtBusi9U/M=
X-Google-Smtp-Source: AGHT+IFxCGIGfAJ9X1RnaRYoNi5T5EGdCh8VRbjXeiBkmNByWwTAmRj2EaOJSRs+Nnx67BSq6yrD5g==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr486259285e9.32.1767626367719; 
 Mon, 05 Jan 2026 07:19:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d1490efsm159900955e9.7.2026.01.05.07.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:19:27 -0800 (PST)
Message-ID: <648b415b-ca2c-4bd9-b216-731776102f7b@linaro.org>
Date: Mon, 5 Jan 2026 16:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/5] scsi: ufs: renesas: Replace init data by init code
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/3/26 01:22, Marek Vasut wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Since initialization of the UFS controller on R-Car S4-8 ES1.0 requires
> only static values, the driver uses initialization data stored in the const
> ufs_param[] array.  However, other UFS controller variants (R-Car S4-8
> ES1.2) require dynamic values, like those obtained from E-FUSE.  Refactor
> the initialization code to prepare for this.
> 
> This also reduces kernel size by almost 30 KiB.
> 
> Ported from Linux kernel commit
> c4e83573c3d0 ("scsi: ufs: renesas: Replace init data by init code")
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/3520e27ac7ff512de6508f630eee3c1689a7c73d.1741179611.git.geert+renesas@glider.be
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/ufs-renesas.c | 511 +++++++++++++++++++++-----------------
>   1 file changed, 286 insertions(+), 225 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index 0b74b39dc2a..b89205d0f11 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -39,98 +39,6 @@ enum ufs_renesas_init_param_mode {
>   	MODE_WRITE,
>   };
>   
> -#define PARAM_RESTORE(_reg, _index) \
> -		{ .mode = MODE_RESTORE, .reg = _reg, .index = _index }
> -#define PARAM_SET(_index, _set) \
> -		{ .mode = MODE_SET, .index = _index, .u.set = _set }
> -#define PARAM_SAVE(_reg, _mask, _index) \
> -		{ .mode = MODE_SAVE, .reg = _reg, .mask = (u32)(_mask), \
> -		  .index = _index }
> -#define PARAM_POLL(_reg, _expected, _mask) \
> -		{ .mode = MODE_POLL, .reg = _reg, .u.expected = _expected, \
> -		  .mask = (u32)(_mask) }
> -#define PARAM_WAIT(_delay_us) \
> -		{ .mode = MODE_WAIT, .u.delay_us = _delay_us }
> -
> -#define PARAM_WRITE(_reg, _val) \
> -		{ .mode = MODE_WRITE, .reg = _reg, .u.val = _val }
> -
> -#define PARAM_WRITE_D0_D4(_d0, _d4) \
> -		PARAM_WRITE(0xd0, _d0),	PARAM_WRITE(0xd4, _d4)
> -
> -#define PARAM_WRITE_800_80C_POLL(_addr, _data_800)		\
> -		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
> -		PARAM_WRITE_D0_D4(0x00000800, ((_data_800) << 16) | BIT(8) | (_addr)), \
> -		PARAM_WRITE(0xd0, 0x0000080c),			\
> -		PARAM_POLL(0xd4, BIT(8), BIT(8))
> -
> -#define PARAM_RESTORE_800_80C_POLL(_index)			\
> -		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
> -		PARAM_WRITE(0xd0, 0x00000800),			\
> -		PARAM_RESTORE(0xd4, (_index)),			\
> -		PARAM_WRITE(0xd0, 0x0000080c),			\
> -		PARAM_POLL(0xd4, BIT(8), BIT(8))
> -
> -#define PARAM_WRITE_804_80C_POLL(_addr, _data_804)		\
> -		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
> -		PARAM_WRITE_D0_D4(0x00000804, ((_data_804) << 16) | BIT(8) | (_addr)), \
> -		PARAM_WRITE(0xd0, 0x0000080c),			\
> -		PARAM_POLL(0xd4, BIT(8), BIT(8))
> -
> -#define PARAM_WRITE_828_82C_POLL(_data_828)			\
> -		PARAM_WRITE_D0_D4(0x0000082c, 0x0f000000),	\
> -		PARAM_WRITE_D0_D4(0x00000828, _data_828),	\
> -		PARAM_WRITE(0xd0, 0x0000082c),			\
> -		PARAM_POLL(0xd4, _data_828, _data_828)
> -
> -#define PARAM_WRITE_PHY(_addr16, _data16)			\
> -		PARAM_WRITE(0xf0, 1),				\
> -		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x18, (_data16) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x19, ((_data16) >> 8) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
> -		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
> -		PARAM_WRITE(0xf0, 0)
> -
> -#define PARAM_SET_PHY(_addr16, _data16)				\
> -		PARAM_WRITE(0xf0, 1),				\
> -		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
> -		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
> -		PARAM_WRITE_804_80C_POLL(0x1a, 0),		\
> -		PARAM_WRITE(0xd0, 0x00000808),			\
> -		PARAM_SAVE(0xd4, 0xff, SET_PHY_INDEX_LO),	\
> -		PARAM_WRITE_804_80C_POLL(0x1b, 0),		\
> -		PARAM_WRITE(0xd0, 0x00000808),			\
> -		PARAM_SAVE(0xd4, 0xff, SET_PHY_INDEX_HI),	\
> -		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
> -		PARAM_WRITE(0xf0, 0),				\
> -		PARAM_WRITE(0xf0, 1),				\
> -		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
> -		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
> -		PARAM_SET(SET_PHY_INDEX_LO, (((_data16) & 0xff) << 16) | BIT(8) | 0x18), \
> -		PARAM_RESTORE_800_80C_POLL(SET_PHY_INDEX_LO),	\
> -		PARAM_SET(SET_PHY_INDEX_HI, ((((_data16) >> 8) & 0xff) << 16) | BIT(8) | 0x19), \
> -		PARAM_RESTORE_800_80C_POLL(SET_PHY_INDEX_HI),	\
> -		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
> -		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
> -		PARAM_WRITE(0xf0, 0)
> -
> -#define PARAM_INDIRECT_WRITE(_gpio, _addr, _data_800)		\
> -		PARAM_WRITE(0xf0, _gpio),			\
> -		PARAM_WRITE_800_80C_POLL((_addr), _data_800),	\
> -		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
> -		PARAM_WRITE(0xf0, 0)
> -
> -#define PARAM_INDIRECT_POLL(_gpio, _addr, _expected, _mask)	\
> -		PARAM_WRITE(0xf0, _gpio),			\
> -		PARAM_WRITE_800_80C_POLL((_addr), 0),		\
> -		PARAM_WRITE(0xd0, 0x00000808),			\
> -		PARAM_POLL(0xd4, (_expected), (_mask)),		\
> -		PARAM_WRITE(0xf0, 0)
> -
>   struct ufs_renesas_init_param {
>   	enum ufs_renesas_init_param_mode mode;
>   	u32 reg;
> @@ -144,135 +52,6 @@ struct ufs_renesas_init_param {
>   	u32 index;
>   };
>   
> -/* This setting is for SERIES B */
> -static const struct ufs_renesas_init_param ufs_param[] = {
> -	PARAM_WRITE(0xc0, 0x49425308),
> -	PARAM_WRITE_D0_D4(0x00000104, 0x00000002),
> -	PARAM_WAIT(1),
> -	PARAM_WRITE_D0_D4(0x00000828, 0x00000200),
> -	PARAM_WAIT(1),
> -	PARAM_WRITE_D0_D4(0x00000828, 0x00000000),
> -	PARAM_WRITE_D0_D4(0x00000104, 0x00000001),
> -	PARAM_WRITE_D0_D4(0x00000940, 0x00000001),
> -	PARAM_WAIT(1),
> -	PARAM_WRITE_D0_D4(0x00000940, 0x00000000),
> -
> -	PARAM_WRITE(0xc0, 0x49425308),
> -	PARAM_WRITE(0xc0, 0x41584901),
> -
> -	PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),
> -	PARAM_WRITE_D0_D4(0x00000804, 0x00000000),
> -	PARAM_WRITE(0xd0, 0x0000080c),
> -	PARAM_POLL(0xd4, BIT(8), BIT(8)),
> -
> -	PARAM_WRITE(REG_CONTROLLER_ENABLE, 0x00000001),
> -
> -	PARAM_WRITE(0xd0, 0x00000804),
> -	PARAM_POLL(0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0)),
> -
> -	PARAM_WRITE(0xd0, 0x00000d00),
> -	PARAM_SAVE(0xd4, 0x0000ffff, TIMER_INDEX),
> -	PARAM_WRITE(0xd4, 0x00000000),
> -	PARAM_WRITE_D0_D4(0x0000082c, 0x0f000000),
> -	PARAM_WRITE_D0_D4(0x00000828, 0x08000000),
> -	PARAM_WRITE(0xd0, 0x0000082c),
> -	PARAM_POLL(0xd4, BIT(27), BIT(27)),
> -	PARAM_WRITE(0xd0, 0x00000d2c),
> -	PARAM_POLL(0xd4, BIT(0), BIT(0)),
> -
> -	/* phy setup */
> -	PARAM_INDIRECT_WRITE(1, 0x01, 0x001f),
> -	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0014),
> -	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0014),
> -	PARAM_INDIRECT_WRITE(7, 0x0d, 0x0003),
> -	PARAM_INDIRECT_WRITE(7, 0x0e, 0x0007),
> -	PARAM_INDIRECT_WRITE(7, 0x5f, 0x0003),
> -	PARAM_INDIRECT_WRITE(7, 0x60, 0x0003),
> -	PARAM_INDIRECT_WRITE(7, 0x5b, 0x00a6),
> -	PARAM_INDIRECT_WRITE(7, 0x5c, 0x0003),
> -
> -	PARAM_INDIRECT_POLL(7, 0x3c, 0, BIT(7)),
> -	PARAM_INDIRECT_POLL(7, 0x4c, 0, BIT(4)),
> -
> -	PARAM_INDIRECT_WRITE(1, 0x32, 0x0080),
> -	PARAM_INDIRECT_WRITE(1, 0x1f, 0x0001),
> -	PARAM_INDIRECT_WRITE(0, 0x2c, 0x0001),
> -	PARAM_INDIRECT_WRITE(0, 0x32, 0x0087),
> -
> -	PARAM_INDIRECT_WRITE(1, 0x4d, 0x0061),
> -	PARAM_INDIRECT_WRITE(4, 0x9b, 0x0009),
> -	PARAM_INDIRECT_WRITE(4, 0xa6, 0x0005),
> -	PARAM_INDIRECT_WRITE(4, 0xa5, 0x0058),
> -	PARAM_INDIRECT_WRITE(1, 0x39, 0x0027),
> -	PARAM_INDIRECT_WRITE(1, 0x47, 0x004c),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x0d, 0x0002),
> -	PARAM_INDIRECT_WRITE(7, 0x0e, 0x0007),
> -
> -	PARAM_WRITE_PHY(0x0028, 0x0061),
> -	PARAM_WRITE_PHY(0x4014, 0x0061),
> -	PARAM_SET_PHY(0x401c, BIT(2)),
> -	PARAM_WRITE_PHY(0x4000, 0x0000),
> -	PARAM_WRITE_PHY(0x4001, 0x0000),
> -
> -	PARAM_WRITE_PHY(0x10ae, 0x0001),
> -	PARAM_WRITE_PHY(0x10ad, 0x0000),
> -	PARAM_WRITE_PHY(0x10af, 0x0001),
> -	PARAM_WRITE_PHY(0x10b6, 0x0001),
> -	PARAM_WRITE_PHY(0x10ae, 0x0000),
> -
> -	PARAM_WRITE_PHY(0x10ae, 0x0001),
> -	PARAM_WRITE_PHY(0x10ad, 0x0000),
> -	PARAM_WRITE_PHY(0x10af, 0x0002),
> -	PARAM_WRITE_PHY(0x10b6, 0x0001),
> -	PARAM_WRITE_PHY(0x10ae, 0x0000),
> -
> -	PARAM_WRITE_PHY(0x10ae, 0x0001),
> -	PARAM_WRITE_PHY(0x10ad, 0x0080),
> -	PARAM_WRITE_PHY(0x10af, 0x0000),
> -	PARAM_WRITE_PHY(0x10b6, 0x0001),
> -	PARAM_WRITE_PHY(0x10ae, 0x0000),
> -
> -	PARAM_WRITE_PHY(0x10ae, 0x0001),
> -	PARAM_WRITE_PHY(0x10ad, 0x0080),
> -	PARAM_WRITE_PHY(0x10af, 0x001a),
> -	PARAM_WRITE_PHY(0x10b6, 0x0001),
> -	PARAM_WRITE_PHY(0x10ae, 0x0000),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x70, 0x0016),
> -	PARAM_INDIRECT_WRITE(7, 0x71, 0x0016),
> -	PARAM_INDIRECT_WRITE(7, 0x72, 0x0014),
> -	PARAM_INDIRECT_WRITE(7, 0x73, 0x0014),
> -	PARAM_INDIRECT_WRITE(7, 0x74, 0x0000),
> -	PARAM_INDIRECT_WRITE(7, 0x75, 0x0000),
> -	PARAM_INDIRECT_WRITE(7, 0x76, 0x0010),
> -	PARAM_INDIRECT_WRITE(7, 0x77, 0x0010),
> -	PARAM_INDIRECT_WRITE(7, 0x78, 0x00ff),
> -	PARAM_INDIRECT_WRITE(7, 0x79, 0x0000),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x19, 0x0007),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x1a, 0x0007),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x24, 0x000c),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x25, 0x000c),
> -
> -	PARAM_INDIRECT_WRITE(7, 0x62, 0x0000),
> -	PARAM_INDIRECT_WRITE(7, 0x63, 0x0000),
> -	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0014),
> -	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0017),
> -	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0004),
> -	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0017),
> -	PARAM_INDIRECT_POLL(7, 0x55, 0, BIT(6)),
> -	PARAM_INDIRECT_POLL(7, 0x41, 0, BIT(7)),
> -	/* end of phy setup */
> -
> -	PARAM_WRITE(0xf0, 0),
> -	PARAM_WRITE(0xd0, 0x00000d00),
> -	PARAM_RESTORE(0xd4, TIMER_INDEX),
> -};
> -
>   static void ufs_renesas_reg_control(struct ufs_hba *hba,
>   				    const struct ufs_renesas_init_param *p)
>   {
> @@ -314,13 +93,295 @@ static void ufs_renesas_reg_control(struct ufs_hba *hba,
>   	}
>   }
>   
> +static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mask)
> +{
> +	struct ufs_renesas_init_param param = {
> +		.mode = MODE_POLL,
> +		.reg = reg,
> +		.u.expected = expected,
> +		.mask = mask,
> +	};
> +
> +	ufs_renesas_reg_control(hba, &param);
> +}
> +
> +static void ufs_renesas_restore(struct ufs_hba *hba, u32 reg, u32 index)
> +{
> +	struct ufs_renesas_init_param param = {
> +		.mode = MODE_RESTORE,
> +		.reg = reg,
> +		.index = index,
> +	};
> +
> +	ufs_renesas_reg_control(hba, &param);
> +}
> +
> +static void ufs_renesas_save(struct ufs_hba *hba, u32 reg, u32 mask, u32 index)
> +{
> +	struct ufs_renesas_init_param param = {
> +		.mode = MODE_SAVE,
> +		.reg = reg,
> +		.mask = mask,
> +		.index = index,
> +	};
> +
> +	ufs_renesas_reg_control(hba, &param);
> +}
> +
> +static void ufs_renesas_set(struct ufs_hba *hba, u32 index, u32 set)
> +{
> +	struct ufs_renesas_init_param param = {
> +		.mode = MODE_SAVE,
> +		.index = index,
> +		.u.set = set,
> +	};
> +
> +	ufs_renesas_reg_control(hba, &param);
> +}
> +
> +static void ufs_renesas_wait(struct ufs_hba *hba, u32 delay_us)
> +{
> +	struct ufs_renesas_init_param param = {
> +		.mode = MODE_WAIT,
> +		.u.delay_us = delay_us,
> +	};
> +
> +	ufs_renesas_reg_control(hba, &param);
> +}
> +
> +static void ufs_renesas_write(struct ufs_hba *hba, u32 reg, u32 value)
> +{
> +	struct ufs_renesas_init_param param = {
> +		.mode = MODE_WRITE,
> +		.reg = reg,
> +		.u.val = value,
> +	};
> +
> +	ufs_renesas_reg_control(hba, &param);
> +}
> +
> +static void ufs_renesas_write_d0_d4(struct ufs_hba *hba, u32 data_d0, u32 data_d4)
> +{
> +	ufs_renesas_write(hba, 0xd0, data_d0);
> +	ufs_renesas_write(hba, 0xd4, data_d4);
> +}
> +
> +static void ufs_renesas_write_800_80c_poll(struct ufs_hba *hba, u32 addr,
> +					   u32 data_800)
> +{
> +	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
> +	ufs_renesas_write_d0_d4(hba, 0x00000800, (data_800 << 16) | BIT(8) | addr);
> +	ufs_renesas_write(hba, 0xd0, 0x0000080c);
> +	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
> +}
> +
> +static void ufs_renesas_restore_800_80c_poll(struct ufs_hba *hba, u32 index)
> +{
> +	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
> +	ufs_renesas_write(hba, 0xd0, 0x00000800);
> +	ufs_renesas_restore(hba, 0xd4, index);
> +	ufs_renesas_write(hba, 0xd0, 0x0000080c);
> +	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
> +}
> +
> +static void ufs_renesas_write_804_80c_poll(struct ufs_hba *hba, u32 addr, u32 data_804)
> +{
> +	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
> +	ufs_renesas_write_d0_d4(hba, 0x00000804, (data_804 << 16) | BIT(8) | addr);
> +	ufs_renesas_write(hba, 0xd0, 0x0000080c);
> +	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
> +}
> +
> +static void ufs_renesas_write_828_82c_poll(struct ufs_hba *hba, u32 data_828)
> +{
> +	ufs_renesas_write_d0_d4(hba, 0x0000082c, 0x0f000000);
> +	ufs_renesas_write_d0_d4(hba, 0x00000828, data_828);
> +	ufs_renesas_write(hba, 0xd0, 0x0000082c);
> +	ufs_renesas_poll(hba, 0xd4, data_828, data_828);
> +}
> +
> +static void ufs_renesas_write_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
> +{
> +	ufs_renesas_write(hba, 0xf0, 1);
> +	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x18, data16 & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x19, (data16 >> 8) & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
> +	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
> +	ufs_renesas_write(hba, 0xf0, 0);
> +}
> +
> +static void ufs_renesas_set_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
> +{
> +	ufs_renesas_write(hba, 0xf0, 1);
> +	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
> +	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
> +	ufs_renesas_write_804_80c_poll(hba, 0x1a, 0);
> +	ufs_renesas_write(hba, 0xd0, 0x00000808);
> +	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_LO);
> +	ufs_renesas_write_804_80c_poll(hba, 0x1b, 0);
> +	ufs_renesas_write(hba, 0xd0, 0x00000808);
> +	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_HI);
> +	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
> +	ufs_renesas_write(hba, 0xf0, 0);
> +	ufs_renesas_write(hba, 0xf0, 1);
> +	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
> +	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
> +	ufs_renesas_set(hba, SET_PHY_INDEX_LO, ((data16 & 0xff) << 16) | BIT(8) | 0x18);
> +	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_LO);
> +	ufs_renesas_set(hba, SET_PHY_INDEX_HI, (((data16 >> 8) & 0xff) << 16) | BIT(8) | 0x19);
> +	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_HI);
> +	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
> +	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
> +	ufs_renesas_write(hba, 0xf0, 0);
> +}
> +
> +static void ufs_renesas_indirect_write(struct ufs_hba *hba, u32 gpio, u32 addr,
> +				       u32 data_800)
> +{
> +	ufs_renesas_write(hba, 0xf0, gpio);
> +	ufs_renesas_write_800_80c_poll(hba, addr, data_800);
> +	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
> +	ufs_renesas_write(hba, 0xf0, 0);
> +}
> +
> +static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
> +				      u32 expected, u32 mask)
> +{
> +	ufs_renesas_write(hba, 0xf0, gpio);
> +	ufs_renesas_write_800_80c_poll(hba, addr, 0);
> +	ufs_renesas_write(hba, 0xd0, 0x00000808);
> +	ufs_renesas_poll(hba, 0xd4, expected, mask);
> +	ufs_renesas_write(hba, 0xf0, 0);
> +}
> +
>   static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   {
> -	const struct ufs_renesas_init_param *p = ufs_param;
> -	unsigned int i;
> +	/* This setting is for SERIES B */
> +	ufs_renesas_write(hba, 0xc0, 0x49425308);
> +	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
> +	ufs_renesas_wait(hba, 1);
> +	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000200);
> +	ufs_renesas_wait(hba, 1);
> +	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000000);
> +	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000001);
> +	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000001);
> +	ufs_renesas_wait(hba, 1);
> +	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000000);
> +
> +	ufs_renesas_write(hba, 0xc0, 0x49425308);
> +	ufs_renesas_write(hba, 0xc0, 0x41584901);
> +
> +	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
> +	ufs_renesas_write_d0_d4(hba, 0x00000804, 0x00000000);
> +	ufs_renesas_write(hba, 0xd0, 0x0000080c);
> +	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
> +
> +	ufs_renesas_write(hba, REG_CONTROLLER_ENABLE, 0x00000001);
> +
> +	ufs_renesas_write(hba, 0xd0, 0x00000804);
> +	ufs_renesas_poll(hba, 0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0));
> +
> +	ufs_renesas_write(hba, 0xd0, 0x00000d00);
> +	ufs_renesas_save(hba, 0xd4, 0x0000ffff, TIMER_INDEX);
> +	ufs_renesas_write(hba, 0xd4, 0x00000000);
> +	ufs_renesas_write_d0_d4(hba, 0x0000082c, 0x0f000000);
> +	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x08000000);
> +	ufs_renesas_write(hba, 0xd0, 0x0000082c);
> +	ufs_renesas_poll(hba, 0xd4, BIT(27), BIT(27));
> +	ufs_renesas_write(hba, 0xd0, 0x00000d2c);
> +	ufs_renesas_poll(hba, 0xd4, BIT(0), BIT(0));
> +
> +	/* phy setup */
> +	ufs_renesas_indirect_write(hba, 1, 0x01, 0x001f);
> +	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0014);
> +	ufs_renesas_indirect_write(hba, 7, 0x5e, 0x0014);
> +	ufs_renesas_indirect_write(hba, 7, 0x0d, 0x0003);
> +	ufs_renesas_indirect_write(hba, 7, 0x0e, 0x0007);
> +	ufs_renesas_indirect_write(hba, 7, 0x5f, 0x0003);
> +	ufs_renesas_indirect_write(hba, 7, 0x60, 0x0003);
> +	ufs_renesas_indirect_write(hba, 7, 0x5b, 0x00a6);
> +	ufs_renesas_indirect_write(hba, 7, 0x5c, 0x0003);
> +
> +	ufs_renesas_indirect_poll(hba, 7, 0x3c, 0, BIT(7));
> +	ufs_renesas_indirect_poll(hba, 7, 0x4c, 0, BIT(4));
> +
> +	ufs_renesas_indirect_write(hba, 1, 0x32, 0x0080);
> +	ufs_renesas_indirect_write(hba, 1, 0x1f, 0x0001);
> +	ufs_renesas_indirect_write(hba, 0, 0x2c, 0x0001);
> +	ufs_renesas_indirect_write(hba, 0, 0x32, 0x0087);
> +
> +	ufs_renesas_indirect_write(hba, 1, 0x4d, 0x0061);
> +	ufs_renesas_indirect_write(hba, 4, 0x9b, 0x0009);
> +	ufs_renesas_indirect_write(hba, 4, 0xa6, 0x0005);
> +	ufs_renesas_indirect_write(hba, 4, 0xa5, 0x0058);
> +	ufs_renesas_indirect_write(hba, 1, 0x39, 0x0027);
> +	ufs_renesas_indirect_write(hba, 1, 0x47, 0x004c);
> +
> +	ufs_renesas_indirect_write(hba, 7, 0x0d, 0x0002);
> +	ufs_renesas_indirect_write(hba, 7, 0x0e, 0x0007);
> +
> +	ufs_renesas_write_phy(hba, 0x0028, 0x0061);
> +	ufs_renesas_write_phy(hba, 0x4014, 0x0061);
> +	ufs_renesas_set_phy(hba, 0x401c, BIT(2));
> +	ufs_renesas_write_phy(hba, 0x4000, 0x0000);
> +	ufs_renesas_write_phy(hba, 0x4001, 0x0000);
> +
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
> +	ufs_renesas_write_phy(hba, 0x10af, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
> +	ufs_renesas_write_phy(hba, 0x10af, 0x0002);
> +	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
> +	ufs_renesas_write_phy(hba, 0x10af, 0x0000);
> +	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
> +	ufs_renesas_write_phy(hba, 0x10af, 0x001a);
> +	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +
> +	ufs_renesas_indirect_write(hba, 7, 0x70, 0x0016);
> +	ufs_renesas_indirect_write(hba, 7, 0x71, 0x0016);
> +	ufs_renesas_indirect_write(hba, 7, 0x72, 0x0014);
> +	ufs_renesas_indirect_write(hba, 7, 0x73, 0x0014);
> +	ufs_renesas_indirect_write(hba, 7, 0x74, 0x0000);
> +	ufs_renesas_indirect_write(hba, 7, 0x75, 0x0000);
> +	ufs_renesas_indirect_write(hba, 7, 0x76, 0x0010);
> +	ufs_renesas_indirect_write(hba, 7, 0x77, 0x0010);
> +	ufs_renesas_indirect_write(hba, 7, 0x78, 0x00ff);
> +	ufs_renesas_indirect_write(hba, 7, 0x79, 0x0000);
> +
> +	ufs_renesas_indirect_write(hba, 7, 0x19, 0x0007);
> +	ufs_renesas_indirect_write(hba, 7, 0x1a, 0x0007);
> +	ufs_renesas_indirect_write(hba, 7, 0x24, 0x000c);
> +	ufs_renesas_indirect_write(hba, 7, 0x25, 0x000c);
> +	ufs_renesas_indirect_write(hba, 7, 0x62, 0x0000);
> +	ufs_renesas_indirect_write(hba, 7, 0x63, 0x0000);
> +	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0014);
> +	ufs_renesas_indirect_write(hba, 7, 0x5e, 0x0017);
> +	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0004);
> +	ufs_renesas_indirect_write(hba, 7, 0x5e, 0x0017);
> +	ufs_renesas_indirect_poll(hba, 7, 0x55, 0, BIT(6));
> +	ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
> +	/* end of phy setup */
>   
> -	for (i = 0; i < ARRAY_SIZE(ufs_param); i++)
> -		ufs_renesas_reg_control(hba, &p[i]);
> +	ufs_renesas_write(hba, 0xf0, 0);
> +	ufs_renesas_write(hba, 0xd0, 0x00000d00);
> +	ufs_renesas_restore(hba, 0xd4, TIMER_INDEX);
>   }
>   
>   static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
