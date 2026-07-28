Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C739FC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D6DE60AF9;
	Tue, 28 Jul 2026 13:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZlkQAxJZzhAi; Tue, 28 Jul 2026 13:00:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15D4A60890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243644;
	bh=K2/g36eE/t3u24RHJS4MAPW8Zcc2IKQid/0BFasCPls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehvpZ/YS4LNktNMQGm2OPA4QmLkLHi6BrwRkx6/MkmOY2En5m86xPxC0R9TO/oDpV
	 9lcfZ7n6y/I27RZpvHbUkgEvHRVXmlvncJTXhz+aNuJ8F73AQS6GPkGgZu3a/pYSXf
	 keFB4nzi6GLtC/R/UbMooP4j5Ecpu/MsXQq8tzqE4m+HtLChDoGWTjsV+xfMWwmrKK
	 Zo5HtINZ0tIlKOWmh2UZWpkapZ+wXkL3pjGf9r7JtDUembArppfTgySYJxW1mob1s7
	 3WllMuAVqv1w31Xo+Xgrnhc1J0h61DenedLHC9PeV1fNPQgbYzSCTaZd2o+/iqBkTA
	 BSVcavHWo1Kww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15D4A60890;
	Tue, 28 Jul 2026 13:00:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04AEF26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E941160817
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbsVmzy21Y-h for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:52:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F3D2E607D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3D2E607D5
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3D2E607D5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:52:52 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so2967565a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239571; cv=none;
 d=google.com; s=arc-20260327;
 b=qFGXwUuawt8aA9pHmfQfIZc+AFQ6sEYyJGEn4PtikT9E7fV8SVsOJw6s3rQEOb8d2/
 4+RPUUIfx/JX1JYHJTn41EHniliQbCq/6Qigenx48gW/xB5vz0b4ExGSUM2P5Rarx/al
 swtA/IRClB6HM3wiJr8eg1rxImc1ZI2ZHhNG/lgXq6OK7Tr4hTZdmm1Jrkoqgyk00VPK
 HckXIcyRnwxkvimh7qPa91QKaktxncHLrHvJySfDKvMi/qSlIxlaCZf1RCXp/xrpPJPG
 /10ROBV6o9N1MlZApg3AoMgYxQe3RkgLGOs2/r1wIdinCwedZbEaCYUk/GNhAT+MmbhW
 t18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K2/g36eE/t3u24RHJS4MAPW8Zcc2IKQid/0BFasCPls=;
 fh=bS826mPx2dWlq/vqb4/6evgLQB8VbUGEnGw40d6Kx1A=;
 b=eaPwIa78wGLAm88b8WJyRm+isFUWUFkpArfjseSttJFvHbBcT+wrxnTamWinL8J83U
 dpF9pSqXl/BqtEKhZ3ZncqH7Xepu/BuyN3pVd/UOZIJcTXfyaK6OlUa9Itrs5JWlJUqN
 0e8NLpFmzJJhHeULkH1k3Hf+U84GHP7a6Fwia1Vp5XJ6V6jt6UhTjUaVxpYnPoFgv8/x
 cUvGkLnqrbCHajygseg3BZcthy1+Z1hSwAuL408C3EDQOsvosxaJPgc0kk6QXc/MH0U7
 +OGncqod2o8/Lo2n2It377SfBXe9rQv7tEXcT5HyMLnj6AYku5GxWzPj2b/z3MbAeO12
 2sZA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239571; x=1785844371;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K2/g36eE/t3u24RHJS4MAPW8Zcc2IKQid/0BFasCPls=;
 b=XGRcPqNFeJW8wbnrb3RPyKCDC6ZbeQbm7l28Y1B3hQuTcOBvFhjRSUZPbW0sigsOVY
 dYIO0fpSUbzNcXs2I9syuKrsf4mJBSI22GLD4moQYKeJ973g/gz1r1SyS5JAC106cSex
 WccWuvojYoVsL1MV19K73afzRBb6/nkI5X8Ky6QN/mowLPwLfkSH5MDg19tjNVovYZot
 3KJ5KJiMAycSykkxL3wmqv01YMh/1+keSR+fe4XshlyKgZhrIVfJw13GOYt9CAQ6H/b9
 pxhJTIadO6RFiSswUXo+YRceB+cxjaZzcZyUCT6YtxTlPXA1VEZr9kLRbI8TBv2OZbKc
 bUUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRmLkvY87p1XH4bJEe39pF7yPjaCtOD8oX+E5eDWkJCoBotW/uYvby3Vcs/ALYS3tS9ommAq0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzffRpg/FNc/aPEVyDbNLkVr+C67qV6My4zDH7Y1nqp2kgPm3hF
 F0bamVZ3orLh4AtHeZQdfh5DoiCxskpvOg682BAOByDXpaCAxbN4DZuyNIZmEk1uB2bVLzcMyKx
 FJirtqBZJkFgOzwLZMkIVVmP3Pczan9TQQb3WHLVA
X-Gm-Gg: AR+sD1363IjExn4yyhbZ92yEnNg21f+jJzUqwPaz6NG50aFxZc3R4pOIJ6K6T5x+QY5
 vKccOsRq584Uxx2RonNl3iRypfOCfD/PUkPadwHe3gILhygQP8Mi0IGuSKwmcin2Oie6EkSL4st
 SFnA2NdDMRg8xtk9uFALr5x1XZCqQRlmtNAo8iX3sEpBQH8qT6D8i1nNjkGcsjtY5sgi0UK9GTo
 /UEuDDwq8kDUocykZLFgiFnBQ++BsivgULJiHIz2+3g9VL0MDiy4mjPNby3
X-Received: by 2002:a05:6402:3605:b0:69f:d4b7:94b8 with SMTP id
 4fb4d7f45d1cf-6a034a54568mr1029348a12.19.1785239570841; Tue, 28 Jul 2026
 04:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
 <20260718234617.98664-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260718234617.98664-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:52:39 -0600
X-Gm-Features: AUfX_mzhA_Gl7lUMZHcsIh4uFoFZNBWkdWTmAVj_qb8DB_F0vlVRsEOUlBpTIo4
Message-ID: <CAFLszTirw4Dd=XP5JU2abhYNH-stVqEsRcppA8z4WC5XAkRoBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Switch from printenv to env print
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Daniel Golle <daniel@makrotopia.org>, Dillon Min <dillon.minfei@gmail.com>, 
 E Shattow <e@freeshell.de>, Fabio Estevam <festevam@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Michal Simek <michal.simek@amd.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@ew.tq-group.com, uboot-stm32@st-md-mailman.stormreply.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239571; x=1785844371;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K2/g36eE/t3u24RHJS4MAPW8Zcc2IKQid/0BFasCPls=;
 b=BZ3hZHlKWwX7xdmd1+cJL+RWEnonVUXqj1WSB87iVHh3mQjN2/Tqi8w0soM5p8rBRO
 O4vo6DCmiuLqDUOtx+4P3pfDVYziPw1kGR392horHqcVCAMleM88GJl/1vBBjD4hVb6x
 JzpPXevYjKktG2V2ooe02bgO6L98cIUy+aX+A=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BZ3hZHlK
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Marek,

On 2026-07-18T23:45:48, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> doc: Switch from printenv to env print
>
> The "env" command is the recommended environment management command,
> its "print" subcommand is the equivalent replacement for legacy "printenv"
> command. Update the documentation to use the contemporary "env print"
> command instead of legacy "printenv" command.
>
> Note that the "printenv" command is unlikely to be removed from U-Boot
> in the near future due to it being integral part of the command line
> ABI.
>
> Implemented using:
> $ sed -i 's@\<printenv\>@env print@g' $(git grep -li '\<printenv\>' doc/) README

It looks like you (correctly) skipped doc/usage/cmd/printenv.rst

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> README                    | 8 ++++----
>  doc/README.odroid         | 4 ++--
>  doc/android/ab.rst        | 2 +-
>  doc/usage/cmd/askenv.rst  | 6 +++---
>  doc/usage/cmd/memsize.rst | 2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)

> diff --git a/README b/README
> @@ -754,7 +754,7 @@ The following options need to be configured:
> -             env set/printenv to work with. To run a command stored
> +             env set/env print to work with. To run a command stored

This is the one place where the mechanical replacement reads badly.
'setenv/printenv' worked as a shorthand pair, but 'env set/env print'
with the embedded slash is hard to parse.

How about "the env set and env print commands work with" ?

Or "the env set/print commands work with"

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
