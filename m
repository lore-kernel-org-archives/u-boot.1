Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6899DC98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 08:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6F01607A2;
	Sat, 26 Sep 2026 08:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPaLGDHcu5KK; Sat, 26 Sep 2026 08:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B676260720
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790412271;
	b=FJyDEqvPa+2V6h5fzDy+DStrhd0NSqnGYfbAtNU98o9BPgmARH8sYOvqwEuU6Rng/Kzj
	 moebg/NG+UWOHV6ll/ZqOgb3SG6HcM48rdDA9lKwfadNsE/Sd1bkNmDYG9ayqHt7Pj/yB
	 okBca/NUEtvg2/PNxjcNclU7m0XiS8RTOYnA2KFj0SBCCLlKL1gXKwfM7sV9kPkrGbvmE
	 Edjf5ixyvxQ/5xEmhqxnIRoGnr2ZWorx0ucqn1i8CtdWfAnkMNEO5VrrKpvLXJ9GIjdsj
	 NAAh/NRR4vmBJkVFFnbKQxh0lQuY9BEUDpsYStpWDe0GgWnvZARV12RJ5nopW01uKew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790412271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zPI1KD+Ue68UyzUSBjZJ/jw62NIDdOWYIfj7B/1WI9M=;
	b=ArlX/MhjdCYdIvurWBlc+j0D2vWE+RToDutWJM9UjlDXOoYqNOcqgI8TncV/Ds0U0Afg
	 l+DoGrcCi/WbQNiel1SxDktyLJX/M6vBAnrgGeVCnxRz4xWYt3H2vEi+3v34HHogV0y81
	 +eaT7UCnWBAMxRyPqBDBeSE0o2spqBRrbpTumzOhruCKwAsjH66jYdIIw8zLIkoMPQ/+8
	 bFLj3/fzoqk/EvN0o2yhj7T4hdtDOFZy7nbf/7eySc2dRy7P2QTLf81dQ6CADLhbd9P5v
	 4rcPTf5vDr2vhmxPcD8cLeZQfUH73jXsX7+MVqZVjTuSXrD+XO7vwpxVQ0IOuuIXPag==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PbwC8EvT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790412271;
	bh=zPI1KD+Ue68UyzUSBjZJ/jw62NIDdOWYIfj7B/1WI9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uuP6QRQKHaSg9e3LBf4LTu1P1hIgfWER/oODAsc6Wbw8ECplEHIq4i2ADHh54lH14
	 3queYDye9WmCzUSLwL1FpJFnC8t6BgtX38tGluLSXy9lb5lfDCmv8FEQGdpuHZJSP0
	 Bbp5Vw+yV3VuzL1qR/uhQyrwQiA1sr7Lnpqm78vNa1uOxv+wVIG2Z5HyxaNWze5TGR
	 HsGwuPOzjJ7fY4O8P9kR49xDqcpr4Xuhip4+IflBZ142PTAWtqQ5WW5WEl7XBRWxc4
	 p1gb13IloeA8nzCshU9vS5RD1dR7WjCNdOoXo3qUQJtLlpkDQ31Cpg9zmUBLPt1sAF
	 Z6L5H6pF5VW7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B676260720;
	Sat, 26 Sep 2026 08:44:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E02AA353
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 22:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1C6D60BE4
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 22:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hB0wEBjep-sD for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 22:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7135B60626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:38::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790374100;
 b=Kx0bAu/XXP2qH1kDvNUaXA6HnBkU1Y9uergyArfWMMMg7jBqvKVaaB4X970JGFJ0uzMy
 ZFR//L+LPkvNAo+XRe8v1B5ovHUzjeYW8VLnXWUIsVCchvvuPnk3WELIHJVKrkx+cRaZY
 LA5D227N4qHEjFW3NjwZRg8jdzwHT0f45BmOUIxSdkHioxloq87z7UG9rpO2EGe38W9Sb
 Egcw/BF/hrjnjkMmgSvYGP4GFDQYHNJ2HRr0xBPYaASTPQNMyaoWzAa6CM8f7E36MwL2f
 hA/mFp0F6JVCq83BPVY3GNwmXA+hQCUgAoeT4Ysv/8nSYI8KKh4lqsLwvnBYF2opCWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790374100;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=zPI1KD+Ue68UyzUSBjZJ/jw62NIDdOWYIfj7B/1WI9M=;
 b=pQXjwbkoFs1lSTqzmHEt9lBi8HjAoibMt0zLMdwftPbAkfDIjFJOacTsbkpWdjjquQkH
 HLdjg3qs4nwgKJF8+zRXQVaaXgIuRZ4j6rbSey6APRiGcGgb1ioPREbZ/KvbR9BJ5MsFm
 rV8qGknPj2Sp10YlpxuHxoze2OA/ReT8XTDLniLW8pmxCtNmnCJTDZmapWDBRyZNsl9gx
 09zrsWLERjVp/KwNjUOYupuohwthU49XDsncLOV4hsg2C/EQB0R4mIpwgxQpQDgPy4OYs
 2uyzx1WqpHla/WxR9a00y2+TWJwmTgmo4Ki46T3jbI9VqxDE1Kb7G3kNHkWRUg5RwOw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=PbwC8EvT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:38::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:38::e;
 helo=mail-dl2-x0e.google.com; envelope-from=yuxiaozhang@google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=PbwC8EvT
Received: from mail-dl2-x0e.google.com (mail-dl2-x0e.google.com
 [IPv6:2607:f8b0:4864:38::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7135B60626
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 22:08:19 +0000 (UTC)
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144d60be6b0so797229c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790374099; cv=none;
 d=google.com; s=arc-20260327;
 b=JRYnJdFly4DfdQBQmPELTbxnFL+1+wdc6rRVD1MUjehxKHsc+o1lBgFPgHMhemJcIc
 1h/CbBGU7RwPKmeD0aLQXokHGZswGS/XEw/2vVlYtRxCtcJgA2gwx1+xOjx6bmnSQVF8
 82+P9eAd30kEqgti7yajc68KEZMXg1cWs437Ag8UyeAMZUeWYo4XC1VzeOz6Yi1vdV/8
 BjZJnVkwnCSfv+bEXy3jkCA1gy54gXW6tY+5n4eZDbvSraA2dQOcrhLMJo/+niMzcrSF
 pT3VjCCYDN59+oCsJ1V5fYGza7YAdGKoNdnOOeo+sEsBz3f9QVAnIbSteQHeh7yfxKTy
 WWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zPI1KD+Ue68UyzUSBjZJ/jw62NIDdOWYIfj7B/1WI9M=;
 fh=716AGB+te7fmiv94E6M5Qo3NoHxfXdj5YzS2gM6z6U8=;
 b=eMrl7R5zXXz830Ze0/Q4LE0vjO7LDKvaiTEQc7c37wXTMxS5CegngpAHcprU9gJSbD
 bYG8heRIGcRXPIcepnMomJQCiNNl+Pndnhzo5Ear7RmN9nvC1D9FUrV/FqGuLhdQBP8t
 2mTecCPOobGxRsz8/Tua7SVZBUEfC+ux+TRU1UbBPm6gzGd42OrND9lIMcnskyXee+In
 Kv16L0OWS6ToKD37u1nZjDJIT5Iaw1qxlDzs2ytCb5sAUbX9ZY4ylszOhrv6/Wehfu+J
 jX02KlOFX472p/RGigfkSU4qEzD11+6kRQ/ej8LJ98IwJw4ib2g9NbDEFnzP/W1Q5QC2
 fIgg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790374099; x=1790978899;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zPI1KD+Ue68UyzUSBjZJ/jw62NIDdOWYIfj7B/1WI9M=;
 b=PbwC8EvTAfvcOb5u0wgHRV5bYIQ84EHesT+03ebYMKCQzLJjWkttMVPw+E82Ald/b+
 RFwd/PCZTHFxUd6+6Ol5Ami8wVtRjp/wuUpc1xqX9oPwADvh/h6aODC5BWQ483JoyW2p
 bWsSCKsrV1ZSzz+tRi9lOANJzOJ5JNiNkleciiZnzMLJAtl/2v+6zpcdu+KUFx4vypKy
 jx6udrGzaR1lblIvbcp0OzGnD8EfoufXX8ZdilS3G3UglYcUcIzS41yD3yVQ/mLxMI2D
 qkno5kAO+13dWfmAOSgWpl993KAfWu88jkKF2BKj8blNQIVLHB7IBKgPihVkEiomLyx/
 BF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374099; x=1790978899;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zPI1KD+Ue68UyzUSBjZJ/jw62NIDdOWYIfj7B/1WI9M=;
 b=RmoPvLy2dw4LxnJGL1Qvy1XDbkmA+jwZKV1dXtl+It0z2Zo3Rd+bc//lZGKw2Bh/Dm
 uTGnskRmy+LNBV8TWhFArSNe2kWtZhDptSCFx/g9xpwHtyU0COB2Nl9axGpk7kMfXsqP
 hZlE+rJ3NdeOchuVNp2aoRcKDg6HR1A33+QFkHQG9QwgypC7H57X6eUK216wH4TKPMxD
 202PK2ayBUxI7FUi8GG3qJsnaKFNuQQDCb3jOXmXzy5LyVx0vLRphBc0HiIgj7Yk/7tq
 uQj3lLHlDar5JPCdALxbvjl9LwSgqzhQHfoX7dbUleqkYk7GodeL4gls19Cf+Idz69/g
 L96A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUf7r5/oQ+HQ4GJS3GG3QY+6D3O1Dn9GfgXj9b1o+P3hQV3wZAwNTsGr+XM5xwo2Uyjd/vmjk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lq/b43eg4vDArIAM0F8T5SYtIbXHaqOjVg3NGSuGQPG9pOBQYO
 6n5lVkFTrxsvmB83vEQ9YDbitBv0hbtWw/0XfqY79JIikejGjZlvZx6gJPaAiBsi6Rs6QIIUNQ7
 BGRQoFIhcdEwSpN2TsihxzTP4APo/UDnhphfl0jPJ
X-Gm-Gg: AYBFou3tqskc4Wida8Orr4X2h9fNMWMUzJ9Nhp4OVYJFuXOHOQ0+hiPltY27Tc5YpsO
 N4HXfKJNTSKN0OZnyWL2HzM2CylPSKuhxY9FJb92rLOzGdS2m4UAlMWLjXJJr9x5TUbfoSDgDC5
 lf/taIW+XAOawt4BsClHGNGMOv79e1GIoZnFZZy3nq6zOVOvTX9lun0uD1ZRX4q50b2tFsUVyyy
 rQZn7yE5XZTb0PtO10MyEPNROMOCsAXfsromxcO940r6b4CHyCPiHYgkgkLafmt8E0seUyLnUj3
 FL9Qwtg0SbB3EgwGISdUQhl0zud1SGVD7qBdve28f+IzJQulXcUyHldz8mjGCASfE9Y6e1U2D9X
 pliqmnnmTVFh3T6ybEO+cOg==
X-Received: by 2002:a05:7022:4581:b0:143:26ed:2dd5 with SMTP id
 a92af1059eb24-146cfcd7046mr1785240c88.31.1790374097580; Fri, 25 Sep 2026
 15:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153255.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
 <7d673713-eddc-4807-90e5-873b572a9497@arm.com>
In-Reply-To: <7d673713-eddc-4807-90e5-873b572a9497@arm.com>
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Fri, 25 Sep 2026 15:08:05 -0700
X-Gm-Features: AclHuK8P5c65zatgcn9CmqOrQ9S9qF506DA_nt3ME8uNm94NnaNiB_GM9zud96g
Message-ID: <CAOOoKeTiVDjEwx2T3w3ij74EOR_15LBNOuFB7ANV5vd2PdgEYg@mail.gmail.com>
Subject: Re: [PATCH] net: dhcp6 use link local address
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, nd <nd@arm.com>
Content-Type: multipart/alternative; boundary="0000000000001b1373065c55f48a"
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:44:30 +0000
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

--0000000000001b1373065c55f48a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 6:28=E2=80=AFAM Jerome Forissier <jerome.forissier@=
arm.com>
wrote:

> Hi Yuxiao,
>
> On 11/09/2026 00:32, Yuxiao Zhang wrote:
> > dhcpv6 is a special UDP traffic and should always use link local
> > addresses. Only pick net_ip6 if it is not empty and if it is not dhcp6.
> >
> > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > ---
> >
> >  net/net6.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/net6.c b/net/net6.c
> > index 4cff98df15c..18072bd9f49 100644
> > --- a/net/net6.c
> > +++ b/net/net6.c
> > @@ -330,6 +330,10 @@ int net_send_udp_packet6(uchar *ether, struct
> in6_addr *dest, int dport,
> >       uchar *pkt;
> >       struct udp_hdr *udp;
> >       u16 csum_p;
> > +     struct in6_addr *src =3D
> > +             (dport =3D=3D 547 || ip6_is_unspecified_addr(&net_ip6)) ?
> > +                     &net_link_local_ip6 :
> > +                     &net_ip6;
>
> Rather than special-casing DHCPv6 based on dport =3D=3D 547, I think this
> should be based on the destination address scope.
>
> For a link-local multicast destination, RFC 6724 source-address selection
> prefers a link-local source address, so something like:
>
> struct in6_addr *src =3D
>         (ip6_is_unspecified_addr(&net_ip6) ||
>          ip6_is_link_local_multicast(dest)) ?
>         &net_link_local_ip6 : &net_ip6;
>
> with:
>
> static bool ip6_is_link_local_multicast(const struct in6_addr *addr)
> {
>         return addr->s6_addr[0] =3D=3D 0xff &&
>                (addr->s6_addr[1] & 0xf) =3D=3D 0x2;
> }
>
> This should fix DHCPv6 while keeping the source-address selection in the
> IPv6 layer rather than making generic UDP code aware of DHCP port numbers=
.
>
> What do you think?
>
> >       udp =3D (struct udp_hdr *)((uchar *)net_tx_packet +
> net_eth_hdr_size() +
> >                       IP6_HDR_SIZE);
> > @@ -341,7 +345,7 @@ int net_send_udp_packet6(uchar *ether, struct
> in6_addr *dest, int dport,
> >       /* checksum */
> >       udp->udp_xsum =3D 0;
> >       csum_p =3D csum_partial((u8 *)udp, len + UDP_HDR_SIZE, 0);
> > -     udp->udp_xsum =3D csum_ipv6_magic(&net_ip6, dest, len + UDP_HDR_S=
IZE,
> > +     udp->udp_xsum =3D csum_ipv6_magic(src, dest, len + UDP_HDR_SIZE,
> >                                       IPPROTO_UDP, csum_p);
> >
> >       /* if MAC address was not discovered yet, save the packet and do
> > @@ -353,8 +357,8 @@ int net_send_udp_packet6(uchar *ether, struct
> in6_addr *dest, int dport,
> >
> >               pkt =3D net_nd_tx_packet;
> >               pkt +=3D net_set_ether(pkt, net_nd_packet_mac, PROT_IP6);
> > -             pkt +=3D ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64=
,
> > -                             len + UDP_HDR_SIZE);
> > +             pkt +=3D ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64,
> > +                                len + UDP_HDR_SIZE);
> >               memcpy(pkt, (uchar *)udp, len + UDP_HDR_SIZE);
> >
> >               /* size of the waiting packet */
> > @@ -370,8 +374,7 @@ int net_send_udp_packet6(uchar *ether, struct
> in6_addr *dest, int dport,
> >
> >       pkt =3D (uchar *)net_tx_packet;
> >       pkt +=3D net_set_ether(pkt, ether, PROT_IP6);
> > -     pkt +=3D ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64,
> > -                     len + UDP_HDR_SIZE);
> > +     pkt +=3D ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64, len +
> UDP_HDR_SIZE);
> >       (void)eth_send(net_tx_packet, pkt - net_tx_packet + UDP_HDR_SIZE =
+
> len);
> >
> >       return 0;       /* transmitted */
> > ---
> > base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
> > branch: main
> >
>
> Thanks,
> --
> Jerome
>

Yes this makes sense and it is a more generic fix. I will send another
version.

Thanks,
Yuxiao

--0000000000001b1373065c55f48a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Thu, Sep 17, 2026 at 6:28=E2=80=AFAM Jerome Forissier &lt;<a href=3D=
"mailto:jerome.forissier@arm.com">jerome.forissier@arm.com</a>&gt; wrote:</=
span></div><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Yuxiao,<br>
<br>
On 11/09/2026 00:32, Yuxiao Zhang wrote:<br>
&gt; dhcpv6 is a special UDP traffic and should always use link local<br>
&gt; addresses. Only pick net_ip6 if it is not empty and if it is not dhcp6=
.<br>
&gt; <br>
&gt; Signed-off-by: Yuxiao Zhang &lt;<a href=3D"mailto:yuxiaozhang@google.c=
om" target=3D"_blank">yuxiaozhang@google.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt;=C2=A0 net/net6.c | 13 ++++++++-----<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/net/net6.c b/net/net6.c<br>
&gt; index 4cff98df15c..18072bd9f49 100644<br>
&gt; --- a/net/net6.c<br>
&gt; +++ b/net/net6.c<br>
&gt; @@ -330,6 +330,10 @@ int net_send_udp_packet6(uchar *ether, struct in6=
_addr *dest, int dport,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uchar *pkt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct udp_hdr *udp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 csum_p;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct in6_addr *src =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dport =3D=3D 547 || =
ip6_is_unspecified_addr(&amp;net_ip6)) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;net_link_local_ip6 :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;net_ip6;<br>
<br>
Rather than special-casing DHCPv6 based on dport =3D=3D 547, I think this<b=
r>
should be based on the destination address scope.<br>
<br>
For a link-local multicast destination, RFC 6724 source-address selection<b=
r>
prefers a link-local source address, so something like:<br>
<br>
struct in6_addr *src =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ip6_is_unspecified_addr(&amp;net_ip6) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip6_is_link_local_multicast(dest)) ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;net_link_local_ip6 : &amp;net_ip6;<br>
<br>
with:<br>
<br>
static bool ip6_is_link_local_multicast(const struct in6_addr *addr)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return addr-&gt;s6_addr[0] =3D=3D 0xff &amp;&am=
p;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(addr-&gt;s6_addr[1]=
 &amp; 0xf) =3D=3D 0x2;<br>
}<br>
<br>
This should fix DHCPv6 while keeping the source-address selection in the<br=
>
IPv6 layer rather than making generic UDP code aware of DHCP port numbers.<=
br>
<br>
What do you think?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0udp =3D (struct udp_hdr *)((uchar *)net_tx_p=
acket + net_eth_hdr_size() +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0IP6_HDR_SIZE);<br>
&gt; @@ -341,7 +345,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_=
addr *dest, int dport,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* checksum */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0udp-&gt;udp_xsum =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0csum_p =3D csum_partial((u8 *)udp, len + UDP=
_HDR_SIZE, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0udp-&gt;udp_xsum =3D csum_ipv6_magic(&amp;net_ip6=
, dest, len + UDP_HDR_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0udp-&gt;udp_xsum =3D csum_ipv6_magic(src, dest, l=
en + UDP_HDR_SIZE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IPPROT=
O_UDP, csum_p);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* if MAC address was not discovered yet, sa=
ve the packet and do<br>
&gt; @@ -353,8 +357,8 @@ int net_send_udp_packet6(uchar *ether, struct in6_=
addr *dest, int dport,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt =3D net_nd_t=
x_packet;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D net_set=
_ether(pkt, net_nd_packet_mac, PROT_IP6);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D ip6_add_hdr(=
pkt, &amp;net_ip6, dest, IPPROTO_UDP, 64,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len + UDP_HDR_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D ip6_add_hdr(=
pkt, src, dest, IPPROTO_UDP, 64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len + UDP_HDR_SIZE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(pkt, (uch=
ar *)udp, len + UDP_HDR_SIZE);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* size of the w=
aiting packet */<br>
&gt; @@ -370,8 +374,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_=
addr *dest, int dport,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt =3D (uchar *)net_tx_packet;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D net_set_ether(pkt, ether, PROT_IP6)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0pkt +=3D ip6_add_hdr(pkt, &amp;net_ip6, dest, IPP=
ROTO_UDP, 64,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0len + UDP_HDR_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pkt +=3D ip6_add_hdr(pkt, src, dest, IPPROTO_UDP,=
 64, len + UDP_HDR_SIZE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(void)eth_send(net_tx_packet, pkt - net_tx_p=
acket + UDP_HDR_SIZE + len);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* trans=
mitted */<br>
&gt; ---<br>
&gt; base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a<br>
&gt; branch: main<br>
&gt; <br>
<br>
Thanks,<br>
-- <br>
Jerome<br></blockquote><div><br></div><div>Yes this makes sense and it is a=
 more generic fix. I will send another version.</div><div><br></div><div>Th=
anks,</div><div>Yuxiao=C2=A0</div></div></div>

--0000000000001b1373065c55f48a--
