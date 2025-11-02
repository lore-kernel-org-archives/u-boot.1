Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB1CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC03838CE;
	Sun,  2 Nov 2025 20:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOJzP0D+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA04838D7; Sun,  2 Nov 2025 20:54:10 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099CB838CE
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so5541991a12.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113248; x=1762718048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ia/EGlQE7yLH/1MoDoVONPj5agLaupCKn02+pnioAoc=;
 b=cOJzP0D+6DCTXHIgRHdJQybrx8xlQPmAAqO2WxZHydWxF4EHNKtx527Us3yrfLlafq
 yJEdeQya/HmUrfFhPLJdCmU49lyAt2aYJcldUmVvOdwaoidc3xym2dvdwEr8r9ck/Zzs
 ufZ4stChdAGUlNFG+HrJ3gub1bqRzltGQPCcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113248; x=1762718048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ia/EGlQE7yLH/1MoDoVONPj5agLaupCKn02+pnioAoc=;
 b=qSjjW5dByQbI0yJPbZnUsHMrCMW7Rv7aPQgA3ncDe5ZTLSDpXPb5z1VsjaeKTseofq
 ncuUoGjwsNnTW16B79T/P8L7Z2tHvecYuvh0hffinejkb0iTWdtMgDGfpMPuFboNffcO
 ZEH5qKLiLQzVkf95pbbTSbdTSV35LEJiADvHxTTEaHhpqKIAI0w6vHfHNcV7Pf0gIflu
 8IUwEyp1IYgEWPG9YktgEjiFOQKW2SYSNqihwGyrVXB/nZ1x0NLckWL9veSikY310jfy
 Ia1OaZH2Jgp/vmwywft5xfOwynC4kwNpvDH9A/7ZDt6Em7t+7Q7kBEHXu2w7ZOxvvZOD
 4Knw==
X-Gm-Message-State: AOJu0Yxr5GxRNXqOqt5xlZ5s7LhMTJSXsf54+2iCVU2H8DbWPtJabIbv
 lYp1YeeMVj8XuP0g+rJhdj4MNK02+sa5BYRdsy6/LSofKQpZNFEivlCfCc473Duzsk/3mDLYJf6
 T0eT9iUpSXDDSa9M5iIfDazdTvH0bIEkWn1QH1i9s
X-Gm-Gg: ASbGncu7nks87wmvofOOdTcRu/5kSHnykyIhJsnw7ATndUyGmaCkrLdT9YWbyatOvr0
 nlubLY/8t7GsM2hjiR58jbkZnQO9WW0d6sLuUBIl6uQOHEYeFyU9vM7hSN1tZDQVlqskhgpB0L/
 mwg5jGsEoSrlTYWyDnMuea8/CNXCgWGnM7PqINW4PeCo0+9llqaFk1IIabWKv1ZrpflwMHYj5cG
 /XVIcwO/uJgp2rLxPQoxUXQjv3jd0jPGJutGN8N48SdoZjB95lh8CnMmMrb9Q==
X-Google-Smtp-Source: AGHT+IETroDM1ySSlfHQyVjDoTAnfvWWLHgv/PS4JCfKboB2o+gZDFkfx1Q1bT+jBoYru/XD/XVupiDW0ue8aJjeqek=
X-Received: by 2002:a17:907:6d1b:b0:b43:3dcf:b6c3 with SMTP id
 a640c23a62f3a-b707062eca7mr952652866b.49.1762113248443; Sun, 02 Nov 2025
 11:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
 <20251031-rsa-pss-always-v2-3-a29184ea064d@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-3-a29184ea064d@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:39 +0100
X-Gm-Features: AWmQ_blB-NxVd6TGwLT4wy3-9FE7k8AddvFfsulhSlwwL_LfgFkV-3U2vL8sFwM
Message-ID: <CAFLszTik1t2gKDNk8ADMYzGW+BGfB+5J6vFuZ-ySXqkbiX9cyg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] boot: group SPL_FIT symbols together
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Alexander Graf <agraf@csgraf.de>, 
 Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 31 Oct 2025 at 18:08, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Let's not mix with symbols from other phases.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/Kconfig | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
