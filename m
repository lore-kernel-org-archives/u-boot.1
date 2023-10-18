Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66585CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7975886EBF;
	Wed, 18 Oct 2023 05:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ai1PBWCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8285D86D51; Wed, 18 Oct 2023 05:29:00 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC9786B05
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so11033698a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599738; x=1698204538; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlyfOmSDQiE1PTiOUU97yoLcIeL57NOD6iwQQO89CeA=;
 b=Ai1PBWCIu3QIUAGgGCuRbC5AgvV/GeHHI5vyv97GvnRaZCl9MN9dd+u+BTqS/PYcL+
 zS0hFVrJ1j33RaEKdzULKfqJ7eEG7PHotsm41hNauniwWm8oV1CyHQ47Q0PZ7t0DvLf/
 HHA8NOONjHrZGY5qbvRgkFV4wHM08FmAri8BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599738; x=1698204538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlyfOmSDQiE1PTiOUU97yoLcIeL57NOD6iwQQO89CeA=;
 b=dg/iu3608D8euWqCmTKrV9zHSjAsby71gm10WOsOJZPBsKPz5O98vef0P+oP+nwuX+
 8S6Mlcj4Q2FCJVlb3lqlsgC+2N1Gp3G26uVz3tEJelru5BQSSXZkLaK2cjZh2weW/3rS
 bRJbJ0kXd6zf6v6qqgeT7y2GuL9IgmMct4g0+rQWz2ugEpA9CgA15Lhru4iyru8RkuEH
 SEuIaiaMbydDilCi3SIues5FJgzing0j1OQ2L8RKNGpF/OOgjvEKy8ZmBBA+KxRJwufy
 6vie7iWUODN8Z06iNDlYCYB92YmCuIgtr5e+zPjhyipup4JQv/FbUnhK+yv2XM40+azY
 DqUg==
X-Gm-Message-State: AOJu0Yw4xfyAX8hhHrzMP3C/8H/Fh/S6YlzqF1HgJZm9bBkyP4yL23XY
 XwUn/+0iYHSnibMAzsGdwFqNwi+kOcUqtwkpcSta6Q==
X-Google-Smtp-Source: AGHT+IFOzcczjKqq82fNLIoCcECgSweSsV2HNbRXtSbqSNLWuX75zUpJDLIaktSeRR6RRZI5ekrCYPjanuf409mMSxE=
X-Received: by 2002:a17:907:2d0f:b0:9ba:2b14:44f2 with SMTP id
 gs15-20020a1709072d0f00b009ba2b1444f2mr2696279ejc.73.1697599737516; Tue, 17
 Oct 2023 20:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231017194703.16448-1-mps@arvanta.net>
In-Reply-To: <20231017194703.16448-1-mps@arvanta.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:28:42 -0600
Message-ID: <CAPnjgZ3NDS6B5aY9iP9twD3RfvGQk9QvnVLR=PnH7Czg-Kxszg@mail.gmail.com>
Subject: Re: [PATCH] doc: build: update description of build dependencies for
 Alpine Linux
To: mps@arvanta.net
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 17 Oct 2023 at 13:47, Milan P. Stani=C4=87 <mps@arvanta.net> wrote:
>
> ---
>  doc/build/gcc.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
