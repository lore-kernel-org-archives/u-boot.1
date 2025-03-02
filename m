Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41DBC282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5A3806FC;
	Sun,  2 Mar 2025 17:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W6sRg59d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF69E810ED; Sun,  2 Mar 2025 17:18:49 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6181F8058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 154F63FE33
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740932323;
 bh=zcKRwgNfMrXEJ7BeUzFfeY2y6v8JLI+aLqU4mRkXEGc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=W6sRg59dai7VRjihcUdqu7kxw/xOfF5Dcrj1jumXa4lyVjmYgqIe/sgTtFCjQRtxC
 6dSIPUgq+yawNuhtFC00yYIIW01wtr96S/L0xOEuISVGOqnXwua/G7LlHwBMtF6f9w
 I9f1Of0U0CNSysjpLxASpLin9iFZp3lE33YpddPbrwqjQwq6X5jUkvAWX+Ne24HLvm
 GwZH83NDUHhqpCkWKYklZHa2eFJaysI1vmYIi+oxrhargz7SM8j7e64vsWt7NNY3pw
 xdqiwjRIX/0G/6TkL0vIgSQ3PnzbNKj4qhTYe3/+8TxptpPJukRiGo+hPZpiu/xwwT
 9CMEZOUD6JmXw==
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fede63f32dso3522317a91.1
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740932312; x=1741537112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcKRwgNfMrXEJ7BeUzFfeY2y6v8JLI+aLqU4mRkXEGc=;
 b=OdDRRLXSvI0MxrssY0WITk+zFX7tXGHv2Z8HZXHgMAV/NT7jL3S/U9kPPAUWOzi4gL
 +qv0U7IIw80bKyk67sKs1rH3C+8AESeCewllo9FbVJoWAXiQcSns73HNQAI6PgMy4fbm
 bMVKSKyUYy68aYc9L42DeOAUUQT1nGZ7qz7gC+HMQBuF7dmXVumulswXJLj+pKRuvjdl
 JoHk9E7DlI5SY58yhZJmD6NFY56+tVjINnGaKZVTlRQP++Ae2dyuO0HFmnm1gEAxVr6Y
 onNMBUv1k1jkbRhfrBLHfdZr/Jps4QamUIHCV/6JYbHbJMtaiaDVK6uTsIE1IkL2/LUR
 Q82w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwszuk8U/nVWK05Lt9lr5Im1kM3JRyUTvB3F18YDcZ0oX4FD9VRrlff6PR1buoUgqX70ByQmk=@lists.denx.de
X-Gm-Message-State: AOJu0YzU8/xt4NuUyzEj3A4lgdeefFrjvngIknAkVJnBnVq83kvUyO2z
 O2dpbtQSGQAk6Q33SaKXFs7jwrcWgIVLKXcn5cflpHzQT/22ZGb0c0JgqiyHiIUR8XpBxYCfq3N
 D+q8P3r8VahNrqlN4zbdPzIGgMqGuNs+rKfwCyFf0V+Bl2PvtFc6DRJyFD2BFmWy35MLojeGcIr
 +jIzEdH0hNJ7p448wT0MzTLaOoCq+sgKM+YHyRqy2jog==
X-Gm-Gg: ASbGncszaqZABTLPMrfm5PV4R7i8V5siX4PIO+ojUndd/XdXbVgoeYCNMcxlRPJYV4t
 lEhrWB4oHyIPawmv8HgXQ19tGNqyW/kfw+kLlzUSMyejBxmd0KoMGS6H00gi2Mc8jW7ItYw==
X-Received: by 2002:a17:90b:5747:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2febaa924d4mr19226855a91.0.1740932312592; 
 Sun, 02 Mar 2025 08:18:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGocsbGztOqyebFRoPmFYDXf10KGPnwRXSpQscbG59631Fr7Ur3ln/c+l3lGyCmZTMqOaD8oyTNIao82uA5miU=
X-Received: by 2002:a17:90b:5747:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2febaa924d4mr19226817a91.0.1740932312072; Sun, 02 Mar 2025
 08:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
 <Z8SA7NrvySYVcIWI@pie.lan>
In-Reply-To: <Z8SA7NrvySYVcIWI@pie.lan>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 2 Mar 2025 17:18:21 +0100
X-Gm-Features: AQ5f1JpxjJ1E7be0yU0ANdtLu9MVUCDTJztJGYqwfo93O8ydXJVd6zZxALGx21A
Message-ID: <CAM=mAOktvhQ4Rq1Z=hQENCx3LR87XXoKq_bK2hL1ct1qiSww6Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm: include asm-generic/int-ll64.h in setjmp.h
To: Yao Zi <ziyao@disroot.org>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Janne Grunau <j@jannau.net>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Yao Zi <ziyao@disroot.org> schrieb am So., 2. M=C3=A4rz 2025, 17:02:

> On Sun, Mar 02, 2025 at 03:21:18PM +0100, Heinrich Schuchardt wrote:
> > Don't assume that u32 and u64 are already defined.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  arch/arm/include/asm/setjmp.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/setjmp.h
> b/arch/arm/include/asm/setjmp.h
> > index 662bec86321..9a7f5af9f8f 100644
> > --- a/arch/arm/include/asm/setjmp.h
> > +++ b/arch/arm/include/asm/setjmp.h
> > @@ -7,6 +7,8 @@
> >  #ifndef _SETJMP_H_
> >  #define _SETJMP_H_   1
> >
> > +#include <asm-generic/int-ll64.h>
> > +
>
> >  /*
> >   * This really should be opaque, but the EFI implementation wrongly
> >   * assumes that a 'struct jmp_buf_data' is defined.
>
> With PATCH 4 of the series, this comment isn't true anymore. Should we
> fix it up at the same time?
>

The comment is removed in patch 3.

https://lore.kernel.org/u-boot/20250302142121.150480-4-heinrich.schuchardt@=
canonical.com/T/#u

Best regards

Heinrich
