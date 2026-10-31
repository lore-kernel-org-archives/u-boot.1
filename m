Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D259606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eptQyFaC;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EXP/p+eN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B0F640BA4;
	Sat, 31 Oct 2026 09:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvEfiE7Z-Q2T; Sat, 31 Oct 2026 09:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1D6540BA1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439413;
	b=enW4vxBWI83tR4vpV0hcy3d4WS/loBgZcvQ69YEGgd8RN0fJs7PPrqbn/NIaxi/HWcqy
	 4wQLrvouAr3r4uM50ct43TCW0ADtS8sBMoEmwXU2VEK4AeINiokwpFovqxQoXDdcgP5b1
	 9pl19hjBpTL9v+hfBLfpjjjTU2d4RtgZMJFqnFcvUypw/s6LEvqoWMOZ7fwTZlmwX32d/
	 XtZ1mP/ij+ayIG2RA4iVJAk51X9KG3U+deK5q3O6gg13VcJqpo5JVzEUu9dzx/Ew/bSIQ
	 AqK6XYaj0fEJDOqlDkrnIroC4htLqOwdJt25NfbsjVQB7NTsPwVjMlw3Di8JuMzr7aw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DIRY6Pm/BtKHpknVgQbKm/LR9n/y5EvpWyL9ciz0hVI=;
	b=iRCcNVOuK23RmBukHSByBHdZA0fDVgPZwtDUTOBCs7UAuWIF3nspjC86xeVF+yfGYVCS
	 cHzW68fgrPvC/2pxdO6F0YKZZ7sPVVbi8206TKmSgWY0GImFrqGtaG4qJoA3RG6zXPQVI
	 ZDn2wMihEHciSLxZgjYYUhZo72DKkEe0M/tX5GJGQKr773vQs4OuHeXyyzagDTF9DMwli
	 sGro9vnrTFCZw7kvJAdMKHKBtfljr2cg4itlz7+QvL9rA6Xk9MfvAiBykKeNfmpLQu2vG
	 f26Bqu07Bwp8AydVovhIeBk37z+iSIaG9MwqpdtC+BSyTt0DQgIIjdK1FtzTIQCgSdg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439413;
	bh=DIRY6Pm/BtKHpknVgQbKm/LR9n/y5EvpWyL9ciz0hVI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eptQyFaCUJmcQua9tt2h9kB1AeZ8c0r4QPOB4WgaCHvgH/REvYivPJ5JgpRCJdGkn
	 +dQL1WI8n4HMKh/kz/bXAw5hgEyYXvhyt4Zt/IJsedkXQUARpMNOaQ1qguzWGcJY9v
	 6cuY0ate4RKU+yvNFQQF/2DIvABkep8MQMHWxvO5lsDCEp4QBwoepwhhA9tzDQFBtO
	 itgSOM02jEP1VwYv6JyPQkwU+UmdCRaXJXcRx6i+8Mw9MjZazvZsOEfs7nSv+l/5DW
	 BDac0NpGqBubaugIw5KVnasRusDhz/mqKtIZB+eUANW3a7LrtwJ+GvME749PzMXlBk
	 U6tm7ytNJhJqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D6540BA1;
	Sat, 31 Oct 2026 09:36:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D254362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EB4440100
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nf9M0a4eEHQ2 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 35F5640057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439386;
 b=bBgukb8FlP79TfQ9wTpB948YR301eJu79fqfWG4qe49kljOfEePVkt6p+HouoTWaGwm2
 mzeXHfiheguy0yMeowry6HMhV6fV421zRM7ATQpcBXMzTU/YPIe8kc/fuxp4hp4aQ2luY
 v3Xr8I+718Ik+eaDZPvN6Z4Iw9FhA0M9Ye6Jhol6j6m93lB+VjcwaN8nVofiEn9Vp1VEu
 OaVfmHk9HFs9lOogjDtgYFm8mzUHcg09mnrhnAG2M9ezcEgKdoq2JIFyQUF+KVWaYvB0T
 RRKxrFZyQWBTP+K9d78mrzTaAOGDoMgTJcYUtZ/PuGXb0QeQ75de+SSGwDnltfRSkSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439386;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=DIRY6Pm/BtKHpknVgQbKm/LR9n/y5EvpWyL9ciz0hVI=;
 b=JcW3GEZBvAqlj0gm7Zxu14IWul+vPcbvsRO2nzCIZiHBF3UEUodGOCPKbODhVT411GFE
 1BDhTbPGovBTo1d2eLh3PkwOjP6Y63npJiIZaeFVVRviaqfDxAIGoWJk2Q5EnHUJdqtdJ
 5azuAkFuRFZsyCIGfk43VXJqRTS7qX353U2qP7/vzN1LW6YvGuRhhlpgzw1KnuWjQOuol
 Mqk7+bOMB9XI6crcENN/+Ct8RhGR6akYtPEtUBEPI/cDyZuY1iSpJwYLzW8H+3XrGutZY
 JDnggqG1Jnd1PxNGWME2XY/Nk0A6rfelowsfnOqDuUWINO0Xb9ZfpH+FtfRqUeoA32g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="EXP/p+eN"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=EXP/p+eN
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35F5640057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:25 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so1997136a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439383; cv=none;
 d=google.com; s=arc-20260327;
 b=dpg2SabiNSzsN8T/Squ1r4ee7cWGwiPnzcC2OyYO37Hruh/bKZsdTy7gV5tRHINT0s
 sN7qkP2ojaNvPLO4xDdFxFdKeeADDU7TXpdaE0Ab+kldgAjhaYWJs/GAyS7UtrI3fu5Q
 uAqSuk6NJnljQIO7tNUxkONKOvd7uK4wMT1LMu+hQ7KR1iKAMPX5YwLfT2EWti5oZB9y
 fJtaD76wOCGbCN+peDUWEukGd3MQdJ8LHwMzhahMBCmm+micL2QRRBcAtc3ju1BqRKFo
 f/Kc5xvVZUZCh+fXG7v1grlGHdm2UNHwiZE9y9ekDgMBU4oiEGCDZ162fGsmZS+kvx6C
 Bm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=DIRY6Pm/BtKHpknVgQbKm/LR9n/y5EvpWyL9ciz0hVI=;
 fh=VSKm+XwYvvJqzck68SXkorNid/AeRXP8AUyCUDMdcWs=;
 b=qD5sUlt0di14utscDbao9eZi2CrXcrikHS+zGA0YSvQu5bJf9KE10Is0h09oZOOH9A
 0QvaapeT+zRokXCgrUAyOAmmSW/Bu+OC6skrMRYtAi2Zvv+6qKT4yxzJ9MCH6pSuBWmo
 R9nILRXBcZkDQax0j0T/7EVuI43/rC/E2udaHgf0KflM4MyJe2FP0ZgFuJdzHGsIFwjQ
 Q/wWGG/Jz/JJCL2MQ/JR9gSj8z7389bbmg080saf6zc+bjX9LONczD5WRBdaR7v4h+b/
 QZ0r0EW9A2nTYvhB5Sbu60sAza0PlcUP7vTmnKkHpgoh4YIPl5OpuuAGxSNGF/PGq0TX
 eCow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439383; x=1794044183;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DIRY6Pm/BtKHpknVgQbKm/LR9n/y5EvpWyL9ciz0hVI=;
 b=EXP/p+eNdCgEoiXzTqYQyPMuqgVSZYlBDHVX0QLDKOUz3vujgEEnGlkN+iOSAhxKef
 iuN+H980cvGmRhLzLszWm4ZJMGCp0XibY3sKezc5zCbQAVITbiIld22t7QemHGI6U/JK
 jy3BAoQ4FDa2O28uEiI8n8j5C/+jj92ZeGttE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439383; x=1794044183;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DIRY6Pm/BtKHpknVgQbKm/LR9n/y5EvpWyL9ciz0hVI=;
 b=z4SOGx+JRzNjVT2UZMvR0wHSQPgTLKoenPYprb0aYf9DglabF67JzB4nzJJk1UqYwb
 /rXRwemglxT3T8ynwzMGVjKVjn4r4sNCJBuNHpdiVQqNXIzCNZKckg/1hWvdJTvEQYce
 0eA+FREMPQS+kauKJ7tDwMav/klJpS8wfusRhb4tOmCTNN++s6Pi2dKw/bHN6gRa5IoE
 pJ0N8u1tWWXiRz5RQ8hO9UCIfBKksHfPI00oLBDJWpnnNeAsp5uMR/EcBlYSiJENzDJy
 /OkdHfgjO0WMWQNrglNTKq4AIK89uwMIZMZ1jL5V6/nKdzJkQDJYB6ISnlK9qe/2mGPh
 4LMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHr2GqxFfn9XrenKPKGoEF5+K6d61188WrajlXCKTU9wLJ7ZcbuY5ZK7FhTX2de7QXYvoZig4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJRF62hqCnFr1WCQXLNHaPAezeKqS3y+BnmIpazq6ZdtKLYQJxX
 yIyCWrZ1m2lD4wrF8gHqom7j3qShi3R5n00FY3Vz/GPv8nt+8dSdywgPp8ZUg90iiQCAZWAG3Ja
 3Ie0UcB0WgXQyVDnJ3XJIBiWgyiZaZNqu3+E9ntZT
X-Gm-Gg: AYBFou00FENbbg+LBcANtPGF96VeigPlipHddUGerhtOefOdQJXLg3hx69JfKOGPRtn
 7ZWHTk0YcoU2pTyLWC5KeigK+PpBwSIn8BejZpBlYW3GdM10jBT33LjuBvPyqtYJcr/AdISrp8b
 GuGf0KR0TQAHvunWQ4dXqex6GHa48vGFRhcTpsBhHqj1IcRymgCZO3EIdaHCJrroIlOcA2cji9Z
 NkUQHkCFobUydUinPdq6rDfd60c6AGkkvd6fj73cPuUaYtdIALHbEYkae7lj1wqkoW2YtYqCyPg
 XM3uiE0IpRQQTUFHRqeYjtyvYrxpSU7V/u+xEo7r4xUc/XkNLArigpqpiSGsZa9xqQFEb9Kt96M
 vxDs9UzYtdf43AVjaiYqImcY9p2jhOgJJ2kjkR2JAU8i/P5PNsaM8FEpfvUrBHSkjXsnifOo=
X-Received: by 2002:a05:6402:c246:b0:6b4:7c35:afa6 with SMTP id
 4fb4d7f45d1cf-6b4d5ed3707mr2143065a12.33.1793439383551; Sat, 31 Oct 2026
 02:36:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:36:22 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-36-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-36-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 04:36:22 -0500
X-Gm-Features: AclHuK_NMBT8Yk5mmS_dnfb5XG3XehEn9xRJspFLiKfWgHE_OTQ7isaZn3kh69Y
Message-ID: <CAFLszThaADNXi+GjnDKxEbPOCRcnQMSSrbED5VmMch=Z_XMVdg@mail.gmail.com>
Subject: Re: [PATCH v2 35/37] clk: rockchip: rk3568: Drop unused GRF syscon
 lookup
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3568: Drop unused GRF syscon lookup
>
> The RK3568 clock driver lookup and stores a reference to the GRF regs.
> However, the grf field is never dereferenced, let's drop it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 1 -
>  drivers/clk/rockchip/clk_rk3568.c               | 4 ----
>  2 files changed, 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
