Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC710C61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 09:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B20AA40580;
	Wed, 26 Aug 2026 09:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GqpC-KI96kVp; Wed, 26 Aug 2026 09:49:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787737750;
	bh=HPywAFgrkbmvs35SOjn3rQAiWNqWLBQu17zo5jH20RU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vdKsWGa7lZfs6vm3iU/gqB4y+pU+FmYKdAndN2vbj9oVsWeZNMrCK//+xDhMFXWnH
	 nWwMBFCaxOlXrAuzIq9O7XFBlE51BLpLeGvCz4U4YKfvXkrL2YbrkLc/PL48vTASUQ
	 4Hvq2aTNNcrlkVJJ8LYP+fTX9O9ALLOh+x6JZb9Est12eI2XCB927o1FFXBgLV8yCY
	 P+xelAv9Kr3pt+Kq/kH78lRJ5Qg/mzMEw2oZSc9j0OoHnn4zx5IbyDTHnCs2SNrRjk
	 ItpTgglMbHU+aKOrscOdLFDxE9C9+Ar0e9vrZNmoViSLLgHBvaoNScSieK4PwznrFA
	 XaZlJF5zrjtCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB3840557;
	Wed, 26 Aug 2026 09:49:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AFAD230
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D4796070D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZ789CJpYAuk for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 09:49:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pIO66FEg
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39E746067F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:49:08 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8f1a8e914a9so6974636d6.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787737747; cv=none;
 d=google.com; s=arc-20260327;
 b=YVTimkno6o++H0sQ1LtrXVrevj+KDgoFK73j44AZ1Pdn2WNCrKaAg5vYXVfyLzvRLc
 dXlUAlyEFqv72uOVU6CHA/6EpxjNMZ9qQiGOEghzFHq4u3tlfmsf8IUGltJjr0MTLmUv
 WUNKhR+lls8MePegTfmH1/u0jIqfdoYXHMtjKb48v2dr0GqbE4HOYg8fl1DB96tfOnK4
 Et3rJJe+mBipVyIwmA1tmhQhHETkhR14wSo5bMrTagQryVxZZ1EQUmYvNZAU4Wz85U8N
 /xDFddk+HhIVNgkOOhb9fw7auQIswZ2iHYsJGnFfulbdkMGZ2EI7nTo9R68vtlm1zhFs
 XLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HPywAFgrkbmvs35SOjn3rQAiWNqWLBQu17zo5jH20RU=;
 fh=XOlhkv9q70rVh1XMK2M7J0GiL/IuGijj2jnsjG/+yWY=;
 b=fPebkjN9B8xq5fLmk63elRW0nP5EBS5UU2IeN3ZPPDyKA+11wK8Z/0puYRKC3aLj9b
 rViTjqGyB4eSCxje3mZ9Mra6NliPY8+m9cX2yUPkTCTZZmghRcsg2ZHDV2GAwl7PSlUy
 4ZHCswFYd0AV1aMKTpffmONZuetj1CEmL2jYECJcEYX/Avk1PiP2um9ui+hzQian+7eW
 YQlymftAc9r1awufGgzgTeQF9UNdYHege8gy5R+vnwc+Wzi8OFE5nZJDl3vMDvSBWwky
 DWJ51biK6wsRFwPvI1i0dOcfxkt/m3i2lpTYtR+JAcJHt/006t2d9MCzmGKjBGot+6Vk
 q7aw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787737747; x=1788342547;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HPywAFgrkbmvs35SOjn3rQAiWNqWLBQu17zo5jH20RU=;
 b=pIO66FEgrBH2cQtA/6M/p63qDYqESkHa6Q0rhkD48ppnKXswYNti0x9+UWwjzH3Rjn
 BNVvAWvXUUDkhHPD0RSZtfrlop0eye/AJuUtGXrcd/CLUmRNAIx1UV0YfvDGbz1AD0T8
 0mrOmzcngZUER+eWSLWcEQ8yBZDPPMRnO5l4zAZN2XcY/38VpG8uc1k5A5A2sb869nK+
 KKlscKrHEYz+ywi+nDZieT3IKr0EPcsupYr/FSi3e5aFILdQrvCjVQt61guBq1BswqKt
 hF6VwRERV79eptqjZ44JW5pvHNLyNhkv23RQDSb+3PKnS9IcHiZYtMhiUNY53FfeNrjr
 /coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787737747; x=1788342547;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HPywAFgrkbmvs35SOjn3rQAiWNqWLBQu17zo5jH20RU=;
 b=T5NqmhXk3pdxybwu7r5NcyXeusAKCnxwa5s9orI73j77NIYur2dB0UDtXJhLDytSom
 pl/HUku+aWnSodwAlxttXXDxG/0OGhgSySDKW8RBqb92otm2iF2OVMOrJ7ZCsFeBhn6W
 /41QAowjkxTyG0zDoVWvvtdZzToCgui99pLakU+cDifJsPGbiuRNM4M8L7ctt1DCG7PF
 5Rfqk5MKsMjg/nUQqg66zF9BEc43FMCcWfRGyyuq44T4fwUD5A+eDEyOGtwEwC1TIB2q
 rKPt2HPJ/uX74nBGiKbna7fNclFP8Zsd383nst6TvB227Jq3MfcQtHJIp3wjAdHLCNdh
 C2VA==
X-Gm-Message-State: AFuF++nXO5rUYs+XMVn/iiWZ1kKy07Gan7b4iHfmcymbEovGTNQI/JtJ
 3dDBSU4+4ulyFQde7xif33YHj1VAtVscnayHyT/hS34uCpfVbT8OrbhdisW/R35wV9jEStth7rE
 GV6w4cvEt7XiKRRUo8jx/C3F496zsrF0=
X-Gm-Gg: AR+sD10NbWBceuaFFJOzVATnyGnRU3CT6QqewO81+Qu35ktcaeXAymwByUQOzj1RPEN
 bZczlm4VgXTrc94VXyv6Xqjgh/YXVt7vFoPxlUR/UZw9WKxDomXfrr9iLs2vHpJspYZbYTl3C9Z
 c6frWKf/zT2qlrkuvKo9XylLj41Y+MCAE6J8/Cz5y+6nS0eksJ7QDAzaJRuAXw+LC3qxJPoN9PL
 aKUVk2zZGez35m64ZWWEeaI76o1wVIIeeLK2Xkvmp71H7cFIwwcrSFMn0wcO0qKgSuU4NeEMCq9
 1udj6eEWFsdVMUzXGycI4PcNPFAAJDqUXg9N+rNgH2SWJDpDUc/u3b81k+yNtxTbkMNkPo5THGU
 4E5kQkimzFFScl2pDyyQtslalRNQYwx2HQr8sK8GJZJwWKZrV/KAyfCB6lwqZhKLKqycNwhv4vW
 nY49K+/y9Yxc49SmhgcKvH/b0O8CCjyyikLcbo4b0=
X-Received: by 2002:a05:6214:1d29:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-90cc794fb46mr51694806d6.32.1787737747489; Wed, 26 Aug 2026
 02:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-lwip-syslog-v1-v1-1-53210f44fd76@gmail.com>
In-Reply-To: <20260825-lwip-syslog-v1-v1-1-53210f44fd76@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 26 Aug 2026 10:48:55 +0100
X-Gm-Features: AcwNN1Vx8QO_yiQSVReMIpNZmjUEj4TNMZiObOtDJndD16JRyXbXZ4HfbkYJl5w
Message-ID: <CALeDE9P+gbt0vg4knDR1f4Z-0OmndNvZhqtjN-xuM2e2bXnvtQ@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: support syslog
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 25 Aug 2026 at 19:59, James Hilliard <james.hilliard1@gmail.com> wrote:
>
> LOG_SYSLOG depends on NET, but the raw Ethernet and UDP header
> builders it uses are only available with the legacy network stack. This
> makes LOG_SYSLOG fail to build with NET_LWIP.
>
> Provide lwIP implementations using the selected Ethernet device and its
> indexed IP address from the environment. Move the shared declarations to
> net-common.h and extend the syslog test to check the source MAC address
> and IPv4 header checksum.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  include/net-common.h   |  7 ++++++
>  include/net-legacy.h   |  4 ----
>  net/lwip/net-lwip.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/log/syslog_test.c |  2 ++
>  test/log/syslog_test.h |  4 ++--
>  5 files changed, 69 insertions(+), 6 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 0c260873c2c..3084a2b2a57 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -362,6 +362,13 @@ struct ethernet_hdr {
>  /* Ethernet header size */
>  #define ETHER_HDR_SIZE (sizeof(struct ethernet_hdr))
>
> +/* Set Ethernet header; returns the size of the header */
> +int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot);
> +
> +/* Set IPv4 and UDP headers */
> +void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
> +                       int sport, int len);
> +
>  /**
>   * net_random_ethaddr - Generate software assigned random Ethernet address
>   * @addr: Pointer to a six-byte array containing the Ethernet address
> diff --git a/include/net-legacy.h b/include/net-legacy.h
> index d3b122c9062..d7f55d34a30 100644
> --- a/include/net-legacy.h
> +++ b/include/net-legacy.h
> @@ -344,15 +344,11 @@ int net_loop(enum proto_t);
>  /* Get size of the ethernet header when we send */
>  int net_eth_hdr_size(void);
>
> -/* Set ethernet header; returns the size of the header */
> -int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot);
>  int net_update_ether(struct ethernet_hdr *et, uchar *addr, uint prot);
>
>  /* Set IP header */
>  void net_set_ip_header(uchar *pkt, struct in_addr dest, struct in_addr source,
>                        u16 pkt_len, u8 proto);
> -void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
> -                       int sport, int len);
>
>  /* Callbacks */
>  rxhand_f *net_get_udp_handler(void);   /* Get UDP RX packet handler */
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 8f8f9d69020..4dd8f0d2ce7 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -159,6 +159,64 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>         return 0;
>  }

If these are specific to LOG_SYSLOG functionality I think they should
be guarded by LOG_SYSLOG

> +int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot)
> +{
> +       struct ethernet_hdr *et = (struct ethernet_hdr *)xet;
> +       const uchar *src = eth_get_ethaddr();
> +
> +       memcpy(et->et_dest, dest_ethaddr, ARP_HLEN);
> +       if (src)
> +               memcpy(et->et_src, src, ARP_HLEN);
> +       else
> +               memset(et->et_src, 0, ARP_HLEN);
> +       et->et_protlen = htons(prot);
> +
> +       return ETHER_HDR_SIZE;
> +}
> +
> +static void net_lwip_set_ip_header(uchar *pkt, struct in_addr dest,
> +                                  struct in_addr source, u16 pkt_len,
> +                                  u8 proto)
> +{
> +       static u16 ip_id;
> +       struct ip_udp_hdr *ip = (struct ip_udp_hdr *)pkt;
> +
> +       ip->ip_hl_v = 0x45;
> +       ip->ip_tos = 0;
> +       ip->ip_len = htons(pkt_len);
> +       ip->ip_p = proto;
> +       ip->ip_id = htons(ip_id++);
> +       ip->ip_off = htons(IP_FLAGS_DFRAG);
> +       ip->ip_ttl = 255;
> +       ip->ip_sum = 0;
> +       memcpy(&ip->ip_src, &source, sizeof(source));
> +       memcpy(&ip->ip_dst, &dest, sizeof(dest));
> +       ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
> +}
> +
> +void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
> +                       int len)
> +{
> +       struct ip_udp_hdr *ip = (struct ip_udp_hdr *)pkt;
> +       struct in_addr source = {};
> +       ip4_addr_t addr, mask, gateway;
> +       struct udevice *dev = eth_get_dev();
> +       u16 pkt_len = IP_UDP_HDR_SIZE + len;
> +
> +       if (len & 1)
> +               pkt[IP_UDP_HDR_SIZE + len] = 0;
> +
> +       if (dev && !get_udev_ipv4_info(dev, &addr, &mask, &gateway))
> +               source.s_addr = addr.addr;
> +
> +       net_lwip_set_ip_header(pkt, dest, source, pkt_len, IPPROTO_UDP);
> +
> +       ip->udp_src = htons(sport);
> +       ip->udp_dst = htons(dport);
> +       ip->udp_len = htons(UDP_HDR_SIZE + len);
> +       ip->udp_xsum = 0;
> +}
> +
>  /*
>   * Initialize DNS via env
>   */
> diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
> index b6c0631aaf6..f848506fb1c 100644
> --- a/test/log/syslog_test.c
> +++ b/test/log/syslog_test.c
> @@ -34,11 +34,13 @@ int sb_log_tx_handler(struct udevice *dev, void *packet, unsigned int len)
>
>         /* Check Ethernet header */
>         ut_asserteq_mem(&eth_hdr->et_dest, net_bcast_ethaddr, ARP_HLEN);
> +       ut_asserteq_mem(&eth_hdr->et_src, eth_get_ethaddr(), ARP_HLEN);
>         ut_asserteq(ntohs(eth_hdr->et_protlen), PROT_IP);
>
>         /* Check IP header */
>         buf += sizeof(struct ethernet_hdr);
>         ip_udp_hdr = (struct ip_udp_hdr *)buf;
> +       ut_assert(ip_checksum_ok(ip_udp_hdr, IP_HDR_SIZE));
>         ut_asserteq(ip_udp_hdr->ip_p, IPPROTO_UDP);
>         ut_asserteq(ip_udp_hdr->ip_dst.s_addr, 0xffffffff);
>         ut_asserteq(ntohs(ip_udp_hdr->udp_dst), 514);
> diff --git a/test/log/syslog_test.h b/test/log/syslog_test.h
> index 39cce4ed498..89c86541f5e 100644
> --- a/test/log/syslog_test.h
> +++ b/test/log/syslog_test.h
> @@ -31,8 +31,8 @@ struct sb_log_env {
>   *
>   * The following checks are executed:
>   *
> - * * the Ethernet packet indicates a IP broadcast message
> - * * the IP header is for a local UDP broadcast message to port 514
> + * * the Ethernet packet uses the selected interface and broadcast destination
> + * * the IP header checksum is valid and describes a UDP broadcast to port 514
>   * * the UDP payload matches the expected string
>   *
>   * After testing the pointer to the expected string is set to NULL to signal
>
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> change-id: 20260825-lwip-syslog-v1-a5625eba2ea3
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
>
