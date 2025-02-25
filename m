Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2595C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A8F80F9E;
	Tue, 25 Feb 2025 22:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MZP1t6jT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6688680FAA; Tue, 25 Feb 2025 22:27:14 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 628BA801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e0573a84fcso8389438a12.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740518832; x=1741123632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dr9ohtFhOTYYdU4YK4EZqT0QwyZqf9pFXaABYUfFVwQ=;
 b=MZP1t6jT0vbTk2ZbD4z6ZEO0agOnnHi+ZlWav/TSQqy9KoR/Jh+YEjlUACT+xaXzlm
 9n/C/0eNbTeMRU2TM1XY5XYzcCc0etQnrrQZis/Os46X6Ec4dmjcbx+GcKJyC1yhgpQs
 7jPYAsjBwjXdf+zGGEAEkd13PX4Wt1kOySdEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740518832; x=1741123632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dr9ohtFhOTYYdU4YK4EZqT0QwyZqf9pFXaABYUfFVwQ=;
 b=EhGbKwLQktmI7JndQmPTmqrEUAhB/bfIlE96LjhWHL9uXKIbRudn3CDkvjT5q6Fzoa
 psXj92ZRCYBy0cfSbe8iJFkBPfTr2VANhc1EuEZi8owP2oyIQ77ZTlGL+dHKwNdA6u07
 pHhvKiK2eqNNy/i/qTBdDChs3SBcQZ2W/m7z9XrRl7C3cvv8CIqGYTBMnZEDXS2Vwaua
 iFTb8uTpec0h4HwPVLfeuW/EIrnPC0wBkqdipLbeNQfZ6m1sbPqzhiEJdndXGLsiITit
 lBtXacJAN5iW9eZMw7GzKtXrGhogeQzqPNVDXELw6kWjPNdB2DJScHdZp0si/NLHmu6P
 sSHQ==
X-Gm-Message-State: AOJu0YyDZx02GNzcwnvXkluL+cdxy1QCC9CDj2nfOvpJmk75qGLufTqE
 ATdk43Fg3P+b2Uz/aI0jHBdj/8d/GA5LUQ78d37MmriP9E1h6UqQb0jEP+q74Hp1BDPzwSbQJWp
 2rtEApC6BjLEIGl32LVhVvuowC5JQjEdfihZP
X-Gm-Gg: ASbGncstmb0lq5npdJmnbXhBl1KMzftAKzp0umPJJmYjD7N6RC+kcnxsIixh2Bsj3j6
 OhsoOHl3HBqLDQzzu4+IzXrL1nLPW1w0+5XhYJa4fgh41PefJ31nIDclLfBtoY0UMtZ8ltHogP5
 +0VniKCpeA
X-Google-Smtp-Source: AGHT+IGAKLZlJvFfwpBnXG4d8hN0NiQ0S6sYRyl4tuKGLPYDhAiWgkCTI7xq6Ih88kRa+Qv56Lj3j/2+0sRmAEQ1z3U=
X-Received: by 2002:a17:906:6a22:b0:ab7:eda3:3612 with SMTP id
 a640c23a62f3a-abc0de4e63fmr2124145966b.50.1740518831827; Tue, 25 Feb 2025
 13:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20250225121143.14862-1-l.anderweit@phytec.de>
In-Reply-To: <20250225121143.14862-1-l.anderweit@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 14:26:59 -0700
X-Gm-Features: AQ5f1JqstI5KnIgfoURPirqYKb3iwl5kjPOD7UjiDbx4-_S3hxqcmJVbT7-BN40
Message-ID: <CAFLszTg9xGTBVevVxFONyT76H-Ny=EuiHPqqSfgdTUNnmLadQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] binman: build_from_git: Add argument specifying branch
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

On Tue, 25 Feb 2025 at 05:11, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Add optional argument git_branch to build_from_git. The new argument
> allows specifying which branch of the repo to use.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
>  tools/binman/bintool.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
