Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017E1FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDCD8426E;
	Tue, 28 Apr 2026 16:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F6+QtrVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D128B842A2; Tue, 28 Apr 2026 16:02:11 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFA484150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6764e36dc88so13145623a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384929; cv=none;
 d=google.com; s=arc-20240605;
 b=b3XAKQquaY/rMwPAUr97zXwLLPoDN7L1auUKckAn7SBMm5FXuQNUmxnySxq9YPGvsv
 kFJt3NZ2q3XTdsarkZbtxueSM2j+PMbifoY5vSUTuOJoWWumO6BrhS1+n8PDK8J6k6Ws
 /lsgT5R64vuxj/6Ljlx5FMbQLWt2Wdssa5SXsl0mxSyDg6HhztZEroeyBk0lHr8F7IOR
 O7b6YP4VdwC2qwXv9agpvjw0LMMSf3O0iNIqfyui5UkLFYfBEQ4DyAV6gGYv+81fcpPl
 UUkQ0cIL83gZbHvH9kmQhrOf0BOupt+03gDEYjn1StUCkg+caC8IVXTKVZ3T7pVh8pGc
 HYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pKhk5eMpz7TOs/ob4iKneezRoPBULF7M9T4ZpfjWFIs=;
 fh=eYnzUsMFCBOD6UP2RXZDEuHlv5UulYA+pv7GYcI4UVA=;
 b=lNyoQz4wVmk9r8eDqiQb53aW0t9HKb75v56qDaqrn9fmZfmnaSu1LLzF3cHML2zr/j
 xmiI7rkgsJ1ytuWAgUt+XxMBq176pmSdwaRrvCYh+5k2f3/AYUyKM4Jo3lx194XCs+eW
 7RDwwRGKE9qyGdTC0gs1W55Nu55h0v0wKv+1T32XN6yjPxsMzBcnZSdiV4ihZpLFZ4T3
 pi86bbcQNJspeAgqCsvVDLHTX1+EGEIIpGe7MZe0g4KEs0TjiDyiYA0k9PfsrtRVbpeH
 xV4FBZdWU/i4s2fmS/YneJCP3M4dKlvTGlk1wMv+0Y5yMsq3l1gV2pceewFO5TxNK8y0
 4ivg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777384929; x=1777989729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKhk5eMpz7TOs/ob4iKneezRoPBULF7M9T4ZpfjWFIs=;
 b=F6+QtrVsKoRgaKGeIdNUvq0pp3yDIH5ltkhPegAib3eZ9Z9355rf6/sYHzTB+Nq+0g
 6oN785zQDBLebsUUIq3jYK/S+lajyHICAZkI1vhpv3xXGMzE+oODWcgOpPRofQLtzsYp
 JEYvzg96IRvre3fm/qyeMN8mOfZm4u21ICwmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384929; x=1777989729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKhk5eMpz7TOs/ob4iKneezRoPBULF7M9T4ZpfjWFIs=;
 b=d3NQDiYoWf/NT/QDnbXDDbPRp2npYPZtRPDZRijYgup7OJCAINfiYXfXkv3St9t6yZ
 rqsWRgHn2JK8is9MVTet6D3mOAxF9sqyXro9mtgbjhM5dlL8zvoZnPyGiXl2WWGcxlyy
 DBe0gcEVtdvNQEqrBoMY6SXVbdy3bwsDnvB5gKRJdsmtH/5h8KP1RR0FPLwZwR9UqP6t
 KKXLnLCLZH08iBaumQSeZvIUIjY7VJDosukinIukw0InZMEACgHRNrBnOIbnfgJovXmE
 CEEKT7jM9Aqb7vW8g7jaz5iChnKU8sbH7bprvxJTAOg+3zoKnSQYySYq44Q+cUhs3nx8
 s8zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KwmSPB6V3jGyq18iWkhpZi4g1zmxLv5sBcIIN5ATvMQiKmpt+Hs5aUDXDONog0x2O20y8R10=@lists.denx.de
X-Gm-Message-State: AOJu0YxHp0tTW+7PXRWh3ru4t2S5v254W/buz2ybM0ts6XTRBz6EIGqb
 wYEn7CEWpPAE0DEFhGFepqjFvaQSPZgqfhfflt6KOX9ePdB05RZU8KZHuTFWI+3dMO/p3zYjskD
 Gb4h4e1dsUHecipQ81w187yY0+G0FQDElBx+UHFj0mzfX6LVrKTc=
X-Gm-Gg: AeBDietSTiiyWcHEVuooK09YRkD6sYFlhrSavqrdshxQA9pMTipkpxmzR0Idm0tzpOL
 eLD0rK/mqN56B91fhrdsDMAHpcmSe3Sj1CqFnQ5ncCvqE/BhyUlpuB76vmBdwkdJnud2bwr0K3y
 hSup+7Y1vY2s2cFOcZRM38Uy2M25iWLc8gYms9XqZvRIJ98RwDCmd0vQAsJXBh85EAkJj/ljU6r
 RQRCVbL7P6ZjR3bZF6EwvsXphXKElZjIBENNgokl46VuZLoHg7Ad3ooRnkAPUEDufeKaNYXb8ss
 +k6UkPxMd1zHc0Fs
X-Received: by 2002:a17:907:da15:b0:ba4:ebe4:d2f2 with SMTP id
 a640c23a62f3a-bb805facc26mr166026366b.4.1777384929262; Tue, 28 Apr 2026
 07:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260424084546.260786-1-francesco@dolcini.it>
In-Reply-To: <20260424084546.260786-1-francesco@dolcini.it>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:01:55 -0600
X-Gm-Features: AVHnY4LgD9Aaqw_gze1iBjEZ33LI097KJusR15td3cTOAjoflYslwrBrseJJNLQ
Message-ID: <CAFLszTjPfWy-ockG0ON0-xptX4Gpbr-zezmOWRc_+teAiw+NJQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: ds1307: Remove legacy non-DM code
To: francesco@dolcini.it
Cc: Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
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

On 2026-04-24T08:45:44, Francesco Dolcini <francesco@dolcini.it> wrote:
> rtc: ds1307: Remove legacy non-DM code
>
> The DS1307 driver depends on DM_RTC since commit d425d6056e01 ("rtc: Add
> DM support to ds1307"), remove the related obsolete code.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> drivers/rtc/ds1307.c | 152 ---------------------------------------------------
>  1 file changed, 152 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
