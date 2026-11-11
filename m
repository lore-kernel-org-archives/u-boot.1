Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FB606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uS4JNC24;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTyqXGDI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0F5560D8B;
	Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2y4Ib4eP0_k; Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EBE560D9A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427881;
	b=ISGcxJi9XtVqdzh6VrgWizsZIlt/dVpjDSL6mxjyWujoxT1EKMOH99l+R+19y3R9AvZK
	 qDbAYl5d+F5tz6iRzx7B1faobpDG2dp//M+xfAJGLdEGkUZUvPD0Zklpe8B4DkLdLf5vs
	 7GrQkkYP8AdNjKZdgjrlYk/g0zKfP03S+8GoZIeXQsQpqD6SwjbD0SoYr9YbxM0NYcwkb
	 e5eKmcEJSSArf07BY/7OyR4BHqXk3etTciowGHe8bct5mP1Kx4U9HVMkMFbpheD84ibDH
	 fzx8fNJ+ZCHC1A/UCy+yZV3eIFiGnKGU1Wt94nyjP9IKusJnAbAXo24XWAs1ace53kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4TOduxn68u3tLWuLT5uR4Sl6I+hR9fVlfwXG1em41Mc=;
	b=RSdsQhR4lfutKWz4PgYTi4d3bCNSrKh8jFZQXp5KZce0IK4KRQEkNEDclncT2lhnfD12
	 d404Viw5wibhhXgYDaZlP1CVYu575zpbh8EOys/udtBLNWZzgx8AC/rDdBAlNPa6yFqqc
	 rmqpXwfl3w5Jim+jfH4HAdBPouXQo5IZ0CW+igJyrYlfEGdW/yEg7dJvDeCAjHWQDPk6x
	 piB13mdNpDmQeVwQp417Uy4PZc/RPNSuutni6f9izzUojrfHRMeAGvNOUlCV/eXhXYxOC
	 8zsWO/87PNm1LjsmV5k7UHXRowlxPzW2oCK1eeXwHFoEQgoDVL9gcGcFBDURKxjMxhw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTyqXGDI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427881;
	bh=4TOduxn68u3tLWuLT5uR4Sl6I+hR9fVlfwXG1em41Mc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uS4JNC24lMBdeBqrSG+1hBkKzEHCZuGfImDr65jPlte72K0GGMQYzUp+/ztBk4GKk
	 AsfPNgsLkqrYjzqvgBSYyZRq82lY701BpRyToJRq2HiEuqMBTHvYf2KWQOBsym+BCj
	 nhFEwKu7wS6dHNwZYsAk+ChAgEFJwkesJKoUTFuKCtCDpP5iNDFK4V2/qARVcxiQ+Q
	 DEIMYVQe4ko9W5WT7fKI9ypY4NoRIuaZHUJ3ACTMNfs+hmtNFHjlwGz9PoZsHHjG/h
	 q32kDJfyNRLsG5epeuC3Lm7xraplcCeLNaIpumutpPGa+++qoOkoJBfNv7MfYQrSuR
	 RRHToW1ySG8YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EBE560D9A;
	Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81D562FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66C0760D9B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kMPPV1tNvjk for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93E7560D8B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=MTyqXGDI
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93E7560D8B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:18 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-70b875f6f1fso2815429eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427877; x=1795032677;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4TOduxn68u3tLWuLT5uR4Sl6I+hR9fVlfwXG1em41Mc=;
 b=MTyqXGDI7PGKEDvWd2xGqJhC9Fy3kiaOl/vWfljenoG3X+7KsGqEWPiTu9Zk+i57X/
 aMpWphIIWHODd+Pan9ciFE7VLb+VNDO9kdabEa67+DoGW8uHJTAc35X1tAtNo5w/DPL5
 9Zs8w3FVSMNb5Msz0riEhm+WOpchMlu9DJRLa/K/xyTS5w9IWkJxwMe1hvpa7sFDIWh3
 pOBNer1SRRgTlUEp3+JSltqmIVEdx/r5UzvzsT6HaAavt/ODVyuKF68lzmgAduFxjynZ
 kAONoIPmU0D4xD4PST41cdiS3gr6v6qEXqw1XdMGI1KBE7Jtu7/btL7H9j9dHYZSEhOa
 d9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427877; x=1795032677;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4TOduxn68u3tLWuLT5uR4Sl6I+hR9fVlfwXG1em41Mc=;
 b=D4cj3UVsVCEptsJ6k9XAvorB7w+UNX4tuWezLYvmeDOp6v48r/FweXEkkAgL64ivmd
 66Djxm4icvC4InvYo8lb24gb8V9BvVVH9lZ7kZZthSm1MePtlzc73e+iHoNdoCCEGJbH
 cs/P+RO9LiNLdNCq4UeNO91EzPQIuIjZoqXLokbM2iPF/mPSB4zR7BtzQwprldAlDsUr
 kzY6gCPG3HswSi9pcsVmpDZ5pa8l4ajCJZ1a6auNIYtos8YyOOUarcSvM3MYGxfUiHqM
 2V0zn9SJQbrUc0tTDP4DIEjaVHSAEBxhuYD315Vk35hDLCGOdl3P7xo0XakMvRSj+Q0G
 BU6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErG4dAfsvYzywqG5x0ldo/Sg+D2vI47yoYbmjzg3lKndfgcINT+l18uRQSSnQeupC2dGi6YsJFM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9T5xHqrFJF/lICSsGMJVOmB0yO/8xv/oU1ydAS2CPpHfghUhYl
 d7c8xZ8+R5JAu0Iv7fpeScxv+G93jDN8q8gwamd41o48DWVaJzuNU72rNTCE5w==
X-Gm-Gg: AYBFou2xmLMSuOD3+4tcfXxo1hG+RKrbng0T8SIIEJdG4MT822NF9gwn6P9KUYYPXRi
 TYVKheGewX6ar4KoPUgO2ipfRBgZdxF75eQCNGgAwfdRnFMrpeTIiJmzVoifPymkHfvpR5H+MR1
 0TZvmVeLOSchEI9z42O72hXC6lAoUtZUJaZpnT7V6gyMk/l5WfOVMX+uxt5ot/8iOad7X9/x7mn
 NxiW9o7jCxNLl26iTu78GsQFwjc5Q40j/TjobcuIRCqH5BSay1WfzChFP1zs90yIbp4/PPOPAGZ
 oR1acfoqEqVqadBtqQIqpy96ZvhMH6vS90j3gNS6ijHEgEnOO3p4t7b9DaPKkBHf3hlr7x91bCz
 o52gQzOBqfduScrboEjQxN715b6rJsW0AV2/6REnpQFYepkARiMQmxA+TFfY3YJZUf5qx03CtkD
 wpP7XZ7oVarhWdK7r2NaGq56b10pvpk6bkemeD+ByBefFM08d0eKSRs1UWvJPwh3AHn3rCqUNSJ
 2Pv8AVHlRW5snc0t3CR31G6c7U35mNuAlL6gj1v2nyeJPpBvLI9n57lune3Kkid84fu4PrJHn95
 rZGWy9BzmxHEiT2pCX0upzSorKjuxEQBmj/7ZX3f5kS2f8PWgAWkiaII2Bm/9XIW1EPNeXfA47H
 Lp78hg2VKYh8HnWBDHaF5XrQNSVnFTbNzaIyqKavJ9O3dJBHbQWHUavCtuIxe0BWCzdY+1DIH4p
 C4pH60mEW/UTLYQimdmKcEwIiDvDEQMkSftCwORDqKa/o0RdIEkpQ=
X-Received: by 2002:a05:6809:2cf:10b0:567:f6db:8b46 with SMTP id
 5614622812f47-56b97611fa9mr2469505b6e.34.1794427876655; 
 Wed, 11 Nov 2026 12:11:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 00/19] net: lwip: enable IPv6 networking and boot clients
Date: Wed, 11 Nov 2026 13:11:07 -0700
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBBA0auQWXcSQaLVqzRdFBh1GqUELDUx3
 l3aLt/i/x0SRaYEvdghUubEL18gLwLs9PAjIbtiUJVqpKw6TG+z8IrzhwNyyA1miUo519a2Nlp
 foZQh0sDb73q7/12yJ9n1u4LjOAHNwGYCdwAAAA==
X-Change-ID: 20261109-submit-lwip-ipv6-v1-22dd73c3b448
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable IPv6 alongside IPv4 in the lwIP network stack. Configure link-local
or static addresses on the selected Ethernet interface, perform duplicate
address detection, and learn prefixes and routes through router discovery
and SLAAC. Static addresses support explicit prefix lengths. DHCPv6
supplies addresses, DNS and TFTP or HTTP(S) boot URLs, and renews or
rebinds leases while networking is active.

Extend ping, TFTP clients and server, HTTP/HTTPS, NFS, SNTP and netconsole
to IPv6. Resolve hostnames in the active network context, including AAAA
lookups over IPv6 and DNS servers advertised by routers. Preserve the
original hostname for HTTP requests and TLS certificate verification.

Clients share the network runtime with IPv4 and persistent users. Transfers
wait for a usable source address and route; lwIP resolves neighbors as
packets are sent. Teardown releases learned addresses, routes and DNS
state. Finite learned lifetimes include gaps in network polling. DHCPv6
retains lease age across commands and rejects expired or withdrawn
addresses. IPv6 NFS discovers UDP services through RPCBIND.

Preparatory changes make address users dual-stack-safe, keep sandbox raw
traffic on the selected interface, map CA certificate buffers, preserve
the scheme and authority of wget URLs, and handle TFTP headers split
across receive buffers after IPv6 reassembly. The series also propagates
IPv6 port-unreachable errors to active TFTP transfers and adds sandbox
protocol tests.

Based on U-Boot main at 8ea02c99391d.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
James Hilliard (19):
      net: lwip: handle TFTP headers spanning receive buffers
      net: sandbox: bind raw packets to the selected interface
      cmd: wget: map CA certificate buffers before copying
      net: lwip: recognize wget URL schemes only at the beginning
      net: lwip: prepare address users for dual-stack builds
      net: lwip: configure IPv6 on the shared network interface
      net: lwip: add the ping6 command
      net: lwip: support IPv6 TFTP clients
      net: lwip: resolve hostnames on IPv6 networks
      net: lwip: support IPv6 TFTP listeners and server names
      net: lwip: report IPv6 TFTP port-unreachable errors
      net: lwip: support IPv6 NFS and SNTP servers
      net: lwip: support IPv6 HTTP and HTTPS transfers
      net: lwip: support IPv6 netconsole peers
      net: lwip: acquire and maintain DHCPv6 boot configuration
      net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
      test: net: exercise lwIP IPv6 addressing and DNS
      test: net: exercise lwIP IPv6 application transfers
      test: net: exercise lwIP DHCPv6 lease and boot lifecycles

 arch/sandbox/cpu/eth-raw-os.c                     |   12 +-
 cmd/Kconfig                                       |   25 +-
 cmd/lwip/Makefile                                 |    4 +-
 cmd/lwip/dns.c                                    |    4 +-
 cmd/lwip/nfs.c                                    |    5 +-
 cmd/lwip/ping.c                                   |  127 +-
 cmd/lwip/sntp.c                                   |   38 +-
 cmd/lwip/tftp.c                                   |    8 +-
 cmd/lwip/tftpput.c                                |    8 +-
 cmd/lwip/tftpsrv.c                                |    4 +-
 cmd/lwip/wget.c                                   |   17 +-
 drivers/net/netconsole-lwip.c                     |   86 +-
 drivers/net/netconsole.c                          |   18 +-
 drivers/net/netconsole.h                          |    8 +
 include/net-lwip.h                                |   28 +-
 lib/lwip/lwip/src/apps/http/http_client.c         |   27 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c                |   12 +-
 lib/lwip/lwip/src/core/dns.c                      |   28 +-
 lib/lwip/lwip/src/core/ipv6/icmp6.c               |    9 +
 lib/lwip/lwip/src/core/ipv6/ip6.c                 |   14 +-
 lib/lwip/lwip/src/core/ipv6/nd6.c                 |  339 ++-
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |    3 +
 lib/lwip/lwip/src/include/lwip/ip6_addr.h         |    2 +-
 lib/lwip/lwip/src/include/lwip/nd6.h              |    4 +
 lib/lwip/u-boot/lwip-hooks.h                      |   41 +
 lib/lwip/u-boot/lwipopts.h                        |   12 +-
 net/Kconfig                                       |    4 +-
 net/lwip/Makefile                                 |    1 +
 net/lwip/dhcp6.c                                  |  999 +++++++
 net/lwip/dns.c                                    |  245 +-
 net/lwip/icmp_unreach.c                           |   33 +
 net/lwip/net-lwip.c                               |  487 +++-
 net/lwip/nfs.c                                    |   48 +-
 net/lwip/tftp.c                                   |  167 +-
 net/lwip/wget.c                                   |   84 +-
 net/nfs-common.c                                  |   73 +-
 net/nfs-common.h                                  |    2 +
 test/dm/Makefile                                  |    3 +
 test/dm/eth.c                                     |    4 +-
 test/dm/lwip.c                                    |   49 +
 test/dm/lwip_dhcp_policy.c                        |    2 +-
 test/dm/lwip_ipv6.c                               | 3098 +++++++++++++++++++++
 42 files changed, 5690 insertions(+), 492 deletions(-)
---
base-commit: 8ea02c99391d2d922810065206721ead2863f075
change-id: 20261109-submit-lwip-ipv6-v1-22dd73c3b448

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

