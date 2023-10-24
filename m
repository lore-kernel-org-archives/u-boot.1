Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03EC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E457879BB;
	Tue, 24 Oct 2023 20:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AcNo6sEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BC0879B7; Tue, 24 Oct 2023 20:04:23 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4F687967
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a822f96aedso48456127b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4ZJNRTmNTL1WOhEJspODJ7VVJdfIGOloeUFcj7gz5g=;
 b=AcNo6sEykP6KX8xAEH78sroyk2QgWMn9gfeaMXE/Hy6STvkqJZk29I2HkXlmeyM+Vk
 JidseBPLfT5ugmU8LiYZGfCOEnAsoUvnXfB/0qLbMmsBuMpjBY6mEHBMckWJFRIaYd0N
 eOHhWV06SOP6wmRepUEQXKWd3BsQPNyIjFQ+tbo/GBBs4B2Crea2kAJCRK5BvdiS4/sg
 2pYLkbJH5pi0BE+SzDFR8LMCkzBjV6f2Ot2T4oKPMjwWxJ/AUrdX6FilS2qXRnDuZn6m
 ERpyyvZMC/vsp/CsbiqUb8o7EjxGsBwrN+Ai+idGIxfSvWwPIbQh1uy+6ZTNZRVh+U05
 Ggrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4ZJNRTmNTL1WOhEJspODJ7VVJdfIGOloeUFcj7gz5g=;
 b=niFma25HbcBgxT1jgJqIxZwJZ18oaRFJ5oNt9Y9kQTTzn7WZ4OqtyStzsamVPLr5Zx
 itpTDxIaZCpY2NO82Z4sRGDt43STIiPNLHzUOT1Fk3KpSAmRKSwakXSag3bCVxbS6xr9
 cTYNPSFTLmK+C17Wxd0SAP7pGpGYOAIxFGOuwnTFmuBKXU13v3EVoGi+TeGOYO8ifShn
 T0Wtf++q0eFKJY0ndp82h7NBSrhrWwApq+AnQTcFlZQZ2rwidQnfleJj0aIe/0a5rbK8
 c1dDX0GXK7jVpx+6PjbeSrfBmt4bE8msRb8NoHH8sOWUsvSrAVjCgEzcTX1QX+JXTElV
 9iHg==
X-Gm-Message-State: AOJu0YxzjTs5Os3Sn67T4Zfp4Opej3K+uxSgWhpOuDZEA/QPS8afh2FM
 yn0ykz2qxYoSbvCBlg5ntuOeHouLkyy7+DaQQh/mzW+7RoN/YUNhYdOEcb5L
X-Google-Smtp-Source: AGHT+IEJaLTG9z9ixafLXu2lrKgEahIYN1G2p1TP5EdEXfdz9WQ7H35gJT5EMrHozLEAlcQ2/jo0NZsJ7rKeRl5yZ24=
X-Received: by 2002:a0d:e20a:0:b0:59b:fb69:1639 with SMTP id
 l10-20020a0de20a000000b0059bfb691639mr13940356ywe.32.1698170658992; Tue, 24
 Oct 2023 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@google.com>
Date: Tue, 24 Oct 2023 11:03:25 -0700
Message-ID: <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
Subject: Re: quick question about TPM
To: niek.nooijens@omron.com
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Niek,

On Tue, 24 Oct 2023 at 04:51, niek.nooijens@omron.com
<niek.nooijens@omron.com> wrote:
>
> Hi
>
> Just a quick question. I'm developing a platform using the socfpga_cyclone5_defconfig
> everything is working, linux boots, but we decided to add a TPM to it's SPI bus.
> For some reason the TPM support menu in the menuconfig is disabled and I can't seem to find out why, or which file disables it. can you point me in the right direction?

The only thing 'config TPM' depends on is DM (driver model). Is that
somehow disabled? Once you enable that, it should appear.

Regards,
Simon
