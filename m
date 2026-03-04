Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B2EB7EB6
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 09:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A974D839A8;
	Wed,  4 Mar 2026 10:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xwaEJg7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E1583F61; Wed,  4 Mar 2026 10:57:10 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97561838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 10:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso99654955e9.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772618226; x=1773223026; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1IG0nQPoKyifiu1IAqzCZpK4efJ4N5JVxgC2F68e60Y=;
 b=xwaEJg7NYlLSGuAXpW17T3FuUPWpDPtAYw0H3kUe7rfKvz+vDMSe5qKqpgP5ikfwvo
 va4vU4y4mDHkRYqIJz5q2KSYljK53ROkH9ycGwtjOfErjz71G38D3c3V8FPfw2vU7Xkh
 Bbnm1fk0JYScx8TyGlXM/KtIo1glrEGvewFVQYHCQTxIPf00KorCarN1vWEq20A0yDr6
 E97+oxg6eLA9y2wLwfS/oHBrJsrySQ2Jxhx0PCZX4E2wdIpsvuDfOh0194hz92ZhRU5q
 vA+iCfJuMSAkUe0QSWP4TjaRb6D4Rxo2pXWxLFNNsH0s37zDpWwcWjVJXLJD7wn+iNau
 tuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772618226; x=1773223026;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IG0nQPoKyifiu1IAqzCZpK4efJ4N5JVxgC2F68e60Y=;
 b=tQNDBuOnMwFZRwHhzWCmNXrU5rtXAuvttnHJvlI8ixt3P2oPLn4C/RHw4GI0F/Wtvh
 2Sj66PXEhQtJD3AMyhLyOa74lzoh5p4os686Xm8QU7BXA3MKHiM3RBR/PvPlof/vSTQJ
 P5NeLbus5MXlBcYHB0azi8Hbzc/d7rqh1OvQf9dTUiCCU/CWcZFaRUh9nYW5lKunrM11
 5X7Vr6XPxw7R3Nun+uxQOxfArdPncGJ8XKgwQzpUU1LD0TQ+FufLtNOuakQAJ876GTww
 yVy6lkcGO9eZ30TBgayUjAtTMZIUN5eU1qC/77HmSvyOIsgcvD0k+acFjhS6MRiNZvaz
 Oj7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLstsCxE5BImMConyRG7o8SWDu0QDEWcFERg3fWcuq9RqiOeUw1iJNLXzvL3wPwtWVhzAj+kI=@lists.denx.de
X-Gm-Message-State: AOJu0YxP1BdMlgBkHrHzep27GIRUsgk8oXzKeHz5YPzaHoiwNDUN96tc
 YA12t7EQwysPBDQzlofMoEGUzQs9DA3YrNpsD0zNC+fiQ8b7qFN5b+/AcQo2wS4+mrk9pvbFVyQ
 /Lp9Co+Q=
X-Gm-Gg: ATEYQzx8ety4fFJ0givbO+E+GHspbNrPVaOZPXzZPf5/QznAJGRRYJTbm/OTK8Es02m
 AoVthYZknPq+r1zoLZSZu0PaYdzVlfd8ae/hOAVnFRu6D+dEmoQbXlkC5XoT5peksjNGlZPjsmd
 0DIAeAq5HthZFy7iF+QlKX1FVGF3Jh/sskirJu34mLg497oABLaiMf+L61NE1qAaJOrSdZHbz7v
 7OxXBSaBtPaGwk8Lru9b1OR6kEP8wdEPsdTiY7gJxsO2ypUi3HF1K48be0LayRo4DFMXJnh+tXG
 8vEv/E36oKQqrDh9ApgM5I9wZMyo04agsryDx1GcI/5whMMOMKYBBXV9A844r/HF61eHImOS2xA
 nttd9d+0k/bS0UIbGkDYkk1U5OV+qVVcHPWw1DAfoLfNow6ufICq172TxIexEBs+1ZPe3B3IhQb
 ZjFSpzkzCx5qYO5la+VlJZiS54DZPfsTmNmRrMIDDL8Q18ZAdkzZFWqApLkBggAitvD0vaIwDc6
 K8DEOw=
X-Received: by 2002:a05:600c:3b09:b0:483:c35d:3662 with SMTP id
 5b1f17b1804b1-48519886a61mr20266375e9.18.1772618225820; 
 Wed, 04 Mar 2026 01:57:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:3ce7:2c0f:fa8b:1340?
 ([2a01:e0a:106d:1080:3ce7:2c0f:fa8b:1340])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851acfa177sm8850675e9.4.2026.03.04.01.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 01:57:05 -0800 (PST)
Message-ID: <194f9188-f6f6-4b68-b547-8c24865f0fdf@linaro.org>
Date: Wed, 4 Mar 2026 10:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] Add an initial CONTRIBUTE.rst
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260303214653.4096007-1-pbrobinson@gmail.com>
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
In-Reply-To: <20260303214653.4096007-1-pbrobinson@gmail.com>
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

Hi,

On 3/3/26 22:46, Peter Robinson wrote:
> Add a contributors file to provide a high level overview
> for people who wish to contribute to the project outlining
> basic details and setting some project expectations.
> 
> This isn't intended to replace any of the existing documentation
> but rather provide a succinct top level document that's easy
> to find to enable users to understand the project and get
> started as quickly as possible.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   doc/CONTRIBUTE.rst | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>   doc/index.rst      | 10 +++++++
>   2 files changed, 80 insertions(+)
>   create mode 100644 doc/CONTRIBUTE.rst
> 
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> new file mode 100644
> index 00000000000..7602e5c5a6a
> --- /dev/null
> +++ b/doc/CONTRIBUTE.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
> +
> +Overview
> +--------
> +
> +This document is a high level contributors overview setting overall expectations,
> +so people can get started quickly, the rest of the documentation goes into the
> +details.
> +
> +Code of Conduct
> +---------------
> +
> +The U-Boot project doesn't currently have an explicit code of conduct, but all
> +contributors are expected to act cordially to, and be respectful of, each others
> +contributions and opinions. There are many code of conducts for open source
> +projects available to review if you are unsure of expectations.
> +
> +Repository
> +----------
> +
> +The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
> +
> +Contributions
> +-------------
> +
> +Contributions to the project are welcome. The U-Boot project uses a fairly
> +traditional Linux style development workflow using git and `a mailing list
> +<https://lists.denx.de/listinfo/u-boot>`_.
> +
> +Patches should be sent to the mailing list using ``git send-email`` or the
> +equivilant commands using ``b4`` or ``patman`` with appropriate sign-off and

     equivalent ?

> +attributions for the code in question. Maintainers should be copied on mails
> +and they can be found with the ``./scripts/get_maintainer.pl 0001-fix.patch``
> +script. Please don't send patches as attchments, and ensure corporate mail

                                         attachments

> +systems don't reformat patches, append disclaimers or other uneccessary notes.

                                                                unnecessary

Could you add that b4 does all the work by adding people in CC and getting the
right maintainers email, running checkpatch and doing the signature stuff.


> +
> +Patch Series
> +------------
> +
> +Patch series for a specific subject are welcome but they should be constrained
> +to a single topic with a cover letter outlining the intention of the series.
> +
> +Generally bug fixes for existing bugs should be at the beginning of the
> +series before any enhancements to allow those patches to be picked up early.
> +
> +Each iteration of a patch set should be versioned, allow enough time for people
> +to review previous versions of the series and incorporate all the review
> +feedback before sending a new version. A week between larger patch sets is
> +considered as reasonable amount of time.

Could you add that within a patch serie, each patch should cover a single changeset and not break build or regress ?

> +
> +Development Branches
> +--------------------
> +
> +The U-Boot developers use two main branches for developing the code. The master
> +branch is used for the current development cycle, while there is also a next
> +branch intended to land changes for the next release early to enable wider
> +testing of larger code changes. The next branch is merged to master shortly
> +after the tagging of a new major release.
> +
> +Similar to Linux there is a two week merge window post release after which a
> +release candidate is tagged. There's typically a new release candidate every
> +two weeks post merge window until the stable generally available release.
> +
> +Release Schedule
> +----------------
> +
> +There is currently four major releases a year in January (.01), April (.04),
> +July (.07) and October (.10). These typically happen on the first Tuesday of
> +that month. There is currently no release branches or long term releases.
> diff --git a/doc/index.rst b/doc/index.rst
> index 43398627d89..9ef6aa9c258 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -15,6 +15,16 @@ if you want to help out.
>   .. toctree::
>      :maxdepth: 2
>   
> +Contributing Guidelines
> +-----------------------
> +
> +General guidelines for contributing to the U-Boot project.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   CONTRIBUTING
> +
>   User-oriented documentation
>   ---------------------------
>   

Thanks,
Neil
