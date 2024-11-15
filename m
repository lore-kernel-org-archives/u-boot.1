Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0096CD6A223
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C528989618;
	Fri, 15 Nov 2024 15:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R/TkNMV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831E389354; Fri, 15 Nov 2024 15:21:11 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A36F890B1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5ceb75f9631so2291283a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680469; x=1732285269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rLm+akBzbqafMV8of1AHDtMY7WunUYUrB74B86dYb/s=;
 b=R/TkNMV0KQ9VPIOYXtEOH5KvGT0qj+WJMKTe2yCMSiy15agtR2kMFwQGTMbhQ3Bxpe
 aGyhRfP8xpX9G6vIKPfcqMrpcDjTFnyXrGHf+A1fdvi+Vkb1aSmzePNTNFzcr/5lrpMB
 Ik3Rqj8da9PrOziT8ivlIT8HObgKhYBQPvYkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680469; x=1732285269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rLm+akBzbqafMV8of1AHDtMY7WunUYUrB74B86dYb/s=;
 b=gA7LJXM0IQBpXvzRSy2RqVKzv/oPiEltf2H/kXqxIb02iiHHjNfpP4l2uPqS/Ny2eN
 uV4KQMkeJ7yTGVxHQKVvFG1DCR2ELbhgslPAGNphaqFRjDBFc6thrxQtWnY9EMc7Bvm2
 LPSm37SweShfMt1ww50MR6r1jPUDm4IgQrQm1BiEugF37PrcsIg+v5OfmOlnLqvn1qL7
 pgUEFEzXyn3TwQxJ4UGg++djGrNFUbsxIbl6lUrXIELGIajTtgkH5cHyxDfaelkRiq2s
 6xzulAdbIMHX1yTPdzNotJanoJ/F0jdCrd3/KO0WZm15onx2XDJIWrLUJra8asuth1w5
 6q1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ68RHhPkCksEmo5JUMNowovw4LihINjLTeHlFJHQdh6y5OhotY37HWBXBBEr83qsyADWFEcI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5j6cjdsY9Jq5UMda0FbfjPhjRaEfx/wO65kF6c2ahaaPdZsMG
 C+1tENsMcHHqB6N59Ca8svS9We00F4KKNclszPsnYeed5IgQ3/yk/M/lKT3d2UEDV9c7Y+4QKM1
 zrryEeJMgcGu5NDJIhwDwpzV2JgqYCjyu7dSt
X-Google-Smtp-Source: AGHT+IEW1ICKhC2+VQMKM0cm48QAjVSr2pnmEAo9vujwGr4/llYy5Di0G6DYjzWZriZ8y46HEsQMYtHgG+hfAP6KBl8=
X-Received: by 2002:a17:907:7b9a:b0:a9a:1e4d:856d with SMTP id
 a640c23a62f3a-aa483422ed8mr239739466b.22.1731680469021; Fri, 15 Nov 2024
 06:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20241113211512.93184-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241113211512.93184-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:20:55 -0700
Message-ID: <CAFLszThZSqsgpb+8Wa2_Rb1S-GdD2gUkSDqq=cpOVT+oRFG7BA@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: unit test for hextoull()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 13 Nov 2024 at 14:15, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a unit test for the hextoull() function.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/str_ut.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks
