Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3806DC3DA70
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACBD8875D;
	Fri, 26 Jul 2024 14:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NtH85s34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5216E8875B; Fri, 26 Jul 2024 14:59:22 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4324F88614
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b797a2384cso3424456d6.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998759; x=1722603559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IuFfHyCRWboQhG+nDhREHW7Gtv6Rr9PtVep+amn17B0=;
 b=NtH85s34AhstHYZ9QZae0Sjnpl+3G08y7+WVgnqF/bGraptQFRvtuh/4aHsuOY6ESB
 MrlKwCNfjVAyz/DN1zzEknN9ww/cqeNwkjI35fMuaHZUGjU4uDBsz98djnprH65e4Ukf
 2NOa+6XrIaoJKGBzd+tV0CVML0hZ5Jh08ad5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998759; x=1722603559;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IuFfHyCRWboQhG+nDhREHW7Gtv6Rr9PtVep+amn17B0=;
 b=xIKoqoezlkf/lY8cKqcGZxddlU8xYyr2PMlbh02z3uil5C+SsqJCozHy6outos2zsw
 oor3WV2DD0tibrLq6Dn9sjCEaNcE7n5oqz4i8Rg9GVxF5L6yJWq1N6T7iM3wUyuP7pL3
 7+01t37Vs6Ary71ZrjJwsZWXdsO+xG9nlj3kSAyq3Py7DdeZpSsm4i7IukeKNi1ZNR5e
 AYP8h3GhmhqTiUdhHQsqwy47Wzx2dHNoSr2q+OAtEO91ZTb7K8lZgiwdnVe1MuLqlqeZ
 SYdguq+tPmhpRjEO5CW2JuD2yMHXLgK4VhOIvQWBtwNPRf7zKbj8hD/EkP4ZFjETgJeA
 1W7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW11VrYFuZFDqhItudvQz9prA5CU2D6CR4AUAnq+aVeaGS3QJ6xusO0wHJ1POnFZiS9bF0iO8R9eZedki1fLPdxrFuECw==
X-Gm-Message-State: AOJu0YwjcGA8Qz73Lyvtd0vy9cvD4tErxcB3gYEGSH83fnKmSKGVOaPp
 SLw2riYLHpwWmxlLE2lZ4C9tJx98pSMwwBwkfEwXGdtKm3TOZWVE+nNHNQSnMvT8fn5IeI8ImXB
 v/3ErUNKveJbcAvprnwPxQyB11J9YII+lQ3j3
X-Google-Smtp-Source: AGHT+IEUVql1OWJ70n+QSxsooStBc+sS6QBXCeDmoi54QGF7aOht4Jdl0VWpggS+SOfGYYwvfneuVdq9Y4ccBvl65J8=
X-Received: by 2002:a05:6214:ac2:b0:6b5:ec9e:a815 with SMTP id
 6a1803df08f44-6bb3cac4c12mr98301536d6.42.1721998759127; Fri, 26 Jul 2024
 05:59:19 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:17 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-3-sjg@chromium.org>
References: <20240717155712.2913651-3-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:17 -0700
X-Google-Sender-Auth: bSdmim8ldN_tg18NbP4ouapESO0
Message-ID: <CAFLszTgFQZtnOEn3a1zR0adteasFEFYYY4s94MHVkxqL_Dr-4w@mail.gmail.com>
Subject: Re: [PATCH 02/24] qconfig: Drop the try_expand() function
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 21 ---------------------
 1 file changed, 21 deletions(-)

Applied to u-boot-dm, thanks!
