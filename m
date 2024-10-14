Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA295D18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CB78919D;
	Mon, 14 Oct 2024 17:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k+nO9OtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CB48918A; Mon, 14 Oct 2024 17:51:04 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B666E8919A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so29213566d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921060; x=1729525860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QO83hboIYliv/3SE1h7tjQAC7tIAQBuQ/M3DyQ4nQcU=;
 b=k+nO9OtOx4YoiKusAKTo79tDfsVxkf56+vwrtOelFF1E+VlV6oKIU71SWHFWgKB4gO
 6f2+yvDNgcdI96R8vWjgphhaTacAihouFVUt+WIEjKiC86A4/8mAMVRSmvc5Ns410uei
 nNwTvorXI6B/5ihky1ON7eFkf/R2jZ0fTp9Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921060; x=1729525860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QO83hboIYliv/3SE1h7tjQAC7tIAQBuQ/M3DyQ4nQcU=;
 b=BLi1HQg8T9iNj5EUZ0QQDnPg4aIvwsoKEGozUraLdwtHef2ZvbCC9uYKfYJs+APtqA
 BVLk5TkJ5rKp93FUYjiyzRPDUCb3zVG/L2xHY8vm64Wux+4InAuZ125RaguBKWwcooH1
 rE7UqFkc1azcTr5A3S4SEvU6I9tbh1kxmn0ZaIqt+5gsYk1CbwZn5kG+V0N0Cyg6En7+
 wLPLZG9irz1ZzKD1N0jhxGNE7VBZNDJXy1KbdOe6n9DfoErdU4uul6KPMf4Cs81pxOKu
 XDmDh+wKFBswS++5IkVxo6dEJw8//wdKZaacUV6GZURZaf7vSTpMN1hil7ZIOvk03M/v
 Fkyg==
X-Gm-Message-State: AOJu0YxgO18Oe+A6iuGGKYNOxH9VoWqYHgEs3SlAwSKFR5S3XodIPppa
 mNzd83p300pnCDi9XMukEA8Bwp7mtgWAJmPVEmUlCi2aHenUNes0j+Fctw2jcnzGE4JeNCEfYnD
 ObSplJJqfRBg+TUqe0+4sq5XkmlWXs8JXWi2z1bwcqhV4e3s=
X-Google-Smtp-Source: AGHT+IEwttnF9m4gesM5HFQFrkFWhLJBI7wh6YuIAJDgtiKkexhnIxy0WfS0FhbbvBkElGio1Uw9s8tqXl5h0ORVDWM=
X-Received: by 2002:ad4:4501:0:b0:6cb:f561:2a83 with SMTP id
 6a1803df08f44-6cbf5613294mr113865716d6.43.1728921060271; Mon, 14 Oct 2024
 08:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-11-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-11-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:49 -0600
Message-ID: <CAFLszThkoMSEgxnHQQBYEswbHcFHuDWn0RiJOCN6jV7g=Y+9Qg@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] lmb: allow for boards to specify memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Some architectures have special or unique aspects which need
> consideration when adding memory ranges to the list of available
> memory map. Enable this config in such scenarios which allow
> architectures and boards to define their own memory map.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  include/lmb.h |  2 ++
>  lib/Kconfig   | 18 ++++++++++++++++++
>  lib/lmb.c     |  3 +++
>  3 files changed, 23 insertions(+)

Since this is in addition to the existing LMB (which protects U-Boot's
memory-region) I suggest emitting an event in initr_lmb() to add
things to the LMB.

But for SPL, this doesn't work, since we are trying not to add events
for SPL. Perhaps I will discover this further on in this series, but
which boards need to do something special in SPL?

Regards,
SImon
