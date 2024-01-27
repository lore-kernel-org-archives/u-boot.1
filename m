Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E773FC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 12:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DC287D93;
	Sat, 27 Jan 2024 13:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dirp1O78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6B0879BB; Sat, 27 Jan 2024 13:53:33 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF9187D93
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 13:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6de19fa4071so1901b3a.0
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706360010; x=1706964810; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=322435ZCHzt6hjdUJVHD82EB/pCyhC+eLW1OjxLokNw=;
 b=dirp1O78+1Hh121Lj4FD1w3a2laWYaakEcZdLsV/p7620pd27EciMJ3ytGqXTSTqJw
 If3Fv4mU/eZk7U4J/Ee3YN4k7cDR+pa5e8dReMaEZP6C9uZDdswK/dtPg9t1SWUyn+aN
 5zd29Z2hIia/dglEFKBh7J1IdhRGX4O4eBxP8sQO7PvZE2d9MIKqjSYFwacx/hx6hSzz
 M5n+Sv0jDoBk/EgxHKZs+98g677gqh59zQnfdOgUl4IuNw/hkH2mdcy4oerM3anQrHNA
 qYJlWzmkt3pv1lAKzzxD+9D4UY0as5qplmOORaJMkclOdxQQrBaTdTkKTEG52RhqgXZP
 BVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706360010; x=1706964810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=322435ZCHzt6hjdUJVHD82EB/pCyhC+eLW1OjxLokNw=;
 b=j3s4GMBp00B7xn5cv75VrGiuY4aw0Da6Dz7EQILV/Rh1xvF8G/eTu9p2M+o8Rrq4J0
 kJAuaYWOi74VWV/aEBVs3zzJr6gL2HXFTTWoMpAJnIXRdfxsXSzHQpx8Lfrzc/ChXooe
 8ELjD02yZl8njAwJm8Ch0SfB9nDIP7V1nuA11MWtaZeQtPS8L1Ekt65evftTRWXljSRc
 +v0CPk6GK1FPBNbdmOVr3haJfXPidigMiar9X4G9hogyrBCvjqk4hVVXc8gMxq07KUEr
 YJdvYMNC+Omjfa0iSMFZUROyBejalxudPdMeEX1ObjYYvPTFh5h4DHWUkO4jdFWvNvh2
 ck8g==
X-Gm-Message-State: AOJu0Yzt4WG/tbICcp0OSzAbOrSa8NMz5AB7HiWUXeElvmyZDQjI/UX4
 mvkqsimsa8i7oTUcsqQPML4VOOHRdTHy7tmEvKswk6Hgikw/VQ5n9AdssHdqoclLRWVp9CdSYTp
 tL/qHnxvnWE4RWY4+Y+JKksewRZY=
X-Google-Smtp-Source: AGHT+IGXMEDEt2B/FxKPjAO4hStGYN+0WjFvKAg01JBkzDpQsKlPx73Ays3Mq/mOODDCmHhWgvp90xSGIRNw6UeJ4Gg=
X-Received: by 2002:a05:6a20:6a27:b0:19c:9acd:6683 with SMTP id
 p39-20020a056a206a2700b0019c9acd6683mr2535651pzk.5.1706360009887; Sat, 27 Jan
 2024 04:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 27 Jan 2024 09:53:19 -0300
Message-ID: <CAOMZO5ATrrzH_KZnspVadcW3Oo7GjRRqwmwXJ2Zkgu0fCo-+Ww@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Adam Ford <aford173@gmail.com>, 
 Fabio Estevam <festevam@denx.de>, Simon Glass <sjg@chromium.org>, 
 Jassi Brar <jaswinder.singh@linaro.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Alexander Dahl <ada@thorsis.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

On Tue, Jan 23, 2024 at 11:15=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
>
> Modify imx8m Flex SPI Configuration Block to work with imxrt.
> Add more Flex SPI configuration options to Kconfig.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Applied, thanks.
