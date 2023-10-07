Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A3E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FF186DF5;
	Sat,  7 Oct 2023 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmch/ieF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CAA86EAF; Sat,  7 Oct 2023 22:37:59 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D07F786DF5
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso3144464f8f.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711070; x=1697315870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CocjJ03DrVIQqKQyd5dPjBAF1uTdRBvafAffxa8pstc=;
 b=nmch/ieF6KD+rujVSr2iOIV2DwcfWoSGTXM0g85F3pUdpNih8gP7ii3qKkBGZNHmwA
 Dj9AFLL2N9AUun+QM4MMGXQdjMOvpykl6st2MnlJsQzbPYN05stW70QiGDgu3lMxbjRl
 XO7jQ/hjoc28PA9NLvbiss0kbrME/tvp6aQqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711070; x=1697315870;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CocjJ03DrVIQqKQyd5dPjBAF1uTdRBvafAffxa8pstc=;
 b=sepMbrUUJyzvcDMhSakjSTSauD64mqSL1OVbyS22anuUu+wzt01mcf3vJKTKjOMvcD
 UKTHQdp6WobE0v/XKnWRJBi7JLGJk8Cs3LHBimlfYkAEZaakx2dtHe0RQf1y7h/KP6UR
 8RjYnjytWgzMNNGAgRRgUDKG4nDiVMy6/ezUm6UtL8Ex6La7V7hN4WQFXoukyn3pYIvL
 sXLjszs+m/PmZ4KJm9mm47qOqmrmsQynQDawGMxs8DbdbFbyC1vQQJuWxck6DAZieVh1
 +7v7rLmqj0r9f2OY1NAKvI0lbWrB+NQN825HUaW8vklwTOmW+/4ZxFgDMyzExdp/Kcca
 LrDg==
X-Gm-Message-State: AOJu0Yxzi+VhC7sQYKZkc3wUW8WKKLRWwaDyHILpENwV0WiEYWAWx4H/
 bDFvVKgkojA7EjpeSdfzGsri9ZME+UB9vdhtBpJM4A==
X-Google-Smtp-Source: AGHT+IGq+Wr28WdsrjjAIi4y7Dw7jdXz3dhrWcmtdb5nldGxnTFZR+eO9SZG1tuDSILdEoe8VegfO+HPCnFFpcA+24Q=
X-Received: by 2002:adf:f403:0:b0:321:5b64:f744 with SMTP id
 g3-20020adff403000000b003215b64f744mr10359454wro.20.1696711069715; Sat, 07
 Oct 2023 13:37:49 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:47 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2f0vjewGFB2Q6fFYhxD=LBWAfGv5W_fjjUuNCZVV90QA@mail.gmail.com>
References: <CAPnjgZ2f0vjewGFB2Q6fFYhxD=LBWAfGv5W_fjjUuNCZVV90QA@mail.gmail.com>
 <20230923194424.1739224-18-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:47 -0700
X-Google-Sender-Auth: X548MjAq75FbbnhiiBuqOeuXxos
Message-ID: <CAPnjgZ1p+dUmqY931q331Qw6sQ3w2uuoE0a1xX-voDvQg1a5yA@mail.gmail.com>
Subject: Re: [PATCH v3 17/27] moveconfig: Only show output when there is a
 reason
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

There is no point in listing a board if everything went well. It makes it
harder to see the failures, particularly on a fast machine.

Suppress output unless something actually happened.

Drop the 'Syncing by savedefconfig' since this is selected by the -s and
is the same for all boards in this mode.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Fix 'Supress' typo

 tools/moveconfig.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
