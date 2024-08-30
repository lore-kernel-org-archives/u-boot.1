Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E68CA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5175988D4D;
	Fri, 30 Aug 2024 03:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSfC9mSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C835588D33; Fri, 30 Aug 2024 03:06:22 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9197388D39
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf8a662467so7069116d6.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979979; x=1725584779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HOFwzpc8N8OZRWS+gF1Du0IcdPB10xdYvBC7PiSZpHM=;
 b=lSfC9mSDRZmerag2KeEVIDF5yYoMJDo33aOdR/cKjLnbhbgg9NhM8709nZjp4KYIq5
 nifXnTKLKXc0/A9JebEUysH5oN7wdxbmm5cyWibUYSK3g8bGLN1dAKzYobWPV5DUlP4Z
 Ue4yiBAW8bCCSk8G1BOqh1OA4bY7qv9v+fO3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979979; x=1725584779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOFwzpc8N8OZRWS+gF1Du0IcdPB10xdYvBC7PiSZpHM=;
 b=l3IgtCTxjyrytPyE5jT+/jt1ErgBVFm0wE8LUpldX/gYuVh1mz/jh8QZyWX7A///S2
 n93HJhHQUtHzHN1hmLve+TxifQchCjv7ic5iaYfaXfALGzyo1DOkbgwrSM1crtjq19RN
 5jDK865C9Kw8274BUDZ0+4b32XjNMxp7B2KmC8xyC/CHIhmObhIBza422gtvBcKgHs6Y
 wnuEv/AEWAEJecxA6F1PhlW5OJVoBx2eKG+r2mEtnD/7UXGjFkrVpo+m2YtVqqJQTcCC
 hpEO6YDEIPyNNa8PKcv2jJk47vZz9kzDe5EFu5joGqPvIv+2bgW5wLroOqkPaEKDrJwB
 x1rw==
X-Gm-Message-State: AOJu0YyH7sMTprE4+8g5HSJKVZEhqpcZNqrkToXr4nuA5DYhQS49inz1
 LZ3E9tPUafVtGucJrgMF0OlQmAoD2xwGgx4pPnX4o+0vPhTNRbP7VRHU3RJ2zpK2AHEkmf84rWu
 hPKV4e6pCrOWur2yV1it6h0wDXethaLLPZpL0
X-Google-Smtp-Source: AGHT+IFrflwpMkgINIBUmjQ+hjGTi39BZSgNApyoPRxwMLwa29wSx9q5u/9AxTEKrnLmwvYGTwM7YxfVzy++S8DcMbM=
X-Received: by 2002:a05:6214:5882:b0:6c1:6bae:b5c2 with SMTP id
 6a1803df08f44-6c33e6a252emr45011796d6.51.1724979979426; Thu, 29 Aug 2024
 18:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240829185602.3179812-1-trini@konsulko.com>
 <20240829185602.3179812-2-trini@konsulko.com>
In-Reply-To: <20240829185602.3179812-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:08 -0600
Message-ID: <CAFLszTjpvG_0kmTK1ytSU-k6ZVFtH50WXEs0UQuK3F=1GPTfCw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks][PATCH 2/2] bin/flashair.rpi: Use kernel= and
 simplify logic
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 29 Aug 2024 at 12:56, Tom Rini <trini@konsulko.com> wrote:
>
> Rather than guess what we need to name our u-boot.bin file as for it to
> boot make use of the kernel= option to always call it u-boot.bin and
> then on 64bit platforms (and since future platforms use rpi_arm64 this
> list should not grow) also pass in arm_64bit=1.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  bin/flashair.rpi | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/bin/flashair.rpi b/bin/flashair.rpi
> index 874c41f76a07..2c2756c73087 100644
> --- a/bin/flashair.rpi
> +++ b/bin/flashair.rpi
> @@ -27,34 +27,18 @@
>  # ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
>  # POSSIBILITY OF SUCH DAMAGE.
>
> -flashair_rmlist=`mktemp`
> -
> -case "${board_type}" in
> -rpi)
> -    kernel_dst=kernel.img
> -    ;;
> -rpi_2)
> -    kernel_dst=kernel7.img
> -    ;;
> -rpi_3)
> -    kernel_dst=kernel8.img
> -    ;;
> -rpi_3_32b)
> -    kernel_dst=kernel8-32.img
> -    ;;
> -*)
> -    echo Unknown Pi \""${board_type}"\"
> -    exit 1
> -    ;;
> -esac
> -
> -echo 'kern*.img' > "${flashair_rmlist}"
> -
> -cp "${U_BOOT_BUILD_DIR}"/u-boot.bin "${UL_DIR}"/"${kernel_dst}"
> +cp "${U_BOOT_BUILD_DIR}"/u-boot.bin "${UL_DIR}"/u-boot.bin
>
>  touch "${UL_DIR}/config.txt"
>
>  echo "enable_uart=1" >> "${UL_DIR}/config.txt"
> +echo "kernel=u-boot.bin" >> "${UL_DIR}/config.txt"
> +
> +case "${board_type}" in
> +rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
> +    echo "arm_64bit=1" >> "${UL_DIR}/config.txt"
> +    ;;
> +esac
>
>  case "${board_ident}" in
>  3-32-pl011)
> --
> 2.34.1
>
