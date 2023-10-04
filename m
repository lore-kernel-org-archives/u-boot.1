Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B828E7C4E9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA4087663;
	Wed,  4 Oct 2023 19:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBd+qDhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB578762E; Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B55F8763E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso22610066b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442328; x=1697047128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JAn5pjvGPwfwPi3KsWAUlpUQWd+vtkSCVo1ct954EzA=;
 b=CBd+qDheuISA435bxNYXgscQuvxNfVCwNqs22jhxM6SArWW1L6LMEMBXeWjt7aW0Jl
 ZqKKtCjPxJ/FH+oXv878y05ZWW9NjZ1luNOrRKlCWmg0r9mwuAXDjtXNfBVOnqLchY9L
 Yl1nZS+AYbVNNLJGUowTWMMwyqkVUSVuUy7GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442328; x=1697047128;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JAn5pjvGPwfwPi3KsWAUlpUQWd+vtkSCVo1ct954EzA=;
 b=FKpE++bgjugMNPeVPjxjgPJKO0Ul4ZMLw1/8MchdtH+LKJvMGQkhc6u77m2VAZYnI0
 pIYoj5iThO03vRs7IO9eKjIxVbdXa7fzssqj0QbVQ8RI44S2tNZ3IGMD1oH2Lqr4MdI9
 KQBIKbBTuHj2oIDvYpHJr9GedPe2K9fcgirBtPVBdnSx1YjXZGdaAofOqcELhKQdEB/Z
 qfLtPNxEuO3e9Mhu2HqbFoA1xCVoLQdHFHQt2UVCK0EGQEVlFU+KqsTrqYBYOi+UMOpA
 z1oGqb+p0HyT9K6bRCOSXm6SfKx/KQbUXtkiT0rt9D8tWu5k96afSQOoVevp1KKDVSgp
 oG+w==
X-Gm-Message-State: AOJu0YxXSzH8vj4F24YLVQPP1Lw5cGrjrKuqBLMfRWOJFF26ZaB8Vk49
 imXvJ8/Kf/xM76MMRUUnBjcwPx+cgRhTy+I9Qr1YNw==
X-Google-Smtp-Source: AGHT+IFeW5VyNooLgk0hK3r6eOZKIpMpXcyw9r1fny194U2L+kjOpkoKhgsVFH6kLrYXoEihxtsJo/rPxLT1mAK7sFA=
X-Received: by 2002:a17:906:30ca:b0:9b2:b7f2:bc7b with SMTP id
 b10-20020a17090630ca00b009b2b7f2bc7bmr2622954ejb.37.1696442328160; Wed, 04
 Oct 2023 10:58:48 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:47 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-5-sjg@chromium.org>
References: <20230923194424.1739224-5-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:47 -0700
X-Google-Sender-Auth: Vh90kwHrDogTF42ms-bD2tDJNw4
Message-ID: <CAPnjgZ1g_SFCLxhRWoOFW9cNyJHokZfQg_y0KaGAvEsRcEogJg@mail.gmail.com>
Subject: Re: [PATCH v3 04/27] moveconfig: Drop unused cleanup options
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Cleaning up the README and config.h files are not needed now, since we
don't have any CONFIG options to convert. Drop this code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 254 +-------------------------------------------
 1 file changed, 2 insertions(+), 252 deletions(-)

Applied to u-boot-dm, thanks!
