Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF2BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E126405FF;
	Mon, 27 Jul 2026 06:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QKl41zHyyUYK; Mon, 27 Jul 2026 06:04:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B904405E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785132281;
	bh=37KnOS4q+9auh0xcSeNO5g0+dK3Z8jghVvnLYwh1F/E=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cRCaNcIiN78l5ElgDNryPm+9mjFMreV159VUinsnxy6lu096uGB4l0Q/zBWF7+n47
	 LPV8PoJTzOVt4bvMrxRcR5XpJhFxQXadQMzISy2/HOn0PKS+1C5wXllogzUB09lpKz
	 DuwnRNAJ4KXeeZlUhm2M/VpS99HtwgNi+/4xOwTNrnJItH3/usJzKWbP3lcnls1+NZ
	 hN+kUBaelnfe/A/BH8zBRkfmU4KsjaNMD/IIlGHsw9AAJb5/m4KCR9P/P7WplATaGa
	 cq6JZRR8Zf5WHQTwg3QHwcfNemOzI1SJRbFAOTf+QKTdydEX2a4pc7h/zEkA2NYUYQ
	 O6Z9KtazX6oTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B904405E9;
	Mon, 27 Jul 2026 06:04:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A43A02E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 869AC605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQKXg4qz_Svg for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:04:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8D129605EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D129605EA
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D129605EA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:04:39 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso2221664b3a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785132279; x=1785737079;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=37KnOS4q+9auh0xcSeNO5g0+dK3Z8jghVvnLYwh1F/E=;
 b=SRSuQfwHfksJ1LkCHjJ4GJlFAub4hatxYZsP8xRWo6WML9ZryFyXQwpU0R/uskqhYf
 0+f0IPiwNXC9d6d/L9ck2HUnxkBuGanah3ZleEnEObWS+nl6OHzE3TChXh4M2scK9y9j
 Bemvhn/k8ZPLxC3RZeZZnakWJMp/99KEhEKhn031J07ucf2MUrJyrEocg8wy2L4k94P8
 R+3a8xlJhYb++hcdRVQXNcdF/vcNLp1wsb5z7EkcU3I45Z65jVCcKDqihnP4pLzxjqe7
 4r5wojs4a5h5GVszWYt068wfhC9BgcMFjxcL9gYbBCAfSr9o/2o9pQFhwWMZNTMbLsNS
 6Pzw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0OxiJBRYX2lG5+159dl4exNfwdtDerK2TjKqmxxgdblz6URE35ZmmdK+DDdKzmRl9wFKxTL4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxcS1DnDU0wtsYlwCzR/5APLQ85fkmuNw6gfbUJjei/ugueXilP
 vDqXaME8yJmsRfrIhxshTT/VizcEA6E632Ya/+FJG4CnfSFyKC/dvCNUXf/a0H2Wtts=
X-Gm-Gg: AR+sD12uzAI9MNtPyez/EjgiJ3gp2zZjsaWZRkHMFyzSMR8R/XiPTmF1MPSn4b+lmKj
 fjezTKgs7ErqjPt4l53qCaWXk2Yhzh1YeJO7ytmZibI1uvhopxrSmCRVrOaFQ+bjS2/ai/buMDs
 OSR1rs7LAhsizjReg68WiioN1cAH+rYO91Xr9a/41PmEV5dWl2EA22Fm5djaH4nE+PqlXCm+uHU
 b+CbTaczlUFsyMDE5oecWR2gZAUaavOGG5OPYQW+nDS9YPIqiVxq6CLeJQILMlbkdAZHMVQMnWd
 c9jDDsXYQs5BNDrpk5TAbFemm7mq+lnTq4D2gH5RYSdoOQYK1dVEp19g2khERoyxvNri74wE+jW
 CsN3adFcP+AEEQxexZCdk8zOrU7ZLwugV3gV8/ntuihaDMC2MH8XEvSUGMWXGdyEzuk0nhGhG/X
 OpHgrk38XYUC9klxV8imgI
X-Received: by 2002:a05:6a00:1f1a:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84e594439c8mr5822598b3a.19.1785132278760; 
 Sun, 26 Jul 2026 23:04:38 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53282e6fsm2479016b3a.24.2026.07.26.23.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:04:37 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:04:29 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Andreas Schwab <schwab@suse.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] board: sophgo: move ethernet driver to common
 directory
Message-ID: <amb07QJmK3H_DnEU@lliang-1876.localdomain>
References: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
 <20260710-add-milkv-duo256m-v1-1-0f761100361d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-add-milkv-duo256m-v1-1-0f761100361d@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785132279; x=1785737079;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=37KnOS4q+9auh0xcSeNO5g0+dK3Z8jghVvnLYwh1F/E=;
 b=gwBYuAAu9+wje0evQ9xdwvd46qVgod4CnR02GjeTqzo615v30Cmfv4DWUAI2pH42Fq
 3SSd5MRwHI+wORofJzaIeVvU/T5Jv8678FYkiex6L8BPz/QjvA9UniMAjK8DCP4VYsNT
 Wy0Wk8QH067PJSUnpqByBy3OTjs+dbTSX+5OIy1MffETDPpmz/Mgwwt2cFyoztbSaDow
 nF9PvVuPx8g4Ukh564uEKnds4B7wSxWl2K6RH7vPtzZlwTIl8QgtL4/F4jptr+gON41P
 I/zQQqpto7PAEKvLbcqqrYa0zaPXKzz8oDeSnOwacuGubkMBmmx64qSuSpALiTJaVFDE
 1RDA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=gwBYuAAu
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 10, 2026 at 01:33:55PM -0300, Hiago De Franco wrote:
> This will make easier for future boards to reuse the same driver (e.g.
> Milk-V Duo 256MB).
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  board/sophgo/{milkv_duo => common}/ethernet.c | 0
>  board/sophgo/{milkv_duo => common}/ethernet.h | 0
>  board/sophgo/milkv_duo/MAINTAINERS            | 1 +
>  board/sophgo/milkv_duo/Makefile               | 2 +-
>  board/sophgo/milkv_duo/board.c                | 2 +-
>  5 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
