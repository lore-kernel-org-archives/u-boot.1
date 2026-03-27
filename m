Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7623E10F2875
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 23:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B837F83FA7;
	Sat, 28 Mar 2026 00:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TugaLf9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F278483EB3; Sat, 28 Mar 2026 00:06:32 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3105B83FA3
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so1179261fac.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774652789; x=1775257589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GdW/2sRwSkJf5qXnEZgLBCEeBl1dzJf49UeujRpvog0=;
 b=TugaLf9IEBOGwAHuMzYgwGSeMDkrO9TdjfuS0BD1v8O55/pA2FyguXkjiwiCCuylCv
 732H6o0+x45gwLoKq3qQaVk0D9grg/t2qcCD0ghUzs0sMqahrdTT2kGOhAdHsPHiDozR
 OxsQcJorkyJE/RYqi9YbkKknZU8SqbdXaTGdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652789; x=1775257589;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GdW/2sRwSkJf5qXnEZgLBCEeBl1dzJf49UeujRpvog0=;
 b=m+1ZJtpv6/0vY1fwAiLc+6dXLOHIFpEipJoSOlUirmWhU8t1MEtqOO8TJw3zFmH0ZU
 1naW0aAgTj30deQE9d9DQtpuxJ3YNG4uh+W/+n76p+Vd/pmjXWIz9LQ/Ha3IhNyOppGQ
 TmdI0Z2K/dOvcI6OZkRmy+5BrD2OPOsihmhFvD9i27tZAQ6syRJMLyvOzMhLzPlWApIx
 oU+MCzVqJtYut1n5hDmmlc4VlONjZ/JJDKq63syA4URRk0xdt54zHsiftNvKfjzLzAWL
 NRC4CS7q8nNxgqigoT5yAGmqQ6uWceZbi8ENtt0elcQTCC3c9TjMMqcG0Xda0OsK0FJl
 yBeg==
X-Gm-Message-State: AOJu0Yyd2Dj4FrtnPnlrteQ42YLDwb49gxXHZ80SUMVJtFY8L6o0Xq+R
 kFOTIS8CHyIRBfDPStQg43n7xMQOOBV6EUCsuN3CAQjTUugYZomlNLQDoH+porEtRslbVbr3EB+
 HB/CjEMM=
X-Gm-Gg: ATEYQzyPosPH2HCC6ewD0rD/Bz0vzvObq+p/O2eCYFcga8OPu4u+bMzROsmnXmXY5c0
 LnW+fzaH/R/17wdvK3J0ZpgNJlJeIGMkkZrKZyM3A4q/PjrOm9/9RE8zX/T4dw/NLlFxLipyNLb
 vV7kXgJs0VSGFpgalj+NEwQAnEBm1jnnHdrEOIuM4PJdKpueOphTWjdfrIUljcM+tg1pzyXgaWm
 4NEumCpX5RKo06Abaze+YQ+RSCwO1Z0zp8jJOcdtoAc4vXfMYAcR92z1SiXYZXMslLtZ4pvlHrS
 R6CoPgEIJaVNROmhOr9wJiwMfz0NSr64pdwFTB64ERzPPMDZcxW3zJzzniyVEaqBP/gj0oflFST
 myGDibYYcq47E9IXLVH+CLFPZsgFQPvb8zSdvKNVSsPNA8Ou9BC9UYdUoW+c5ty5DbvKlcrunfE
 nmAIWRYFuj6jkBWkoJFRthG8JvvwPvJrYBZ+/bp10R9oU1ZX012/q0pBI/rv/h5JKJGZakjD/f+
 +TAEU3YSEGGwJs/M6Mmgdo/riQCwrlkqIgocNnc4Rcl3no=
X-Received: by 2002:a05:6870:2046:b0:417:533b:79ac with SMTP id
 586e51a60fabf-41cec08d9f4mr2312269fac.9.1774652788934; 
 Fri, 27 Mar 2026 16:06:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04cf9e03sm421650fac.14.2026.03.27.16.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 16:06:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260315235320.304612-1-marek.vasut+renesas@mailbox.org>
References: <20260315235320.304612-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm: Drop unused __XSCALE__ section
Message-Id: <177465278802.41705.3659019828659085694.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 17:06:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 00:53:05 +0100, Marek Vasut wrote:

> The code in the __XSCALE__ section is unused, since there is no more
> XScale support in U-Boot. Remove the stale code. No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: Drop unused __XSCALE__ section
      commit: e20405860790d344035464e29e0eb237b42284ea
-- 
Tom


