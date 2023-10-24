Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035BDC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF97879B0;
	Tue, 24 Oct 2023 20:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S6IuZDvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C74879B8; Tue, 24 Oct 2023 20:04:27 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8580E8798C
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso46327207b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MQohYwNVHV1ESqEqN3kIHeQaANym8zINnLZ0JKVLeCg=;
 b=S6IuZDvAm/ggNmNBPtNGQFHpktNUzpA3yTC232faZ40B8iDGX+yBJoHYRQC00Zd9OE
 9/P0vmKIBL2MkMPikEvwPHayp4UfwDT8ObqkLcyXjUfS/cpjbfV7HAGnxZMH/LiNWXPA
 j2LpQUW1lBYTFTo+6BAqPVSb8+treiFitPG0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQohYwNVHV1ESqEqN3kIHeQaANym8zINnLZ0JKVLeCg=;
 b=bEdcEbvQ8H8WfTGuaZpRUiaetk4WW069SWlYNLl/Ib1tlVALn6kZwjIV8RusaqeZRh
 OqsukkVmRhwCXmnvkOAaZQbGPR7Fjjw/5tSzLXYm3qdYZn27W9JaBNOC8EhDPClrdy8r
 TmFGhvgD9OHr+0l9Oxgo1FzO5QJNSQUuJMocyiRoNy++cRpQk6wElICpWrQwZPo+StZy
 mUcBDzWf0C/FMCjuNH3RqcwKNRolNNB6PmidSlCrMZL4bCXQwGJNm5UsW9FoIyYxPMUX
 W8dnpRxqrEUgHZ+rD5FLZgOxteykld5BNjskXssc72qVXrQZbQv32sjVFzHKePB0fSlx
 qSNA==
X-Gm-Message-State: AOJu0YzFk3Ias1jkNpVgDbMu1maFAETQQG/UhtdyMXqeksMEiaM4UEcV
 muzPZRzcC5AcTH8jCzPCApE1inECHO09BFzZUrCt/w==
X-Google-Smtp-Source: AGHT+IEekTL7dud9stbtsNZQZ5mHvLiiTwdb/IFFfeqoi25ZpCRmfPjC9HFGgUcyZVvaJqYou720eOPCwOrq+IrwA9g=
X-Received: by 2002:a0d:d5c4:0:b0:59e:7f14:4b48 with SMTP id
 x187-20020a0dd5c4000000b0059e7f144b48mr12561227ywd.41.1698170658997; Tue, 24
 Oct 2023 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231024071916.39523-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231024071916.39523-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:03:34 -0700
Message-ID: <CAPnjgZ1vRBwW2zuSo63PFEUzRCJtU+cgeiWv1v_+-t1iWmNdOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mkimage: do not write incorrect error message
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.denx.de
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

On Tue, 24 Oct 2023 at 00:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When running 'mkimage -l' is called for a valid StarFive file an error
> message "Error: invalid marker bytes" is written by the Renesas SPKG
> driver.
>
> mkimage -l may be invoked without specifying an image type. In this case
> mkimage iterates over all image type drivers to find the one that matches.
> None of the non-matching drivers should write an error message.
>
> Fix the Renesas SPKG driver.
>
> Fixes: afdfcb11f97c ("tools: spkgimage: add Renesas SPKG format")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/renesas_spkgimage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
