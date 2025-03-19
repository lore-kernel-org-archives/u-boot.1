Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5987BC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFC181951;
	Wed, 19 Mar 2025 13:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JmWpC1b9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9827181A04; Wed, 19 Mar 2025 13:08:56 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485EB81101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2240b4de12bso39179865ad.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742386133; x=1742990933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2PWWDpbKBXC5vS/atlxo9FeJB72ss6SyzL0IZ7ijYGg=;
 b=JmWpC1b9j7Tw+vVlNE7LC6cuJ7gOeC3QpgCgEmvu1HhIJbWXrRLqNO3i9ITlVOqp6J
 qKXImcy3+XxEst4X3GI4ow67oO82XkNaR5l84DSwfrwkZwI8unltMfNc9JbDsCMg+YtN
 yzIC7zOneCiMSPISUS7tAJ1R2I9yNJagm0W4C8fAfE/Fx7CwmIB5zOQsOXh3L8GQmohk
 WbmL64GnlSTmM1XLSS1W78ji+C6ykt/PeoUPs/ldVna3x6YUpZ2L3jA7MhqiPQWXHHS/
 qFgHprYzlLftqwqDA0/Kt5ADDpgfV+iFmJo1ao5+vYQbidRNFeGn5RP0qckK7lqGNExw
 7NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742386133; x=1742990933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2PWWDpbKBXC5vS/atlxo9FeJB72ss6SyzL0IZ7ijYGg=;
 b=pDLHeqgDR59oOtxCHtKow3Q6Vg3BWUL3fqi3mFx7/6cVN8W+7Ixhq2PuMyOftwY3k5
 gRm/x4kL/VSZtol8i2JrF621Bn2D7lmDslgMLisGgbGfqjU32m4Rirvwvan/jo0uuzF2
 TJHc6LlnbVOredkakxzh1XEKjFN/5OChtLq4RFnIIuUUXRnvqo1wvhL7HctF2WJzv01r
 Z3LCTdzbq5U/q36tXbTG1SPOFs2mcqIP6lMdBA+ESyjGwy5Bp1TyE4Pv7674l0/9QJCW
 lCJYUwb7Cd2ySavwEXTolz+5o/mYnqRSD4vXB6gRCjymkhgKLZg2CuM9aNPXJTeASMkZ
 Taqg==
X-Gm-Message-State: AOJu0Yw7K4SMHlN5cKJfCLzObbYt4XKlJTzLVID+9sQoVD9oNWYOxQLE
 bkJ1LYHK54OLqGgpwoDbiHqMiutR+e/HFcJ7PpEvu7O4uxidgfZ3tE37q5P9Zm9RIquxP046tF2
 RU+wXmbOJ+AbpkXmr/QcBSVMvBk0=
X-Gm-Gg: ASbGncs595q3AK/H1rIq69wWK99/fk/P5oulfYN+2jkg0U1p/UAKeYjEr4IAOLPuLDm
 AfZpLTBpR5ZgItgwiUaQUUizyhRbTBc618FffX8oYco4CYgSGSaiqlQKhn9Enh0crK4YBw74/vC
 MOi7zJyu5AHhVF7c89E3X6YIMh0ik=
X-Google-Smtp-Source: AGHT+IHCE09DgSQIAQNMeC6Xgt8Fp1vPW/K6E6l/0fq8qf59aS2zisvYPzoo61Md/v1IKp9JNwO6EYk7GDcvVSUt6hc=
X-Received: by 2002:a17:90b:3e84:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-301bdf86158mr4441196a91.16.1742386132604; Wed, 19 Mar 2025
 05:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-2-adriano.cordova@canonical.com>
 <CAC_iWjJ=+dqqVen8b6NfsUx8-NpkzOeYbq4UG-LUcf7E=88jwg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ=+dqqVen8b6NfsUx8-NpkzOeYbq4UG-LUcf7E=88jwg@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 19 Mar 2025 09:09:04 -0300
X-Gm-Features: AQ5f1JoxaJDU9Xi5KqhXT1kxScSqFsKRWw7rxVvl5vWE8HtksrzLRy6CkTw8ENs
Message-ID: <CAMGU2hWYCA+H0Pa+d5KUFCEXxp4SB_pOj-b9uNH9RH89x7Nm0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: efi_load_initrd: provide a memory mapped
 initrd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El mi=C3=A9, 19 mar 2025 a las 6:28, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> On Tue, 18 Mar 2025 at 15:23, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > U-Boot can pass an initrd to subsequent boot stages via the
> > EFI_LOAD_FILE2_PROTOCOL. The current implementation only supports
> > this functionality via the efi boot manager: the initrd is taken
> > from the load options of the BootCurrent variable. This commit adds
> > support for registering a memory mapped initrd, e.g. loaded from a
> > FIT image. For now this new method takes precedence over loading the
> > initrd from the BootCurrent variable (if both are present) because
> > the BootCurrent variable is not cleared on exiting the boot manager.
>
> So for this to happen you have to
> - Invoke the boot manager and eventually have an entry that eventually
> fails
> - Load a FIT image with bootm right after that?


yes, or just exit from the efi application launched by the boot manager and
launch another.

Thanks,

>
>
Looking at the efi_bootmgr.c , removing BootCurrent on fails seems
> straightforward. Bu I can live with this for now.
>
> [...]
>
> Thanks
> /Ilias
>
