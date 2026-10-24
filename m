Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFB606A320
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qoJ0q5ps;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HgTGMM6e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22382605D0;
	Sat, 24 Oct 2026 13:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQn6Ty0K9ESK; Sat, 24 Oct 2026 13:03:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 404D360735
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847034;
	b=aIZqlgv1SwYRhZnlEAMaf6u3NoMmmr3Zram8zx7xAReC6IF6BUbkHJFLg/FGQNqdJkon
	 6mSZP/d+bfwdyvGTxOPGQmlpOha2E2i6+pmQL9JfZ+zcHlqX3npfYGdcMJ+4UXn3RMDuH
	 KBFTl1qJayOzWvG8KMShIS+anTYthU8mQhI20oLZ7pNb+zsCTREVGG9m6tjBbGRTqfLZl
	 gZsEltZmBnMwPitbH09K0kAtOYtS+A5nRsDmSwHRoFMnYRLDvnmeVnKo4zMQcFG4yShnv
	 cYUACzct6Guodzf7AZFFBKgWi2sSLhqb9wiOzHu/W2cwodCIC/odJ2yqgx2S8KIqbkw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=to40btiOW687x+PKgOHfFkmHkKW4ZaxbSGNrkGEx8eE=;
	b=QHCL5C167/XUtaRDk97UvwWazgmo8bhm9zEClJIT+SrOMUmAHV64UQdCmbAyxRB8Egxk
	 C7joe0OfFZyiB8UGZ8RotW66I6zM3lhnlfqwaeEP6D5/GHoS+HicNWoP3uuJOmMgnLMRn
	 00/oONzEWFBbfzpGWxAI53wZj56d7MMwMDHFC4nCPV4+V/UawqLwZOj6GNrLSOYhDVaPy
	 jM3yxbAz3VWy1mB+RgM7sNLCT9vcW1Q4RGhyuypl1jiHkhIIBCsuVdlmjv7MD2HcXibU9
	 z9hw+Z7d942yyNluiK+WMiyEWqNOjGh192nviyfknXHtSXG6GL5l6EbTgmsJcIklFgA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HgTGMM6e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847034;
	bh=to40btiOW687x+PKgOHfFkmHkKW4ZaxbSGNrkGEx8eE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qoJ0q5pscEqnFePC6kQv8utKJoM/qNuH74guTspNR0IAOGpsRI9k3WQZ7px7CHu6J
	 NIDWXYNlq8MRukxu7f3qQQ89QI2d1kXXaHMS74aRyH21xbFBG+EJeXEzyWwRleesAo
	 fibhEhCzgv4pgphIeB1rczOBdSAp3q8/wU5kpmidIAngn+f357HoA/l6OPvwqZCDi9
	 WEVxz/9JNAEwoJJeDPDbEIwTXAZ62DmnzZUKLX/hhevyQmD4Wz68qBpG5KoQYS1UPv
	 bQXgAQMR1PuEb5MSjZg8+ql54iGT/k3EHapTS3OQ8E2iPgsTGH0BAkceoNCh0kwcoX
	 epLZwslgbvkrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 404D360735;
	Sat, 24 Oct 2026 13:03:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E67343
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 037A160A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lduAnIzAk_cF for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 199F360A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825251;
 b=e7SvOddN057DEx517lwub8g9ZfXylnD/LH6Kjk1TsiTiPA523wGwg7VNezBYeDwUnRcs
 OJBe86Zo4sWsSmv485l7bUAcMXo0p98XDiA1tt2F1nSTWZAgi1PRlwwZeCGCKlXdZTQbU
 kMe8Czu6+owM3ugwhea7x1POejqPeM5N5RsgiRXV2A8b3aRPzpt7y6/cD+WJTQkuuULcS
 660w/NE++frQf/DDrdGn5i4HGsIuYkKvsE52AtWO1g8rq1iIhYKfX9eR9cidt5fh165BY
 JL/nqVxKoaemzlfIFQ65pVa28qHfOr2vmi8aexk4qEBT/xpt8I+rcuv5dDUc2ULuDAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825251;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=to40btiOW687x+PKgOHfFkmHkKW4ZaxbSGNrkGEx8eE=;
 b=pszCpRZrr7NIdN6xQctS6jabQqxnl5ImArt7JW9TvuKTiGkFkrHJVgU/j318J+mlpCO+
 oNETpgnriOP+i6CFAod9DHZcmhUucaKv6utbVFI+vasQ8TQKSQY1MRGJW8tNhfMtUh6/Z
 lkYnzvGtWmSIS8S3eY1fx2GvSUy6Pb2vU/500HsgTPO8Y3/a6TNgGrZ0YZmMDYVzPBAvy
 xze2sXBe0b10YeyGkpuAmnbGtJjGiVvzc0D3A+3Rf/XTiAbrGO8sD0LoJWCNfZPwPyd3L
 Dk/MiTuWCwuqlkONE8HlWIuXTOEW6h02RXEWTlpDKB1RVvy79rx71Atvy/e8MORyoNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HgTGMM6e; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=HgTGMM6e
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 199F360A59
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:50 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso2134884a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825249; cv=none;
 d=google.com; s=arc-20260327;
 b=rBbA94Yacj7W0IJj02IH5NPSEazqO5ITPkrYwzOLomizWoQkRXxe3ZbDO+Uilw5w/e
 dvwMNojsZulNVjd7fKWy70IhpYzpY5wL6owXXjdz9EiEZHbT2uZNPRijaAXj5ppzoiI8
 tK2UAX1a27v7DaWa67vzmSWIVlwWoP07V0NVkPsqr/mV6SoZm7lJXLLQv84xSs2L4Sy0
 KobWfH616/LhKKssZqmp2Pjrsh/1wrpSL+7UtTe+c8et268KVBPgzKJMjTyGQKDWSyHF
 3PQz+jZt2EMeVU1RQLaQ2QiJw3QgWjZCjO06wA7aiVY77sZjQkKrW2OGq0okt9fhdkUY
 N1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=to40btiOW687x+PKgOHfFkmHkKW4ZaxbSGNrkGEx8eE=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=eHvhuW9u3og4C8OR+PpomSJQnjs0yXa1dFlbogBFO4fCX5mYinu7k1TVlrZ30eBiAj
 Gmqpflmx30V4ky7ARSwgWCXGaFhK+4Ec8dflyD0SaYJb+StNRWcNLo9ECMgLlu426nzI
 aTeMIOzqb5kwpJTMG9PAds2GOH4Dxt8FySWNEqmJtOyKsZu18AgM0HZWDBufdbdAYJiq
 QvyDHTV4iZ1ilLEu3grKrMICHF0a7T8Blu8Nmjo6U005kWsK3Lcu0uFzfHQFH9Y+BZ6z
 G9Xdri88/dbKtUoEGSeBFEuN9u6SmqaIAMTEUrTW3hW7+aTsyoq7skNc8nBE8ntxmrx6
 RFrg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825249; x=1793430049;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=to40btiOW687x+PKgOHfFkmHkKW4ZaxbSGNrkGEx8eE=;
 b=HgTGMM6epN80P9vhD1ZdDfE/P89jkbXzXVQu+5crrmW8QB1mvGPBYCVmbF27svH2dq
 kSEU+PDN6xES8EzXFqI71oJlq6MHRUMmVXF261y9SQL0br4cw7SgQa1GyKpFja0REmn5
 Jiq6ZSHoQ7QUqvYQ+uWav81CXcGtjt/V9wP6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825249; x=1793430049;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=to40btiOW687x+PKgOHfFkmHkKW4ZaxbSGNrkGEx8eE=;
 b=utAWDVU967izp12cQ0CmCIGIkHTJXxXLGRMalQnX0V6ZfjcNeUcrMlr076Qypdrsbm
 q/qvXA9NyRgnNshVqe6TTqowZYrs6XxVcR/ZKoqJFw6ZtIm/8yH7WWK2gkiqC1MnHbIN
 5NQKmoij61/Y/zeieSHeSPV+o9SILYIVcA4l1fFjr5l8zJyt68SgEbiVz5NDd4jyTpAh
 cftJmNj11hGBGmLZI7Eok0r4nzaw80QmDKrJ+xRVCL58atjpLN52frUF1iQCHjsKHwP6
 yaW1pIJ57m/wPpayO+GTZ1jMNArQj+Fa56fxGKGKUWIhinH0dvU5riO+yhu7dkbLQKzb
 Vdgg==
X-Gm-Message-State: AFq9FYL6X6r8JZsr5HwqxMlp3CoX+gvJg9D8NpjjEsxgB3QBZcg5Yp6C
 o+o8VcVt64n15zlX21rSszx4IGqP3DYwzfhweKS/CaUpMqq8hUXO4DjapnrGauiN2RZIvBjzJgf
 cQtjTfsVqXPJhxTvFpyCqsSRFiEz830hCSiVg9Nwm
X-Gm-Gg: AYBFou2Mi3pclaRmDjVsbj3DMVNqX9HWVhrR9+paoWn6UeslAzPbbISYQivP/G0qj0u
 9nwbv7AFbjTAU93jIAK/JZr68YFRVsJvC6/ebJl8Xb9vZtlW6ShpMFx91BxUmHPH2QnARr3Zuc9
 QaAMq/uENh1KplCN/nNLudckbg9NNpBuw/NxAXh6BxCx9hFJSHordiEuTTcEaSBps279vEoUeOW
 oK/MPg9v3U7pI3x3LXyMeuX0zvG1pEAPhCV9Uz1E7YmACAhWhjC/0Xp68EwlCcQ9fJ2UCgiEyr7
 +UjcGri86suArh6W9N4av+LDlFTWuI8trprMcz0soolf37bzGXBV5/EK9PGt7yXlnjyDELeO467
 gkYbvuhNqV0dNCWM0GUK7u5b87ag6M0vMuAmS
X-Received: by 2002:aa7:db45:0:b0:6b3:af2b:7b34 with SMTP id
 4fb4d7f45d1cf-6b442fc7e5emr1193802a12.11.1792825248816; Sat, 24 Oct 2026
 00:00:48 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:47 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 05:16:39 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-19-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-19-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:47 -0700
X-Gm-Features: AclHuK_VnuaI_l3gmD4HyrWvWp79y7vu7QlLPNMQMULYN7kig_R4k2kzWlRuQIQ
Message-ID: <CAFLszTgT=Dk1TSuJMyUWnygfAqPni3jwy1kZTWZbo=sxi1NpJQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/23] lib: zstd: Report a failure to allocate the
 workspace
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> lib: zstd: Report a failure to allocate the workspace
>
> zstd_decompress() needs a workspace of around 94KB from the heap, which
> is more than many SPL heaps hold, but only says so in a debug build. The
> console just shows the caller's generic decompression error, with
> nothing pointing at the heap.
>
> Make it an error message, like the other failures in this function.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  lib/zstd/zstd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
