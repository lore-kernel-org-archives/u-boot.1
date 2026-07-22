Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF49C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 09:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCF2380BFF;
	Wed, 22 Jul 2026 09:05:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 719hXiD0mQSD; Wed, 22 Jul 2026 09:05:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D04F580C59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784711149;
	bh=amNSRftW+/iN1eupWvx3+/EYJu44wWrZ1w5AYcUTxVQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YhbedwPygLluUhDuBVzg1uAkSy1WAFvJviuNku/J0aSoQE3hLnvuhJagZgJF2w0Lu
	 9MWXleuCsVNdPgzgnfC144Csu9w8ySdeAeI5R00BGXJ/Y5xDwfx/hBxbJgXMebFqnr
	 ykxDVjvU4/fl0KDkqH3KDuInQ4GkBldFa6ATGv5NaiyKeSjzX1Bc7mo8VYr5eSqyBq
	 VlYa/bWejeqRtyJI97VJ9XK9B8OKhXCoaRkcKirUWrEMfIgKRAmG6SgdaYME+OAfLU
	 Cq5vYVnMF/mtF389kX8x7LiQISoGETt1lE23fEvDzMaBud3QHa0YZhD1UolZWNxuuu
	 9/MihAoEnHjUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D04F580C59;
	Wed, 22 Jul 2026 09:05:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E7B5DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 240444015A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JheHPvbDYb0A for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 09:05:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A24B740077
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A24B740077
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A24B740077
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:05:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6324F848BA; Wed, 22 Jul 2026 11:05:43 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733B7803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:05:40 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so34753025e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 02:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784711140; x=1785315940;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=amNSRftW+/iN1eupWvx3+/EYJu44wWrZ1w5AYcUTxVQ=;
 b=eRF9kGPHTxiUekWIUgMLNTpnjQt27rSczMxJa2AAJPsj9BtNsI89UXYGVETvG2+QPk
 oxzd06DEoVuabO1YvvnO5L7sKMzi800ZtUSNSsl1R7/KNjX1Kqh+O7HdscYQmUGDTj3O
 cEprIQ+J1sbaqsi3zAv3otTDLeEHWmoVL9I3eljIRxpI6pUunJS3Qy6M1YiGSru9tOtd
 qvpBT0ts0SE5Tf8vFLnRZElGgwB6XwI4rUloh+oLXNLMBgjazWF6h4OzEPkgxi8Opjez
 HBZn8EHn3A8Jnn5BFvYEzvTnGlYtK8iyKTqwGuNgfS65UG8xiFekVxLCD14soik4DK/H
 WlBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNJCohvv/5d9fbIUyzqjhKdNb79zC9Hp0erntfTFTXlZAKe3kFf6ALnUgIyGk4+TM5SleH7C8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxolpf9b8j7iR/WhJQmDkOgbdWHWKD29FAOeMcf0FiumBYeQU0j
 8Xpcq7W2EltHI5ZTJ3a7/biUGtyolV6eGww9YFsUOCuKwC/o9mNT9fGsijPf0KYMQhw=
X-Gm-Gg: AR+sD13l4Ufijvf41sJLT1NXVXTqFYyaOMp/Ncy9//2bTqh/hWe1nQfTXdho24hAPBh
 pwHI67xacXnDek7EjsNSizbkZH82JC0mjWCiikoiCQsTetQpyYtfUuzExdx5yow0xOJ/jn1HZQ5
 1OfgJy6teTzJ7jbzejpL0XCpL0/UwUPxtKhbNESQc6DJXdhKYg5NuAz88+sqnhoMnQi9gnPRTng
 XYj8+9xx5/e5caOGrw79tZfhc8r+lhz5lDQONQnUZAolBhx9pqg8BSdR7oJD4OLSZlp8grmS68S
 c7nZPfTqbbCycq53cUsx4KT6oLeIhRfdeclSB77tUdWN0kyh5vp5uzjVRcBxX/9hs+L+E8P1qQF
 fOAVpFNje3Iq9ZaICxUeHQ6g5+gZ74+v+r4LCYbARyUDQ/2oxjeyV6OCxnmVz2N186q4fu0sGex
 cY03aJPEdKrR1oeNa9XOBoEt3ADk0nYftB+UlTuJ09f/OJmFY5MgZQtkXjMEsbr+Xh1/lh
X-Received: by 2002:a05:600c:474e:b0:493:915b:dc4a with SMTP id
 5b1f17b1804b1-4954a3d005amr285393315e9.8.1784711139259; 
 Wed, 22 Jul 2026 02:05:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3307:4f92:b0bb:e8cd?
 ([2a01:e0a:106d:1080:3307:4f92:b0bb:e8cd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5127sm4649106f8f.10.2026.07.22.02.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 02:05:38 -0700 (PDT)
Message-ID: <dfa8cb93-535b-4707-8472-63c0d8038df5@linaro.org>
Date: Wed, 22 Jul 2026 11:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fastboot: add SPL support
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>
References: <20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com>
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
In-Reply-To: <20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784711140; x=1785315940; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=amNSRftW+/iN1eupWvx3+/EYJu44wWrZ1w5AYcUTxVQ=;
 b=QrQ4sfglZeR2JsBPPlMRn4fSePtReJDRmTcNA9+G7lcZwnkInUQssBT4JUO/PJ9Qw4
 3kyC8goJkosXmvm+5z6FsMYy1fj8bi56HjR75hBiKPeJdyXrSQTuw+D6SC5afA9iKKYz
 NojMNNkWFZTIDhudob97lKUNzbWWRVtUpvejLKTISxTDurV16z3xoXdqcMi7FCLqjGms
 dIhuNdNNw9jIMFZvfuJjL4Pb43wRmzpkSstl1I+wFygVopDQJPXm1rs0et7O0F2/jc87
 X1mI/b2toHzO3fqHiX36CNePWHXlPRFDb7dJ7PBiVYS9GSlcIuKtEJymAu3BWc0x0bH7
 VbgQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QrQ4sfgl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="QrQ4sfgl"; 
 dkim-atps=neutral
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

On 7/19/26 13:43, Carlo Caione wrote:
> Some recovery and initial-provisioning flows run before usable firmware is
> available in persistent storage. In these flows the SoC ROM loads a small
> first stage, but that stage must still provide a standard protocol with
> which the host can provision the device.
> 
> U-Boot already provides fastboot for this purpose, but its implementation
> is currently restricted to U-Boot proper and coupled to command-line
> support. This forces platforms that need provisioning from SPL to maintain
> a separate downloader or an out-of-tree fastboot implementation.
> 
> Allow boards to run USB fastboot as a service directly from SPL. Include
> MMC partition flashing and Android sparse-image handling so that the SPL
> service can provision the same storage images accepted by fastboot in
> U-Boot proper.
> 
> Keep the SPL interface deliberately narrower. The fastboot boot command
> is not supported because SPL is being used for provisioning rather than
> OS boot orchestration. Filesystem probing is also omitted, so partition
> types are reported as raw. Reboot support remains optional since reset
> and persistent reboot-reason handling are platform-specific.
> 
> SPL size remains an important constraint. Make the support entirely
> opt-in and phase-specific: when CONFIG_SPL_FASTBOOT is disabled, no
> fastboot code or supporting library is added to SPL and its binary size
> is unchanged.

The overrall code looks fine for me, but it would be much easier to review
if you did as split by moving all the non-SPL changes in some previous commits
like the usb_start, config_boot and preparation for SPL (CONFIG_IS_ENABLED, CONFIG_VAL).

Thanks,
Neil

> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   cmd/fastboot.c                  | 60 +++++----------------------
>   doc/android/fastboot.rst        | 27 ++++++++++++-
>   drivers/Makefile                |  2 +-
>   drivers/fastboot/Kconfig        | 89 ++++++++++++++++++++++++++++++++++++++++-
>   drivers/fastboot/Makefile       | 13 ++++--
>   drivers/fastboot/fb_block.c     |  9 ++---
>   drivers/fastboot/fb_command.c   | 58 +++++++++++++++++++--------
>   drivers/fastboot/fb_common.c    | 25 +++++++++++-
>   drivers/fastboot/fb_getvar.c    | 19 +++++----
>   drivers/fastboot/fb_mmc.c       | 36 ++++++++---------
>   drivers/fastboot/fb_usb.c       | 68 +++++++++++++++++++++++++++++++
>   drivers/usb/gadget/Makefile     |  1 +
>   drivers/usb/gadget/f_fastboot.c |  6 ++-
>   include/fastboot.h              | 10 +++++
>   lib/Kconfig                     | 11 +++++
>   lib/Makefile                    |  3 +-
>   lib/image-sparse.c              |  2 +-
>   17 files changed, 328 insertions(+), 111 deletions(-)
> 
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index f3929f88dfa..b12f9ea0ac4 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -7,12 +7,9 @@
>    * Rob Herring <robh@kernel.org>
>    */
>   #include <command.h>
> -#include <console.h>
> -#include <g_dnl.h>
>   #include <fastboot.h>
>   #include <net.h>
> -#include <usb.h>
> -#include <watchdog.h>
> +#include <vsprintf.h>
>   #include <linux/printk.h>
>   #include <linux/stringify.h>
>   
> @@ -63,7 +60,6 @@ static int do_fastboot_usb(int argc, char *const argv[],
>   {
>   	int controller_index;
>   	char *usb_controller;
> -	struct udevice *udc;
>   	char *endp;
>   	int ret;
>   
> @@ -82,48 +78,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
>   		return CMD_RET_FAILURE;
>   	}
>   
> -	ret = udc_device_get_by_index(controller_index, &udc);
> -	if (ret) {
> -		pr_err("USB init failed: %d\n", ret);
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	g_dnl_clear_detach();
> -	ret = g_dnl_register("usb_dnl_fastboot");
> -	if (ret)
> -		return ret;
> -
> -	if (!g_dnl_board_usb_cable_connected()) {
> -		puts("\rUSB cable not detected.\n" \
> -		     "Command exit.\n");
> -		ret = CMD_RET_FAILURE;
> -		goto exit;
> -	}
> -
> -	while (1) {
> -		if (g_dnl_detach())
> -			break;
> -		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> -			if (tstc()) {
> -				getchar();
> -				puts("\rOperation aborted.\n");
> -				break;
> -			}
> -		} else if (ctrlc()) {
> -			break;
> -		}
> -		schedule();
> -		dm_usb_gadget_handle_interrupts(udc);
> -	}
> -
> -	ret = CMD_RET_SUCCESS;
> -
> -exit:
> -	udc_device_put(udc);
> -	g_dnl_unregister();
> -	g_dnl_clear_detach();
> +	ret = fastboot_usb_start(controller_index, (void *)buf_addr, buf_size);
>   
> -	return ret;
> +	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
>   }
>   
>   static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -167,13 +124,14 @@ NXTARG:
>   		return CMD_RET_USAGE;
>   	}
>   
> -	fastboot_init((void *)buf_addr, buf_size);
> -
>   #if CONFIG_IS_ENABLED(NET_LEGACY)
> -	if (!strcmp(argv[1], "udp"))
> -		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> -	if (!strcmp(argv[1], "tcp"))
> +	if (!strcmp(argv[1], "udp") || !strcmp(argv[1], "tcp")) {
> +		fastboot_init((void *)buf_addr, buf_size);
> +		if (!strcmp(argv[1], "udp"))
> +			return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> +
>   		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
> +	}
>   #endif
>   	if (!strcmp(argv[1], "usb")) {
>   		argv++;
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 96c544ae11b..3f9cfb2fa78 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -10,7 +10,7 @@ The protocol that is used over USB and UDP is described in [1]_.
>   
>   The current implementation supports the following standard commands:
>   
> -- ``boot``
> +- ``boot`` (not available in SPL)
>   - ``continue``
>   - ``download``
>   - ``erase`` (if enabled)
> @@ -72,6 +72,31 @@ platform. The location of the buffer and size are set with
>   may be overridden on the fastboot command line using ``-l`` and
>   ``-s``.
>   
> +Fastboot in SPL
> +^^^^^^^^^^^^^^^
> +
> +Fastboot can be used from SPL without enabling the command line. Enable
> +``CONFIG_SPL_FASTBOOT`` together with the platform's SPL USB gadget support,
> +then start the session from board code::
> +
> +   ret = fastboot_usb_start(controller_index, NULL, 0);
> +
> +A ``NULL`` buffer and zero size select ``CONFIG_FASTBOOT_BUF_ADDR`` and
> +``CONFIG_FASTBOOT_BUF_SIZE``. Passing explicit values overrides these
> +defaults. The ``continue`` command ends the session and returns control to the
> +caller. Unlike the command-line invocation, an SPL session cannot be aborted
> +from the local console.
> +
> +MMC flash and erase support is enabled with
> +``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
> +storage layout must also be enabled, for example ``CONFIG_SPL_EFI_PARTITION``
> +for GPT.
> +
> +The ``boot`` command is not available in SPL. Reboot commands require
> +``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform ``reset_cpu()`` implementation.
> +The ``reboot-bootloader``, ``reboot-fastboot`` and ``reboot-recovery`` commands
> +also require a platform ``fastboot_set_reboot_flag()`` implementation.
> +
>   Fastboot environment variables
>   ------------------------------
>   
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..43d03479146 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)DMA) += dma/
>   obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
>   obj-$(CONFIG_$(PHASE_)DFU) += dfu/
>   obj-$(CONFIG_$(PHASE_)EXTCON) += extcon/
> +obj-$(CONFIG_$(PHASE_)FASTBOOT) += fastboot/
>   obj-$(CONFIG_$(PHASE_)GPIO) += gpio/
>   obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
>   obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
> @@ -93,7 +94,6 @@ obj-y += block/
>   obj-y += cache/
>   obj-$(CONFIG_CPU) += cpu/
>   obj-y += crypto/
> -obj-$(CONFIG_FASTBOOT) += fastboot/
>   obj-$(CONFIG_FWU_MDATA) += fwu-mdata/
>   obj-y += misc/
>   obj-$(CONFIG_MMC) += mmc/
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 90212fcf9ef..017fb7956a1 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -1,5 +1,6 @@
>   menu "Fastboot support"
> -	depends on CMDLINE
> +
> +if CMDLINE
>   
>   config FASTBOOT
>   	bool
> @@ -47,7 +48,27 @@ config TCP_FUNCTION_FASTBOOT
>   	help
>   	  This enables the fastboot protocol over TCP.
>   
> -if FASTBOOT
> +endif # CMDLINE
> +
> +config SPL_FASTBOOT
> +	bool "Support fastboot in SPL"
> +	depends on USB_GADGET && SPL_USB_GADGET
> +	depends on SPL_ENV_SUPPORT
> +	depends on !SPL_USE_TINY_PRINTF
> +	select SPL_LIBCOMMON_SUPPORT
> +	select SPL_LIBGENERIC_SUPPORT
> +	select SPL_PRINTF
> +	help
> +	  Enable the USB fastboot protocol in SPL. The board is responsible
> +	  for starting the fastboot session.
> +
> +config SPL_FASTBOOT_REBOOT
> +	bool "Enable fastboot reboot commands in SPL"
> +	depends on SPL_FASTBOOT
> +	help
> +	  Enable the fastboot reboot commands in SPL.
> +
> +if FASTBOOT || SPL_FASTBOOT
>   
>   config FASTBOOT_BUF_ADDR
>   	hex "Define FASTBOOT buffer address"
> @@ -79,6 +100,10 @@ config FASTBOOT_BUF_SIZE
>   	  downloads. This buffer should be as large as possible for a
>   	  platform. Define this to the size available RAM for fastboot.
>   
> +endif # FASTBOOT || SPL_FASTBOOT
> +
> +if FASTBOOT
> +
>   config FASTBOOT_USB_DEV
>   	int "USB controller number"
>   	depends on USB_FUNCTION_FASTBOOT
> @@ -294,4 +319,64 @@ config FASTBOOT_OEM_BOARD
>   
>   endif # FASTBOOT
>   
> +config SPL_FASTBOOT_FLASH
> +	bool
> +	default y if SPL_FASTBOOT_FLASH_MMC
> +	select SPL_IMAGE_SPARSE
> +
> +config SPL_FASTBOOT_FLASH_MMC
> +	bool "Enable fastboot MMC flashing in SPL"
> +	depends on SPL_FASTBOOT && SPL_MMC && SPL_DM_MMC && SPL_PARTITIONS
> +	select SPL_MMC_WRITE
> +	help
> +	  Build the fastboot MMC flashing backend into SPL. This allows the
> +	  fastboot flash and erase commands to operate on MMC partitions. A
> +	  suitable SPL partition-table parser must also be enabled.
> +
> +config SPL_FASTBOOT_FLASH_MMC_DEV
> +	int "Define fastboot MMC flash device in SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC
> +	default 0
> +	help
> +	  Define the MMC device that the SPL fastboot flash backend uses.
> +
> +config SPL_FASTBOOT_MMC_BOOT_SUPPORT
> +	bool "Enable eMMC boot-partition flash/erase in SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC && SUPPORT_EMMC_BOOT
> +	help
> +	  Enable the special fastboot targets used to flash or erase the eMMC
> +	  boot hardware partitions from SPL.
> +
> +config SPL_FASTBOOT_MMC_BOOT1_NAME
> +	string "Target name for updating eMMC boot partition 1 in SPL"
> +	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
> +	default "mmc0boot0"
> +
> +config SPL_FASTBOOT_MMC_BOOT2_NAME
> +	string "Target name for updating eMMC boot partition 2 in SPL"
> +	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
> +	default "mmc0boot1"
> +
> +config SPL_FASTBOOT_MMC_USER_SUPPORT
> +	bool "Enable eMMC user-area flash/erase in SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC
> +	help
> +	  Enable a special fastboot target for flashing or erasing the complete
> +	  eMMC user area from SPL.
> +
> +config SPL_FASTBOOT_MMC_USER_NAME
> +	string "Target name for updating the eMMC user area in SPL"
> +	depends on SPL_FASTBOOT_MMC_USER_SUPPORT
> +	default "mmc0"
> +
> +config SPL_FASTBOOT_GPT_NAME
> +	string "Target name for updating GPT from SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC && SPL_EFI_PARTITION
> +	default "gpt"
> +
> +config SPL_FASTBOOT_MBR_NAME
> +	string "Target name for updating MBR from SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC && SPL_DOS_PARTITION
> +	default "mbr"
> +
>   endmenu
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index a341af076d1..43e391d8ec4 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -3,8 +3,13 @@
>   obj-y += fb_common.o
>   obj-y += fb_getvar.o
>   obj-y += fb_command.o
> -obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
> +ifndef CONFIG_XPL_BUILD
> +obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
> +else
> +obj-$(CONFIG_SPL_FASTBOOT) += fb_usb.o
> +endif
> +obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_BLOCK) += fb_block.o
>   # MMC reuses block implementation
> -obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
> -obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
> -obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
> +obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
> +obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_NAND) += fb_nand.o
> +obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_SPI) += fb_spi_flash.o
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> index 51d1abb18c7..9658b14e668 100644
> --- a/drivers/fastboot/fb_block.c
> +++ b/drivers/fastboot/fb_block.c
> @@ -130,11 +130,10 @@ int fastboot_block_get_part_info(const char *part_name,
>   				 char *response)
>   {
>   	int ret;
> -	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> -						   NULL);
> -	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +	const char *interface = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
> +		(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)), (NULL));
> +	const int device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
> +		(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)), (-1));
>   
>   	if (!part_name || !strcmp(part_name, "")) {
>   		fastboot_fail("partition not given", response);
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 18d86988f4c..4a3cc4cbb27 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -37,9 +37,9 @@ static void getvar(char *, char *);
>   static void download(char *, char *);
>   static void flash(char *, char *);
>   static void erase(char *, char *);
> -static void reboot_bootloader(char *, char *);
> -static void reboot_fastbootd(char *, char *);
> -static void reboot_recovery(char *, char *);
> +static void __maybe_unused reboot_bootloader(char *, char *);
> +static void __maybe_unused reboot_fastbootd(char *, char *);
> +static void __maybe_unused reboot_recovery(char *, char *);
>   static void oem_format(char *, char *);
>   static void oem_partconf(char *, char *);
>   static void oem_bootbus(char *, char *);
> @@ -70,7 +70,9 @@ static const struct {
>   	},
>   	[FASTBOOT_COMMAND_BOOT] =  {
>   		.command = "boot",
> +#ifndef CONFIG_XPL_BUILD
>   		.dispatch = okay
> +#endif
>   	},
>   	[FASTBOOT_COMMAND_CONTINUE] =  {
>   		.command = "continue",
> @@ -78,19 +80,38 @@ static const struct {
>   	},
>   	[FASTBOOT_COMMAND_REBOOT] =  {
>   		.command = "reboot",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
> +#else
>   		.dispatch = okay
> +#endif
>   	},
>   	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
>   		.command = "reboot-bootloader",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_bootloader), (NULL))
> +#else
>   		.dispatch = reboot_bootloader
> +#endif
>   	},
>   	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
>   		.command = "reboot-fastboot",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_fastbootd), (NULL))
> +#else
>   		.dispatch = reboot_fastbootd
> +#endif
>   	},
>   	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
>   		.command = "reboot-recovery",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_recovery), (NULL))
> +#else
>   		.dispatch = reboot_recovery
> +#endif
>   	},
>   	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
>   		.command = "set_active",
> @@ -339,19 +360,19 @@ void fastboot_data_complete(char *response)
>    */
>   static void __maybe_unused flash(char *cmd_parameter, char *response)
>   {
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
>   		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
>   					   image_size, response);
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
>   		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
>   					 image_size, response);
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
>   		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
>   					  image_size, response);
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
>   		fastboot_spi_flash_write(cmd_parameter, fastboot_buf_addr,
>   					 image_size, response);
>   }
> @@ -367,16 +388,16 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
>    */
>   static void __maybe_unused erase(char *cmd_parameter, char *response)
>   {
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
>   		fastboot_block_erase(cmd_parameter, response);
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
>   		fastboot_mmc_erase(cmd_parameter, response);
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
>   		fastboot_nand_erase(cmd_parameter, response);
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
>   		fastboot_spi_flash_erase(cmd_parameter, response);
>   }
>   
> @@ -482,8 +503,9 @@ static void reboot_recovery(char *cmd_parameter, char *response)
>   static void __maybe_unused oem_format(char *cmd_parameter, char *response)
>   {
>   	char cmdbuf[32];
> -	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
> -					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
> +	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
> +					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
> +					      (-1));
>   
>   	if (!env_get("partitions")) {
>   		fastboot_fail("partitions not set", response);
> @@ -505,8 +527,9 @@ static void __maybe_unused oem_format(char *cmd_parameter, char *response)
>   static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
>   {
>   	char cmdbuf[32];
> -	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
> -					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
> +	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
> +					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
> +					      (-1));
>   
>   	if (!cmd_parameter) {
>   		fastboot_fail("Expected command parameter", response);
> @@ -531,8 +554,9 @@ static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
>   static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>   {
>   	char cmdbuf[32];
> -	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
> -					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
> +	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
> +					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
> +					      (-1));
>   
>   	if (!cmd_parameter) {
>   		fastboot_fail("Expected command parameter", response);
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 9c52e004588..bd8ba8824de 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -12,6 +12,7 @@
>   
>   #include <bcb.h>
>   #include <command.h>
> +#include <cpu_func.h>
>   #include <env.h>
>   #include <fastboot.h>
>   #include <net.h>
> @@ -89,6 +90,14 @@ void fastboot_okay(const char *reason, char *response)
>    * which sets whatever flag your board specific Android bootloader flow
>    * requires in order to re-enter the bootloader.
>    */
> +#ifdef CONFIG_XPL_BUILD
> +int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
> +{
> +	(void)reason;
> +
> +	return -EOPNOTSUPP;
> +}
> +#else
>   int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>   {
>   	int ret;
> @@ -127,6 +136,7 @@ out:
>   	bcb_reset();
>   	return ret;
>   }
> +#endif
>   
>   /**
>    * fastboot_get_progress_callback() - Return progress callback
> @@ -138,6 +148,7 @@ void (*fastboot_get_progress_callback(void))(const char *)
>   	return fastboot_progress_callback;
>   }
>   
> +#ifndef CONFIG_XPL_BUILD
>   /**
>    * fastboot_boot() - Execute fastboot boot command
>    *
> @@ -175,6 +186,7 @@ void fastboot_boot(void)
>   		do_reset(NULL, 0, 0, NULL);
>   	}
>   }
> +#endif /* !CONFIG_XPL_BUILD */
>   
>   /**
>    * fastboot_handle_boot() - Shared implementation of system reaction to
> @@ -189,12 +201,14 @@ void fastboot_handle_boot(int command, bool success)
>   		return;
>   
>   	switch (command) {
> +#ifndef CONFIG_XPL_BUILD
>   	case FASTBOOT_COMMAND_BOOT:
>   		fastboot_boot();
>   #if CONFIG_IS_ENABLED(NET_LEGACY)
>   		net_set_state(NETLOOP_SUCCESS);
>   #endif
>   		break;
> +#endif
>   
>   	case FASTBOOT_COMMAND_CONTINUE:
>   #if CONFIG_IS_ENABLED(NET_LEGACY)
> @@ -206,7 +220,14 @@ void fastboot_handle_boot(int command, bool success)
>   	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
>   	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
>   	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
> +#ifdef CONFIG_XPL_BUILD
> +#if CONFIG_IS_ENABLED(FASTBOOT_REBOOT)
> +		/* SPL may omit CMDLINE, so use the platform reset hook directly. */
> +		reset_cpu();
> +#endif
> +#else
>   		do_reset(NULL, 0, 0, NULL);
> +#endif
>   		break;
>   	}
>   }
> @@ -234,8 +255,8 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
>    */
>   void fastboot_init(void *buf_addr, u32 buf_size)
>   {
> -#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
> -	if (!strcmp(CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc"))
> +#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)
> +	if (!strcmp(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME), "mmc"))
>   		printf("Warning: the fastboot block backend features are limited, consider using the MMC backend\n");
>   #endif
>   
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index e8aa0e09aa6..608a62299af 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -70,19 +70,19 @@ static const struct {
>   		.variable = "current-slot",
>   		.dispatch = getvar_current_slot,
>   		.list = true
> -#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
> +#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
>   	}, {
>   		.variable = "has-slot",
>   		.dispatch = getvar_has_slot,
>   		.list = false
>   #endif
> -#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
> +#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)
>   	}, {
>   		.variable = "partition-type",
>   		.dispatch = getvar_partition_type,
>   		.list = false
>   #endif
> -#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
> +#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
>   	}, {
>   		.variable = "partition-size",
>   		.dispatch = getvar_partition_size,
> @@ -116,21 +116,21 @@ static int getvar_get_part_info(const char *part_name, char *response,
>   	struct disk_partition disk_part;
>   	struct part_info *part_info;
>   
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
> +	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)) {
>   		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
>   						 response);
>   		if (r >= 0 && size)
>   			*size = disk_part.size * disk_part.blksz;
> -	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
> +	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)) {
>   		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
>   					       response);
>   		if (r >= 0 && size)
>   			*size = disk_part.size * disk_part.blksz;
> -	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
> +	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND)) {
>   		r = fastboot_nand_get_part_info(part_name, &part_info, response);
>   		if (r >= 0 && size)
>   			*size = part_info->size;
> -	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI)) {
> +	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI)) {
>   		r = fastboot_spi_flash_get_part_info(part_name, &disk_part,
>   						     response);
>   		if (r >= 0 && size)
> @@ -240,12 +240,17 @@ static void __maybe_unused getvar_partition_type(char *part_name, char *response
>   	r = fastboot_mmc_get_part_info(part_name, &dev_desc, &part_info,
>   				       response);
>   	if (r >= 0) {
> +#ifdef CONFIG_XPL_BUILD
> +		/* SPL does not pull in filesystem probing just for this getvar. */
> +		fastboot_okay("raw", response);
> +#else
>   		r = fs_set_blk_dev_with_part(dev_desc, r);
>   		if (r < 0)
>   			/* If we don't know then just default to raw */
>   			fastboot_okay("raw", response);
>   		else
>   			fastboot_okay(fs_get_type_name(), response);
> +#endif
>   	}
>   }
>   
> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> index 9bc782ccd02..ae33e35365b 100644
> --- a/drivers/fastboot/fb_mmc.c
> +++ b/drivers/fastboot/fb_mmc.c
> @@ -75,7 +75,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
>   	int ret;
>   
>   	/* First try partition names on the default device */
> -	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +	*dev_desc = blk_get_dev("mmc", CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
>   	if (*dev_desc) {
>   		ret = part_get_info_by_name(*dev_desc, name, info);
>   		if (ret >= 0)
> @@ -111,7 +111,7 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
>   	return do_get_part_info(dev_desc, name, info);
>   }
>   
> -#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
> +#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
>   static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
>   			    int hwpart, u32 buff_sz, char *response)
>   {
> @@ -130,7 +130,7 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
>   }
>   #endif
>   
> -#ifdef CONFIG_ANDROID_BOOT_IMAGE
> +#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
>   /**
>    * Read Android boot image header from boot partition.
>    *
> @@ -346,7 +346,7 @@ int fastboot_mmc_get_part_info(const char *part_name,
>   static struct blk_desc *fastboot_mmc_get_dev(char *response)
>   {
>   	struct blk_desc *ret = blk_get_dev("mmc",
> -					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +					   CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
>   
>   	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
>   		pr_err("invalid mmc device\n");
> @@ -370,15 +370,15 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>   	struct blk_desc *dev_desc;
>   	struct disk_partition info = {0};
>   
> -#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
> +#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (dev_desc)
>   			fb_mmc_boot_ops(dev_desc, download_buffer, 1,
>   					download_bytes, response);
>   		return;
>   	}
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (dev_desc)
>   			fb_mmc_boot_ops(dev_desc, download_buffer, 2,
> @@ -388,7 +388,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>   #endif
>   
>   #if CONFIG_IS_ENABLED(EFI_PARTITION)
> -	if (strcmp(cmd, CONFIG_FASTBOOT_GPT_NAME) == 0) {
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_GPT_NAME))) {
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (!dev_desc)
>   			return;
> @@ -415,7 +415,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>   #endif
>   
>   #if CONFIG_IS_ENABLED(DOS_PARTITION)
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MBR_NAME) == 0) {
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MBR_NAME))) {
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (!dev_desc)
>   			return;
> @@ -440,7 +440,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>   	}
>   #endif
>   
> -#ifdef CONFIG_ANDROID_BOOT_IMAGE
> +#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
>   	if (strncasecmp(cmd, "zimage", 6) == 0) {
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (dev_desc)
> @@ -450,8 +450,8 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>   	}
>   #endif
>   
> -#if IS_ENABLED(CONFIG_FASTBOOT_MMC_USER_SUPPORT)
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
> +#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (!dev_desc)
>   			return;
> @@ -485,17 +485,17 @@ void fastboot_mmc_erase(const char *cmd, char *response)
>   {
>   	struct blk_desc *dev_desc;
>   	struct disk_partition info;
> -	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +	struct mmc *mmc = find_mmc_device(CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
>   
> -#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
> +#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
>   		/* erase EMMC boot1 */
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (dev_desc)
>   			fb_mmc_boot_ops(dev_desc, NULL, 1, 0, response);
>   		return;
>   	}
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
>   		/* erase EMMC boot2 */
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (dev_desc)
> @@ -504,8 +504,8 @@ void fastboot_mmc_erase(const char *cmd, char *response)
>   	}
>   #endif
>   
> -#ifdef CONFIG_FASTBOOT_MMC_USER_SUPPORT
> -	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
> +#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
> +	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
>   		/* erase EMMC userdata */
>   		dev_desc = fastboot_mmc_get_dev(response);
>   		if (!dev_desc)
> diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
> new file mode 100644
> index 00000000000..b6637c49fd8
> --- /dev/null
> +++ b/drivers/fastboot/fb_usb.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2008 - 2009 Windriver, <www.windriver.com>
> + * Author: Tom Rix <Tom.Rix@windriver.com>
> + *
> + * (C) Copyright 2014 Linaro, Ltd.
> + * Rob Herring <robh@kernel.org>
> + */
> +
> +#include <console.h>
> +#include <fastboot.h>
> +#include <g_dnl.h>
> +#include <usb.h>
> +#include <u-boot/schedule.h>
> +#include <linux/errno.h>
> +#include <linux/printk.h>
> +
> +int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size)
> +{
> +	struct udevice *udc;
> +	int ret;
> +
> +	ret = udc_device_get_by_index(controller_index, &udc);
> +	if (ret) {
> +		pr_err("USB init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	fastboot_init(buf_addr, buf_size);
> +	g_dnl_clear_detach();
> +
> +	ret = g_dnl_register("usb_dnl_fastboot");
> +	if (ret)
> +		goto err_put;
> +
> +	if (!g_dnl_board_usb_cable_connected()) {
> +		puts("\rUSB cable not detected.\n");
> +		ret = -ENODEV;
> +		goto err_unregister;
> +	}
> +
> +	while (!g_dnl_detach()) {
> +#ifndef CONFIG_XPL_BUILD
> +		/* SPL callers own the session lifetime and may have no console. */
> +		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> +			if (tstc()) {
> +				getchar();
> +				puts("\rOperation aborted.\n");
> +				break;
> +			}
> +		} else if (ctrlc()) {
> +			break;
> +		}
> +#endif
> +		schedule();
> +		dm_usb_gadget_handle_interrupts(udc);
> +	}
> +
> +	ret = 0;
> +
> +err_unregister:
> +	g_dnl_unregister();
> +	g_dnl_clear_detach();
> +err_put:
> +	udc_device_put(udc);
> +
> +	return ret;
> +}
> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index f2aebf4e480..87ec0cf6c40 100644
> --- a/drivers/usb/gadget/Makefile
> +++ b/drivers/usb/gadget/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_$(PHASE_)USB_ETH_RNDIS) += rndis.o
>   ifdef CONFIG_XPL_BUILD
>   obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
>   obj-$(CONFIG_SPL_DFU) += f_dfu.o
> +obj-$(CONFIG_SPL_FASTBOOT) += f_fastboot.o
>   obj-$(CONFIG_SPL_USB_SDP_SUPPORT) += f_sdp.o
>   endif
>   
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
> index 8df0e3f331d..49cacde9db5 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -422,7 +422,7 @@ static int fastboot_tx_write_str(const char *buffer)
>   static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
>   {
>   	g_dnl_unregister();
> -	do_reset(NULL, 0, 0, NULL);
> +	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
>   }
>   
>   static unsigned int rx_bytes_expected(struct usb_ep *ep)
> @@ -490,11 +490,13 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
>   	g_dnl_trigger_detach();
>   }
>   
> +#ifndef CONFIG_XPL_BUILD
>   static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
>   {
>   	fastboot_boot();
>   	do_exit_on_complete(ep, req);
>   }
> +#endif
>   
>   static int multiresponse_cmd = -1;
>   static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req)
> @@ -560,7 +562,9 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
>   	if (!strncmp("OKAY", response, 4)) {
>   		switch (cmd) {
>   		case FASTBOOT_COMMAND_BOOT:
> +#ifndef CONFIG_XPL_BUILD
>   			fastboot_func->in_req->complete = do_bootm_on_complete;
> +#endif
>   			break;
>   
>   		case FASTBOOT_COMMAND_CONTINUE:
> diff --git a/include/fastboot.h b/include/fastboot.h
> index b106d617749..b7b661b9591 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
>    */
>   void fastboot_init(void *buf_addr, u32 buf_size);
>   
> +/**
> + * fastboot_usb_start() - run a USB fastboot session
> + *
> + * @controller_index: USB gadget controller index
> + * @buf_addr: Pointer to download buffer, or NULL for default
> + * @buf_size: Size of download buffer, or zero for default
> + * Return: 0 on success, or a negative error code
> + */
> +int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size);
> +
>   /**
>    * fastboot_boot() - Execute fastboot boot command
>    *
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 24e55ade4d3..07ee3c88fd3 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -205,6 +205,9 @@ config VPL_STRTO
>   config IMAGE_SPARSE
>   	bool
>   
> +config SPL_IMAGE_SPARSE
> +	bool
> +
>   config IMAGE_SPARSE_FILLBUF_SIZE
>   	hex "Android sparse image CHUNK_TYPE_FILL buffer size"
>   	default 0x80000
> @@ -213,6 +216,14 @@ config IMAGE_SPARSE_FILLBUF_SIZE
>   	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
>   	  chunks.
>   
> +config SPL_IMAGE_SPARSE_FILLBUF_SIZE
> +	hex "Android sparse image fill buffer size in SPL"
> +	default 0x80000
> +	depends on SPL_IMAGE_SPARSE
> +	help
> +	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
> +	  chunks in SPL.
> +
>   config USE_PRIVATE_LIBGCC
>   	bool "Use private libgcc"
>   	depends on HAVE_PRIVATE_LIBGCC
> diff --git a/lib/Makefile b/lib/Makefile
> index 222378a8531..014fda82860 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -44,7 +44,6 @@ obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
>   endif
>   
>   obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
> -obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
>   obj-y += ldiv.o
>   obj-$(CONFIG_XXHASH) += xxhash.o
>   obj-y += net_utils.o
> @@ -56,6 +55,8 @@ obj-y += list_sort.o
>   obj-$(CONFIG_PMBUS) += pmbus.o
>   endif
>   
> +obj-$(CONFIG_$(PHASE_)IMAGE_SPARSE) += image-sparse.o
> +
>   obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
>   ifeq ($(CONFIG_$(PHASE_)TPM),y)
>   obj-$(CONFIG_TPM) += tpm_api.o
> diff --git a/lib/image-sparse.c b/lib/image-sparse.c
> index 09225692e9b..48e5d8ee869 100644
> --- a/lib/image-sparse.c
> +++ b/lib/image-sparse.c
> @@ -125,7 +125,7 @@ int write_sparse_image(struct sparse_storage *info,
>   	int i;
>   	int j;
>   
> -	fill_buf_num_blks = CONFIG_IMAGE_SPARSE_FILLBUF_SIZE / info->blksz;
> +	fill_buf_num_blks = CONFIG_VAL(IMAGE_SPARSE_FILLBUF_SIZE) / info->blksz;
>   
>   	/* Read and skip over sparse image header */
>   	sparse_header = (sparse_header_t *)data;
> 
> ---
> base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
> change-id: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64
> 
> Best regards,
> --
> Carlo Caione <ccaione@baylibre.com>
> 

