Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C77CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 14:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A27586958;
	Sun, 15 Oct 2023 16:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aPK52HKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C3A86A26; Sun, 15 Oct 2023 16:40:23 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E0C86689
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9bf0ac97fdeso135723766b.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697380803; x=1697985603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Oj6T6BrrSWilWjB5VxjglAZfUkmhAjDHdTQAq4ypPA=;
 b=aPK52HKFkMjONVeoxnVcmfC+d7vs1LcmHmZmCkqIoRJXmJ7QMheW75trgIxkMzdrW5
 UcSf7nrDPa1UzCbbt2km2bYmSNoFIpcXp7qjqnFp12W3yDbrHuUQjx+0UDE6Zhedp5Nb
 jSKiF/D0wOl6BdTzMKfI4EKsI+wVapYnK06Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697380803; x=1697985603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Oj6T6BrrSWilWjB5VxjglAZfUkmhAjDHdTQAq4ypPA=;
 b=jwp0tLruHbJpCF7n9T9ztDv9wJ6/CNbXHmPMTCOu5L20d7FjVbPnc6wySh9GOo3CzM
 rkwWRsOlyGqgTtAYHPrqMcH1vsjq3FAdUY3oDfHFBfYaRE9RcsHn0xYem1+3ShDHf5i9
 vufWWzcK7qWDOuS3VPtclDcsgxSRZv32jBs3yn97EUAAc0g1IB9Yz48MQwm8YysdItkz
 GyGWtoZuj71RyJMNkwsQASerRug3slQrWtqIaD8MnTIUnrEhWegTWWmRRtGFpeQHVeoj
 93i51fTJVFOgFgHPa6daXu0nyEYyu7Vb8UFUhzzWRO+WVZ2dJ3K/Cp7zLln3hiw5VO5t
 n0sA==
X-Gm-Message-State: AOJu0YxbN5/S5Xm48DWzsGmqHDlUTFaVrO+ld7RiFSK33+nCEQ/le7IW
 3erv0FTbmIBCSZZwOROBOmOPjJkxBm8OjwJdUn7nDkn/o6bA85Ze/9c=
X-Google-Smtp-Source: AGHT+IGvKI+J9F7YBqHs93uq2uXvbaevobUqqtQ6rVgLkLzPELUkKhOsHUr4pqSty6jnbkEo2nWD6NliWZ9vDqcf+9c=
X-Received: by 2002:a17:907:6ea5:b0:9bd:f3b0:c087 with SMTP id
 sh37-20020a1709076ea500b009bdf3b0c087mr6112938ejc.2.1697380802893; Sun, 15
 Oct 2023 07:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-18-seanga2@gmail.com>
 <1365B46D-6CCA-4064-ABC1-97CF581564C7@gmx.de>
 <f3fa804c-0c6b-f31d-6bd6-d5e3408a3861@gmail.com>
In-Reply-To: <f3fa804c-0c6b-f31d-6bd6-d5e3408a3861@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Oct 2023 08:39:50 -0600
Message-ID: <CAPnjgZ06ULY5335j-7JpBU75nDV52Rbyevj0FdPyvVwRds47wg@mail.gmail.com>
Subject: Re: [PATCH v2 17/29] net: bootp: Fall back to BOOTP from DHCP when
 unit testing
To: Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Harald Seiler <hws@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
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

Hi Sean,

On Sat, 14 Oct 2023 at 15:27, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/14/23 17:22, Heinrich Schuchardt wrote:
> >
> >
> > Am 14. Oktober 2023 22:47:53 MESZ schrieb Sean Anderson <seanga2@gmail.com>:
> >> If we sent a DHCP packet and get a BOOTP response from the server, we
> >> shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPACKed.
> >> Transition straight to BIND. This is only enabled for UNIT_TEST to avoid
> >> bloat, since I suspect the number of BOOTP servers in the wild is
> >> vanishingly small.
> >>
> >> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >> net/bootp.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >>
> >> diff --git a/net/bootp.c b/net/bootp.c
> >> index 2053cce88c6..7b0f45e18a9 100644
> >> --- a/net/bootp.c
> >> +++ b/net/bootp.c
> >> @@ -1073,6 +1073,11 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
> >>                          CONFIG_SYS_BOOTFILE_PREFIX,
> >>                          strlen(CONFIG_SYS_BOOTFILE_PREFIX)) == 0) {
> >> #endif       /* CONFIG_SYS_BOOTFILE_PREFIX */
> >> +                    if (CONFIG_IS_ENABLED(UNIT_TEST) &&
> >> +                        dhcp_message_type((u8 *)bp->bp_vend) == -1) {
> >
> > As written before, please, do not add unit test specific code paths.
>
> While it is convenient for tests to implement a BOOTP server, there are
> effectively no BOOTP servers in the wild. However, BOOTP is commonly enabled
> in U-Boot. In an effort to avoid growing most U-Boots for testing purposes,
> I enabled this path just for unit tests. That said, only 6 boards enable SPL_ETH,
> so maybe it is not too bad.

Yes, also if you are using networking in SPL, you can expect it to add
quite a bit to code size.

Regards,
Simon
