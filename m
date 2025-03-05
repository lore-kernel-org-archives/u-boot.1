Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17927C282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB21680F56;
	Wed,  5 Mar 2025 15:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jsJgoh7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1620981253; Wed,  5 Mar 2025 15:19:20 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA469808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abf57138cfaso796545266b.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184357; x=1741789157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SE4ybUs1W3A2PVvmBotWf6noU8XM+Jvi3dFj7iXse7A=;
 b=jsJgoh7T8ZnIJV7XROUTQspCs79woKsPt5WqSjt2Yl2+fJ/njtpfzzQp/pgwqwZtz2
 yQmIDVXEQrzoqMFLGtyq12Cgl0hrx/YkNuoO4s0c72eGweytRrD9eUOTw8siOT+HG2N4
 MbxnSfhN4+uy5eR3tTkTM6zADFwLHLUKFA4pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184357; x=1741789157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SE4ybUs1W3A2PVvmBotWf6noU8XM+Jvi3dFj7iXse7A=;
 b=L/XHceJVoaY2MYsf6pUbcgRhkK/GzsxVUHhjrCk6G9uFyu9idtStfTMzUW8xZkxDhw
 l/zMnkKpt3u+9SyvuUs9VofkGpOuRk1YXwuje3A/McPrwooxjA1S4cDw1OGBFHpdJS5R
 HLUPLbEXPq/7jX2RCx+NxjJrsuZ7K7Md1rbY2pJZLnNTC3leCauiLECH1GKWq1pABuU9
 9rzEns+Ep76Cma0eDW2kX6IweeVH5ukmLC6w9lOSIsSe5wzaYi6bZZAZpCAUE+bvqO/9
 A2YymOndrapT909oRFA97QJFHo/Gjp7759BrBbSbb/exQFIRN07EsVQkQosB0JzlEALK
 i9wA==
X-Gm-Message-State: AOJu0YzWrHOWUTB+dh3dO+s++/FhjICaz/QK5Vf48ju58onwmc+dKV5X
 lpqNHQiPp6AyCCiIpusIM9SQ9c6o84RXHQiGN6bRVS2ece5R3xkgXoAqDGqDl7XlxJzJNGZSSgk
 ymLOwjfvLkJUvaQ1WKa8J3Ba/atHjWz08aMGUxV6XQoqWJPI=
X-Gm-Gg: ASbGnctlstOG4WcPZuPfjScnZmbxqCIvuwpNiF3bPZX1cOqADcZ7GYd0jmBvlYBMlM4
 gaDl4KnisvzCJ3Pi9tLmjxgAqbmXp9FPR7bnw+nOmeFA29gHATtkkWquz8csX2bnfNj37xji3fb
 w3KFTcy8jowDWi+TiMHrj8uVXKNyg=
X-Google-Smtp-Source: AGHT+IER6ATITS++j9rR8LZv5KAmigVGEyBqT4TQSRXIf6ohRA+CzFOjh1/a7djoRisoAQlgbw4n2rY2oEKK6SZ91Pg=
X-Received: by 2002:a17:906:c103:b0:abf:6c2d:f469 with SMTP id
 a640c23a62f3a-ac20dac4979mr357074966b.20.1741184357211; Wed, 05 Mar 2025
 06:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20250221203243.672465-1-sjg@chromium.org>
 <174103318277.1518351.1970213948242640285.b4-ty@konsulko.com>
In-Reply-To: <174103318277.1518351.1970213948242640285.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:19:05 -0700
X-Gm-Features: AQ5f1Johi-pffitWP0d1h-HWIXng44ha5IXT8AN463hVzHyk-5jwmfmEbNjA61k
Message-ID: <CAFLszTiGKWYFAJDf+SnBEhLNMwgr5Hn-3YsViLeH0=Hg_ET+pg@mail.gmail.com>
Subject: Re: (subset) [u-boot-test-hooks PATCH 1/3] labgrid: Deal with strange
 Python error
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 3 Mar 2025 at 13:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, 21 Feb 2025 13:32:40 -0700, Simon Glass wrote:
>
> > Add a way to work around an unexplained Python message which appears
> > sometimes with Python 3.12.3
> >
> > Make the file executable while we are here.
> >
> >
>
> Applied to u-boot/u-boot-test-hooks.git/master, thanks!

I have seen a few responses like this. Is there a way in the tool to
indicate which 'part' was applied?

It's not a problem to leave things out...I saw your comments and will
take a look.

Regards,
SImon
