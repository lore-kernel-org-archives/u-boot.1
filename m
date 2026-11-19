Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8A606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aSU/zBlx;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qXGyT0t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53AAB409D4;
	Thu, 19 Nov 2026 07:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmELnNSiYdYd; Thu, 19 Nov 2026 07:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CBE2409F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795073925;
	b=p2hG7B7uOayK9KmRsBBf0x+SVmj+Njv+bZmpAmCWyNX4AjiV75tGg7lfHL8//E/bssWh
	 5rcT8Nfbe00dBpsmlNQf/bnqT6rqvv6W/pweSTXk+lt4UsAQBMdQYA6MlnaQY33v+76ru
	 zPrh0r5wOxu/BCy0HpwqdOCxNG2lbNAOrZfWOtW/JwLFUgGmyrAFAh5HtM6WhQoRZcKTz
	 B6553Vy/BZfIqLm8gZvY3eH13zxXVF2rHjBn6C7pN+OLNJSASNJ0Oi6ErcN8Y1gX5d6uC
	 mJE6pJlchPzKQLA15MQu1Gw/MQaWWQ6ZUeRTuRgrUTYMx9m/3a2H1f9Mz6Xl7vIVVrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795073925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IAppsx2paoPUKB2/g9GOyiFWqMOcmw2v+TY1eAnsekg=;
	b=naM+xq01/lMp/Fm1rby7EbGheoaLk6xvsaFw6uvFZYhfFb/JxEVnrfTphCxqpouC4FPH
	 fMbVr863mOhGoVmjBnmAuS0peE8cOGFQpzWDRrXgI9oG56QOpPTRK7fB4X+DyjC7HG9Y0
	 qOfizKL1kdaF0lOwsGoM80Y6rGfm5lzHiEcLFrnb3zBzF8OlFFoeBiqy1duMRY8BXRe0S
	 FbcQnK/Oon63Thu2iHycXeqoudrvQReVTK9UIEOW7fTb0+NK+GIQxulfkX7+G8z0wX+8z
	 WNbOvfVA3GhUt6lykdF2rwsGQEuoYxDgCNHcV3MKWA+hAuwSz2JKc0gQ96z9P349FDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795073925;
	bh=IAppsx2paoPUKB2/g9GOyiFWqMOcmw2v+TY1eAnsekg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSU/zBlxNrIWENYofeYOkmsXLxFc0vPJJgD8PUCNDsZCbQIxr8nCycLf8XQ9iaam9
	 FfQcpOza14rQVEAJ7S5axu+Fv1oVXoKowX3iHf7XwXlDEwsGP3C9bjBE8s/jo4NPwd
	 MP7i37p+g/b4TW60SlBE5KAznftujpDUKqX8KJK0Zu6cbKXG2NlqJfjkaWJlsMN1Ng
	 5r1rF0eLJDu8jm6qnFt+jZHJTPIDLOqypNwemuh48YUOmfh7AqZH0oDrWdiJEsKznN
	 7JQUPPUkNie63uC2vr3Im/j58+VGd5VmQPzkjWsxWVPLdQhRfHVkmU3zz5Mumw+cEF
	 HZtHXAc5pqdXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CBE2409F4;
	Thu, 19 Nov 2026 07:38:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FD969F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65EFD60A52
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFkdompbgIx8 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 07:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 342F560609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=0qXGyT0t
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 342F560609
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:38:41 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c50e26763a4so295890166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795073920; x=1795678720;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IAppsx2paoPUKB2/g9GOyiFWqMOcmw2v+TY1eAnsekg=;
 b=0qXGyT0tQ4yiHAFStIWYCcHqDWYYLhWbB4t9B7ixqv4/VLsEVCl3MqQ6+YsBJYqces
 029CHnHzjqfvCdbhLZcpgoxOIVu0j25GI3ob6wTpTv8mkGk1DmgxivO8lgiup40NjkyZ
 73a9K02hQE+i0OxV7pXNSZUp2NMCa4Mu/i4LEb0W2BpkPcasoTR0uZXbSXY2kaSgzY2y
 fGJie/vKtTQpz13rwPoF0o3pPOyD/zzA9vNcyIqc54SCkIBk8TsDUeO1gZQaT0AyQK3r
 XhznDKUWkSxsf1fCuL3aIe2U09Dgk1gp4ebq7Sd63Ke/crw6obsfIV0iaFZUC4hn1Nji
 yQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795073920; x=1795678720;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IAppsx2paoPUKB2/g9GOyiFWqMOcmw2v+TY1eAnsekg=;
 b=uCUaQ0Fyxsl1wnyDHpmDw1rEezGGwE9UzLVzlxhZk8y3S1QxPe/NLEDIJoQ5Q1Z02R
 xP3XZm1es+ZE1mrXwxoDto8qffi6GvZpaUUlZI1M5GvTvKjyhSf39QJA3oiOaGSsZhLe
 d8IHLpzyV5syVkk76KPoFDHIYT+GYiylpH52OyFnjNdR8g5jqSGUjBo8oy+P1+U72ZsE
 PtxdwFBtRDn1UaoHCQ4yt2KvngI0w5q2mF+j1Fz+Upuw8llR/0wrqA/ZCRUq20G5KXq6
 WkWrEuolMwrzNl35pcdtMiUFVz32AcEAUpFwcLb0Xoabtq37gteTpenKtWHCWlzTXti9
 lrKQ==
X-Gm-Message-State: APuU4Z+Y1kRZ8pwxok+0qYNgHARLNLCmgyhfi85vHhHxAJpKD4+9FtHf
 EJs/u7/if9okyQCpKeCxZPoXKlzEuZLzZkDRhU6w5vUJaXsBrnr36Xw/1zZd6D2E0dN5DG3BZyN
 3Z/90SFvQGnAK9dQPTohtW5RHRWLiu1sqjUKG
X-Gm-Gg: AYBFou2mg1plmVQVKaKPZkkZGm/bcPjsXfUtKYZYPBwMv+byjTPusLdZ5PLD9YK1qIL
 Tj2vexRZX57vESnycXlYbZFdkRetaLW5U9HzIGWc/mt8+cytyxvoeZ95XoBQtcqSmFCJZCJ9vb8
 ByGntvlhG5obLaoVFmbwZROzu/xMmxLJtT1E6zn4MQkYyEfXYXFzjYn2UXsiZTZ3KJTqU8YmPci
 IaiiyrFIxONfW9M2bih+X6ZxUztrycKpSSfCICyzOM2bR45VAW4Fa5XniQys2Na1Va+Q6hQtg7/
 tVYvKtX/nCWa6pBgLyf9ncp841vsNqUx4Q6yHpIlRsawU3UAPD6R5tnkFN5a249jrWhbjQH2H6x
 q3Db1mLkFbxjlIp942DFDVrGyq3OUATJ9o+Ge1A==
X-Received: by 2002:a17:907:1b27:b0:c3f:c856:fb7a with SMTP id
 a640c23a62f3a-c510dfdac48mr452290166b.3.1795073919787; Wed, 18 Nov 2026
 23:38:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-2-fe9fb30a3169@gmail.com>
 <ccb6d9bd-284f-4cb6-9348-246e4477b0c6@0leil.net>
In-Reply-To: <ccb6d9bd-284f-4cb6-9348-246e4477b0c6@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 19 Nov 2026 08:38:27 +0100
X-Gm-Features: AclHuK-noCKBqfd4Dz0z6dsA6CJ8tNFXDHOoQiJm6Gt0caqq1Frgp5bH7c6ecN0
Message-ID: <CAC928HYwfH6TzwngZGM+vstGGHA4sm9wUrY3ryvgkGCi-63+3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ram: rockchip: add DDR3 sdram type config option
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

Il giorno mar 17 nov 2026 alle ore 17:35 Quentin Schulz
<u-boot@0leil.net> ha scritto:
>
> Hi Massimo,
>
> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> > Add new RAM_ROCKCHIP_DDR3 sdram type configuration option and drop the
> > PX30 and RV1126 sdram drivers' fallback behaviour, which consists of
> > using DDR3 sdram parameters when no RAM_ROCKCHIP_XXX config option is
> > selected. Instead, the drivers code now raises a compile-time error if
> > none is selected. The default value of RAM_ROCKCHIP_DDR3 is true if all
> > other RAM_ROCKCHIP_XXX options are false: this preserves the overall
> > default behaviour avoiding impacts on defconfigs.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/Kconfig        | 8 ++++++++
> >   drivers/ram/rockchip/sdram_px30.c   | 4 +++-
> >   drivers/ram/rockchip/sdram_rv1126.c | 4 +++-
> >   3 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> > index 74422947452..f51ae6a4542 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -24,6 +24,14 @@ config RAM_ROCKCHIP_DEBUG
> >         This is an option for developers to understand the ram drivers
> >         initialization, configurations and etc.
> >
> > +config RAM_ROCKCHIP_DDR3
> > +     bool "DDR3 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>
> Same remark/question/thought as the previous patch wrt currently
> unlisted SoCs:
>
> thought: add ROCKCHIP_RK3036 || ROCKCHIP_RK3368 || ROCKCHIP_RK3066 ||
> ROCKCHIP_RK3188 || ROCKCHIP_RK322X || ROCKCHIP_RK3288 || ROCKCHIP_RK3328
> || ROCKCHIP_RK3399?
>
> > +     default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
> > +             !RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
> > +     help
> > +       Enable DDR3 sdram support on Rockchip SoCs.
> > +
> >   config RAM_ROCKCHIP_DDR4
> >       bool "DDR4 support for Rockchip SoCs"
> >       depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> > diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> > index 37e62120504..bdb9cc9031d 100644
> > --- a/drivers/ram/rockchip/sdram_px30.c
> > +++ b/drivers/ram/rockchip/sdram_px30.c
> > @@ -130,8 +130,10 @@ struct px30_sdram_params sdram_configs[] = {
> >   #include    "sdram-px30-lpddr2-detect-333.inc"
> >   #elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >   #include    "sdram-px30-lpddr3-detect-333.inc"
> > -#else
> > +#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
> >   #include    "sdram-px30-ddr3-detect-333.inc"
> > +#else
> > +#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
>
> issue: misleading Kconfig symbol
>
> We already have a CONFIG_RAM_ROCKCHIP option and it must be enabled for
> the build system to even be able to compile this file. This means that
> the user will be told "look at this option" and it's already enabled. I
> would suggest instead:
>
> Please select a DRAM type via a CONFIG_RAM_ROCKCHIP_* option
>
> what do you think?

Totally agree. The intention of the message was something like "Please
select the config option prefixed with CONFIG_RAM_ROCKCHIP and related
to the DRAM type needed by your build". Your proposal is certainly less
prone to misunderstanding (unfortunately, RAM_ROCKCHIP_DEBUG also matches
the expression).

I will fix in v4 with your suggestion. Thanks.

Regards,
Massimo

>
> >   #endif
> >   };
> >
> > diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
> > index b371f597d23..3d7cd076a51 100644
> > --- a/drivers/ram/rockchip/sdram_rv1126.c
> > +++ b/drivers/ram/rockchip/sdram_rv1126.c
> > @@ -83,7 +83,7 @@ struct rv1126_sdram_params sdram_configs[] = {
> >   # include   "sdram-rv1126-ddr4-detect-784.inc"
> >   # include   "sdram-rv1126-ddr4-detect-924.inc"
> >   # include   "sdram-rv1126-ddr4-detect-1056.inc"
> > -#else
> > +#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
> >   # include   "sdram-rv1126-ddr3-detect-328.inc"
> >   # include   "sdram-rv1126-ddr3-detect-396.inc"
> >   # include   "sdram-rv1126-ddr3-detect-528.inc"
> > @@ -91,6 +91,8 @@ struct rv1126_sdram_params sdram_configs[] = {
> >   # include   "sdram-rv1126-ddr3-detect-784.inc"
> >   # include   "sdram-rv1126-ddr3-detect-924.inc"
> >   # include   "sdram-rv1126-ddr3-detect-1056.inc"
> > +#else
> > +#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
>
> issue: misleading Kconfig symbol
>
> See above for suggestion.
>
> Cheers,
> Quentin
