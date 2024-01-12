Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95519C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 303D287937;
	Fri, 12 Jan 2024 22:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/d0+wVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A639D8793B; Fri, 12 Jan 2024 22:00:05 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E722A878C8
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d3fe03b6b7so14311395ad.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705093201; x=1705698001; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11QaYuA76iOmCEIKe6WeqomPDV48IpaE1dx4Fgset+A=;
 b=O/d0+wVJ9bsgxlq+zbdrC3rPRx/bxcjO0/xZlhMIvt2Sqd+RkVOwADCZ+QcUYkcXlr
 /idGbpqn+TCo9UqDFc8o7IYqmu0xpmbfH0kBrN+JVvhMigKQtzIJdHiZV/o3Gzmnmzr0
 GeMiwgNedLwq/bFzRRNHpm0jH24PFQnx03sOulJn4qE3NOn6XFNw2D3d+vcln/GuxzXt
 w0tz8w90FwIGL7XxrQBznbg7zxgm+7J9DT9WqTolk/I44Sd5p+kRufD1CVEbNLZMUW6y
 lGGZTcPEyBmvNDyHBtmlAncfeNKnzeATJXVq3OeAtK84RRagMJFDPORb8v9u46yOehP9
 IWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705093201; x=1705698001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11QaYuA76iOmCEIKe6WeqomPDV48IpaE1dx4Fgset+A=;
 b=wS9zrYkuYVNLcK3qX7OHthGRKpXIMNZezFnl2kTO+KtUC+khGz76kj3e9SRhXtostn
 XmEJJiE1FYlCcxw3QsHj+0FZ/+NOGpSdnEVrOoijHCJALPXDR/R7PrVl4SVEd3Fln+wY
 2+DPCywKdJ7MUTEI5eyWbwpPL+l8cha2k2vf/C5Q9QleDypR4pTYOekB7R/Y3vzoDPcl
 CdpnfiHPcSqot5OtaoJDdfZN6D0RiY5hUnv6rrU2bB4zbaaUajEHoswQ1bIN6oRfs0CX
 Qj8ZflwKfDPy2UV/8+3nk8PXul2f5b5z/NnvCr9202/kpRsuW0q+ULvyVRNJb3yuIClh
 t09Q==
X-Gm-Message-State: AOJu0YzKh+f1WDFcdogTRVFKW84UMop1kvHqJ/oF1ke7yha9zKmswaMr
 GzLojSYKAX432LF463YyeVD/JBSktoGYJ1YM52qaQjoA
X-Google-Smtp-Source: AGHT+IFeX+LI1nmKLMS9UeEH4WsNjy6JQWqIqfoykddH8jRdr9LQDDQqYjONwduuHHqHDh8VNyg1WDoxEcw3L23faw8=
X-Received: by 2002:a17:90b:4c42:b0:28e:fa5:7afd with SMTP id
 np2-20020a17090b4c4200b0028e0fa57afdmr2283869pjb.4.1705093201072; Fri, 12 Jan
 2024 13:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
In-Reply-To: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 17:59:50 -0300
Message-ID: <CAOMZO5CmmKXbzj6F1-tQ9tKifFNz4k-TpSMXBAfKQrTufM2epw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] This series adds support for the phyGATE-Tauri-L.
To: Yannic Moog <y.moog@phytec.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Teresa Remmet <t.remmet@phytec.de>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de
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

On Wed, Jan 10, 2024 at 10:35=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wro=
te:
>
> The config is minimal and mostly a copy from the phycore-imx8mm. SPI
> (flash) is disabled as it is not populated by default.
> Also add documentation for the phyGATE-Tauri-L board. While at it, add
> the other PHYTEC doc files to MAINTAINERS; they were missing for
> existing phycore-imx8m{m,p} doc.

Applied all, thanks.
