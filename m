Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D70E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A538722A;
	Mon,  2 Oct 2023 03:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UUQrYC1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46169871E1; Mon,  2 Oct 2023 03:22:12 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D35870CC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-538575a38ffso833584a12.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209724; x=1696814524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6GnYl5Lr4vdLP3x8z2SmSUElXmcop+Iy64L/oCutAuc=;
 b=UUQrYC1Vy+hLXFlU1UuqrHUDg+7UCvDex3Gj12QJw7vPHy4cxKUZgaTQec3NC4CWGx
 0+rEwNvwwii5TIi6jKNOhWJUPkCCRT32uUigxoAXOfjCQGfRv4Jj0Vt9oP1ZyoHNBR0w
 noROUDZVaS1E0LswdRqaGNBRun0FPXxa9zPBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209724; x=1696814524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6GnYl5Lr4vdLP3x8z2SmSUElXmcop+Iy64L/oCutAuc=;
 b=Q5k7nMG+t4kK+MuRvcb1v3yq1AnDAjbTHwa1tZj1E3zc7vPI6kbyR4Yy4KVebn9hb3
 OlHK4Zi76XgS0S3QwSYsg/o51O1oVkCAMfg96oU4xG/2gXRUYwj8QlaMY5oQkVcMj7p2
 t/WoHGYMVmbHIaah51O+6xEadLKxBLUc5NJ/mw5WEc234AszA0Y2KivoIyWd+K4A5SOv
 pCL9HhlDEDrPv7r27fsaullkZEsxhLPF7m07cVpOKHEU5TpV559NoRv7PfmswdXxIGyf
 Fhh7XfqTelplTvHR482eDfbkkpWCvhlsfuBlPj9gOpCX0VIqfI+f4pPeaX7FLt1Jb7//
 kWhA==
X-Gm-Message-State: AOJu0YxR8f1nUfdmaMBcXB2aW5e3V3fntUXcmnp4FMGu1D/HnoAZreHv
 uWw+y60nX7f1yuH6bobs50HiyPXgHDMiok78jMbRJQ==
X-Google-Smtp-Source: AGHT+IGrmgdmT66aF8ir5x/4bniLklHAGMjhXtgKwr78kFRrOg6D+yVuoVXh1BpZpuUaxfxHgRTx3pWkP5d6iuuXhxE=
X-Received: by 2002:a17:906:5352:b0:9a1:c44d:7056 with SMTP id
 j18-20020a170906535200b009a1c44d7056mr10049837ejo.26.1696209723721; Sun, 01
 Oct 2023 18:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230930204246.515254-1-seanga2@gmail.com>
In-Reply-To: <20230930204246.515254-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:54 -0600
Message-ID: <CAPnjgZ2ngp=jqEyvKM58QkyxHVti=S=Zi-xunfK7eU4bJ91QeA@mail.gmail.com>
Subject: Re: [PATCH] Revert "fs: ext4: check the minimal partition size to
 mount"
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tom Rini <trini@konsulko.com>, Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

On Sat, 30 Sept 2023 at 14:42, Sean Anderson <seanga2@gmail.com> wrote:
>
> This check breaks small partitions (under 1024 blocks) because part_length
> is in units of part.blksz and not bytes. Given the purpose of this
> function, we really want to make sure the partition is SUPERBLOCK_START +
> SUPERBLOCK_SIZE (2048) bytes so we can call ext4_read_superblock without
> error.
>
> The obvious solution is to convert callers from things like
>
>         ext4fs_mount(part_info.size)
>
> to
>
>         ext4fs_mount(part_info.size * part_info.blksz);
>
> However, I'm not really a fan of the bloat that would cause, especially
> since the error is now suppressed. I think the best course of action here
> is to just revert the patch.
>
> This reverts commit 9905cae65e03335aefcb1ebfab5b7ee62d89f64e.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  fs/ext4/ext4_common.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
