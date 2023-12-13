Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D9BC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B938784C;
	Wed, 13 Dec 2023 21:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eJ8HU086";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5607787817; Wed, 13 Dec 2023 21:39:06 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2970A8781E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dbcc63b7c68so1733706276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499938; x=1703104738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EHPxvbL041eRwhCZu2oPDKtCTwIcoMJx+AJrbTD2rL8=;
 b=eJ8HU0863VxA2Phoqi+t1YwoSIeBRau4W6tTQNjYFeY4fDPejQ7HhCVEAJxTwKBj+a
 DQm9SJ9GBYa7zdz8ksdhXpChUvrV4MTv39D7rfFQeigSD81D/L6G1mHXkfY66iHBSCFq
 Q1N++lvpLR9bKD7//Rr6lcA9NYXBzHjAI45Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499938; x=1703104738;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHPxvbL041eRwhCZu2oPDKtCTwIcoMJx+AJrbTD2rL8=;
 b=MH0rIC+t86hkCbdABx49MUTIz9jws96Pl5AjTw3ZL3pTrrCUz15AXJJ4pc7m3T/JJk
 cCEfllyLJ2VkhodA3nt6NJJiOcgxnbEQqkSV4Tx7AjP3msLjtalSof86s79xzd3rdksj
 T+wYWj4O5dZO2k2UzXHVsI4GI8Z1GKmlpal8lPHtt3wJo/FBvDUM+GpANpKDLd4bt1WZ
 Bc/Nj+m3zSIuiy98AiBFSL732BLfvwdmjyCq2U66NilJir+I0mQMVLpsDbwK19GB/d3s
 dzAY6lWdTL/hfQhmS/BapR0UI8/1YXkZO6awAcu7cqD7gocnOXc+JUF+rbfrduTeNOIO
 EMtQ==
X-Gm-Message-State: AOJu0YzejBf4RIkq2m9YzFwb7m8w38cpaUqqCzBxTMkT1eUd502xjK54
 ThwE5MfBenzdoYJRcK1RwUYFjqSgDE5g0pv4clyTfA==
X-Google-Smtp-Source: AGHT+IFk6GRFlTZQcK7mV4Kb6s/7t1tbEsyoVq/j+qYsGsblkVYHxiQ0f4LJ83qod6JOw5hde8ktfWESwMeHfUPKBrE=
X-Received: by 2002:a25:a404:0:b0:db5:3e3b:d2bb with SMTP id
 f4-20020a25a404000000b00db53e3bd2bbmr6171718ybi.48.1702499938256; Wed, 13 Dec
 2023 12:38:58 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:50 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231211180733.86629-3-heinrich.schuchardt@canonical.com>
References: <20231211180733.86629-3-heinrich.schuchardt@canonical.com>
 <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 14:38:50 -0600
X-Google-Sender-Auth: kRtyqEt_iFpdzg1p6FtJO81If1w
Message-ID: <CAPnjgZ1Q0L9_wme0u7qqs_3Fr+c8=Kt9_edt+MDqniFjxv7CJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: vboot: Using variable 'old_dtb' before
 assignment
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

old_dtb can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Avoid a pylint error reported by current pylint.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	mention pylint in commit message
---
 test/py/tests/test_vboot.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
