Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA82606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f+Nl4UV6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uOr98lq/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08D50405ED;
	Mon,  9 Nov 2026 08:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKH0WUD_UfaN; Mon,  9 Nov 2026 08:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60E71405F0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794212056;
	b=NqV7w3RgLblBmUhK0dCMX7nj43smIV0u+TouPCr+Q0Es58JWsTcFg5I8YXnJpFtMAe4v
	 mSRq3ZZczGWlVyRI0gN2BeMTB+dOZgsN5JBUfi5LToqB7PVTyoC30ELsoUVP1jSMLaOnt
	 My2zeENONa8OkgmD8Zq8X0rmV5jZn8uGb+yceyyZ9PfbH3ESDaeDhPtw8f3eLK8wtTcP5
	 NiHLlhW2oyBzlqExVw4YPQ6lP+xwXEdCk/thFEkfUF2/ksb7/L7NbK6JneDYUOB5mrxA7
	 NR3CZnDf8HHiFrBJ+t8SnqDFuy7axrKuNXYOTXOHELFu3NOsosTNQGZlxogM096qgAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794212056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=00+vxH/hng83WER9DhGtBB5zJCTCj6zdIX5MxiRcDNI=;
	b=h4hlGvGTly0RWQUmxsJzB86nze0nv85oBllTY5GD5sNROpPYFQBE+vUc/Eel4jiZvdE7
	 AsESiv79EnDnw3kzcqWa/Lt9sq1jh4zWJ7ucFw40MTsLzPa6lMKDC9ynBa9zfmKUADbm+
	 5F64V3SfDfh7OCZUlqUKbtYJRsveLTmof2zgScria1h7p7CTCq/oNGHfreZIGMA9tpgQk
	 jCUkO91wYDKQy1j2Fmrn+8pXN1XTYcQiVHhuLbH04WxOZCMY0mZfLvROkpt2l4trvuz1/
	 ME1AXnWlMm1A4V1JPirjKQKqCEMYw741ZWBmkgQM3q9KvrZ91p2NhktXxR42yjkJKvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794212056;
	bh=00+vxH/hng83WER9DhGtBB5zJCTCj6zdIX5MxiRcDNI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f+Nl4UV6Mbzt8/YEFvXHHVuAtJDSHIuzA7J+jT9zFjzZYtLKvWROvgszo7mKOg8M8
	 DejxF4T2qr+NjLy0J1aNulCcnxEkEtrSJTu0yi6fEx1m3vxv8ZLb4K5zE8/3XX5bXv
	 RuvXtwGCOz/fXS04nMlI3adA5G9JjNbrz/FLYwfmntGdgD5MNB5JW0JkrVaVmBq3JA
	 0bw6rItok0WIIBstkBCYQq8tRyuClkyB8AuQGQpEn+tuBAPe0WbKqfbt4KL41U6JAn
	 QmLPiXdsFsSdhI1LJK8T+QERsNJQ9n9EhaEtp0fdzNoMlhBZa1OsOPAU0kJbVRljsX
	 UcNKmR2S8ku2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60E71405F0;
	Mon,  9 Nov 2026 08:14:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 156CC362
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF8F140242
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYUBaghxbQru for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4DEAA4022F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=uOr98lq/
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DEAA4022F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:11 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6dd7070699eso334765eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794212051; x=1794816851;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=00+vxH/hng83WER9DhGtBB5zJCTCj6zdIX5MxiRcDNI=;
 b=uOr98lq/3KVCVjWKjF8jfYUdWdv0dOHqsXK8pFs2PqAaJ1jS03C/U8avJxhCULxJmS
 kMnwA4qqsXjWu0pQTIEo9EIhvlQb0ZX392NrhdMx5Unmq3OZBpiz/zqMoKG33qk/74jg
 ZVOPwl7QTRU78E91CtXkcjrRHL545NEOEvHU6QWDC2HaHSyKGumpcqoFIW3ivbiKeZaq
 KMrLEMmmjDvhg2wN2lNzQFBJ8mpRo1GxUqQpxpzGWGol+8bgwjNeaVmJMVcXBAwk9tI2
 VfwMw9bu0nwtupqlMEkvOXxokB5DUbTepm8JuCGlrkfjnBq/OKvLVQg+i9AvhbckYjeo
 1lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794212051; x=1794816851;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=00+vxH/hng83WER9DhGtBB5zJCTCj6zdIX5MxiRcDNI=;
 b=wYiOkmZIzZBCAXnc7BPrUmr19v+6su3v/B1Ftt9ZaWVSFA71Jri3zzr9ViFItp77hS
 2wQUyZTMRzgllKF5Jkex7djsxY6xGtFIafW/UVPhwCns9tbWrHvm0XY2RR+SQqlJdzAE
 MtlUJ9WNyk6LDoG5QKxwstYJ4z0V+JPgJ0CBYCpwI+2k//lMM0JpfW52h2Om5nWztMoF
 8VzTNRVdiq78uSaOkcV4GhMwb5Y7PsJKn26ghQlKI5j0TkdFpieN7gyoY58Z44XrhrqD
 jvbESB973qiBoSOu5en29plrY5BARsL4sDT+T6DNhhAW2s10A71Tl4dnVwGcNeukLNRj
 fxRw==
X-Gm-Message-State: APuU4Z+I6Nts/dQnHOeFxAzHwzlzIKm4G4D5qkZRvg2xKP1hq72fFVqw
 RWsJ7Nw2aSCIxbBxTMQ/6SI0izMqyyYhdzdD5WyUK/eju4uWubKODKWdJF97flq6
X-Gm-Gg: AYBFou2WkT5jBTxHC4awNHtW4sAAt0qlZi2eEuxehUqk0QOJTe4aaSX0Pey11tkq0js
 9AS0z5o4IPGjk7fbfHU5Vpm4Q3nDQdeTlS1Zme1QKOf+1JXZKTJDMZJp3K/P4HjqLUVz7mCgSL4
 qFfliI6Atx6kx5ErsbbcokDLeldosETB9gPsXJY8K4zvgViP+B1+nQ7Y+zOXFK9IEfSIWvh4t8t
 CFviCZ8L7k96hAZvHLF9pTX7bwVDLPE0g756HnCDlSDM4tyD9YWICDxJt5lO+WCYCe8SROJd1QV
 cPwOertj21mS00tM7BHGCj9cI2zC/Nu23G1EY5GtHX2KpOs8+SnYMLkICz3MeUs225cJwA22/fj
 EW4j9iwVu1FaDeJcViZ7vbIN0zLGAxF/tC7UJNb1PfFjbSvq1SRQq+HCs9j9Vp9kYdhCHRKiQdm
 Eqfw+NdBHm0Vbp6IREbNzdVHH6oNXb7XXkskn2j4DujP2rAj0NkuVTUA9V0s0a4FisROyBnM5ot
 NaX3Fmq2ULa5iGoMu8EFLNUleGam9bgy5xreEty7KWkE10k7exw4O+NIaoSYpXlI022pzNig/dO
 n8zgoIQ+eB84XR9nENFEQuk5t7eE/iTe6QAQjRZNT3AR8BB5QtXD4uwRDF/d7+xsKEIEIzPzje1
 tmj7qmkdYpNRW/ff2lrxib8FPQCiiuWXQ78sDs4Xl6x78nLMCy3ZzHJQM1l04v9lpmqDFknaTtl
 8pd4IL8KxcFaiFRutQthkXavhov2pdnpbHmm+VbVuASnMhm+xxbqY=
X-Received: by 2002:a05:6820:a00a:b0:703:8835:5fd5 with SMTP id
 006d021491bc7-7170f2b1d31mr1252273eaf.25.1794212050678; 
 Mon, 09 Nov 2026 00:14:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8cbcb9sm2816766eaf.6.2026.11.09.00.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:14:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/3] net: lwip: add wake-on-LAN command support
Date: Mon, 09 Nov 2026 01:14:07 -0700
Message-Id: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQqAMAxA0atI1gZscb6KuLA1asSJ1gnEu1t1+
 Rb/X2DJMFnIvQsM7Wx5nhyE74Huqqkl5NoZZCDjIJMp2k2NvOJw8ILHPOAuUNakolCoJIxicOF
 iqOHzmxblb1f1pNf3BPf9AInxbyl2AAAA
X-Change-ID: 20260928-submit-lwip-wol-v1-2deb541b7456
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make the existing wol command available with lwIP. It waits for an
Ethernet magic packet or an unfragmented IPv4 UDP magic packet on port
0, 7 or 9, including when the interface has no configured IP address.

Share magic-packet validation and Ethernet password export with the
legacy stack. The lwIP listener uses the shared network runtime and
leaves other clients active when the wait completes or is cancelled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (3):
      net: wol: share magic-packet validation between network stacks
      net: lwip: support the wol command
      test: net: exercise lwIP wake-on-LAN reception

 cmd/Kconfig                |  11 +-
 cmd/wol.c                  |  20 +--
 {net => include/net}/wol.h |  27 ++--
 net/Makefile               |   1 +
 net/lwip/Makefile          |   1 +
 net/lwip/net-lwip.c        |   4 +
 net/lwip/wol.c             | 129 +++++++++++++++++++
 net/net.c                  |   2 +-
 net/wol-common.c           |  46 +++++++
 net/wol.c                  |  51 ++------
 test/dm/Makefile           |   4 +
 test/dm/lwip_wol.c         | 301 +++++++++++++++++++++++++++++++++++++++++++++
 test/dm/wol.c              |  91 ++++++++++++++
 13 files changed, 618 insertions(+), 70 deletions(-)
---
base-commit: 1ed1749575f28b406c241218eb6a200574574a25
change-id: 20260928-submit-lwip-wol-v1-2deb541b7456

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

