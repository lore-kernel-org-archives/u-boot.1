Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E1E8536A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3125483DC9;
	Fri,  3 Apr 2026 15:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WWU/Wvve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D5083642; Fri,  3 Apr 2026 15:22:18 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012B484106
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so277279566b.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222535; cv=none;
 d=google.com; s=arc-20240605;
 b=B+ff65EWvEcA8dgNRdn6iHnPzZLPy8oyupT0EJ1ymGSawm66TdwvMWR8rLveTAMbdS
 gMxc4TMZdGqf2SNGQHC6x6jbEJoUy6pzqKVJYxrKrVXc6wAEjTyV4+wSiW0zg6y8w+Oe
 9R+EmMnbAoXaeJ40Ox0sFMdbTu3qp/RNNmx8udiBN8JPxI3R9cz/BWHyo0BIeIom/YlJ
 BVsU9XSk15NbkaZ+kNl2bWVpXCh9395bnmR9sxeVf77cKm7AhPQsif4LIiI6/5gPD08f
 XLl+gy5RbHn0gxUZSLeQfZWxTpjP2bpfACKp1Liu/SThFVPnFPGBSuceIbcKt3cpcRwo
 CTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wJ353VM6GGFoQkksQZ/fGTbFeFTgeGyCLoBGXMvL8Og=;
 fh=GoI+sirgUYAsy875+zYsOf9xP8IMILer9nqBWQEMKjo=;
 b=Tkll66yr4guQ3dIxXgmrKHohJtLsQJgn7VFIM4qX+qsBuhQGRkSyg0PwsGl3QXnZde
 6pw6qP8XfxfqVNN1ooinhhX6SwZzpSmgq06vk7CCWaKZHmWqwp792scoWL9nb3awouML
 Kjr66XAevVYAOMuPdzTVWpo2SxIkjvGfFEz8Rq46TiUjcyk3nMyqVIwrLjbDv42inLOg
 OaCGO/JTILLUpobWAXtwy2UfwAPA9y6eVn6foCQqC76YWxe9bhLs2BvclRH8si0kffg8
 f4RupSZbGhOxBOx8AI+fJeuBH0kS+MClL7ZX5bCEzbmpyBGrEH6ttdzNKCeEY8AI0Ijm
 QuwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222535; x=1775827335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wJ353VM6GGFoQkksQZ/fGTbFeFTgeGyCLoBGXMvL8Og=;
 b=WWU/WvverC0xAZZT1wstBcGC4QHF2cgC1PYO2POfEn5hR/WSF/Yt7cFSsZa5c5bV9b
 E5KabZ7emO2pD41nhS4FUbs2USktYK+SdDbHKLp36Ix7EpspKZy6XUe/iiLUckxTMjAl
 RiUilijAvgNUMVKX124hBtjpzraDdxyqCBXTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222535; x=1775827335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ353VM6GGFoQkksQZ/fGTbFeFTgeGyCLoBGXMvL8Og=;
 b=JmzKPvNogPdidZm1dBb9eu99IUAzkIl/5M6raCf5FtZodp9eD2hcRln1awMjucoQdw
 QRUtlBBp2VVmrYFjoz/NkigF1oUYWLvrY+OxgY5W9cM2m27aBZXIOKdTuc0qAIL1V+Ey
 xqMS3dKfcPZJrZi0l7wCD+O9fsuiIXxx8MqDg3mVIFZKdgkqM3/LP8XW4ErASKa+HRPX
 IIOA+sOsDmEHhxv3kvtXRvGAjsaIdKB/3rLzMr2bw4UwGLN/48Qj7RwvosL4+ctG65KM
 cvJNQY53et2eywvGkhEwDEbk/7J9pITxEjYC0pMXERGAxAGOQte/rzs3osblcDIPbOCH
 DN/A==
X-Gm-Message-State: AOJu0YxJB6MEocxTMmQKiF7nyGRwJFilDKVfWo6DLTANiFWTXBH+LXue
 IDG1YOKuhHsok46t1+oygGJlaA4aEbHegSPVFOVNDYvCUVs+2CL7C7I39Eaj9G/0NU+lXTDhiOO
 VVxQw4tj3KcdGLl4rKly3cq8APkVLZz/yC+Pxu9AG
X-Gm-Gg: AeBDievjDlOAxH5WDWn32wC8GSt6iRC9/ZW1NT9wl3cDQFpyNQxc/AOlpziRKePkfCh
 HkA+CuMlM9o56YJQEG2oxbV2aISxwsPOOF0CB5TzokGku9c4NGr+a/jh7bou76KgtZSQHuC8JR1
 k/VTjigRusJYldeNixW/S2Xlcdr0NfdYt1uzF2DpAPVFX6FvIUvI5851xdgsYHF/5HMjOtADjiW
 UP5skiqFoq19z01M3/uYaA5d1eAlE53kaJoFS72ynFlx1sOYm+eYDQosSF5clWLP9vHA+w6BdJD
 1s8dVw==
X-Received: by 2002:a17:906:5999:b0:b9c:4fc9:87db with SMTP id
 a640c23a62f3a-b9c679add8cmr102206766b.30.1775222535354; Fri, 03 Apr 2026
 06:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:22:01 -0600
X-Gm-Features: AQROBzCZiPzSt2H50B9c6T1E7nOXlGL2iZnvHJt5J6m7t80DP_Qg-pftTBMsHDU
Message-ID: <CAFLszThduP4SAskvH0MO1vM-=6o9-WLguPiHbw1RTiFAfoCpnw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] binman: collection: Set build_done on referenced
 entries
To: paul.henrys_ext@softathome.com
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 yan wang <yan.wang@softathome.com>, u-boot@lists.denx.de
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

On 2026-04-03T07:55:27, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> binman: collection: Set build_done on referenced entries
>
> The collection etype uses phandles in the 'content' property to
> reference other entries. Mark each referenced entry with build_done
> to avoid rebuilding the same entry data multiple times.
>
> This is important for cases where rebuilding may change the data
> content, e.g. due to timestamps or random IVs in encryption.
>
> Refactor GetContentsByPhandle() to return both the entry object and
> its data.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
> tools/binman/etype/collection.py | 8 ++++++--
>  tools/binman/etype/section.py    | 5 +++--
>  2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
