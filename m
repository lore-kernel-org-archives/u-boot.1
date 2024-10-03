Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB99CF8552
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020CF88FB9;
	Thu,  3 Oct 2024 04:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XPulLfxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4956688FAA; Thu,  3 Oct 2024 04:52:34 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E2288EC4
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb2824ddc2so4299876d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923951; x=1728528751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGu2FOYV3P8laRf8wnrjVvw5pi0s8o0EVrfK6iQj+Pk=;
 b=XPulLfxXySzrn8zsy7p90H/Aww1E/kQsq1KazWyi/jT4j8xKZRgPDKlaAdd1Ug1aBw
 vgUZ8t6WA7TDAjqJ3GsEywFzxHLkym6tkghb9dn9DNLcDc8rc048b9wKfughXIR5SOUI
 +sUVWZxH0hVkSCW6yCSXwNk5BccJdd67Ib5eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923951; x=1728528751;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGu2FOYV3P8laRf8wnrjVvw5pi0s8o0EVrfK6iQj+Pk=;
 b=Dwx5CXHh5mK1iAm/nczdg1sJ5drO2FM0s4tAJXyWop9OXFasKNx0xiFnLLIl8fWg2d
 win1xDSc5n0LV3e3s79wHb6lF55HhOvg8YAiAjC+WfpD4ulgPo/kYk8J8Oc4B0BSA0PD
 h8zEGVR1OU/WJz2zRb60+V6s7/9CoW32CBkkhu8b7MRQQWxrxVYHKDigpgFChXdUTOtY
 dhws3AKUVfRNKYDxFD0cR5tt319snxADZfSwK4ygfgDBICoTxdz5ipBWHxehF8bgBNj5
 D1C7mkDNXq8iQpIdBEB56diLl/s6mEowiPuSRndATRBCme4vCSH1UKDy/Dm2q+SUx8Mf
 OoeA==
X-Gm-Message-State: AOJu0YwLPrYUl0mIgru1jh8WQ9b+vtzjT99DZrRwJ/XpftRbWIU0Nemk
 wE19OZ//SdeYOomQwFrAI5VMGe/ECnC/Dm+WWxhaFQJrcczttlphCQTtUvlC9SU=
X-Google-Smtp-Source: AGHT+IEs+Yyd9NM8LYTNKG7PwVDHzgIAwHuQDw2mv0JA9Fue2xl5fC/dqXqt1pwcK8fguzxP7NLAhQ==
X-Received: by 2002:a05:6214:4807:b0:6cb:2e97:6235 with SMTP id
 6a1803df08f44-6cb81cc67aemr85470616d6.49.1727923951112; 
 Wed, 02 Oct 2024 19:52:31 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com, Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 1/2] bootm: adjust the print format
Message-Id: <172792394808.1516896.5692674491695691567.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 25 Aug 2024 14:26:07 +0200, Dario Binacchi wrote:

> All three addresses printed are in hexadecimal format, but only the
> first two have the "0x" prefix. The patch aligns the format of the
> "end" address with the other two by adding the "0x" prefix.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


