Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A99ECA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2809480EDB;
	Mon, 28 Sep 2026 15:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cnp2-yc1yQGb; Mon, 28 Sep 2026 15:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E71CE80E7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608387;
	b=ea0OEmk/3ilcxUmn3vaiyhRnd4VLgk+Lh21yM9ljmObp7aOHrEO0/hHoAdJCzaWmvKEC
	 +2LvrDe1n9bjPDMe1U9FI3pOUzkEQZGz3Tem7hukaDl7FqdI5imKO2aFfoj06ZKSX0OsT
	 VMHUhIfOaxeSv6EaVON6H1AwCKFPPNqmrWsQHq8agbLHw8JKtZB/S1OvtuBH4/VCZlljg
	 Q7+h5BpVZlsds8kzRokQtoc20jqq1+GdG62/p3yfWRpPqDVNmhvODV0+/hmcCTpNRBbh6
	 609vaoWIWE28mZ1tLMh490pO97mwm0sUR2QQ6QZ3wQjnMRR83oHrXwkAYIRxqDL5xjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ccqhcJW3Hv5UnQmafNdIAt91YYIfhQyLzqNh5VqkTF0=;
	b=pi8mW+4bmV1rk4VOg0uVb+iIRAL/73DpMlE1QhWBaGKEt2YfQzqJOBXxdg0O+D2MNFWW
	 zKrlP3YjOwNPlsaTu5FJA8COzNrT0soW+ZoL2nYkYR4VxJfXj1uRasbxRkHJ1hVl9nSjc
	 z6CHIAOilGaijV15/Pxoq6lQOlf/pwqTn62QRTYK261ZRnJser5mPF6QL5IHgDUrGhZQA
	 Dek/V3mEyPcXBESllPR8efBaWen5pF24sFCyHq2FMrLOmsxqzR4KFmam9WHABy2bSlXiC
	 gIHVWpWg7rg+FMstYKgP+uIbCVeR+skZHwrt14G1hIKY7E15uQG/sgGKM6Qcrq4jmqA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608387;
	bh=ccqhcJW3Hv5UnQmafNdIAt91YYIfhQyLzqNh5VqkTF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iIAjsedQZTP7kB4caESXNfxcAlpm7pHyzTaLEFYkrVyEVX6kJyjZdpCNM7zWJ+cJW
	 GGdMTaCUZR1gIhV5kMtLGgUPeqzpHr6tlBOJE2FRal1zqF3odDCWqeSOePzw7ZuZAa
	 pZ6jAz16V18nuFa/g9fc/PldyNu4wiMpIJm0Zmj7QV57M5HNaI5DMN8CB3gBGOo5qj
	 D+AsEPYENQog2Vg3S/G0CFRfjKbmWLssfiTiQ6AbkWp6bJJL9RKWkY7jG+XNESuiXN
	 KPjgx6W2oT3K7LgPuN4DyvEfmrhiGZm0bdaSsTdfQwSioiyJfkD+XE81ErS+gJpgnr
	 oIvnUPVlW+F7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E71CE80E7B;
	Mon, 28 Sep 2026 15:13:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60AD7D1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46D73400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHuSKd3FsHmo for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5982040048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608384;
 b=MvVDJZkmip4pHmHT5vam+bIsbfVGvS+Ug7zGxI/0zEh4f8NG7TY/R5p0YziOjTb48Awx
 Eu6hGuu4+mN9YCyT7HN4STjeuciqaRxrEXyZ8qNmBulNDlr6Ci46iNEf44VboDDO+/LLl
 erZqmTz0S/L2fUlKxcb0NlEUtHete5evTrHpZ0xAy4z5fiObzbTAxQKGLTbDGANCQFAgq
 gN1WZzcpBp1uBEaIhUzcfcfCl+yK+00GVuqH3o+80xePsFt/7OF2ZRSzj61iPcm0Ubf4m
 h+R3m60Us5pSniOcnSFUNRJaQGJ0XEjqnc/yGtJF30MeesFmhjQ4U8LV973anhJXldQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608384;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=ccqhcJW3Hv5UnQmafNdIAt91YYIfhQyLzqNh5VqkTF0=;
 b=O0RXlviIKupYdFlOkthuzY1AjeMxcSyRWrxhrTzRitx5kLL9stW+EG2K/54lSE3G6if9
 dI/HwPXWZVgiBGxQrIhAPtwUW8rh5g28nUlDlWDB12uWOfKO1b53xzm0sFCHkGJcwJh1N
 qnWZa5mWdk4mjghVEgkMBbEDckVrZlKDgW3GwsMmNXbE0IbdDm/Ucuqp4v0yXSztuWOHX
 iC4VVdZiJOMzKuF9T9eC5F5b6gycyHtYUzN+zPgrYxJ9wm0Uw/5dSfr31wtzT3w5/gwg0
 8OnKcpnLCXxWjIF4pgkcm7YgeNbNeGaBjDYTj2TmztFm4BHwDQIyxPymkZ78OqjX5JA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=e0Ddt+HU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=e0Ddt+HU
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5982040048
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:03 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1694721a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608383; cv=none;
 d=google.com; s=arc-20260327;
 b=Z2trY6oA2C7ZS8sBB+5lHKm7jtxePcywxpz6HhbIV8kXYU3e0BRK3eFn5v4J4w4lvo
 gL2lU2WoL5GxvRQ8uWsWaeroGGlEI+Qm2sxgV9Z1TP/bD60CTtWQPmrXJyODZZ3UGCU/
 jbieOWf1SEAG+7IO3ukeaONhIsZnQjZ8+BiEpdLL48VD8OEj1xR2aPQ7T6JhSTuRJNy2
 vf6PqZdZSS5ROMj7LCzPEEXz/EUf9vZGCGtt3JWaDYBgUSSVY6QMmuonNDShM1rqFrfO
 dMtHuws5Z6VN47rJpr5rmlUJoDGGRy6GuYQp5bP977kMd3rHOPSH8teNIxMlHTg0u3oK
 BmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ccqhcJW3Hv5UnQmafNdIAt91YYIfhQyLzqNh5VqkTF0=;
 fh=3yzjRICVm/OBdKx+ifB3q9MBDiwTkK6O/pHXFszFbek=;
 b=KBrCSmvAN60n9gJ6ak14l/5837zg0KILbZF9XLbL4OHtaJTSB4fNj01FyI/GIFhuwR
 TFdyyD+il7Ky61hpgAbjtWfYcfJ7TehS4ktX4qGu7rdDVdG4FdzT8Yw2bmwV42f7p9qG
 UCfI7sFBQ+5HPPWXx5ItxhuwBeKb1oz3ZS85H0/wgcwoorUCLHuTOsFZXRZDL3ivA80Y
 M/nxb59Xo3c4i21GqGJlLp0yFDVUxYuA3BAbrlp/6OdzgyJHDoGZPf2WTD8MS++s5sN7
 5HaaQZLYFaggcKQ1pxNnRpIO1AZsh6q0BVyFhHFu/r4G3yxECxSx0fe3pDlGvtGN9Ajo
 NVTw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608383; x=1791213183;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ccqhcJW3Hv5UnQmafNdIAt91YYIfhQyLzqNh5VqkTF0=;
 b=e0Ddt+HULkTuEgdAOp8hbJHmr9vHBOtVUcptrLLq8pLIigmMUm7CJO3OVXcwiHqtZK
 UV3coIuJam9y4IOsOaXvi+aPFSvrKfAXg9mvY71u8VFoG8e+YpzovtpxQSPsld3FycwB
 7yLUJaXzdkZFJcLe/BQ75tatIuA4J4bjAdIso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608383; x=1791213183;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ccqhcJW3Hv5UnQmafNdIAt91YYIfhQyLzqNh5VqkTF0=;
 b=C7duM/Fl5QI8zAM41QsjC8JSorachZwTRpFmkgWqjtzDgjPNhvtYx2vOd5sc84hb+2
 1NVfhwpvBtDiApROBzgrCj/PPrfX8IlqwnPHQMk/z/tzre+YViO0Db7jSIvVwVi9zuwH
 6FRsvMlQcxYOXthYE8JdG99AqxIZu135kzu2Mqpe1kQSCmXy9HFZvqLmpHgCdFSIH2OL
 g+2OWWm9xNqUvJaA5DH2R+Oit+HLWan1bT3aEaOhlD/2mUR9wlY3ZLzHzNP/CJzF8UXb
 J04QjMjXbv6f6SXxagAHrXiD7KPcll2yC2y4KZCVzSIr13AZNq3YOeRQMCOTMlP16MXI
 uovg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtqonoQhrPl3sBAYOz3OQiBYzl6DCd/48uyBTslj6nPd9qobdWxXbITQ/unL2P0qAoOj9U7aw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLCqt3P797eYnqn/j0ix2rU/02X4T3IsUTg80QkRfq72UCOfjQn
 lXyeYSA4yjecSIrC9TBZePmi1H89lbC8N+ociaZSq38s1Wcd16UynGpwNqKxoxC9IWc9zllkH8X
 FdPEOGX+YCsI6njc96DlGJNh7aqxXjIJhJuyPwt9j
X-Gm-Gg: AYBFou3/pdQ5Y3GUPVEwISEF7h8FTTIg3/+uuBpKQcx4OzEIhVNVBSPCw1X/LRmA1lC
 CzFgNuzIjAhdE8MKbi2bsNapRtdpWfRGO0J1aXqCO/ly+AtWyt6d7LCJWBhetG5wegqnjnc66Zd
 JzltyY+iWtiPcczI+7usDdmekv/cJfuhix9Bd2J8UpqXosKoGs0MiMwcmyN6q9D4CHkM8ADSmqP
 oXfODEgwabIyOZaq1xM8HmfC2uMrfWorNiaGAWyqsAhYRGiTCjNmZakESWjYAxErC5jDroeMM8L
 ScBFveiDU7GL+Mc84BFXOBHhMc98CY+XUMRh+ReyUDo2iT9LnVA81g==
X-Received: by 2002:a17:90b:3886:b0:3a2:b20f:21a9 with SMTP id
 98e67ed59e1d1-3a2b20f2a8dmr3413103a91.30.1790608383181; Mon, 28 Sep 2026
 08:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <325760fe2cb587557db49a21b51b85a04c3dc198.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <325760fe2cb587557db49a21b51b85a04c3dc198.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:43 -0600
X-Gm-Features: AclHuK82345efvcaiFFEJyXvFMmYyMkrlk-fIhIAIdbpLaOsYOAXt8xUQi05jJc
Message-ID: <CAFLszTh2v+7oc=VpJk6SvnZ_O7Vxnjd1komRNMyjiwrEozQ3Hg@mail.gmail.com>
Subject: Re: [PATCH 6/9] boot: fit: support on-demand loading in
 fit_image_load()
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: support on-demand loading in fit_image_load()
>
> Integrate storage-backed image loading transparently into the existing
> FIT flow so that all verification, decompression, and copy-to-load-
> address code runs unchanged for both RAM-backed and storage-backed
> images.
>
> Hook imagemap into fit_image_get_data(): when gd->imagemap is set and
> the sub-image uses external data, call imagemap_map() to bring the
> payload into RAM instead of returning the unmapped fit + offset
> pointer. Every existing caller, including fit_image_verify() called
> from fit_image_select(), transparently gets valid data without any
> changes to the authentication path.
>
> For uncompressed sub-images with a known load address, pre-populate
> the translation table via imagemap_map_to() before verification runs.
> This loads data directly to the final RAM destination; when
> fit_image_get_data() is later called, the translation table hit
> returns the same pointer, achieving zero-copy. Compressed images or
> those without a load address fall through to the lazy imagemap_map()
> [...]
>
> boot/bootm.c     |  70 +++++++++++++++++++++++++++++++----
>  boot/image-fit.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/bootm.h  |   2 +
>  include/image.h  |   2 +
>  4 files changed, 174 insertions(+), 9 deletions(-)

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -147,7 +148,22 @@ static int boot_get_kernel(const char *addr_fit, str=
uct bootm_headers *images,
> +             buf =3D imagemap_map(images->imagemap, 0, 64);

Where does 64 come from? A short comment or named constant would help
- genimg_get_format() has to distinguish a legacy header, a FIT FDT
magic and possibly an Android header, each with different minimum
sizes, so an unexplained 64 looks like a coincidence.

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -1033,11 +1063,21 @@ int bootm_run_states(struct bootm_info *bmi, int =
states)
> +     if (states & BOOTM_STATE_START) {
>               ret =3D bootm_start();
> +             /*
> +              * bootm_start() zeroes the global images struct. Restore
> +              * the loader pointer so the storage-backed path works.
> +              */
> +             if (IS_ENABLED(CONFIG_IMAGEMAP) && bmi->imagemap)
> +                     images->imagemap =3D bmi->imagemap;
> +     }

Restoring a field immediately after bootm_start() zeroes it is fragile
- any future state that also calls bootm_start() (BOOTM_STATE_RESTART
already runs bootm_restart(), similar in spirit) will silently drop
the pointer again. Please move this into bootm_start() itself, or
teach bootm_start() to preserve imagemap across the reset, so the
invariant is expressed in one place.

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -1145,11 +1188,24 @@ int bootm_run_states(struct bootm_info *bmi, int =
states)
> +err:
> +     /* Clean up imagemap on error (not reached on successful boot) */
> +     if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
> +             imagemap_cleanup(images->imagemap);
> +             images->imagemap =3D NULL;
> +     }

Several paths in bootm_run_states() return directly rather than goto
err - 'if (images->no_os) return -ENOPKG;', 'if (ret) return ret;'
after the OS-func lookup, and the 'ERROR: booting os =E2=80=A6' return 1 al=
l
bypass this cleanup, so imagemap leaks on those exits. Please convert
those to goto err, or drive the cleanup from a single place that runs
on every exit.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1140,6 +1141,16 @@ int fit_image_get_data(const void *fit, int noffse=
t, const void **data,
> +#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
> +                     if (images.imagemap) {
> +                             void *mapped;
> +
> +                             mapped =3D imagemap_lookup(images.imagemap,
> +                                                         offset, len);
> +                             if (mapped)
> +                                     *data =3D mapped;
> +                     }
> +#endif

Reaching into the global images from a low-level helper couples
fit_image_get_data() to bootm state - until now this function has been
usable purely from (fit, noffset). Please pass the imagemap in
explicitly (as a parameter or via a small wrapper), which also keeps
'ut fit' style tests free of hidden global dependencies.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2140,6 +2151,84 @@ static const char *fit_get_image_type_property(int=
 ph_type)
> +     if (CONFIG_IS_ENABLED(FIT_VERITY)) {
> +             u8 img_type;
> +
> +             if (!fit_image_get_type(fit, noffset, &img_type) &&
> +                 img_type =3D=3D IH_TYPE_FILESYSTEM &&
> +                 fdt_subnode_offset(fit, noffset, "dm-verity") >=3D 0) {

Please use FIT_VERITY_NODENAME from image.h rather than a literal
dm-verity, so there is one place to change the name.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2140,6 +2151,84 @@ static const char *fit_get_image_type_property(int=
 ph_type)
> +     if (!fit_image_get_data_position(fit, noffset, &data_off)) {
> +             external =3D true;
> +     } else if (!fit_image_get_data_offset(fit, noffset, &data_off)) {
> +             external =3D true;
> +             data_off +=3D ALIGN(fdt_totalsize(fit), 4);
> +     }
> +
> +     if (!external || fit_image_get_data_size(fit, noffset, &data_sz))
> +             return 0;

This re-implements the data-position / data-offset / totalsize-align
dance that fit_image_get_data() already does a few hundred lines up,
and uses a slightly different expression (ALIGN(fdt_totalsize(fit), 4)
vs ((fdt_totalsize(fit) + 3) & ~3)). Please extract a shared helper -
otherwise a future fix in one path (e.g. the INT_MAX bounds check that
fit_image_get_data() has) will silently miss this one.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2140,6 +2151,84 @@ static const char *fit_get_image_type_property(int=
 ph_type)
> +     if (img_comp =3D=3D IH_COMP_NONE && load_op !=3D FIT_LOAD_IGNORED &=
&
> +         !fit_image_get_load(fit, noffset, &img_load)) {
> +             void *dst =3D map_sysmem(img_load, data_sz);
> +
> +             mapped =3D imagemap_map_to(images->imagemap, data_off, data=
_sz,
> +                                      dst);

map_sysmem() should really be paired with unmap_sysmem() - a no-op on
most arches but not on sandbox, which is where the tests run.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2349,8 +2453,9 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
> -             printf("   Loading %s from 0x%08lx to 0x%08lx\n",
> -                    prop_name, data, load);
> +             if (!CONFIG_IS_ENABLED(IMAGEMAP) || data !=3D load)
> +                     printf("   Loading %s from 0x%08lx to 0x%08lx\n",
> +                            prop_name, data, load);

This is a build-time gate, not a runtime one - any board with
CONFIG_IMAGEMAP=3Dy silently loses the 'Loading =E2=80=A6 from =E2=80=A6 to=
 =E2=80=A6' message
for RAM-backed FITs whenever data happens to equal load, a
user-visible regression for boards that don't use imagemap at boot.
Please key the suppression on 'images->imagemap && data =3D=3D load' so
the message only disappears on the genuine zero-copy path.

> diff --git a/include/image.h b/include/image.h
> @@ -412,6 +412,8 @@ struct bootm_headers {
> +     struct udevice *imagemap;       /* on-demand storage loader, or NUL=
L */

It might be worth making this (and the equivalent field in struct
bootm_info) conditional on CONFIG_IMAGEMAP, in line with the
surrounding fields - otherwise every board pays the pointer with the
feature off.

Regards,
Simon
