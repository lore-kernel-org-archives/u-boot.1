Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63095E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4050287286;
	Mon,  2 Oct 2023 03:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g5EhGZQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A407187493; Mon,  2 Oct 2023 03:22:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC12874A5
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a645e54806so2155116966b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209768; x=1696814568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KDnXOiXqXu6SXIwvriGCeHZfIJRWh6box27hqWdKiN0=;
 b=g5EhGZQaZbUlPVBFD1/WVZPzg4bEoSpL4PqSD0x7uj+eNZPvTcEfBkn8O9EFyKZ6Vj
 lCPRsJ+5eOkjnpDq5/1vQaNDKEHMnqnU1y9mW9SCjIIxT7u2OA+fGBNRyVegLmIx8q+S
 KCJ1rDCX/y1HisvKNLk78APt4Iw6Dv52SxyyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209768; x=1696814568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KDnXOiXqXu6SXIwvriGCeHZfIJRWh6box27hqWdKiN0=;
 b=onAVOkIQbiN+caa+VZTMqLjI5R5xvcsqSXJCwjokkoytgeaCvtbcWyH467WX99zh2R
 U5zNxQnuVNuUWhQHsmXZeiXNkwlS/wTyk8apzVgBKIvNyssRwcAGw0SJ9Wpo4aesmTuR
 n4//7wMgroYqUeYRZb1qTWuhCV06lyOQOqrOp79y2+yD22nfoyvxy5U4P006QQOXWKg8
 azrRY+8DhI+r9cgDkjTK2ec8AFLxlmRqzKDo4y1042W6dHYTpoEoulu0ttUktbsEx6/6
 aT69DFtt63FZnFEfZXPflVQ1DOaASzE5DtuSTfNW2R1xilAxLeGWr9gdtOa8rkLU7ZO7
 8sJA==
X-Gm-Message-State: AOJu0YzRPkzl1RRh6XLuTN/ddV8I8FQxzrRAU9qLm3w8mqSWlOf/Ysy1
 oxDX/Qf/x1+jOB+8tJ5ln/fLhk1pZZwBQ94zhghKlpgFR7A24CaV0/Q=
X-Google-Smtp-Source: AGHT+IHsrZu0knekY4WFu0pN2a2RtS4FaL0aTZXQg5EcKP2MZb3BHT3L0sKOfqTw3Ew2O0ctddqrE9BjLqCr/DGroiY=
X-Received: by 2002:a17:906:f15:b0:9b2:a078:4461 with SMTP id
 z21-20020a1709060f1500b009b2a0784461mr8731251eji.44.1696209768021; Sun, 01
 Oct 2023 18:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-15-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-15-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:05 -0600
Message-ID: <CAPnjgZ0PxuMt8coTrvTNYQ3TDAcDWBNBAcPW=FCq2Q2pddh8jQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] disk: part: Print out the unknown device uclass id
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>, 
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

On Tue, 26 Sept 2023 at 04:09, Bin Meng <bmeng@tinylab.org> wrote:
>
> It's helpful to output the device uclass id for unknown devices
> during the debugging process.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  disk/part.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
