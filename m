Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA85C88E41
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 05:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96C1F606E8;
	Fri, 11 Sep 2026 05:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InkFy9Srzt3P; Fri, 11 Sep 2026 05:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E55B8607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789103392;
	b=ZWVdBNLGAwfO3qtoHvH5BnjEmytnFQuuK/+rMW+QChY3m+CFp+15oy7wcLT9qHhOg/yt
	 jGKCG254XETnaR/h9InZgsReKRRPmcYoNOmlgymFqrYKHnZKRWqL3txbqIMaLaBSBScqU
	 uTsiCzMTLljW6Xgmze4VfMDAreJtLWKCULkU2p0lk3RpfqrEpu6fx2tNdVTH4GwKQ6V0W
	 o1SfhniINggiXbf8qX1rDjSj+ijPudswROtYWYvMNrDb3eCfBOkVMirbanrpJ8uIdl306
	 Pdt6PHfPIp6TKc0TDVLHgcb7YZfnI3WYa26lNzIh5f7BL95/xfmz9sXvVzN29TFN97g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789103392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P4n8dp4/KBF7pbG+0XvXscOH5Pq3iLW0bzezDDjDX9o=;
	b=ewVraFIrQ42BfiGqPuGqXTWPpRyqsAt5cKKT2MMDSNX6iQiVW/Uxct0GgKwr+fqCL0MN
	 k6DSrMPttWTSDKNcAtSx5RAGkglo/Yv8Ub5Jgj4YXXNWpXvvuySwyCZvhfGqOwqecdhio
	 7UN7WzuXrHL3z18RJ9CUWKicuuGTjQo7umtotCkg4YObk9bnrNh3al5ALp1raUHSfko+i
	 CZYk0+CkpxNno6V3hP2LFGaWVzHwm5lNHI1N7QQR67VPV7L/IGYdjGI7NCdt9MQFclqYS
	 DrTQxNhau56XdHFGagiVBfmp6u8HE2Xjm85Cfu9jZrR78QHemSh+T753PJstjpHo1+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789103392;
	bh=P4n8dp4/KBF7pbG+0XvXscOH5Pq3iLW0bzezDDjDX9o=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YeKRQu+AHhG5Q0U1/NqGHS5h8tT6OVPAf5+4ZddoHsDG7iCgB/amPq5V/ajfKs9br
	 DVJEEP90eXUjPbd+DqMONzERV6T0WC8OxS6mvKuvbT5OEzaoQtSNipqiy3JOx4GAc5
	 /hQV8zNe5wTqVOOpBz70bWLE/xsoeOr+BA6bqg+UZpPEKHvhR3EHfTCoiw53ziFXan
	 a1rorhPYbzPwx53HFaiqkFYV+A+4WLV7/WGQooidzik2d5+1XKVR+pVrFCNk1CJaL0
	 3qtVPJcH6+mpzoI9lJ5FB0UuAXBu2KGzmeHUKlWZx81AUGWry0gT77hOjMINhdq9rW
	 w8gQOKXg3J2UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E55B8607BE;
	Fri, 11 Sep 2026 05:09:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC3A949D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE9654025D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGtrXN5QUzsz for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:03:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3AF1540077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::246"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789077788;
 b=YHkCB7C0P1v2xYUQvR8ab689aVxu2nhSBLnSZq6onJulaOnV2X+cSBQ7rE2bn1PekSuF
 v49VwGhlgIL8eBYrkmx6vYL8RAsl5e5YUKarCIDp4qGCHZd9AaYgr1zSa7Tu7jQ+7Ua6V
 dh8w846WkK9aQqyCYzCzUJnUJbnJI37c8PQAt0LUwq7Kw1mGdvPZASfjhxIwNT0YyoejG
 qSHwgKOZNF68MZATT6JBRCCzMq1sz0eJsSmZ2xzzZyCSMVFPL+j5ZbzGdbt7F/+Cg8qbw
 QPR/gBqPmgS1FHZSP/ZvKoKXKQYxsvK3l4aA5ZnwKBrq3o8HcN1ZiofAe7SPsCt+f6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789077788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=P4n8dp4/KBF7pbG+0XvXscOH5Pq3iLW0bzezDDjDX9o=;
 b=P5XbOWU0MhBsiMK1mhoTW/UziS2nH3ln6+zWegoUlsA01n+W3g/kat02jxTEGF0lDmiX
 cyMOKshzaYmSdBj91+mTn0nsAW0XhmuRM9MU2ueBpvVgxoNvVqrUaSHsDyNGm3BkPOiZ/
 ntJl5lvXGM6TayO/YCmXiAnSOgIr7/xjN4v/jskKBCaGUce+wCALiXRXaPck93U3YyPH8
 9KthJkQicww7eo9WG7+kdPjBGwJ6HsOiCb9vkloaBXDFJ3H131D2Jhw7IIdwTmxelkdsj
 DtDFRBDrMyb7Lbdn9lFzcOxVfWE7RvK23bISlOclk08u3IHbPMMAmSC2YlCwJqNA4yw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=htz5rjb+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::246"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::246; helo=mail-oi1-x246.google.com;
 envelope-from=3gcmjagskblmjfi3v9k2v8119916z.x97f-w99e63ded.f-w99e-ac94zxe.9c1@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=htz5rjb+
Received: from mail-oi1-x246.google.com (mail-oi1-x246.google.com
 [IPv6:2607:f8b0:4864:20::246])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AF1540077
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:03:07 +0000 (UTC)
Received: by mail-oi1-x246.google.com with SMTP id
 5614622812f47-4ad778bacbeso543557b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789077787; x=1789682587;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P4n8dp4/KBF7pbG+0XvXscOH5Pq3iLW0bzezDDjDX9o=;
 b=htz5rjb+HgF2B7EbJSlFCT7imtxPS93Lp5u8G9pKMpVLR+Co7C+lheCjHDE0vD1vPj
 weyDwdI8/hVec8S64maqAtk1zorYtkmL6r3z6xskXcfi6lmKlFozmLiyUK/fKKIZfBe0
 L6s0ZmM+RDFY7EuFAIdIyNXj/ShwHL7dKiPEtrv75BJXHuI8zzCoBpj1OvmdUxGY0raY
 B353T0mHDSh92JX4Js8rkGnYU803ptCKREkjlgH7mPQKIv8KEqvogGMZSUYuQCjFZFAD
 hiUnZwuPVPRzx7GHWOnLZtV+yNt3kK4esdbduRk/3jpunWWQvjA0ot7hCHZWJAKJXnW3
 4Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789077787; x=1789682587;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P4n8dp4/KBF7pbG+0XvXscOH5Pq3iLW0bzezDDjDX9o=;
 b=qLZJfY4tDe1A/gbR4f6j25aAk7lALbef0SDxRSCPm04C3n/S0sJ3XfMIEp/7nwk3lI
 atUG2FFnfcOQyWq68Arak8KsKbyths5gwJekV6P0h9zLYdMXMSxjystquwCHImSo6RhN
 c0Ley3CSOdgqqlK7F1Y5kvL/Ye5zQvKSQO9Z95Gr4KOLqVu0Onxu8Uy6wms2zpjOlelr
 TuuzkEj3csnEtoKXlQauHUw/EfOyC3gu4YykUyzt9SUrGtKk6DcUXdPStTfca7YuuI1Y
 S7WEF3tfWBqT3LhhBfjMedXaTqNTEloNbqjsOM7d9fcqLrGAN9LSefz4iuyeEY0n5Q5M
 C95A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGIb6Ul1LqMu/RA9hLs7etA8mQ5YH8NXUvrpRiAhHPK8qcf5alJ4YKD9NC47jVOKWTLV1k+XA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nduCnyNt8jUgfz0zFfMeozZf3z4y2vgNJh5EbVgoeQVt67QACd
 ohgwmO3pXc71nfdoczPNRKBgSsDa1F7aa/SH+u5bV97ip8U/wkGBycI/5WoKRdPAigmzZvJEcfK
 nKM9VM5ovHD1AxdRCp4lYdsDQ4A==
X-Received: from dlii10.prod.google.com ([2002:a05:7022:418a:b0:143:579f:6755])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:f004:b0:6b3:1874:6f21 with SMTP id
 006d021491bc7-6c0b5fec555mr690442eaf.0.1789077784904; 
 Thu, 10 Sep 2026 15:03:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:02:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910150220.1.I0f085098ec5deb5c9ce3f89eeda6bb88f3a6adf1@changeid>
Subject: [PATCH] net: use non-LL address when solicit is asking non-LL address
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 11 Sep 2026 05:09:50 +0000
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

When the non-LL target address is on the link, use the target address as
the source address to prevent server NDP failure. This also consist with
linux kernel behavior

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---

 net/ndisc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ndisc.c b/net/ndisc.c
index 641cf6d8385..90460876754 100644
--- a/net/ndisc.c
+++ b/net/ndisc.c
@@ -222,6 +222,10 @@ ip6_send_na(uchar *eth_dst_addr, struct in6_addr *neigh_addr,
 	__u16 len;
 	uchar *pkt;
 	unsigned short csum;
+	struct in6_addr *src = target;
+
+	if (ip6_is_unspecified_addr(src))
+		src = &net_link_local_ip6;
 
 	debug("sending neighbor advertisement for %pI6c to %pI6c (%pM)\n",
 	      target, neigh_addr, eth_dst_addr);
@@ -231,7 +235,7 @@ ip6_send_na(uchar *eth_dst_addr, struct in6_addr *neigh_addr,
 
 	pkt = (uchar *)net_tx_packet;
 	pkt += net_set_ether(pkt, eth_dst_addr, PROT_IP6);
-	pkt += ip6_add_hdr(pkt, &net_link_local_ip6, neigh_addr,
+	pkt += ip6_add_hdr(pkt, src, neigh_addr,
 			   PROT_ICMPV6, IPV6_NDISC_HOPLIMIT, len);
 
 	/* ICMPv6 - NA */
@@ -248,7 +252,7 @@ ip6_send_na(uchar *eth_dst_addr, struct in6_addr *neigh_addr,
 			    INETHADDRSZ);
 
 	/* checksum */
-	csum = csum_ipv6_magic(&net_link_local_ip6,
+	csum = csum_ipv6_magic(src,
 			       neigh_addr, len, PROT_ICMPV6,
 			       csum_partial((__u8 *)msg, len, 0));
 	msg->icmph.icmp6_cksum = csum;
---
base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
branch: main

-- 
2.55.0.1007.g17ff1f9808-goog

