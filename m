Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FBAC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18CAA883F4;
	Thu,  6 Jun 2024 14:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OnaQ6BaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1998823C; Thu,  6 Jun 2024 10:51:45 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C94F88027
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52b962c4bb6so948485e87.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717663902; x=1718268702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQhgUuE/HRv/WpZboKol8zWN7n+VTbFHFy7lAN3ySDw=;
 b=OnaQ6BaM95Ze58YmXcUM80CPpSrWKE0UdJPtobpUahX3Y8ZVRHNOCpLBOMuUaLcLp7
 f320QGMywant6/A4ObeZcEECPHAFGVP3B1wYZ6UwDcSf1SvDVZCljJ1lc+ZCN7wRNtEU
 qdxu9stJaPx5dHfSiJl0gA6Sx/HIwLBm364W9WUJp9zoNz15lDwLyH55kauB+CT+DjPV
 x22utxqVojjrr3LcLxy+53ixkKasTB7r/cG5+tGNR1+RxwVm1onKNDtU4MKXRbNfqn3W
 hePgg6xl22SZXA7k8LF66++UP5QQncAgKHCTZUEnB+Issegul2Dxj0bS5cWclq+T4EcO
 esLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717663902; x=1718268702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQhgUuE/HRv/WpZboKol8zWN7n+VTbFHFy7lAN3ySDw=;
 b=g9IjeqgempZGfS1/t783TxOr3hhvZTzSACKcF41+abT180ZAt1mQsFJjH76W0p0bPF
 PWvL0cpKXAedXLgxfJJQ0jim2ln9jQypdw7e/bvf8+WgBCX9JFmrOcIMNDGwxNL60CcL
 M8WmBHszAWV1clzOx9a/xj/dMysddlfk9LKT6Ok2ddqy958GEF4Qib89XN17ZKA2DSQN
 SO6Exue2ekSq/VIGgE+X2wBdPm8W8eER6LQZPjEg/d52xpjvpzhfnQEcmtq6XHivMcdo
 vnrFgFRzz8XvQ9kIdtYpcsmxN5iUFcwdOJJnGdE9YVc+SZ+QGD3cOmARbmuRGDjI4yl+
 g2Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUWjNKqICoE3MBuo0mda5U7S2UnG1IBf6H9l6/dGSPADQ8eeDWAwyOGkWZ4DNImDJMqeodMC9wly7aXOdSB/mGG/MOpw==
X-Gm-Message-State: AOJu0YyBB3fU3MPqV0OStthEceZwl/gLX7MW/MU3QLf2/M529t+B4Unp
 IhcIEhhL0YjDrEvvmiYyIGpsa7R0xe5HyhhVTCvZRKHdEGz+8x8WRUhxaqNhnp9h2fgZ0Yhpfj8
 luXRM5DYJNjKlSsyswvgf2KSCZbM=
X-Google-Smtp-Source: AGHT+IErXqoUjFUhOls9PfXcGILXxEAWqShXNddJXc7xzLcsPCdLIFvl2QmF6+wYQ305Wdt3F4TgRo6UUHPDYzBbuYM=
X-Received: by 2002:a05:6512:3194:b0:52b:9964:9dae with SMTP id
 2adb3069b0e04-52bab50b1abmr4040962e87.57.1717663902203; Thu, 06 Jun 2024
 01:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <b77a239e1fb9a81744d1da9a000979aac298fd29.1716566960.git.jerome.forissier@linaro.org>
 <CAC_iWjKrsG+fBNm3k__QtsiQSqH8OTyee6E-Oc7JFCmn8WhyPQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKrsG+fBNm3k__QtsiQSqH8OTyee6E-Oc7JFCmn8WhyPQ@mail.gmail.com>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Thu, 6 Jun 2024 11:51:30 +0300
Message-ID: <CAJGZr0KqWVJe4pmjVZc=or0PUBF6VBVbTLC3+41s1s=xKkj7BA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] net-lwip: add dns command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

=D1=87=D1=82, 6 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 09:29, Ilia=
s Apalodimas <ilias.apalodimas@linaro.org>:
>
> Hi Jerome,
>
> [...]
>
> > +
> > +static ulong start;
> > +static ip_addr_t host_ipaddr;
> > +static bool done;
> > +
> > +static void do_dns_tmr(void *arg)
> > +{
> > +     dns_tmr();
> > +}
> > +
> > +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *ar=
g)
> > +{
> > +     char *var =3D (char *)arg;
>
> const char *
>
>
> > +     char *ipstr =3D ip4addr_ntoa(ipaddr);
> > +
> > +     done =3D true;
> > +
> > +     if (!ipaddr) {
> > +             printf("DNS: host not found\n");
> > +             host_ipaddr.addr =3D 0;
> > +             return;
> > +     }
> > +
> > +     if (var)
> > +             env_set(var, ipstr);
> > +
> > +     printf("%s\n", ipstr);
> > +}
> > +
> > +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[])
> > +{
> > +     bool has_server =3D false;
> > +     ip_addr_t ipaddr;
> > +     ip_addr_t ns;
> > +     char *nsenv;
> > +     char *name;
> > +     char *var;
> > +     int ret;
> > +
> > +     if (argc =3D=3D 1 || argc > 3)
> > +             return CMD_RET_USAGE;
> > +
> > +     if (argc >=3D 2)
> > +             name =3D argv[1];
> > +
> > +     if (argc =3D=3D 3)
> > +             var =3D argv[2];
> > +
> > +     dns_init();
> > +
> > +     nsenv =3D env_get("dnsip");
> > +     if (nsenv && ipaddr_aton(nsenv, &ns)) {
> > +             dns_setserver(0, &ns);
> > +             has_server =3D true;
> > +     }
> > +
> > +     nsenv =3D env_get("dnsip2");
> > +     if (nsenv && ipaddr_aton(nsenv, &ns)) {
> > +             dns_setserver(1, &ns);
> > +             has_server =3D true;
> > +     }
> > +
> > +     if (!has_server) {
> > +             log_err("No valid name server (dnsip/dnsip2)\n");
> > +             return CMD_RET_FAILURE;
> > +     }
> > +
> > +     done =3D false;
> > +
> > +     ret =3D dns_gethostbyname(name, &ipaddr, dns_cb, var);
> > +
> > +     if (ret =3D=3D ERR_OK) {
> > +             dns_cb(name, &ipaddr, var);
> > +     } else if (ret =3D=3D ERR_INPROGRESS) {
> > +             start =3D get_timer(0);
> > +             sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
> > +             do {
> > +                     eth_rx();
> > +                     if (done)
> > +                             break;
> > +                     sys_check_timeouts();
> > +                     if (ctrlc()) {
> > +                             printf("\nAbort\n");
> > +                             break;
> > +                     }
> > +             } while (get_timer(start) < DNS_TIMEOUT_MS);
> > +             sys_untimeout(do_dns_tmr, NULL);
> > +     }
>
> Looking at the lwip code there are other ret values than just ERR_OK,
> ERR_INPROGRESS. Should we have an 'else' handling the rest?
>
+1
And check the return code of eth_rx(), that is int function
and current code for some reason skips this check.

BR,
Maxim.

> > +
> > +     if (done && host_ipaddr.addr !=3D 0)
> > +             return CMD_RET_SUCCESS;
> > +
> > +     return CMD_RET_FAILURE;
> > +}
> > +
> > --
> > 2.40.1
> >
>
> Thanks
> /Ilias



--=20
Best regards,
Maxim Uvarov
