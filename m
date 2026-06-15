Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC0ACD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 23:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33B6848F0;
	Tue, 16 Jun 2026 01:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="CBnqY7Vt";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Qi9tFAUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0DA8846CF; Mon, 15 Jun 2026 21:46:36 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2a0a:51c0:0:237:300::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6F5846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian@breakpoint.cc
Date: Mon, 15 Jun 2026 21:46:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
 s=2025; t=1781552793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9IgUSoClU0WXFHNMyMlB4wWBYC1+JHmq4qrDy9nMy8=;
 b=CBnqY7Vt/UVUkaDa7wSM8Nx3Lm6WGkrWXs/Jm8pRMlfXh8lqSI8I9YuzersRnbfXKBUD4B
 DRZDshMIFzX6/XTqKG6uJJj39yyqtEhyRbuV30kiEOasiUsP7vd7pQNY4753Hoxr5QDpNP
 vMg7BoI3KmRavo3OM6v6ehW3RQE8ZuoP6UAg7mDpo9X2GjRgFhbEc1ip1fWU+nxMCSzgWv
 WGqtGtXHn1HJ0e9r/sJAIlyGwHgmE0AWQ3o5r1se7yv1uY0XG8Htdk4WG8ACL+jARPTyq1
 1vImVGRwmnVRkYk7W7jSO54kY5vP9QKOve+MnFk3kpJpmFZJ/jj16gY3He7FnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
 s=2025e; t=1781552793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9IgUSoClU0WXFHNMyMlB4wWBYC1+JHmq4qrDy9nMy8=;
 b=Qi9tFAUa+5UdUzipNjxR+uPy5zZM9i6ouGZhz6ETOvAOxZk+QgmIM/MI7gOhiTHKhpEd7U
 NdRepO5gQJzJDDBw==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
Message-ID: <20260615194632.ACNju1Qi@breakpoint.cc>
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
X-Mailman-Approved-At: Tue, 16 Jun 2026 01:14:20 +0200
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

On 2026-06-15 18:07:18 [+0200], Heinrich Schuchardt wrote:
> Add -DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations to the
> rsa-sign.c build flags.
=E2=80=A6
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1138297
> Reported-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -90,6 +90,9 @@ RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) :=3D $(addprefix gen=
erated/lib/rsa/, \
>  HOSTCFLAGS_generated/lib/rsa/rsa-sign.o +=3D \
>  	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
> =20
> +HOSTCFLAGS_generated/lib/rsa/rsa-sign.o +=3D \
> +	-DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations
> +

I suggest to ifdef the engine support for OpenSSL >3 away. Also maybe
removing it since the "provider interface" is available since the 3.0
series. And since 1.1 receives no FOSS support it might not hurt anyone
to drop it and keep only the provider interface around.
If the engine support was introduced due to $HW then there should be
matching provider support.

>  ECDSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) :=3D $(addprefix generated/lib/ecds=
a/, ecdsa-libcrypto.o)
>  HOSTCFLAGS_generated/lib/ecdsa/ecdsa-libcrypto.o +=3D \
>  	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")

Sebastian
