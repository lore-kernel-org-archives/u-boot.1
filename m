Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF72CC35274
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 00:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1273B8718F;
	Tue, 19 Dec 2023 01:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VEabP9fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE908744F; Tue, 19 Dec 2023 01:34:31 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB42686D2B
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 01:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d2793532d2so527982b3a.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702946067; x=1703550867; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFc/whY94ldUSolDAKZQJPkJSxNpycC3wtRww1+Tmo4=;
 b=VEabP9fp5t9H926CaEj5RdSh7FJj/UUXmSVI6Y1cKKtuGttdDb38YbFADfajnfgyg5
 lDs8R/JKDuEWJjcpK0dnjl1ShGdROIftqIWk2CA7R9m0yR1muelAI3NpqagOsh1ugvLA
 XXwT1kM+oXosYkDqGVHz69kMPX8ArsBEjD/Q7KKIreiBYKRGN4I/R5HsOVxvFcZOOdEe
 pjbgzCopiCqx4qXHUIPfr2Dlx9qEHwsd209krCi5pwzSe0yoLURJWo53aAtvXFIxhsRn
 LPH62qxvS7aKtbnJQ0VjEJPCFNy2DCkAD+fQSQazRSmqJ5irz1kfMXwbbrZqgN8hI20w
 okBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702946067; x=1703550867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFc/whY94ldUSolDAKZQJPkJSxNpycC3wtRww1+Tmo4=;
 b=XeWVjEviaFDkwQ4uKOIKLE65dGsMCQnj9z0RTBlT0nmDT20VWZXQIZCqgDHZlFcOd/
 30X6+cSYShSk9BjQt8apASKsc/MvuPZqwAv3mHtfYf6RVoRJSBaXJMFlaiiy3N+zgWUr
 8ETuVREam5NJGR21Fz1q9JT7mCp9WWU67xsCZM8mzu3H6kqsq5ucDvwEP3TUQU5fPXKT
 1qQ6PGR8/KAGaFU0zbmv0PHD2yOlUxDoBjoQYbHWQvRM3Boo9xsykH4dUMl/05ZRU16y
 IKjpGQIs7F32iDvLdLnPSALlCcwI+HKIvGa4tngbxs2qW5uT1XHewde9u/n39s3nZ/BR
 C61g==
X-Gm-Message-State: AOJu0Yz8pQF8qt9ReCekr78FSr2GDKEsI19g0JkSBn6kNh5tUiE43WT5
 pVKEA8j7zrV7m860RmKDoGhNBX/e096M2r/fvvc=
X-Google-Smtp-Source: AGHT+IGcnnFSgc8loooWXkqsFzFxu+J7tas4Z788wOPC72vL0fonkCojxC7/B/u3TZqCaGRkwO4reeXmNz0/eCIsZZE=
X-Received: by 2002:a05:6a20:3942:b0:18c:198a:469b with SMTP id
 r2-20020a056a20394200b0018c198a469bmr40006307pzg.6.1702946066918; Mon, 18 Dec
 2023 16:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20231218180226.37685-1-marex@denx.de>
In-Reply-To: <20231218180226.37685-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Dec 2023 21:34:13 -0300
Message-ID: <CAOMZO5AdEWsvcHPX1EK9LDwgmBRqfRrMPZGwTbGjfgofCYRCpw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Power off display output on Data Modul
 i.MX8M Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Mon, Dec 18, 2023 at 3:02=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Turn display connector power off on boot and reboot to prevent any
> bogus start up sequence of any panel potentially attached to the
> display connector.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/master, thanks.
