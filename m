Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B05C10DC1
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 13:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65991875FE;
	Thu, 30 Nov 2023 14:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zg0/c8eN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F5C87656; Thu, 30 Nov 2023 14:14:58 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D073875C3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 14:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a08e4352992so130433366b.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701350095; x=1701954895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Hxf4Cf533Exi94Jt2a9wEly9KlxzYkYKr9Ccob2rks=;
 b=Zg0/c8eN2zRiGVky9+cKMdXJw0tTSr9p4bPGkiaXBqWbAESWVhTuWvHYRapy2I3jP+
 tp0HhuB8ug5Cws5R4CN7eqheM3Aogk75QETCFByx4rg2W5H8OUM588MQeYoBavzPFmu1
 fZiYq7Ig0U9FWamNmLWkI8Tdv1NpeJYJ+2wK8Dt+gUaxKD+Hy6RiTaZVUvEuaTeKYAec
 lItPQVjStc2Wnz0EMSA/NAE/b+1KvIqWEkZ4hhSq+8qSKl/+xYqZefNUkC88O7xsgtFF
 ITttnTejQtKhdZH5cKeO9XdIkts75x+XcB5ek9B/Y+w37ohsgBwHRgqFCc4BssyiGxKI
 cdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701350095; x=1701954895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Hxf4Cf533Exi94Jt2a9wEly9KlxzYkYKr9Ccob2rks=;
 b=CnvjrlOf2kSpHUIZHSaAUZwcefESzJYy+Q2iU83puoXBKOd8kIOmOWAj5+VJu5D0OG
 s/LMOz1IUQ2r48lH8ak8GXtDS4ff3rdyMibndi0N/+xw9VarHxME6RgzVGQZYwc3zzpe
 6r7XTjiNKE4CBhyEA5gKvwWEjygDE3w/hOk2DxCFG/MsqQHdmFaxkXnVTN1K8imfvtE5
 ZsITML6i4MEKyNvUy6eZkigP1lp1dtmvJoH+qtxduXIfQDQ+m4g5TCc4VMGH4yOaxV/t
 PMT8872bYmNDLCLb+Q/zzfHhDEpxQnTf7XI1sttosOfzEzN24DqVJnouGVYejEcDfm7y
 hOUw==
X-Gm-Message-State: AOJu0YzaSX5FpcjY5VAL/JAf/Bu98R7mfUvMM69tKsbx8LeXsTCdRdBQ
 H9sWtxXcf8GR4QaFAYhztX4poRTUnXa1ME3JMJkfLw==
X-Google-Smtp-Source: AGHT+IH8oov/1TB679Gt5smeWiPzkcXcZto/n/QB8mNpCwgZwaQipuKZ64O+gQNJAyAdahLDi80pauFOYW6BSHDQrLA=
X-Received: by 2002:a17:906:b20a:b0:9e6:4410:2993 with SMTP id
 p10-20020a170906b20a00b009e644102993mr11882906ejz.18.1701350095029; Thu, 30
 Nov 2023 05:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
 <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
 <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
 <CAOMZO5ACEd9q4QPmdeSsKWdsN5Gu9smH-VAowpSRhBaxA3pT-g@mail.gmail.com>
 <CAD8XO3Z4JLJfG7ceZS6_fOFY0fyQ_7GMQLdLioVp7xxcvDSgUQ@mail.gmail.com>
 <CAOMZO5Bbg-3HyOtjofw0+gR6htx02_cDV3qbdPCb0aZQvW6pqA@mail.gmail.com>
In-Reply-To: <CAOMZO5Bbg-3HyOtjofw0+gR6htx02_cDV3qbdPCb0aZQvW6pqA@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 30 Nov 2023 19:14:43 +0600
Message-ID: <CAD8XO3ZCOELS+7g3A2dVz8n-bw-NgENPKaPZCLM53joGYc5=sg@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 30 Nov 2023 at 19:00, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Maxim,
>
> On Thu, Nov 30, 2023 at 5:39=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro=
.org>
> wrote:
>
> > If networking for some reason doesn't work on that board (I tested only
> virtual board). Please try to compile with:
>
> Could you also try on a real board?
>
> Tom tested on a Raspberry Pi3 and it failed too:
>
> https://lore.kernel.org/u-boot/20231127185953.GW2513409@bill-the-cat/
>
> > CONFIG_LWIP_LIB_DEBUG=3Dy
> > #CONFIG_LWIP_LIB_NOASSERT is not set
> >
> > It should make network activity more verbose. In many cases I saw issue=
s
> that physically MAC address do not match to lwip initialized value,
> > and lwip drops such packets.
>
> The ping response with:
>
> CONFIG_LWIP_LIB_DEBUG=3Dy
>  #CONFIG_LWIP_LIB_NOASSERT is not set
>
> u-boot=3D> ping 192.168.0.16
> init already done for eth1
> Using eth1 device
> pinging addr: 192.168.0.16
> ping: send 192.168.0.16
> ip4_output_if: 0IP header:
> +-------------------------------+
> | 4 | 5 |  0x00 |        60     | (v, hl, tos, len)
> +-------------------------------+
> |       40      |000|       0   | (id, flags, offset)
> +-------------------------------+
> |  255  |    1  |    0x3994     | (ttl, proto, chksum)
> +-------------------------------+
> |  192  |  168  |    0  |  164  | (src)
> +-------------------------------+
> |  192  |  168  |    0  |   16  | (dest)
> +-------------------------------+
> ip4_output_if: call netif->output()
> etharp_find_entry: found matching entry 0
> etharp_query: queued packet 00000000bdf03e70 on ARP entry 0
> ping_tmo: ping failed; host 192.168.0.16 is not alive
> u-boot=3D>
>

I will test that. smsc95xx_eth included in some CI tests and it worked. So
some differences on real hardware...
Log says that a ping packet was sent, but no packet on rx.
Might be the start function of  smsc95xx_eth called wrongly....

BR,
Maxim.
