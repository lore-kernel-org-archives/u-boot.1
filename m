Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02738C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD418329C;
	Fri, 23 May 2025 15:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EIF45JPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91C38329B; Fri, 23 May 2025 15:18:18 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CC28310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so1492270866b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006296; x=1748611096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X7G91CWhn2JbGubQ7kDKhhqDxj2jVlCJD3ZZU1SgKBs=;
 b=EIF45JPgb1hpc0ue7MmQynKxOb9IOiADahTFIVNyf/T07C5vl1JzzPVA9oNHEz4ZQM
 PdPDnbgurYKTPjsgoSMRVSrrP8/pU4ho472gpNo+5u1sjWbEgn3ZW7CnMztzZbJNmu8d
 0ODxEAxaQcDhRoj9DIoNPFQzDLTtxSHattIq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006296; x=1748611096;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X7G91CWhn2JbGubQ7kDKhhqDxj2jVlCJD3ZZU1SgKBs=;
 b=S9kkjDfzO09u8Qz+7Mkeu3F8o32j4fDtexDF+tf9EUzi4zoKsCsjqLOdyn2gzK3rvh
 +iBJclsVKv/toQMNcOvcb/QmtqNOgE7dnQQ7nuxWcps2Yv9NfYg+xFKfY8qomO3Kz+VW
 cGnO/lGy8Y3nADKa8B/lYPsGljq23napEeNd1g3cWGfQsZZ3qO3Xy+DohnuxfdEtK8eQ
 P8d73TyjutuwWYGYBpVJRPrmks2eXsjy65FYaaURN0s2g6SmTVlTyBBzvU9cPrGWdyId
 SEkv+d12A+nCY9halxPUModYzn62Ecgj3sUKT1jeVu1pbG7FR1l4K+Wj7cPTCETuxBEA
 tqGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8PxkgY8uQPLeX+7aCW4tkfBlCcsIp6uLQR5E0sGWwY4mUJ5uwKA3DoPC6hMCcpVuN91Rg85A=@lists.denx.de
X-Gm-Message-State: AOJu0YyUWe4S9TGNI1/vawjSiVOVA/+XkxQ4283PVtv8dg2mtK3uxXku
 OaTHCX9Q1IGJyZ83MWlJzS0c7ZeIsomYW9XsBIjyk7S7YZIIGVnbub0tbRw/KjbMP/fwyQFdndm
 Gpq8rg0vbjm2Ea+X/I0GLKZ8932Zd7H5+BwRYHXdM
X-Gm-Gg: ASbGnctUYNxj1CJtjc5D3MTjoXGJP6g+5RrxpxJDiD8+yBvWfRqn7M4+7nijDgsgQeB
 lu8HLVvkly3hKkFj08M/pTHnWhtTOVMATuAcCZgaD0p6Pek77N3yubTBA5L5RCjjL3cKfINXrKY
 uL7Lkv9l3ZNa74vjE7/06+WgZpT2+SYgTIew==
X-Google-Smtp-Source: AGHT+IEHi/9tunaCAv68YRELOfF6gTKJCwZFB5C61FWQ5S5l7Ar18OLYgnACjctKycLziSsTuPcYBHAHL3xFoaI2kdw=
X-Received: by 2002:a17:906:6a05:b0:ad8:5264:6063 with SMTP id
 a640c23a62f3a-ad8526460f1mr143416466b.13.1748006296170; Fri, 23 May 2025
 06:18:16 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:18:14 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:18:14 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-30-sjg@chromium.org>
References: <20250504132356.2317305-30-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 06:18:14 -0700
X-Google-Sender-Auth: y37w-ayktF9gWRNrLVqfmvPk_Hs
X-Gm-Features: AX0GCFv2du6IORwq3x0myVqBAL8Blu0K4H8amHcSJ5140BWQWCPlmNnQy_HSjDc
Message-ID: <CAFLszTinj_JQhUO1MagKyRY7ehOVBVqGiNqPoXe6yPos8jNYyQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/30] patman: Use a pager when outputting status
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

The pager makes it easier to review large number of comments. Add it
around the output.

Patman normally sends multiple concurrent requests to the patchwork
server, as this is faster. Provide an option to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/status.py | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

Applied to sjg/master, thanks!
