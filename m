Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FCACA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 07:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF61830A0;
	Wed, 10 Sep 2025 09:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RcuR3JA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4AF831D5; Wed, 10 Sep 2025 09:03:09 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC9082B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 09:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3dae49b1293so3266876f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757487786; x=1758092586; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Um4mbIBpBor6xjVylODbway0xPglGJRf3Ehub4y+HTQ=;
 b=RcuR3JA8a7y0eA4MMai/dN7DzL6mTOTqhtKZ54uabB6EkX11V2MHnd/vkbuPKBB9Hz
 hAIYYN62ugrAvdrAMHn5nTMyZ4bA1bThAumykv8gDIotnod7cPxyehNd5LBq2xXBxYzE
 kjrgPJsvfm9ay/cIqyATZ6QiLUi4sWdla/9PCiBtynzOAt4QmSv84m4UStKkivk7M68w
 GopYn732rIhlsb2ffRezNgZX75kTq4BT/g8QCC/yo3+VSV+rXy5JdG/20+/Hz5iCxO3i
 MFP66j/frREkm3RedCtybukVq5S5jBvyGJEpjFPEzRD9yx4Fdutv4OQ3ogMRKq5UJJB/
 C0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757487786; x=1758092586;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Um4mbIBpBor6xjVylODbway0xPglGJRf3Ehub4y+HTQ=;
 b=g2weu34SYhX3853dm2wlGIKxu5/U42+2m502cTbh7oChvUoVQb7tfsxC8nfLzTePg2
 sJB6Ty8/bfdaGrlQGuvEai2lDoV6T8F5nL+cpZpK6uON+JY4bOHZmWbnyOr7nAwWCA56
 eKqsK/Cv3ZIUhvc5RzvDevE6tkwVpHUqIT/u7Vz65/weZ+d4UZicqZmnTa4l1ltsYQc0
 7/2fXDq6lmMGxu++AfGmpESDM0pR0ZAZrIhfOS9TuwJDlca43slLW9qCl7V0X6YPjXvD
 +odjzc7NLfMRwBp2aBRjN6tl2iwLZl+17Rbx0yod/QzhgKjRBAR1roOcHb5j6iARQT4L
 5qSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWbdaEr6ScBUuO2U0pq1MeNVWFdykm1kRf3TwbOPtoSj6N9gNNL+DjNexXihpuih7SDoubCcE=@lists.denx.de
X-Gm-Message-State: AOJu0YwKm7JXCVsBT+/YfvR/MBbfPQfET+CSuyUOCl9JLOK1tuEeYa47
 uvK8ZLrwhYSu2eMM8jzcP39WLob4U8D6l+k8BOBW3JOLt0fW+4ibJWNJu83lnsMIUJQ=
X-Gm-Gg: ASbGnctpt+zq5m/y5qWwdoGB5DqmB3PZu6UOq/x8aeKtnAWZX5rsTZ23nfB8zFPH1l/
 ZBSqzi6D7Sy86hQeeJWAUWEsKxkkEwYD8H11Y6+/2vsuaCeH44Q9PKeyWypKmm3V/pz3uoqsnGv
 F1U1z7Ke05yxT1uJS6yXnrcFkJ+GfjmrEZwIayumOgu5gl+W0Mza+HDt/FWsgx51t129a4qRHmS
 /4WKSe7eadFq9JQZDzFkk251+Agz/sVF4PGgaZ3OGLsqZYI+S+ajb6JOlOuoJChlvdZ3WO1BkkO
 bgInUiyprKkLrT0zCw4NuCoJB2fIU54RGGuujNvm1Hs+GSIU2eUaNYQht2iVgkOH3hS6U0QsDSH
 VnWqiwQRgiHAwGZSDEfOppXHhaj76uh/DI2vQgJ95WoN8+O93dCwlqIxDXFF4gcR00WB5W4tiJk
 mYgBGcdcoJsg==
X-Google-Smtp-Source: AGHT+IFKQA5ZXG7UX01mOjeiJmp4dpx3VYKO3DNZdLLLwO4Qe1HYbS88Q/wxwcOmVMLRjWPQerwatQ==
X-Received: by 2002:a05:6000:230c:b0:3d0:64c1:1a40 with SMTP id
 ffacd0b85a97d-3e64374116cmr11500435f8f.46.1757487785858; 
 Wed, 10 Sep 2025 00:03:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2?
 ([2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223f188sm5499000f8f.48.2025.09.10.00.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 00:03:05 -0700 (PDT)
Message-ID: <12661062-d02e-41aa-aa57-d83c05688d7f@linaro.org>
Date: Wed, 10 Sep 2025 09:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 9/9] doc: board: amlogic: add u-boot-spl documentation
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
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

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Add building and usage instructions for SPL.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   doc/board/amlogic/index.rst             |  1 +
>   doc/board/amlogic/pre-generated-fip.rst |  9 ++++
>   doc/board/amlogic/spl.rst               | 77 +++++++++++++++++++++++++++++++++
>   3 files changed, 87 insertions(+)
> 
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index dcd935224ac0280a77455e3475a610fd81cfb80d..23380ac33f2b06efff7d4741ce2967d75671ca13 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -78,6 +78,7 @@ Boot Documentation
>   
>      boot-flow
>      pre-generated-fip
> +   spl
>   
>   Board Documentation
>   -------------------
> diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
> index 6a43d776d43f35cbffc7ba9e72bf05dd719f6387..d820bd09115952d4fca2b9e7d7b5a9e30bd11430 100644
> --- a/doc/board/amlogic/pre-generated-fip.rst
> +++ b/doc/board/amlogic/pre-generated-fip.rst
> @@ -98,6 +98,13 @@ The repo also provides the following files used with GXBB boards:
>   The repo also supports the open-source 'gxlimg' signing tool that can be used to sign
>   U-Boot binaries for GXL/GXM/G12A/G12B/SM1 boards: https://github.com/repk/gxlimg
>   
> +The following binaries can be replaced with open-source implementations:
> +
> +- bl2.bin (GXBB and GXL only)
> +- bl31.img (GXBB, GXL, AXG and G12A only)
> +
> +Refer to `Experimental U-Boot SPL Support`_ if you wish to replace them.
> +
>   Licensing
>   ---------
>   
> @@ -129,3 +136,5 @@ clarified. The current Amlogic distribution licence is below:
>       // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>       // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>       // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> +
> +.. _`Experimental U-Boot SPL Support`: spl.rst
> diff --git a/doc/board/amlogic/spl.rst b/doc/board/amlogic/spl.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..39d50e3da87d71f62cec1903c441c334bf7020e8
> --- /dev/null
> +++ b/doc/board/amlogic/spl.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Experimental U-Boot SPL Support
> +===============================
> +
> +There's some experimental support for some Amlogic SoCs, in U-Boot SPL.  It
> +replaces the proprietary bl2.bin blob used for DRAM init.  Currently Meson GX
> +SoCs (GXBB, GXL) are supported.
> +
> +A subset of Amlogic boards have SPL enabled.  These boards have been tested and
> +known to work to an extent.
> +
> +
> +Building Arm Trusted Firmware (TF-A)
> +------------------------------------
> +
> +This U-Boot SPL port requires the BL31 stage of mainline Arm Trusted
> +Firmware-A firmware. It provides an open source implementation of secure
> +software for Armv8-A. Build it with:
> +
> +.. code-block:: bash
> +
> +    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> +    $ cd trusted-firmware-a
> +    $ make CROSS_COMPILE=aarch64-linux-gnu- PLAT=your_soc DEBUG=1
> +
> +Replace ``your_soc`` with the SoC target you wish to build for. For GXBB it's
> +``gxbb`` and for GXL it's ``gxl``.
> +
> +
> +Building a bl30_new.bin binary
> +------------------------------
> +
> +``bl30_new.bin`` has both ``bl30.bin`` and ``bl301.bin`` binary blobs
> +bundled. The former is the proper system control processor firmware and the
> +latter is a "plug-in" for board-specific DVFS/suspend-resume parameters. For
> +more info you may wish to read this page: `Pre-Generated FIP File Repo`_.
> +
> +To build using the FIP file repo, simply issue the following commands:
> +
> +.. code-block:: bash
> +
> +    $ cd amlogic-boot-fip/your_board
> +    $ make bl30_new.bin
> +
> +
> +.. _`Pre-Generated FIP File Repo`: pre-generated-fip.rst
> +
> +
> +U-Boot compilation
> +------------------
> +
> +U-Boot SPL is not enabled by default, instead there are config fragments that
> +can be used to enable it, with per-board configuration:
> +
> +- ``spl-libretech-cc-1gb.config``: 1 GB LePotato board
> +- ``spl-libretech-cc-2gb.config``: 2 GB LePotato board
> +- ``spl-odroid-c2.config``: ODROID-C2
> +- ``spl-videostrong-kii-pro.config``: Videostrong KII Pro
> +
> +Pick one of them then:
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-linux-gnu-
> +    $ export BL31=path/to/tf-a/bl31.bin                 # Upstream TF-A BL31 binary
> +    $ export SCP=path/to/bl30_new.bin                   # bl30_new.bin binary
> +    $ make <yourboardname>_defconfig spl-<yourboardname>.config
> +    $ make
> +
> +Write to SD:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=u-boot-meson-with-spl.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
> +
> 

It's very nice :-)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
