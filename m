Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD32CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 19:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9305083C2B;
	Mon, 11 May 2026 21:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mm5/RqtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91D283C5E; Mon, 11 May 2026 21:19:13 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D8E8394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 21:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso10255061a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527151; cv=none;
 d=google.com; s=arc-20240605;
 b=cgCL7p0LbwuotGCsp/Zi+nnan1IeWgREoKbxNg7NHMlDhtQpgxdhc2dPyBTYQhkPbs
 Op/wpYOw7g0wRIZedGcX7EswFGES1JeRAPzOfS29kw7e9Cjli77IgvEuvpdblNhDrP+P
 SSVbvs8NdXSWeBc+E3ReoYltQ9w0z+5kQE9iqopiFXzr4Vk5cH/ZwX1jtk19pCYVv3VQ
 AKaZHEU7grpG+AO+WMxIJq7GhcoHjiRl0a2sisAoD4uE5t8UxtVJxVkPrOaS7UVSwtsh
 M7o7c83N5UHROlNeM5BfSnxwIcs2jKDGYQD0zECxMNOyJdt7Gh8mSEeE1lecVqEQEFNE
 FdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OgytUZhoyzk1fquULv1HrniPwCIBwmXbCUuu5Xh+Mmw=;
 fh=vmm9EcMVCrSY1Ivu0S2OwTyC3DBJWu1y4WGqfQeMuv8=;
 b=iIZM2zRTJ+cacZnU9XoxWlAwlWCUx1Dg2rUOn2ot/sb2ArvUKAhTy1GrU0lriO8f7C
 sj4GvfMXOV7pF+1gPKHvxadp95+75sdUg9YVIWWTgMfxQrLKLTTOiq9m+jdxCkMOX2rJ
 TVT/gcmvWhk0/skFFiMwXc7iYV98spgU7Xn7vTAOq9sXGSHUF15mmxvPRFfbEo+SD7U6
 v3lxgQZKj3YRR19KDpNBfQkQscnUPWYhz2Pr/K6MmCtdJwdwa5Drs9Jan33bRgPWYSel
 jkNCgmmqdb95hI2vnOc6rfdDXXPBVKwQxZZ2zIsdP51hrhraAKIwoqz0uTxCFm5t8mDV
 JbEw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778527151; x=1779131951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OgytUZhoyzk1fquULv1HrniPwCIBwmXbCUuu5Xh+Mmw=;
 b=mm5/RqtSiOlz5lmTAVZqeqc55o+LHgax3xL+oTD3txc/9pRqdgNrZo3Cz6BJ/iLmmN
 0IQ2Kce4YcHfzzoDkcWYXfCDbx5m1cbcIdP/nzsgkUezHkRy75DxRzAWi44tC6aK3D2X
 hcEij8zJq78+Cpiq5LnecyeJcECwLcbVqpHCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778527151; x=1779131951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgytUZhoyzk1fquULv1HrniPwCIBwmXbCUuu5Xh+Mmw=;
 b=KZOWkihRrFS3+MDjW7VByfGkVtCu33spD7A30cz2IGH/vphXrgNjH5aIFN46SoWSGD
 xNeL0bKdXmUx+7dWAVddd+jb9IBpID8TsNrmi0YPm6mp6VcX39GNdQu0dWXPiKJgxzxX
 tu0LQ7ylupa24s7a15TCLi0PIu/yShlTV5bzXgREKppu7k8gpW+8K8KMShJC/YrSIQKL
 3JQn2uEA3lbnnGRpanVzmzTxYZIVRvrjSjfkQB8QLDPs+hcTGbL4jTHeSDy8ohFZJ7EI
 zwQmAlZDaSJuLtjkWKAgko+iiskQpzHa5yMKbN9XTCcXQAxbFhR7MhOkh8TFP9ziVfkp
 tmRQ==
X-Gm-Message-State: AOJu0Yx47PcsdJvbp2GwrseMJpSUihsFjyXM7YVZ7kK7xfvsIiSLrf1m
 ANoTBEGewXlA7hChrmpH6u3/hPAVf8INa3WJfSZu9UN7wcflDwOEvCHn29SvKLHo/6t5qiEBoSq
 xHiZT/l5bH8LxccnADbHykn+sUotzDI5bDqWiThHJ
X-Gm-Gg: Acq92OEjzjn6XdmieKZ5hOai4rTDNHMg77SFForoFg5MubLqTg6r1OFlTvlZPne+GDU
 dO23cLcdpanKt8Y4PO6buJX6+VUMJOvoUOWyEV5IeUXwidwSCcg/RC11fDeLarZmGB6pBHbNYqx
 77/h1Pp9NXeGnKwPvTVsugGyz99afX72+Dn7i8TQp7ulyiRbt8sPeiqFJLi9U0Qav7XCZooqkTw
 bYjmCuwk4jP4JTIxeVNs6BEdIGnke883dKexFOr/ghrARzBddl3K51Z5MGqt449ci1XH9RS2inU
 gc13LQ==
X-Received: by 2002:a17:907:5ca:b0:bc1:1808:7fe1 with SMTP id
 a640c23a62f3a-bd23be009ebmr54247066b.21.1778527150979; Mon, 11 May 2026
 12:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260511182036.50453-1-james.hilliard1@gmail.com>
 <20260511182036.50453-2-james.hilliard1@gmail.com>
In-Reply-To: <20260511182036.50453-2-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 13:18:58 -0600
X-Gm-Features: AVHnY4KUAyrrO8BoV_KmPcYVYUVGZq-G3J6GL72JrqMlIIQl3G4yqw1VTuYB0O4
Message-ID: <CAFLszTj_P22h3aaOksaXmY1uEOob3_79A-50=MA4PtOBV9UWBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] doc: remove configuration settings from README
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@denx.de>, 
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-11T18:20:25, James Hilliard <james.hilliard1@gmail.com> wrote:
> doc: remove configuration settings from README
>
> The remaining configuration settings section is legacy README content.
> Its details belong in Kconfig help or the rST documentation.
>
> Remove the section instead of keeping partial stale configuration
> documentation in README.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> README | 124 -----------------------------------------------------------------
>  1 file changed, 124 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
