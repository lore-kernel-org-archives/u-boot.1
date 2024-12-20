Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490BEE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E94A6803D2;
	Fri, 20 Dec 2024 05:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jT/5u+a1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C86803AB; Fri, 20 Dec 2024 05:05:05 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2F980087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso2025763a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667503; x=1735272303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wwHKsZWGgELg4HuzxzV9AXeJZtyQ2cekgdonbMCgQak=;
 b=jT/5u+a1lHqUskoshcvXt2BRUxO8OgZrPp0+ViukRtm36+TaBFJBIZtdXBTB7Gr4U2
 tzIOOeItliVN+T3UnA3mn8g5KKsjPHIclzfTvcfzED1qV5uf12b/pKMcB9LWFG4Dl9lZ
 L9504EQg7k2YfY4RIMVAQKBNeI56+sfId1xe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667503; x=1735272303;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wwHKsZWGgELg4HuzxzV9AXeJZtyQ2cekgdonbMCgQak=;
 b=ebMr0OQUZWxIrE6IRrw6ZagclNSmvWodAq9cKD2RWLh7JF4wI7qljCQan8a6f06NBY
 jitz1ObuBxF/jtbmtBsfiJ2proJ4+yoGMULwoXz8jf2Zqk+7ugL/eLcD7QS/i4VMVExD
 mb1t0kjKhG32oUS98vyjXTkEsVsvK4PBJVfesmyX6xWRxa3/pBCdcExq+wlzMkM1QI8O
 cnPcV60uJY9oHL8y++8hqrDy5AHafMA8sDH0cZ5k6mrWSwh08d/R+Rg/9pA8DmgiSpb/
 Yl+5LcZU3agpyYBbLipwAsnfVSoMLk85SWG19zCYQSp+l2KRoHRc+Ogd2tvT9pjEEOBP
 Fguw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5h++GKwS6Rf/gYOf8/DgeMXPYrrpiyxJn/jGTM2EoyqOtXlsAXqcCJAn6T7MnLfdMT0wccz4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7YAk+pHh4NwGQv8dSinLWjrH6FL5Iim/2jQY8zAReMds318FR
 40VRQyzR38D2vqWKkEdyWfBX7E4+IWCdXtqbsXWh3xvQ1adEzkGolvt7gw4kiefU3qCDlOm5I7o
 YQ4QH2sEVx8n0SEGoVTnaQTQ3KVKGK2OSN3Es
X-Gm-Gg: ASbGncvoYOt687BZKpbt54Fohh/kKAP0Ae+vnYNzTnq7gcn4XUK8qxQYbhgmvQLWkg1
 LW8HK+o1VLRVQ21Jt9DGRHu8gWw07jZ55Ecut+pk=
X-Google-Smtp-Source: AGHT+IGLsxj7iI9d/OlQT5GEo8/g4ZJfiYySzS/C3sH0PJZ4gSbDz6YrdGeZm636gGC6MNEdDU37uekXneWQc0jzidI=
X-Received: by 2002:a05:6402:1588:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d81dd9ce81mr2819545a12.13.1734667503411; Thu, 19 Dec 2024
 20:05:03 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:05:01 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-43-sjg@chromium.org>
References: <20241206023626.2456858-43-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:05:01 +0000
X-Google-Sender-Auth: sxOcdI2cMNLcbzgDLJqPVo4o-Ig
Message-ID: <CAFLszTjwcfzsGhU0pEeF4LAHTQG8bN5tQ3kXejHGXxpnk_9t0Q@mail.gmail.com>
Subject: Re: [PATCH v3 42/46] pxe: Collect the FDT in the bootflow
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

Move processing of the FDT so that it happens before booting. Add a test
to check that the FDT is now visible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c     | 22 +++++++++++++---------
 test/boot/bootflow.c |  6 +++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

Applied to sjg/master, thanks!
