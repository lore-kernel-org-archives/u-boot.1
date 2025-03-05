Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293B3C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590BC8121A;
	Wed,  5 Mar 2025 15:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IMEYcw63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F6E8083E; Wed,  5 Mar 2025 15:15:53 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31166810ED
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso7964799f8f.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184150; x=1741788950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJbJlVpuyMl0GROmmClg1oxdOC/pqhEPErpduFs08u4=;
 b=IMEYcw63rmTrQW1FyoSdnh92akY2P7i7Yyxt856Ph18ehRIugyhsBdDNnMJV/6M0bQ
 Juml45Ah7ERfZMcE196I6sK89W/+tpb6do9QtWtYkmxLE1QxDscjkVmwL6Od6OuUjHj1
 DbAdqLoMLxqUtUcsaGz74V8fQf3XsFwSCt9Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184150; x=1741788950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJbJlVpuyMl0GROmmClg1oxdOC/pqhEPErpduFs08u4=;
 b=to872vQ+QPLSLhxfE/5WwZwJzcAqWjxZU8OMzxNKWbJDAHGgaZ1lr9J89H8RAhNJUF
 Zkup/2C106BzJ8wibcKtiFsiWW07UU2Db2gIMJzsLPlk2z8F6LGOP45v9grBfCY88Qyo
 qIEqWyCKpNUWsqJfPVffVKRER30KOyUttNuQZcQpbIoPtH5z4YDWpsCf1SZACoS5vJnl
 KaRNseBFnNvXzY8+tnAA5Sf63tFK5l6YOfaNF2onsUdqJIjAp6qbMegF8J0dNPS2U2e5
 TPto/ZVW52YZYwrhiaVETVCfGSLkj3BlAcETehi/hXAKyqKYn8j0vfphB06+sO7fRHpJ
 ikbQ==
X-Gm-Message-State: AOJu0YxJ/rmKAl7+GK04MR1Zx1Lj2Q0tjSWiwkfcOD9I8cAf1jfgZwTQ
 IS67u4xuMiPM6HA/rF/QgrUJkGGIQTIHHhK1v4Bv8cblUmEtQgVcFWbbnt1k4gk+chR+0dwngSR
 6ILM19k+4owMhfV+MN97abl1BUccEC4Dq6pSG
X-Gm-Gg: ASbGncsN9Ck4pP1irv9s5gFIGL2vybqy/U648pBeW0wz3AGvlcaRiypeKj3wStKmMql
 10o5FNS+3cL03ou+cRKrBhHv+BnxhX2gv+9BNZnKjAs269MWZsxyj9GddeYc1tXYIkR1J5wrbtI
 ewc983xEO99XtIvz6ZLrrEtrxjfZg=
X-Google-Smtp-Source: AGHT+IEk+szOgyHd8kBMnJbMn9R/sQDeFirWCnWN7H4ik4RojgkIAOeBH1LNJDBTKqJGPWx61Du4PrP9g9vGnvVHMek=
X-Received: by 2002:a05:6000:1786:b0:390:fc5a:91c8 with SMTP id
 ffacd0b85a97d-3911f7cae02mr3053664f8f.53.1741184150651; Wed, 05 Mar 2025
 06:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20250226210501.72794-1-l.anderweit@phytec.de>
 <20250226210501.72794-2-l.anderweit@phytec.de>
In-Reply-To: <20250226210501.72794-2-l.anderweit@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:15:32 -0700
X-Gm-Features: AQ5f1Jr-AMFwgccfPppobAlIRiBJiBOTE4IlmBdjB7xvBoQBtpIHSCAT5D-EXAA
Message-ID: <CAFLszTi6DQdPPP1mpU0Aa5wfrCON8TLQkObAEFbtGozYr8-3cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binman: build_from_git: Add optional make path
 inside git repo
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, upstream@lists.phytec.de
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

On Wed, 26 Feb 2025 at 14:05, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Add optional argument make_path to build_from git. The new argument
> allows specifying the path to a Makefile in case it is not in the root
> of the git repo.
> Also adjust the corresponding test.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
> v2: fix tests
> ---
>  tools/binman/bintool.py      | 9 +++++++--
>  tools/binman/bintool_test.py | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
