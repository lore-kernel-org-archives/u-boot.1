Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DD3F8DFC3
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB3783FC0;
	Thu, 16 Apr 2026 23:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vs5rczDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2397840AB; Thu, 16 Apr 2026 23:22:57 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE5E83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so159122166b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776374575; cv=none;
 d=google.com; s=arc-20240605;
 b=gIN3orEEVVe61IXmpQ7u+KkXcTOO2KvKqJEW9PI3PANpCPDOUMkSc4hNpYrcQZK45p
 7tuN+TvNRBno7V3pRMw8NnyzEhMZ7pi0ltxHcQR0y+tRTZRB+GTWF0p4ht+DSUONBHGM
 qPpRahTGlQ8o7vlY+VE388Ho2sY71DqQK+PWBd08gJb45p0gqQ7CYyZDd0db/HWeEoP8
 qntwddy9bIrY/CXRsbTvF2sRl61k25x5HFgFLk9Eu0iUG3IQ7hV9/DoEZm3n7tuKKkHa
 IPQEYbvoXSImQmj9UImqCpFaG6A9cSeWKiQf6qpTXafFceG9026YgJknr04MP/gPJxDv
 3OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jxznjHdK3fgDkNMGJE9g8BbOVzw45DEqc/+66/26+MI=;
 fh=T4PkicUUx6uDDJku+sxXk7XY6skMi90tHfLhn9SkZQc=;
 b=kMfcd+Xlcg6+VjZjDEoxdfewTCH0MhirYIsgcn0uXUJxp/yqq2yEiMFTf9z5qV/tQl
 DbQ0DPhxAqINjTaBraVjJa0O7x5NBdqCrKUISwiAADPUql+QJyoxSW2iePZZCOMVZZq5
 +xoMg/fItiegjlwu0pcwQdluI/6cs/CMFBtYsxtPblSyNuL9QrN2xpO0kwmzxv5k5T5K
 MgibxwcAfDpwBpV6Wgxy8lIAMmTz14tnyS6iG8PiSqoW60oeFeeFsELFJKCA0HjkJ6Xu
 p9hX/+rmO4HtMOFFwKMb3lfxR9Ph39exU9z/2c/dxVHZFOPcUAO2MQzGbemvi/2o31A2
 qeTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776374575; x=1776979375; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jxznjHdK3fgDkNMGJE9g8BbOVzw45DEqc/+66/26+MI=;
 b=Vs5rczDut0Q7LyzM7Ira4Xh4kt+jFU46r2tKPN8yyaXOC0MS5xiWX8PYyIf7iD9G2/
 pZl6sJ3h8WcNB44QTZ7GAyoCfiODs/GPRCJ0Fw3IhtG99IHIrY2AoqvZxy0gc9O4FrAD
 nIVfACHFcNEmUeL9mkfOKKJQOK0kBVaE5Bkfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776374575; x=1776979375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxznjHdK3fgDkNMGJE9g8BbOVzw45DEqc/+66/26+MI=;
 b=Iy6EquyW41laAv/lEWfST8LxAEX9RYuxsTNvsdBpXmuByfs2QpVPf8PbhxlK8nSGPq
 3+Numfd2I1Zfksyf5anqSX5HCnyMJnmfVnzIyj3k647S7cf3335qrBUwrcIjjPUOXWYy
 0ZgNhy0OVtu+oad7Uv2/KbfCuXEek1bs3q0xqIt7KhiAWzPtLkRU3V3baeZjU6ddzgkl
 klgB0RoZ5rt8vLusrS2O9p7w4ZNZoZVKccezuEF1iFKe/CQC5GR8M65az8hBvMWLb6Ur
 APy4FG+/gTefm5v3420K1ZuvG3c4RIB0bw2dscAKSLizf5h8VT2/eYysUvcOCKZGo1Rt
 gbnA==
X-Gm-Message-State: AOJu0YyX5uvB2Fpc5VuNg79/uF51ybBYw5EFOPCasCFcSbxFT+nrzVM9
 D/3vy8G2YrhUYZ0Zke8mSRmp8nVXw2dibHRjlNM44SQ3hCji0tjHeGB49seSPTD9WQBW5wFj3fP
 SPx/6IHxfMxWmyPeUgtFgyGBZi1VBR5HH4YwOo05K
X-Gm-Gg: AeBDievZENPYDM4rimMlj4mphVhCosmMavToNQB1FT63BTGKfyUj1gT6ewIx2R7daJL
 mCFtDXCNTXkiYB77/Xq5VQ9n8XIIn0+3rPrmjjSniR0wt/1O3cEBPJJqo/ZOgrP65JmmaFQgykQ
 ISfPfY60v3rFvGZwl/4tBG4i949j1cuYAPBctsrNlF8J9ebxbNcX3L/TtsJDPu2aQHf/opOEQ0N
 Cu3P60ZMGnnhf8sAxrxsLb0p6rtMl7F6S8I3dsviXAMQj6Y+EbVK/HpeaRtuGBsKcjucwuQ12Oo
 cNQejDtMAJER7pznHnPz
X-Received: by 2002:a17:907:6d08:b0:ba2:5314:f979 with SMTP id
 a640c23a62f3a-ba42140793bmr4098066b.6.1776374575301; Thu, 16 Apr 2026
 14:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
 <20260416-enable_fua-v3-1-84508de2bfd9@oss.qualcomm.com>
In-Reply-To: <20260416-enable_fua-v3-1-84508de2bfd9@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:22:42 +1200
X-Gm-Features: AQROBzBt0iUwWxWTs7T32py7Sw6O-5Leo0nQypUD5hh-sDyTXjrJPkHlAGeC5XQ
Message-ID: <CAFLszTj85ynec5=o+HyAXaAEW4rsgSdSpnrqq6cB+BtKbQnfVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Revert "scsi: sync cache on write"
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>
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

On 2026-04-16T09:10:45, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> Revert "scsi: sync cache on write"
>
> While the SYNC_CACHE approach prevents data loss during board resets,
> it causes system hangs during large sparse image flashing operations.
> This will be replaced with a FUA (Force Unit Access) approach in future
> commit, which achieves the same data integrity goal more efficiently.
>
> This reverts commit ffe4e6ab42d2534302be825e49a2d085acf80f30.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/scsi/scsi.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
