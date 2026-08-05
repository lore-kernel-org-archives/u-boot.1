Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E3CC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 15:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C83076079F;
	Wed,  5 Aug 2026 15:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S69CHFVAmqST; Wed,  5 Aug 2026 15:31:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED154607AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785943887;
	bh=iMpt3Yn5Zn7+mofWFQl3GMf2qo9cRPphPtCAjgv4z9o=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FV2MST8jEx+doOjxhk1QWdB+9IwuhvFwPUhNPTiDtT63Xgof1nbl38WmENCF/VXs8
	 f00j0GQ+6K0i16gF/ZzQaVuiJpP6+DJaHNnOsKj0L1dQSl9H8A4Svzgo30T5XZFk3z
	 Alz9iiOfblH0KoNOvae8w+7sV8F6geRJvbQuyivIGXRvVwuBcE/1F3Y1195cWOzDyL
	 WqthqMcsj/FkxvooLBEp1vsKoXnUSWsojiKPzLfn2DpdJ7TjEytCV1VRVCdDL54KHA
	 RiLq+trDfLLSLiwF29yulBZd1xQKvq4DyLdodi/+kI1xlxsPgE9mDezfwGgIasNkwb
	 xMFzo48j2hz6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED154607AC;
	Wed,  5 Aug 2026 15:31:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 614F8144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F005400AE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tcqaav-dePZK for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 15:31:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6BBD34004C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BBD34004C
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BBD34004C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:31:24 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so12819855ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 08:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943883; x=1786548683;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMpt3Yn5Zn7+mofWFQl3GMf2qo9cRPphPtCAjgv4z9o=;
 b=BUpsyf+C1u7FXu3k20fzWg+ID3XmlM5UwlgvK7VBfwvVTwwCBTNvywhiRl5NMAFWVk
 sntslkNtJKgD8NZ8Crc/ZXoPIFdc2GucY4tpjkv4sZROtj3E5G+QcNn3hqhHtBSJFfPb
 EAUwWn020jME8LT6ZXV/DaF5wFesXllULXKQxRHAOYjoweoh2ywI4lNu9KRQItWz4Joh
 M2k8HyU3iovi9/mlZW6GU3146Sgf4WA/7RyCduKTSdkcBgY/sLSh2l0K4x23a4XfJXIt
 wUDHy248bTYJKWO26rnesZAnwTuZLEWKKDMdsgVoJ+4hivfYy/9Ys4XB8gHKB6eKq9V6
 r9uw==
X-Gm-Message-State: AOJu0YzNEBsTwVnbzQSSp5lAAeA1UiK9VffD5ziL1kiOh8wj3sMMIfJh
 nDDFjj68uobvV8GhX+qY5vvYPsLrgdS5q65f8cGV9DDUFwvnm6OIy56eESiTlI2cp58=
X-Gm-Gg: AR+sD128f1AlN06jCNGgfbY5Wte/BhqrUmhsMJZa7mN+VR3KwOLlBTJ6cdwq/ofYr2R
 hf8ygFQCqiqZYFUaRviMVjdrJmiCeHjlcsQObhZOpeiWE6YtykFmgKdKaV+HOSbH+XWD2pbmzpr
 YRch1zC2NWoLBJq1guuZvNjEDyMQcEVobHowv0TzgTz0WauhAo3nF6owb8a4vZANRAt/LacYUdW
 S5ovRdCXpb4fI79Da05teS1hyAEECHCPhMfEP1qxP4F+GZeNGAr6d7/sY9N8B6ldDw2h3K0n2mz
 huZYyCrg60MUvdP2mSAICnJ8qoA0UWlXR4zBcaAMz3VYVKdjgIT6R50+zq/W59SzAhT8fEL3Xkh
 TOaJ8dvrOgINGmfGwb2W+7HqDziVSkxOcFZLb2H7aswA+jBT0B070SeMXrbDQt2aQhJjrhOkRLF
 xd7CSV1cN7nQucL9dBHs5EmDEQv7RGRlBJ0XcMMlb3oOVfQ/4dilcnQ0/RoLf9urnHxNiJ43boL
 8tTVFU=
X-Received: by 2002:a17:903:1a2f:b0:2ca:1b97:70c5 with SMTP id
 d9443c01a7336-2d0ca7afcccmr94940085ad.4.1785943883564; 
 Wed, 05 Aug 2026 08:31:23 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa0268b3sm18428755ad.37.2026.08.05.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:31:22 -0700 (PDT)
Date: Wed, 5 Aug 2026 23:31:11 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yao Zi <me@ziyao.cc>, Andreas Schwab <schwab@suse.de>,
 Michal Simek <michal.simek@amd.com>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <anNXP80Wcl9VDHTa@lliang-1876.localdomain>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260723-add-milkv-duo256m-v2-2-2e1373dbcb8d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-add-milkv-duo256m-v2-2-2e1373dbcb8d@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785943883; x=1786548683;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iMpt3Yn5Zn7+mofWFQl3GMf2qo9cRPphPtCAjgv4z9o=;
 b=R6lkhdtHfKZFQh3yfHvB1WHKQ9GKWMnnEY+NkKFwzwdsYKiXHd3U9aV741CFzS2nXA
 6Ui1tIJTrGJ7UNgLXio6PYrgJj6vh2ZYk2wJmQEt73XsViJLmXHo8FW9aS8oJSrDr2Zl
 v6QZHqEE6PgVt+uokIeEzd8fx1OJ5mrSMrKLSqSa5yWkKwmFJFWlPR4e6KPr9cxfrzBq
 3B6MUXOAyjCELnBYHt/CU00pizMZCsshZKOOLcBZ9kFDCSRn8/nxcvtpZXK+nI6K0NDk
 rwdo2jjyfeCAsFjQ0w1eu/Aa+ST5PAq0+/ZkZMZrKPiffkeVV92JI4t9xe/hTvNEloFz
 0Ghw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=R6lkhdtH
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

On Thu, Jul 23, 2026 at 11:44:35AM -0300, Hiago De Franco wrote:
> Add U-Boot support for Milk-V Duo 256M.
> 
> This board has a different SoC compared to the Milk-V Duo 64M, it uses
> the Sophgo SG2002 instead of the Sophgo CV1800B. Both SoCs share many
> common IP blocks, so this board reuses the existing cv1800b CPU support.
> 
> The board shares the same 'board.c' with Milk-V Duo 64MB (CV1800B), so
> use the same file for now.
> 
> Link: https://milkv.io/docs/duo/getting-started/duo256m
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/Kconfig                             |  4 ++
>  arch/riscv/dts/Makefile                        |  1 +
>  arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 ++++++++++++++
>  board/sophgo/milkv_duo_256m/Kconfig            | 30 +++++++++
>  board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
>  board/sophgo/milkv_duo_256m/Makefile           |  6 ++
>  board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
>  configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
>  doc/board/sophgo/index.rst                     |  1 +
>  doc/board/sophgo/milkv_duo_256m.rst            | 84 ++++++++++++++++++++++++++
>  include/configs/milkv_duo_256m.h               | 12 ++++
>  11 files changed, 239 insertions(+)

Acked-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
