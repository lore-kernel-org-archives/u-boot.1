Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F7CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF6688E6C;
	Thu,  3 Oct 2024 22:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OjtQ6fX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02FF88EBA; Thu,  3 Oct 2024 22:46:10 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8702488DB2
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 22:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a99e4417c3so108931985a.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727988367; x=1728593167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+nCXug/YwK7H9XMirG1nLKRtZqUymDdab7qd32sSpI4=;
 b=OjtQ6fX6EErw2i7LgNE0cW3uVk5ketae8gntbts/ch9wE/HLtDvnOZrLBemQN5otUi
 wCZELEtQWtZgozv7lRudHKKj2FRnSmHoj7PwflCvC7Ly/dTcu2PvOYdrjPl3IGWoawmO
 JkBA0On5RG9NLAJ8N+i12wxA8vV4XYUXE14yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727988367; x=1728593167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nCXug/YwK7H9XMirG1nLKRtZqUymDdab7qd32sSpI4=;
 b=K3SvL+SQ/ucakboI0lVDYF66LG/GNFbjELiRyT828UBXjj5s8/09VIQpgpKDazDBA9
 Eq8wTtgs/w2CItf5xcAg77NlAx7pBsdft7mE64VSKMJM5zPsXofBzwSz3TDNryeJJWDE
 rlMha6PpY3glMnzFghMhDvhV0h1rdxXWAkQPazhHDNZj2JgfmOrP2GxleIC8Jd+FRkoK
 L0DwXrd6ZpR0v4tZY4eLyQ+K3bOSZTU2g/xO+46FQBwUkQKuQYJaaF/zwZRBI2ipzWlj
 S65LrKJiERb7FnL1PFRm6Skd6piVGLy6Q/522vWtffRJprLhAx82ehi4cYFj9NIYjtlT
 2HRg==
X-Gm-Message-State: AOJu0YzPHQxAyppxkpsEA9sgKOnMwJla3gfR3l6u9fFW5RGd0m9FwPza
 QS1pcdSWKmLs6vwgcOisQ9PwBPtHkyPLhLBh5VzYb8bczWqRrEdMIUoAPbasDJ/bydJjKqoqg1o
 RiaK7epHbmokMDAEMSOTjXAzc7JAdfjUFtp6I
X-Google-Smtp-Source: AGHT+IEQTDbf5eg+7VG5RttEmI1UrrLlCC8nNh3A42gsg9FDetSjS0g/4vlEWf67zjm0onE/TASbg3AnBhWj4NqjjfM=
X-Received: by 2002:a05:6214:5d06:b0:6b2:de80:2be5 with SMTP id
 6a1803df08f44-6cb9a30cd17mr7759536d6.31.1727988367319; Thu, 03 Oct 2024
 13:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241003142030.1610222-1-jerome.forissier@linaro.org>
In-Reply-To: <20241003142030.1610222-1-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 14:45:56 -0600
Message-ID: <CAFLszThy6TXhZ_fkgsWyoMmK_F3ciC_CV=fd3KULjqQuRPuVzQ@mail.gmail.com>
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 for CPU_MIPS64
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Alexander Gendin <agendin@matrox.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, 3 Oct 2024 at 08:20, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> exception may occur. Fixes an issue found on malta64 with QEMU:
>
>  Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>  31                      if (!strcmp(name, entry->name))
>  [...]
>  ld      a1,0(s0)
>
>  (gdb) p/x &entry->name
>  0xffffffffbe04b0d4
>  (gdb) p/x $s0
>  0xffffffffbe04b0d4
>
>  $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>  4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
