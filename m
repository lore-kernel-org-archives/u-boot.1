Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C7606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZtCfVkJ9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGFba9SW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5C8D40CE8;
	Thu, 19 Nov 2026 18:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3eEFCrm39W8; Thu, 19 Nov 2026 18:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BCF9240B81
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795112876;
	b=p6aLxIZwmUTnXXVeI43g80wycrEloeM0gFO6WQxfT4RUEP/MOLT5oGo3NK6mi03ZkiAg
	 6XES9IYzyAgxJAQWKC67abE/rrtOmvlUMEIz+TKOElBQXzjvuX2ZosKqynEWbEaEkGX7k
	 umDZIteIffAFaE1ZzN9dTjDanwg2PxhEjfdavo+FH1XB8KV7XUgppkIbXo8zLn9jzqM6S
	 OCZLvhmkSPonUFcZyLTCh4oX16aelwN0WrtrruG117oJft7xqI9E7TK3n07FNAwK8Rihz
	 4Z464mQRvRGnEOfpOEZWo5fib18jsw8JQxIDzzlr8hjk8YcHgWD6qHC0glNARGJXV6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795112876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TW4bc5CkuOZa+KUNztT6aTIKt/azwxDPgwVwxb64ZYw=;
	b=gnzjMpD3Xpy1FBUD9alZAdosJaLip3YCA6EYaSUzUw+kYcr9Tpd+e0JtiEEXkXtZu+dV
	 x9mk/RPGuXcsGc37MvEAf9DvcedcMBvnI2YkrvdYeoiYzpX2aLEI29lo2YS9rAMB6Jsuo
	 zAOrDURPO3ggXcOPpFQmQwhXWPq/SbGBuvwATmTA9lFeMTtwbnFb9gUn06OM2CetqD1rR
	 ho/wGOfenigy6bw0xphJAi6WgIZ5lK/OIfqSIfYgV242aBJcbSa53BFQHTSLplkczTC8m
	 7GnBIARZUFpc5sfp5s+HP3ixaDLkBnBvVfDNpgT0g1B8wvN/ngNYS3Pcs0GlCHA5iWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGFba9SW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795112876;
	bh=TW4bc5CkuOZa+KUNztT6aTIKt/azwxDPgwVwxb64ZYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtCfVkJ90KwzNgaxvS6u/8NGPLYzekkZ8ihEzhMnGvUILUGL/C35FOiDxoO5haElv
	 fx3FhBl6nws9kS0N3ltV4feMQrROMXhDj/lyBnZqKwDNfLD4VFI9NUyD1FxaLmnlil
	 QP1fLbvUp6gJK2pfDMM5Y5DJMbniRFyiF5XQOiT97HlWDQvNMUIUuumbycQzQ3DgOG
	 UUIVj9Mre9lmXcXOxEkN/l9rtHHxoyThOlcXQli+BXJcDWFbbaxGW3qSvMIWx0Y4uy
	 1pBB2frv4B5SK2E53gH7BtI8wFZPTGhhh1ymn1qlUIhZehCG9M4WdHeMq7YMgpRFR4
	 55FbRpD2wYiGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCF9240B81;
	Thu, 19 Nov 2026 18:27:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AEA33465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0AFD40C78
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lJWZfxpgYnb for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F43940B39
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FGFba9SW
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F43940B39
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:27:53 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c511c0e2826so13148866b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795112872; x=1795717672;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TW4bc5CkuOZa+KUNztT6aTIKt/azwxDPgwVwxb64ZYw=;
 b=FGFba9SWxEjAv6dMts0ic8l1ZPQRiWxjXoXKtCK9jbYZ2SROxMBWxzZF5K2M+ztEbW
 oDAHxamgNIrN2oeYUa3rAYtxTkKGi2tPYQhxr2fZwNUchQ7gVNx9IIEc0edI2wYupIu3
 /llBq9KVznLsYxeup2wrwSgO3MyPUy5RLXd9+yWAHks4orCfyZ6nrA3hS6Qt7Bu62i23
 EgokPYZB6x4I/sIix36FLXDwUQkMBLPjtaI8/IZYpMhN1ZfeRxOOTOOTeY5jwp5SjW/x
 c5T4K4qjWUrJV43LQTyAdsc0gvk7wLJMKWyHYIkRk/SIoxoBGZKR9ssq5fXu+T8CUdPI
 cbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795112872; x=1795717672;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TW4bc5CkuOZa+KUNztT6aTIKt/azwxDPgwVwxb64ZYw=;
 b=ixuRnZvOt2rXtA1+qT6aBPjoOp1j1+FUKVBEx4vCpRhGxtymTLo0DoFE0ZIGKY3plC
 /sgWIB5C05H0VLHFp45kf2CkF3J9cL8TraohFRYRo3QFd4+wwRtee0Hw9d4lKwGMuKcC
 +05xFxD8auQx80PXQVPNpys696h32wm7mYBp0U2YdkCZUNGeLtMiM8TQ6T4y88H859II
 S7Gaismqpe+fLidiT0B7yNG4cm/qdXBvTa4NV/K1H3Ing8IptmxKbKr/t6DLuTuon/rY
 tVYn6ucnlEZGJmS3U9DEG6BILvVnnPNn4hUV3y2qpXaTXUVdwFF75pFlCb6sK76OJgeI
 +l+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGGjjmVGYBZAHQAx2LA9oHJX5V33dVfDRrXxWWxluXf8tnA3hVexTH5xlxPRcgDQAj3PkIj5fA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+xhb/JwehT/A5w+pu1Ru2cnpNJLm7JNjlb5fUxPQI/o35qEoOC
 V/qiBx4AwXSHfjmSjeMfJ7j7ro1Jr60YkbxSwwnKuWbpZm9BD8OoXjJYmxRkCtANlK8egqF385M
 5BfEzrHZtLakM/2Godn+jkYLJ3cR6cRU=
X-Gm-Gg: AYBFou0B1qR5m1ZD7Hm8kACR/myZYAFTlfV4D27NRvDu49vcqihJA6Gjl5V6sYUDspu
 OTckGDmxv2ixvbqrBrvkAk+o3mn8azaVmgaPVPtzCbGPGGbfdaRo08gTFSKEDJpf+Xp4uwB0+lt
 n5Kw14Y4FsXb/Fmh7fMWh5E9GypEGdNnJNGbJJxM++j1HnLnutnqmYeaMSLh+09yS9+pfJVTcKM
 5aJtafeFWZpSBsipAVFWbHDzyGYtBR5soO366/XjraOLo2PP3GY3JvDDMyiRi8C381+FUMO50Hs
 2qUdzmkNnZlBjSuggk9y39iDfq6P/1FNq9xV4XgpLnVhBUiFV6BW26Kp4/VQpvJ5DziJOem5vm8
 FCngsrlhSDO3fMbO0tGH48VeLAtCfBV/Q4DLsoOFm3m/e5gV7AFjte5/ZLNY=
X-Received: by 2002:a17:907:ea90:b0:c50:5e90:5ea7 with SMTP id
 a640c23a62f3a-c513ac9dac3mr78882666b.49.1795112871776; Thu, 19 Nov 2026
 10:27:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <d4dd19c0-2243-4f31-8693-02a25bd4a6c5@kwiboo.se>
 <CAC928HYDGxPsRWz3SatjTP7-d4GPo5ie6EdRpijxF6GUKEVOGQ@mail.gmail.com>
 <8e917d4c-4c0b-46bd-bf0f-84e75c865c8f@kwiboo.se>
 <CAC928HaHp-F2_-fCAihT0Q+nY4Hm3j9jbGzY988+vLM619W8mQ@mail.gmail.com>
In-Reply-To: <CAC928HaHp-F2_-fCAihT0Q+nY4Hm3j9jbGzY988+vLM619W8mQ@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 19 Nov 2026 19:27:38 +0100
X-Gm-Features: AclHuK_BerX6Mf7LMjWr34U--eiPDv4B8uBhSRfwb8zUAzi_bvf8CZr8SxH7pyc
Message-ID: <CAC928HZAyoFGf+UamUtC+2xLjXvD9S1WkuY1Dah3Dz7VaWEviQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

Il giorno mer 14 ott 2026 alle ore 20:25 Massimo Pegorer ha scritto:
> Hi Jonas,
>
> Il giorno mar 13 ott 2026 alle ore 23:01 Jonas Karlman
> <jonas@kwiboo.se> ha scritto:
> >
> > Hi Massimo,
> >
> > On 10/5/2026 1:44 PM, Massimo Pegorer wrote:
> > > Hi Jonas,
> > >
> > > Il giorno dom 4 ott 2026 alle ore 20:54 Jonas Karlman
> > > <jonas@kwiboo.se> ha scritto:
> > >>
> > >> Hi Massimo,
> > >>
> > >> On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
> > >>> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> > >>> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> > >>> common/spl/Kconfig file where they are originally defined. Addition of
> > >>> a second config statement without 'depends on' guard causes these two
> > >>> options to be put in the configuration even when the guard is not
> > >>> selected, which is unneeded and sounds wrong.
> > >>>
> > >>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > >>> ---
> > >>>  arch/arm/mach-rockchip/Kconfig | 2 ++
> > >>>  1 file changed, 2 insertions(+)
> > >>>
> > >>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > >>> index 1a2e7847c9e..5ed774159be 100644
> > >>> --- a/arch/arm/mach-rockchip/Kconfig
> > >>> +++ b/arch/arm/mach-rockchip/Kconfig
> > >>> @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
> > >>>       default y if ARM64
> > >>>
> > >>>  config SPL_BSS_START_ADDR
> > >>> +     depends on SPL_HAS_BSS_LINKER_SECTION
> > >>
> > >> This change is causing make to prompt for SPL_BSS_MAX_SIZE when building
> > >> e.g. tinker-s-rk3288_defconfig.
> > >>
> > >>   Maximum size in memory allocated to the SPL BSS (SPL_BSS_MAX_SIZE) [] (NEW)
> > >>
> > >>>       default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> > >>>       default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
> > >>>       default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
> > >>>
> > >>>  config SPL_BSS_MAX_SIZE
> > >>> +     depends on SPL_BSS_LIMIT
> > >>>       default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> > >>>       default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
> > >>>       default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
> > >>
> > >> Possible adding something like following?
> > >>
> > >>         default 0x8000 if !SPL_HAS_BSS_LINKER_SECTION
> > >
> > > What about selecting SPL_BSS_MAX_SIZE default based on SPL_TEXT_BASE instead of
> > > SPL_BSS_START_ADDR?
> >
> > Unsure, the original intent of the BSS_START_ADDR dependency was to only
> > affect boards that had transitioned to use the common bss and stack
> > addresses introduced in the commit 008ba0d56d00 ("rockchip: Add common
> > default bss and stack addresses").
> >
> > Not fully sure about current migration state for AArch64 targets, I do
> > not have any rk3368 boards so never tried to migrate targets for that
> > SoC to use these common addresses. Most/all other AArch64 targets should
> > now use these defaults so it is likely these checks can be simplified.
> >
> > >
> > > This seems to me more straightforward. As this configuration states, there are
> > > cases where SPL_HAS_BSS_LINKER_SECTION (and thus SPL_BSS_START_ADDR) is not
> > > needed, but SPL_BSS_MAX_SIZE is. Therefore, I would avoid a default definition
> > > based on SPL_BSS_START_ADDR.
> >
> > It is likely these complex conditions have overplayed its need now that
> > most AArch64 targets have been migrated to use these defaults.
> >
> > >
> > > On the other hand, I've just noticed that the value is the same in the three
> > > SPL_BSS_MAX_SIZE default statements, so it would probably be even clearer to
> > > have something like (not tested yet):
> > >
> > > config SPL_BSS_MAX_SIZE
> > >     default 0x8000 if SPL_BSS_LIMIT
> > >
> > > What do you think? Thanks for your revision.
> >
> > Please check current values used for ARCH_ROCKCHIP boards using the
> > qconfig.py tool. If all boards use this value, we can likely just move
> > this default to normal "config SPL_BSS_MAX_SIZE" in common/spl/Kconfig.
> >
> >         default 0x8000 if ARCH_ROCKCHIP
>
> I will check. Thanks for your time in reviewing my patch.

I've checked and there are 134 configurations with ARCH_ROCKCHIP and
SPL_BSS_MAX_SIZE both defined. Of these, 133 have 0x8000 as the
SPL_BSS_MAX_SIZE option value. Only one is using a different value:
the evb-px5, which has 0x20000 specified in its defconfig. This is
the current situation on both main and next branches.

Do you see any problem with adding to common/spl/Kconfig:

         default 0x8000 if ARCH_ROCKCHIP

as you suggested?

In the case of the evb-px5, the value specified in the defconfig will
override the default driven by ARCH_ROCKCHIP, with no changes.

Regards,
Massimo

>
> Regards,
> Massimo
>
> >
> > One goal should be to continue migrate as many boards/SoCs to use the
> > common bss and stack addresses. It should mostly be older ARMv7 SoCs
> > that I do not have access to that never have been migrated. I do have
> > access to rk322x boxes, and have some early work for that SoC, but too
> > much other work to try and upstream before circling back to rk322x :-)
> >
> > Regards,
> > Jonas
> >
> > >
> > > Regards,
> > > Massimo
> > >
> > >>
> > >> Regards,
> > >> Jonas
> >
