Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DEEC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48E52404EE;
	Wed, 22 Jul 2026 08:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5SJO1LWu8GXU; Wed, 22 Jul 2026 08:21:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5921D404F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708476;
	bh=ODgsihVb695BoM/Dc+CHRSZkQWKx4a7nLVjGzZZhNbw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GDJKR11C+JsN/8672cWBliTD5aC87cqH8zjYKeSyYXriCtyfcLC3I52pshsOm7VeD
	 szqFYNvmeEkU3/M//GZOxTxE7TOBNJ6XDCm7PWvPFQfIG8snqDzJ0+lWQ+C7XxQx1p
	 yGNkguffLeyhpHVRaL7n1tQU0ayCal+lOAHijWCLWP4ZqCjnKcQ6FemrZuZpoc7eVB
	 B5t4YzA/svQqUv1Dh7K2/x14rLNT9/V3Dlwe1XuoFinkdwwkmRauJc8ZuG2hrxkYNy
	 lAn0BzYWm+gvhfOWJt4Dhry6OObhAED07LdhJAixradtty7LRMdmoTK6GN8dbDC3+Q
	 tuY7mTXA0kp4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5921D404F2;
	Wed, 22 Jul 2026 08:21:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6772C109C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CD54607AA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZYgBMDzYjNA for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 08:21:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C69916078E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C69916078E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C69916078E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:21:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D368493F; Wed, 22 Jul 2026 10:21:07 +0200 (CEST)
Received: from mail-wr2-x02.google.com (mail-wr2-x02.google.com
 [IPv6:2a00:1450:4864:30::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFBE803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:21:05 +0200 (CEST)
Received: by mail-wr2-x02.google.com with SMTP id
 ffacd0b85a97d-47825ef4012so3717744f8f.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784708465; x=1785313265;
 h=in-reply-to:references:from:to:subject:message-id:date:content-type
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ODgsihVb695BoM/Dc+CHRSZkQWKx4a7nLVjGzZZhNbw=;
 b=oIdVjPTo1hjSRuIbgLcGmJ1VGOPe5giZ+RqnsqwsDpmrlhbEmKKg9QEK068lc9uzML
 bmBJAyvFHWO2bw2MeL3s7orrCqLwkT+yL8yQbBJVVN9fmfi5uHqEB9RguaN5ACkFCpDc
 Lp1EygeKDqw0YYbSkpcMjO2zi7+IMibv1wv/eoxGeUDnk+UVxyz9S2BFnDPbRzVmqnvp
 SWpzer7NAcpdAP/aO0LyAXQDVtsFPPF/50I493FsNtyOldizSovtklQbXTO4i+ahpw4q
 T2VV5oSjCC+hsmMYsNupkWXIGNpc2gsRKN+IAMmxnTGdrFV76X0HnTK2os38M1leYGCQ
 R5Cw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7ZcQswH0M7Ugn+8s2M8mQN37ouq1lVBAL4DsvRij6qRjvsRK0jwBUtUV5sCEwftvcXBZjwSY=@lists.denx.de
X-Gm-Message-State: AOJu0YzO0D1Q6y5BZlb9f1+KLASrYlJaRR1HXYjOo1oi5JIwoVJIg0fF
 1z+jgTqyYUg6Z0OtUf6JoxpdR9tRKP5vCAssp+KduklLBvl5n6JuheGFiBKkirlj1OZFz4vUt7q
 gVL1ZX5Xt2jj/Avo=
X-Gm-Gg: AR+sD12zKZ6Zz2Y3YDoxpe7IdO7Bd13xtTMG4Qhh2fXHBMtd4OT7wUA9MDxSjyMxYBA
 0FOFn6lBI6DZ5K0VANsqF2sav5hK2OzpM3sOPR5IKMcB92Eh8NajBCzuZUNSB7psmhtxeeJL9+G
 6rn438Sq6y/UzPDMzNgjNwjXSHc9RfXTGI5mAExBLU6oy4NtRmzvqAS8omIdwjuvlmmUBXk9uNH
 Sj0hYsh5YxdJQ/oHs/IMVM4D6YvQnpgrOmuaYOCf6AJCGsp2OI+ddrjnf/QiXSUfoEQx+bnsC1t
 Gf49uVNqUII5/ZPTys9APQxrGl02CoL9mJe9PWrdT3jkC/MxA5KjPVKP7l4mCO8o14ZZPZjzXpl
 MlwtRg/B4a4OPCDkRv8IUMtuIiv/DMQAlCurzDE/Bj431svX/5BSE3WXsbYwJHsaIJSodgQcj+f
 V1FXZcDhObsOa+m9AH9wPfPCya+paksFsGVcEsPx/EzGJ6D4JZHrlERr8a
X-Received: by 2002:a05:600c:19cc:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-4954a402fcdmr278536895e9.21.1784708464692; 
 Wed, 22 Jul 2026 01:21:04 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bc62basm3756954f8f.13.2026.07.22.01.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 01:21:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 10:21:02 +0200
Message-Id: <DK4YCL8ZC0DS.2FCC2V5ZDBKO1@baylibre.com>
Subject: Re: [PATCH v2] fit: prefer the default configuration on best-match
 ties
To: "Carlo Caione" <ccaione@baylibre.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>,
 <dlechner@baylibre.com>, <jstephan@baylibre.com>,
 <GSS_MTK_Uboot_upstream@mediatek.com>
X-Mailer: aerc 0.21.0
References: <20260709104940.75514-1-ccaione@baylibre.com>
In-Reply-To: <20260709104940.75514-1-ccaione@baylibre.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784708465; x=1785313265; darn=lists.denx.de;
 h=in-reply-to:references:from:to:subject:message-id:date:content-type
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ODgsihVb695BoM/Dc+CHRSZkQWKx4a7nLVjGzZZhNbw=;
 b=CO6suQeMU9htdSw33ys0dKurzOp41gxv1DeykV16pGwbJ3Mvv8F7RgrawVQjaQN5uS
 mg3jI7HgaTuCgf7hPrLLh97ZbtYhl50jNOyHxec6uyGceSsTDC/nkzl8iQyhvXwPWKsx
 M2CTnpvH1JAI2b5wC4G+XP4GX1tYg4ImaVCwTc+WDbuAdxHtmlazbdSKeyHqjjMjz6HM
 DXTJCJh/plj1QigQ+thOzNVD0up11eRydcMOwxomXFceD9Pa2OqiaDfJs38yhKSLMptd
 swCPmvrVB7Kf8oFTdsFiJda8Wf2AUysWlJhXY7IZ2zfnuy2MXjl/5axXfBC/8dV4lWxh
 XZCg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CO6suQeM
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="CO6suQeM"; 
 dkim-atps=neutral
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu Jul 9, 2026 at 12:48 PM CEST, Carlo Caione wrote:
> With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
> configuration matching the most specific U-Boot compatible string; on
> equal matches the first listed configuration wins and the configurations
> node 'default' property is never consulted.
>
> A FIT whose configurations all share the same base devicetree compatible
> (e.g. one manifest carrying a base tree plus overlay combinations for a
> single board) therefore always boots the first configuration, silently
> ignoring the default chosen by the manifest author.
>
> Break score ties in favour of the default configuration. A strictly
> better compatible match still wins over it, and FITs without a default
> keep the current first-listed behaviour.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  boot/Kconfig                       |  2 +
>  boot/image-fit.c                   | 20 ++++++++-
>  doc/usage/fit/overlay-fdt-boot.rst |  6 +++
>  include/image.h                    |  4 ++
>  test/boot/image.c                  | 68 ++++++++++++++++++++++++++++++
>  5 files changed, 98 insertions(+), 2 deletions(-)

FWIW this is the link to the PR changing the spec [0]

[0] https://github.com/open-source-firmware/flat-image-tree/pull/59

Cheers,

--
Carlo Caione
