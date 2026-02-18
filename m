Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24708E9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 11:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB6C83AA9;
	Wed, 18 Feb 2026 12:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RADeKokd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F7F83C19; Wed, 18 Feb 2026 12:12:43 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEEB83936
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 12:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8fbe5719ceso770260566b.1
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 03:12:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771413160; cv=none;
 d=google.com; s=arc-20240605;
 b=AW/w2K8GoAayXsKNkRbTXbYd10FZ70450YibtRd1+BwNo+KrKdxhKgGwKmV4u5Js47
 5RYWdcGb8INpfBJ3MuDv0hPMjaRqgsWuAPXHE2kxK0iZy2N1MFI7Hj5pGOlhtc1eV0ul
 /Nbq/2pVPMffbmrasZa9AKraDjQVGx35XzPMA/w6eIds9tyQ/ijZLOMdwq7672TlmZU2
 vMa2QsnccABUSsO5PgldN9rN9Cdtx4SUGJovuNOu57Z2nK+QUNcU20suKB7jj/nVUyb9
 JQMEkHeiJbEJFzSr/EhuOae9eQqAu75BuiX2Xe9eJVWm5DFpjFi6xiKRzKEss9ta1AzR
 JPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m+rOwiUTI68Cq8ekvrUwe7hab4K85u4LsrGybS/o7H0=;
 fh=lEnt6i2qrjwBbaSCkrdTcOSYGh/b1tw639piUMO096Y=;
 b=csIp9CQN+ucNssv+UqS1KJRjm13rgJIB0vcKt7konklQr3mWtPDRwn71yj6LCIy1Pz
 V49XJEJgCrTDgctDewvSxaKJFmoMHZRR8Q4utO4lxtfePI72J0w/uS3HOmaH9Ow+7bsp
 cu2ubTWIlTu4Pc4yu2iuYUmZ+y2a7BGDH1Bl8Vt+4jZJVtUATFvcaZ8Pgt8xZXA7XS2s
 cuB2rIy465GcTUfGoDS7FkNqiPlPJUMYI10X+ni37e01f7RYCVx8RQPRkTQJnE4Mp8OW
 aJDN5mcHvOMLoh7RurnH1MXxax3tZjG/eC7y6bQYYM11W3ClcRcxMOHPhDxAVTlhE+nY
 yyJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771413160; x=1772017960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+rOwiUTI68Cq8ekvrUwe7hab4K85u4LsrGybS/o7H0=;
 b=RADeKokdAhwbl5+FynvjF5aqsAyFWgq0kGV1gmcUfMJeIj1wQzSruP/to7a/3evWBf
 EvzHU2bY/olJeryU9YCYhcF67ByB+WKfBs6dtLq3CAqn/sCYtrXO7nWRbuc5zU4gjOYI
 +Ko7aVQ6J66u1qGMZLBcMuBqq4Xkt/KVU0/7ZDi2fasjh8bGvoXukpB+qV/+vq7f6xIE
 Gs3p8FDkNrNBPW/zL8j/JR9VsFWGCiIfJ00LOngKIqiIZK/xP12bKgokrzJKCZQe9aPg
 aL5WBtiR94wqRle2XAM6+33gkwT1xXi6szEi/ZJjLwW38OVwC1BuJ0ge6O9WcdxEV/Ke
 0JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771413160; x=1772017960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+rOwiUTI68Cq8ekvrUwe7hab4K85u4LsrGybS/o7H0=;
 b=RRbA4x6HGvSOG3uGC9FgKfcOhjGKCsoUmdV8hz/4mhLIerKX/3pfQoqNFRt8RHSVDo
 ANC0PPtuvZA8cI5QykwbvyjHW8QlOBhmqsYqJ+ecvaB7aRUXI8Gf0AbCGtmFZ/1ioo+O
 bKlwuQCtYYU4SC9n6+jMPGSQu7gmhIbkp1wiX4jjP4J08040j1LGNwHGEShnmz3wazq/
 G0tWvGsjYZuxatv6FSc/EwA87Y8uGLy1rjC3xjOXI+HmLFPQauoyW6Uy0UPhzIT9w+v5
 y/wOXUyEuTFO1tr0c7r9mThmEY1pikm7fKewjQRn49pAH5e0qlbI2GT6IYXrULYSWkyp
 5YAQ==
X-Gm-Message-State: AOJu0Yysh8bJKttXUgudYTbP//bWQTnZCtZ3WZ8qy2Fe4x1MCTiiveZ1
 haWhhHVaWysn3XOI57vJnbaP+VlMXfOe6JeonNYjslqDRsWepPNC9iSycuVU0F725NNcQaSXuDV
 86lVe5UaMblj7cLX9K2RDC0k8Q8Oe9Oo=
X-Gm-Gg: AZuq6aKatEAnE2jY/QUEj8TxNennCZxiC2AM/x1z5UUFHm70qjIGEAnQQy4eiX7v5lA
 94OR7WqMetghcp4YdqNKT+spxgJxGf7zQqAZH4e9cj3Uct5qAJWAcCxImOtpisOHm25rKwwslq1
 tm2R1jY7e50OPOJaFtDEYd/UGoz0GCaAFXsyF+M9L3baLbHdv4FN7zteKZpNQbPVFQc4NtXXAoz
 uYOXubGueOkFdEG8do7CWGwkI3+dtGfQvqum4tgk+ZwT+11vXaRMKOn9PyaMsxnB4uiXvhszEu4
 PrimnHecmU80ExKH/Spwu/MlQ0TzYJ//6DjhnQZA3a9rPnN2x+eVRnU+62082j+b97p0MUnsdAy
 KWO80h2t6nYYfKgM6nmX8RruvWSozV4V7+HA6j2QRGVgHkq4e
X-Received: by 2002:a17:906:c103:b0:b8e:dd59:7ba6 with SMTP id
 a640c23a62f3a-b903da9c0e1mr95714766b.20.1771413160191; Wed, 18 Feb 2026
 03:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20260216184452.18732-1-filip.kokosinski@gmail.com>
In-Reply-To: <20260216184452.18732-1-filip.kokosinski@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 18 Feb 2026 11:12:28 +0000
X-Gm-Features: AaiRm51VEbCyRnCpf907B0m7x-U4ZTRl6tNuCkDcpzLIuMyaDr7mfekoHckANoA
Message-ID: <CALeDE9MTfGaVt3p9h2oTt2KkJ8JDjauNT7oA4bnsHbP8C8aB7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] board/raspberry: add FDT for bcm2712d0
To: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com
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

Hey Filip,

> This series adds the FDT for the d0 stepping of the BCM2712 SoC. The v1.1
> revision of the Raspberry Pi 5 board can't boot Linux properly without
> additional changes specific to the d0 stepping.
>
> The d0 specific changes can be seen here:
> https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/dts/=
broadcom/bcm2712d0-rpi-5-b.dts
>
> To do that, this series introduces support for multiple FDT entries for a=
 single
> device type (bits 4-11 from the new-style revision code).

I started to look at that last week to see what was needed so this is
good timing.

> The rpi_model struct is modified by:
> * changing fdtfile to fdtfiles (const char * const *)
> * adding fdtcount (size_t)
>
> Adding fdtcount is motivated by wanting to keep FDT selection O(1), and a=
void
> relying on NULL terminating fdtfiles array.
>
> A new FDTFILES macro is added to initialize fdtfile and fdtcount.
>
> In case only a single FDT is provided, or the board revision code doesn't=
 match,
> the selected FDT defaults to the first entry in fdtfiles.

I tested this very briefly on my RPi5s and the good news is it
continues to boot.

The problem was I see no output from U-Boot on the serial console at
all, I get the early RPi FW output and then I get the Linux kernel.

I think there may well be more details we need to deal with here,
there's at least some difference in the console serial port [1] and I
suspect we might need to deal with other pinmux nuances possibly
around the sdhci interfaces.

Can you also provide details of which revisions of rpi devices you
tested this on?

I have an 8gb v1.0, and I thought I had a v1.1 2Gb but looking closer
it looks like that's the old c1 SoC rev (I read their original
announcement for the 2Gb variant as they were all 1.1, it appears
not). I have ordered the new 1Gb variant so I have a revD I can test
against.

Peter

[1] https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/dt=
s/broadcom/bcm2712d0-rpi-5-b.dts#L93

> Filip Kokosi=C5=84ski (2):
>   board/raspberrypi: add multi-FDT support
>   board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5
>
>  board/raspberrypi/rpi/rpi.c | 96 +++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 41 deletions(-)
>
> --
> 2.51.2
>
