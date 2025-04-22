Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A1C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 12:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE72280FF7;
	Tue, 22 Apr 2025 14:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c+cLepog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36DA281273; Tue, 22 Apr 2025 14:09:24 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010C480FEC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so683968766b.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745323760; x=1745928560; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDWR9fuWtm2QvquaXjAxvC83tiAdDrSHeEZqpDGNdys=;
 b=c+cLepog2TTCmQfQt/yTqomb+PrXicca3LPqxSiy4oZCykR45lMbVO5WdAdc5vBCY3
 ibjy3K2vUXb9JSB5gwK9yK8rS+V21roHkLYkFmYkNP4E5q9mKzY9qVCIAMBKPBPRZwK5
 Kv0ADxNSxIJtzgDv+EdlFK2hpfQ96e4qTVPozILQ4JZIjiVFZ/HajoBihW3fSOV4X2cr
 LJDl1JmTqVHZo6HHm3nkdsDCb+Pxxx57mOeuKwPLVGBYHWxNvxiTE/gRqyFH12ohuKKa
 ny2qgW43MswgErELxntAXXPA5h0SeL0LRXLEmizW0LaJRhyEpdq73/x5EN9XX7R7D1BI
 nnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745323760; x=1745928560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDWR9fuWtm2QvquaXjAxvC83tiAdDrSHeEZqpDGNdys=;
 b=fzGStL8HR9OuiKxsNnfa6+vgde16nfolpVH3deomKMHAD7OdCrRU/kV03vvzXFq4rW
 q8Qv9mLZN1CuS3uA7awdD8dj9CrwoNS1twKAH4+cdXbNeyw7Jmm/7eCqup1nhBu8Y6ry
 T/ZBZEN8x0f5ecQPX9GafsIIvdQU3PBC5BduZZWebV75R8cTyL8qF7qcCQlYFXXD/JjL
 tm5m0IDaJD4enBPks9O4gnPgC5mK1oKq9+sdjOgIqMg5hfvpj2D2soduMLVHsZ294BpI
 r57HDZ6wxJb97kyYqngfwfFg9UqIdfrVfn2gFyTjvJ7WkFfo2ea6jtNxLMHZj8fy4C0F
 6YFg==
X-Gm-Message-State: AOJu0Yx/HBSaGp1EFT3vODCB9fa1IFo4VVfFJtM2shYL8wAJ3ESwilAt
 x+pKIWV+YyXO1A8V9CQk+b2PvipvCwlg7ilCkbIiUsT6O71XYzwCTLX8HjElDDMheSjGnW6cTwX
 viIf5YPy/L95pmGuMjt8xdHHq7NzmbvTSRXHi+Q==
X-Gm-Gg: ASbGncta6G5gmaJsKYGHmmignns8M9ZHaxxVLW/8oIEylqT8P+qEuIwF6KqVQHgqxi9
 zODEtdc9YjskFKPC4EfuzhFChraQoDRxrzcr8tx/Me0+EIY/WtvCrZJrpQxYdGytPX84Pcg0XAl
 gy+v88DxbwTc4rRmgnqvV1fQ==
X-Google-Smtp-Source: AGHT+IGBLFux/P9H3kHSRi9RbzKSlvGoUQ++Q0y9uN1im6i8+XSeDsPDueO4TBVT2XyLhXt9pb9K9xWFqJMZIzmpf6E=
X-Received: by 2002:a17:906:4fcc:b0:ac7:16eb:8499 with SMTP id
 a640c23a62f3a-acb74abf442mr1375371166b.5.1745323759762; Tue, 22 Apr 2025
 05:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <17f988b0-787f-469b-8602-e324e0eae8d7@gmx.de>
In-Reply-To: <17f988b0-787f-469b-8602-e324e0eae8d7@gmx.de>
From: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome.forissier@linaro.org>
Date: Tue, 22 Apr 2025 14:09:08 +0200
X-Gm-Features: ATxdqUHzjn76g_hW1afq74gXfVvFHRccQOwGZI1yIaeUtlRYE7cthcQWfFT59rs
Message-ID: <CA+NB=mYLdD_PYgUsH_50E5vLakqJbjEYLq0vPWjU=dzv3cNgKQ@mail.gmail.com>
Subject: Re: NET_LWIP breaks common/log_syslog.c
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Tue, 22 Apr 2025 at 05:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> Hello Jerome,
>
> I am trying to compile with CONFIG_LOG_SYSLOG=3Dy and CONFIG_NET_LWIP=3Dy
> and get:
>
> common/log_syslog.c: In function =E2=80=98log_syslog_emit=E2=80=99:
> common/log_syslog.c:59:24: error: implicit declaration of function
> =E2=80=98net_set_ether=E2=80=99; did you mean =E2=80=98env_set_hex=E2=80=
=99?
> [-Wimplicit-function-declaration]
>     59 |         eth_hdr_size =3D net_set_ether((uchar *)ptr,
> net_bcast_ethaddr, PROT_IP);
>        |                        ^~~~~~~~~~~~~
>        |                        env_set_hex
> common/log_syslog.c:102:9: error: implicit declaration of function
> =E2=80=98net_set_udp_header=E2=80=99 [-Wimplicit-function-declaration]
>    102 |         net_set_udp_header((uchar *)iphdr, bcast_ip, 514, 514,
> ptr - log_msg);
>        |         ^~~~~~~~~~~~~~~~~~
>
> As these function just prepare packet buffers, should they be moved to
> common code used both for the legacy and the new network stack?

Doing so may not be the best option, since it will be pulling a few more gl=
obals
we don't have (and don't want) with NET_LWIP: net_our_vlan, net_native_vlan=
,
net_ethaddr... I believe the best course of action is to rewrite
log_syslog_emit()
to use the lwIP UDP API when NET_LWIP is enabled. It should not be too hard=
.
Something like that:

struct pbuf *p;
struct netif *netif;

netif =3D net_lwip_new_netif(eth_get_dev());
pcb =3D udp_new();
udp_bind_netif(pcb, netif);
udp_bind(pcb, ip, src_port); /* maybe not needed if src_port doesn't matter=
 */
p =3D pbuf_alloc(PBUF_RAW, len, PBUF_RAM);
memcpy(p->payload, data, len);
udp_sendto_if(pcb, dst_ip, dst_port, netif);
pbuf_free(p);
udp_remove(pcb);
net_lwip_remove_netif(netif);

See also lib/lwip/lwip/src/apps/tftp/tftp.c for usage of the UDP API.

HTH,
--=20
Jerome

>
> Best regards
>
> Heinrich
