Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F10C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 12:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCBA87E16;
	Wed, 14 Feb 2024 13:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PC1txybQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8409787CAB; Wed, 14 Feb 2024 13:08:33 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7427187E18
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 13:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d722740622so8307515ad.0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 04:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707912508; x=1708517308; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEQtB99t9LGCVhoFS/QP6xDlkWwOZsa5EPtsTHV6klw=;
 b=PC1txybQqQXeaKW86YHa4nMF2F1YDvf6ZptGnAS593GKnRpa0qq8xtrzooyYETF3Bu
 qD+Qdz4sSK5L7z8R5XPy+Z5qxS1ztus5u/RUItqNHGT0ljdTgyqfm9zXqdjoZxxxrYVP
 fuXdFxx95XRQxM3nnvaN3rhJQk/BSHUeJ5c9ZBOW9AoQ8FTnSSsVVPW3nBH57Z8ECrqJ
 iuvW+HnMR1ybsKWwyMNTvlggIHAGwSR/fjYxDsuOwOdbSltA7t/+gINXqFczlRioiudb
 KnhiowVuFSxenhrwkkV52iIdQdrj7R73aq1nlu1lHMBo78hMjIbMoIKluaj2PLYEnp47
 cVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707912508; x=1708517308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEQtB99t9LGCVhoFS/QP6xDlkWwOZsa5EPtsTHV6klw=;
 b=JRha0DVX/2Gi4iTY0GWlubulzvHZpb2hxZgRlInEc3qyLAd4bd/C5GlbnuYoPu4Bop
 oOmIwVEJkiGm5fCeqCOGLYSpoZdiwHcAEElegsmDO7kHZNyChpnCr1uRAaiB5f2pY1ZI
 bD8FZudLtU43WKjZ5gaXIJBQCVtLLRMN7uueExC79fpF7lY1STJKT44Ga2HpLcsKjxia
 oPzrTz3F6E+qznODG90EDtTV98ku5hN+Vmo3oFISwaGc/6G1NUvpV2Zw6y2PEXI84laV
 Qmi8/Yfz4yHFMtOAkgsFLpcHzTOOJJ4tmmKAyKUDAuObX0gG2+/PQKj/48FpKgjxsJy7
 S7Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/cS842Nuc5u/Sefu0RC6JQ4St3xA6BjGl0OGC7Y8dHHgWpI8IHJU0ZYifNJCALWgF0PB3lNdab2X3cJ0uHKTt9DWWVA==
X-Gm-Message-State: AOJu0YwUqFcbg1xOROtffXRKOz/tM3Ix+ug3kv4p5ehZHKF4vcqeLguU
 O7Z+d1F8lCuhkYmJ/Z+H3f4U990OlnS6e5sn4bVH/llm/8U1baK/Rav1ZBOi6wOXYb98Y5agtV2
 KOuJ7QZj9ZOOxCEdZjbGVP8vrRMs=
X-Google-Smtp-Source: AGHT+IHcE7l0ldZSm76hyG1k+eJmhm6s3QlFDlCKnzi/10pykUnIrW7gkP6yWqobCGOiQkFy0QTgdGASQvkBhDqhgeY=
X-Received: by 2002:a17:90a:7406:b0:298:bc90:3b69 with SMTP id
 a6-20020a17090a740600b00298bc903b69mr2069187pjg.3.1707912507792; Wed, 14 Feb
 2024 04:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20240213172226.151181-1-frieder@fris.de>
 <20240213172226.151181-3-frieder@fris.de>
In-Reply-To: <20240213172226.151181-3-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Feb 2024 09:08:16 -0300
Message-ID: <CAOMZO5DZfGZRp2EVPk=LpKmXT8B51guNVFNmbGrS_xcu+aUbyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, Feb 13, 2024 at 2:33=E2=80=AFPM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Describe how to build and boot for the Sielaff i.MX6 Solo board.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
