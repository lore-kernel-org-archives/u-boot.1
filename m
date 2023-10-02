Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC027E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B2B870D3;
	Mon,  2 Oct 2023 03:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AnZtsE7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFCB87135; Mon,  2 Oct 2023 03:21:26 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07230870CC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f6492b415so34880387b3.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209682; x=1696814482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CN70mK7juglKiGHj1k3579imvxowVPrzUAaoBPC4l3M=;
 b=AnZtsE7yvqAg/lKVeeiMITq3X8HY2McokErIACsDmGlCqdwzECd8g+FDW+aXWUdYIr
 Tc4iGggmX/U92fcycIFEJDR6ejfDOFjtF9wFXwa97004TUL1KHaRnB8d5OccbjnWmlyM
 bwrJZFCLF3WIdfBngE3w5p+n69b7P0EnYoziM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209682; x=1696814482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CN70mK7juglKiGHj1k3579imvxowVPrzUAaoBPC4l3M=;
 b=BFnGp2GAg816ZQhE/p6qCuqCepZlSfNYHorxV1jXPaIDrEv6F2UPRRlPuwVUfa0EKR
 eFFjZjGyZ3cg/DebDmfB5hBnvh3VARqU8bYDt/bXOkJwJliZ0EC/f6RjnG9yoz3bFKVY
 JLSauuEqbc68VXvuz/tOD6kt7jZOmuDcCqCk1ksvKcbkuvnVIZULnmvkTA0aY6qwLIEB
 tJLjyjS62saV568SC7B6H4iBIZvkuWWs6wyZPZvRKVvAwTFBX+Wydhzvy/EcJcQmGn07
 K5Br5Uaj4o0TP9PeAw7Eu1H/UiR/hPQrzMmTsXXVCNI4c2ZL/EWvKhMeAFQ6t9RtdKeR
 99gw==
X-Gm-Message-State: AOJu0YzvLRkqT4KGMdZocjuYjoLgKM/wrTIFyJT/X7xi+1O61g4XJkIc
 BiicMPXM4ha/82o8Ch1Zgaag6/39IzVT4+2Gufd64w==
X-Google-Smtp-Source: AGHT+IFcJTijFQfOhAH++Jm4VooaSz2jjjMxP/ITXdwLflWV8vJ24wPpxwOwml4S8mEWOezM0Vx1qd2eljiZPXDm2bU=
X-Received: by 2002:a0d:eb86:0:b0:59b:e743:630 with SMTP id
 u128-20020a0deb86000000b0059be7430630mr10836754ywe.22.1696209681950; Sun, 01
 Oct 2023 18:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-9-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-9-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:24 -0600
Message-ID: <CAPnjgZ2i+Q_VgsN_=civ-Wurpei-RbZc5doOoHbHuk9kEbwFMA@mail.gmail.com>
Subject: Re: [PATCH 08/15] cmd: blkmap: Make map_handlers[] and its .fn static
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 02:52, Bin Meng <bmeng@tinylab.org> wrote:
>
> These are only used in cmd/blkmap.c.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  cmd/blkmap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
