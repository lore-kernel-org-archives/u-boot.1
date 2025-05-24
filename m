Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF2C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8980F83496;
	Sat, 24 May 2025 06:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gvTsH3WH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E26B83496; Sat, 24 May 2025 06:25:31 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308C883303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-602346b1997so789306a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060728; x=1748665528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCj3KjJ8qc0PItbPAvqZaCmjnf7tDhKA/DtoMoLWY2o=;
 b=gvTsH3WHiRVsPd9ACV+H4s0+4uU3cylCij3FTpDRHEz6yq50uKf3eCmjlYc2mklgeY
 LmZPA2C5RuO7xbEkpHe9DYpWA9zH6lPjcrBcZVVlqsJe6FgWW4eWiExtJOMi7a1Nu/pH
 IFXgN6kmm3IhgZiluOKRptGp4DKKJGEFvIdNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060728; x=1748665528;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCj3KjJ8qc0PItbPAvqZaCmjnf7tDhKA/DtoMoLWY2o=;
 b=GOANbuFqwQ71U1ajzleLingStYpbfFnuRvWTbuBExKiqAkbeaPkSYFixiApc0u517F
 yywr9D3g1gyDkJjyTmUwbBdp8vMGTN9IsKzeVCvBtS0xqafpC3r+oF7Tdn3xpMYCC4lx
 4haG7Lw4++/4SG6oE5LqAHjhB57SD2l9AtBcnnxak5ENGFFkJJpMMsNkciCZzadI9Lrn
 McWKFWLZu72y619H+rD1WRoY48MS1GZJtGoz0Tmo/SGL4a54w5p65olUXWq2KSaYVEvI
 3MHnec1vMmR+BFArEsjuG3PbTmnwm1p5Z+KRUnmev/sqvZ0Ty2RCtlr5rHT7PkNzobyy
 ufpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHB4p1xJNJljVulZrmPaWU7l9KQ4aPinvKS4aqXOYyRh+QgzHJ5m47gxxLYDU8+TysDC4qyZc=@lists.denx.de
X-Gm-Message-State: AOJu0YxdE5zbSUdR4TxEM4LN5LaGsSMhCGhIArkMDfUS7lmLLYuTK3+I
 /zzh2wy6Mwc/e/kEGxo5B4oydhATbo6afkBHNeu9sWn6saKzJgSqgVXIaGI0IhFN6yFJCCprMCm
 MbdEe1wKoDtTtAP9w1U7CRmQugmCO7wHg5jz5EM3n
X-Gm-Gg: ASbGncuIE3+nUO/xs/PdFcQUMqiAgSicMq8fzXfs+NOC2A08Lq9fLQGvuj4upkgyisJ
 +Fcl6cUAry4lXRmk+uGEUGl6AlMdcFrcIAbZ4YyxNzc8vVpylAR0EwEIqXuGB+Ml0PG2ZOkgP5a
 FbllL8sKP4qLswWXwJ1DfN8sL+B4rOmi0NUtts+X0iBw==
X-Google-Smtp-Source: AGHT+IHzt3uCuUimkaRg3qsHYxREygMbdr10CJcPiF5tEWoD4vv1/OWAgRkaaLLr0pKGUYJM4ZBKIMZwIb+zHT+C34g=
X-Received: by 2002:a17:907:9627:b0:ad3:f3dc:e36d with SMTP id
 a640c23a62f3a-ad85b3290e0mr121308466b.50.1748060728627; Fri, 23 May 2025
 21:25:28 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:27 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:27 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-12-sjg@chromium.org>
References: <20250508072907.207175-12-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:27 -0500
X-Google-Sender-Auth: VYzNJg_CjqumK4bnrVy_G1kC2zg
X-Gm-Features: AX0GCFsjxvWDJpEMLgnxQVApFTq3FNDJlLGZkHU34GwqSxWh9S8v21E6lphcG-U
Message-ID: <CAFLszTgMGSdzqX4DUyjk9YETcY-CE8_NYRj5u3snBm4yUKu9Ww@mail.gmail.com>
Subject: Re: [PATCH 11/20] patman: Clean up creation of the git tree
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

The test starts with the HEAD pointing to the wrong place, so that the
created files appear to be deleted. Fix this by resetting the tree
before tests start. Add a check that the tree is clean.

Update pygit2 so that the enums are available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py     |  9 ++++++++-
 tools/patman/requirements.txt |  2 +-
 tools/u_boot_pylib/gitutil.py | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
