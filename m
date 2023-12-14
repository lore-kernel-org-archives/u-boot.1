Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED677C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1371D87A8E;
	Thu, 14 Dec 2023 15:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HdvIuyRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF59487A9B; Thu, 14 Dec 2023 15:53:16 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F06787A89
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cc47f1e829so4258851fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702565593; x=1703170393; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=skXGbXSIreTR378cHYiM0gsCg47hJf9aYIfMnwZnJOA=;
 b=HdvIuyRvLu0H/SZDsC8jCaRxGlLL4GJfAqTJdRVW5VxEwcIIXpr5DyooE63QCTmIdN
 H+SYwMnQ5v8NGLUhK2ZbXkDpByGAatagftCZtdjLH9p3MKvPPXm+10XvydeiZAT/wbUF
 I2X6A6FkGNqUAfJ6pAKUlXtPW5uo2ybEdxdW3zdCCpQBC1zsKOr+E6rjiSBMUatD6Pzw
 uo5Jvo8BYJ0JW4tGHzituYr3ltYhrD1LisaeEMj7CBphg7wQ0Sm0tOfhj83cUndE5YRX
 xgldZlln5UeKwenG7XdVYKb/XW13nBjQCMDsdzEvgfDCO+DPrQdlClqVgu77XoMzzJAb
 57Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702565593; x=1703170393;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=skXGbXSIreTR378cHYiM0gsCg47hJf9aYIfMnwZnJOA=;
 b=X2UwHv26NVUrT4FTJQAZS13ssrk8eZ3KA7umJDqjC8JFrGIa5+Czpeo521CWqS+dX1
 nM3iBhkJkwmKLW9FfoCpDENKDY3MIEYV7nxuPBNcyGZj068meBSXxLP/XSnm3HRX0hPj
 RCygRtihaDKEqokO/q4yj+phjF0qyjxo9UieMBVg0XiIPkEEPXDs+vgNS+E4vEv6rVxC
 Zo6wD9bZJEsJDOnYV1N+8kwL6DAeSl4uVngbkxMzVIfpH7VnuZ5ruiPSGQTq/ExRxQ+C
 iWOIa/aZigahxOO7v/NLTC55HvJ4sNuq2iESrEwOq5CWJPkQx8NebcmR8vpdAXWz6hSG
 /oFQ==
X-Gm-Message-State: AOJu0YyJ19SthmCxUjCIXjkjY4Vy2TnOB97E/922EvAeqcCVvIwt+x0c
 SHk+yxMqJ3pWmNdQtfSNnMq1tg==
X-Google-Smtp-Source: AGHT+IHyaE024GLfsR+Wc4ryyIrZYr/2H4ovYTdMbPruIU33VMS2BT3rzXtgdRHHKojUAmfund7rWA==
X-Received: by 2002:a2e:8e39:0:b0:2cc:41f1:a53c with SMTP id
 r25-20020a2e8e39000000b002cc41f1a53cmr611359ljk.7.1702565593213; 
 Thu, 14 Dec 2023 06:53:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1ec5:7f64:7775:e1e3?
 ([2a01:e0a:982:cbb0:1ec5:7f64:7775:e1e3])
 by smtp.gmail.com with ESMTPSA id
 x14-20020adfdd8e000000b0033630da3528sm6670578wrl.25.2023.12.14.06.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 06:53:12 -0800 (PST)
Message-ID: <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
Date: Thu, 14 Dec 2023 15:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 14/12/2023 14:50, Sumit Garg wrote:
> Prerquisite

s/Prerquisite/Prerequisite/

> -----------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-boot repo via:
> 
> $ git subtree add --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        v6.6-dts --squash

So I think the big question is: when should the subtree be updated ?

Because as we discussed in the previous GH pull request, if a bindings changes
was made in the upstream Linux DT, then the subtree update should wait until
the u-boot support is merged before updating. This could cause a lot of frustration.

And this could cause a lot of regressions, even more if both Linux and U-boot are
not maintained by the same people.

Neil

> 
> Background
> ----------
> 
> This effort started while I was reviewing patch series corresponding to
> Qcom platforms [1] which was about to import modified devicetree source
> files from Linux kernel. I suppose keeping devicetree files sync with
> Linux kernel without any DT bindings schema validation has been a pain
> for U-boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
> 
> However, Linux kernel DT maintainers proposed [2] for U-boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
> 
> In order to maintain devicetree files sync, U-boot will maintains a Git
> subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> It will be regularly updated with every new kernel major release via
> subtree pull as follows::
> 
> $ git subtree pull --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        <release-tag> --squash
> 
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-boot maintainers here [4]. Now we would like to
> reach out to wider U-boot community to seek feedback.
> 
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
> 
> Changes
> -------
> 
> Traditionally, U-boot placed copies of devicetree source files from Linux
> kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
>   
> CONFIG_DEFAULT_DEVICE_TREE "<name>"
>   
> SoC/board maintainers are encouraged to migrate to using mirrored copies
> from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
>   
> CONFIG_OF_UPSTREAM=y
> CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
> 
> An example have been shown for Amlogic meson-gxbb SoC and corresponding
> derived boards via patch #7 and #8.
> 
> Devicetree bindings schema checks
> ---------------------------------
> 
> With devicetee-rebasing Git subtree, the devicetree bindings are also
> regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
> sub-directory. This allows U-boot to run devicetree bindings schema checks
> which will bring compliance to U-boot core/drivers regarding usage of
> devicetree.
> 
> Dependencies
> ------------
> 
> The DT schema project must be installed in order to validate the DT schema
> binding documents and validate DTS files using the DT schema. The DT schema
> project can be installed with pip:
> 
> $ pip3 install dtschema
> 
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems:
> 
> $ apt install swig python3-dev
> 
> Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> installed. Ensure they are in your PATH (~/.local/bin by default).
> 
> Recommended is also to install yamllint (used by dtschema when present).
> 
> Running checks
> --------------
> 
> In order to perform validation of DTB files, use the ``dtbs_check`` target:
> 
> $ make dtbs_check
> 
> It is also possible to run checks with a subset of matching schema files by
> setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> or patterns (partial match of a fixed string). Each file or pattern should
> be separated by ':'.
> 
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> 
> Sumit Garg (8):
>    Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
>    Makefile: Add support for DT bindings schema checks
>    scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
>    dts: Add alternative location for upstream DTB builds
>    doc: devicetree: Updates for devicetree-rebasing subtree
>    MAINTAINERS: Add myself as devicetree-rebasing maintainer
>    dts: meson-gxbb: Switch to using upstream DT
>    dts: meson-gxbb: Drop redundant devicetree files
> 
>   .azure-pipelines.yml                    |   3 +-
>   MAINTAINERS                             |   6 +
>   Makefile                                |  20 +-
>   arch/arm/dts/Makefile                   |   8 -
>   arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
>   arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 415 ------------
>   arch/arm/dts/meson-gxbb-odroidc2.dts    | 418 ------------
>   arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
>   arch/arm/dts/meson-gxbb-p201.dts        |  26 -
>   arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
>   arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
>   arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
>   arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
>   arch/arm/dts/meson-gxbb.dtsi            | 856 ------------------------
>   configs/nanopi-k2_defconfig             |   3 +-
>   configs/odroid-c2_defconfig             |   3 +-
>   configs/p200_defconfig                  |   3 +-
>   configs/p201_defconfig                  |   3 +-
>   configs/videostrong-kii-pro_defconfig   |   3 +-
>   configs/wetek-hub_defconfig             |   3 +-
>   configs/wetek-play2_defconfig           |   3 +-
>   doc/develop/devicetree/control.rst      | 108 ++-
>   dts/Kconfig                             |  11 +
>   dts/Makefile                            |  17 +-
>   dts/arch/arm64/Makefile                 |  23 +
>   dts/arch/arm64/amlogic                  |   1 +
>   scripts/Makefile.lib                    |  42 +-
>   27 files changed, 204 insertions(+), 2730 deletions(-)
>   delete mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-odroidc2.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>   delete mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
>   delete mode 100644 arch/arm/dts/meson-gxbb.dtsi
>   create mode 100644 dts/arch/arm64/Makefile
>   create mode 120000 dts/arch/arm64/amlogic
> 

