Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56120C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D6987239;
	Sat, 18 Nov 2023 18:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ElaW5DZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75BD586EE5; Sat, 18 Nov 2023 18:11:49 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A508487083
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-da37522a363so2917560276.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2RgH6RYysm6oayr3WdViC9gL2AS8zRtWba6rmFAs5wU=;
 b=ElaW5DZyCgv5Hzir8nopS4/Wnh3xEJWj2tVzZCvjavgd3JMkoFHH1JVFp4TmmO1ovG
 /Wq8ONOn/hunfbZqvDJ1p6Rwf7fNnht5rmyqFiOVrou494NUAEmXvO0TeOOAlVc42pr9
 mtOF+Cq8+c+sCG634DT11jysHluk0Tg1BTqHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2RgH6RYysm6oayr3WdViC9gL2AS8zRtWba6rmFAs5wU=;
 b=auU7V3K2RqT4H4tqo+HkrsybvrxXexM+nrJ81Vj6vOOqDPhP9ORyYlxzDvxSdtpnbl
 EWjKBvJAhYTOaKGG+W1im7QQfQU5UMPN0/e/Wd4QpU1b9Sv68ghogTiBygSvGdD/5MKm
 qWE5nM81WnLEetAyWc5mN/IEJbnu56MaiipJfMVWbVWEFFRz/7fBf+47rDfjVBtfYTtl
 ONi9mX8w+yoy001ENqctYX/VKHBlqxxa/oo/JJPbk0gztGPeKjASZIW3/7CQkBzB/Km6
 jnehd7ZCo7DlZ9f8R+31c4eIBfM83C/DfnZLiKAJtI4vOf8nN9odKQNQNCRjN9/q4+Kp
 tZig==
X-Gm-Message-State: AOJu0YzxVQJGqmm6tzDFnNFyijOFNJIJyTkE/OvzW5q9G2a405oieLHJ
 XLvDGqK1Uks+dW/y3S/BHlLkZYsYVAVkYmFWRRXtBShlXHn08GTyVXo=
X-Google-Smtp-Source: AGHT+IF8nQ7dtAdAY8T7FhrmgEPVljoeHiKir+99abdGWeMflL8wxr3mGWrFNO+w2dXLixZPkwsAN4rAl8eXTbGhdyA=
X-Received: by 2002:a05:6902:c5:b0:da3:b87b:5b75 with SMTP id
 i5-20020a05690200c500b00da3b87b5b75mr2357625ybs.64.1700327504891; Sat, 18 Nov
 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-2-trini@konsulko.com>
In-Reply-To: <20231117225313.2144665-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:58 -0700
Message-ID: <CAPnjgZ3Wen41caE2M_yNXHyP4td__oUMXdKbrvS_YPZ9W1sFFg@mail.gmail.com>
Subject: Re: [PATCH 2/5] arc: Cleanup and audit usage of <config.h>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alexey Brodkin <abrodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uboot-snps-arc@synopsys.com
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

On Fri, 17 Nov 2023 at 15:53, Tom Rini <trini@konsulko.com> wrote:
>
> We need to include <config.h> directly when a file needs to have
> something such as CFG_SYS_SDRAM_SIZE referenced as this file is not
> automatically globally included and is most commonly indirectly included
> via common.h.  Remove most cases of arc including config.h directly, but
> add it where needed. Further clean up the tb100 board config.h file so
> that we don't rely on config.h being included there for a value used in
> a single place.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: uboot-snps-arc@synopsys.com
> ---
>  arch/arc/include/asm/arc-bcr.h |  2 --
>  arch/arc/include/asm/arcregs.h |  1 -
>  arch/arc/include/asm/cache.h   |  2 --
>  arch/arc/lib/cpu.c             |  1 +
>  board/abilis/tb100/tb100.c     |  4 ++++
>  include/configs/tb100.h        | 21 ---------------------
>  6 files changed, 5 insertions(+), 26 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
