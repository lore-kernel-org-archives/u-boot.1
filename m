Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97014F9B5E0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C5B83936;
	Wed, 22 Apr 2026 10:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBcIx526";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64955840CB; Wed, 22 Apr 2026 10:36:29 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BBC8352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488d2079582so60233565e9.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776846985; x=1777451785; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jz4qrRMyBsylfJ/s/qiOcgXr+HmpyhfgN0lrMTstmbQ=;
 b=kBcIx526SOXJV68BidKvhE+Ve5lHN/Oh6tlWrH8EQCwLdcFuiECsn7J0A2k530bbpC
 nDxxCQGaeQ02PIsnrfJKYLX5rM6wG8leltE4OtxZOJQENs9xqBsa2k5RWVIklch8Twk0
 yvtwNrId1dGPRXFQAGVj0V6Aw6aLRhvr8ooAu7r4I0thvCB0l28M5qkfQC9itrNTst1U
 Fg//LaJZN6DuKbDItpYyi6KDZC4IFaQVAat12LksLgijNTxcFysMOVblQ1kClYTWTOAy
 OANdr/9528Xv/clXG2Q4R2GsvPNVUkGi7s+rUCfM1LDH17kdegMy8JHOCY+JCNFdmLM7
 sxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846985; x=1777451785;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz4qrRMyBsylfJ/s/qiOcgXr+HmpyhfgN0lrMTstmbQ=;
 b=IUaB39RIf5mhFEcM1c/iOoNL8N2NQm3MK5WLdWuZwGAAt72VzRrNV7IW2CKMXNZlXf
 p35oyds9DgVAwiX1t2b348j0s8zYi4hhaJqw9tnihV4xUTmNyLfhXzacpRW1ZPYDu7b9
 8ctQwl6AuRuxacv4+FMw8wz+dL+dNt9JkMJDgbJptC5xRGZAIcyV2siNUgaiFwxW4sjA
 MenlOvhLO30O21UIF5rtW7L2fkHVQnuSUW4SmRHGoVnEow5QT8yYnb8wJ1GfiKJ48gt6
 noFYy5FpqZkT4st+c1fjOcLdeYGY0/2k1GukS8bfE9S1rZ3z2xfH7Y/io+IL4K37dT7W
 DdFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8c0zBMcC4WlNihE2G1BzyYRoeaGxW/08a6EozQSbHnKwzQrJgbJCbnAqHsKBYO/Be7QSNeSdU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/Ln2ULftF10k7nLcbBkxXBLfyHJTlCAW3B+XrnRar4LgYINGR
 PIG1He6RL1DADlpBv5UWtGYyOutDLCoQRx+7vRDvG5r5kG0+SBgr6EVIGuYy4/ZJa6Y=
X-Gm-Gg: AeBDieubD+h8/5Xt2IEefNb2HdfrIqVBm9RjXPlyfKlqaW3Q9kh9RDNCsMur5MGGPF7
 KbN710y4dHZuaMLh+yCnPs6tnsThPg/sOex8jK0rkwXXY2OopJux2bqU+kpo5PmJtQJX2Jp39R5
 7fONLwxHr+2wLKraRjmi77w+9cKIiGqt+ZUYTkHB52uA8Nt2ecKl2bKhvpHEQzc4jM8jy2xq23j
 s+bNqx1Mq58EQr1UQwX5uauEJ2IerToX+y16KjjkRtcT6e6HSjpUoEumHrHMGOgW88iH31Nu3dT
 ebG4iGdPw1dgVyK0H6/hr4vIiRgT8oUwlIYHJQZGrO3kaeBxeQoTISKjEa70FsQyFuAauCZYK9R
 C7SueoKq8OlsWUA1PIE8Kt63KCC9VZt3qvbBdd5RCUwqFf0MB8Dik5D6IADQ8EDm8iRRpoV80Ko
 vlxLxPcCyBABO0KaIJXyhE3XxbWzAJzrubbNOd806Ro27wbL2nU/BnLu43O7KbZzzvfr3bGkHiC
 YT9wmcpEqbnWjYv2Q==
X-Received: by 2002:a05:600c:1d19:b0:48a:525b:e157 with SMTP id
 5b1f17b1804b1-48a525be257mr141443195e9.13.1776846982727; 
 Wed, 22 Apr 2026 01:36:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7?
 ([2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm442144685e9.4.2026.04.22.01.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:36:22 -0700 (PDT)
Message-ID: <9a187a8f-068a-4889-90a4-cba4c2f06328@linaro.org>
Date: Wed, 22 Apr 2026 10:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
To: u-boot-amlogic@groups.io, funderscore@postmarketos.org,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
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

On 4/8/26 22:30, Ferass El Hafidi via groups.io wrote:
> Mostly everything is already in place to enable EFI capsules and in particular
> EFI capsule on disk.
> 
> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> functionality expects sysreset to be present. As the current reset_cpu()
> function in board-common.c is basically only doing PSCI reset on U-Boot
> proper, we can replace it with sysreset's PSCI support, which works just
> fine for that purpose provided BL31 is running (SPL stays on an
> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> sysreset is too high and we don't have PSCI yet at that point).
> 
> Then we can enable capsule on disk. LaFrite has Capsule updates enabled
> already, so it is simply a matter of enabling CoD. LePotato does not
> have Capsule updates enabled by default, however it can be easily enabled
> and setup to update u-boot on eMMC/SD.
> 
> With Capsule on Disk setup, it becomes possible to update U-Boot directly
> from Linux, without having to worry about manually using `flashprog`
> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
> can be handled by `fwupd` and applied upon next EFI boot.
> 
> To test:
> 
>   * build U-Boot as usual
> 
>   * in that running U-Boot, run: `efidebug capsule esrt` to get the GUID
>     -OR-
>     run the following in your tree:
> 	tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESON_MMC
> 	                                   (or U_BOOT_MESON_SPI on LaFrite)
> 
>   * proceed with the following guide to create a capsule file:
>     https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-uefi-capsule-update-feature
> 
>   * generate a .cab file suitable for fwupd using `mkcab`:
>     https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/mkcab
> 	mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc "LePotato" 2026.04
>     (as of writing, the README.md suggests this is for Qualcomm only. It
>      actually does nothing that is Qualcomm-specific, and works on any
>      board that supports Capsule on Disk and fwupd)
> 
>   * on the board itself, boot to Linux via EFI, install fwupd, copy the resulting
>     .cab file, and run as root:
> 	fwupdtool --force install u-boot-libretech-cc.cab
> 
>   * reboot, make sure you boot over EFI, else the capsule update will not
>     start
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
> Ferass El Hafidi (4):
>        arm: mach-meson: move reset_cpu to spl only
>        arm: meson: enable SYSRESET_PSCI
>        configs: libretech-ac_defconfig: enable EFI Capsule on Disk
>        configs: libretech-cc_defconfig: enable EFI Capsule on Disk
> 
>   arch/arm/mach-meson/Kconfig        |  2 ++
>   arch/arm/mach-meson/board-common.c | 14 --------------
>   arch/arm/mach-meson/spl.c          | 10 ++++++++++
>   configs/libretech-ac_defconfig     |  1 +
>   configs/libretech-cc_defconfig     |  4 ++++
>   5 files changed, 17 insertions(+), 14 deletions(-)
> ---
> base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
> change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
> 
> Best regards,

Got the following failure in CI:

    aarch64:  +   sei510
+
+WARNING: unmet direct dependencies detected for SYSRESET_PSCI
+  Depends on [n]: SYSRESET [=y] && ARM_PSCI_FW [=n]
+  Selected by [y]:
+  - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]
+drivers/sysreset/sysreset_psci.c: In function 'psci_sysreset_request':
+drivers/sysreset/sysreset_psci.c:21:17: error: implicit declaration of function 'psci_sys_reset' [-Werror=implicit-function-declaration]
+   21 |                 psci_sys_reset(type);
+      |                 ^~~~~~~~~~~~~~
+drivers/sysreset/sysreset_psci.c:24:17: error: implicit declaration of function 'psci_sys_poweroff' [-Werror=implicit-function-declaration]
+   24 |                 psci_sys_poweroff();
+      |                 ^~~~~~~~~~~~~~~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:271: drivers/sysreset/sysreset_psci.o] Error 1
+make[2]: *** [scripts/Makefile.build:492: drivers/sysreset] Error 2
+make[1]: *** [Makefile:2205: drivers] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
    aarch64:  +   sei610
+
+WARNING: unmet direct dependencies detected for SYSRESET_PSCI
+  Depends on [n]: SYSRESET [=y] && ARM_PSCI_FW [=n]
+  Selected by [y]:
+  - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]
+drivers/sysreset/sysreset_psci.c: In function 'psci_sysreset_request':
+drivers/sysreset/sysreset_psci.c:21:17: error: implicit declaration of function 'psci_sys_reset' [-Werror=implicit-function-declaration]
+   21 |                 psci_sys_reset(type);
+      |                 ^~~~~~~~~~~~~~
+drivers/sysreset/sysreset_psci.c:24:17: error: implicit declaration of function 'psci_sys_poweroff' [-Werror=implicit-function-declaration]
+   24 |                 psci_sys_poweroff();
+      |                 ^~~~~~~~~~~~~~~~~

Could you fix it ?

Neil
