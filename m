Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4888FD68B29
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A243E89601;
	Thu, 14 Nov 2024 15:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zfafkAgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9E3895F1; Thu, 14 Nov 2024 15:32:24 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7AE89601
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so510986b3a.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594739; x=1732199539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yTuSqy0KPiomJJnU+NVk0XtiUoIe1zsMpgfclIWPbmk=;
 b=zfafkAgvahCOGAdU5vVhvgHrWVDG88pOtSIHAC3DnANdmT4jRO/n9hPJvRhj9a8gXf
 OUTlGuByermFwtA4UG1PYE7JD4/p0OhPppYn5cS5w15QZkft53I36+wfiTauGiax4sps
 wF+4ZPhFJhJrHJxZxGZR+y/oTA5rYdCNUten7cU5TrIXtnUxzY22+67T+COAW5Sw3h/7
 FMRv7v1RrMAcK2s5hhb4ick57zJN0RvSo1vbN8eVXS+uwQpkvPgnIpCU+tKSIDvkkBnP
 zgbgsETt7/z/JeAVZeLSoBUW3S98ED5AUVX/ZnBecceaKjoZ6nmz43YCJPu3/bln7ja3
 NsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594739; x=1732199539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yTuSqy0KPiomJJnU+NVk0XtiUoIe1zsMpgfclIWPbmk=;
 b=AcEySRZxOysSNOq1QTotDbP/v6jMrB+lwi3x7TQLTCR6sy1nq/MKzjbquc5OVyfAa3
 5lb0TDDyWKL3FZI5xd82Z5vdPSJhg4ap/zYyYwL8n1mclTBKreZ+MmkABqojWfVPR4z1
 RAWIGT90EiVLM6MAq3mzIB56pQHZeKoK5XAxWEzhjdI54Q6gUsSDac4V24Lss5+/sCc5
 GioY68onDCXS5ccIWUTfWgK/FP2wYLR5y9htAP60ctq1ZU6dW5x+dJgUMMiWeS+Mqh1s
 pMWWZGdbNtbf+Sl9HIytsQpGhxT/zMlCzFhdHd+YTc/EI8TqDUjvE3AKyHJdFWmDVZOg
 VZOg==
X-Gm-Message-State: AOJu0Ywy1m9InHKSqKZctP23mNGQzEQp4UzaiqRzHu8xZl6kd2mCrVhb
 icx8Ur57oB47rh8PLfsiLxyMVcwQpnimjckvqduJ/Pwp8Ulhj3E5+5WNDrYmzhLsTO9msFKbPIG
 py/a1jd5+6y5Vq5nIWG2HWNBdnZS4LY9GuUOqJA==
X-Google-Smtp-Source: AGHT+IEzKhUxohcMXk9VYGQ9GZBIX1B10Ec/UUDqcfEK0ggfT8PcydZVY5LzSJZ+TtA3PzMEl1yRpz+VJZgkVYwPRT8=
X-Received: by 2002:a05:6a00:90a4:b0:724:6aa0:90ef with SMTP id
 d2e1a72fcca58-7246aa09305mr3788407b3a.11.1731594738844; Thu, 14 Nov 2024
 06:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20241114142004.2051240-1-jerome.forissier@linaro.org>
In-Reply-To: <20241114142004.2051240-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Nov 2024 16:31:42 +0200
Message-ID: <CAC_iWjL5Uedu+2DnibFBXJveB3qckLUKUwY4B-s1D+Lup-fwkQ@mail.gmail.com>
Subject: Re: [PATCH] doc: cmd: wget: document lwIP syntax
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jerome

+CC Simon, since he asked for an update on the docs

On Thu, 14 Nov 2024 at 16:20, Jerome Forissier <jerome.forissier@linaro.org>
wrote:

> The lwIP version of wget supports a different syntax with a URL,
> in addition to the legacy syntax. Document that.
>
> While we're at it, fix a couple of minor issues in the legacy
> syntax:
> - hostIPaddr can be an IP address or a DNS name
> - path is mandatory
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  doc/usage/cmd/wget.rst | 71 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 11 deletions(-)
>
> diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
> index b8ca35bb140..5be01a22e47 100644
> --- a/doc/usage/cmd/wget.rst
> +++ b/doc/usage/cmd/wget.rst
> @@ -11,29 +11,51 @@ Synopsis
>
>  ::
>
> -    wget address [[hostIPaddr:]path]
> +    wget [address] [host:]path
> +    wget [address] url          # lwIP only
> +
>
>  Description
>  -----------
>
> -The wget command is used to download a file from an HTTP server.
> +The wget command is used to download a file from an HTTP(S) server.
> +In order to use HTTPS you will need to compile wget with lwIP support.
> +
> +Legacy syntax
> +~~~~~~~~~~~~~
> +
> +The legacy syntax is supported with the legacy network stack as well as
> +lwIP. It allows only HTTP.
>
> -wget command will use HTTP over TCP to download files from an HTTP server.
>  By default the destination port is 80 and the source port is
> pseudo-random.
> -The environment variable *httpdstp* can be used to set the destination
> port.
> +The environment variable *httpdstp* can be used to set the destination
> port
> +(legacy nework stack only).
>
>  address
>      memory address for the data downloaded
>
> -hostIPaddr
> -    IP address of the HTTP server, defaults to the value of environment
> -    variable *serverip*
> +host
> +    IP address or DNS name of the HTTP server, defaults to the value of
> +    environment variable *serverip*.
>
>  path
>      path of the file to be downloaded.
>
> -Example
> --------
> +
> +New syntax (lwIP only)
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +In addition to the syntax described above, wget accepts URLs if the
> network
> +stack is lwIP.
> +
> +address
> +    memory address for the data downloaded
> +
> +url
> +    HTTP or HTTPS URL, that is: http[s]://<host>[:<port>]/<path>.
> +
> +Example with the legacy network stack
> +-------------------------------------
>
>  In the example the following steps are executed:
>
> @@ -52,13 +74,40 @@ In the example the following steps are executed:
>      HTTP/1.0 302 Found
>      Packets received 4, Transfer Successful
>
> +Example with lwIP
> +-----------------
> +
> +In the example the following steps are executed:
> +
> +* setup client network address
> +* download a file from the HTTPS server
> +
> +::
> +
> +   => dhcp
> +   DHCP client bound to address 10.0.2.15 (3 ms)
> +   => wget
> https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.4-aarch64-minimal.iso
> +
>  ##########################################################################
> +
>  ##########################################################################
> +
>  ##########################################################################
> +   [...]
> +   1694892032 bytes transferred in 492181 ms (3.3 MiB/s)
> +   Bytes transferred = 1694892032 (65060000 hex)
> +
>  Configuration
>  -------------
>
>  The command is only available if CONFIG_CMD_WGET=y.
> +To enable lwIP support set CONFIG_NET_LWIP=y.
>
> -TCP Selective Acknowledgments can be enabled via CONFIG_PROT_TCP_SACK=y.
> -This will improve the download speed.
> +TCP Selective Acknowledgments in the legacy network stack can be enabled
> via
> +CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
> +Acknowledgments are enabled by default with lwIP.
> +
> +**Note**: U-Boot currently has no way to verify certificates for HTTPS.
> +A place to store the root CA certificates is needed, and then MBed TLS
> would
> +need to walk the entire chain. Therefore, man-in-the middle attacks are
> +possible and HTTPS should not be relied upon for payload authentication.
>
>  Return value
>  ------------
> --
> 2.40.1
>
>
 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
