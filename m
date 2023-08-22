Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCB8EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28B086511;
	Tue, 22 Aug 2023 20:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AQRydb7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B2A855CE; Tue, 22 Aug 2023 20:58:07 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5299A864E8
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d678b44d1f3so6552033276.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4KNZ9nLiFULt94rr1R8vo/MYgsZN4GhSE4AmpaYsdCc=;
 b=AQRydb7SusOkWWfxJH3qP6tajZPwSIbNeTsVpYEp5anYakkGru6+HiaeQQm6ngrX26
 +WfoS2XAiNi3xk1TZlykcnpbw8R1eT5zYsm/xc0tr6wK+dct0VhK7hRn9Tk+J7biugGL
 j76pGuWqdjJQd6xm/pRJnwTFkTC66aHBIDv2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4KNZ9nLiFULt94rr1R8vo/MYgsZN4GhSE4AmpaYsdCc=;
 b=gH34Ymffj+sJjgxUFltebHRvWiu1/L9Oy7SPLfV7rGZPsNWTTcgy3RwaPoZdVY3ZTI
 1cRZ2WIr+prAZrmA7/2NqsJghzkrsmgV2ZwyVkIeGz1F6yIaHCLIvTCeqyG738ndJg0r
 eO+/fATYJZOV/wWVPaIKejjVIg/CoVKN4RYx169KSf/4CNLemSqN/RDP8TaH9EoF0cYw
 RqWK3+v9736oycPuDRJjAD1z0/BxYnbt11HUqtHm1+Dr1a7rCi5CzQ63T2LDzYtV4MST
 Pfau3fmzJn4euRQRbEDMp+AUTKmvuxpUO12l8YnYqzZ6QsDvZdiT75G8qJXYPv6QejiV
 ifvg==
X-Gm-Message-State: AOJu0YxQ/5RjYCymBe7KY0xOGh4rxg3KLaBMgfvpJioRCwxtB76WJ+1Q
 FGDHNEOYJMCoxzCozzeNnlyG4vxEYgdupjOV7s4gRw==
X-Google-Smtp-Source: AGHT+IG+brhCKHh9L3EvSqwtXO9ydCwsfzcKB4ApDhQKz5a/3+TJ06hn5iDwvFZwz3ArhPfDSeLK8y+jbShnNgXYR90=
X-Received: by 2002:a25:ace6:0:b0:d71:f3bf:d5f with SMTP id
 x38-20020a25ace6000000b00d71f3bf0d5fmr8867097ybd.5.1692730678853; Tue, 22 Aug
 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-2-maxim.uvarov@linaro.org>
In-Reply-To: <20230822093614.4717-2-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:41 -0600
Message-ID: <CAPnjgZ1vFQbh2sYRPjyeDBSh5kRKZ6q0Mf=kQU+F8vyy=U5CEQ@mail.gmail.com>
Subject: Re: [PATCHv7 01/15] net/lwip: add doc/develop/net_lwip.rst
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

Hi Maxim,

On Tue, 22 Aug 2023 at 03:38, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> Add initial documentation of lwIP network IP stack integration
> to the U-Boot (net_lwip.rst).
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/index.rst    |  1 +
>  doc/develop/net_lwip.rst | 76 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 doc/develop/net_lwip.rst
>
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index 5b230d0321..4764990f25 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -48,6 +48,7 @@ Implementation
>     spl
>     falcon
>     uefi/index
> +   net_lwip
>     vbe
>     version
>
> diff --git a/doc/develop/net_lwip.rst b/doc/develop/net_lwip.rst
> new file mode 100644
> index 0000000000..cd85de92a1
> --- /dev/null
> +++ b/doc/develop/net_lwip.rst
> @@ -0,0 +1,76 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +LWIP IP stack intergation for U-Boot

spelling

> +====================================
> +
> +Intro
> +-----
> +
> +LWIP is a library implementing network protocols, which is commonly used
> +on embedded devices.
> +
> +https://savannah.nongnu.org/projects/lwip/
> +
> +LwIP  license:
> +LwIP is licensed under a BSD-style license: http://lwip.wikia.com/wiki/License.
> +
> +Main features include:
> +
> +* Protocols: IP, IPv6, ICMP, ND, MLD, UDP, TCP, IGMP, ARP, PPPoS, PPPoE
> +
> +* DHCP client, DNS client (incl. mDNS hostname resolver),
> +  AutoIP/APIPA (Zeroconf), SNMP agent (v1, v2c, v3, private MIB support
> +  & MIB compiler)
> +
> +* APIs: specialized APIs for enhanced performance, optional Berkeley-alike
> +  socket API
> +
> +* Extended features: IP forwarding over multiple network interfaces, TCP
> +  congestion control, RTT estimation and fast recovery/fast retransmit
> +
> +* Addon applications: HTTP(S) server, SNTP client, SMTP(S) client, ping,
> +  NetBIOS nameserver, mDNS responder, MQTT client, TFTP server
> +
> +U-Boot implementation details
> +-----------------------------
> +
> +1. In general we can build lwIP as a library and link it against U-Boot or
> +   compile it in the U-Boot tree in the same way as other U-Boot files. There
> +   are few reasons why second variant was selected: lwIP is very customizable
> +   with defines for features, memory size, types of allocation, some internal
> +   types and platform specific code. It turned out easier to enable/disable
> +   debug which is also done with defines, and is needed periodically.
> +
> +2. lwIP has 2 APIs - raw mode and sequential (as lwIP names it, or socket API
> +   as we name it in Linux). For now only raw API is supported.
> +
> +In raw IP mode a callback function for RX path is registered and will be called
> +when packet is passed to the IP stack and is ready for the application.
> +
> +One example is the unmodified working ping example from lwip sources which
> +registered the callback:
> +
> +.. code-block:: c
> +
> +        ping_pcb = raw_new(IP_PROTO_ICMP);
> +        raw_recv(ping_pcb, ping_recv, NULL); <- ping_recv is app callback.
> +        raw_bind(ping_pcb, IP_ADDR_ANY)
> +
> +3.  Input and output
> +
> +RX packet path is injected to U-Boot eth_rx() polling loop and TX patch is in
> +eth_send() accordingly. That way we can leave the driver code unmodified and
> +consume packets once they are ready. So we do not touch any drivers code and
> +just eat packets when they are ready.
> +
> +U-Boot lwIP Applications
> +========================
> +
> +.. kernel-doc:: include/net/lwip.h
> +   :internal:
> +
> +lwIP API to control polling loop
> +================================
> +
> +.. kernel-doc:: include/net/ulwip.h
> +   :internal:
> --
> 2.30.2
>

Regards,
Simon
