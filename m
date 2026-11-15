Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB1606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mxoyF6lo;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of9SrrWT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E34360698;
	Sun, 15 Nov 2026 10:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vzUYjBnleyt; Sun, 15 Nov 2026 10:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6597B60611
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794738875;
	b=ZwBfVj7hqCiybwBt4w3RUYFmN6ovRR1IUcTpH+qSKkIJud+M6RPntqvd2GGqCUjVqcP/
	 NEvAvN9l0o3jXUrJMs1zj6zOVR4YYDdCs8GSwHrj5piMYu80bjG23EMHWR9e8rlk9tJq6
	 UdlLMxfhVcbxP3xF7NxlCsVcsX4bGtC5cPFkBG44EqViyJjbDO32BakR8uxt0et3BbyFH
	 mlGELKCkqwIImboBaxA7z2+JLvndsMXulP+KhdqxD6EfasvMxgbTfzlUmZ82nXX+rljlf
	 WCdEPMsedlParfUSHF6anTlBXYrHLnluLbzQa93w3h7HNkFzG8flKPwB+pgPIJ2VXeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794738875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uKaYwml6R0U9qb4gnyp4cKQOXqtdATsuWDIsuKrQseE=;
	b=L2tA/DhtP0YRmZaRl0RDJipD8LEcKCti1+6WRYSN+kt0aseD/IB/w492lX5IMT/dCx9F
	 r8kX+4bb3YHld5G3UVTnLIjYt42ckuOB33yK/Z4rhgOT3DIKEMGjTysaxclOl+KnFlfua
	 7VMCUaol5SV8O4HePYY9zdQLdtNliN3GiG1cbYfOhcwx/BlHOEuwwPBdJhSMM3v9n9ECk
	 yVoD+KgzfyFRSgIhgeC5SwaXFNz6LHrozT860hbbH4p4jOMYkPzSxZTbAgIMA3M9tLz6I
	 Zs+1mSC4Xp/olzOsNc/HUgsMxxYrHtphoCOdU8zQMLh0OUA2l1rvhFgSLss6z53tCtQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of9SrrWT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794738875;
	bh=uKaYwml6R0U9qb4gnyp4cKQOXqtdATsuWDIsuKrQseE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mxoyF6loJ0wvGDSy9XTLZMOYKwq4PbulW96s/QlVKnIId5OjCubq2a0JbqF2LCcPt
	 OvulY5R4zYtjuYqLStl0faCRWNiw57gJHt3Sbom2S+8NxrC2DSDAlxfDEEMkXa5oI2
	 oqrO/MlqqhszrkI6ci3nAeEdeyYHuJY4EkYvCbTrAQRaowF8i936vIvDXztRzRga66
	 kUyqNU6lw++1cHvMAEpZ2YY2KBcKLcLAA2z4hSeiJ6raqIDn5iDGPoUWjMHlGFeOF1
	 LKwPV+NVAcDzf2BToobV/K/aWOrwSpYfHGNDviGfgPQy6Cko9BnWld+jNvoPqOBbfT
	 5BeYydub2sKrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6597B60611;
	Sun, 15 Nov 2026 10:34:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45F2870B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37CC860611
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sknN2f-a-OUk for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2971960604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=of9SrrWT
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2971960604
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:34:32 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c5075fa7ed0so439866166b.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794738871; x=1795343671;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uKaYwml6R0U9qb4gnyp4cKQOXqtdATsuWDIsuKrQseE=;
 b=of9SrrWT0D6+BceOCXVtVHDFHAqHaOSXyHGjXiW/6CKF1OYRELhq+xMW2McwYKlaXC
 Eji+hw8TPmJKKA5dXSW2JLrZYX+EKD8kAQzYO9xOPgDMNiCQCvTZ2/6Moe6qHZ3Ya8KC
 TIkHOGxTCl5WfHBIbnSdksxjzHhH0OnkCYwsXeBuDiFN4v+As6X/r7UvhbL85JsGoQJ0
 f+AAzoR2EqH9wOg84YWiEu0q5vkqKExO47kDOzwlknmrF2kRVj5+O+cWTUc0UtPZFBCa
 dX5LuejgfveSNyX8TzDblgyAbCLMtPxWH+Ei51P4vPtY6s+60Lwi6MmjFjcHKtRhsRh5
 gWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794738871; x=1795343671;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uKaYwml6R0U9qb4gnyp4cKQOXqtdATsuWDIsuKrQseE=;
 b=lodMZt2ed4x/tUKbuABz3buUTA7YnoOQKeBMSkTUcbYrAwMQ3y7BnmRquH37IEzRSC
 2zKbgLToph+mw8S9AdI75r6H9ABMB7KsbskUBBXpvB4K1Hx98YJXJ2dpFysuiT3i8y/C
 oWw0GQso5gtMPy3kQUwMIoJ6nQIH22JaMc8qIokaTnhWt0Ng3aRxYiu8666X2Mg4r/X8
 StHHFBa3kTKURkGlgFEKG8GD9yv7a96WFwJbUPQelOUl1+n5iXcOoTHlBY5CsvSdSvd9
 O+QsNPL49SlvpXynnT6BXpVHvF5jI44ZauYyiayBV9OyLh1tBN87/wwYCMJRjj96+Tge
 fzmA==
X-Gm-Message-State: APuU4Z8yPyY7LlHCWSqqFSOdAlM0M0Uo4Xh186CS+dsb1hDUjHPzPbcs
 a2gsl5OsN4H1sMriknlnkk40fmnVZbT/nZ2eFytsei0q7blKU1Wf9edpg9MqhsqPSYSbNEw9WEp
 PhWWPyVSHrzF/6tHQN0wOPRz7OevCeJY=
X-Gm-Gg: AYBFou3IbdwWaV05gWJC6ms6lN/S0LejcarhDT4/zrbr8ht8JdZtkUxGHPS6Inzu/Ex
 RSpwEJzo/rHgWmAihYuZgcyesZRp1RKccy58pJ1V0x1mwxU58K8qVpMt5Jpb7CzAxvlgSa3Y5n3
 HWKx09WNTCDzZGShPVmW97D7FYi8jXex4WKoQm/8CbnKoKK75yuknSyc0JtdecbvJ/vgQt1SwNN
 8nd0iZB1QsXhymNv6IrykV/bwwUgI+loG8PXMVlsq8fJJndBGiZItLZKS+VPs9HudSuWs0BYEEB
 RvNRezSOineVurjJSfLC1mmUptA1tYgDQEEKkUBEA4doqCpiT81UY9qdciyAgAEVFAXF5W0ctY1
 dpz2UH7NE45vxQzybOZLwMUMfw57fUeYGrzFOmw==
X-Received: by 2002:a17:907:3f9f:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c509631c9c0mr668056866b.25.1794738870529; Sun, 15 Nov 2026
 02:34:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-4-b82ff9c860ba@gmail.com>
 <29c060b0-17c1-43a8-90f0-f517ac874268@0leil.net>
In-Reply-To: <29c060b0-17c1-43a8-90f0-f517ac874268@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 15 Nov 2026 11:34:19 +0100
X-Gm-Features: AclHuK-hFX6yeEOoGhlEDr8T0pnd0pFZHfy0lHlcFovDcoFyBxPjH7IGvDhvCNo
Message-ID: <CAC928HY5SW0akmHG-tJ-wA6F0a_2ZokChr5K7N+HqBLvch3pTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ram: rockchip: add config option for tinier debug
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mer 11 nov 2026 alle ore 17:23 Quentin Schulz ha scritto:
> Hi Massimo,
>
> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> > Selecting the RAM_ROCKCHIP_DEBUG_TINY new configuration option, the
> > debugging code prints only the SDRAM type, frequency and size, limiting
> > the required space. In this way, the debugging code can coexist with
> > support for multiple SDRAM types without exceeding the output size
> > limit, such as in the case of the PX30 SoC TPL.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/Kconfig        | 11 ++++++++
> >   drivers/ram/rockchip/sdram_common.c | 54 ++++++++++++++++++-------------------
> >   drivers/ram/rockchip/sdram_px30.c   |  4 ++-
> >   3 files changed, 41 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> > index f51ae6a4542..98770659cd2 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -24,6 +24,17 @@ config RAM_ROCKCHIP_DEBUG
> >         This is an option for developers to understand the ram drivers
> >         initialization, configurations and etc.
> >
> > +config RAM_ROCKCHIP_DEBUG_TINY
> > +     bool "Rockchip ram drivers tiny debugging"
> > +     depends on RAM_ROCKCHIP_DEBUG
>
> question: do we really need a new symbol for that?
>
> Maybe we can simply have a constant (e.g. DEBUG) defined at the top of
> the file and check on that. I am trying to think if anyone would want to
> have this configurable in a defconfig? If it's only useful for quick
> debugging, I don't think it makes sense to have a symbol for it.

Quite true, indeed. But RAM_ROCKCHIP_DEBUG defaults to 'y', and 143 of the
152 configurations that have RAM_ROCKCHIP defined also have RAM_ROCKCHIP_DEBUG
defined. Therefore I have thought about a Kconfig option, but we can consider
a different solution: will do in a next series.

>
> > +     help
> > +       Limit ram driver debugging info to sdram type, frequency and size.
> > +
> > +       Help to keep basic debugging information while minimizing consequences
> > +       to ram driver footprint. This can be useful when configuring the ram
> > +       driver to support multiple sdram types in a very constrained context,
> > +       such as TPL for PX30 SoC.
> > +
> >   config RAM_ROCKCHIP_DDR3
> >       bool "DDR3 support for Rockchip SoCs"
> >       depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> > diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
> > index b46de5d9044..519bbdb4e60 100644
> > --- a/drivers/ram/rockchip/sdram_common.c
> > +++ b/drivers/ram/rockchip/sdram_common.c
> > @@ -44,36 +44,36 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
> >       printdec(base->ddr_freq);
> >       printascii("MHz\n");
> >
> > -     printascii("BW=");
> > -     printdec(8 << cap_info->bw);
> > -     printascii(" Col=");
> > -     printdec(cap_info->col);
> > -     printascii(" Bk=");
> > -     printdec(0x1 << cap_info->bk);
> > -     if (base->dramtype == DDR4) {
> > -             printascii(" BG=");
> > -             printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
> > -     }
> > -     printascii(" CS0 Row=");
> > -     printdec(cap_info->cs0_row);
> > -     if (cap_info->cs0_high16bit_row !=
> > -             cap_info->cs0_row) {
> > -             printascii("/");
> > -             printdec(cap_info->cs0_high16bit_row);
> > -     }
> > -     if (cap_info->rank > 1) {
> > -             printascii(" CS1 Row=");
> > -             printdec(cap_info->cs1_row);
> > -             if (cap_info->cs1_high16bit_row !=
> > -                     cap_info->cs1_row) {
> > +     if (!IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG_TINY)) {
> > +             printascii("BW=");
> > +             printdec(8 << cap_info->bw);
> > +             printascii(" Col=");
> > +             printdec(cap_info->col);
> > +             printascii(" Bk=");
> > +             printdec(0x1 << cap_info->bk);
> > +             if (base->dramtype == DDR4) {
> > +                     printascii(" BG=");
> > +                     printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
> > +             }
> > +             printascii(" CS0 Row=");
> > +             printdec(cap_info->cs0_row);
> > +             if (cap_info->cs0_high16bit_row != cap_info->cs0_row) {
> >                       printascii("/");
> > -                     printdec(cap_info->cs1_high16bit_row);
> > +                     printdec(cap_info->cs0_high16bit_row);
> > +             }
> > +             if (cap_info->rank > 1) {
> > +                     printascii(" CS1 Row=");
> > +                     printdec(cap_info->cs1_row);
> > +                     if (cap_info->cs1_high16bit_row != cap_info->cs1_row) {
> > +                             printascii("/");
> > +                             printdec(cap_info->cs1_high16bit_row);
> > +                     }
> >               }
> > +             printascii(" CS=");
> > +             printdec(cap_info->rank);
> > +             printascii(" Die BW=");
> > +             printdec(8 << cap_info->dbw);
> >       }
> > -     printascii(" CS=");
> > -     printdec(cap_info->rank);
> > -     printascii(" Die BW=");
> > -     printdec(8 << cap_info->dbw);
> >
> >       printascii(" Size=");
> >       printdec(cap >> 20);
> > diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> > index 7f51b9c4f8f..2b25a0124ed 100644
> > --- a/drivers/ram/rockchip/sdram_px30.c
> > +++ b/drivers/ram/rockchip/sdram_px30.c
> > @@ -715,7 +715,9 @@ int sdram_init(void)
> >
> >       sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
> >
> > -     printascii("out\n");
> > +     if (!IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG_TINY))
> > +             printascii("out\n");
> > +
>
> suggestion: just get rid of it
>
> In a separate patch. Considering sdram_print_ddr_info() always print
> something, there's no need to say when we've exited that function I think?

I will be really happy to get rid of it! See my comments about this in the
reply related to patch [2/4].

Regards,
Massimo

>
> Cheers,
> Quentin
