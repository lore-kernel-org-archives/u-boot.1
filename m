Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F08FCF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7378909E;
	Wed,  9 Oct 2024 03:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="awQlsLXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4587F890A9; Wed,  9 Oct 2024 03:53:14 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA09A89051
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e053cf1f3so2372726b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438790; x=1729043590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yR89mThlHnHoTq5Qr18gq4/D+kx8Eq/HpRfGRpFmjaE=;
 b=awQlsLXXYtFQ4azvpqb35wxo8Q3ju9fQjpuj6MVt1cO6yaQQSF1beJsxrPUv8sAbGW
 ilLo0CQpcYePQrg7bDUgyKTU1s0rnlSzDoSae0uoRVAcB95A2pyv6KRkLAscpdcrFUSV
 wBqTjaQkevC0ONuGuxQeQUxVCCVxb1bR22AjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438790; x=1729043590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yR89mThlHnHoTq5Qr18gq4/D+kx8Eq/HpRfGRpFmjaE=;
 b=Jy2SUoELo7n5LntS9v2pbjZHVfzA9gEJn2+DEzXlHIwZOjF/WsRg4Jxn29y5fWPh6u
 2AC9dzrFariXeov9J3WhcLX51wh0J5DcC7DNdPt45jZTAgi/Yg+ri/+ZkTkF9LQKvLiX
 DXsnKZJh81/GqIgndVMlFoVqgrptKX8/epFwCFMPhfb3PWQIYE9S+cTL+QESmwWnjeNs
 z5E+t/RpFIbN/1YdDNuRUWQcJf0NerhBHXSRCBpWktmxIrKbjm/65QeC/d/FjpylkbGq
 4CyNA/UTxmLji6z+zkJlNyIsDeinxqh3Ew0KjMn5kjteLVJ+bkCtxBwNCDgtK/7gJb8h
 WK+Q==
X-Gm-Message-State: AOJu0Yx+84JjwmoMi5uavfuMu0AE3w4bv5i1L8885i/bjsNqJMKZ5n+n
 y3Nip9e2HzHMwAnQMRyPBB6haLneQsr6i+8bhcyKHMflK6KLhFFfX828VvpRh7BnFe2SlTDuHvf
 /+4Clp+u7X7hezLbbxrzNC60vBSs5HrgjzSTV
X-Google-Smtp-Source: AGHT+IE1/eOnsdeY/fLJBPZXqNr1tZuBDnw45dXAf7e46SFSnmF34ofHlQhu4YVXBOQkJvLq6YNGwwXFzHn8C2suT88=
X-Received: by 2002:a05:6a00:228d:b0:71d:fae5:4ee6 with SMTP id
 d2e1a72fcca58-71e1db6e1e4mr1544835b3a.5.1728438790431; Tue, 08 Oct 2024
 18:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-8-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-8-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:43 -0600
Message-ID: <CAFLszTgqos6zyA-OpMwZk=HsCw_T3EOiu46YxbmncrBMtNeFNg@mail.gmail.com>
Subject: Re: [PATCH 07/13] cyclic: make cyclic_run static
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> The only caller left is schedule(); everybody outside cyclic.c now
> calls or references schedule().
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  common/cyclic.c  |  2 +-
>  include/cyclic.h | 12 ------------
>  2 files changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
