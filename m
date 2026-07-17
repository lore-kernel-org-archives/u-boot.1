Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1A3C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 15:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3674384E61;
	Fri, 17 Jul 2026 17:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l5ttyr6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24C984E36; Fri, 17 Jul 2026 17:35:56 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A2784E36
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso412654166b.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784302551; cv=none;
 d=google.com; s=arc-20260327;
 b=p83ULWkAhwfQiUiHjhB9vcgCN8ygOUw1u/Yw4euvMBJXxANHUOqWqaPB7ylFc6w7Qc
 tnqtwaGvHPsLLtaPGKXHB39nxQUIFQ87Zu/LgLlAA9zIAYljwI2U5U76VeSBhoaPW3yu
 PNrP/XTFfMbGopaPc6keTXOnkES05fZHVWfN/l3BYohllFYziENp39P2h6eRlv+JBAZZ
 nYzYx60e8MK+kfk8o+Uc3HRle2vBj78OfA00YOXWp2/snEKAByvtciRBu7f0TpDZaXVc
 h+vU5co9GeBaW0Jk6r7TpEvFNwy9He3Pj31KVmc088YZivSfJKxIncX6PgdVESuh/o55
 oDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gD54HUHtiZhr/cgssW5sH5/BCsyTS6McEF7IUY+DOvE=;
 fh=RMotW0d5XlV4ufFtnrZdzQ0yk4gZppNtVCUWCpNgShU=;
 b=JhL10tX/nJ1+v3SPMEq9JO13thvGQ1Y2ox4jN/11uJoUUCx36Om68PmVlIvNGVbw4d
 PWoLEbAb6XFIAf7/hRp2F7gO+x/6OmdB2R8I3SMqxP/VTGLt++T3fPIVjE1/G1eS4Fmv
 ag06FY+C6ubIo4smTBZJ40Gbjv4fqxCXjoKzQi5YOl8GmFI10zBGh/0m5ZQhP1VZkoWK
 ohWnJsBojWttfsKV04wyS516ICT3I44lzJq5KAMN0kO7I7wf7wjfDOQaCJCp3B9vv8J4
 OyIJ829sng4MQpXNzEXLAnYGvVq+DROBMAnRT1viqXKZX2HiGZlZRg2anmCAgZ0REKTp
 WoLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784302551; x=1784907351; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gD54HUHtiZhr/cgssW5sH5/BCsyTS6McEF7IUY+DOvE=;
 b=l5ttyr6sAKKdvPAHaj/EdyblIpSlq5hhEHKRJKF3dLNpSWC3uRHOVwsIsgj9L3RsSf
 hvN/mdhd9O9AyE1fdBDQV5EK7gm22cZK/VXyjQboc34fvvLhD7fv25DPT2m/9oZV3fDt
 XffX3yUrOfS95VMQnwPvUeWcTR5x+c6VhrNik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784302551; x=1784907351;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gD54HUHtiZhr/cgssW5sH5/BCsyTS6McEF7IUY+DOvE=;
 b=bus/L27v0syME1IRwgkhj+2rOP39y+kmU14Lgc9R53Jd8/SllruOVEzpZQqvj7CyXI
 7IKpPgfP9b81JNv/BZydJkU6C0j1T/cyrLSAP163F8kGFTw2heUnp7ehYqXrH0FkZ3SL
 jD2zBrlzEQLBXsHBXTvGA9Fhvth+ZXwfrZfIlKlCPPRgGaYwotgEo0mx3ETDRvKfuAFO
 +q1eWEEpR0zD7iayludAPTEHOHSUrvwjXDVPRC68Ib4HymItKy50QfYyD5iheYvcilpZ
 0O+EubJDE15ObCywaZl5hOrdzb/cwDSpoddo0+L06SOnyxffNXx1wqTjuCHYBG83qKXb
 WKZg==
X-Gm-Message-State: AOJu0YxB+KonnHwaz0mxkXKq8vhOP/lkZ3d3TBMrY+tj8qIstnGyW2o2
 UppV5lqghjPvbXRKIxTTZ/UYvEAfQwddq/YR+dwVHC7bFS61fxzpYWtS67VuwoW+bKnPkxmuCr0
 e/1X/SiHuc/viEXxS5Oq0binhPfy2EtRq8e6Pwcm1
X-Gm-Gg: AfdE7ck+x2WXZSgeswMI9kZK0CPYzCcy0E3bnE8D/Gt98ZGUhdcc/WScHk/oWWCSJ3Z
 +vwqlHCUmg+OqilIy13KJGgzuyiuFKYIBqbZRl+XNHcvUDV1BU0bskND/Wpimsf2vM+Ipex7Wst
 Rtuot5/YVOy8iQmCbrr08tmXrjxP3g1ufLQ8txWwfUyl+ZxW4PVYBv1aMeAAGxX4HGAOqLj3JVq
 +hfhfB/QfEn5IP2HIPWv5yXSDiMlkgLGMA9qaDdEwrRznM3a5R1wkFXoE2H
X-Received: by 2002:a17:907:3e8d:b0:c16:5978:2624 with SMTP id
 a640c23a62f3a-c16b47b6d73mr141879466b.46.1784302551270; Fri, 17 Jul 2026
 08:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260710153343.1839357-1-aristo.chen@canonical.com>
 <20260710153343.1839357-3-aristo.chen@canonical.com>
In-Reply-To: <20260710153343.1839357-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 09:35:29 -0600
X-Gm-Features: AUfX_mxXMEyUQLHg3oQvJcNjxM-ni4HvyP6LGqhqEpCheTcF56iJB4yDu2n37aE
Message-ID: <CAFLszTh1krOBe0jxV=2TvZ60Tr0-c-qNgy1SsZXOeyV3Z0cB4w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] test: py: add regression test for
 fit_import_data() stale state
To: aristo.chen@canonical.com
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

On 2026-07-10T15:33:38, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: py: add regression test for fit_import_data() stale state
>
> Build an external-data FIT, remove the data-offset property from the
> second image so that only its data-size remains, and re-process the
> result with mkimage -F. mkimage must reject the malformed FIT with a
> clear diagnostic from the hashing stage. Previously the stale per-image
> state in fit_import_data() made the import copy the first image's data
> into the second image and abort without printing anything.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_import_data.py | 89 +++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
