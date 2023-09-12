Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A25CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 07:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF45B86D70;
	Tue, 12 Sep 2023 09:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xWBgth7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17EC286D80; Tue, 12 Sep 2023 09:41:06 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B157B86D59
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 09:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31f915c3c42so2730500f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694504462; x=1695109262; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rh/T5Cv4YPdCYQZ1/sNbl2qb3cDg3abKm+HK0nRaTtA=;
 b=xWBgth7IlUcpZCB3QEgT2MLSVZxWUOPYI5sXUb24TNlTC+NbFlEqlOrSvbFIV4kq+p
 BjQIe9A4RTxR5DZfOCjJ6KXNDMR2TDpSI78ucQo6+13/r5pEWbY5FrxDidlCVYE9IDNa
 Kzn9uKzckHM1CvvQOoX/SdqePItqEMgWdZXOPTHnphJ3Xkuc96l6sn4pglz4FwUuyRdX
 EgOy47DfQSWnE6VqOjKWTxCCepX1F4c9PjYJzKW+h10KFcBedkvrThoIMEXzufK9O0rZ
 ueWPOeJ2fafw7ZlbfUxWI2TBgbdsn7zeZGnJqDE2Q9ysxE3tB83B83Fd5MRbyKW83fL9
 TTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694504462; x=1695109262;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rh/T5Cv4YPdCYQZ1/sNbl2qb3cDg3abKm+HK0nRaTtA=;
 b=BxS5pwuRhyitikhhcLhu36B6cmZMma7EKa/5JZHNPzuTCFqZjcwnOb5du/OOmYnG8p
 hlA4e1PxAdYax4ibKF2Ke6u3cTor53P/KMqoKBDNoyPNEtWnka28Y60Fe5TIAw/jE+eB
 KAxQU/tvypplI0gOZt/9kPyvi9BQzQq+/7sBt6zrsbXmsPU0p0qriloyL6/BUKN/UoXY
 XP7E13YjjUS01kd2y4AFrjQyNhf3EK4Hy8ymh9wMLeu2pE3H++sDCdnw+vW8w07aCB2r
 M6hvdCqrE1sZcWZlrAhjDjPqpR3GIRo4t91gWSAV0XCfwaWM+Dx3M8AgSlLKIHIZNw/J
 cYNg==
X-Gm-Message-State: AOJu0YwHVx5nL01bpiTQ3XyHwDab/6M7RRwbebFmvn7VBCIa8fUxG3lX
 2lqrnWSftgpBCW0PY3w/qza6Ag==
X-Google-Smtp-Source: AGHT+IGIqP4pRmj1b8HmuySdsr3C4NEKZlcu9wOdehbFBF5mY7tLZpzGvUjxURIxIGSxpLG/PwOBnw==
X-Received: by 2002:a05:6000:710:b0:31f:882b:ea02 with SMTP id
 bs16-20020a056000071000b0031f882bea02mr7089216wrb.29.1694504462078; 
 Tue, 12 Sep 2023 00:41:02 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a5d6152000000b0031f3780ce60sm12181896wrt.7.2023.09.12.00.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:41:01 -0700 (PDT)
Date: Tue, 12 Sep 2023 10:40:59 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCHv8 01/15] net/lwip: add doc/develop/net_lwip.rst
Message-ID: <ZQAWCzDN2dGLq2FK@hades>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-2-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908135320.7066-2-maxim.uvarov@linaro.org>
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

On Fri, Sep 08, 2023 at 07:53:06PM +0600, Maxim Uvarov wrote:
> Add initial documentation of lwIP network IP stack integration
> to the U-Boot (net_lwip.rst).
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/index.rst    |  1 +
>  doc/develop/net_lwip.rst | 75 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
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
> index 0000000000..a77ab60d0f
> --- /dev/null
> +++ b/doc/develop/net_lwip.rst
> @@ -0,0 +1,75 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +lwIP IP stack integration for U-Boot
> +====================================
> +
> +Intro
> +-----
> +
> +lwIP is a library implementing network protocols, which is commonly used
> +on embedded devices.
> +
> +https://savannah.nongnu.org/projects/lwip/
> +lwIP  license:
> +lwIP is licensed under a BSD-style license: http://lwip.wikia.com/wiki/License.
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
> +3.  Input and output
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

