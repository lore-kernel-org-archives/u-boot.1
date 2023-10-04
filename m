Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5ADE7C4E9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7B68765A;
	Wed,  4 Oct 2023 19:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilTekWHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31818763F; Wed,  4 Oct 2023 19:58:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC19E8761F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so18991666b.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442325; x=1697047125; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VXRBAOxasKaZPLvza8ACdxPleWj5dGgB43G2mzT6j4U=;
 b=ilTekWHdx+4rpVKrOiRY25mi7XoJERF2V43ZxlgHcEN96UkYcDpyA+QwCRPC7iEU5n
 h/QD9kcB3bsQP5zprjtZCUmlmdD8VVWgGy2a4H/k6T8kRoA+sRZIepYUzs93iiAefTg7
 sx0DZ7gKHWmDIVM97HtwPmYlUJR2YO6awPS3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442325; x=1697047125;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VXRBAOxasKaZPLvza8ACdxPleWj5dGgB43G2mzT6j4U=;
 b=e874zSeVT5gbhAB+wItNYxA1cv7sE2ZJ2JXqaXpj7lAPMcOaa5RxIRZqXeNCSy4al1
 xnLmlbohje1IzO1zw7lDrZaxM8sHJDQu5wSW+guZ63CeCKKAtbq6D4wlQFGy8ihkOVgZ
 1CWwOwZm7fApax4HsnTFJ6lfV9p37ff76WeISovb69Y1cCNGAPHlE1X59E346vTJkX6/
 VQm3d7QjrU1cr0rtR79FoEfz1Ifslva9GBvlGDOiF8UDm8RDJe5btba5xdLtOF+swYGO
 fUj4xoRUQtTAsxhpR9m2Bvokyvu1zlwNbuRkoV3O9jcTqPtvEWTN9Y6CNem0VMiGYj9D
 hU6Q==
X-Gm-Message-State: AOJu0YxOYrzsPsCHR6DanVReaYpTX0c+aYRQTD+SGB0Nt4JpRg6A5jes
 rk7KUzLw5xQA7kv6Z3SfjXt/gC+QcsMRHmuKcWcAcg==
X-Google-Smtp-Source: AGHT+IE6M1ZCQZ/nRcn7PcVLTR9LOr2brMKXU+x+FZ4MnJWYxfWpUS99YbDaNq1GsLf/0zA9JCnd9BwWMg5bpAbWQ6A=
X-Received: by 2002:a17:906:5a6b:b0:9a1:e8c0:7e2e with SMTP id
 my43-20020a1709065a6b00b009a1e8c07e2emr2558088ejc.14.1696442325438; Wed, 04
 Oct 2023 10:58:45 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-7-sjg@chromium.org>
References: <20230923194424.1739224-7-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:44 -0700
X-Google-Sender-Auth: YOBaL0PqEioqaX-juHpp9Foh5e8
Message-ID: <CAPnjgZ3QgcBTw5ckef68MTzOspXYRST_ia1wz45enNtdoEaQvw@mail.gmail.com>
Subject: Re: [PATCH v3 06/27] moveconfig: Drop check_defconfig() and
 update_dotconfig()
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

These functions are not needed anymore. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 62 ++-------------------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

Applied to u-boot-dm, thanks!
