Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25C606D81E
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WYadVXDM;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YMM+8SFD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89DBA60833;
	Thu,  5 Nov 2026 17:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3HgiMxwgUD5b; Thu,  5 Nov 2026 17:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B482E60697
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898214;
	b=U5yo17tAmz0g4n0Bi0/hvPkvsPVHwNmH34WKk/cvVMUdoLodbTeKJv1PEBgSv1BLG+v9
	 xI5m/9AIxmp5FQXDwdJLcacNek1iuQnFJb6NABTia5wZl3mfpqKixCzRCClYbYkS31Ixw
	 +1UF32qxDVYXlZdqrraOhKRvRhXq1M6YZ1/yEQE1WC/aoRHNEw3Wj0RsPJqi0zKiEjx5M
	 kX3M5yh9hVhgRT8m27KXODJcsjh+z/08BS21KaEtjZIw13FIJm+OV4gkv3iDbnhYkV5zt
	 b7EXdDtS6txm+GjOwzW7Q/m8bSppaf7EkSWnLK8t55h8CuwPnHJHOL/PgwC+2OIxaww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SXWpCmk2wSB8uckWRJ69SK2Sl52jkSzKslDXx5/IK8s=;
	b=PVzyHIOSyqCZpKGaDwIWXmnZl8s66Eh9QFqoZkWQ28acIWWWxWY8ZmlE/TbCZqbyjWwt
	 tIBDhHz8QLJ6HncXu4s4gO7ikVvjJzw4tk5P/yGE4wBuv5xPnYYq7nCElUJWNFujESTwb
	 hjj96BhtvHh8Qr8v538WM9KkfLkLj+xlzDofo7rCLbYElyUJGbTzM0yGVNYNe5XcaIEIl
	 859Ofz94F3bRqhw/SYX/2qSojF2uTUDOnDNZnN1Gj+lyJ2nHgOPHd/Vw8+eLA6VWYfAO/
	 ef8OOtUsmsEk9uBpEhvagVr3Kkf5XpSaTP8zyaAUOO8XPGiaBiQviowijy59xszpiFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793898214;
	bh=SXWpCmk2wSB8uckWRJ69SK2Sl52jkSzKslDXx5/IK8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WYadVXDM+N91Hu6avt6rYqQ0RRp0bw3JqY4KjzOM7NwfPq1wwQu9yMACcYP3/UMYT
	 S1hXPXbNmw5oogwkCR4Yk7CHb0XCwJ8ajMfhhnZst/CwqYq+gqa9SQZMhgx6ZuWqX3
	 nYH9o3VdEIGMoR3FlrwLJvnDl2OHnsqbo5/92K0qDqa8BDkhHudX1Z/seWFdLcsANl
	 CthTRMegq0GK+nuA5fm8wvgLXivsr2lKN65TmAAbeGnozd2rZCwRBASrT1sCZMY1Av
	 d50T8vx7RfrlWEj1km+W+IpXNTWnbcKADe7L+LbfengUI8bbb/4mUbSlkbC4Hq4LIO
	 GNyHmF/E1QKwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B482E60697;
	Thu,  5 Nov 2026 17:03:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9879E280
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95B408111D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZuze5a29vbO for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:56:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 264E4810E2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YMM+8SFD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 264E4810E2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793897776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXWpCmk2wSB8uckWRJ69SK2Sl52jkSzKslDXx5/IK8s=;
 b=YMM+8SFDNNjzhkLL5VU09wleJbUFG7z1JLIidJl13NV1D6P+dCelLw5Hr4Nj3S7gY2YYC0
 fT2ggy5TQtIb60dAGN9xtRCIWTxfmn+vT5LTNcPIkDqqzstdCDFjrImNxxLH72+AM3kKAr
 EB0iOpCAhSi3wc3NZi69C/GJgpyZgJ4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-gfoE4c0yNHezYGt52IUtMQ-1; Thu, 05 Nov 2026 11:56:15 -0500
X-MC-Unique: gfoE4c0yNHezYGt52IUtMQ-1
X-Mimecast-MFC-AGG-ID: gfoE4c0yNHezYGt52IUtMQ_1793897774
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-844195cc415so3149334a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 08:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897774; x=1794502574;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SXWpCmk2wSB8uckWRJ69SK2Sl52jkSzKslDXx5/IK8s=;
 b=VaXdf5InHlJTPy465KWKIrbrYRVz687CVzoA7T60xJ5vIvSAfeFK6FDKJJAA683u6B
 xxTzRCw31kJoddrTzmgJXDJq61ym7f2QHsYWzZ9sbMXWsChDpnOzblFNp8vfs/Xpm/pC
 KesjMhsqsWfOIFJdCH3NS93vxJSnZU6lJ/xeCYJeQF2QEn4Dr/PVf1jIbLIay19jEXzw
 KmBqHKflcEHX7oJ0KeRVdWV1axS40Lx+QG662IQou62iwNz/aOV58Ugk19bEqqk2XcL2
 Xcz0rFrlBtNdnm7LGdrPtw7S4tQk/Zzr8CAhLwFnlOOiAaZKHBAoVpVetJXtr6rxVG9C
 OjfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrlw5vhyZLzOQCUtKSSYNocJcPpSsf4VDPnirmeasaWLIMFyDdJQEJhy27jbgC+06zwdpa2Ts=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/fEWJxnsStzMntdg+u+fMlzEj6CJaj81kSM4QY4N+RmoCRW+P/
 KghJ3RPPOqbFVen1cuzq26r6HNqkNzsjp/ZaxiRTXcMjUIQg6OWxtInHiFOru0xSsAb7FBadj81
 c4LA/y9Jmra7SzuL9jYj+XOeIrP+g1ZtHT6X/yYoSWtMnQSMt6cGWCWBYk8+9UbC5TiqpKA==
X-Gm-Gg: AYBFou1elHTbQL45M4CcJ+T9v8wFD+EjT3dSkuIjw32uDm7Z4MKB//H/BiVnEpbNkpv
 0OnuQkrRlwcfbC9YtLLgHB5Az3og8ZJKwdMlRQopoC7/9Ww/1q9UZ4RQuh5aeN08P9hBZfsOcLz
 kDOTtF9udr0FH2jHQZnd1ucenJOvuQK6MhgKi31I+/LmcU6hGKSjh0wZcC4jnqMYvkXGXnkE/ei
 buX+aYIIsqx1BRFSyBGvNOklUS3208DbfuFKQKfyK2/Feg6LDl6o9h9z29T9+QEjxGAcBAFxkEG
 Wa89FR/0BZe7DbyazdkHz54SvO2e0SQ6rcb20w5LEcccOJK7TmPSpij2UiWVni3OVRfouji7uiu
 /GOmWs41xkzHrWiuP3E15C62yTCFp34GOW8YzwA8Rm20=
X-Received: by 2002:a05:6820:7408:b0:70b:9808:a78f with SMTP id
 006d021491bc7-716e79b0b34mr36832eaf.51.1793897773893; 
 Thu, 05 Nov 2026 08:56:13 -0800 (PST)
X-Received: by 2002:a05:6820:7408:b0:70b:9808:a78f with SMTP id
 006d021491bc7-716e79b0b34mr36812eaf.51.1793897773096; 
 Thu, 05 Nov 2026 08:56:13 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3de2722sm4992056a34.12.2026.11.05.08.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:56:12 -0800 (PST)
Date: Thu, 5 Nov 2026 09:56:11 -0700
From: Eddie Kovsky <ekovsky@redhat.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
Message-ID: <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IdLLXGQCsYwld9OSpyN37VCZtqug14bLYD0qsM72Jrk_1793897774
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 05 Nov 2026 17:03:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26, Quentin Schulz wrote:
> Hi Eddie,
> 
> On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > users have been advised to migrate to the new Provider interface.
> > Several distributions have already removed support for engines, which is
> > preventing U-Boot from being compiled in those environments.
> > 
> > This series adds support for the OpenSSL Provider API while continuing
> > to support the existing Engine API on distros shipping older releases of
> > OpenSSL. Build dependencies for local development and CI are also
> > updated, while the final patch adds support for using hardware tokens
> > with the Provider API.
> > 
> > The changes have been tested with the FIT signature verification vboot
> > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> > tests pass with both the legacy Engine library installed and with the
> > Provider API.
> > 
> 
> I'm NACKing this series quickly because we are having pressure from multiple
> projects and Tom would like to see this fixed ASAP, and this version here
> should not be merged. From a cursory look a lot of feedback was ignored,
> possibly because I did too many rounds of reviews and it got difficult to
> follow. I'll therefore spend time next week to collect the reviews I made on
> v4 and that sill apply and post them condensed on this thread.
> 
> Please, we just need to fix the build issue for 2027.01. We don't need
> providers in 2027.01, just the ability to build on OpenSSL 4 and on distros
> with OpenSSL3 with engines disabled, without breaking OpenSSL engine support
> for other cases. If you get a patch to fix this, please send it whenever you
> can, I'll still collect the reviews from v4 and post it here. If you're not
> interested in doing that, lemme know and I'll take over this part and you
> can always test the patch(es) if you want to.
> 
> Cheers,
> Quentin
> 

Hi Quentin

I designed this change from the very beginning to maintain the existing
code base and preserve backward compatibility for users of older OpenSSL
releases who are still using the Engine API. We cannot add support for
OpenSSL 3 or later without moving to the Provider API because of the way
the OpenSSL project has changed their interface.

Both I and other reviewers have tested the proposed changes on different
distributions using different OpenSSL releases. The build failure is
resolved on OpenSSL >= 3, while building with the Engine API still works
as expected. (The only obstacle we found was that signing with a
hardware token key using Providers didn't work, partly because the
existing code doesn't make the pkcs11 uri parsing available on all
paths. But Johannes already proposed a solution that resolves that
issue.)

What are your specific concerns about the code in this version of the
patch series?

Eddie

