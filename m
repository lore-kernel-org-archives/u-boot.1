Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA49C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA92181875;
	Tue, 28 Jan 2025 00:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLmlux1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD1481877; Tue, 28 Jan 2025 00:12:25 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3D681870
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michaelsunn101@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso6682664a91.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738019541; x=1738624341; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z823P+g0xvah8Fp6Qi9jwtlhXhrba9sBxMh21fhPK60=;
 b=LLmlux1OOBmGiKLIlkxBgQ6zYLzpx1Jnjkdhn9eSLNQYNEmgdg1nIUtbr1qIOD5EHg
 N7K0WyQrTP/mqVbzMiFd1LbpVgKZWPucuatRkHP4znXGMpF4F1B3Pi7LsTkN2zcts4zw
 kWIuyg1X6RgqkaOkLIDltaQS9XrSHo1tOG8HYPSmuWq6AXen0V/ErzsVN7UoJ8/ghPXq
 d7Eme1741XD1laGMhqCbhPnLX5WcRyBjPpopvYfamfhQbHNPGugiDkh6Ozdz7qE2wgie
 /tTx0ISB7yBgny3Ebq788E67ps+2BVYgEu2EuaXIpzfmxNYOPHUIL3ZBQyUJ8s3m6I9X
 T9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738019541; x=1738624341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z823P+g0xvah8Fp6Qi9jwtlhXhrba9sBxMh21fhPK60=;
 b=nvqUsiU3P46kijqEDZRChHwdWhvIwwyrNCfZC3DTLWfh+wLKcaLp5SZJpnF/ggNzHQ
 schas3kbokEsrujM0minP0S5Fg4DuP2568CE9nPkIP5OIXkZaDBz4QgZUxb0Ayi7e46c
 R1aQm2TzTeuBgkOyu9AeB2JzyXX+w20uwVFdlfL4OwqDf1hcuH+OAdX32my4YaImdZFy
 u2/6Ci+T+4WRrQQpfZ8624ZWFlJ7hXFzVSmuoqpVW3VrstzpeAgTt9YTZXrMuP43Ts+U
 Vxx5jO6vk8jcM0SEhLuTyeO6PthWQDV/E5/B+1Ic2rz9buuc71t/hsyP9McVCMh48JBL
 VPOg==
X-Gm-Message-State: AOJu0YwqjRzlJPQQC31k7qVKZeXsXfIX9bJASIKm18p1V4Ed7G99fARS
 oKzq+WTCFE/TXXZVBt3/65vke7+LUxuXinaQixu7MpUohMFghqGwdL5kGQgjx9bnSKwsuJD8VLM
 viF1PiP/Iq/aCvKAVEqnq+icNpg==
X-Gm-Gg: ASbGncvDvuuplyRWDPbgHc5aqvkzfGgrP0SxN60CF7cUtZqMHQc2QS/wKV4B9cS4NzQ
 vdqNk6RCS7+mRToHFCUKvpPyzb04I0w98ubUeuCoVs/e1/vEr2Beo0eW5Sg==
X-Google-Smtp-Source: AGHT+IHIODpCxMmcm2YL8X4uNQiVeo7NJzUqS2UfYHbfVRIQHhPNuXPRvAdahNj5dCfj1h9JkoL02/qWixIeArjt8Jg=
X-Received: by 2002:aa7:88c8:0:b0:728:e9d1:218a with SMTP id
 d2e1a72fcca58-72dafa68ebfmr49679620b3a.17.1738019541249; Mon, 27 Jan 2025
 15:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20250127210741.820819-1-michaelsunn101@gmail.com>
 <ff8c7554-a03b-4423-8692-13c7c278095e@denx.de>
In-Reply-To: <ff8c7554-a03b-4423-8692-13c7c278095e@denx.de>
From: Michael <michaelsunn101@gmail.com>
Date: Mon, 27 Jan 2025 17:12:10 -0600
X-Gm-Features: AWEUYZkO49q7DmLdo5HcZhlxnOmns4ivGs-RzB1oFKIAV5jq5xgDTcHZFJ0ZMZc
Message-ID: <CAH40Y2icS-vuHc1E2DCCQ3Jd-37hLnHk0vdrbnbG3oj+izy4JQ@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix NULLPTR dereference when serial# is unset
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>, 
 Lukasz Majewski <l.majewski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
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

The problem can be reproduced with U-Boot's sandbox with the default config=
.
Then, run the following commands at the shell:
Hit any key to stop autoboot:  0
=3D> env set serial# test
=3D> env default -f serial#
at which point the program will crash.

The following change will show that the env default -f command causes
the null pointer dereference

 void g_dnl_set_serialnumber(char *s)
 {
        memset(g_dnl_serial, 0, MAX_STRING_SERIAL);
+       printf("Reading serial from address %p\n", s);
        strncpy(g_dnl_serial, s, MAX_STRING_SERIAL - 1);
 }

On Mon, Jan 27, 2025 at 3:58=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 1/27/25 10:07 PM, Michael Ferolito wrote:
> > The current behaviour of this function will dereference a null pointer
> > if the serial# environment variable is unset. This was discovered on a
> > board where U-Boot did not have access to the first 256MB of ram,
> > resulting in a board crash.
> > In the event that U-Boot has full access to memory, it will still read
> > from address 0, which is probably not optimal.
> > This simple check is enough to fix it.
> How does one trigger this problem ?
