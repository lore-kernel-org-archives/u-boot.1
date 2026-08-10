Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CDAC5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 08:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49A656064C;
	Mon, 10 Aug 2026 08:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yQm1eDTmILn; Mon, 10 Aug 2026 08:13:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 816B56063F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786349625;
	bh=V6CcsBmE9d8AZRmH1oxEjtohI7GsrsRp4pHHWd8oXNs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=A6XZ9l+jsGUzdKcoeurLYZ0+UtQ/LI1Sd5lgsBoI8i6nDuFUQiie1BzHR/PLtaOQQ
	 u+Xp0TaZWolqwgcJY4Y4ubGdE4Ys5Iad2h5T4THUj7G+QtFMFgSRIaSt4IAtHYdg/N
	 wt2sgqY+gxSgckGyY19EEw+jZuv/h6kU/37KAQ9QegOkKM7CgmoJE9dFQqEf5WU/Ka
	 X+zrudff2zbcrJjZMvubt9HxcohrocOyH6Y2r9uNyZLwkJtDZeN9BSq+i2Rkbch5Pa
	 cG13EtHQIWgxcJQg7idQXJkyELNP1dD8GXFmkVlKQ3rrfzdBsf82F8RCH3I8wjEeVQ
	 /nYgjvmbslL0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 816B56063F;
	Mon, 10 Aug 2026 08:13:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E561282
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 145286063F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kHGAOgvX600 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 08:13:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9F946063A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9F946063A
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9F946063A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:13:43 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so14130375e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 01:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786349622; x=1786954422;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V6CcsBmE9d8AZRmH1oxEjtohI7GsrsRp4pHHWd8oXNs=;
 b=eri6Em/imkEVOEZ+zvwPJkOQqf8lI6SI1oC5ZGPkqa7WimjAsy6wBMIVdvo9ITr5ZA
 IlwwYEvu+OaciksF7Q1LIPQvWqSHHxbG6w9eutVQ/A6yq+E+6yfdcg4Sn3GWnWOP0EXV
 XkIQOJ9lUbWlztPOcO+m59aHQcL7DfHuhBYOs62PiTSySTjRoUnDuOFeU/R+ZtxK51W5
 /P4sPBVGZkxya/qurHZlKvdnXZ9i6px7B37nd9AEqxco8Wk6+L4EHTji7yoj+63Q+g7Z
 TSR4/e3eV8T0T43ZvKLpI0ppTnUl7er3KewgFggICq4zT4HvH5RApsMyIThg7GCsbP0Z
 H5YQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKhyiw8dqlY//THNsBZ54MAX6DIeqDhkFXLFxzGLHX37gkzsNwZ146AD4QRnPClIV9VrfIfQk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzoE5ZfjXBizRLmIqpyWHL9d9ePQYGPgzPhwNHyyk3hT4p7NNyO
 Zs/FZJxSXX3qsHXttbIt3yx7vnelYGwwSNTmDOLRIpH94Uy0WxRoaQA46sRZ7NL5ZIM=
X-Gm-Gg: AR+sD12pxDB4bTMM2ymqp0GRrULkCBIpSNWpx3+CG12alpULJOiViGYeB3ZRj3ftpny
 ujT/KsIIRnfkASmt6h1ES3bIqY0DDID7gDPIyiB847i0PkwWHjQ4r0fZxTm/GOGXOBtQkirKmCu
 2BfEeQ4OH+s+TXf3/sd8lUfP+vR248ZuSc0ezNOYRcaSuJ+vS+O6cNarrivnfNfV9OsW+lI6tkQ
 8gigSaNS+HvpZErYS3Wq7NCg65vnFpHGwGgBIDXfYh53+pdoIQseKhxYQlYZgD0n8f4I2wcJYrQ
 SF12k5qIlSOq42N00i/pcOJCfkI6CkZLQsyhb/SWmz8vN1mVYjVO5CMJ50kbJPaRpHRgtO6+hFI
 vvaBTRN7sDgx8FROyRO7RppPkWZ1hDQ5uhI3FISoUvTPmJVPurMS+YU6h9bQwfO01vf4zbPUbUI
 nwbCtKaCQAws5uXkJl3R02EKTWZqjFB3NY21RsoGDVZUUxS7Aj9iVHWgzS3jJUYp7oUIlyHpwse
 biMmT8R2AXt8shSxrauw3u3bI+NerMm8eyenXvuyQ==
X-Received: by 2002:a05:600c:310f:b0:493:faf3:3ea5 with SMTP id
 5b1f17b1804b1-4994e7432ecmr511736155e9.4.1786349621614; 
 Mon, 10 Aug 2026 01:13:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800215078asm31207435f8f.12.2026.08.10.01.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 01:13:41 -0700 (PDT)
Message-ID: <22f08266-216d-4554-ab1c-5a93ffffc37d@linaro.org>
Date: Mon, 10 Aug 2026 10:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
To: Lucas Tanure <tanure@linux.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io
References: <20260806101809.72526-1-tanure@linux.com>
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
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786349622; x=1786954422;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V6CcsBmE9d8AZRmH1oxEjtohI7GsrsRp4pHHWd8oXNs=;
 b=ASbEXTvdJgDs4nppdLj94lZCBbSC4Tv7dRF7SM7klM++U+KfEvjWtjwKHfx/7uXJyb
 fcBaeVBU2aJYQiW6roSMIebdteRoJPdlOshuer0t9pKKwrsgPI+lPAPcKSn6l4pfO28t
 M16IHsD2dRUCuBSudkhVjuQSlS0WR/Ln9AU6913nUX3CdBQVrJG3PHJPQeUeh3MUA0yg
 qQgpiPT/6KOP/QCTSYSwLsuwtSsiroZ7APvDCeMIpknariNPzoygwn9lyAHl0RDBwr36
 bdJpG3wOMbHV+tQIHJyKue1WM+K/Sa7oIT0iteHSvrrq7doCTNO8CZG8ms92pVAV55Vn
 zbNg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ASbEXTvd
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Lucas,

On 8/6/26 12:18, Lucas Tanure wrote:
> This series adds initial mainline support for the Amlogic T7 SoC
> family and the Khadas VIM4 board (A311D2):
>   - S4-generation UART support
>   - the T7 platform code
>   - VIM4 board and defconfig
>   - VIM4 documentation
> 
> Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
> (tftpboot) and cold-booted from an SD card.
> 
> Lucas Tanure (4):
>    serial: meson: add Amlogic S4 UART support
>    arm: meson: add Amlogic T7 SoC family support
>    board: amlogic: add Khadas VIM4 support
>    doc: board: amlogic: add Khadas VIM4 documentation

Overall this looks good, I'll review all the changes closely,

Neil

> 
>   .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi |  22 ++++
>   arch/arm/include/asm/arch-meson/boot0.h       |  18 +++
>   arch/arm/mach-meson/Kconfig                   |  10 ++
>   arch/arm/mach-meson/Makefile                  |   1 +
>   arch/arm/mach-meson/board-t7.c                |  97 ++++++++++++++
>   board/amlogic/vim4/MAINTAINERS                |   8 ++
>   board/amlogic/vim4/Makefile                   |   4 +
>   board/amlogic/vim4/vim4.c                     |  14 ++
>   configs/khadas-vim4_defconfig                 |  27 ++++
>   doc/board/amlogic/index.rst                   | 119 ++++++++---------
>   doc/board/amlogic/khadas-vim4.rst             | 122 ++++++++++++++++++
>   drivers/serial/serial_meson.c                 |  51 ++++++--
>   12 files changed, 421 insertions(+), 72 deletions(-)
>   create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>   create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
>   create mode 100644 arch/arm/mach-meson/board-t7.c
>   create mode 100644 board/amlogic/vim4/MAINTAINERS
>   create mode 100644 board/amlogic/vim4/Makefile
>   create mode 100644 board/amlogic/vim4/vim4.c
>   create mode 100644 configs/khadas-vim4_defconfig
>   create mode 100644 doc/board/amlogic/khadas-vim4.rst
> 

