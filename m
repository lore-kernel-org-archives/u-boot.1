Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EE0CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CCA83093;
	Tue, 19 Aug 2025 21:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NnL21+ja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB922830B4; Tue, 19 Aug 2025 21:43:16 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CED82F30
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74381e207a0so3087657a34.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632593; x=1756237393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiyFcH4Ltw64BP/DT9qssvHsQzxcvfeIPHhs/wbALYc=;
 b=NnL21+jasqOsT+goEMk6HHhSBhKBbWUisjNolYF3IhN41u0OaYs8Ab2PwihLxel/Hv
 sJeaIwuYzwZFcQMZV3nzPcdah8RqqKQbmFUhH42LrMiEJoJLUroGOm3wcdTGaz/sNtOz
 GGVDM1T2KshCN03KSzLsmuvziF/JGviDkB7ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632593; x=1756237393;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiyFcH4Ltw64BP/DT9qssvHsQzxcvfeIPHhs/wbALYc=;
 b=r9FUWhdfDsP4m0t1IZ8Hl02P+zBkyoKRJTKb/HkIxoYBo2H3pI+9+399jbGBOmun9H
 m+SdVBq+X7Fvwc0ZIcB2XsNFogY86GWEpS8o69h7IhjPCrsbzucPjCEljHklbNioET2Z
 jFIOwFKJggCXdbUvndHjuVI4+DjnRuSq0yfTeqbVdrO8c2U1ezdn86CMhS/YLGzXrFYJ
 bJ7Fc8O0FvB5pi1tlwuSj94A4Q2SfOLx4ZHjQrC0+jU7LChec6X7ZfjX368Hmk58dMFl
 /QE4yAxiJHJb0UE85Thw+iWq7t+9Qlj8l/X4HQtkehlx+vISmtUr9YaSO9Ew6sOSVSWK
 mryg==
X-Gm-Message-State: AOJu0Yw0hMrDsPl54yCemUJL7XsRTjjUeIvifZsYCFZt834VycNrwx73
 jsqH0hIcV/TDqmM3hWBkXZ0VRYGoxNasHg3Y4Pe69hmulPJVmeMLpXt3vN2aq3UK+3coNvqtZJC
 0wMOJ0NA=
X-Gm-Gg: ASbGncvje06IgsKcba8oz2ZNRE/NeUbXXfs8ToA0qsjsL45bm+jwUV8dMy+3AOlIIl9
 SpwQurnJL3twMXDoGUOGLUDJmcHMVvOk5HglpWusLuB1A/YShckQrqy2jK7yFKaoOsBDDCzU7dT
 261c5lb/JU4BwX+Y47jtG96letudiNyfHtUOdGznrmIL1japvH1ZKkiop0JOX5dgcOPOo5aEWsc
 d1BhkwaU6nFSgtRkzXa2uuTd0dZYce4mqW4eeK0SQ5EJWh5noGaAq15373EuzUOTZY4kgK/QeSx
 8fOmAbzstgNf17sxIKVEgld1+4DvO/m5Ktc581zVZQo8UwRkdjr6VttWGd/IKoOCEmCZI78OuWE
 sOt+3nzuGVrpn/NeUokAy+BapEJZ+WBVfXibMOoL8LapND18sfMxCtkk=
X-Google-Smtp-Source: AGHT+IEWISCdoLXG1MrVlZEQUqIVLTs5UjyKj6ODl4fVLT3uZzuqWWepGiAnDKcB2r4zSkZ1pcxHgg==
X-Received: by 2002:a05:6830:2a0d:b0:73b:2617:87f1 with SMTP id
 46e09a7af769-744ebc21da8mr293072a34.28.1755632593357; 
 Tue, 19 Aug 2025 12:43:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
References: <20250808-remoteproc_tik3-v1-0-f7dae0b177b2@linaro.org>
Subject: Re: [PATCH 0/2] remoteproc: k3: Fix two Smatch issue reports
Message-Id: <175563259227.3359676.1630368240944038132.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 08 Aug 2025 13:00:21 +0100, Andrew Goodbody wrote:

> Smatch reported two issues, firstly attempting to compare a u8 to a 16
> bit macro and secondly a potentially uninitialised variable.
> 
> 

Applied to u-boot/next, thanks!

[1/2] remoteproc: ti_k3_arm64: Cannot set or compare u8 to 16bits
      commit: f780ad4be9fe84fbdd874455c7518e0576e4d845
[2/2] remoteproc: k3-r5: Ensure ret is initialised
      commit: c9cd480b5c5496b809d954424ce3554673c278d3
-- 
Tom


