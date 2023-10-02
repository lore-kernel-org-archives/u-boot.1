Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67704E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8EF8745D;
	Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bMFoeBdL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CFE871A1; Mon,  2 Oct 2023 03:22:21 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBCF871A2
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a645e54806so2155074366b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209724; x=1696814524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JVJEM8MMDZPBprv1x76dhaulS8rYt8njLZ07zYDaUUc=;
 b=bMFoeBdLnzgyHrwTEBtyOlygSy1mVipKj1ygzmcg8KnkxXAt0ce1+IXZ1Ksbsflfdp
 yU6aQIm3ew7r4iSMxv3Xi5SSWePrvZj0dCyBJfxdkdok5wiKPWOoE/2Lu5Zmqmrakpmr
 ae7Kv/rbsPU+Ft8ZrV9wqbo737lmz80wh2F6fygW0DX5hkCF2gMsAmukK6vWPr36I8OR
 d2qSbsk7O1YMwTLfB17dsNaLYcYNnhWnoygXkYEKEJh1ddtUvECSAt8mnRZIyzA6+vNc
 rREV/wNRObezqnLjGQlgHtzEzXXac0gPNOxx9bA68bNXz45bMw7cT/sihy5WR8WAJEMu
 B02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209724; x=1696814524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVJEM8MMDZPBprv1x76dhaulS8rYt8njLZ07zYDaUUc=;
 b=Q2LRgCdGfYqBeZFIfZIlnC/vIzmWKW123mFQc/9r4AnqqIIcBjD3vOqp33C2f6RuhA
 HM8grVprxubS/hsbsjVdlxTAiOJo/GdRf9LJwrMlZeIDOjBzUznXfZb3F7JjwAxuddVE
 Lp94gcUo/ly7MTrNCrQQVgAeStoH9tnPzNlWD/dD9QxnkSCOWwGbw6WYKaT1pzpDx2uN
 8O2gpOHQQmwETO6CulC83LWIMDHlPWYmQrUOX/NwV0eQ5CcKWguUWLFqHlQXFQefT1sC
 Euk85acakP6ezsHt3p6EK6nhSOrOPv9ic0kQdJxkCEwm4seY8ncAm/QuP/vkKwQu7m5L
 sYIA==
X-Gm-Message-State: AOJu0YylsHtq78DiYokvnbXCvEw747Ux7D7hekwE+rwgms4jH5hADKHv
 4JKxUCsWmq7Ae8nTWd7E55V1OXoYyI81IAA1R+mNaA==
X-Google-Smtp-Source: AGHT+IH8Eymj6JbfkqqwyudwnwkWdkHc8Gy6RVC89y7J+Dx5P/c9IY6rG/gQX4hr3Ucn9YC7z27w30WaNC7v+q+O1ew=
X-Received: by 2002:a17:906:738b:b0:9a2:86a:f9b7 with SMTP id
 f11-20020a170906738b00b009a2086af9b7mr8266880ejl.59.1696209723713; Sun, 01
 Oct 2023 18:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-15-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-15-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:49 -0600
Message-ID: <CAPnjgZ2snTZjQvFt-AfGk8rMYRAyaDWy3Tzbbzah4sf2Gymb9A@mail.gmail.com>
Subject: Re: [PATCHv10 14/15] net/lwip: replace original net commands with lwip
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

On Tue, 26 Sept 2023 at 03:46, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> Replace original commands: ping, tftp, dhcp and wget.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  boot/bootmeth_efi.c | 18 +++++++---
>  boot/bootmeth_pxe.c | 21 ++++++-----
>  cmd/net.c           | 86 +++++----------------------------------------
>  cmd/pxe.c           | 19 +++++-----
>  include/net.h       |  8 +++--
>  include/net/ulwip.h | 64 +++++++++++++++++++++++++++++++++
>  6 files changed, 113 insertions(+), 103 deletions(-)
>  create mode 100644 include/net/ulwip.h

Reviewed-by: Simon Glass <sjg@chromium.org>

I don't really understand the error handling. I'm not sure why we have
void functions everywhere?
