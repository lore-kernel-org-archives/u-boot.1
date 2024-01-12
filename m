Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2493C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 17:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62A98792D;
	Fri, 12 Jan 2024 18:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g5Sz6ahC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38F587937; Fri, 12 Jan 2024 18:56:04 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD2C87561
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 18:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28b93b04446so1410989a91.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705082160; x=1705686960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAPBPT5lEx6l01Nyst65ShHJ7E+5cJ7RC2FweFSGakw=;
 b=g5Sz6ahC1Abq2NiR1fjflS00BxDE9lkLLSsLgGkDmna7Ym7b85ODm7WafMvdLRoxKK
 F4P8Zj6reQ/iXKGJdGKnxTuSo0bSkBZZwyKRbIE31sFqsuDkvE7NTY+45uYU4ZIoTsw5
 6yofME/wvhIDBq6ybbH5icu62NfQ1NjoIuM7e8DZytZG+2Wz3S326u8hrx+7P+KX8O52
 aVw1uA/hxhEMKqTUyjbVGl91t7nsq6cq8NSCg5KFrzV3l8+3UoZkdja1jpx6vfg62OVo
 vsU0LCif7ONm+hk68ht83mWmYJzbziesMfJL3UK0wlG+FowuNtaq/Wek/XrOo3Rk41QK
 /o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705082160; x=1705686960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAPBPT5lEx6l01Nyst65ShHJ7E+5cJ7RC2FweFSGakw=;
 b=siaR40yYwIQVkMIK6hYOS9Ih5vJu1XjMuCBzzFqFjD2+Vj3Mk1r8nKHuBrimgiyfby
 25QiIN4EcT2dtYbU5QlHv0EbqK9JQMjLw2qDazGKMiVzxFTM4xileFSnVcqqJSkEDY39
 PlXh55tqAmBzzzgGpBu2md9IB67Mb65VprH+wdvIGUbfPP+ubJy+eblJMkRz4GmB9ElT
 DnsbvkvlQhon8AibjB+eC3LQuirswCxnbH3WueDP9jiZdwy6xskTJmE8p1WS689TpzX/
 DgjKqgBvK2GvP0C5Nt+5PzNNcWqtAZzQ0gefQlljAshG1oLhb4zpsWqqXkRPm9uxpYa5
 QQzg==
X-Gm-Message-State: AOJu0YwT4o+2sDr8by5kG6QVNQE57ewkaGPgBM17NGfyOFs1eXGEM66u
 Z4fgdrrP0ibgRu85LLaUSnvmTvycN+Yg7Gdo7YnK6x0NQG0=
X-Google-Smtp-Source: AGHT+IEnJQ1n1qJkgtTh5D46dnswP9Sgq8OGgxDpcZUbmMCr45euf5Ot7ot5UR6H/x6ffPkWGVzyMoBEZ1neZavtYb0=
X-Received: by 2002:a17:90b:1bd0:b0:28d:e180:5429 with SMTP id
 oa16-20020a17090b1bd000b0028de1805429mr2506127pjb.2.1705082159792; Fri, 12
 Jan 2024 09:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20240111-wip-y-moog-phytec-de-som-detection-fixup-v1-1-7c1a63e7eee8@phytec.de>
In-Reply-To: <20240111-wip-y-moog-phytec-de-som-detection-fixup-v1-1-7c1a63e7eee8@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 14:55:48 -0300
Message-ID: <CAOMZO5BBhS9qQFNkftiNN-6odxe_MN+ONGKwTsbCdMWwX1vtKg@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: fix link error when disabling
 PHYTEC_SOM_DETECTION
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

Hi Yannic,

On Thu, Jan 11, 2024 at 5:27=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> Commit aa7858fe5e2e ("board: phytec: som_detection: move definitions to
> source file") moved function definitions from header to source file.
> Makefile however was not updated to unconditionally build the imx8 and
> phytec som detection units. Fix this.
>
> Fixes: aa7858fe5e2e ("board: phytec: som_detection: move definitions to s=
ource file")
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

This causes build failure:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/769421
