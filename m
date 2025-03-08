Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B7BC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 07:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134DD8058A;
	Sat,  8 Mar 2025 08:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wci/hzFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD14808A2; Sat,  8 Mar 2025 08:51:19 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBA38043C
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 08:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so2205090276.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 23:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741420275; x=1742025075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+X3DJZRv+6IabXf5nGGPvbrpB3MlPQZMZ92z44wsI0=;
 b=Wci/hzFB8hByjQ3ZuxFH0q3LFZNNsD0rMR6AY/kWOQS2M1+Pc8KvQmqN3wZiEcc5FX
 CtTWdoLrJrBjUpbQ0DHseFp6vFMT5ZPtO6k4dpt4whESwcrgHHWH3/Kc/UiIgR2xNRDK
 I1I/sknYGWY6MykFtvz2tDR6UZTSzn3Fr1RBnpP1Z2d9qzY/EZ62ikoOPq12LbdBupXy
 RvotIhzhSmoKaH0/NqXTAFCrDo0c4Prmfdj+5cB9VPTlEZMA0uoZfKuBoMcXLH1Ng+FF
 suh5GeVTe3YXu8pURy712R8L5VzpnnMKnTUR7sGZR4c16LUXIrYECeJA4/mYMETLL09j
 KkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741420275; x=1742025075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+X3DJZRv+6IabXf5nGGPvbrpB3MlPQZMZ92z44wsI0=;
 b=j4vsPDGZhecueLcnc8LsHlpyThNJYcw3NNSyKz0b7o2zS8I/1XidS3iamNZIWi2a9M
 E/fjO/y1y8HI7Z5Fs+zwTjJJJ7nIIcaZfE5BVNljgWsfGL+4DeAxxYNvbxj32HTHXJ4R
 de1yavplz1h1uU1UZhwrLIxTVs8hZEHKT33wkT2Qlp6xTV+ceaggBXFxvyyIY/xHYJpB
 SrDWjZRDty3wdgLDlh9BXjDrB9yPjgvjQ12sJtUN+CfTyGtwMBo0t93bmSkoxaQyRoRD
 GyV+A4R4QC5l9BCbK0J+Bz0Z5G49LO2rKnWFHCIgHZ2cbZU0rcNtiwNphJj/MWEIZYyc
 5yIQ==
X-Gm-Message-State: AOJu0YxAiP1uojeeshXonY1nBvZvR6Su3Ek6NmdDqUpjBc/gnTiqeJz3
 F9TKS8fpD5LZAfDvjB2pk/ssPfO8ogfQYUVhXkwLWmwBZymijvAn+5hgD/i55zz3vmYiPBhnoAO
 QT1+Dh6VJmcGFiee5ufoPL20Of5Vb28kFZRtD1g==
X-Gm-Gg: ASbGncs09SCt5b9qSecOP79ckGky1mYBImH4fljnueXUC0Hk6bYW0E4yp7PCTm3NXDF
 HPapUR8yluo9MvqXae2AJYmOOJT4HplOMLFRVSAy/DKjPzbwI40mOJgD4HRKlHz638Ziq0AFxFd
 2RS4GONsWvtiwQxvZRSH9JDUiU494=
X-Google-Smtp-Source: AGHT+IHD4gNmRlbfrC5i3GjAzTeyo72/9q/TqT0/IUeBA+H4rFKCUmWq1+bua5g+YKTg1VIC7jX0A5yVD+mUmspdeyI=
X-Received: by 2002:a05:6902:842:b0:e63:199a:efd5 with SMTP id
 3f1490d57ef6-e635c17882amr8445318276.24.1741420275494; Fri, 07 Mar 2025
 23:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20250306143224.3080316-1-jerome.forissier@linaro.org>
 <20250306143224.3080316-2-jerome.forissier@linaro.org>
In-Reply-To: <20250306143224.3080316-2-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 8 Mar 2025 09:50:39 +0200
X-Gm-Features: AQ5f1JpvwGfuquZ9xdyWNsytnJCF6E4CR7xYaI2aYenM-6CnO5bEYJbKmztPhJA
Message-ID: <CAC_iWjLfFjj5FxthbLE1G4s0NV_kkQOEPcnYYNi=eRPY56hd5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: lwip: rename linkoutput() as net_lwip_tx()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Thu, 6 Mar 2025 at 16:32, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Rename static function linkoutput() as net_lwip_tx() for consistency
> with net_lwip_rx().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/net-lwip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index cab1dd7d483..5a2a86686f4 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -30,7 +30,7 @@ char *pxelinux_configfile;
>  struct in_addr net_ip;
>  char net_boot_file_name[1024];
>
> -static err_t linkoutput(struct netif *netif, struct pbuf *p)
> +static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
>  {
>         struct udevice *udev = netif->state;
>         void *pp = NULL;
> @@ -60,7 +60,7 @@ static err_t linkoutput(struct netif *netif, struct pbuf *p)
>  static err_t net_lwip_if_init(struct netif *netif)
>  {
>         netif->output = etharp_output;
> -       netif->linkoutput = linkoutput;
> +       netif->linkoutput = net_lwip_tx;
>         netif->mtu = 1500;
>         netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
