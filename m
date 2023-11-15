Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3258C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D63870F2;
	Wed, 15 Nov 2023 14:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LHQbgWaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F3B87120; Wed, 15 Nov 2023 14:16:57 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F838615A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso991803666b.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054214; x=1700659014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YsLYr/fVOqs6jHIehgO8ZHyKWxJyuJCTDOz7rGFKbtw=;
 b=LHQbgWaFb8HwdT/7WbQ3F6Bo3oWgbKf1sd81Tb4Gn2RdOy8W5gTHlCfrjSu1Ck+HUt
 hBsWh+3ONfKS6XHPqKKV73fA9rdmHpqupFH019+1/drzsID6cRPgzEwP3oZ6Hp1lgyfY
 N4MyvmcABOsRM11EjqHCDmZpuVUIMDoDL5TwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054214; x=1700659014;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsLYr/fVOqs6jHIehgO8ZHyKWxJyuJCTDOz7rGFKbtw=;
 b=Yrmaa5GdZOjvW/ORphCLTDRNgKlpaXw6GB4HWusMEDUIU7FR483hI5C/8mV3hFQ2Un
 VDXqvWi5bF2pDrkBKChLHJerld8C//MF1q372kUtDzZeelzuZW0rsPtb2CLgmbptSf62
 yqwS35w1NEdr+OUg9INOzd6+KkNpmbGZPU8QtVALXSDpqg6HRUgZqdkL7fj/701zSLJB
 ihGXeXhr1oMBGKNLLMXVvRf7GeI1/Cf44cD0BO/2EhbOdzN5hFqmQBMqm2TxI26ZZzve
 ny85u3ePcImQd6yWQKTRFYVrFFKvJ5bt7waKv1orlvU2RXnFiFocouj70PhfHhLdcJOS
 9AKw==
X-Gm-Message-State: AOJu0YxxCbk3jvCl5IAiTdRTjD39uHqUJj0X46JsR22DAa8Uuvo7silS
 FKLD2c7a8Lia2oxoCct13HOCe0J8Ne8BUWH9ptICh3Xo9fxl0OuAJNU=
X-Google-Smtp-Source: AGHT+IH0ocVZYM22lTu/xzZPITy3v6oP5qbOplUxz9Rm/xSV0xnYmmHdzSRVn+tQup2jUSS8waf18NngBWy9C8aZjlM=
X-Received: by 2002:a17:906:d217:b0:9be:3c7e:7f38 with SMTP id
 w23-20020a170906d21700b009be3c7e7f38mr8997934ejz.10.1700054214156; Wed, 15
 Nov 2023 05:16:54 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:16:53 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2YgwAzsG2kHZZWgy8p126hBH_r0r55nParwOt5wjuW+g@mail.gmail.com>
References: <CAPnjgZ2YgwAzsG2kHZZWgy8p126hBH_r0r55nParwOt5wjuW+g@mail.gmail.com>
 <20231107101729.1.I843fdbc83d3f8522e4c43d47c72825b388643ac6@changeid>
Date: Wed, 15 Nov 2023 05:16:53 -0800
X-Google-Sender-Auth: iPCdaeRqQPVrPSaGNTkf31LHMOk
Message-ID: <CAPnjgZ3EQGbHMWuKM1d8+Whs6FWZ4SGoOO-9=N51EPXsswqWwQ@mail.gmail.com>
Subject: Re: [PATCH] bootstage: Correct exhasuted typo
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, deffo@gmx.de, Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
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

On Tue, 7 Nov 2023 at 02:18, Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Correct this typo in the warning message shown when no more bootstage
> records can be added.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> I just cherry-pick the Simon's patch in the branch fix-bs-working
> of the dm custodian git but it is not yet present in patchwork.
>
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/8810b8dd3d233978c15203b23420fa819ab1e791

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you


>
> Regards
>
> Patrick
>
>  common/bootstage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Applied to u-boot-dm, thanks!
