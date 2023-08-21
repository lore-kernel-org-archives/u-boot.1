Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C094EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5194D8713A;
	Mon, 21 Aug 2023 21:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="w+A4B+2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F7886672; Mon, 21 Aug 2023 21:14:06 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E747F8717E
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d665467e134so3867175276.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692645240; x=1693250040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yu/L+djlD+CPcB9q0yOAPz1PAXFguPjWtncR67diLwU=;
 b=w+A4B+2ImsIyOfTT6oBFbRgKrHFXBdWPxXFbQLu2JjEbvKROKvFGkSVReXYiFom/Pj
 X3rpfaoqWauamAhvcrhX1OvOtszBOZH0z1j4am/FfMuNhg51Z2/VGjxJkxhJDTC9nosY
 CA3CeFsVXd5oFpSuNlr5KyD1xnog0KbKzAUJ1gEpE/llmb+J6HnWcUQJHRzCFocvsqe6
 Mt2I50t8B7FIvHaPH+eJVialRDujUjjPLlz+ttCRNxhzAzOzP1hncuP3yVCdL08w+DH+
 qjPEsCP/fLqXbeMk1S+Iec3muAJdfarHgNjvTPkpvnfneO7fCfERMIEXBZhazl0apalp
 A6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645240; x=1693250040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yu/L+djlD+CPcB9q0yOAPz1PAXFguPjWtncR67diLwU=;
 b=lh8QUigR0PMhi7SexKuszQtYcCjzbdkM+3Bj1InfBh5IB87vJvxdS/4X2oZxbbpZ8D
 xzyXFKQlNNEHNtgxPXeIY96B3bzBz0Z9RikFSYDsw5KJ4DV9YnvjYjCQ30vBdDR8bsco
 b3Fg5bKJ1msSy+oXpozxr0VXp2caTGHI0j6/crAhZiqUTZYKuVYP7DcuNjBKX5wcwnQN
 sOmaNOj9ncRiVM0BaOj7mCSs0jvE7ps8CBJQlkp6e17KvBdm+6i4lNTlqewqN5MOM/FC
 dJdr8nNUGJHELzUtRIHoU+dvw61253AqzkwUQDqkZ0n7tLNhAfm4N0TyW8dL98mrU4LI
 xV6Q==
X-Gm-Message-State: AOJu0YwYFZJkFXZgTCMdRLEv3OX8Ne5iRx5a+Oms6DUScfyZhziH7Q0N
 ggQkU/K1Lpqr88jje2p4yxZk3jBdJXkzdlHULVR18dXKgjEaik8lK9w=
X-Google-Smtp-Source: AGHT+IHn34PjeKbNJo9yHLQIUv+pAr3/qz3J3DxEyOw0BRC43wHmNKCAQiWU14vvyf7C/UerWeIM1GYWXjgBDyJB4s8=
X-Received: by 2002:a5b:d45:0:b0:cb9:41ad:8938 with SMTP id
 f5-20020a5b0d45000000b00cb941ad8938mr7140344ybr.3.1692645240493; Mon, 21 Aug
 2023 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230820173129.781985-1-trini@konsulko.com>
 <20230820173129.781985-3-trini@konsulko.com>
In-Reply-To: <20230820173129.781985-3-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 21 Aug 2023 13:11:42 -0600
Message-ID: <CAPnjgZ2JYr+eNwJsy-H6Xf3ApPdyAuHdCzDZM-m+uNvP-MZ6pA@mail.gmail.com>
Subject: Re: [PATCH 3/4] CI: Combine tools-only and envtools jobs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sun, 20 Aug 2023 at 11:31, Tom Rini <trini@konsulko.com> wrote:
>
> These jobs are to confirm specific build targets, on a Linux host.  We
> can safely combine these two build tests, with a make mrproper in
> between.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 13 ++-----------
>  .gitlab-ci.yml       | 12 ++++--------
>  2 files changed, 6 insertions(+), 19 deletions(-)
