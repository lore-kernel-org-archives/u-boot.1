Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B91D75BCC
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 07:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F702895D7;
	Thu, 21 Nov 2024 08:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QOTD9O7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1EA889637; Thu, 21 Nov 2024 08:37:32 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894E3895D7
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso610566b3a.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 23:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732174649; x=1732779449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Sc+fScZwmuShhSB7xPKJe9J782hB9zuULcbjb8nIXI=;
 b=QOTD9O7QT2FVvA3MiPpoMc4QUuB6KfB5cBhruky3T7kfjHue1jTwhDLlwD6PtOjdr4
 xzGJTwHBaWWdkPAIuzn5kySdqO6shyN6I4DB2IDybfNQg5k+AhORoZpxxGjkOd7fnHr4
 /8y6EpJv8lelM6i7Q7g+3EAV73qf1gzHpQ9mQGk9QbnghoAM/prEsCewDD0vc5CaL9Ln
 6lJNEYa1DO/T4BJN0h4qKcr4lljCVjt4nWGrHjnyN+3TnB573hJHGRM3Ar85sXOkot4W
 dHI1dU+Ri+VKubk8X2Xms5FTgMXKIw6DoOBfJFaxG45cCwBnCBeuXqAdV+ZLrvTYXZtT
 YsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732174649; x=1732779449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Sc+fScZwmuShhSB7xPKJe9J782hB9zuULcbjb8nIXI=;
 b=lltz2QnInZsXzc3Rah6XvhJmwvJxyQ37h99PiGfgl7k9V3BHrDOZ2fS2ixpYzdtcpK
 AISWknQbZr58bPdSPoSJfQgjg82UYWO7PmJRE3BXQCFsCOWhNbea9gegEo6s9RjXBFhK
 swULAkVdGd3VMNx4LbuSr32NOYmuJeeYEOjA7TRDhzL1cnZH4/70rlINT4Yh3DfoBb8X
 UtHgt40S5oZoCW0g1OVBzBQt9OoCfkfJIU3L/4YCe1tVApkZywssRYd+NHsGaM96nSmV
 0UoxIFAGg7/apkbXMGAeakIUJrE3pKpKFne6qywM+5N4oK7yXP4fEr3CD5+zxxL5UXl2
 tO0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlkTglHa+kGGlEybKR5i+Q43g0txSBuZcbXby1vo1VsKJQVNtO5UYr+c0LdvsrsJP23zy5BMA=@lists.denx.de
X-Gm-Message-State: AOJu0YxnTLl7BMc7Sb/SQSfnRB5xcnoR1kVAkcp/YJt7vnKeVRpzs5LO
 PDco0I3FWQ6aBbdXboB5z9ZWWOAEhpDve9K9p9lSEOAcYVO9jlPNY7937vCp1nSomatzG4MoIEr
 xySxz8HJoolfMddbKc2AI13W3sU6/zJ92LT/uPg==
X-Gm-Gg: ASbGncv6WhIdIy3RjxSTPewvT3UH8aFfYcDDTlJ7E3o85LWpTXRmNDwCsVt4LoE8so7
 zQXk3dzdA7XmnpfCEq079dGmVgzYn9A==
X-Google-Smtp-Source: AGHT+IFYM1gAtBBXB2bWelSO7Z7mvA5zsJDqeiOOz6I64Y77CXJ7JyveyDEKkvt/JZsu6rHHH0yUaTfIrMD/6dH3xLw=
X-Received: by 2002:a05:6a00:928e:b0:71e:68ae:aaed with SMTP id
 d2e1a72fcca58-724bec7afb0mr7408888b3a.1.1732174648956; Wed, 20 Nov 2024
 23:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-8-adrianox@gmail.com>
 <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
In-Reply-To: <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Nov 2024 09:36:52 +0200
Message-ID: <CAC_iWjKTmTzeWXO0cs79fs76B1ccD_GsVusL6hhPb14W7_i2ZA@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] efi_loader: device_path: add support for HTTP
 device path
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
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

Hi Heinrich

On Tue, 19 Nov 2024 at 12:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 18.11.24 22:09, Adriano Cordova wrote:
> > Add efi_dp_from_http to form a device path from HTTP. The
> > device path is the concatenation of the device path returned
> > by efi_dp_from_ipv4 together with an URI node and an END node.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> > Changes in v4:
> > - Reworked an if-else
> >
> > Changes in v3:
> > - Moved argument checks in efi_dp_from_http to the beginning of the function
> >   include/efi_loader.h             |  1 +
> >   lib/efi_loader/efi_device_path.c | 52 ++++++++++++++++++++++++++++++++
> >   2 files changed, 53 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 612bc42816..96b204dfc3 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
> >   struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
> >                                        const char *path);
> >   struct efi_device_path *efi_dp_from_eth(void);
> > +struct efi_device_path *efi_dp_from_http(const char *server);
> >   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
> >                                       uint64_t start_address,
> >                                       size_t size);
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > index cdeea4791f..9ee03062ac 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -1012,6 +1012,58 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> >       return dp2;
> >   }
> >
>
> A function description is missing.
> Please,
>
> > +struct efi_device_path *efi_dp_from_http(const char *server)
> > +{
> > +     struct efi_device_path *dp1, *dp2;
> > +     struct efi_device_path_uri *uridp;
> > +     efi_uintn_t uridp_len;
> > +     char *pos;
> > +     char tmp[128];
> > +     struct efi_ipv4_address ip;
> > +     struct efi_ipv4_address mask;
> > +
> > +     if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
> > +         (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> > +             return NULL;
> > +
> > +     efi_net_get_addr(&ip, &mask, NULL);
> > +
> > +     dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
>
> This seems to be the only usage of efi_dp_from_ipv4(). So we should make
> it static.
>
> dp1 is expected to be NULL if we are out of memory. This error needs to
> be handled.
>
> > +
> > +     strcpy(tmp, "http://");
>
> @Ilias:
> Linaro sent a patch series for supporting https.
> Will that go in after this series?

The https:// support in already in -master, but I can live without it
for now on this series.


Cheers
/Ilias
>
> > +
> > +     if (server) {
> > +             memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
>
> Please, use strcat() to simplify this line.
>
> > +     }
> > +#if !IS_ENABLED(CONFIG_NET_LWIP)
>
> Please use 'else if' instead of '#if'.
>
> Best regards
>
> Heinrich
>
> > +     else {
> > +             ip_to_string(net_server_ip, tmp + strlen("http://"));
> > +     }
> > +#endif
> > +
> > +     uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
> > +     uridp = efi_alloc(uridp_len + sizeof(END));
> > +     if (!uridp) {
> > +             log_err("Out of memory\n");
> > +             return NULL;
> > +     }
> > +     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +     uridp->dp.length = uridp_len;
> > +     debug("device path: setting uri device path to %s\n", tmp);
> > +     memcpy(uridp->uri, tmp, strlen(tmp) + 1);
> > +
> > +     pos = (char *)uridp + uridp_len;
> > +     memcpy(pos, &END, sizeof(END));
> > +
> > +     dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
> > +
> > +     efi_free_pool(uridp);
> > +     efi_free_pool(dp1);
> > +
> > +     return dp2;
> > +}
> > +
> >   /* Construct a device-path for memory-mapped image */
> >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> >                                       uint64_t start_address,
>
