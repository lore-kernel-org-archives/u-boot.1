Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85305CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134A3834E1;
	Tue, 30 Sep 2025 16:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="og+GJ3el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E30802C1; Tue, 30 Sep 2025 16:13:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D99834E1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so142255366b.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759241621; x=1759846421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wt/mXDzh93yZJeA4OdAMAk6x2ad0RtqmSid4bj9OaYc=;
 b=og+GJ3elvqxWxh6dC6eyyKsoMNWuo/8ARBuEGaHKtRn9zfiBqBUeIG7vCzVDvpPLnv
 4IPR4VUagJll3qO/ShS0FD4An36B6Rok2Duwi3wBd5YWiBKL287fvz7aQ96TN+15LPUt
 wtrXwMRdmiqOUBczZAPdKIvxFangC3UtjHP98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759241621; x=1759846421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wt/mXDzh93yZJeA4OdAMAk6x2ad0RtqmSid4bj9OaYc=;
 b=bCG9XMuE2GnxQ/rSi9WEXo7gZ2I50xl+puqiQzodcs3SHq/lzxkf2Zy0VtocN4S2o7
 6JYmt6jd2AO2Sn45148aIWztSAnZL1MlBwveJq5XySr/V9h/viJ2d2jhyft9sOnFEQgl
 mDOPH9aG8pW4oRIc78JkzUA0vJV0Gola6cdULe039Mf6QOUkN85jZJXMtsOPTWh62SiV
 0Ye/hdZO8H6yC7zjg5j5Bwpc2MQE2/LUmVFZrUUuWLzbJOFkeuSepxdexdwvYtkmoM8T
 mmPUyBIwjIC1EQMGUbS1Kgj8V7ZqcLLIg2Wifnn95WwLM8bTQZ85xGrgG0V3m4oldquj
 v9fQ==
X-Gm-Message-State: AOJu0Yy/NuayyGrkChXT2Q/TgQ5nIT2Wy4M8GVNHtrxWFDNX2V+QmsZW
 G1L2x+bPfc6OcKNgXVGscb93Pu6efCCnQ/IZwFNY5nC3Ms9DTva9F98AKfVgtWmsuf42lqq/emK
 cV+4TWIjOmjouaRAcCP3NSlf/sTOIM/TO2cvuOhfq
X-Gm-Gg: ASbGncsZtmreV0QvvMNcZ9JzLIBdx7GLzuPc6EdL023APay+sqdqpodklR4yzkqdzfz
 FuB6wW11Y7pvlFjTRRv0c+q//I73UrUBn/ndpCm5GYYsoPWaNQH6xdqV5eRlkxcnfPk+s0+LxXS
 3dYYv+7g/vJuhOThtF0UsjBxo/+lp5J7hd6lKlAitifbCopDlfPVwa7jxmXAYgl6I1rFXZ5c0bW
 KNUztHNlRxhoNrBKUaa7+0nouA57Q==
X-Google-Smtp-Source: AGHT+IGS56Fgkf+Xe6c+t4sCbCJZgbWIHFotknCfcp1rcWl535Trw3kzeSHTwccwSl6tN3Om+3pCZ4g9cdUWLHFSCgg=
X-Received: by 2002:a17:907:da1:b0:b3e:e244:1d8 with SMTP id
 a640c23a62f3a-b3ee244020amr767914366b.34.1759241621350; Tue, 30 Sep 2025
 07:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250930110839.3470553-1-yegorslists@googlemail.com>
In-Reply-To: <20250930110839.3470553-1-yegorslists@googlemail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Sep 2025 08:13:29 -0600
X-Gm-Features: AS18NWAOariskwqOWfOToBOMDzMYw1p-MUzW6Sd8k0_C_cBkWxoD8-Kd-FxN5XQ
Message-ID: <CAFLszTh3izkJwkuvuaOza-BuHM6HyiZdnSP5mbB7rp2jAyb+Vg@mail.gmail.com>
Subject: Re: [PATCH] doc: develop: fix grammar and syntax
To: yegorslists@googlemail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On Tue, 30 Sept 2025 at 05:08, <yegorslists@googlemail.com> wrote:
>
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  doc/develop/devicetree/control.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks
