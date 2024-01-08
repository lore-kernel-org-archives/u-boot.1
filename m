Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA3CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 18:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA6087AB0;
	Mon,  8 Jan 2024 19:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRli9Olu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DB487AB8; Mon,  8 Jan 2024 19:25:48 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F75487AB9
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 19:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d437a2a4c7so3679855ad.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704738344; x=1705343144; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYM+0ZP37SNr4XpPEpPMIQfdQCKe6x5mNpGT5UiRk9o=;
 b=gRli9Olu7LrVXWcHAuC7a++yVE/ZJwjFaxlgKz/tIA0PMdCVoqiFDYJw7/S1pso8A6
 lK45lf5xBtXoviiebXQ911uO57zyJ0SaX9ter8pQIHa8BvdDusRqwdL5vNDIT261hDcE
 2n/CLYk4FA/9+J9LL1MNTBRwDYQlcYbjUZZQFbnOkztgr11/Cat6ZhsG6g6IXsrvNIZd
 S9RnIBvVNzpNkeXc+vDU8cchCulFVOeGLNBUjt6x/ch052oGDyD1+B7JNsTK4l7cOvA0
 7+OWv2RnZDDZCmaatDjl/+BDFEwrD7O0d188U1cdwfZW2A8t+s9WKhC2iPg1HTUv7KMR
 L6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704738344; x=1705343144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYM+0ZP37SNr4XpPEpPMIQfdQCKe6x5mNpGT5UiRk9o=;
 b=CE3H13ouMNMTHiD3+gkG/3/tEhdtYWvFdnPeAcbbhBVb071RXYdqjnJc15hJ0sprwb
 WuhBbfnF8Tzh2ib6LcW49aSEw1K1CfTLtKVo2wPszWzdxWEDeUqDTspROs+msnwHKdib
 0sOF8Xi41hyLJEQ2Ap82zwe60Y2Z9YOl/XePUbhjtRjFdgA7zOEkCGpInqzNPBJgy13V
 ciA+K2i4yVRVnw/ACKfEHequQNax6OtxCszN2/4Cmk30ZDcSuy89ZS3OP7BXqt7PAqNi
 uj4LLf2iyR3wg46cjwpRo6VYny2QSyxjXMTZAjiwKwZsWATz1x3dmxFMHDII3ou/NHUk
 ntmA==
X-Gm-Message-State: AOJu0Yzowi4fDahHjX1Y7VTiQa+cxb1NYoPS/hWJ6vrCSNa0rkv9sLFu
 yE3z8jg25ZQ1dpnjQO7yl8XzfmCS15qhQJ22xUU=
X-Google-Smtp-Source: AGHT+IETnFGPg9T5O8mjTUddpMHF6mSErQjncCIdI5LxC8sGh7cGN2Mbn8HA7t48hVXkD6XcujBehGBW7T/z+OiSUZ0=
X-Received: by 2002:a17:902:a50d:b0:1d4:e2bc:89f3 with SMTP id
 s13-20020a170902a50d00b001d4e2bc89f3mr8052602plq.4.1704738343924; Mon, 08 Jan
 2024 10:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20240104155357.21865-1-othacehe@gnu.org>
 <CAOMZO5Cw3WE5j02GmFpGB7z4-LBA7Tne7X2TG=riTxpYvJZRuA@mail.gmail.com>
 <87v88489b4.fsf@gmail.com>
 <CAOMZO5CyqnaqqWpcLQZXPYXiSYbtzLzR+7k10NC-LZ2WA7P4iA@mail.gmail.com>
 <87a5pg8515.fsf@gmail.com>
In-Reply-To: <87a5pg8515.fsf@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Jan 2024 15:25:32 -0300
Message-ID: <CAOMZO5CYb3roadzA3ENu64umywJKExt5y4A60yeXisC0oGB60A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add imx93-var-som support
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

On Mon, Jan 8, 2024 at 7:59=E2=80=AFAM Mathieu Othacehe <m.othacehe@gmail.c=
om> wrote:

> Right, because I wasn't sure CI was working for pull requests on the
> `next` branch of Github. It looks like it is so I also created a PR on
> top of the `next` branch: https://github.com/u-boot/u-boot/pull/459.

I applied this one, thanks.
