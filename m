Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0EBC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8C187876;
	Thu, 25 Jul 2024 16:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBOWwjUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14C188373; Thu, 25 Jul 2024 16:03:02 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14D6881BA
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc491f9b55so9025035ad.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721916179; x=1722520979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CRLT9DVjtsq7K5isQoGef6oFeHVOIVCV1hxVaJWYmVU=;
 b=CBOWwjUd3OOe6+uv5/34jnmSEKf/euqw00aww51VIa6NWGoou8vBvY+hSWFLHWNb6X
 T9En54+DQSoTtWx7K/VfMiXsXvXkmc2HSVQq5njeHxxrsdhtZTFuFHEjf+dxcDgZZK6C
 9EmEzOOvVoC18Q64KxfILpJ6klnfxZGkYgIGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916179; x=1722520979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRLT9DVjtsq7K5isQoGef6oFeHVOIVCV1hxVaJWYmVU=;
 b=dOrQSeB1YZ6FgjM4lkYFmr80rUQM/Q2KWlkaYWi9hKP1Dk0rlCD7/v4eHzJ1XaTtST
 eKO9bzD6rB7ReDRLfFEt7JUEOf/iw3JiOpISOXFnDNj1BRwFLkzUgUnbuiCeFzoA1Lix
 UYjN34/6AqzkOrHkdbXnTdz0p/4yj2Mk2c+BbIkHt6KcbY8V9tYK28jUYX0Pqxom8EkX
 sJUPLlLys/1vo9HPpDOCAIw3KSy6IV6fOKV7AD0AcnUc1QNw/GlfV3qANPS3nbyheBjB
 NcWLhtw5nK2TqvfdUK9oQBjVIyjFXb5j8Gz5pxCOR+QreZBcS+NaGpoO12NE35OVbEly
 gohQ==
X-Gm-Message-State: AOJu0YxblKxdD1ooRefyYl8+Fieng8SSyhfqv2Q0mJ+4keyB7QDCgG8q
 SPx0h9b41vwYbKV0Eas++aDEAIwCbzrDV/nlkjM1f5PaB1yEiLIlBHCqbH7QU3bbmXbEODPVeUo
 3ZEYSJJQxgxjNlhw/ltncHgERQd5HKt12q/QggAAxw5R2AfU=
X-Google-Smtp-Source: AGHT+IH79U+n7NjSw6jBF+RfFIsOHHWpDbTACV1XFqt+Of7VZMaHQIFXNXVJJwAamu1NKtePsDlQalhkgKk8Bj9pin4=
X-Received: by 2002:a17:90a:bd87:b0:2c9:7e80:6bc8 with SMTP id
 98e67ed59e1d1-2cf2eb9ce76mr2054722a91.37.1721916179188; Thu, 25 Jul 2024
 07:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
 <20240725095331.14245-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240725095331.14245-4-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 08:02:45 -0600
Message-ID: <CAFLszTiNYWOq1qpACvjrcPiyz1Z97BSGgZxf2Zu76AjrbrftJg@mail.gmail.com>
Subject: Re: [PATCHv2 3/9] test: cpu: add test for release CPU core.
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com
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

On Thu, 25 Jul 2024 at 03:32, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add test for API cpu_release_core().
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch.
>
>  test/dm/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
