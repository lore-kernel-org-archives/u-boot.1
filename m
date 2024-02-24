Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF8C54E41
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935D587D06;
	Sat, 24 Feb 2024 23:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBx8M7yA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28D18751B; Sat, 24 Feb 2024 23:13:40 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A762387D09
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so724055a12.0
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708812815; x=1709417615; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9sD1O/pSfiyrrTudZnzEZBLQaFP7rdpc+vDoYB3rX4=;
 b=QBx8M7yAIDqHL/v3Y17PsJoQ9zd5LN90EUrjSgP5NyGiTLLnu8ODTGJHP37Z7cXUo1
 uc9pWySq8QRSLwpw3zg3b19v0ZktYxDyCzrIed+E/hTcpevrpWta6YOMxHg/L+HR4OYY
 mQ8qH6+IADnfRnLQdfVC6lKNCHcZvtFWY2q3DAA72aSOS4NxfgZn/HgSIYIC6WdAYiNI
 iFtC+XEhLWO9nEJ0Y9cl/5lgElezGqfHKknOFsXMNvFpLjcvAkzzdyEHJ9/xlzLeUiy8
 ODSr1FwPt167RIkSPja1JnjHvV3bfB4Ei6ybtf3/mrFQLFia+OYo5e8Iyu/1Akbi9fpP
 nMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708812815; x=1709417615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9sD1O/pSfiyrrTudZnzEZBLQaFP7rdpc+vDoYB3rX4=;
 b=u2r4g+TkKwrBYesSFMpHZYfCqEEWg5Oc8aUapZOrhtjxIdvw56xkqCbI3/5PzQtJfk
 HVz0BZLVjBQBmHS3uyAnM3XbiuzxcMU/SrHiK5Rxl/hco1FFGLSliEinOyRj4knlNhxr
 vqVtuVmHqbBcQLvTZ9yf19h218tYVafmeo1b2SbonbwwCmLm8z2ZZfISMZDsCWTu4b19
 52p9K/l9QctVKqnQjXxUs1BX8Z+Cfgv62tqOA9tPVs2hl9VJz+RYFYHhrsJ+9HV7atyW
 Ronxuzmq373znCof7XaZRffB6ywWlQjz+SyYUUdUohv85uYt6mNma+7JG9QiWgZlJ9Sk
 LdHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhvlFWHF+0tUBaaGRrpeydSJhzgMeBfaMc1CL4StPVWoZak79tUCuZnmqxn1vgTnmUMwIH45V+lUmgv/yzEhB4sSKyLw==
X-Gm-Message-State: AOJu0YwrUbyg6+6oeI2i5tZm9g0WRn+1IVu9gcwQy+HAPe8o063GGJmm
 NmprGNwjQOVaEvghoedwBfdURt9aeQ2BTv+M5Ac3Hx6LbtEbDAyu2luz/bbZmD/rPEJinA7NU7m
 A4N5v6AGjVHxtbS7UevBUzLqckSXfcayQ
X-Google-Smtp-Source: AGHT+IGY/cqMDUarjaUc4LBMvrq9fJNXXi9jETFoZLeW8xIR1QjhZvj3+z9ClKEf66DDJ8PZPw2LGyOHJ6auW3No9DA=
X-Received: by 2002:a17:90a:6806:b0:298:b4da:f90e with SMTP id
 p6-20020a17090a680600b00298b4daf90emr2684977pjj.1.1708812815579; Sat, 24 Feb
 2024 14:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
In-Reply-To: <20240220-thermal-support-v1-0-f6a97d8d6481@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 19:13:24 -0300
Message-ID: <CAOMZO5AP6ZXjYg+O0xCq9sGPGbKeG7y9QFCtc4hoPSGGxqZTzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Enable IMX_TMU driver for PHYTEC boards
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Tue, Feb 20, 2024 at 7:43=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:
>
> Enable IMX_TMU driver to prevent the system from booting when it is too
> hot.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Benjamin Hahn (3):
>       phycore-imx8mp_defconfig: Enable CONFIG_IMX_TMU
>       phycore-imx8mm_defconfig: Enable CONFIG_IMX_TMU
>       imx8mm-phygate-tauri-l_defconfig: Enable CONFIG_IMX_TMU

Next time, please put me on CC.

Applied, thanks.
