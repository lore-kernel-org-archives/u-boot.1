Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8755FC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 16:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCEE9830C0;
	Tue, 27 May 2025 18:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="TJq7H2Fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0653830F4; Tue, 27 May 2025 18:36:12 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE4E8309A
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 18:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e7da20d35ddso2144167276.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748363769; x=1748968569; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxfuX7PLa6k8TbnajGIUfAZxB8hOK8l0tCFZiiwjJDk=;
 b=TJq7H2FpKhKV15sFhCI+8Q+WVTle8g31QuM/rQfi+vge3gtlKrYj0ceV5pFoKrbpNR
 pdlhpCKKwhpruwuJz6A7b/+9qYNpL+kPUro5DdYATH92ccVFE85pa88ArzGW1ZLt8b9N
 b0tRS5SbVi9GBoEds1nyZDia/gNZ0d66NtFVmfYvYb1NqVEdBTFCPYi25ebzN/dWUiYP
 pqQxKlWv0nlTjWGC1KJbgfA1MevpAfWUFZn6p/nkLY6Oa8jnFlpv4TfOdpnhZ187JzlL
 gH2KN6foeWyGobJRXDsNp9L5nhezTa1kQTWJSz8VFpQ0UvCoR4fE3cAhg/Cy48dWFJ1Q
 6gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748363769; x=1748968569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxfuX7PLa6k8TbnajGIUfAZxB8hOK8l0tCFZiiwjJDk=;
 b=U2UYOJffjaM40ZrqBFn+KmhuPaqdknDq26hXOaYO2crfRZhYDUpcmbsVJQAOsZJLpP
 ObnKiuYTXJI9sMyLHXEuCN0xb5m3nHp8zaAo5aDuoPmoqcnwryfF515e/EyYtUWWemNp
 XJI6AgvOc+gyVsCX5bTz8oVMS3AgsG8yYH5VCt2ZGZEvH1zmHHjXBtKIx8H9ItG5/YzG
 R84/pon1AnmZadbzjIEnnNsrPm50GT4U4xD+09SOH0l8pQMNPAdYnOKtqCxCIRZjIl9i
 UZVWjU7AwKAefz5vfTvq6EyiGqGj2qlMckUQon7Rqw5S10LIlRTyqrZRnNp88ejYPiR7
 Z7HQ==
X-Gm-Message-State: AOJu0Yz2sC0dDRk4WcqICBZiaFC9zqdL1hH5DWS2hngwpEoohIbJPM6g
 DV/LrfcM70tuJTd8en2z1Wh5c18O77cuchRASIOigZXusgJjSBhiiZvDBqUsX9/JZOGNuQVC2iZ
 CExPIvVDn2ivUX2XWEC5yJYuUjCfluGc41pwWrh1Ikw==
X-Gm-Gg: ASbGncsQR1hVy0sRSZIhjVrC0azhE5iI21rXj1X1DSgyXa40xc06oHE2KDsj9iNSBFO
 hYGbgx1MsieqdNHDmR23J0fsLpc/qfd7Oqd4WSKr0oeHVdpn9Fusx4VKnFA2yPBqTuYOYYd8ZAv
 blV/Dx+EVqZiKiD7kns424ho3qqi3y9Aez
X-Google-Smtp-Source: AGHT+IFdCVj7lWdcUbUQ0Al/TGNSkbEok8677/AcYUvx4yeeDahbP/2FcTMlGZeAFwJvqkmtoT5zul4bpocJYTT1PxA=
X-Received: by 2002:a05:6902:20c1:b0:e7b:a4b9:c02d with SMTP id
 3f1490d57ef6-e7d919c072fmr15690344276.4.1748363768977; Tue, 27 May 2025
 09:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
In-Reply-To: <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 27 May 2025 09:35:58 -0700
X-Gm-Features: AX0GCFtXsqI3P-lJ5XImKz9d1InUqWdpun8B8WX9DJP8ocRO_PQc8kMTa0Ny8vk
Message-ID: <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
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

On Mon, May 26, 2025 at 5:17=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Tim,
>
> On 5/23/25 20:31, Tim Harvey wrote:
> > Hi Jerome,
> >
> > I've enabled LWIP on imx8mm_venice to see how it's doing and while
> > dhcp/dns/ping/wget appear to work great, tftp is broken.
> >
> > Enabling LWIP_DEBUG shows the following:
> > ip4_input: packet accepted on interface et
> > IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY=
 =3D=3D 0).
>
> Hmmmmm IP_REASSEMBLY should probably default to 1.
> >
> > I tried enabling IP_REASSEMBLY in lwip but that seems to change the iss=
ue to:
> > ip4_input: packet accepted on interface et
> > ip4_input:
> > IP header:
> > +-------------------------------+
> > | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> > +-------------------------------+
> > |    10568      |000|       0   | (id, flags, offset)
> > +-------------------------------+
> > |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> > +-------------------------------+
> > |  172  |   24  |    0  |    2  | (src)
> > +-------------------------------+
> > |  172  |   24  |   21  |  251  | (dest)
> > +-------------------------------+
> > ip4_input: p->len 108 p->tot_len 108
> > Unsupported transport protocol 1
> >
> > Any ideas what the issue is here?
>
> Not really :-/ Does the transfer work with a smaller block size?
> (CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You could
> also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump of
> the messages going into/out of the lwIP stack.

Hi Jerome,

My config was with 4096, setting it to 1468 works and anything above
that seems to cause this failure.

Some sort of fragmentation issue?

Best Regards,

Tim
