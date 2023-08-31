Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C6C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 10:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6FA8655C;
	Thu, 31 Aug 2023 12:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0CA8656F; Thu, 31 Aug 2023 12:28:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F96F86558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id CDBA9644A91C;
 Thu, 31 Aug 2023 12:28:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id HcXa2gwH1Ynv; Thu, 31 Aug 2023 12:28:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 5A2C8644A91D;
 Thu, 31 Aug 2023 12:28:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 0GHelFXQPQQX; Thu, 31 Aug 2023 12:28:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id 39636644A918;
 Thu, 31 Aug 2023 12:28:00 +0200 (CEST)
Date: Thu, 31 Aug 2023 12:27:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, trini@konsulko.com
Message-ID: <404816774.38.1693477679941.JavaMail.zimbra@nod.at>
In-Reply-To: <20230720125156.31773-1-richard@nod.at>
References: <20230720125156.31773-1-richard@nod.at>
Subject: Re: [PATCH] net: wget: Avoid packet queue overflow
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: wget: Avoid packet queue overflow
Thread-Index: yw95irNgif8D2X6jiKxVnze9Fu9Cow==
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

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
> An: u-boot@lists.denx.de
> CC: "richard" <richard@nod.at>, "Joe Hershberger" <joe.hershberger@ni.com=
>, "Ramon Fried" <rfried.dev@gmail.com>
> Gesendet: Donnerstag, 20. Juli 2023 14:51:56
> Betreff: [PATCH] net: wget: Avoid packet queue overflow

> Make sure to stay within bounds, as a misbehaving HTTP server
> can trigger a buffer overflow if not properly handled.
>=20
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> net/wget.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/wget.c b/net/wget.c
> index 2dbfeb1a1d5b..8bb4d72db1ae 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -35,7 +35,8 @@ struct pkt_qd {
>  * The actual packet bufers are in the kernel space, and are
>  * expected to be overwritten by the downloaded image.
>  */
> -static struct pkt_qd pkt_q[PKTBUFSRX / 4];
> +#define PKTQ_SZ (PKTBUFSRX / 4)
> +static struct pkt_qd pkt_q[PKTQ_SZ];
> static int pkt_q_idx;
> static unsigned long content_length;
> static unsigned int packets;
> @@ -202,6 +203,13 @@ static void wget_connected(uchar *pkt, unsigned int
> tcp_seq_num,
> =09=09pkt_q[pkt_q_idx].tcp_seq_num =3D tcp_seq_num;
> =09=09pkt_q[pkt_q_idx].len =3D len;
> =09=09pkt_q_idx++;
> +
> +=09=09if (pkt_q_idx >=3D PKTQ_SZ) {
> +=09=09=09printf("wget: Fatal error, queue overrun!\n");
> +=09=09=09net_set_state(NETLOOP_FAIL);
> +
> +=09=09=09return;
> +=09=09}
> =09} else {
> =09=09debug_cond(DEBUG_WGET, "wget: Connected HTTP Header %p\n", pkt);
> =09=09/* sizeof(http_eom) - 1 is the string length of (http_eom) */

Friendly ping. :-)

Thanks,
//richard
