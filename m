Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B0AC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB3087B9A;
	Sat, 16 Dec 2023 19:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VqhHQdxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F21F87B0F; Sat, 16 Dec 2023 19:47:03 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6431D8797F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ba2e03e21cso1371129b6e.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752420; x=1703357220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E9lf4mE45FrgAHEG7oNyvDQBnj39XGdGgfcuhfylVrw=;
 b=VqhHQdxq6U+lRy6EFpwkwtHbZqNDaLhzQhlun6MUkk+1cVyu4qOaUrrTeV7XacS2SB
 qga2AIN/DbnFlrDB3UCYc/nSsuXtVpuYQagglQ6m2PX7LTkKuBT6JJFYQJTp+nAHPnu5
 kujbLGXGwY3zL1Jxihw4p6KwNmeB7hoIRjPrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752420; x=1703357220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E9lf4mE45FrgAHEG7oNyvDQBnj39XGdGgfcuhfylVrw=;
 b=F/XnNPQyJUtMMGfJmazfk0uQc/WIPHj6B4BSubkyOp3ax86wjjDNcvYHeDkHI+18+W
 Xp1ttu9fYZV6OXlcFeNOBsg3IR2SnuwYNNyqgp56VBMvchC5Mo/Qg5quznEFAAfmy42R
 8t59CjDMB9UvPlV2X+9p9eWj0EyyNv4ML4FjjL6JCFJyediNcqGQsrWPdQwHYtShxy+/
 HgiKbnHv/hIYThmXlJlnJKne/E90IK+nfRjE0CyJHvEHieSgHAlgKPj4Y1ylBOKSs0lI
 ZbMIx/XRJg7qFwH6kKuZhVGA46ivrm0MNkDNu8X0OaaS4BrYaQ2+55iyKRm+qrgUx04s
 frKg==
X-Gm-Message-State: AOJu0YxIvm3ZOA81nl8I5fh4WfKAWAjU+jn6dEJBEGIZcBi9gl8n5dgL
 WIIqnlOAACCuy1nN70Dy6Km9BA95yIS6m3DmZHittA==
X-Google-Smtp-Source: AGHT+IHopLUY6G7f+doMtT+pjek/wnsQAECDTI3rROLE70KbfGJHF4yuKrcnqfuR5vP7ND0Sr/W1ikoyOg02qykVJ5g=
X-Received: by 2002:a05:6808:199b:b0:3b8:6fcc:226d with SMTP id
 bj27-20020a056808199b00b003b86fcc226dmr14420042oib.53.1702752419639; Sat, 16
 Dec 2023 10:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20231216154631.87789-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216154631.87789-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:49 -0700
Message-ID: <CAPnjgZ23Uf5C+qdiKstXGQ_qNpe97TGqWtQZo6ZGu8v+VMc2-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: CONFIG_UT_BOOTSTD must depend on CONFIG_BOOTSTD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 08:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Building sandbox_defconfig with
>
>     CONFIG_BOOTSTD=n
>     CONFIG_UT_BOOTSTD=y
>
> leads to an error
>
>     /usr/bin/ld: test/cmd_ut.o:(.data.rel.cmd_ut_sub+0xc0):
>     undefined reference to `do_ut_bootstd'
>
> Add the missing dependency.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
