Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89668606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SEjJSdsr;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Sn8gzVUd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 654D160A92;
	Sat, 24 Oct 2026 13:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQ9NL_6JLfZY; Sat, 24 Oct 2026 13:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 956E160AB4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847046;
	b=NLs+XvYnIbQdZip1k04CHgMT80qJO4Vw6pbN39AX0B/pVAnu630wlM2mOH65spnFzU73
	 Zlf83byk8C8OKWl9DsWdgJEtS8i6RVvOWoYvI4ArYpGN60GfEaHyC6IWSRr0/yMdcwtnW
	 9Dq78KLPUlDhNQuHaiHGnDYsWdGFCrkcmTtkLfqTybLiEUAlIjeYwZBFUxCPOHjLYwUNb
	 FJk9DJTZ+6Z5Js3YlwJ5ft0VtKD1ogBqTzS15cY4hJ+pEnAWaqLEBtQ3ymZD2hZnd5xLm
	 K54EWfPf7wsKBCcEveVAI2SMra/es9ZpRZo0M09Gnb6FfEbe2m5NQiCmHA/0AFSSDDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Gs8nvqUD6Ewa/yJuBN/6S2N8sXpFHlp7zBTEIi1Dfek=;
	b=aX2QFm+a01Bp7MJus6hiWTRcRTkIMClPK45M4D3etC/OrW6Rm5pPi3lfGthTmXtCrS5g
	 xPAGWi6yZzjBHppKbIon1HlZFgKRLx8jIXRxEdLe7Nu9nxcEVmiGVHakyV9jx8FxeWpCR
	 QawOzbbtDBkrf1dl9jctKBwu23YjigHb0ghYgvbz2Jnpbf1A9swYrX/bJWuOfaTAgf58q
	 bt7zUlMjvXUpdDWeOVDMOTGGgqfKAmu24oON/47Jj7ZOg0x+fxsNa6/F2TwYruVUzAWW9
	 se4M1vVNL2Phrdr3W9qN9NyBRPw1w3HZV9dfE8RBlvScN0yGZwzovlwvyDQGdWXOOqA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847046;
	bh=Gs8nvqUD6Ewa/yJuBN/6S2N8sXpFHlp7zBTEIi1Dfek=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEjJSdsrcpV8fpSerPwu5rqhCuzpwz6rf4g1A48aNvVvGZJqyqSTf2JRLMbR8e/0P
	 n81qj1dpgkMEk9Ik0OhIyApxi4Ls2zI9hwdQdzGW3+Uxr2FwtTPK9PHUl2dkTr8BoL
	 JoSON4YMbImiiXZx4wP1iyOKdKLrF8WBgSho90xFw+BPLTM7YtGFhlOYvYDQQsbRPY
	 hs3A7gb2eWFYBGxhWv6qno0RYePnFrv86y91rBC8g2a5OVhWADvXROfpe/iJDHYd3o
	 F25AEwITKrB2sb1ThsaLCUJWdEsNJjjVkXpqBXpDuMRLwNNwSRrIcXpEk1tJhkkoUh
	 Z9dLW8AhPuhBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 956E160AB4;
	Sat, 24 Oct 2026 13:04:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1AAB2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7559400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1O35sof8fHU0 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CE27040068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825307;
 b=mom47uY99X7fB678nFBN78dL+iD/rrxSZPEaEcGoKAi9P+2XcvJ8px6TKmFpL8OYVyA6
 M+pRe5TomuM8MrnGLuQkJc+djDAZtkT5++7REK4LbdQ5HTTYkXna9vxbfKgRSiBD0wYms
 bnAYV7ijvU4YQmx/F+iNV+K/BgGQLmQho4IPmt46aT/zx7nTAkoH2xWlLDN0zPFlKMw7V
 vTFOEIS+wK8ZYOTOQ07KCP7IcTKYkMfCst+fw+/tBXr0dvCmnd87v7hrYFjkW+VrDAK23
 O33B1xOjlye9fmPefmY84cglSqkELa7vTVchZVWQMP/ygKwcKxrEhFOrK+6Cl+TYbvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825307;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Gs8nvqUD6Ewa/yJuBN/6S2N8sXpFHlp7zBTEIi1Dfek=;
 b=o9bYYG7e28heXkkM1g7PktRPsQ4/sVsUsxdXptst5fvAAcwqO8+a29LOh7afF5J4UbG1
 v8KGLwbLx9bPleZHZIANJ0Mx1nWeHfhK//XD8NKNqwstY6J8oy3uQDNHRMKrSSg+Im1Yy
 6GSbF4YjLDSRXwyy4TJLEkOB1glKW7ccwmL7UCo6Jc07tttBWyZnbvjj3MRlo1jP+BT8t
 FJ0PPQDLMlslbdiZpVntmSC0WaZK659pIZMSYBRCZ7NfqTZ6RwN9o+I+8nBn4IEAvkM1d
 0FeLLZrvqWGYC6QWuw8zVQXLNKlKT1rXHlnyEMN+JrIxR/kKPnRFnt1Feg3Cs+MVQHg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Sn8gzVUd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Sn8gzVUd
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE27040068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:46 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2309306a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825305; cv=none;
 d=google.com; s=arc-20260327;
 b=qyNWkOMnF7JjpWshZs8I+M5bS6oHi4/BDekL47CVr/yO0wyro3TtSgWqFOV8vFwbfR
 oHfA6NoPajGYVwyXsqj8XVwfXW+oYl0IytxQR8LSclNaGCum7VCL+bS/gVaF80r95GYr
 udzjxzAvQYEXU9Qqe+ZiPSOYIB+TxyB0ddd29p3C7DQ7uDs5m8wb8WqKk/Ns6JcEdcTM
 uKPGu7GlNBB3ByxAnwNfgUVSS91P1f8VkndQSvn+v50k13meGmV+pKSI5WAIOKV801jl
 FRNCXyRWThd/0b5+jpQ2Up1s/+Q4DDi9TCIRycOQANIOPLpyQySb8mo+dyayhF3bQoaF
 tdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Gs8nvqUD6Ewa/yJuBN/6S2N8sXpFHlp7zBTEIi1Dfek=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=HgD7NwmQwBPvoZIQi+b28067rQVvjHYouwlCOL0K1Bbrft6Xj6S13cTJVUt473wYDr
 eiz896Cl8fnjxVDoeif8DduNhMGxLbH9xhtmhwIGSIW9Honmh66f5v4MjSoEbMvBNSlW
 Cmzn0eTWfglNoc8umCPvDIMm3T75QGSPXxt1rOpMtzym3RUzdLgs/LtKFirQNhFpFReo
 yIBwEKQ8HngPGJJ++C08d/E5QCxqr1ohWTsL18b83movbLlmD2yQnNCNRnSK8q8NVrcO
 x3z2V14UCwSC6RfqdtMcW1dduq5hfoAtbvDxKLcbk88B0zXcQUmC5Dvf8WX01WQoCgo5
 bzbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825305; x=1793430105;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gs8nvqUD6Ewa/yJuBN/6S2N8sXpFHlp7zBTEIi1Dfek=;
 b=Sn8gzVUdQ2WaXVz6s8cgH3yvTwqfCw2Q59hXU/Mcv96FGx76vz+Iwj9sOsxXaI7Dnp
 LIgmv4BXvENVncrYKdZ3yBQxViLNN32Z0/N8TjJDXT45cxCjYbMJDV8vuP0LvBYqDuzh
 kzZuoXVZvNheBk81AGe/691Cwc3oxfjbXUCbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825305; x=1793430105;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gs8nvqUD6Ewa/yJuBN/6S2N8sXpFHlp7zBTEIi1Dfek=;
 b=YUCtky0RwYQu7z2/AWVHXMIk1i/Okrp/wXk+0xL6CXZJ/0beq1RhO2W84pVf69r8U1
 BgB5PGreWgM5kPHsUHvuLB4qyIHwEQhuZZCuO8QfZmuIq3Oa1BKNEWuE8KL4ZeHOC+e8
 qwHMheTsQYR9eR+Y1Umf1YRSFQCD1mngyxxjnT7X50vhdp/UpS4yOQBH7ewjz1boLSPI
 qmoW0+qODMZ6bkb9KOvs4EiV263/zjc0yqny3N8uUZfapixGnVkY0oteBJef/4i5PJNL
 Y2c+p/ULH5Xn6QioZ3Y+uG9IjLkAkIaU8mscMzyz+CacZdelEYECORDkjlfDKXPOl6ke
 /Ncw==
X-Gm-Message-State: AFq9FYK9u6YkSvFTqrxqNjaTFxjUhZ04asY2euZbKe02KTD+YXkf4Azr
 ZkNFpxwHoNmXgRk5VWLk33qyBaT46g8Ay4AT8lIjy+tGRxRdpnMEKUSiPXRMhvpsLF7yYPIDeYW
 qdT5N/A5qFf5eNgXVFZiNHgT2fVlP+b1vaHV6sxyn
X-Gm-Gg: AYBFou3cZP2i1KY6ot8Q3w2HHJw2DhU2V4AeuDwPNUP8rIHU3Eo7QAlhnx/jxGl4jOr
 RqUxdNZbRTAzJIOYrPQGiXSiIh9B7iSbXVIybvrMFDvZsnLHl2qH/fERe0TT0glxBHPxiCB0VQb
 rKLRUYmA39ScQO4K0zo7H6wcQDWoEOCvpeyJFc/sjq/8YMeuA13x/XKqBbKudrmdDFCj6utybWP
 +Agm4WYNptPbZuQST7p2vBJCu21achPFMymkHvdUFRJdffCPP3m3a7lH5tLnwLkfBM4wrcGU9y7
 FujV2Ca9o1XR0I8xtWjVBNQn1u+D7jf9cyYr53IcHxvt+AUXhh5M9tvfTdEriJRXRsIuWynO8yK
 jTBQzn1q11tL0NwQmc64S/xAIU9s+2VpS/c0=
X-Received: by 2002:a05:6402:c49:b0:6b1:ecee:8e77 with SMTP id
 4fb4d7f45d1cf-6b44311a994mr1696034a12.43.1792825304653; Sat, 24 Oct 2026
 00:01:44 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:01:43 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 05:16:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-8-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-8-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:01:42 -0700
X-Gm-Features: AclHuK-OlGL3kx_eOVCw6autjq9fV6LSywIrZXat3wuxRniVbZ-l9QS96-x_l7g
Message-ID: <CAFLszThzq5AqnDnu=AKfGzeTgzYY5ppCc7WND-N4bSvV0Kio3Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/23] spl: fit: Report compressed data overlapping its
 load address
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> spl: fit: Report compressed data overlapping its load address
>
> load_simple_fit() stages compressed external data at SYS_LOAD_ADDR and
> decompresses it from there to the image's load address. Plenty of boards
> keep SYS_LOAD_ADDR just above TEXT_BASE, so a compressed U-Boot proper
> there unpacks over its own input, and all the console shows is an error
> from inside the decompressor, with nothing pointing at the cause. Worse,
> a decompressor which keeps no checksum of its output may not notice at
> all, and the image's hash only covers the input.
>
> Refuse input which reaches into the output, naming the addresses. The
> output size is only known once decompressed, so check against the input's
> length up front, which catches the common case before spending time on
> it, and against the whole output afterwards. This is conservative: input
> just above the output can survive when the output grows by less than the
> gap, but no layout is set up that way on purpose. If decompression fails
> outright, hint at an overlap the checks could not rule out.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  common/spl/spl_fit.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
