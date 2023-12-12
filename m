Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF31C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56688782B;
	Tue, 12 Dec 2023 17:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h0Cjf0hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16D386EF1; Tue, 12 Dec 2023 17:14:34 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2158782C
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so971983a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397670; x=1703002470; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmhfeL3S/u6C7QkjkUoLZnox0WN7PU7PsvKlPOWCLKk=;
 b=h0Cjf0hlF4nJc0C+5i4pVGVoVdDbCVvYnJhuEMUA8tW5yt4Lg2Qu/a2Pqqw6f9yNUT
 pcDNo6fGXN+w8ay3zfZH8IVI7BxXB7+Xkk6tAQjNKWiaRM8G4DWUnHJ3GmR+Ey0iPZ5u
 yHs8NWFyyCi5yf0DeG3eScYThOltG85LrG5i5/nXeIoLJrPIhGxN2pb16ZbbflTgkklC
 vzMoQiZ51E5TgMpHt+A1X3CULdH/uDclqA/YiRrYW4f11uZBdLMlSDaUOzFpjvJ2YDNm
 +UdH2LOca0D1an6qPMYurKNzJ6On8nRk53hxH6UI5E5Sp0BBaIJAl5BAOJvLCgZFwcsV
 ck0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397670; x=1703002470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmhfeL3S/u6C7QkjkUoLZnox0WN7PU7PsvKlPOWCLKk=;
 b=rYsh3RnvTZoWV8gLtCABHFosY3s7RDpEBqhmgilmhp3dV3+0r8HjmOJayXykXtaGzu
 BzTvb+7Z3Fx9u0FpAGTQsLBJBnBNz32rsKuRj6iYEqW9jTkwq4KyOH52+i05LLTZPXvU
 QtibJq1KqA9nCcVPwfeSGH3n4lnfbA54DdnZtYHfjMW05pFVW4NgfNJx/PWm+nPuAAEp
 jn97UxLpTSPrEODKJvsY0gbsiI7BMCVhKO8X/vKEJqJnKEnW00hnRovGUSHfCfKSnLn/
 d6zU6PhZm6NK/zjXaijpfApSOHeR5bz3gO695vUomQQ6E55mg1gwammkJXwzVU/Dyb+K
 sbgQ==
X-Gm-Message-State: AOJu0Yy8OzF3uh+YArOu+c2aGlGJy5bZwyxC+MwsV5/KNNQFvQbnSYCQ
 y38szvjBgCR577MZ1KOBwPeMFW9dvjaaAfiRZDA=
X-Google-Smtp-Source: AGHT+IFuGr6rhtob1OqQJjeH0A1kgne8k6wXT1HUNH1YFwwll78YE2ZZR8HWLEoOb5cEvR0h+VN8N6dPKRlPMLvcj0E=
X-Received: by 2002:a05:6a21:328b:b0:187:ccb6:ddf1 with SMTP id
 yt11-20020a056a21328b00b00187ccb6ddf1mr14634906pzb.0.1702397670338; Tue, 12
 Dec 2023 08:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20231106163323.2883561-1-festevam@gmail.com>
In-Reply-To: <20231106163323.2883561-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:14:18 -0300
Message-ID: <CAOMZO5DhjeKFtXjNHOiRMKNgj32TdkTsVwRJAPxVAevoLJ95SQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx7s-warp-u-boot: Fix aliases and chosen nodes
 indentation
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 6, 2023 at 1:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The aliases and chosen nodes are currently indented using spaces.
>
> Fix them to use the standard tab indentation.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
