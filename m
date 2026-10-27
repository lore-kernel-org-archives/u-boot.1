Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271B606A323
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wcdLTcfB;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CGKfaBl/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F60380DC1;
	Tue, 27 Oct 2026 14:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 59bzdj0eh70q; Tue, 27 Oct 2026 14:36:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E9A780DCB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793111803;
	b=W173Pd0cXAfQVqDUsDqvyTrfwKCgrz5wslPK4HM7Fg0EojOZ6aitFzgZeTVHfjsdUn/e
	 KjW4XAd8WjdNKaMn21z/9hTpw03l1xmSn/4hirqS9PC2w+0edbrqFk8/+H7tIrX2uS+F4
	 +s1TD3i7dvYEF1+82bLBVRYX9+fV+cwh+MhgjU8TncObMUe43UPuKa4cg1kHduk02kE6o
	 OtaiGOituSxDPnANQxbF0GZ+4e4bW4PFKkumb87pxDS7VhUsopjrIL1GLsM/gfnVWwhoN
	 YXds8QCp+T6dhGnio+hrEE4zwtRB3DTIevuUPzobFtpZcv3t0H5HMwM2AqnTv01/35w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793111803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=74o5BUKpjhDsPRs5sn4DpumQ8MLc1Jj1qkJ1mBMTQ4Y=;
	b=jOo7ZzGzQpnKO7EhZ21jEiwXEZl5PdBMczU16McjN3/5K0bbu8d5Q5oyvkGJcdw2WuNH
	 4rXKdgOjCKXWjdGIswI+L9IQzKBLJ6OKwN8irH0zu8sKmV79wXH7/Gr5gK6Ku/Cwxel7U
	 flZNfgbVv2mZFq7hdVH8oOCPrcv+MC2rMxo4Qfqr9k+/QGmzS+twngUS8i9Xy4drg7+j/
	 +IGsT7IdQRZLoGryA/MsHxaOy92GktWwk0QG4GgM17lKnfFbWuM0KV60isz/hwlh+/avD
	 jskTjv/Kkh+3Mi3PEgCZQGc63THXIx050uxvSBM4AZBLZCMoDpYDOCxoQl9y0VL0C6Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793111803;
	bh=74o5BUKpjhDsPRs5sn4DpumQ8MLc1Jj1qkJ1mBMTQ4Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wcdLTcfBc1D8hbE+WnL+uj/6Nv571O2uzXdpfYQXk9adzzgN8E8kq6M9MbtX4BYdA
	 +kuz+oEkEdcbd6Gv7P+X7ByhNhHub0Cr+DpUYXyiZx54MZ0h7x4Uuw/AsY7Y6euECs
	 6BHLYudkUQG/4oVY8QA38BEWHiYqW8vUwOWfSM3+xrSxAgeRSU+3/TCoFl+RXGpyMx
	 K+WkggyijcXPvOEffTlMEKOx1CYN+sp1AUGyf8EsmGnun8dBUhvEekdLkzNKfw4eyq
	 c68bMQAR38983tYZcJArQqWPJZiFHtmv5pfUP2R/e6WvuW1EyhO6Mmozvxa+2Brf1Y
	 AoLFUbJiV4GPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E9A780DCB;
	Tue, 27 Oct 2026 14:36:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FC023D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81546402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SzcypHj0hm4V for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A0343402B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793111799;
 b=bZbeVodG92ceAh5hCsZzn7Ce496PJ+SsoS6kP4DrXgBnwVtVpGws5qGaQndCYQ73EpTX
 6ljqFM/VvueMct0uUbmqgN3Qn4udqhOcZnanjdyP3U04q58eUImmi5yjBA8j48RT+iBoE
 dQqvn/2hgrfXCURZkfX8On0Y//stIiGkAQug6eaDrXe/GjU8HeLgZxtVfTVYac6Q6/72n
 PA06H7BW2O1T+1iQBe7g+U8MdzGGJNqv3hy9GNXFALIpizJeJa7MFvdvnstT5Ly4QgF27
 EvJ8Hbv96kUzJlp0ntduoflF/0OxJBgd22+S8USFworeFWy2ASbdV+v11YZ8VJCxgMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793111799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=74o5BUKpjhDsPRs5sn4DpumQ8MLc1Jj1qkJ1mBMTQ4Y=;
 b=AUcnUkzVbZHAbbvimrOmUbGakYzylrEzznAICgc8fdiuEPhFJodHYoEjf9YXYY4LK5Fg
 TeY99YLqkdFFZMOJjKBcXF/PQ9C+ZZjpBCmQS4gtBazKuq9sn+Q9AU9VaHQFoDzlb83Nf
 Nps12r+dgHVjS/bDjawUP1Hhvzr0wNQXRV45CYkfWZLhXieXZrQopMA/KU2/Q6OzL4NEz
 ly/buS0jcHdbe+wTRnCtBxNL5nssCyJLh+hSb9sF3IPdHvr3ehSogZvnp8DiV0ajFDKII
 dzzuoR9BjKJxKPvso9+lYAiRnLqRAjEQ/k0EsOah7OKXpPbD3ONZLyW9ln0B5fHc0wQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="CGKfaBl/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=CGKfaBl/
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0343402B4
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:38 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so6500955a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111796; cv=none;
 d=google.com; s=arc-20260327;
 b=WFyaDcUyseLfutrDcsz4SodPJX7VnJ+uCdbUAvqy+Rpgoz+k9QhYrb+c2RrKfCzoWQ
 uJuoYbLRjRKzXR8nSGgkaO3Xk5erA4klM4FGQC3TBRltaapeAefwXcXnk8RqOtV6I8Pm
 wXotQJy22XcK6RQvtokq7KzDGG5f4QSJ1BRS5VBGyU527ezY2RHaHxICluzKMU7/eEkB
 HfjNCMKKYLh4dpIiM6BcF6m+dVQMwarWlUBqHYcPzAFHlg1MIHMM+9oP9BMEQcO3iJxl
 acXhTerG6dyYhEQzMrMRTtYOESiTtcj9Vad35I+2Wkg5Vkg70Nd7p6l6ZoDDErNo+TPr
 mt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=74o5BUKpjhDsPRs5sn4DpumQ8MLc1Jj1qkJ1mBMTQ4Y=;
 fh=sGWtNaYfW6eE22vnBXRyNNEM7kHgAGNlSGyuiTh27us=;
 b=WiyPLa+rPLDAiEXaQ8lDK5PqT4ItbfHCUJoM7czDAu5VJJ7vKFySY0GpgZ0pjAMvL1
 2Ci+bTjWlVRhphvaQjKWsDGOlEnSLt7I5HjUyJqbSk56HhgBnJJY/2yWL/ccRdC/obme
 w+h7hGR5z443J46jRzUalv6c0TeuDzpAH4bynfJCtP831Z8WOPxkvsfTfGo/JOEoTVEt
 ZlmK2Luon/9aWrReD2xp/T798skcbJVi1cP3y5LpX4wuTD23DqJGnYbIfhVQfjEeiSTU
 qQbURIsuBSGqB5aV/VRoosnWIw0qN570FeGY6n1bDoUd4Pqi+4H24NfqCG7bB89fDhC2
 a3Iw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793111796; x=1793716596;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=74o5BUKpjhDsPRs5sn4DpumQ8MLc1Jj1qkJ1mBMTQ4Y=;
 b=CGKfaBl/O2no550WHAIoOoAHUgk/lY1+xlm1rLCjwkDsuvurCe1ixVhPxGpT06jBJz
 Gq1dyof7hOI6ALZmDUK1Dm4oZRtAA63u8oaRmzFVbTXqeKjc6h/r9yfa5waqg1XyE8hB
 wNa6md6XxSSJXEjyp6PJEIP46gtA+4HEbLWyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111796; x=1793716596;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=74o5BUKpjhDsPRs5sn4DpumQ8MLc1Jj1qkJ1mBMTQ4Y=;
 b=dgoqdAxMaxSrlkC6nWO7CUGCiz2tw1CspxJ6pMvOqHvq+XnQvtgpwn2f25BtyKaASo
 UH24LU1TUfz6AWGIJt9VCkLBRUjP9021tSu+NoNR70PReDdCf66dK7WOG9Safnfp2d+b
 eHKwHCUj7zB1K0bAaRq/vN2Izq72ZDoF8nbkiFI1/PX/Lwt9GPiHOdyaADvvgTb+4YnW
 cLSNfbqTB8cnyG7iwnm90oAyfdDlnI/7t69xO18izgKSzOhyICJx5hTls0iQ3hvbSm5W
 sUaNHeeTwOOwYyv3wlIeiKEfxjEDTqONgi7qAPUYI+Z84lEWyp7n6AAX6l5XN9c/qw0f
 oP+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcSvtfIqfST3lA7hXKCyKZVPNMEOuzsgpkWpK9RCCPFb7g7LHMLQ0wDcDYHTHGL+eDSgTJ200=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJq2p2EBUO3sG1iCvwy2cY9A1UP1RkzUKPCZ7M2v41rjy7LZNtW
 dAZH+vBYD7NTb2I1ya2Y6xQUypvOIYqEAJgE1oGfvEdm1fzMh9D/nvm5qD4i65KtvjM/9JtukBI
 mA22gQu9zxxtM7+4HcD9cA/t/FSxBCAfCH7y6/hxK
X-Gm-Gg: AYBFou22SQIcBqE9dV9cugRMLlQUcJap2O9khwjV4CVUvu6d19APcbCnVxCUy23S2UG
 s02j8+ALCMkYVNDq765Mm6HIDca/kIfUsrHHDB5wj1sDjR2X2b1aWexqkHTnW2vXD7rxwsTJjjg
 H2aBtwmI35G9dljAcXDBSgdL0VMBNdbvmH9r6AwDA81hlHoPezL5PZONAVHanossZRrPBiIZOfx
 ZQzwaV3r5GzrKkysK3HyJAuOwOxDpTGEsX2L2P8fqDoI1NAoKHNsZIV7AST2+V6VsG5VKH0tqws
 mDMaNjFhjx0bBXm+tU9+mc0K5+wU6ceW8ST+dgjd054DU/r3H9DDqyhzyDp3QQiy+xyH/glHOSL
 xtFAz/rBQGEypCqNFS9euwQxOTy2b9Um2iuk=
X-Received: by 2002:a05:6402:4593:b0:6b3:f692:985c with SMTP id
 4fb4d7f45d1cf-6b443008fdemr7103878a12.44.1793111796463; Tue, 27 Oct 2026
 07:36:36 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 09:36:34 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 07:05:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027123905.839-9-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
 <20261027123905.839-9-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 09:36:34 -0500
X-Gm-Features: AclHuK9Pe7yU6vIduyP9NIOIZN-YGNhkSWS1qog9tYDCxx1zszExP7OIbOlZmX4
Message-ID: <CAFLszTh6ZSOEzfTPgbKqLzvhKC8uktvOTs4LkHG1OawVuxo4xQ@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] test: dm: Add test for FW Loader feature
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-27T12:38:55, Christian Marangi <ansuelsmth@gmail.com> wrote:
> test: dm: Add test for FW Loader feature
>
> Add basic test for FW Loader feature for the Filesystem way and FIP.
>
> Additional MMC testing image are added that loads a dummy firmware.bin in
> a fat partition or a simple FIP blob.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  arch/sandbox/dts/test.dts          |  38 ++++++
>  configs/sandbox64_defconfig        |   2 +
>  configs/sandbox_defconfig          |   2 +
>  configs/sandbox_flattree_defconfig |   2 +
>  configs/sandbox_noinst_defconfig   |   2 +
>  configs/sandbox_spl_defconfig      |   4 +
>  configs/sandbox_vpl_defconfig      |   4 +
>  test/dm/Makefile                   |   1 +
>  test/dm/fw_loader.c                | 254 +++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py           |  58 +++++++++
>  10 files changed, 367 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
