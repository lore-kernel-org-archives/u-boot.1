Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA55C83F17
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A61E835FD;
	Thu, 10 Jul 2025 01:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="GdNzEkIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49129835FE; Thu, 10 Jul 2025 01:53:37 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFA6835CE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eacb421554so201939fac.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1752105213; x=1752710013; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHxRwAuCXRRghE5c+ToYi4pRuXmviZaixQXHn2n6CkY=;
 b=GdNzEkIl9Cy2Rt54gec35nJH4VcrXSHrzpgLLGzzI/ChKO3C1dwG2Cu2hy0P/f0zud
 tun3tVdyTTtkcTF4xOQQ9+9OstAY2fTmpJFpqPHU1BH1wf8RRoLQlRrSQh65n5/ceCJ3
 x9lGOe0rrHd+YlTOhnKHyEP7VSxfi7h3AEzYCRepC1gEqQSf1Vpszbn2BIaZcIaujdz7
 iiqATQ8e5ehYZrdf7JL4Py7pQ0SonQKZ2v1d+p5chMP4Y49XWF5kvh7L9MRrrxbKgnmO
 zhgY4ubo/tVFswqRhakoXudGUJpzyE2Yep2SSO8lmUTu4zEjE7LGzNPq6dq1eje3Helz
 HApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752105213; x=1752710013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHxRwAuCXRRghE5c+ToYi4pRuXmviZaixQXHn2n6CkY=;
 b=cxbZ7zHN/libFZhiB9hnxh9tl2n5lMEVSWYGUb2wOepnkB7SgzgyZ9b37ZBWgcj7wt
 CjDCDW/23VvTzsUegDcX8XTDuZEepw0/rAVvlin1R0rlT0u0Fw36u1+Bnd0zvSuQEaZG
 ptuZzAl8SM+Sevy5k5e2/o9y4wh/O7vQFWVe8TzNMKV/g4rv0CcNCj8qqJrAtTm6I281
 V0WqAnw2ieGx1U0ob8CwVFNvJfsfembcjXSh91URgl8/Si2YXBzplgBxZZ4Rx4ryy13R
 bUUKhgZtAQzq8dtULxs4KONmMH9sdeA4WOPtfsj3j1b9SXizvQk0fp05N/IkPTsgYYmQ
 XzNQ==
X-Gm-Message-State: AOJu0YzL1q+JXsYiQ5LRTWyYOkS4nUH6YXsrsyj4HTCIx1Ms0kpl2eJQ
 HQnYwQZXz+6vLg+x66VnO9eLYDZdPwQD3SZEmVp+zKLltStpILXiWq9OIj61lF8YXrYurJrQPcV
 05ccJwKQC6vBFzbDp+BPSyx2uo0B5qhpqRUeHQ22Hqg==
X-Gm-Gg: ASbGnctgX8iJ0ioWelgiCBMiwcKAf3872Ex/pPjRw8TG6/UlXxyVEin8NH9DTyqMmc6
 eisKMgjEV+i6QpzZj7JEtMDNvusSNSIpwgAcEOt5p3lsffs36azkU7ZaVwjAum/uYom4I2vA+El
 2Tgmdi3j64A/VUzd1ve350bxv8x6ZY71Fe3PM2gEoWmOk=
X-Google-Smtp-Source: AGHT+IFaGlbynHqKHj9OZnwr0mj6+kwe4D9EbRtJJynehWdtSqFBbl8d7gYVtGpEx1EkY9Erc8I5MsprFbeG+p/32K0=
X-Received: by 2002:a05:6870:40d5:b0:2e8:7953:ece7 with SMTP id
 586e51a60fabf-2ff10991555mr456095fac.24.1752105213018; Wed, 09 Jul 2025
 16:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
 <20250415211819.1254435-2-jerome.forissier@linaro.org>
In-Reply-To: <20250415211819.1254435-2-jerome.forissier@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 9 Jul 2025 16:53:22 -0700
X-Gm-Features: Ac12FXyeO_RwFfFKsRBOFrP45Dn1ZTOsmzy_er-8leXKAznVBRaPB5xDnXD_cz0
Message-ID: <CAJ+vNU2Z-9n78B25g6h7AEEcWDQfKxM0vWymft2-LaWwpb-_2w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] net: lwip: fix initialization sequence before a
 command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Apr 15, 2025 at 2:18=E2=80=AFPM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The things that are done prior to executing a network command with
> NET_LWIP are not consistent with what is done with NET. It impacts the
> selection of the current device, and more precisely if the active device
> is invalid NET would return an error while NET_LWIP would try to pick a
> new device. This incorrect behavior was detected thanks to the eth_rotate
> sandbox test (dm_test_eth_rotate()).
>
> Fix it by re-using a sequence similar to what NET has in net_loop().
> This piece of code is inserted in a function called net_lwip_eth_start()
> renamed from net_lwip_eth_set_current().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  include/net-lwip.h  |  9 ++++++++-
>  net/lwip/dhcp.c     |  3 ++-
>  net/lwip/dns.c      |  3 ++-
>  net/lwip/net-lwip.c | 40 +++++++++++++++++++++++++++++-----------
>  net/lwip/ping.c     |  3 ++-
>  net/lwip/tftp.c     |  5 ++++-
>  net/lwip/wget.c     |  6 +++++-
>  7 files changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 64e5c720560..0d3bb8a8bd8 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -10,7 +10,14 @@ enum proto_t {
>         TFTPGET
>  };
>
> -void net_lwip_set_current(void);
> +static inline int eth_is_on_demand_init(void)
> +{
> +       return 1;
> +}
> +
> +int eth_init_state_only(void); /* Set active state */
> +
> +int net_lwip_eth_start(void);
>  struct netif *net_lwip_new_netif(struct udevice *udev);
>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
>  void net_lwip_remove_netif(struct netif *netif);
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 3b7e4700c6e..92bd7067a7f 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -115,7 +115,8 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc=
, char *const argv[])
>         int ret;
>         struct udevice *dev;
>
> -       net_lwip_set_current();
> +       if (net_lwip_eth_start() < 0)
> +               return CMD_RET_FAILURE;
>
>         dev =3D eth_get_dev();
>         if (!dev) {
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 149bdb784dc..19172ac959a 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -121,7 +121,8 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc,=
 char *const argv[])
>         if (argc =3D=3D 3)
>                 var =3D argv[2];
>
> -       net_lwip_set_current();
> +       if (net_lwip_eth_start() < 0)
> +               return CMD_RET_FAILURE;
>
>         return dns_loop(eth_get_dev(), name, var);
>  }
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 6b7b696dbf0..6748008736b 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -134,18 +134,27 @@ static int get_udev_ipv4_info(struct udevice *dev, =
ip4_addr_t *ip,
>         return 0;
>  }
>
> -/* Initialize the lwIP stack and the ethernet devices and set current de=
vice  */
> -void net_lwip_set_current(void)
> +/*
> + * Initialize the network stack if needed and start the current device i=
f valid
> + */
> +int net_lwip_eth_start(void)
>  {
> -       static bool init_done;
> +       int ret;
>
> -       if (!init_done) {
> -               eth_init_rings();
> -               eth_init();
> -               lwip_init();
> -               init_done =3D true;
> +       net_init();
> +       if (eth_is_on_demand_init()) {
> +               eth_halt();
> +               eth_set_current();
> +               ret =3D eth_init();
> +               if (ret < 0) {
> +                       eth_halt();
> +                       return ret;
> +               }
> +       } else {
> +               eth_init_state_only();
>         }
> -       eth_set_current();
> +
> +       return 0;
>  }
>
>  static struct netif *new_netif(struct udevice *udev, bool with_ip)
> @@ -224,11 +233,20 @@ void net_lwip_remove_netif(struct netif *netif)
>         free(netif);
>  }
>
> +/*
> + * Initialize the network buffers, an ethernet device, and the lwIP stac=
k
> + * (once).
> + */
>  int net_init(void)
>  {
> -       eth_set_current();
> +       static bool init_done;
>
> -       net_lwip_new_netif(eth_get_dev());
> +       if (!init_done) {
> +               eth_init_rings();
> +               eth_init();
> +               lwip_init();
> +               init_done =3D true;
> +       }
>
>         return 0;
>  }
> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
> index c586a96806d..542ef2cb148 100644
> --- a/net/lwip/ping.c
> +++ b/net/lwip/ping.c
> @@ -168,7 +168,8 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc=
, char *const argv[])
>         if (!ipaddr_aton(argv[1], &addr))
>                 return CMD_RET_USAGE;
>
> -       net_lwip_set_current();
> +       if (net_lwip_eth_start() < 0)
> +               return CMD_RET_FAILURE;
>
>         if (ping_loop(eth_get_dev(), &addr) < 0)
>                 return CMD_RET_FAILURE;
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 123d66b5dba..4f9b2049187 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -280,7 +280,10 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>                 goto out;
>         }
>
> -       net_lwip_set_current();
> +       if (net_lwip_eth_start() < 0) {
> +               ret =3D CMD_RET_FAILURE;
> +               goto out;
> +       }
>
>         if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>                 ret =3D CMD_RET_FAILURE;
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index ec098148835..a3b82908877 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -471,7 +471,11 @@ static int wget_loop(struct udevice *udev, ulong dst=
_addr, char *uri)
>
>  int wget_do_request(ulong dst_addr, char *uri)
>  {
> -       net_lwip_set_current();
> +       int ret;
> +
> +       ret =3D net_lwip_eth_start();
> +       if (ret < 0)
> +               return ret;
>
>         if (!wget_info)
>                 wget_info =3D &default_wget_info;
> --
> 2.43.0
>

Hi Jerome,

I'm seeing an issue with NET_LWIP related to this patch.

In net_lwip_eth_start the eth_init function is called first in
net_init then again within the if eth_is_on_demand. This causes a
situation where the netdev is started, then stopped and started again
and in the case of at least the dwc_eth_qos device this causes the phy
to drop link after negotiation has been performed the first time a
network operation occurs.

The situation is this on an imx8mp_venice board for any network action
(dhcp, tftp, etc):
u-boot=3D> dhcp
ethernet@30bf0000 Waiting for PHY auto negotiation to complete...... done
No link
FAILED: -11
eqos_start ethernet@30bf0000
No link
FAILED: -11
Could not start ethernet@30bf0000

Here is some debugging added:
lwip with eqos:
u-boot=3D> dhcp
net_lwip_eth_start
eth_start_udev ethernet@30bf0000 running=3D0
eqos_start ethernet@30bf0000 phy=3Dnull
eqos_start ethernet@30bf0000 calling phy_connect
eqos_start ethernet@30bf0000 connected to phy ethernet@30bf0000
eqos_start ethernet@30bf0000 calling phy_config
ethernet@30bf0000 Waiting for PHY auto negotiation to complete....... done
eth_start_udev ethernet@30bf0000 done running=3D1
^^^ this was a result of eth_init being called in net_init
net_lwip_eth_start calling eth_halt
eth_halt in_init_halt=3D0
eth_halt current=3Dethernet@30bf0000
eth_halt running=3D1
^^^ now, because we are already running halt continues on to halt the inter=
face
eth_halt ethernet@30bf0000 calling stop
eqos_stop ethernet@30bf0000
phy_shutdown ethernet@30bf0000
^^^ phy is shutdown here
net_lwip_eth_start calling eth_set_current
net_lwip_eth_start calling eth_init
eth_start_udev ethernet@30bf0000 running=3D0
eqos_start ethernet@30bf0000 phy=3Dethernet@30bf0000
^^^ phy links again but link has not been established by the time we
try to use it here
No link
phy_shutdown ethernet@30bf0000
FAILED: -11
eth_start_udev ethernet@30bf0000 running=3D0
eqos_start ethernet@30bf0000 phy=3Dethernet@30bf0000
eth_start_udev ethernet@30bf0000 done running=3D1
DHCP client bound to address 172.24.23.42 (1110 ms)
u-boot=3D> dhcp
net_lwip_eth_start
net_lwip_eth_start calling eth_halt
eth_halt in_init_halt=3D0
eth_halt current=3Dethernet@30bf0000
eth_halt running=3D1
eth_halt ethernet@30bf0000 calling stop
eqos_stop ethernet@30bf0000
phy_shutdown ethernet@30bf0000
net_lwip_eth_start calling eth_set_current
net_lwip_eth_start calling eth_init
eth_start_udev ethernet@30bf0000 running=3D0
eqos_start ethernet@30bf0000 phy=3Dethernet@30bf0000
eth_start_udev ethernet@30bf0000 done running=3D1
eth_start_udev ethernet@30bf0000 running=3D1
DHCP client bound to address 172.24.23.42 (29 ms)
^^^ any follow-on network operation is fine as the PHY has re-linked
at this point

legacy:
u-boot=3D> dhcp
net_loop calling eth_halt()
eth_halt in_init_halt=3D0
eth_halt current=3Dethernet@30bf0000
eth_halt running=3D0
^^^ does not call stop because its not running because eth_init hasn't
been called already
eqos_start ethernet@30bf0000
DP83867 ethernet@30bf0000 Waiting for PHY auto negotiation to
complete....... done
^^^ works

Here's another board (imx8mm_venice) which has a different MAC (fec)
that works fine with this patch:
u-boot=3D> dhcp
net_lwip_eth_start
net_init init_done=3D0
eth_start_udev ethernet@30be0000 running=3D0
fecmxc_init ethernet@30be0000
ethernet@30be0000 Waiting for PHY auto negotiation to complete.... done
eth_start_udev ethernet@30be0000 done running=3D1
net_lwip_eth_start calling eth_halt
eth_halt in_init_halt=3D0
eth_halt current=3Dethernet@30be0000
eth_halt running=3D1
eth_halt ethernet@30be0000 calling stop
fecmxc_halt ethernet@30be0000
^^^ halt is called but for this MAC it doesn't drop the link
net_lwip_eth_start calling eth_set_current
net_lwip_eth_start calling eth_init
eth_start_udev ethernet@30be0000 running=3D0
fecmxc_init ethernet@30be0000
eth_start_udev ethernet@30be0000 done running=3D1
eth_start_udev ethernet@30be0000 running=3D1
DHCP client bound to address 172.24.23.44 (1117 ms)

The difference here is the FEC mac driver (fec_mxc.c) is not disturbed
by a start->stop->start. I'm not exactly sure why this is... I thought
it was because the FEC driver configures the PHY in the probe vs the
start but even if I remove the phy_shutdown call from the EQOS driver
it still drops the link on eqos_stop.

Removing the call the eth_init from net_init makes NET_LWIP behave
like legacy and makes more sense as you don't get a
'start->stop->start' call sequence to your netdev but honestly I'm not
sure if this also points out an issue with either the fec driver or
the eqos driver regarding where/how the PHY is handled.

Would you agree with:

net: lwip: remove eth_init from net_init as its called later

The call to eth_init within net_init casues the network interface to
start, stop, start again which can cause issues with certain network
device drivers. Remove it to make it behave like the legacy network
path.

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 3918d57d7e58..d53faa39ba11 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -285,7 +285,6 @@ int net_init(void)

        if (!init_done) {
                eth_init_rings();
-               eth_init();
                lwip_init();
                init_done =3D true;
        }

Best Regards,

Tim
