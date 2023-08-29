Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED216C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 23:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8BCF864C3;
	Wed, 30 Aug 2023 01:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MMTqlV/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B10864EC; Wed, 30 Aug 2023 01:15:49 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2608648F
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 01:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5922380064bso56783367b3.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693350945; x=1693955745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHpVdqB4fptzotvEYibHKErBAq6Aspm8T+qYGPWO3nY=;
 b=MMTqlV/1EFXwwd5VBETFUluSJxyGLfpNqqPRaKd0OU0fdI57UGztmP7Gg2ROaXO1l3
 3/LJkSQv87I7ZUPuhsWvuzHyWb/BzNNZHmvnrwtAkO1Y4+CK/GIyHZMIAPM6rQDddp2L
 KVoSOMfdGzJhZQXA2R9qDJ2d6uGXS/SIqjGyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693350945; x=1693955745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHpVdqB4fptzotvEYibHKErBAq6Aspm8T+qYGPWO3nY=;
 b=KjrEAhETMKM+R92fSKAcfjlt1q+Fx0CXNBpV92nHEksRJQRjNUwyubLS/6R9iz3d3m
 VrTr2z3Dre6QBixa6+SKLM8WPoDGxJBCSEVS/lNwxNjv50e2DR1ja22Eru3zYX61u1mI
 joYzwuh9ReLfUeMiX+g+hP8t6qlpdaKCsO5ScLwajTrvhLtt131l4WsMO6Eq+My6gAmY
 iLDgn+oLNj/VZQU6ZpNwwPZLMgkEbpw+yI9RwtqbjpKxkgUSMIkVsxeD+Mn4gE0heqzB
 bu0j6ZCbGJfsFX/XTOxfnPbVdmY+17U9Gl7+JCRxPsWT3kHhJ7xJOwjO/NrYSdyIaCVo
 3MWg==
X-Gm-Message-State: AOJu0YxyjnYZTBD9NgyljMMNbXJLJ80Awb4VpqEIrBvdXC7Is+UtjIIh
 O768bxzxC1IgiDCfLv/eiOXDKhE23RANKW/gKw5vHw==
X-Google-Smtp-Source: AGHT+IFKQArO8JnovYCEgb3ojPIFzeI9Ylo6p2qooHrJeMZE2rdDR9T9osrC9qGscaalnz3X3fMx+w==
X-Received: by 2002:a81:5309:0:b0:55a:3ce9:dc3d with SMTP id
 h9-20020a815309000000b0055a3ce9dc3dmr612301ywb.13.1693350944980; 
 Tue, 29 Aug 2023 16:15:44 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 g188-20020a0dc4c5000000b0058c668e46cbsm3017325ywd.46.2023.08.29.16.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:15:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v11 00/15] Integrate EFI capsule tasks into U-Boot's build
 flow
Date: Tue, 29 Aug 2023 19:15:43 -0400
Message-Id: <169334277324.3085284.3185028999789447095.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 22 Aug 2023 23:09:53 +0530, Sughosh Ganu wrote:

> This patchset aims to bring two capsule related tasks under the U-Boot
> build flow.
> 
> The first task is related to generation of capsules. The capsules can
> be generated as part of U-Boot build, and this is being achieved
> through binman, by adding a capsule entry type. The capsules can be
> generated by specifying the capsule parameters as properties under the
> capsule entry node.
> 
> [...]

With v12 of that one patch and v11 of the rest, applied to u-boot/next, thanks!

-- 
Tom

