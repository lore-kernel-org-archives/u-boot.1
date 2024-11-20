Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E4D6C29C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 14:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAB989229;
	Wed, 20 Nov 2024 15:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BMAb8YEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B50894F9; Wed, 20 Nov 2024 15:50:46 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C19888EEA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 15:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21145812538so16409935ad.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732114243; x=1732719043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qV5G3+Lp1zkMh4t86oATNsfjSLpl24fcv12Ak+Rq1h4=;
 b=BMAb8YEW8wRWtc0zY4fzZn8/bmxe/jneZbx5ZzBDtf3hNwC1I6DfGY/yCDQPuGw1aV
 8FXotyQcIuTW+ZNfXHvYjNWzk+O3SnlG6OMLogAuAOzwpCgALY9dW9asajzMyMe3Iot+
 g3Hd3G+57i+hFpZ9rpv2s8JGAK6ueSH1ZAy7ho/fzGR0Sv38jA28WU+0iX4zr2tElMPX
 1MWdlLUGN+y+zq7gB7y++QNr9CGZICeh0mJULHXAQ59vji7FJGsoq0Co9fkuN991AbJw
 HcGsG4ieJT518I6PFEUeYXBmJQV17QNJrF7mtmVfuStwSEayyDiIm/cN1vWwYtkA1VCs
 +4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732114243; x=1732719043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qV5G3+Lp1zkMh4t86oATNsfjSLpl24fcv12Ak+Rq1h4=;
 b=AX7C/7/jXcP2cDy0NLVAPkwS4zZT4uiNJktfIxfDAZ0GDRi5TNiNw/XlFLpx8DI+51
 Xhn5iZxAnBovlS5UlW3aac0QXSLoHdzVhHVcMBJaevx6Kip+ZQmfiP3Ij8geK7rvzZdq
 8Oo1rLA63fFnGxH+lgnh93fyltG8cDtuuZ2grXvjlRFl8cC9LEOuK2lgsN5Nrty1JZHc
 +ioD8iRUGmqSMZUXpPiW6tBbWfOzfKbmtPuzadIgGxQjwQiR8oKHSd3c6OhGAo3RBOQl
 MqSIfW7/fl67I6FUoGI1iHCkksZkdgOm/WRI3Oqi1ifJ4BwH/8Vw86xaap1MDdW0yXE9
 S42Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBhmZLJ8C/cMEPkMk6K4kF3DWMHBmjUa4QC4nc8zwCoech/74A+BjfyX+HMTuwY+GnkSPMShc=@lists.denx.de
X-Gm-Message-State: AOJu0YwVzwl1thO/pAIoa4jmyZNlvvkdXUaOg10c5ZRJhzS7SC/isf6J
 xbWMJaIdWsksM4NoUsGRmVkDnOosHssu9DE8f1PKn6EGsU48/jfGSr+5babX/mdFCzOC6XOj0EI
 pm4vDNIrq8/ATrY81/WRNoU3dNrw=
X-Google-Smtp-Source: AGHT+IEwao/4pKqa7J4I9ECpr07HfAQErs6H5sx1dSJ6Kj62NeBkiRsXWU8eHl/Ylg0JWmVBqdVAxtUlw23jq9QidPU=
X-Received: by 2002:a17:902:e74b:b0:20c:af07:a816 with SMTP id
 d9443c01a7336-2126c11c490mr38065675ad.31.1732114242539; Wed, 20 Nov 2024
 06:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-2-adrianox@gmail.com>
 <9d784844-a0ae-4cba-809d-2dff06daa446@canonical.com>
In-Reply-To: <9d784844-a0ae-4cba-809d-2dff06daa446@canonical.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 20 Nov 2024 11:50:30 -0300
Message-ID: <CAMGU2hVcKDi9YFXCjVimR_4L0+cAfn60qcwvFSuHe_u9dO5SDA@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] net: wget: let wget_with_dns work with dns
 disabled
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

El mar, 19 nov 2024 a las 6:27, Heinrich Schuchardt (<
heinrich.schuchardt@canonical.com>) escribi=C3=B3:

> On 18.11.24 22:08, Adriano Cordova wrote:
> > This was marked as TODO in the code:
> > -Enable use of wget_with_dns even if CMD_DNS is disabled if
> > the given uri has the ip address for the http server.
> > -Check for port in the uri when transforming to legacy wget
> > syntax inside wget_with_dns.
> > -Move the check for CMD_DNS inside wget_with_dns.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
>
> Changes in v4 are not described:
>
> * drop console output
> * avoid checking non-zero via '!=3D 0'.
>
> >
> > v3:
> >   Removed console output inside efi routine.
> >
> > (no changes since v2)
> >   net/wget.c | 36 +++++++++++++++++++++---------------
> >   1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/net/wget.c b/net/wget.c
> > index 3bc2522cde..1166aa5aa6 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -530,12 +530,10 @@ void wget_start(void)
> >       wget_send(TCP_SYN, 0, 0, 0);
> >   }
> >
> > -#if (IS_ENABLED(CONFIG_CMD_DNS))
> >   int wget_with_dns(ulong dst_addr, char *uri)
> >   {
> >       int ret;
> > -     char *s, *host_name, *file_name, *str_copy;
> > -
> > +     char *s, *host_name, *file_name, *str_copy, *port;
>
> nits:
> Missing empty line.
>
> >       /*
> >        * Download file using wget.
> >        *
> > @@ -550,24 +548,33 @@ int wget_with_dns(ulong dst_addr, char *uri)
> >       s =3D str_copy + strlen("http://");
> >       host_name =3D strsep(&s, "/");
> >       if (!s) {
> > -             log_err("Error: invalied uri, no file path\n");
> >               ret =3D -EINVAL;
> >               goto out;
> >       }
> >       file_name =3D s;
> >
> > -     /* TODO: If the given uri has ip address for the http server, ski=
p
> dns */
> > -     net_dns_resolve =3D host_name;
> > -     net_dns_env_var =3D "httpserverip";
> > -     if (net_loop(DNS) < 0) {
> > -             log_err("Error: dns lookup of %s failed, check setup\n",
> net_dns_resolve);
> > -             ret =3D -EINVAL;
> > -             goto out;
> > -     }
> > -     s =3D env_get("httpserverip");
> > -     if (!s) {
> > +     port =3D host_name;
> > +     host_name =3D strsep(&port, ":");
>
> RFC 1738 has:
>
> login          =3D [ user [ ":" password ] "@" ] hostport
> hostport       =3D host [ ":" port ]
>
> So here variable port may point to the password. And host_name to the
> user name. We might check for '@' and bail out with an error code if it
> occurs.
>
> You are determining the host port as a string, but I cannot see where
> you are ever using it.
>
> In wget_send_stored() I see this line:
>
> server_port =3D env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
>
> Maybe make server_port a static variable and set it here if variable
> port does not contain a number.
>
> Best regards
>
> Heinrich
>

The current documentation and implementation of wget is not compliant with
RFC 1738 and only supports ip:path. I will erase the port and leave the
wget parsing
as it is documented (ip:path). I think reworking the legacy wget parsing to
be RFC 1738
compliant can be done in a separate patch.

>
> > +
> > +     if (string_to_ip(host_name).s_addr) {
> > +             s =3D host_name;
> > +     } else {
> > +#if IS_ENABLED(CONFIG_CMD_DNS)
> > +             net_dns_resolve =3D host_name;
> > +             net_dns_env_var =3D "httpserverip";
> > +             if (net_loop(DNS) < 0) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +             s =3D env_get("httpserverip");
> > +             if (!s) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +#else
> >               ret =3D -EINVAL;
> >               goto out;
> > +#endif
> >       }
> >
> >       strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> > @@ -581,7 +588,6 @@ out:
> >
> >       return ret < 0 ? ret : 0;
> >   }
> > -#endif
> >
> >   /**
> >    * wget_validate_uri() - validate the uri for wget
>
>
