Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899D0C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 22:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1618706B;
	Fri,  3 Nov 2023 23:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+OKtP9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF11B87081; Fri,  3 Nov 2023 23:11:40 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA6586E54
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 23:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2800db61af7so657195a91.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 15:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699049497; x=1699654297; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekI+zOYdw9e+om4vRufps5+Wt7QXlPPY+5FMZlY8yU4=;
 b=O+OKtP9iiiMalSNT2K+S2TSpBd7sKn25OgkAiqVA11dNrsOm6QGfzVKxeZLarNt8kO
 iuTUQEwnOVHU5c3VkJZ7dipu+3wzz1AbWeED3gTDl5BZ1996whAFHpIPrVJyC7F09BMy
 LdE9ITRd30IBPFaiaP3Ee4L89HAhL5fZGrVSPGaGboycKvbJ/XytemNra3Z+td7KWetz
 JncQKsOQC6yMn2iw60uIGtFX1m+CAabiqQTX5WhSGSXopQaRCnGWUOHnvBSesC6yjSZG
 nByJ+Cg2RRyySsw+YhnrVMuH3FuCAQaga7bKPEBLb3zTRlghdyg169haiaecBF9WJYXS
 hjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699049497; x=1699654297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekI+zOYdw9e+om4vRufps5+Wt7QXlPPY+5FMZlY8yU4=;
 b=NXt3yXKNXQOwvCktDNWqeNTJ2l2ha3h8HOUe8vOg07/mbUA4h5b0ueCf18RFqppqan
 iJNGyNEcSn5Gktq4r0WkoHDUInHeiWtuPRNdVDIEAAPitzqOyKsC3S6vjHiE5OobAsZs
 XAErBpkrbv3YsQPEhjJ18BzzsGn+kY0kYhqYXLayy+dD0mjTLiu1DSLE3IycYRy9dNcC
 dLcaG6Z6dnDhyHWSQydoZnWA2ZySZgH0KxqbFGxWwfas3ijmUJn0n2Vgr+rw0QR6GEYs
 aBSi52WANW/gG7Y1gfyO6chmkfAmkfMf8LLdI7rKJa8sydmUC2Y2Fa6WoPI/E8YEo7Hj
 5wMQ==
X-Gm-Message-State: AOJu0YzKfnfESxb3qTaGf1ROWqm42z2sGyySP+73iFzVXhOjUGnFNOvN
 feW4SBzjZMFJ//9AVTk0Yr6eAHwofe7NzIfVfnU=
X-Google-Smtp-Source: AGHT+IEAZE1hiBYHoW4+dRUnFj/GJA/0otLJ+IkJVMJb7ZFxx4G4fSB1OhASSJVr2c7RGrvTZjgC5wXo6VV1GALMf9s=
X-Received: by 2002:a17:90b:3781:b0:27d:15e3:3aa9 with SMTP id
 mz1-20020a17090b378100b0027d15e33aa9mr22040006pjb.3.1699049496710; Fri, 03
 Nov 2023 15:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231103211640.423-1-egyszeregy@freemail.hu>
 <CAOMZO5AeBwBrJcbU1c2F9pgHYjj4xGpHmxYn6wR+q1m6LBmdHg@mail.gmail.com>
 <A2AuTQ.RQdSxFYeff4N.2rZqv5Zu7g099IGJhPc@freemail.hu>
In-Reply-To: <A2AuTQ.RQdSxFYeff4N.2rZqv5Zu7g099IGJhPc@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 Nov 2023 19:11:25 -0300
Message-ID: <CAOMZO5Bg7MWtE7Lf+XQr6xegkTOjaxcaJ6jhkAS1KNtDsve0_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: fix typo in AR8035 comment
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6FuIEJlbmphbWlu?= <egyszeregy@freemail.hu>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
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

On Fri, Nov 3, 2023 at 6:59=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin
<egyszeregy@freemail.hu> wrote:
>
> You said it should be a separated patch, here it is. Totaly usless to mak=
e big commit descripton for a type fix. Merge it!!

Any reason why you dropped the  U-Boot list?

Yes, I said it should be a separate patch from the original submission.

I didn't say you need to enter a big commit description. A single line
is enough.
