Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5859C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 16:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD9F875CE;
	Tue, 31 Oct 2023 17:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzUvXwwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C8E870D4; Tue, 31 Oct 2023 17:09:22 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF7C875CE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2809748bdb0so209913a91.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698768558; x=1699373358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnnF94GqdYbzNNqbaX3QX+NHLFTBTDEZRWekWfQnsak=;
 b=OzUvXwwEac6dinpznucYP+knZ3lFe2C1K+Nw+hdhaaBmfPZ64U9fh5rC5W/8vZvr3P
 PG8H27sold/y2DI38Fbb+M3EF0Y36qopPbcT1jxB/DkYe08vo0z/EPgTESaV/VJ82E78
 VfxsR8+xmeX62PBkpAxwg8EWD6hVpdjBN/gdtRTSnoMU5o9HYMTIhL+96DYMu00rX+5b
 mSz/HN7By1ydkdUNoIyMJCP4wDqwm+C4QVhL8lEhEC8xgJEOO2X0kUwB9gUJ37bS065S
 SA8ElDb5KzdzH5ng7P9DMPvkY06z47tzlI4MWq65NaD6HLqqaykIIS8lzHGzd3PdQ1En
 mTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698768558; x=1699373358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FnnF94GqdYbzNNqbaX3QX+NHLFTBTDEZRWekWfQnsak=;
 b=i5ycUdxYdYzfhcTpAvVkoaykmywYXZt48axVxO+pA/NhtLARMfubP60PA6bzFahBY0
 TdSlmIMnTEYr/hqcg3J8mAX4YlK421r/1RtFe66ffljiZa6DS7WgEHNC32OQvUULf67C
 eYOahKuM0dpQ5+F7d8kUMg2Yla/HRHTTGGZGb3fSONXfIylmlxDondXqmz1sLc7Zzf2J
 FYSuKcy1B23YrRtl8A9aBFTfaFa6L/vEgTiSVUnTFmhbvJ16GIjU7lwdnL091zt+V1dG
 k+bFwzcKcfAstrpfu4FYRePZNP4Ake+hOCjCxUYcRqGzvjwYRryJ2kgwd9Juu86iDYj4
 Lvgw==
X-Gm-Message-State: AOJu0Yyazz4a8MxLSR/Yl4R7kK3AwRnVW8/jUgw3KvVTApHK0Eckt6og
 sTls0L49n2kpZ1IMtdT9IRCIXXJDmP3KQ26xA7w=
X-Google-Smtp-Source: AGHT+IGNt+TllbanX55e78wPJ4U0ML2HFPfjtFCSHRERXqauhri8tsYCQlKppwESBNTvbiu1uFByyhtVd99e44CNX2I=
X-Received: by 2002:a17:90b:4396:b0:274:99ed:a80c with SMTP id
 in22-20020a17090b439600b0027499eda80cmr10764508pjb.3.1698768557905; Tue, 31
 Oct 2023 09:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231031122020.95007-1-marex@denx.de>
In-Reply-To: <20231031122020.95007-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 31 Oct 2023 13:09:06 -0300
Message-ID: <CAOMZO5B7YMuSRxjMnvuQ0u3MgLxZ=B9PwrqDe0DNOd3nJT7eXw@mail.gmail.com>
Subject: Re: [PATCH v4] cmd: mmc: Add mmc reg read command for reading card
 registers
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, Oct 31, 2023 at 9:20=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Add extension to the 'mmc' command to read out the card registers.
> Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
> supported. A register value can either be displayed or read into
> an environment variable.
>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
