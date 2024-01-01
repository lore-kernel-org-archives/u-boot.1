Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185D8C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA0687867;
	Mon,  1 Jan 2024 17:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VHpVNOHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8314D8789A; Mon,  1 Jan 2024 17:49:34 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED278785F
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680a06cc763so19155326d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127766; x=1704732566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f+GxIU0k0fXq46PPrIU8EranYTe4Il+xtuWRWQVwdcs=;
 b=VHpVNOHpTuRXuWSjV7N9ktjYRRKwDb7XAUsOMVytTjq8nR20s+Do9MXBnT2k1JWLKC
 dSV/13LIv7A6EyuOTiqBvnRNuCiIPvk+xI0wkB3P0eArCpD8PgzHEyEpsXKk1dHo8157
 cqd0K1kwFB+pktmF1p7JSo/rx4ILCBhvPiDzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127766; x=1704732566;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+GxIU0k0fXq46PPrIU8EranYTe4Il+xtuWRWQVwdcs=;
 b=CNVSdAxHCG/O0vZ47Oy8/xXo201OrokgO6lSq4RPrFhnWu6BIJzIqOjOTOhFVvNRVQ
 7HWQhNzIrl5AzJsoRwxrbytWtsiKjy/YjeoxWF0O2YnkbFF+hhOpXNsUFOv1Iq4C1QLq
 zIejOT7Ckc2ImRJVI/+WOGUz6sFxhajfPB+W9vm0buKnx0bK8x4RIIeyRkdvrdrtEP1K
 aJW8BwEOrMmFOV2wpedJzwfuI7QWca6iYFfvSgL4t/NKsbs24y/zLaNNq78MxuMyPFH+
 8xc9FBJiydOqL8iu8+f4F8WbdpJF2wZb61OBSCBYcOwsXEyb1dLQFfdRrdFD7Gc6wO4p
 ubMg==
X-Gm-Message-State: AOJu0YxKTlWLnMpbjo2iQqets24leIH3XNggKHaWbtNqHxjb4Xi/Sf7x
 W4g68vrZuwEnUjcHuvxXqQTuSO/gS3QOJvDD0simYENH0+hA
X-Google-Smtp-Source: AGHT+IHkLAm3+5pZ7+j0CGezMrhzzgX58iVE2gkpllp0CkMOBXvWCzBvu33u9Zfuj0WVWK/acC7c9cxGTOQQeCJK+6s=
X-Received: by 2002:ad4:5369:0:b0:680:5fc7:d478 with SMTP id
 e9-20020ad45369000000b006805fc7d478mr9452090qvv.30.1704127766254; Mon, 01 Jan
 2024 08:49:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:25 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-6-sjg@chromium.org>
References: <20231217163627.2339802-6-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:25 -0500
X-Google-Sender-Auth: gKaANWAGGelLiP6rWX4yWcnwvjo
Message-ID: <CAFLszTg5p3cq-BmSuqP1S7YZY807uOCC8GLe2+74huSViFmfAw@mail.gmail.com>
Subject: Re: [PATCH 05/10] fdtgrep: Tidy up comment for h_include()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Copy the comment from fdt_first_region() so that it is clear what value
this function returns.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
