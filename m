Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ED4CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4D88432A;
	Sat, 23 May 2026 10:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gsWRSmWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193A3844CF; Sat, 23 May 2026 10:20:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF1F83E76
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so1556381666b.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779524429; cv=none;
 d=google.com; s=arc-20240605;
 b=GVI3fVqlnXb5MhN5n80edQMs3HXAIeEfPlEp/BE+Ci9CSSMjJT0Z7OhNUNKWeUdud7
 x0MT6XZKFMdZvuqxE56/PM2Q+HXSmOtSWzlBaX0681iblluXeDyf74uADl5wv13l7L57
 rw3eHUf4kOKyMY1QyntuMyx1e2dc9OTLw/IF2a8+0esmOtxCvj+r5Tmeb4Rr9yEuopEw
 V8BzvMRLjQXW4gp+lcU14b7NEr7cSGL8VklsaZ3wDyjwEz2gK44gPnaTNe42gtn7V2oQ
 AY58alQw6KfGKV/mLIHrWoFjYAswBdTrrTQ0raDvDI5vWCaQs+jkKG6lj+RVkCfUNWRu
 cuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k7CscYLvooiwoLBwkLcBgqWnZ9YeHaN1RknkvwOQcGI=;
 fh=a8pxiSKm1OWzckLTBsZigBs4bvifQgzydoldMMBd8tg=;
 b=f4KqEMBklv7MDGWXc4li8PtLtwxjscB/M0oLdLxhy4H7i2EXwh8w4GOB+Lm2Zg/NI+
 +ySfKsR14kBIfAt80DzOxJ4Q8fVBgoTt1Uehj9vZ7DYQjFaxWJSOQZUzhK5V/FzgthO9
 xs6PpcY8PgMEQwfgJ/+TFjBf25Tfj/eMpB8QheOJQASV5PrR4ted0eeiZJ+pti4wXO8M
 HmpobwtZFBwOy5YYWzdb9yhHYKsdoWBQJ6Zfhzbc42eEqrq6+FvJjk9Ox4VQeSQUvJ6l
 hn3/LWyPCyibykx12EL9RlBJSf9HwZ0gYOWkvRWEJrZyJ1+ANAhKeot7MqfrKDKEpeUN
 Btqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779524429; x=1780129229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k7CscYLvooiwoLBwkLcBgqWnZ9YeHaN1RknkvwOQcGI=;
 b=gsWRSmWZXB5PyROpCtkl2kaqfpX6cqPHJXyfLrZ3EZ2No+3gks7E3kiohyyVKCsk61
 pyt6odO13QsPXmr8wuzwttRT8xXUkVMmE4Vr75rx347WhTC/9ruE15KwPJsiCloGEMcj
 Q95j0HGV/gplrW3DL5M1sfyz9hHDxada6AdJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779524429; x=1780129229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7CscYLvooiwoLBwkLcBgqWnZ9YeHaN1RknkvwOQcGI=;
 b=COGhoA7oNAE6FZnRBBy2gML3NJHsEdZ6gegi3w2zLpSlp1jk0EMhgsnmReKuURlArV
 mF2YqPGdyLgq4UEzu3nXkDURlKgdyBFloBTW/aL8NmsEyTu4duznHOlPYKfdw9f6KL1m
 tkIUjFv8OeNvZDa6oVjKxo9S/MnaBAuA92WtqjRyogVMRn89XbVoLP+uZc8R7owhV7K8
 zxYZrw4fJZTQma3g0RbVFI4v00mmZilr/FkxUj8DFYzuuhvNGsfpqJJQHcFwAlbk1Ar0
 52K3VyZhfGotiY5SOxiJv0KQHoP62jMl5X24N/iJRXzm39mnQR9YLEzZlQYuLPdZX0NY
 wviw==
X-Gm-Message-State: AOJu0YwQ9AkvHhitu6+QuxMDNwV7JfIaTEZyoHTHuFxT8idbdEUakpE5
 Prk+tiaVzRLPBdSjS074nPB8JpVkkyLVjF9nAJzL3CrzAoaozg1ySi4M00SNgTaOBZFAxF71DRW
 Ru91bepNF3mIKOhSUsxgiOK07+F1+qkyTpQJxfPhMdmDStoON1SE=
X-Gm-Gg: Acq92OEwvaxpdbPDJr/9Olb1fKk0rFicLJ9cyjTS/vdEJoAOi52RpCl6RFmNX0wCjTq
 IUGLyMPfXDtHsauz0YKUXCpGhEY9UB0jrm5aZ4wI8wEqlSFQ6TEbABBrJPYpIJ/DXpWommRffPl
 lr3snpiFq1kjt4wDWMZTZVVXVGrkh23OYyookSUWOBXeYLaB0t7vojyfDx9s3VEE+ah43JY0Jb5
 WlTSpWIqNYzUuTNg4A/BY8YU3PNeXjXWMyeQEQG20fqbaycuH2j0/6UN0zTeoGF6kgYOhx5POcw
 XaOizjEBE7RbONY6
X-Received: by 2002:a17:907:3f0c:b0:bd4:7bcd:cd2e with SMTP id
 a640c23a62f3a-bdd279d2bd8mr510840666b.34.1779524429569; Sat, 23 May 2026
 01:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
 <20260522153929.2472552-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260522153929.2472552-2-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 02:20:17 -0600
X-Gm-Features: AVHnY4LRH4VqFVhChohUKddyClXlQHm22xjr0lW92KafoOrf3ymNBH3G3i1Kuko
Message-ID: <CAFLszTg76VyxkhGc8h4vDKAtvG0ZL466+yjhtuA-zm-reyb6hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] cmd_date: make mk_date() static
To: Alexander.Feilke@ew.tq-group.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-22T15:39:21, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> cmd_date: make mk_date() static
>
> Use static as this function is not used externally.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> cmd/date.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
