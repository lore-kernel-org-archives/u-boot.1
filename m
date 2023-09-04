Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C05FC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737DC86936;
	Mon,  4 Sep 2023 11:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rlNrtx/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EF886945; Mon,  4 Sep 2023 11:22:19 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182C286915
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so1875112e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819336; x=1694424136; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/840kZgrscObTEvYXoW5rlC2KVwEiYUwVc+QH4/oNvo=;
 b=rlNrtx/fd9T0aO7y+Pq0UhWcTuQSXBatLsaWiowrpi/uUD0R1lTq1XTmLaHFrollnX
 uSbCOcWXTgKsMTTIgJQbwWAEkDWpvwgjXXIhhazdF47dTRH0wZBm5+TpWS3KbJpfTvF3
 5KG5n+SwGEbz8exmn+w4jJ4lqOOUcnBgU3NBBH3YHsQjTYroSL/F4R6q/sbiwU3o4ACI
 XqorWaBAHWpwmMrAn6GVURxPds4xsATygsfhghYlQXfBike/AijQmw8IwbqtfdN2gapG
 bN3IwNmesIi5bsdZNbp0ptI/NlHDrTpxXh+KytfgPSHhmnH+2s9nzHd/UEPHlu3wUdSR
 PTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819336; x=1694424136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/840kZgrscObTEvYXoW5rlC2KVwEiYUwVc+QH4/oNvo=;
 b=G2diOdH0C6zFJzHZIsdpW91WQKmhp/QKJe4iJfZBIThQExePTEQbvHjTQOhs/lD2SG
 nIvEpjJGZT39ZqLKCG0Xqb0AOAh8RihLM5dA3MnmleHF/xm8TMLVgXDRE7XgbLybYm+3
 /W8vsntaVRvtbp3wkneuy3LOtqdWuETXQ8YA8mpRLcA05zVX50n7zr9HcyBiYTfrYnio
 3Uhwxbuwa3HY4dsnMpspPwG8vMo6ui+/GanCR0cBUw77ZKiV00U7/fgAkGiRKfhtRk/P
 5D8+gvRC50543Qr7IHGPEMyDEEK9JCTHHCLpmCLCPUKVPRH69x06qrwqkH2rOP3YsRmK
 hgcQ==
X-Gm-Message-State: AOJu0YzKe1wUj5FvXhN9blMzn4TbyW/LmiRYVuk9CmuhWVnE3lPZoVnD
 zwHI6Fs04ZfcjBPQw3lkI1Cq/Kf/CwERG1Dkq8o0Zw9qAEzzWw==
X-Google-Smtp-Source: AGHT+IGa8kSvRLFrtnopHXYcnEAky2pwK7DUOvlyZSXhUESY2yP1m9mE/vIAs9fhAOKOv4/NaN+j2AmrDsWPKiMNPaQ=
X-Received: by 2002:a19:644a:0:b0:500:c534:3e4e with SMTP id
 b10-20020a19644a000000b00500c5343e4emr5319793lfj.60.1693819336142; Mon, 04
 Sep 2023 02:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-6-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-6-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:22:00 +0800
Message-ID: <CAEUhbmVXFQpMzC7KMTk9dy_f=-iJCcK_ux_zJS2L4+UbdyBoDw@mail.gmail.com>
Subject: Re: [PATCH 5/8] x86: broadwell: Avoid initing the CPU twice
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Suchanek <msuchanek@suse.de>
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

On Thu, Aug 24, 2023 at 2:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> When TPL has already set up the CPU, don't do it again. This existing
> code actually has this backwards, so fix it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/x86/cpu/broadwell/cpu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
