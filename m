Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A880CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A918490B;
	Thu,  4 Jun 2026 14:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pw2WAVIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B868493E; Thu,  4 Jun 2026 14:48:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E527848DF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so6300565e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780577328; x=1781182128; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KuXfxNr0l2ZPQaUGohdPO3hh0Us74UTHf0szR62wmE0=;
 b=Pw2WAVIFuGDWzp1RcfmGrTVV5AmOC5v+FLA6ZXKDiK4BE2QFxRJzZehAhKz3eRT7Q8
 av8VpzJiAtalUuM2P2u+rotqL18FzMl6rXeZ3gaawljREJBWYGLPK/U/iB80N00FcBGQ
 F/wJQ5bVqIR80qXYv8lXgNZurPDPQxbakDH3E7X4RwXOFHCHBEbtEbZJkrchfNJo4NnA
 T/lrRC0U/hOlq6l4DqVBG7go3+zYi6Dz//hE8vvMhS3HLKn0u/kZy7n44G4GaUc1xC75
 9+j8yhJj7HYbEFbRDQM7/nOW+sB1GcxX7YyNbC2ZQ7Uh8PomyUAM+3TQ1zecCVEi/m9U
 2mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577328; x=1781182128;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuXfxNr0l2ZPQaUGohdPO3hh0Us74UTHf0szR62wmE0=;
 b=Mn4V1BbKwihsExxhF5q8KGN+HMlZmqdbpQXnwGDhUyORW9HC1JSPy3oxZtX/Tq52ZR
 l3mJWedMRnOmoVPM9JGVdoB/q3tF3TSFuhgxg+DTRS0URidhikFR2n4ElCsZqyxKdRhH
 6tVSBIDpSUW3PaTNIGijFc6/6UuMIl2Z962gZ7NsA85yI489B1RoMm+L56uc1HA/toLr
 NnuHATumSlFKh1sLh0ovlDN3vIpTJHCzdCd75mY62v3RbFqxCAqJpLwXM4DX+Mm3ZaXj
 mpPmLKaO51Roi7UcHN87ZpzJBoZMJyRR8+VbHSru7i2wnODOPZLEvRFw7I8IjtEEIKtS
 Z9zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZWqCLfcWDpajaboRqI48V4PP3A9MzdKyUw2sC+VlaNxOfCUgm5ah6R+YlCp9C5qOAb+uTAuc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxhyd9U5SRMDMXFKk1nX65nrymVqKYuuCjX11WVt8FXn3y+5OnO
 yxAmVtwcgdciF6eDISKg07VohurovoBzVZZN6hoJFMqzlaYycm0WJ2LmQ5bjPMymi+c=
X-Gm-Gg: Acq92OE1k6gobbG11u/o73baczMWFhHaScTJPtY0+aH5FyVxV0zoBjD+4/dhxsotq+d
 xFfxNi00xN11TctyVtoRwxTvjhPrSVcAPK2QyGbRGbVxh4UP4E6+peWtPnz4ZNDm8nQ1LLfy8xM
 7h98RzjFUXKeivCGllLllOo13Z0TRRtYEjZHmgI+SQpzGQCyB38xLxeGk+bNxyRpI2vnNBL5NMF
 Y2VjQOPcPVWxuTlIPuZe2zTmIGuOf3su1KMtyKgUYcZlCzV99rYnVadM8AFf4swsIz5YKdMHglp
 8gH8iW5sp0QBfv6JQ3HgWCdx3zm/BKzb+01pa9Tg4lR5gZB0kmMDqjxkZEjv+1Cw/f50Eoavztx
 hp4m/7MGBbDqgrwte9vVhKvZszqXlxUa3gXl5VCHIPot3twsatvjIJDqxLj31tWN5JEP1ZTR5To
 eoIskof9VgsH6yK11TliEPqBsm4ijx9Bs9kAdIKvG3CabC7rLkFQsxPOsYouh75iXE6NjUPms8I
 7A5A53ECsOQtEI=
X-Received: by 2002:a05:600c:4fcb:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-490b60ff366mr127376645e9.31.1780577328460; 
 Thu, 04 Jun 2026 05:48:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm15809995f8f.17.2026.06.04.05.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:48:48 -0700 (PDT)
Message-ID: <20f96ca5-e76a-46ca-ad8a-5cc18149c621@linaro.org>
Date: Thu, 4 Jun 2026 14:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH PATCHSET 4/6] ufs: ufs tool
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
 <20260604-ufs_tool-v1-4-741ed00232c0@mobileye.com>
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
In-Reply-To: <20260604-ufs_tool-v1-4-741ed00232c0@mobileye.com>
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

On 6/4/26 13:25, Raz Ben Yehuda via B4 Relay wrote:
> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
> The UFS tool provides utilities for querying, displaying, and modifying
> UFS device configuration and descriptor information.
> 
> Features:
> - Query and display Device, Geometry, Unit, Configuration, and Power
>    Descriptors
> - Display LUN configuration and calculated capacities
> - Modify LUN, Configuration, and Device Descriptor fields
> - Configure WriteBooster-related parameters
> - Query common UFS runtime flags
> - Commit configuration changes or clear all LUN configurations
> - Decode and format descriptor contents for easier debugging
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   cmd/ufs.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 89 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/ufs.c b/cmd/ufs.c
> index 790dab50f18..c8bafcd5e1d 100644
> --- a/cmd/ufs.c
> +++ b/cmd/ufs.c
> @@ -24,15 +24,100 @@ static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   			} else {
>   				ufs_probe();
>   			}
> -
>   			return CMD_RET_SUCCESS;
>   		}
> -	}
>   
> -	return CMD_RET_USAGE;
> +#if IS_ENABLED(CONFIG_UFS_TOOL)
> +		if (!strcmp(argv[1], "query")) {
> +			int lun = -1;
> +			int idn = -1;
> +
> +			if (argc <= 3) {
> +				printf("usage: lun idn");
> +				return CMD_RET_FAILURE;
> +			}
> +
> +			lun  = dectoul(argv[2], NULL);
> +			idn  = dectoul(argv[3], NULL);
> +
> +			return ufs_tool_query(lun, idn);
> +		}
> +
> +		if (!strcmp(argv[1], "set_lun")) {
> +			int lun;
> +			u32 val;
> +
> +			if (argc <= 4) {
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			lun  = dectoul(argv[2], NULL);
> +			val  = dectoul(argv[4], NULL);
> +			return ufs_tool_set_lun(lun, argv[3], val);
> +		}
> +
> +		if (!strcmp(argv[1], "set_dev_desc")) {
> +			const char *name;
> +			u32 val;
> +
> +			if (argc <= 3) {
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			name = argv[2];
> +			val  = dectoul(argv[3], NULL);
> +			return ufs_tool_set_device_desc(name, val);
> +		}
> +
> +		if (!strcmp(argv[1], "set_cfg_desc")) {
> +			const char *name;
> +			u32 val;
> +
> +			if (argc <= 3) {
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			name = argv[2];
> +			val  = dectoul(argv[3], NULL);
> +			return ufs_tool_set_config_desc(name, val);
> +		}
> +
> +		if (!strcmp(argv[1], "getflag")) {
> +			if (argc == 2) {
> +				printf("usage: getflag [flag name]");
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			return ufs_tool_query_flag(argv[2]);
> +		}
> +
> +		if (!strcmp(argv[1], "commit"))
> +			return ufs_tool_commit();
> +
> +		if (!strcmp(argv[1], "clearall"))
> +			return ufs_tool_clearall();
> +
> +		if (!strcmp(argv[1], "luns")) {
> +			ufs_tool_print_luns();
> +			return 0;
> +		}
> +	}
> +	ufs_tool_help();
> +#endif
> +	return CMD_RET_FAILURE;
>   }
>   
> -U_BOOT_CMD(ufs, 3, 1, do_ufs,
> +U_BOOT_CMD(ufs, 5, 1, do_ufs,
>   	   "UFS sub-system",
>   	   "init [dev] - init UFS subsystem\n"
> +#if IS_ENABLED(CONFIG_UFS_TOOL)
> +	   "query [LUN] [IDN]\n"
> +	   "set_lun [LUN] [parm name] [value]\n"
> +	   "set_cfg_des   [parm name] [value]\n"
> +	   "set_dev_desc  [parm name] [value]\n"
> +	   "luns - prints luns\n"
> +	   "clearall - zero out configuration descriptor\n"
> +	   "getflag [flag name]\n"
> +	   "commit - writes luns configuration\n"
> +#endif
>   );
> 

I'm still puzzled on the overall design, I think most of the "tool"
code should be in cmd/ and only the helpers should be in drivers/ufs,
and not in a dedicated ufs-tool.c but either in the core or in a separate
helpers.c file.

Neil
