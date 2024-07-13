Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B829C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D6D888C8;
	Sat, 13 Jul 2024 17:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ay0rb8J3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD24887E13; Sat, 13 Jul 2024 17:14:33 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2A9888D2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fbc3a9d23bso23064395ad.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883670; x=1721488470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3hHOOb6stFATS0iH0Hi5hg/Vn0Q61MddQCQRRNMWw8U=;
 b=Ay0rb8J3yL1H/iXg2dNOpXe/dnT0X+DH5Ejr7VqCnbTBO6+1LB+X90vZayWZ5pKOdg
 F0c1fr1AmcZeNYdoCaVtN7hU2BdGwQNsUo8NYZKNkHcLHD+wgukJHtSMUzjiZSOlkRfU
 T556tPgfVsfvbiGLVhQs7aCj5hLSJUNBLEJYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883670; x=1721488470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hHOOb6stFATS0iH0Hi5hg/Vn0Q61MddQCQRRNMWw8U=;
 b=U+A82qQI7GaAbQVyOC8ss6NCTFzL82XYlJImBfY18ZqtOZDnojbmbjcIoABVYKOIqO
 4OcuTp7+5KCKVYLh7XIY8T6vUsd5bsfGkyhvZFhZU5VpTMsS8dYYv8yaVMFXjLUOxM3l
 nSST2nz/H5T91uR4J/1ZCgN2z1/ZmmVyGAAhzedK/NA0M/D57og3SzGdby3uFs0f7Z2P
 2el+Q8LwdX/GRnfFvZtMGlC81SlkqKRS7JIksj6tjW34ywlLsUjtyKkyVyMRf8gn++fr
 SJEuVX9ubEwS6KgL0FgmcGxzPv4YyIQwIhdemlzPx9rnRVrK1Yj5BObkYqYH/sy3sBeK
 yYtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmnT+pEYkG/VgS1++GIK6PhMbzJ8mNr+4PMLnZZgFswQ9duVexKPoCYUOhMDfd12U0QIGEKJiwwCkQ09yzyehIUMcTdQ==
X-Gm-Message-State: AOJu0YxwuD0MEkAQPrSRPb2RtlcNfoN/h9WgXz/E0tLgfE+Hnx3mKF/9
 PmBybwfrMgCjyvhKcJL1xJF3OqCTarutnmOInZGG30RybaCW3yEjKuhVPhyHjBmVfjPEFmWEe4c
 gKfcn5USKbnG/0AsBu8tMZZvsxzkWzEv6cMry
X-Google-Smtp-Source: AGHT+IEx3vLBmI8eiaqainkGOP2P5ZrUWIt+wYFoZ+XZZccduhcnWkCDSrt3Y8UnOmQho/VQqARx2GLR2lzrBIPY3Sg=
X-Received: by 2002:a17:90a:3d0c:b0:2c9:8161:dfc7 with SMTP id
 98e67ed59e1d1-2ca35d58fe5mr9774994a91.47.1720883670103; Sat, 13 Jul 2024
 08:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240708164812.1205697-1-sam.povilus@amd.com>
 <20240708164812.1205697-2-sam.povilus@amd.com>
In-Reply-To: <20240708164812.1205697-2-sam.povilus@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:52 +0100
Message-ID: <CAFLszTj-GTrA5-Nnx-3aR13KJKCF6hJMnVitkT2QOWESx46v7w@mail.gmail.com>
Subject: Re: [RFC v4 1/2] doc: Remove FIT documentation that is elsewhere
To: Sam Povilus <sam.povilus@amd.com>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, u-boot@lists.denx.de, git@amd.com
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

On Mon, 8 Jul 2024 at 17:48, Sam Povilus <sam.povilus@amd.com> wrote:
>
> FIT documentation is now a separate project, instead of having a
> duplicate, we should point at the other project.
>
> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
> ---
>  doc/usage/fit/index.rst              |   4 +-
>  doc/usage/fit/source_file_format.rst | 682 +--------------------------
>  2 files changed, 5 insertions(+), 681 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
