Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FD8E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55FCE86D9D;
	Mon,  2 Oct 2023 20:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pG/j3XDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79BC087171; Mon,  2 Oct 2023 20:56:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A11E0869C8
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99357737980so6386666b.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696272995; x=1696877795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Or8n2ePl1zakLo6izef1OHQX5nhjlmudeHdTeBvb0EI=;
 b=pG/j3XDypqj/Z9ziU2gBMSsN3l7AVh+tAPJYIqbGmHtwnGGRDUcvYC0ZAGyIe8qJAy
 hjVuDeNpcRUvLeoXtDAe3R0sxETcc0GfJwhQJjET1+/0Pml8KwZyQlkm3mhZJ5WLWUKn
 wWJfUUp0OS8pHOagQB1EhrAGiaWzH2WQ67Zk80bUaz0j2a0obQunCyuKfbdaOXBBfveY
 mAiSu40kSaoJ22sl1laylvSVg2rUF6R0Pbr77oo4RGvN2y1cp+sMJEyD+YWET+oGWY3B
 9iIzcnaE6Shzi4yCY5s5ZYgKDVuVufa/r4driMF26AK7a2z5so8bdhm7dzJpaF+PRQZ+
 R7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696272995; x=1696877795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Or8n2ePl1zakLo6izef1OHQX5nhjlmudeHdTeBvb0EI=;
 b=XQwPgDdDVg6eN1baJ0W2uxlyBRduMB4h/1kyo6NQV8BTmYuYHJwewvkw0mCf7RnsNj
 ysceoEgnmoCbxi+bTUVZfC8fwpqKcJPdNmwgipiYy/YKFlA/MzQGAmzUVPmVDHA++e7z
 CG0zsrOq03K8kwIvd89XjcnSWifWyCCJSR4NDDiDbDwj2ZlpGAI776kY/TC6DZTTApH+
 9K6PKsGcOoGFdxmTeciTZAekBYhB0TRunIRb1h6F9xc/CH2vA7+UVzFgeKmuFdM/N/84
 eklYXYDKEBhLrLm+XycXKUd42WSaI1dI4EGYr+fzPO9j5xuGNi10zhQmuwpNNAC828fH
 tbpA==
X-Gm-Message-State: AOJu0YzeXzkWLwqeVx1BWDeLKOAKauSwqd52Y1cADiZ3L+bz8G4J7gSd
 BNFu403vj/75mpatIuIjdY2vT2tga58nOcNst7ebqxi+T4PezgDTa08=
X-Google-Smtp-Source: AGHT+IHvAeH9c2QERTy8bmm7L4saLR4Goxv7CFVySCkpRpgB6TBpj7F3RhKpU6jrlylStX4e2O9vuWcojB6DEZUPzHI=
X-Received: by 2002:a17:907:7786:b0:9a1:bd53:b23 with SMTP id
 ky6-20020a170907778600b009a1bd530b23mr11905304ejc.14.1696272995052; Mon, 02
 Oct 2023 11:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
In-Reply-To: <20231002134621.94786-1-miquel.raynal@bootlin.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 2 Oct 2023 12:56:23 -0600
Message-ID: <CAPnjgZ2ev-4icbQW-TiYc_RdRB7zqb_JkC1L23=40Boj9A0oWQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] cmd: bind: Try to improve the (un)bind help
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
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

On Mon, 2 Oct 2023 at 07:46, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> While it may sound totally obvious for the regular U-Boot developer to
> get the parameters of the bind/unbind commands from the output of 'dm
> tree', it did not felt straightforward to me until I was explicitly
> told to look there. And even when I knew the command, I did not make a
> direct link between the arguments of this command and the columns
> returned by 'dm tree'.
>
> Several of us lost a lot of time because of that, I would like to kindly
> help other users by slightly improving this textual line. Unfortunately,
> because of how this string is used (like within the 'help' command) I
> cannot detail much more, but at least the pointer is there.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Resend: no change.
>
> Changes in v2:
> * Moved the details in the long text section as suggested by Heinrich.
> * Rephrased the help text as well, not fully following Heinrich
>   suggestion, but taking inspiration from it.
> ---
>  cmd/bind.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
