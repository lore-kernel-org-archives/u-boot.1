Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B272C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B1D87776;
	Tue, 30 Jan 2024 14:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wu0jj4r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C149587D74; Tue, 30 Jan 2024 14:07:31 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8ABF87DEF
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-339289fead2so3091896f8f.3
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706620049; x=1707224849; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HMKXJ3j53hBQJOI+TOTDA95fyL8MJDnRkFn72tvKN6A=;
 b=Wu0jj4r8ev2VVZ/J78Nk64mxfCfadFjhedk9vGjN4TlHIesgBDRhcgU9IfzHW/mNWd
 hp0NLMf5Uyfw++jTOlMZ/uoSpRAHC9++WU3rP/1Sy9+hskPXUMuaTJ2IH5EXEo0W2Dka
 U6B8XexjamsUouRmrEu5a1KMS7OlmW7mVFIwP+zMoAMYpdZfXwXe0AbAv2ReuxfiRcnD
 pmfYr5swsjj/pMzvhyZuQUvFODgqnwpoA+sq8hwiL95Wx7XW0Bj67c14RPBDAtfp1Q/7
 /vf4YRvTlXC0a0OfZO71B843E6KsZQHtgpTFp3hG37xIUxQPLwhBen54ApP0ELzjDZof
 Qtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706620049; x=1707224849;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMKXJ3j53hBQJOI+TOTDA95fyL8MJDnRkFn72tvKN6A=;
 b=HO77UWQsVdFCCkixFnLRaA3gc+2Vy6JVkxnzjijC1//JU49fS4fkJ2Jed1d8SFigDp
 yuksN1rQ95S0ha1cLEWnuykZmC37vqRHCp6bzr4NjszbjSzFFryFvVp5/fXMIqqYmz4l
 PIwKINNuO2AnQeqoXmEzTON+12YA3TA/JKW5IG9BrFRAhFZ7RRljxqPL7sHuWD3De/FV
 FLRLU2ZREMLhfoWnOAhhFx2N4VBWzDdJoUvH86QJnkjftYs2L3VK0AXRb76QgF4N8IRr
 kww9Yb6foUvqlb0nXlYV2smFzkQ057vvJSsjDAJjmqMvBUKGg0sdNQ9N6dexOjCVo5r0
 yh3Q==
X-Gm-Message-State: AOJu0YzE1SRHX5y2MzHlLGV0viKyi6/3YOkj9sPvLitUxBe7pSwermSB
 vqXkvBj/YIQlHsLqG5wsO5zlI4wSvfS5PdAr5xaqXcWwcYCv0mDT
X-Google-Smtp-Source: AGHT+IFa/nr2+eUSpY1XA0+u6LybvopQM1XZObsTS0S03c+0POK6Xa+Du39heJLzFEX7hD09wFenAA==
X-Received: by 2002:a5d:69d0:0:b0:33a:f6da:589b with SMTP id
 s16-20020a5d69d0000000b0033af6da589bmr1843104wrw.69.1706620048990; 
 Tue, 30 Jan 2024 05:07:28 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:2d72:bfc1:4136:432c])
 by smtp.gmail.com with ESMTPSA id
 en8-20020a056000420800b0033940016d6esm6665079wrb.93.2024.01.30.05.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 05:07:28 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Primoz Fiser <primoz.fiser@norik.com>,  Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,  Yannic Moog
 <Y.Moog@phytec.de>,  u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
In-Reply-To: <20240130125728.GQ1152441@bill-the-cat> (Tom Rini's message of
 "Tue, 30 Jan 2024 07:57:28 -0500")
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
 <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com>
 <874jev2dgp.fsf@gmail.com> <20240130125728.GQ1152441@bill-the-cat>
Date: Tue, 30 Jan 2024 14:07:27 +0100
Message-ID: <87zfwn0y28.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 30 Jan 2024 14:12:48 +0100
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


> And what awk do you both have? environment.h is generated via
> scripts/env2string.awk

On my side:

mathieu@meije ~/u-boot [env]$ awk --version 
GNU Awk 5.2.1, API 3.2, PMA Avon 8-g1

and I have a similar result with:

mathieu@FRMONPC1176:~$ awk --version
GNU Awk 5.0.1, API: 2.0 (GNU MPFR 4.0.2, GNU MP 6.2.0)

Mathieu
