Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAA7C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3458486F1F;
	Thu, 26 Oct 2023 16:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eLd7pNTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2501186F1F; Thu, 26 Oct 2023 16:20:32 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57953875F6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bb744262caso220671b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698330025; x=1698934825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qyd3MVb+r70LNrKXiDBDcKQG4BGIVrjZX6VYFsLlK94=;
 b=eLd7pNTzKaK81r4fY0Akghy/vl8BF9c2ooYkfKz4QLksXhM6w3fVlCSpAiOB6UDpIc
 Uw4tW7688CoNvIjNLrwZw7H+/ALGFImqNXW4v5dhUKblRDPe3rEvJgpAtWWZNhl9+Jm0
 DDDdpMCAE5hjhbgcQmnL2xHOiLrj4tD4tnEOL75+/VL6z39oZm73n6ShkQtlWmKRciR0
 D+uVwqgmZdymQUK+9iGGPlMynmoKHWDwxJsgUu+6g5gL1BGeeBmcK4cOrvcwSqBiUoii
 U91f1ZxaVz/fRVk4K3srhb+bTRA/sdXMXKPvmjWB0EFhnSLKfQPNxPZs1z3JQfaAIuOL
 S9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330025; x=1698934825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qyd3MVb+r70LNrKXiDBDcKQG4BGIVrjZX6VYFsLlK94=;
 b=LOsDWdj/CNWTCPDWxtrt2FhO8KzEtcm9cmdxMrWIaUA8luMJ4HvkTk4NVdZgh1a8Dy
 thcfAAy+KCKWRkIx21DCiZbqD1xzT/w0i52QBnndG6y1HXXrWOLGXZvRKdzyfrzHn+UB
 XcbfpYOCmyQX8WZL7FoJCJ/J/a0GL+bjAOHbQkbw2xMTLmKpP2Juogm1AzkuNPErLrFv
 WTSOYq4iPkuIUJ1NCkb+tsqP7ACOh/gI5Kdn+Kv+/F4xGUac+9egGr6qhz6FgtzhlssT
 PxPt+5HgHrfdhAsGy9gyMZNKfJqwQgOq7zk3kaVanWxk7udypIN6KuI9bwwMrsmPm5Ju
 A23w==
X-Gm-Message-State: AOJu0Ywurk9oRu5S50H/GStXMJ0LTUmt3pNOX+HBbMC2z6rvQe+PhzFZ
 M1LKrtujgyxref+7OSCOnoOpTENU8DKfeGpnoYU=
X-Google-Smtp-Source: AGHT+IFxjetOgQizr7QvAedq+0wjgEhDI8Mx3SKX7k3NV84ldnjm0RxhA6NlxQc2gLrlsutiLDFiZpbe6nr+XoSXsdc=
X-Received: by 2002:a62:b518:0:b0:690:c79c:1912 with SMTP id
 y24-20020a62b518000000b00690c79c1912mr18154878pfe.0.1698330025363; Thu, 26
 Oct 2023 07:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231025230456.7924-1-aford173@gmail.com>
In-Reply-To: <20231025230456.7924-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:20:13 -0300
Message-ID: <CAOMZO5B-QMKUB7rFAqvXPyMNJVm0PX+PPZoTuwQVo3uYhsX_-A@mail.gmail.com>
Subject: Re: [PATCH 1/5] configs: imx8mp_beacon: Do not set
 SYS_CONSOLE_IS_IN_ENV
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com
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

On Wed, Oct 25, 2023 at 8:05=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The hardware only supports a specific console port, so  remove the
> option to change the console location in the environment.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
