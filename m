Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1090C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537FA80BAD;
	Mon, 10 Feb 2025 14:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T2Oh/vuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62F380BAF; Mon, 10 Feb 2025 14:10:15 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6875C80C77
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa0f222530so7939156a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739193012; x=1739797812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9pK0N5DUdOLnGhrbNPzs+MZO9mqPHsPK5DGWu8fTlk=;
 b=T2Oh/vuZkI2uwx0z7ghP9v9+MyJIcXTAxG9yx/CT1GzGJTJGPDiCdQ6BtiOzakpKVa
 T7AdDjrYhXN+TPNZYNQWDUf7hsTd/Ci7bk7ymQMJt+doQxWZPuN02Zu8a/5e0cjpzvN9
 TGSdJcXvGA3/VWwJQueDDrbXRycTnnI0iW/9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739193012; x=1739797812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9pK0N5DUdOLnGhrbNPzs+MZO9mqPHsPK5DGWu8fTlk=;
 b=L1MejT9qMII5gu65TkduzCMmELhEg/N5GUIbdtwNZkBKwY3avk4NxpNdGYh8qyllLM
 d8B9xFcvuY622Qx2SgA7S0aXD2jGbXVlMpjASLP3Q3tyxMJCUgBBEP/k1xzUue+uTon6
 u+aPF2Qtei8zE6iXrdTLieaapCCxWZVXsWBv7S1emML9tfMNZTc1lWWxFBDbdyB93MRX
 s1GyIBJNpBoMCxgUpHB5R1t+TERjKr4F1Q24ZulJsEzQ5RgNSkqjSLChRY0FdEag+OK0
 UqnWpvvEyCI9lSrwTdAt4AnqU9I29jdf01DYe8pJA5FGD+ihan+jYoKv0SdYNm6/m1jq
 4GRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv4dWopK42OzYamrl8FegcfIGoAZrxAoGsY6j3dNMcVa+cUXbfdYKJmSSPaCYopFLQrMG7Y54=@lists.denx.de
X-Gm-Message-State: AOJu0YxE/dQAihhfoSmxYNxXDz6eedI16ZPogGc93GdFQYm8HbMpahCh
 c5lVnnVLiPheZBxwDMWru6BW3VG3zcqrU1kDc12Vi+E9FU9uq4UoFbp4L7YJwvaDgIAXYeLHWVz
 HpAAOcBBNVQR3cVkFVbHZQKkDQLbid/uHnm2R
X-Gm-Gg: ASbGncsHvq59a9EnYjBxjhhvdoEkma5oL7KqoWtuFOKB+lz/Ch1KL30XcKzzx4CakC9
 lS0oH6Qq0mj25kC8/hyf35dq2I7clzD7qWK/0P2DuuP29ytTiTD62xr07fZSE5mBDtBw9VnAhjw
 ==
X-Google-Smtp-Source: AGHT+IEMdje3be/4czNtQwe1YvsHI7HtufZxBJiNWvImuDm6LapumYnrZu+9XdrJP2rh6eOur2LwyZAVD3/U5XzMtac=
X-Received: by 2002:a17:90b:2b48:b0:2ee:9d49:3aef with SMTP id
 98e67ed59e1d1-2fa243db8d1mr17425828a91.23.1739193012030; Mon, 10 Feb 2025
 05:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-2-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-2-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:09:48 -0700
X-Gm-Features: AWEUYZkxwvH3W_AatHpAxrrJlvhsb5AAS6lQWG6lSat6rpe6Z8bgxDZedWmCznA
Message-ID: <CAFLszTjFvPMkWH6inDRO0kbgFjwwzBj56sYZeVa02xYFWC_u9g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] tools: binman: ftest: pass allow_fake_blob to
 _DoReadFileDtb
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> Some test cases don't use _DoTestFile directly which accepts
> allow_fake_blobs. However, they specifically test functionality that
> requires external blobs not to be faked. Extend the _DoReadFileDtb
> signature to allow passing that option to _DoTestFile.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/ftest.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
