Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613E6E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA028743A;
	Mon,  2 Oct 2023 03:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H5WcQoRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4BFE870BE; Mon,  2 Oct 2023 03:18:48 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAAC8727D
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a229ac185aso37442317b3.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209488; x=1696814288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PHkVOHWwu2NktbxFM6xxqf3A9p5zYq6uduiEZj1hBEU=;
 b=H5WcQoRWrr35XiSRBW5X23owJIBb9uZYRKINjmay9hkO30FmjDrjDGRDUlRJE7RpvI
 zxcEA1SfMzVwoAIICcRIowcCHQiFLHorZuSFBrFAc5Mtj8TFxdhd9VUfYac8tZVxlIR1
 /xB3UeRLVsM7AIGPFZJ7vEVF9RBBF9Hv+b3Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209488; x=1696814288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PHkVOHWwu2NktbxFM6xxqf3A9p5zYq6uduiEZj1hBEU=;
 b=Z2coIMa8IeUFUM82ufjVB5HIL5NAQViYn9Qhu2GzcfL9Y1BHFQxHPuQPXxnOoPVFol
 aNC/nfr3ZvxHDyj24qn7oIXIoO3T8wq5uV7J3fZcxaBCgb2DqV7ExYQEsQTYXwaSJna0
 DYqFpqCiaEM0VyjcKO4SWkO4nW8j/Hogzkj9TFOukgXagncht1bMHA6J83jlDDHmpusH
 JA6pKHP7kbNI0jFlDv9CGsGbJTDL62wZdYCkZQJHIB5Zo2m4XrcyzJ2vyKFGllXWwkcx
 e4N4cTM9Ax4JiiKGdqo4+M7WFMxclEeHwSAptODi2SL1PzVX1LRyPeWPvWV1SEiUDfbK
 Xu2A==
X-Gm-Message-State: AOJu0YzJ1CyHMxK0Z6U+AQPmntyeg0iGxnyIpJ58NDJxlUpO2vlNvy3r
 Z5m7Q1eOF4fXnGLDwxZXTiV7Evgk7dmUAVFSZvAATw==
X-Google-Smtp-Source: AGHT+IErI+JJ0qQb0kGRaBojESvZz0XJJL4g79Qy/zZ5ny6YHKLgtq3Sh5UfWr8QnParMPf1D18KI7QU6ZpWolWmOeA=
X-Received: by 2002:a81:738a:0:b0:59f:4e6d:b56a with SMTP id
 o132-20020a81738a000000b0059f4e6db56amr9966206ywc.2.1696209488104; Sun, 01
 Oct 2023 18:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-8-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-8-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:59 -0600
Message-ID: <CAPnjgZ1kbNsttZXNiAOPufdSS1tY4jxt=26o9KZjP71Vgcec_g@mail.gmail.com>
Subject: Re: [PATCH 07/15] blk: blkmap: Make bind/unbind routines static
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

On Tue, 26 Sept 2023 at 02:51, Bin Meng <bmeng@tinylab.org> wrote:
>
> These 2 are only used in drivers/block/blkmap.c.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/blkmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
