Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A84C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B01240412;
	Wed, 26 Aug 2026 16:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6L8nL8uy1JkG; Wed, 26 Aug 2026 16:17:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787761065;
	bh=xIkZjZblW1Nka/knUDEqTSWOwyvIqa8frr1bxBkNUZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P7aY72OYXaACjxcw0SFGEi82o/8BZyjQE3uAPy6RrssrTRE/k3ZY0E1lDqd3I1OnN
	 tBbp6dmW1jjwY3xb+iMp/ruAyxSwTHT9TKfZ7UpspLpAbcv7x7m+L3PyMjksDT1qtB
	 dNfOH+HPQiXeOG6yUFigEGCO5E8rahxI7IpRzkymjWkuNEN3bGnRplEDvmQ5JRv0Z8
	 L3sGUdU4hknoFd02xTy7CkvdFImLF4WP30BXy1xTXsiSaddUmKz08iawQ4PjwykVXs
	 D53JskSkmhU2bmlXuv8GBBrWheoZXWARlZjmRX+bZvxdq28tnTAI6y1PJz1nAAhsnc
	 zRgOcIIcFcHqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ADEA4041A;
	Wed, 26 Aug 2026 16:17:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16B1529B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F117840118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvIOiz5XQvRI for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:17:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::934; helo=mail-ua1-x934.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PtqxgNuD
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBE28400C2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:17:42 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-966eabad303so331122241.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787761061; cv=none;
 d=google.com; s=arc-20260327;
 b=jLm0bnf1tgArtr8jaVctyfABFOs/WPyvPHlTJmVukBn4MXOX5OnyK7salDvvx8LJ90
 ErzHM+TXSsWpmFLadmCnT+Ze2krgLqTNQtO0scpwmjIl6qH9hs2pRzr38V7VhpGN8ysy
 Ro4xWRJCVT6ISVE1mOZIcibemjvkOsvKRf2+qBNX/EjfeSdJhJqHBF0UctgNNY/xBVBg
 Xo0+MllRN2OkmbAe4Vq8PpkAU7i+jTBAo4bhChnRTZie8DFTi+9UxCOnRxE5g7zliWqt
 kh7/tTDJUWT5Jv/wodZvf14y6RLaWUnNGEGjLGfuEnpD4UeFMriVxV9CB2rARS0xzUUU
 FyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xIkZjZblW1Nka/knUDEqTSWOwyvIqa8frr1bxBkNUZM=;
 fh=fMmC/SpKfcSdTmLPZWELmtXTtHkTNqn4UjSmswvF3js=;
 b=c6tkO/chW4dW0x81/NG6qy4ESorPgX0VslMyW/OMO17EnlH7MGu8Y858LYqYioN0OU
 mGeCLQsb5IiUnb+YMadG10eWMsQDxUjIBRsI7TCJ3Sw57Xvr/TD3j7FT9gK5FYsrqFnJ
 ex3TJwXrqcvUZCwToazDUheFKKBTYtqueo0Hi+rnfnjC7MFi3SLFKjobryuPNjw7saxy
 JoXrAPPY+gI/XPF8+s1G5DNgqggTl1pRmcA0Dqj9CS6s4M1x/Z4zZQ7RN/MdyizhFC9H
 QuY7ucT6DGqO6z0PqRqFq7YlMlYMAb7Dc7N7MFFUOsNLd1q4J05p64ZC/MqQjCuwD8Y/
 HoRg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787761061; x=1788365861;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xIkZjZblW1Nka/knUDEqTSWOwyvIqa8frr1bxBkNUZM=;
 b=PtqxgNuDRXMk0gDkVhCm0/ow/pClowfB9tOrjV8mHpQkD26Co+ZJojDu9PFrgqlTLo
 Rxcsu345NsPSL2XF1a3XrnMVr8FkzPaS7MCZRBKEGoDsGS0cvwYZaYf8i8uxunBd78av
 mBW2wWESjrCRHQwTSNC1b4zKbMvxM6rvXJ9fbxl+OdbAMSZ8W8LD4pIHNB34Mm+MPVFe
 hyAZvapiGLHSP2MSrs8SRXH5lzZnM7wRphl/uB58M789/wiXNTBkEW0Qq08JPT4Dk+oq
 rO64rXdwd7z/hjnx04xYMybhB+146UuWDjkoSm9+HF8P5hwPEjg38sqDfNp6rkTziZZt
 6FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761061; x=1788365861;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xIkZjZblW1Nka/knUDEqTSWOwyvIqa8frr1bxBkNUZM=;
 b=d3KLsZv0x4fOGRmA02IFUiDVaBOO6nFhyzgKi/Ag6Em1nyzVARzKaR7lB9Soaqy+kJ
 u4oozBAa0x8CS7yLZyMUZWDtSJdGIDg/wmQ84bqU3/agAv/wkS4yxVMGjbXnb7Mft9l/
 TRGA3f5hGG/HWINIOcpESEp9bV0QgbeckMzpHintGzB2eWQNEJBPg4FAM5GJsu6MWY7I
 3MKe47guAjFP6Oj5+NP9fyZyY9OsFYRe5VP954Z7k0cpGPsIcuKEE4hcCMEFkfcT2jj8
 D/mUKc7VQNXsKnuFYOvypWuyMMeDZPr1XzNntNE0kbYOtfeuae8H2OLt64CVlOoNiS74
 sDtQ==
X-Gm-Message-State: AFuF++kdACb/JYvMDDXP4so4Hk+1PBSppNKWOggf5YczqEeepvIi9Lxv
 8mUnmUtqMRSzlsU8MWMEWoF7POwNM7Sagy17oNBOR8znWft6NHyZoGlILbaY6G0JDd7k0tPVwSV
 A5OVa4NZdpIWttgzkdZT4PuEXHm6/n8L87CYN
X-Gm-Gg: AR+sD13jSuXJrM1p1GpCfRiPcC/XZ347Hc2HNInem/uqi6jVcsDVccBks+2KTGpq+Uh
 NUhiWJdiC3LwPJFJ2aqMEnYfLTKL4Rbe4tg9U8TZXuK6yJaounov+e0/HSgfIgTkPv6aSgwWHqO
 kuGiS4Lc6/Uz5nuvRHs/1WHbfnevjvG0YGt4Mrls7L0032fLrmKuLja7O2Me59GNItrg/m2jh6n
 p80dy8Rv/tyzbPI8bepYcgUoEwJZa7ZEPZV/PnUn2Lf7BrpW0FbG0ENkRd4M41aIXTAlu0ITN6L
 ElUz91+vcxs0d5jGgxzhn9Xs4wDogfMfMWnftdMPrUd3rc8mQ3s3bVfSQndIn9Z8cblfmvYsa8V
 cXcxEDKffWHiXw+3jkyXkRpqP1wafFKltXHNQTa0HzY/4SvwxEQjQmHva6KIn18cQjBylB+ulZN
 rlX8CTEgul14N8vHZJ6Qiah7PxBA+00+HR1B94
X-Received: by 2002:a05:6122:507:b0:5c3:61c2:9ec6 with SMTP id
 71dfb90a1353d-5c65c74c45bmr3183720e0c.7.1787761061178; Wed, 26 Aug 2026
 09:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-lwip-syslog-v1-v1-1-53210f44fd76@gmail.com>
 <CALeDE9P+gbt0vg4knDR1f4Z-0OmndNvZhqtjN-xuM2e2bXnvtQ@mail.gmail.com>
In-Reply-To: <CALeDE9P+gbt0vg4knDR1f4Z-0OmndNvZhqtjN-xuM2e2bXnvtQ@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 26 Aug 2026 10:17:29 -0600
X-Gm-Features: AcwNN1Xd4sY4hw5CADs1T5c6EwKgYeqhhsjyj_lOOEz6EUuevP-Jq6RepKwVpwg
Message-ID: <CADvTj4otwHzef-Ta-c77ucY-aTv4G1xVYESZ6Op_CP3AnZQJHQ@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: support syslog
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, Aug 26, 2026 at 3:49=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Tue, 25 Aug 2026 at 19:59, James Hilliard <james.hilliard1@gmail.com> =
wrote:
> >
> > LOG_SYSLOG depends on NET, but the raw Ethernet and UDP header
> > builders it uses are only available with the legacy network stack. This
> > makes LOG_SYSLOG fail to build with NET_LWIP.
> >
> > Provide lwIP implementations using the selected Ethernet device and its
> > indexed IP address from the environment. Move the shared declarations t=
o
> > net-common.h and extend the syslog test to check the source MAC address
> > and IPv4 header checksum.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  include/net-common.h   |  7 ++++++
> >  include/net-legacy.h   |  4 ----
> >  net/lwip/net-lwip.c    | 58 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  test/log/syslog_test.c |  2 ++
> >  test/log/syslog_test.h |  4 ++--
> >  5 files changed, 69 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net-common.h b/include/net-common.h
> > index 0c260873c2c..3084a2b2a57 100644
> > --- a/include/net-common.h
> > +++ b/include/net-common.h
> > @@ -362,6 +362,13 @@ struct ethernet_hdr {
> >  /* Ethernet header size */
> >  #define ETHER_HDR_SIZE (sizeof(struct ethernet_hdr))
> >
> > +/* Set Ethernet header; returns the size of the header */
> > +int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot);
> > +
> > +/* Set IPv4 and UDP headers */
> > +void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
> > +                       int sport, int len);
> > +
> >  /**
> >   * net_random_ethaddr - Generate software assigned random Ethernet add=
ress
> >   * @addr: Pointer to a six-byte array containing the Ethernet address
> > diff --git a/include/net-legacy.h b/include/net-legacy.h
> > index d3b122c9062..d7f55d34a30 100644
> > --- a/include/net-legacy.h
> > +++ b/include/net-legacy.h
> > @@ -344,15 +344,11 @@ int net_loop(enum proto_t);
> >  /* Get size of the ethernet header when we send */
> >  int net_eth_hdr_size(void);
> >
> > -/* Set ethernet header; returns the size of the header */
> > -int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot);
> >  int net_update_ether(struct ethernet_hdr *et, uchar *addr, uint prot);
> >
> >  /* Set IP header */
> >  void net_set_ip_header(uchar *pkt, struct in_addr dest, struct in_addr=
 source,
> >                        u16 pkt_len, u8 proto);
> > -void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
> > -                       int sport, int len);
> >
> >  /* Callbacks */
> >  rxhand_f *net_get_udp_handler(void);   /* Get UDP RX packet handler */
> > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > index 8f8f9d69020..4dd8f0d2ce7 100644
> > --- a/net/lwip/net-lwip.c
> > +++ b/net/lwip/net-lwip.c
> > @@ -159,6 +159,64 @@ static int get_udev_ipv4_info(struct udevice *dev,=
 ip4_addr_t *ip,
> >         return 0;
> >  }
>
> If these are specific to LOG_SYSLOG functionality I think they should
> be guarded by LOG_SYSLOG

The lwIP implementations are only used by LOG_SYSLOG, so I=E2=80=99ll guard
them with CONFIG_IS_ENABLED(LOG_SYSLOG) in v2.

> > +int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot)
> > +{
> > +       struct ethernet_hdr *et =3D (struct ethernet_hdr *)xet;
> > +       const uchar *src =3D eth_get_ethaddr();
> > +
> > +       memcpy(et->et_dest, dest_ethaddr, ARP_HLEN);
> > +       if (src)
> > +               memcpy(et->et_src, src, ARP_HLEN);
> > +       else
> > +               memset(et->et_src, 0, ARP_HLEN);
> > +       et->et_protlen =3D htons(prot);
> > +
> > +       return ETHER_HDR_SIZE;
> > +}
> > +
> > +static void net_lwip_set_ip_header(uchar *pkt, struct in_addr dest,
> > +                                  struct in_addr source, u16 pkt_len,
> > +                                  u8 proto)
> > +{
> > +       static u16 ip_id;
> > +       struct ip_udp_hdr *ip =3D (struct ip_udp_hdr *)pkt;
> > +
> > +       ip->ip_hl_v =3D 0x45;
> > +       ip->ip_tos =3D 0;
> > +       ip->ip_len =3D htons(pkt_len);
> > +       ip->ip_p =3D proto;
> > +       ip->ip_id =3D htons(ip_id++);
> > +       ip->ip_off =3D htons(IP_FLAGS_DFRAG);
> > +       ip->ip_ttl =3D 255;
> > +       ip->ip_sum =3D 0;
> > +       memcpy(&ip->ip_src, &source, sizeof(source));
> > +       memcpy(&ip->ip_dst, &dest, sizeof(dest));
> > +       ip->ip_sum =3D compute_ip_checksum(ip, IP_HDR_SIZE);
> > +}
> > +
> > +void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, in=
t sport,
> > +                       int len)
> > +{
> > +       struct ip_udp_hdr *ip =3D (struct ip_udp_hdr *)pkt;
> > +       struct in_addr source =3D {};
> > +       ip4_addr_t addr, mask, gateway;
> > +       struct udevice *dev =3D eth_get_dev();
> > +       u16 pkt_len =3D IP_UDP_HDR_SIZE + len;
> > +
> > +       if (len & 1)
> > +               pkt[IP_UDP_HDR_SIZE + len] =3D 0;
> > +
> > +       if (dev && !get_udev_ipv4_info(dev, &addr, &mask, &gateway))
> > +               source.s_addr =3D addr.addr;
> > +
> > +       net_lwip_set_ip_header(pkt, dest, source, pkt_len, IPPROTO_UDP)=
;
> > +
> > +       ip->udp_src =3D htons(sport);
> > +       ip->udp_dst =3D htons(dport);
> > +       ip->udp_len =3D htons(UDP_HDR_SIZE + len);
> > +       ip->udp_xsum =3D 0;
> > +}
> > +
> >  /*
> >   * Initialize DNS via env
> >   */
> > diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
> > index b6c0631aaf6..f848506fb1c 100644
> > --- a/test/log/syslog_test.c
> > +++ b/test/log/syslog_test.c
> > @@ -34,11 +34,13 @@ int sb_log_tx_handler(struct udevice *dev, void *pa=
cket, unsigned int len)
> >
> >         /* Check Ethernet header */
> >         ut_asserteq_mem(&eth_hdr->et_dest, net_bcast_ethaddr, ARP_HLEN)=
;
> > +       ut_asserteq_mem(&eth_hdr->et_src, eth_get_ethaddr(), ARP_HLEN);
> >         ut_asserteq(ntohs(eth_hdr->et_protlen), PROT_IP);
> >
> >         /* Check IP header */
> >         buf +=3D sizeof(struct ethernet_hdr);
> >         ip_udp_hdr =3D (struct ip_udp_hdr *)buf;
> > +       ut_assert(ip_checksum_ok(ip_udp_hdr, IP_HDR_SIZE));
> >         ut_asserteq(ip_udp_hdr->ip_p, IPPROTO_UDP);
> >         ut_asserteq(ip_udp_hdr->ip_dst.s_addr, 0xffffffff);
> >         ut_asserteq(ntohs(ip_udp_hdr->udp_dst), 514);
> > diff --git a/test/log/syslog_test.h b/test/log/syslog_test.h
> > index 39cce4ed498..89c86541f5e 100644
> > --- a/test/log/syslog_test.h
> > +++ b/test/log/syslog_test.h
> > @@ -31,8 +31,8 @@ struct sb_log_env {
> >   *
> >   * The following checks are executed:
> >   *
> > - * * the Ethernet packet indicates a IP broadcast message
> > - * * the IP header is for a local UDP broadcast message to port 514
> > + * * the Ethernet packet uses the selected interface and broadcast des=
tination
> > + * * the IP header checksum is valid and describes a UDP broadcast to =
port 514
> >   * * the UDP payload matches the expected string
> >   *
> >   * After testing the pointer to the expected string is set to NULL to =
signal
> >
> > ---
> > base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> > change-id: 20260825-lwip-syslog-v1-a5625eba2ea3
> >
> > Best regards,
> > --
> > James Hilliard <james.hilliard1@gmail.com>
> >
