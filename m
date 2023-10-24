Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F6AC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 06:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A145E87086;
	Tue, 24 Oct 2023 08:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="o9qwyY7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AC886D2E; Tue, 24 Oct 2023 08:06:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576FD8272A
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 08:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698127558; x=1698732358; i=xypron.glpk@gmx.de;
 bh=E4WEYYoTUXa9KI2p3ozJ4b+sdMOPylkm7/defs7e9+Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=o9qwyY7JW6rqV8Y7ao9UfANrjDRPggXk/ee9VKwe0MPWDJcW0wZkvz0rRMF90o1g
 RazSsCQjMotHR47r9OybtwgtIFYkL9ODDW5ylWc++T1nU7rzeT+8+Qx353DPCgVq4
 /+0+ZURhzSjl7mLWIENQsR73DfQOmhX5UWCPVQmdMdDmioao1DgbnqEaehIApAv//
 VUkzsY5ojahAL1ITKegr5V6n4WkibwvfK0dB9BM27lxkxB1dwawULu6Y0/psRVZlZ
 IC2qntr5lBKl2mMj954iRcmvalVZMVLHOGCRoU9Pw5TWiDaIezJDAwARjSi+VZqKY
 ilAitHCcNh12os/R8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1r80Zg1iuP-00MMsW; Tue, 24
 Oct 2023 08:05:57 +0200
Message-ID: <5d6aba63-d050-4365-8a4d-9cd2b528e804@gmx.de>
Date: Tue, 24 Oct 2023 08:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: bootp: BOOTP/DHCPv4 retransmission
 improvements
Content-Language: en-US, de-DE
To: seanedmond@linux.microsoft.com
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-3-seanedmond@linux.microsoft.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231024002159.74477-3-seanedmond@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eEZ7+fSHJ16YqBVpL1hFCCdQ+BjIoSv/8DSxI87f+5tc+AH+kR4
 aQ3tPsnteqjwxkmETo3BuM6I1DW7fdbY/O6SGosjxcmPxTtH74t+XrX9GhOZ1KHSFh/c9s8
 GMmvgzbQ3k3+wn7GuFu3nk4nAAfPjlti/oi5VJcKwA0D5riyZ48ukPEI7UGtE395spiTEM5
 oBQopmustKULTZwkyG65g==
UI-OutboundReport: notjunk:1;M01:P0:9tQb0yZKya4=;KP7PszifcJgp3K88sEsEDcpnyfs
 WB6t82fxjQsu3wzC51V4gA0IaLkO+XF0JYZU9VWrrYcuGqTylBSvwTSr9uyf3iaq+wS+FMoDe
 0JgoScJK3gOtIJ82XFHLrjPUqb0XqzhHwef7ajpBGGi8sB59cKZu1i9SpLp6Xy7Hr85264Qnk
 OACZZPTx1BCb483K72F3eRW1wkBIEhw9jf+3bF1Yjy8QSKoIP4+71bv+keBVlvZjmbqWKX7N6
 CZfKnW+Ei5VvpJnLTDr1pv09wH6PALXuczCBQ8rsu7lu4IP7nsa9ovgZ7/E8+qvNPQsHMADTK
 9FJ/A/OwagU0O/hlDBmGCIrKUCoq6Ji2zRBjVPWP1SWbqiRSEpNSnfGpydYQeQCKYkvpIm7QC
 AEUDXGvTIq5MEsBBlSyQnJ/z/l5IKBt/UGrDg75WWMJS76tBVHp37uU+c0CCmTZU4pMCxFotK
 Zqv4emhhLsIZL9Z42qRqEaAi8coB79avUuinH4E+p5I4SH/XdtmFhDIxUBvLqSfuIlyHTeMgz
 emOyHDkJlaHdua37jOcBvU8CSb3j/dxX/GFVGWLgR0hROhJE5lbSbPJ7L7QZ3sLjeubx4Z1Ol
 XafMUo7zZR7F0CoSiez2xKAt7Ase7ArJQS/QFE/27GfqmuzQO9+s3OWGXcR07WxlmZpJIJl50
 d7ZZY37/2iFTuM15maNEXrC3Lbs2yVgG0Kk15EKbor2JMH9IXhxdhwGQ1Br9dnQsqjNkBGn4a
 9ua8SKAadEy/ApZr5WrJjsmt/nATnyGiRp9821LUayz3+5MiLtPLZazhAX4EnehoELqzjG+jk
 K2
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

On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
> From: Sean Edmond <seanedmond@microsoft.com>
>
> This patch introduces 3 improvements to align with RFC 951:
> - retransmission backoff interval maximum is configurable
> - initial retranmission backoff interval is configurable
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>
> In applications where thousands of nodes are serviced by a single DHCP
> server, maximizing the retransmission backoff interval at 2 seconds (the
> current u-boot default) exerts high pressure on the DHCP server and
> network layer.
>
> RFC 951 =E2=80=9C7.2. Client Retransmission Strategy=E2=80=9D states tha=
t the
> retransmission backoff interval should maximize at 60 seconds.  This

%s/maximize at/be limited to/

> patch allows the interval to be configurable using the environment
> variable "bootpretransmitperiodmax"

If there is an RFC defining the value, why do we need an environment
variable?

>
> The initial retranmission backoff period defaults to 250ms, which is
> also too small for these scenarios with many clients.  This patch makes
> the initial retransmission interval to be configurable using the
> environment variable "bootpretransmitperiodinit".
>
> Also, on a retransmission it is not expected for the transaction ID to
> change (only the 'secs' field should be updated). Let's save the
> transaction ID and use the same transaction ID for each BOOTP/DHCPv4
> exchange.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>   net/bootp.c | 56 ++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 40 insertions(+), 16 deletions(-)
>
> diff --git a/net/bootp.c b/net/bootp.c
> index 6800290963..bab17a9ceb 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -42,6 +42,17 @@
>    */
>   #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
>
> +/*
> + * According to rfc951 : 7.2. Client Retransmission Strategy
> + * "After the 'average' backoff reaches about 60 seconds, it should be
> + * increased no further, but still randomized."
> + *
> + * U-Boot has saturated this backoff at 2 seconds for a long time.
> + * To modify, set the environment variable "bootpretransmitperiodmax"
> + */
> +#define RETRANSMIT_PERIOD_MAX_MS	2000

This does not match RFC 951. Please, why shouldn't we use the standard
value by default?

> +#define RETRANSMIT_PERIOD_INIT_MS	250

This constant should be described too.

> +
>   #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
>   #define CFG_DHCP_MIN_EXT_LEN 64
>   #endif
> @@ -53,6 +64,7 @@
>   u32		bootp_ids[CFG_BOOTP_ID_CACHE_SIZE];
>   unsigned int	bootp_num_ids;
>   int		bootp_try;
> +u32		bootp_id;
>   ulong		bootp_start;
>   ulong		bootp_timeout;
>   char net_nis_domain[32] =3D {0,}; /* Our NIS domain */
> @@ -60,6 +72,7 @@ char net_hostname[32] =3D {0,}; /* Our hostname */
>   char net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN] =3D {0,}; /* Our bo=
otpath */
>
>   static ulong time_taken_max;
> +static u32   retransmit_period_max_ms;
>
>   #if defined(CONFIG_CMD_DHCP)
>   static dhcp_state_t dhcp_state =3D INIT;
> @@ -414,8 +427,8 @@ static void bootp_timeout_handler(void)
>   		}
>   	} else {
>   		bootp_timeout *=3D 2;
> -		if (bootp_timeout > 2000)
> -			bootp_timeout =3D 2000;
> +		if (bootp_timeout > retransmit_period_max_ms)
> +			bootp_timeout =3D retransmit_period_max_ms;

RFC 951 requires that the backoff time is randomized.

Best regards

Heinrich

>   		net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
>   		bootp_request();
>   	}
> @@ -711,10 +724,14 @@ static int bootp_extended(u8 *e)
>
>   void bootp_reset(void)
>   {
> +	char *ep;  /* Environment pointer */
> +
>   	bootp_num_ids =3D 0;
>   	bootp_try =3D 0;
>   	bootp_start =3D get_timer(0);
> -	bootp_timeout =3D 250;
> +
> +	bootp_timeout =3D env_get_ulong("bootpretransmitperiodinit", 10, RETRA=
NSMIT_PERIOD_INIT_MS);
> +
>   }
>
>   void bootp_request(void)
> @@ -726,7 +743,6 @@ void bootp_request(void)
>   #ifdef CONFIG_BOOTP_RANDOM_DELAY
>   	ulong rand_ms;
>   #endif
> -	u32 bootp_id;
>   	struct in_addr zero_ip;
>   	struct in_addr bcast_ip;
>   	char *ep;  /* Environment pointer */
> @@ -742,6 +758,9 @@ void bootp_request(void)
>   	else
>   		time_taken_max =3D TIMEOUT_MS;
>
> +	retransmit_period_max_ms =3D env_get_ulong("bootpretransmitperiodmax",=
 10,
> +						 RETRANSMIT_PERIOD_MAX_MS);
> +
>   #ifdef CONFIG_BOOTP_RANDOM_DELAY		/* Random BOOTP delay */
>   	if (bootp_try =3D=3D 0)
>   		srand_mac();
> @@ -801,18 +820,23 @@ void bootp_request(void)
>   	extlen =3D bootp_extended((u8 *)bp->bp_vend);
>   #endif
>
> -	/*
> -	 *	Bootp ID is the lower 4 bytes of our ethernet address
> -	 *	plus the current time in ms.
> -	 */
> -	bootp_id =3D ((u32)net_ethaddr[2] << 24)
> -		| ((u32)net_ethaddr[3] << 16)
> -		| ((u32)net_ethaddr[4] << 8)
> -		| (u32)net_ethaddr[5];
> -	bootp_id +=3D get_timer(0);
> -	bootp_id =3D htonl(bootp_id);
> -	bootp_add_id(bootp_id);
> -	net_copy_u32(&bp->bp_id, &bootp_id);
> +	/* Only generate a new transaction ID for each new BOOTP request */
> +	if (bootp_try =3D=3D 1) {
> +		/*
> +		 *	Bootp ID is the lower 4 bytes of our ethernet address
> +		 *	plus the current time in ms.
> +		 */
> +		bootp_id =3D ((u32)net_ethaddr[2] << 24)
> +			| ((u32)net_ethaddr[3] << 16)
> +			| ((u32)net_ethaddr[4] << 8)
> +			| (u32)net_ethaddr[5];
> +		bootp_id +=3D get_timer(0);
> +		bootp_id =3D htonl(bootp_id);
> +		bootp_add_id(bootp_id);
> +		net_copy_u32(&bp->bp_id, &bootp_id);
> +	} else {
> +		net_copy_u32(&bp->bp_id, &bootp_id);
> +	}
>
>   	/*
>   	 * Calculate proper packet lengths taking into account the

