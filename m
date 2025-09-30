Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B78CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E7F83045;
	Tue, 30 Sep 2025 09:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r23liT2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E3983071; Tue, 30 Sep 2025 09:58:16 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2B2828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2562e8cbso42943765e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759219093; x=1759823893; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3PEUpJBRBy8UN5xjMz8pCuYSZkWwFwD21Wrt2JaMFmo=;
 b=r23liT2AyjpHSY0i1kJxlOq6ayf9YBcsYK9hjiFQYjF8pk/l56njXAeK2bIJLpQCEZ
 JTUZNR9NgkPg4Aui4CGGMXeHAkyBMHzu/6enEPg92lbWqMgDpYR8W7Z4f1bvC1Q21HvC
 lLfxMgzDKM5p8A74GuZac7rRUfzbuZv4ZW/LMYv3qmTpGoIWhisBLYS3S3yeZYf7QwJg
 tqm/zwpoaMszqZw/4T4JxZet768OKMvHjAT3/t70s3RtD5/ULeUkQcVN9Eanyrp46ABv
 7polzdDZDP3GA/GChV9leoViWJ+vAu927U1CvSHygUMmKq7JoRC9ROrBql968qcKnF3d
 9RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759219093; x=1759823893;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3PEUpJBRBy8UN5xjMz8pCuYSZkWwFwD21Wrt2JaMFmo=;
 b=Tcxgbp5iZ+2j5f/4Ef1mJZNR0cS7VSHr7klm6vH/pDLY+OdxhOx1eicmNgx8O+U4Vn
 6SQmrMFKF4jzlXaBQOYPHweDyBy+Ib7HNWom743hbMxukRt7u+A6OBRGyHpg8k7Oxmw7
 fx261Y6JnACUScrUProOlfEh+Ggo9t0sK3e/NgVBfFncKTmBpkBmtw58VejptxcMsBdD
 mYJoWI18wc6wa5/qfIKv3Id9ohu5adhogbi3nwI2+mGy9d+iFmOFVaT/7LE5JZnWMB6b
 yC1iIvCnlyqaw/15toszLA/7IhxTe39iQKE9xxviZ3EBKlyXh7EDDSXRaSXuTCwepkHO
 JC7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJoQ6wARDDksu8Vu/z1gz12FU7aGa+EOaerIB7tLxXyN22CtiTm2oeJDmuue0Z62KMd6RKssE=@lists.denx.de
X-Gm-Message-State: AOJu0YzTTEkXE2HwsvTVP6uAZ2n3bIQLeFh3+2aSgolS7cghq7Lh6nRK
 K5FOLS5JFb6h3Vc03wM2tVwD0+1ec6jgqlroMFnzNnCOBWDjHnxlgbHwjZH/COqk7yc=
X-Gm-Gg: ASbGncsZ1KZlbPFrtqRr2iFvyd7UiAp25ITcyCNTUTlztOHnWcWCBpGmLbcCfWRKe8f
 QtwoTdgx7Lt2Ol4seONkCYBPSKusHmnGPQsv97nH+0XwrBnSD8381kFpbUByAu+lqgrZyFAzolt
 yANOhjp/cQBkyPfrYnz31ORoatrUjfeG21HcAa0WANPaAcu9ZYyVVt8P3WXrCw0qSC+phq3F+X3
 LJ1HbxPVNHDOnO1X5aNClSZpUqS2q139Mn8wR76DMmmCZ1SRxKI0zSKtuXbGSCcgvl7UW2ZVwRA
 VMUBcMlYnEusV6jXk0sxsptpiB9x4JS4Hrgmql8Jvm5UNYAtfA/OF+dR2XOmZlsYaoXZ0sxdzoT
 Btfm51AqHzLFFgn5Wi89u+SsrV+2P5B8NynVtRcwelUeqBuXg0ol08v2xG8Y2LDtWrTQywh4uBl
 FPG7IUxFZOzBIV3WxNhGLB/4mU0JRb8kAwaYYQZYPMzjaN
X-Google-Smtp-Source: AGHT+IEdqg9FXfGg+jK0zl+UH81V0oiBuTl5jT99IZRaYhflpgreZrl2i+oZ7w+/8cJqn5rWKE5fBQ==
X-Received: by 2002:a05:600c:4650:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-46e329f9e64mr114184995e9.21.1759219092983; 
 Tue, 30 Sep 2025 00:58:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f64d06sm43720215e9.12.2025.09.30.00.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 00:58:12 -0700 (PDT)
Message-ID: <24cc9575-9753-43b5-a9df-09beb8cb38ec@linaro.org>
Date: Tue, 30 Sep 2025 09:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: Update coding style to recommend b4 for patch
 submission
To: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
 <20250929-b4-docs-v1-1-a56c1a1856c5@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20250929-b4-docs-v1-1-a56c1a1856c5@linaro.org>
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

On 9/29/25 22:39, Javier Tia wrote:
> Replace references to patman with b4 as the recommended tool for
> preparing and sending patches. b4 is widely adopted in the Linux kernel
> community and U-Boot ships with configuration to simplify its use with
> the project mailing list.
> 
> The updated guidelines describe how to prepare series with b4, handle
> cover letters and recipient lists, run style checks, and send patches
> safely. Instructions also highlight how to collect and apply review tags
> before resending.
> 
> This change documents the preferred workflow for contributors and
> ensures consistency with common practices across related upstream
> communities.
> 
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>   doc/develop/codingstyle.rst | 54 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> index bc18b2ebb7b0fc875a299b9e2e5c64c3d6a8e2b3..8ed6babe4556423fe30effc504615e07a841f21a 100644
> --- a/doc/develop/codingstyle.rst
> +++ b/doc/develop/codingstyle.rst
> @@ -23,13 +23,55 @@ The following rules apply:
>     <https://peps.python.org/pep-0008/>`_. Use `pylint
>     <https://github.com/pylint-dev/pylint>`_ for checking the code.
>   
> -* Use patman to send your patches (``tools/patman/patman -H`` for full
> -  instructions). With a few tags in your commits this will check your patches
> -  and take care of emailing them.
> +* Use the `b4 <https://git.kernel.org/pub/scm/utils/b4/b4.git/>`_ tool to prepare and
> +  send your patches. b4 has become the preferred tool to sending patches for many
> +  Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
> +  targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl`` for
> +  recipient discovery.
>   
> -* If you don't use patman, make sure to run ``scripts/checkpatch.pl``. For
> -  more information, read :doc:`checkpatch`. Note that this should be done
> -  *before* posting on the mailing list!
> +  Start a topical series with ``b4 prep`` and keep the commits organised with
> +  ``git rebase -i``. ``b4 prep --edit-cover`` opens an editor for the cover
> +  letter, while ``b4 prep --auto-to-cc`` collects reviewers and maintainers from
> +  both the configuration file and ``scripts/get_maintainer.pl``.
> +
> +  .. code-block:: bash
> +
> +     b4 prep -n mmc-fixes
> +     git rebase -i origin/master
> +     b4 prep --edit-cover
> +     b4 prep --auto-to-cc
> +
> +  Run the style checks before sending. ``b4 prep --check`` wraps the existing
> +  tooling so you see the output from ``scripts/checkpatch.pl`` alongside b4's
> +  own validation. You can always invoke ``scripts/checkpatch.pl`` directly for
> +  additional runs.
> +
> +  .. code-block:: bash
> +
> +     b4 prep --check
> +
> +  When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review
> +  the generated emails and ``--reflect`` to copy yourself for records before
> +  dispatching to ``u-boot@lists.denx.de``.
> +
> +  .. code-block:: bash
> +
> +     b4 send --dry-run
> +     b4 send --reflect
> +     b4 send
> +
> +  After reviews arrive, collect Acked-by/Tested-by tags with ``b4 trailers -u``
> +  and fold them into your commits before resending the updated series.
> +
> +  .. code-block:: bash
> +
> +     b4 trailers -u
> +     git rebase -i origin/master
> +     b4 send
> +
> +* Run ``scripts/checkpatch.pl`` directly or via ``b4 prep --check`` so that all
> +  issues are resolved *before* posting on the mailing list. For more information,
> +  read :doc:`checkpatch`.
>   
>   * Source files originating from different projects (for example the MTD
>     subsystem or the hush shell code from the BusyBox project) may, after
> 

LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
