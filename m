Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5287C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C25871D4;
	Sat,  4 Nov 2023 20:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MNwzPok5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184FE871D4; Sat,  4 Nov 2023 20:45:28 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F6C8715B
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so5269892a12.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127123; x=1699731923; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0qKdr224Y+F80DTqFTCwKG1pz4rGqviNZWdPWtP9LA=;
 b=MNwzPok5oJfwSSstBQPKV0s/trWL4kC5ka20/4gFFhuUz/5ns+P4TiEGE67eC4NqYG
 cP4ddDz3i7JJ2whlFvAsBV0kHncrj1fb/Oo8aBzcOIyw67/rQMCXylakqEwbIabJdRb1
 9JsBGpzju8aeMMtdKBNvPngdy5EnYuXOfrddw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127123; x=1699731923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0qKdr224Y+F80DTqFTCwKG1pz4rGqviNZWdPWtP9LA=;
 b=buA3SD3j5wMh2vgncRwNPh9o2Qj73AZNaaAjOvsGhMWDOv5v52zvzm9qiUWALpFH6z
 /6NB4ArbwzW9kZ82RpaEO0U+UdstnR2u/XJkZKdDaEt023F5z4liJXn6k9Tvq3KHnOtV
 n9QdaocGVY7PVCr1tkETGNqHHP2vJ6fYEkGSWy3z71VIsipqRNJyi40NjAGjm/Aa6C2E
 nAL2LwhwjjOxqdJkdehk1mWQFrpWYzejOJQy9w+rxYo6lZIj4QyRAxg0ZeBlhzZzacwA
 U8+V6VlciaLdTpxpTWWzVhFZLIy6ld9kNOnAGreVEVCC7mxgiXeUZ4GCi5UPAGQF8nEx
 4x0Q==
X-Gm-Message-State: AOJu0YwGANrZwcFiQJqGOzFZcfCM0VpR7ToOVSbd2DvlzJnqEHIoYHK5
 MSOTgsdFcBMjTII6tS5eK7eXJ8m0zSQRnjcQvuR/5w==
X-Google-Smtp-Source: AGHT+IEHH3eAlCqPCr31Wki0QrCrPqROo44X2/oRyT/dYmIBY4FJOZaXzqf2KOVz+pzoSmxFx52h8a0RPNXiYIuvJRs=
X-Received: by 2002:aa7:d296:0:b0:53e:58fd:9600 with SMTP id
 w22-20020aa7d296000000b0053e58fd9600mr22207751edq.36.1699127123346; Sat, 04
 Nov 2023 12:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231104143834.5043-1-mps@arvanta.net>
In-Reply-To: <20231104143834.5043-1-mps@arvanta.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:45:11 +0000
Message-ID: <CAPnjgZ3iHjeYxwhz=GC-dvWtOEW3Lu4S=G+5myLp8bqGtaMD9g@mail.gmail.com>
Subject: Re: [PATCH] doc: build: fix wrongly written targests instead of
 targets
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
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

On Sat, 4 Nov 2023 at 14:39, Milan P. Stani=C4=87 <mps@arvanta.net> wrote:
>
> Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>
> ---
>  doc/build/gcc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
