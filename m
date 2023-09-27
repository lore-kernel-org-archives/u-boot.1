Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C611CE7A8B
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 04:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF9986D20;
	Wed, 27 Sep 2023 06:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DCE86D4D; Wed, 27 Sep 2023 06:11:29 +0200 (CEST)
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
 [80.67.31.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D99486BF5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 06:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay05.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <LW@KARO-electronics.de>)
 id 1qlLtW-0007dR-HX; Wed, 27 Sep 2023 06:11:26 +0200
Date: Wed, 27 Sep 2023 06:11:25 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCH 2/3] net: bootp: BOOTP/DHCPv4 retransmission improvements
Message-ID: <20230927061125.3f1702a0@karo-electronics.de>
In-Reply-To: <20230925202935.118652-3-seanedmond@linux.microsoft.com>
References: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
 <20230925202935.118652-3-seanedmond@linux.microsoft.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

Hi,

On Mon, 25 Sep 2023 13:29:34 -0700 seanedmond@linux.microsoft.com wrote:
> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> This patch introduces 3 improvements to align with RFC 951:
> - retransmission backoff interval maximum is configurable
> - initial retranmission backoff interval is configurable
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>=20
> In applications where thousands of nodes are serviced by a single DHCP
> server, maximizing the retransmission backoff interval at 2 seconds (the
> current u-boot default) exerts high pressure on the DHCP server and
> network layer.
>=20
> RFC 951 =E2=80=9C7.2. Client Retransmission Strategy=E2=80=9D states that=
 the
> retransmission backoff interval should maximize at 60 seconds.  This
> patch allows the interval to be configurable using the environment
> variable "bootpretransmitperiodmax"
>=20
> The initial retranmission backoff period defaults to 250ms, which is
> also too small for these scenarios with many clients.  This patch makes
> the initial retransmission interval to be configurable using the
> environment variable "bootpretransmitperiodinit".
>=20
> Also, on a retransmission it is not expected for the transaction ID to
> change (only the 'secs' field should be updated). Let's save the
> transaction ID and use the same transaction ID for each BOOTP/DHCPv4
> exchange.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  net/bootp.c | 63 +++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 16 deletions(-)
>=20
> diff --git a/net/bootp.c b/net/bootp.c
> index 013d54c7ed..7248536cc4 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -42,6 +42,17 @@
>   */
>  #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
> =20
> +/*
> + * According to rfc951 : 7.2. Client Retransmission Strategy
> + * "After the 'average' backoff reaches about 60 seconds, it should be
> + * increased no further, but still randomized."
> + *
> + * U-Boot has saturated this backoff at 2 seconds for a long time.
> + * To modify, set the environment variable "bootpretransmitperiodmax"
> + */
> +#define RETRANSMIT_PERIOD_MAX_MS	2000
> +#define RETRANSMIT_PERIOD_INIT_MS	250
> +
>  #define PORT_BOOTPS	67		/* BOOTP server UDP port */
>  #define PORT_BOOTPC	68		/* BOOTP client UDP port */
> =20
> @@ -56,6 +67,7 @@
>  u32		bootp_ids[CFG_BOOTP_ID_CACHE_SIZE];
>  unsigned int	bootp_num_ids;
>  int		bootp_try;
> +u32		bootp_id;
>  ulong		bootp_start;
>  ulong		bootp_timeout;
>  char net_nis_domain[32] =3D {0,}; /* Our NIS domain */
> @@ -63,6 +75,7 @@ char net_hostname[32] =3D {0,}; /* Our hostname */
>  char net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN] =3D {0,}; /* Our boot=
path */
> =20
>  static ulong time_taken_max;
> +static u32   retransmit_period_max_ms;
> =20
>  #if defined(CONFIG_CMD_DHCP)
>  static dhcp_state_t dhcp_state =3D INIT;
> @@ -417,8 +430,8 @@ static void bootp_timeout_handler(void)
>  		}
>  	} else {
>  		bootp_timeout *=3D 2;
> -		if (bootp_timeout > 2000)
> -			bootp_timeout =3D 2000;
> +		if (bootp_timeout > retransmit_period_max_ms)
> +			bootp_timeout =3D retransmit_period_max_ms;
>  		net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
>  		bootp_request();
>  	}
> @@ -714,10 +727,18 @@ static int bootp_extended(u8 *e)
> =20
>  void bootp_reset(void)
>  {
> +	char *ep;  /* Environment pointer */
> +
>  	bootp_num_ids =3D 0;
>  	bootp_try =3D 0;
>  	bootp_start =3D get_timer(0);
> -	bootp_timeout =3D 250;
> +
> +	ep =3D env_get("bootpretransmitperiodinit");
> +	if (ep)
> +		bootp_timeout =3D dectoul(ep, NULL);
> +	else
> +		bootp_timeout =3D RETRANSMIT_PERIOD_INIT_MS;
> +
bootp_timeout =3D env_get_ulong("bootpretransmitperiodinit", 0, RETRANSMIT_=
PERIOD_INIT_MS);
does the same...

>  }
> =20
>  void bootp_request(void)
> @@ -729,7 +750,6 @@ void bootp_request(void)
>  #ifdef CONFIG_BOOTP_RANDOM_DELAY
>  	ulong rand_ms;
>  #endif
> -	u32 bootp_id;
>  	struct in_addr zero_ip;
>  	struct in_addr bcast_ip;
>  	char *ep;  /* Environment pointer */
> @@ -745,6 +765,12 @@ void bootp_request(void)
>  	else
>  		time_taken_max =3D TIMEOUT_MS;
> =20
> +	ep =3D env_get("bootpretransmitperiodmax");
> +	if (ep)
> +		retransmit_period_max_ms =3D dectoul(ep, NULL);
> +	else
> +		retransmit_period_max_ms =3D RETRANSMIT_PERIOD_MAX_MS;
> +
see above


Lothar Wa=C3=9Fmann
