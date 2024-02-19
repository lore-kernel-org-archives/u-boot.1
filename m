Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E71C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 20:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071EE87F22;
	Mon, 19 Feb 2024 21:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fzifI9hV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F2C87EAD; Mon, 19 Feb 2024 21:35:03 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4840C87DA4
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dbd81000b6so6981445ad.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708374890; x=1708979690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BpZpaZwlKcwoO9EgDW1tR4T2FejBLe5H8xL4acmbqs=;
 b=fzifI9hVian2GP9LXtjbCSc5cFbtVfe02/pR3sGrjmrJCvFYWA6aViqTt+GbZOyhlG
 0QB3zrMfsNXHcFEmaM3NFstRbtsDlk5fOEngYULC80sK4f6xwEgjGEyaG1wSj4Q/nqyW
 9idMdyJAIHbxfrw51qot4QY4jWlErfXCaXvsMEcMuardS7Cy9ADVz5oz45QgRnziyCO6
 UOqMfa5WXkjJ59vGpc2GTLwgbuo9fK2T+uSKj/t9DJAUbmjh5kkgbL8OvITFdt345g5E
 gy+wA3KcEW01rPJGnb7ERE5qQfM4L+L3HZzJXX5coJMSTzdqxoLAzxYJ/WA/ceC488Z6
 0lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708374890; x=1708979690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BpZpaZwlKcwoO9EgDW1tR4T2FejBLe5H8xL4acmbqs=;
 b=wFPh5HhPCnMhu45KnwVzgauyLqsMDYSPMyAntR4nAiii8f0zemRh3qS6NIK4t8Qboe
 jIoKllMXneo0EVLLQ7Q4leZyUKsuKbctjQMB6lCj1MdKuVglFOmHR8g/yKudJN0ml6lk
 7s/6rkOPFTGbMX85mYp/Q4zwGbthh2B1BTOrR/j80UR9xEdN7dt4Ny9ySTMRGikCtA91
 Pj267MOWXqWlyNsNAs7hrTvjzJf3QQ/grJVixug0GBAbTobtM8ptzShixDnPGOt+4/fc
 BG+LBp4YbfYiR00Y411vLfMg6m56qj5A/jQDROQ88fP3V/IlREvkUui3+8BpwLcdTqUn
 HRhg==
X-Gm-Message-State: AOJu0YzvClLkS2UyzT5H5yC7NadcrxQ5k7lnwANq/PkU6QzECTaKBbpm
 1F2QdLOeDlXn9MD8UIx6LG9/HIowZa+LYHa2Ua8qU8MmAgybFxWreerxREjjIuM46M8zu54OzJ8
 QLT2uSRV9D5ifVvDtJ8G/JTDalW8=
X-Google-Smtp-Source: AGHT+IFRgP6qJFNBiluFZA3Y5PPib5cUOpAZS3at62B4RhG0w5fcDexTaDOS8/chSJ2vvZw9NU2PdLc85TMPq3F/Gxw=
X-Received: by 2002:a17:902:c14b:b0:1db:92e1:2e55 with SMTP id
 11-20020a170902c14b00b001db92e12e55mr11458305plj.2.1708374890121; Mon, 19 Feb
 2024 12:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
 <CAOMZO5DQruTiaWMj4zv8gKyUJqtYqb5bmf7Z-Upc7k2+6yCffg@mail.gmail.com>
 <CAOMZO5AgYn1i1U6b85b3-6GXigY3UoCJ=1Zy4PsREGD88B-uEw@mail.gmail.com>
 <CAJFTR8R9tnycG2iV7QSDb67PqJBB9tJHnxmjxW8o-TzUBy_9yw@mail.gmail.com>
In-Reply-To: <CAJFTR8R9tnycG2iV7QSDb67PqJBB9tJHnxmjxW8o-TzUBy_9yw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 17:34:40 -0300
Message-ID: <CAOMZO5DtKH63vvvp5X8U8h2w1TwkmaAmVdn1zYJgJGUHEHofXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: dts: imxrt: Add binman support
To: Jesse T <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Mon, Feb 19, 2024 at 5:18=E2=80=AFPM Jesse T <mr.bossman075@gmail.com> w=
rote:

> Shall I send a V4 with them squashed then?

Yes, please send a v4 with them squashed and with a nice commit log :-)
