Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02786FD0046
	for <u-boot@archiver.kernel.org>; Sun,  1 Mar 2026 00:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0FA83EC6;
	Sun,  1 Mar 2026 01:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q2BR2WdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEEA83EC9; Sun,  1 Mar 2026 01:11:20 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE343838BB
 for <u-boot@lists.denx.de>; Sun,  1 Mar 2026 01:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0c83so6258323a12.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 16:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772323875; cv=none;
 d=google.com; s=arc-20240605;
 b=cIPj+MEul00RpDVOkqzrsGIA1Dwwu6TXgMCFaiC/zhq7pG8Qbsxsy8ZPi5TwAa1Y9m
 TV8uw3w7ShbmKHF7qeY5hIK3LBMZli13d6lLyZ+g8Sl/xjMbgd4HmP/9mZc+9tnguFXM
 vFdy5YjxeWeVeALY0mAUyUah5Rtcn06fYYleM10dTMC1tLy/yxywyJwXj1P7rklpdTkd
 nwH+SJ/YGb/cGs+6UQxzWMTmVc9g2rIUWDEJsC3bMFIrSZj7z9sMzL3Wa7zZJBP4WNrs
 fjmzkG/vjYnP8m7WyxqWy+UZidM/ESX1xQs0Qpdp5+zI1gfxizDWIkHsuXoQnhUfapO4
 Sd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MxnJXGZbgmDTdosPJMdCw156p7Z2ftYnEZ17bb+WKys=;
 fh=KlxOvR6ovko/Tq4+AAoilf1juvoiIsDuyXSo1REyiUo=;
 b=DiETCajYX9I+nbTvYZIbGjXrdlcOIgem3hb3nCiyuIifzizSYlw/OYKjjtDYfbNWy+
 iCKopxmcV0PHtky8aEmZRgNKnDQKTaj2Zgaevu8ML6f1CErW0FR97AIvahbOEFUijmCK
 +w+zGWpU1Ycfg49s/m3KDgdA3y18MXZzBp3L2d0OOikc+WMk/AifDsaRAxOrAeemj2Bj
 janzOSmztBPdRJzYZ4IGqpfRG3Zj6U+8VvIO5Fo2eKh+dVGsR017Yu7pq2qtvEFdmpa9
 rqhUeyjttbpXVpyGnTVMemCbOr9ivwAqxLfH5Q+73Fakae8OdYCakvCSwwulwFVSnsFC
 Mg5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772323875; x=1772928675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxnJXGZbgmDTdosPJMdCw156p7Z2ftYnEZ17bb+WKys=;
 b=Q2BR2WdXmy4mbAAm7ppgoTaaZwsxHm6t+lxkjue1FyAFd7sgYisoX+TIxyc4zYgsz5
 yald/2M+jhAUoCbSfJ+sQnPOWvHK7D2m37O7+uqhuc1D3sfLNgWPiMkzLmNf4KgMCUaC
 WeVTAd4igMzB/NAanFunccZhdJzeYAeUHf4ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772323875; x=1772928675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxnJXGZbgmDTdosPJMdCw156p7Z2ftYnEZ17bb+WKys=;
 b=rOZ9SnsjOU5VOmjGa8yEgd4Cq6DIvubgfy0nqQBpTuuC1HfkDN1hlHAknQcCk+4At6
 pUTb+f2gRQM77J9sp8vAvrWeraGhJn1ZegSyIbgCKOfxUrZ4RIG7JB9EO+3FjT4cD+hF
 bhId8Xw/CcyigYkus6bzAycLF2aiVHABO1bkD48hy+PPmNd6f8RFO2PKwP/s+LYq+I+v
 lzNzNyR1zSoB7tzSMAxGMv7B32cct0ypdarNCXx3S3Yz8cUbaXnMJa/iznm2L6s0yd3f
 jSNPemeYJBe03Zd9wB43A//6VWSJkvfIJ+33iCSUMBHWDcDSc8+UlXOVDVXzfQ/UYSN6
 +Msg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ0uPflALsdCL/oipxUwzbBvI6wYj9P0I0S1vILnXVKSk9E4x3jhtRrtCdwQX7Bj+744ODvWw=@lists.denx.de
X-Gm-Message-State: AOJu0YxYJ7YyUAVdo0DpA4gvM5koptCF8fy1aFiUj9ma7PMxBoZMEDCi
 wjgEIrJ+z3USj6qgSEc40vQW4i/7GLUOrCw4Lnqz1EyZxJ8EOP2G1IUPqyM6G9LduMaIwyD7Us2
 vOuGa8Nevl7S2jMr07FVY3KJDwXPF8AIZQrWfMRbs
X-Gm-Gg: ATEYQzx+Fy1CnbHh0pCynt/0nvsVoA8Q1M8cypUFoO2asS4+TXVWz2LtcFAM1qmwpSa
 1faUASXKtOnKAcU1yisTMdwRsi0ZZZla5UrGFyB88Azig5FpRLUqqNJbM9aGn7tWJ9SVyGES61z
 BpFmyrszE7QKILpDYrTaRZV0Utrdqot5o73lzub3hNwcw/BbyiAsRTibERqYwwNdJd9wm2csQYQ
 IgJQoLJBHo+y/HJEXQ6ommtm1z5Hzd3HznpqVb2gZRLbc6IYA11Gncv9KSeRRo/ZWkhA9vE4PGA
 kEdjQw==
X-Received: by 2002:a05:6402:1444:b0:65f:ab99:2d4d with SMTP id
 4fb4d7f45d1cf-65fddaf7260mr5355908a12.19.1772323875505; Sat, 28 Feb 2026
 16:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTj42WZF3DTOt4HxskNW3qyZJ5_pQ66RsBNdbr13rXTFeg@mail.gmail.com>
 <2acea5e6-5760-40b3-b8e7-952fc355e621@mailbox.org>
 <CAFLszTjRjpFRxxQJt2hNXzuMn9O3Kgcwrh10XpAMXqczK146NQ@mail.gmail.com>
 <40018ce7-5fed-4eb4-8888-601f99747109@mailbox.org>
In-Reply-To: <40018ce7-5fed-4eb4-8888-601f99747109@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 28 Feb 2026 17:11:03 -0700
X-Gm-Features: AaiRm501AI1kzmbd3nsxf1468A0Eh7hvR22duqmNVH-RJG4d-1PqxVZIDrSR-E4
Message-ID: <CAFLszTiENqOipUbkFAoNMwF1ut1ya1TDQ7+gf7PGNd5w2cbheg@mail.gmail.com>
Subject: Re: [PATCH v2] gunzip: Implement chunked decompression
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
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

Hi Marek,

On Sat, 28 Feb 2026 at 15:16, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 2/23/26 6:41 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>>> +       /*
> >>>> +        * Allow runtime configuration of decompression chunk on
> >>>> +        * sandbox to better cover the chunked decompression
> >>>> +        * functionality without having to use > 4 GiB files.
> >>>> +        */
> >>>> +       const ulong minchunk = 0x400;
> >>>> +       const ulong maxchunk = SZ_4G - minchunk;
> >>>> +       const ulong chunk =
> >>>> +               CONFIG_IS_ENABLED(SANDBOX,
> >>>> +                                 (clamp(env_get_ulong("gzwrite_chunk", 10, maxchunk),
> >>>> +                                        minchunk, maxchunk)),
> >>>> +                                 (maxchunk));
> >>>>
> >>>
> >>> As you mentioned in the last version, there is a compression test in
> >>> compression.c - could you add a version of this function that takes
> >>> maxchunk as an argument and call it from that test? Reading an
> >>> environment variable to avoid passing a parameter seems pretty odd to
> >>> me :-)
> >> Do we not want to test the command line interface ?
> >
> > Yes it is a good idea to test it, although we don't need to
> > exhaustively test each compression case. I suggest using the dedicated
> > compression/decompression tests to check detailed features, with the
> > cmdline tests just checking for basic functionality.
> The compression tests already test the memory-to-memory inflate path,
> but they are not suitable to test the gzwrite inflate+write to block
> storage path. The existing gzwrite test is suitable exactly for that. So
> no, I don't see the compressions tests as a good place for gzwrite test.
> The command line gzwrite test on the other hand is already there and is
> testing exactly the inflate+write path.

OK I'll leave this to you.

Regards,
Simon
