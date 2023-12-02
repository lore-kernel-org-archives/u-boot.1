Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FE2C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4043187675;
	Sat,  2 Dec 2023 19:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H3YD3u5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A73787651; Sat,  2 Dec 2023 19:27:12 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801D387675
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5cdc0b3526eso26753797b3.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541629; x=1702146429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aXdtIfkkZEzA/lFm2BPm7fIY544VCBnzf+haE7KtrnY=;
 b=H3YD3u5rYwivxKBsvuQKF2fVb+PbRMMp6zRGs+E0GeKKiDYHDpu3LpfEriAnXOaW0D
 ezENtOK6Nce9wb1b5rBvp0AihnjjCCnVYvrl9kVItQlllsZbWcfpyP5uzUetCGp70dbP
 sU+VqsSsRlIPBoLaiGRFGQeLrCpugNIt9lwrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541629; x=1702146429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aXdtIfkkZEzA/lFm2BPm7fIY544VCBnzf+haE7KtrnY=;
 b=oQ36emYl5sKxcGVwgysenNp1yqGPJmKFAGcM55aYLoHzmVzfbggunFvgAEKUZu5Uyt
 ObT9yiYJskcn3mS2O78bMmvp3UvijwlnMZHMObSMH7X50wAq6OmxQHp2Jq3TOHjJ0kNF
 Xqu3WCHO8ltG+SdxVZDeS7J1R+LQy01qEDaRgvgalRA/j8TdJla9hYLhI7MF78P6nRKJ
 pKe6h5mCRzTgu5eJJnV+SaKdRXgKwlv86RLGoo+hJboy4r/C2lY5PyozK3UIBVWO82Ad
 i0tdjGJj+jmjgHXufWlBpqPLeOxS/Z2UinZYVI7JrhctHIquR3C0nJfutDUquHQx9QER
 iqBA==
X-Gm-Message-State: AOJu0YytXDnB8ITs8/7qw+CN64eO0Sdt2KT2mgv1D3GnO3ef5S0T7JkU
 aU5pASUMw2ib8Ux1p0FKE1JUBfRbrfBC9sam8AO6VOQn4pK/1Kt8XDKbdw==
X-Google-Smtp-Source: AGHT+IE9dXoXVPKYHzrLJG9vI9WrpfdDfMzUvKs8sRn+ah5rFOC7/JlH6eiriBEhi9TiTx+gKQ7mN/BAfGxb5zL2I+c=
X-Received: by 2002:a05:690c:398:b0:5d7:99ca:b57a with SMTP id
 bh24-20020a05690c039800b005d799cab57amr454377ywb.2.1701541629077; Sat, 02 Dec
 2023 10:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20231122225711.96464-1-pbrobinson@gmail.com>
In-Reply-To: <20231122225711.96464-1-pbrobinson@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:26:41 -0700
Message-ID: <CAPnjgZ3Rs7MjmjXiAMu3+EYE=KWdPq6qRXjQmGtDKYw7LAW2pA@mail.gmail.com>
Subject: Re: [PATCH] doc: Remove README.sha1 file
To: Peter Robinson <pbrobinson@gmail.com>
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

On Wed, 22 Nov 2023 at 15:57, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The contents of README.sha1 only refer to process around verification
> of the pcs440ep board firmware in flash. The device was removed in
> commit 242836a893ae ("powerpc: ppc4xx: remove pcs440ep support") in
> 2015 so this readme isn't really relevant anymore so can be removed.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>
> With the wide deprecation of sha1 in general we should likely also
> review the use of sha1 in U-Boot as a whole and look to move the
> remaining users of sha1 to sha2 or sha3 in general.

We could start by adding a warning in Binman when it sees this being
used in a FIT. I suppose we can't really disable the feature in U-Boot
since so many images still use it?

>
>  doc/README.sha1 | 58 -------------------------------------------------
>  1 file changed, 58 deletions(-)
>  delete mode 100644 doc/README.sha1

Reviewed-by: Simon Glass <sjg@chromium.org>
