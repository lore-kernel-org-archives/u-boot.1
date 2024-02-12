Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3256C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 10:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59BB787C93;
	Mon, 12 Feb 2024 11:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrGZCxp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB84087EBA; Mon, 12 Feb 2024 11:58:21 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9389F879DF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d987a58baaso3758215ad.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 02:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707735498; x=1708340298; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq2NzGRrhbAxOO7BczbQ+8iwOvIgibIYnJBN1yQC9wg=;
 b=XrGZCxp5qtM9xrjG8yFlejiXN6IsAsNnIIFZBPCeUdTROEeSu9s6xJiqxCFPiMcoN3
 5+AsLA7f8yaqnqhG39tsZnoY0hhBp8qV+OrDskv3kQyOI7e+RlImQcz61wUCRtpCHsTR
 XB/BFZ+7u31SAAFa0tfr55hlF68yfGcIlaOoGQVw0VN/sNS9ikuOPX30y8NE/CgLdIlG
 l5+/rUpfPvRI5pltxpaiNBJSiKzgYgL62ZKrwrRexbFjMAEhLp92GBKrNjccer59SKqM
 Z33J3H8DdAxr0p16GFhhtrlF9k32gj+WvpI/yRl4YVc6XugKp0V6r6J4XTTrPE37gK+N
 AtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707735498; x=1708340298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq2NzGRrhbAxOO7BczbQ+8iwOvIgibIYnJBN1yQC9wg=;
 b=ItbrCT5c0bvKkJc+0YF3geaWRCIikAwqCfNpupARHWKOOfOe+oK8/Yk9QNV1/62Lv6
 Maog8P4UnZyiHs0HRzUD7NN/YuYwe3/axsInxOStuqgs6f5ijx+/Embm0kJQQxM/ZhAr
 71+uSuYwlPPqlpdVc0LIZ+vGl/MmPAF8/gcVFdKDfMN+jsMpMEbwSwn6/MoDFwPESsVC
 mAucFockWJzG0TLcJ8NcRQzrhkbLPXSeeImEnAL8gicNjfiyj91CGamMITk4oj8LOyDV
 AL73Y/pwjzk3BqXiW5ZmE7LBw5kjHuZs1PplQHytFOAewOXg/Dt18KApffaHWl1TkquZ
 mlEQ==
X-Gm-Message-State: AOJu0YwEA4kW3KMUDxosnT7E6WJAC9l7XYth90/Y7GLUy3TaYAdf8/IH
 VEQLh4AweXXIJ9fIs7AcGXkezLtBqpDG/QbBeZee1rDi+pQqXWdobpMIWdDYbGp8CYcfPHZYVKL
 7YIDnM07wvh3QQ0qYlQWI7gPQtGc=
X-Google-Smtp-Source: AGHT+IHwBWmSGDaC3LsfcZrCGER8srL23DFeVUpnQPi1jJF4FRXUO/lCS6fZ8DCCi556oCjvMUC/i/Ue0fn10gk+H18=
X-Received: by 2002:a17:90a:3f87:b0:296:df79:c663 with SMTP id
 m7-20020a17090a3f8700b00296df79c663mr4319648pjc.3.1707735497794; Mon, 12 Feb
 2024 02:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20240208173415.397633-1-marex@denx.de>
In-Reply-To: <20240208173415.397633-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 Feb 2024 07:58:06 -0300
Message-ID: <CAOMZO5AVn_cVsD=M6O9EGTS7gy3bMOq+eqoyX5FXB38umCZVbA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Let SPL configure ECSPI1 clock on Data Modul
 i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
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

On Thu, Feb 8, 2024 at 2:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The SPL clock code does configure the ECSPI clock frequency, which has
> to match the mxc-spi driver configuration for successful SPI NOR boot.
> Drop the assigned-clock from DT ecspi1 node on this board to let the
> SPL clock code do the configuration and keep it aligned with the driver
> expectation.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
