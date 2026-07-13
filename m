Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21ADC44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CEA84C20;
	Mon, 13 Jul 2026 16:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/zwOh0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119EC84C2B; Mon, 13 Jul 2026 16:25:11 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E0784C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so482715a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952707; cv=none;
 d=google.com; s=arc-20260327;
 b=cTaPJzRQjcVGNiB5eYeFEA7LT98Qsb1642z6tJvSSPhVwud3Q1fbqg5APm6l6xRXXJ
 5mHJCeiTRWZwLHX/x502LXM7bvN6hXOLgJ056N9Q+VNjgRX4mHzaa395ibJi8ZRTFBqu
 oGuKv6pauvtb7S5odk/pbKkvNzNqvyWdc+IiNM3HGoh3VNAeGAGAjooxISnIQh4G0HaK
 asLW7ja9VG9qONud4oIZoL+30VJs30RRwdCnwtmBrBCO4KMkIoHvkMhHN7giFe4UUEj3
 PTy/NR3Ff1KMKgeC6Dz3i9CviZAlxHIAneKNUUwgtgkF/a744FA7PbZQjZpPS31fg5up
 yU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=98w7C58M890ptBjnQ2Maprdkxe7yVjwn5kTGTjpApnA=;
 fh=BwhJ/qa3q2umnvSxC/8qPTLnUTxbKx1GYFMZhGakBJM=;
 b=ShgcZkd+dHj5rHBpQgAw71lK6HNFfT7g3LLsaX9atl/CHKmZHnMMkI/L2Ijz/KIJw8
 ViLkemlMiYvrLL6JbJhfBRCQzXx32ZgVXWku15Qe+ngiEl42PD8eIHOydhWraqsxxnBW
 c0W6+9+mlp5JWNq7n3gOZZNcCDkGcyKWVKOf2KRtTB5CwqOcqeRtYn0cL0d4kMVsxycS
 wCIOpRgU2esyeGVqUsi0LZ+kAz7rcqRx+gqSJeFSyyX1Ry2NEjkBl/FXJscYfs932vfS
 h3eenwBsnQfx4LWC++ST486/LQt4zQ5EUwp+n2eBVtrR4257gDuCr/0nfcn3i49UQvpc
 9b4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952707; x=1784557507; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=98w7C58M890ptBjnQ2Maprdkxe7yVjwn5kTGTjpApnA=;
 b=I/zwOh0+VnLEhGEh4xGbMFokC01Td/2W6ZwpZCecVuAwugw5zLIhQtIHjmNiFC03Qh
 n7pvspj3T2fCUxTj6BwsCgAWb2Y94sWE8Hc6gQpArv5P3Ko/0+a/4aToDfUGg2cb7chx
 MQwcJL5iZ6e9nSKTjOesYAmoCAKBJeQ6BZBPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952707; x=1784557507;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=98w7C58M890ptBjnQ2Maprdkxe7yVjwn5kTGTjpApnA=;
 b=of5qdKZ50lCj5QsRr6SFP36PlIASVhswDLrwUzEwnBo0SosBtaNN6p98cGeCjqaukE
 DkQtHvtxQFPiTyYP5GC8kttg+zuqgYk8E0n7nEAshdfsmB6Vd/YKQxindtiNnwNKYlT6
 q/Oqr6ChmiVLvhXyztyl7CUrgExLn/980sb+SQ/eDn5ZMhTPk7WjNVAsIEE+L1eb1FOD
 p4x3a+zLp4fBmUq9flnvoRNQcztrw+JYUC6so34N2HtODW+bBNwYd1ncy+vY+l76pwf1
 4DlP3tvQ7skvIRG16YaYHpcXN4Q146Sfxmag2SkAbFJLUVWPyoMgHPDdTVLgRL2rfnPO
 +tpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqM2V2K4Omx/JpY708+Icn+y4BX4rTm5H3xqMleXp1sE8wiWuh0tTIR2mGlZcrJKisZrFpvhEU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj0ss9Tcj6odnH1W67Cfy8OeXSrKlBGNJk8AQyJYaCHvCQ3gTq
 OzPFCVb/UwpaCa7YnIM6Eub+Jvv3mVWQ+HnLPvONEDxjt8kqIh/fL1paaRw7PcCp2WFH0YyASnv
 xdSxS6ppreFBxJLPSvK9cYGxKCiG9ao9IQ95suWHAhsgL0lTvp7QvoA==
X-Gm-Gg: AfdE7cmdXRPFQ0vebON/lIDY8pYDWf4WbeDL7SJBRcGRSUMOrocWOa6DCIJ/YNEZOol
 P8ZQG72EICzFUhF6Kz9b/4Zeq7gnun3QEGf/tT8hqgIZWcrPoNDshBmqZmFYgyDLVXz4aGtCXhN
 +3b92V5nZ34XvKcTkDS76r0nK5iJtA/qEQwKgm0mFqowfS6KqAbJMgjHKdqBiWotxXd8d9KX4mF
 XMp8zlpWR3hOhElruBewFIz5o/UcLmKFiMGw5CXtKT+utpVH63ikpSgugdO/ahz1cOr7J0=
X-Received: by 2002:a17:90b:1fc8:b0:37e:2005:6507 with SMTP id
 98e67ed59e1d1-38dc75f4cf5mr8813108a91.15.1783952706945; Mon, 13 Jul 2026
 07:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-6-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-6-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:24:16 -0600
X-Gm-Features: AVVi8CeNn0fSPrc2BPFZJW52fJV5Ts6xF6Q9-tkkF_wqSRACar1RvRVVUH8RHXc
Message-ID: <CAFLszTiafmnLwxq8On6vKo8jRs8LoOthUkA14SQnZxLmVZa-_w@mail.gmail.com>
Subject: Re: [PATCH 05/11] spl: Simplify xPL_BUILD conditional guard example
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> spl: Simplify xPL_BUILD conditional guard example
>
> The old meaning of the SPL_BUILD symbol has been transfered to a new
> XPL_BUILD symbol, leaving the SPL_BUILD symbol only to be defined for
> SPL builds, and not all xPL builds.
>
> Change to only use the SPL_BUILD symbol in the SPL code example to
> cleanup from an old SPL to XPL symbol rename.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> include/spl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
