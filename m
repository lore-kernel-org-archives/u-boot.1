Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67B3C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C43877D4;
	Mon, 11 Dec 2023 18:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VPClBr7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A66686308; Mon, 11 Dec 2023 18:53:25 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897A5877CD
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5d05ff42db0so45762717b3.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317202; x=1702922002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KaaUHeguNeeyPvh/3BsI6tO6gHOmGjp9EHGMdlc5nfU=;
 b=VPClBr7bZbEmBUf3apXNLavUSrXj6mVXNPkoQfAgfs26l20QrIVCb7ouFC3etxe7tZ
 OXiKuSQ2jp0+fF1/7FGdJXQ8aUbSwSeQB25UewcEnf6HCYTLNGUE2YfYxfCABMSjovtw
 iig+/R0UsTHVAHvQHx+dFWiMYAaAuzqfhXQ7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317202; x=1702922002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KaaUHeguNeeyPvh/3BsI6tO6gHOmGjp9EHGMdlc5nfU=;
 b=WT37ieRdzoVlFraRjBFcOkYBCDPb4xvlTrawj25p6CSEkLni+MiCdAEp3FjGuU1lhS
 gaH9u2gU+xDV6ErKyJUo7yPk10wnkQs1qf80Zh+RyKEWJCBdycaxIsh50nsv6zXRtQSw
 wocQO/88t+3U/UvYp6oPWHf5ryFtzFl02chR1gUjiUS9paSyXiQwLsEzNMJg7x8n/0rE
 j8thIBPPszzMqoe6wYt4foOw74nBpFBJdIblOA33esy6bsr9Vk2zcOiuT8RBgx9RFlxX
 2dWcGC1wov9yNMq22Ks3NK/iJBeJQ3SDCX0bQPUzZE5F8J1n3cPFAwUbLgonbuUWYdZ4
 mkew==
X-Gm-Message-State: AOJu0YxexEe22jFkkSL4UCpGCse5uuPL2+TEk5D5xFx2tl/OTIIoIhhH
 mkcHiDMI1ErEhS1W/zrwFr1t3EZOkrc5O999ndJM6Q==
X-Google-Smtp-Source: AGHT+IFjxGZJU90MpZWdz2tbYFQ4O0bJdgSc5NtG8OmcMag+6363BX92KqDOYlQD9reFxXijetSzrZGouGsMRDaaIiI=
X-Received: by 2002:a0d:d4d0:0:b0:5cc:dcf:47a4 with SMTP id
 w199-20020a0dd4d0000000b005cc0dcf47a4mr4008935ywd.40.1702317202005; Mon, 11
 Dec 2023 09:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20231209200300.12272-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231209200300.12272-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:11 -0700
Message-ID: <CAPnjgZ0ApG8GpgHgr-dS9se7GkSn_YnWpPn0n5V9BaTtuKfHNA@mail.gmail.com>
Subject: Re: [PATCH] CI: update pylint to recent version
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 9 Dec 2023 at 13:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We are missing some Python problems like
>
>    "Using variable 'varname' before assignment"
>
> Switch to a more recent version. Adjust the documentation accordingly.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .azure-pipelines.yml      | 2 +-
>  .gitlab-ci.yml            | 2 +-
>  doc/develop/python_cq.rst | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Is there an associated patch to actually fix these problems?

Regards,
Simon
