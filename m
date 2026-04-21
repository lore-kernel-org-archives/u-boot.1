Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79128F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27D583E76;
	Wed, 22 Apr 2026 00:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mQF3vskd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC2683FED; Wed, 22 Apr 2026 00:43:06 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A579839D5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-671c24f23b1so6951805a12.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811382; cv=none;
 d=google.com; s=arc-20240605;
 b=ezdJyU6lyoKYHbgiCi9L3MUEh+T4TTc/7RneUq0LmSDD2QFzWHEW2ppOSZUFNPO7L2
 vOyPgy3UB284wa4U4y5moXzr5NOUL7iGWlHVf2hThLE3Ms4YQfLu5R3cdKN5ZzFTJcs9
 R5xyLfnUcrHMz83q5fsn8ZkWwWHx+DjzMWwBVj6CnIIPBewbajfZNI3gSKAS830RhQYJ
 vYjfDjEy4eb6V3l0U9gemIA/Khi8Qfh8cBlODOZZbHyMw0zsbYT03BXBos7gSJS1dkT8
 Tgc49kI08fOollRRI5iCyhMZ8DK8Rh7NAKyy7S5OT6C+HmZ5+gi4bnTmt/5ZtdbkZrvC
 KYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AMMqsY4FjTwa1Yb4cYgQ8bLTkIk2A62p67Gk0erdy8Q=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=ZYdisaNZeSQMiPvyB+Pi9hyFXJKtxOb6kkizv6F9NDwyAM4XdZTUZHzgFvmm+wzU7s
 UjDpz2vYL+aIp1BX34Cb/3kLJOQh/6h1mX5Pcb1QQKdyOjglwntWMWGRE+iJ7ak/PB3f
 RGurXVwom5/wIcTsBxjnz0Z/0+kxxCEf0dQ7R/fK/jL+VRX/c14qZCHA1UDak0nRPeTX
 7tMjoCnUzOn19AbHYSgGucFfGiWteZqLGu3ztFv5Gyq5CjGDBKkp7Sj3V52x64fu3biH
 vbAOp38IwPzAhpTc2M/0wAbOJ0EDtmFo2lSRflRsfDa3ssl2jv29dGu8lLsbbkdIxS6r
 Qppw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811382; x=1777416182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AMMqsY4FjTwa1Yb4cYgQ8bLTkIk2A62p67Gk0erdy8Q=;
 b=mQF3vskdJz8955UJe+g51ef00vji/gOzbJ6Ng7TAUMz1pC0vrbf3ckATg08ONRF/y/
 GVgOkteBzacS5Hjoo/xcKbq5kc9BpN9RZU1bBg+NrMZZUZB6SLzp+qWHKWm7G01fQUwp
 VNnupMF+Pw/dBD78+eKY4IV4JW4MKlzlwMghg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811382; x=1777416182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMMqsY4FjTwa1Yb4cYgQ8bLTkIk2A62p67Gk0erdy8Q=;
 b=TXFK0VIOaQ+9PvcFdqvCDfGoYCSPfpfizP3zV+w/wZp3BxEwMdvd7xdsNotCtSVJ/5
 yvP4du4kEfMhtaI7jzy/MrcH0rP6nucjDkVRwx2qyNwYHgkjafcrS546tcH/AhKwfdS/
 pH8XXTMqc3pGxC5lhkGSGBhN9PQ+Kidawa0ZKc9qHbEoBgZku7Pz4ykQ+hHZSlEgcRA8
 KCe2B3zOMGJx1YbbDePZ8dY6crjoBXaVytevloxaTjp+yjnYTbtNPbP/qqTpi3L2+kkT
 1eJwz7m0vetgSnjAV4ltyeIThY55LzH6AcG102m0UqL8SlQTH4FwM0otX0/btu5Pq6OT
 91/w==
X-Gm-Message-State: AOJu0YwxXx/tOSW5AwQA05ls2xT/R5ttraEEr5AXyWkZVZaX4EsKzP8F
 NQEVm4do3ESqP8koY0zol+c+3XCfB9Ln1046ceIJgf9q/lQvB0jd1dPhADFW+jKomI/+sO5QT60
 WCkisWv6+o8gKX4VAsylraR7yuDgXeEGm9NyddTtNGMfgzIfF1CHvhw==
X-Gm-Gg: AeBDievr/i2dwseXLjHKNyMtsWrI/lNklUbrtHyGuDWL09lOhuztcJQxhshh6cqv4Ir
 qngSoTHYdrIk4exos/UQ66Xzv/idCC7tpYHc+t7TiZDmrYiH8tRGcVKhaVQNKpd6KEyHSqg5HOm
 PYFtPyTg5iMlxE2FN3x3pLwRF70F5Bat/lLfrAOIarPztyN7CPKbt9pTtkRP4ycvm2b++4NdeLH
 XGPSdk3rsKnNU5qmbMkMkf4nPLf/Znu7E1Rl/dke/vtjgNNKQ8W0/MMe0HA10blFsj3TGQ9l937
 w2t5WgOELx2bwzCktQvM
X-Received: by 2002:a17:907:1588:b0:ba9:3162:182 with SMTP id
 a640c23a62f3a-ba9316201a6mr228279866b.19.1776811382419; Tue, 21 Apr 2026
 15:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <f7912b43c018b0a1c9b5d9e75418685782b213d2.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <f7912b43c018b0a1c9b5d9e75418685782b213d2.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:42:45 +1200
X-Gm-Features: AQROBzDrUz5wKgXfvMuqKEnjoVLzgArvY835ogTWj0yjnyAbEiEYXALs46AgaiE
Message-ID: <CAFLszTgnG9dYgoMKfFFGKfB_9GMo4NuES=PrNYFR10PnfyxGWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] ubi: remove unnecessary extern directive from
 function prototypes
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> ubi: remove unnecessary extern directive from function prototypes
>
> The extern directive is unnecessary for function declaration and should be
> removed.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> include/ubi_uboot.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
