Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA1CD54A7
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5CB86B0A;
	Tue, 19 Sep 2023 10:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eMTbeiBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529FB86B0D; Tue, 19 Sep 2023 10:29:27 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879A686A49
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so716939466b.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695112165; x=1695716965; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dtZJ0zMcSH4otb8LNr2+KwUjvqnT7vifN629n7S6J0=;
 b=eMTbeiBf+RLqW2ZJD0CeQ5bYoV1kSOgxUDz/lOcGEg/CLGW+tI1Bor7ub0pD+KFwPt
 6FirySqEBD8o6GrnqW56huRka+GWDhnlNcBm09rpRIiF4rvq6gx59a8rSGxqshQEayUM
 a+2uqs3NuQyNLVTTIJEJRWSBhbFupC3etE7pEqbNox8hAz0XH94bPFogAVBU4ULZICY2
 KRz6bI0o+uvggGGMB8u298zB9ycJDsxHuEneQaXkljKJkP2YeziDXCaV4Id9sxs1GK+h
 S2HdA9K8lURVEP8Qb69FLQMy/VU+SH6yNhk9gyBrjdEbtp/LeflABbX9o/i/yQlzPO+l
 B7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112165; x=1695716965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dtZJ0zMcSH4otb8LNr2+KwUjvqnT7vifN629n7S6J0=;
 b=LViFJ4VhDS0En0aMxFAnzvGvTFBHbPbmV141LIJQrELIEQ4QTheO/i5FM+AyM1y7ne
 JE95d7h2Kge6pCtAv+VPHkAuAXJUFsyE3EKrUc1zts+Ir/Ko9F2xFu4MpBTLsSKstnyF
 laDHVfaNslIc2vRgafk/0mZallEpvjkIySeEOXsoGHeeBHuYkM+xsb9Ouqu31kbp4IHS
 9Pl8Z6/hvADjnUF4looWYP8RQU3cDbxZKMCUFgXOCXDJGNcrY+YgxVfkWIlkM5cdDlgW
 DZwi3jzzQnzNTsBxOKX5510n/yC0GZ4rAzBAENMDwzx/qOytsRs8fLhP+2Yxp3Qxkh65
 c92g==
X-Gm-Message-State: AOJu0YxouZuk7A6aZoKi9M28tQmawCjMSLjXevzpQcxYEL/bdymzZnM3
 iq4GP9hm/742HsgQzLFntyMmO7fbQOU3y0u21PHz00TbToI=
X-Google-Smtp-Source: AGHT+IFJPYvXnnUFjBzUcVmVIs86hPKr8peGYkg5O3iWJkOJV+bmAao3HYf6AjCgte8hwT0NE9zb4t4ypwFtzZKzU0g=
X-Received: by 2002:a17:907:2716:b0:9a5:c5a8:a1a0 with SMTP id
 w22-20020a170907271600b009a5c5a8a1a0mr9581443ejk.49.1695112164756; Tue, 19
 Sep 2023 01:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230907155825.48056-1-sjg@chromium.org>
 <20230907155825.48056-8-sjg@chromium.org>
In-Reply-To: <20230907155825.48056-8-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:29:13 +0800
Message-ID: <CAEUhbmU5PeHkFk+nJipZXyCHKf70wJFEZM0uzThYcGF3sa=Acg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] x86: broadwell: Set up MTRRs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Sep 7, 2023 at 11:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The current condition does not handle the samus_tpl case where it sets
> up the RAM in SPL but needs to commit the MTRRs in U-Boot proper.
>
> Add another case to handle this and update the comment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/x86/lib/init_helpers.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
