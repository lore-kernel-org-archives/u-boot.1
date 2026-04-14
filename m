Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A8F9D0EF
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 19:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E49A84253;
	Tue, 14 Apr 2026 21:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tc7fi6di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8040D8424E; Tue, 14 Apr 2026 21:02:42 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDC383015
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 21:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4795222965cso1450251b6e.1
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776193356; x=1776798156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7r1gAPK48bTI1yj7NvEFx3T4+xlqeK/G3qbe/2RBbY=;
 b=Tc7fi6diLsiYQHh6OE+O8h9PlRWGmspZAT8oq6+LJu2Q+NrUO35D4jMTOTCkLTqDSg
 CEaQE7Sw5/f2+fZ/mzYv7097zUVz4QW1OD1KW5O96xyUGL5XhYURwJnfY5pqCAMldPpy
 z4QiF6MiwXhrGDv92TNKxHH5TBPzEdCgJ123U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776193356; x=1776798156;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7r1gAPK48bTI1yj7NvEFx3T4+xlqeK/G3qbe/2RBbY=;
 b=IQbbh+VSixZej4EOp+7ge/4Gzcmk7dFTF2WFtsRwfE+h+JCU6PYrFlY3nGk1iDy/bU
 EWTSFPBG4UU2bsEjTiU1zkhOr9utarv+BH7/0qX64tvTuL7tcJouB30LwTuz9xMktlBj
 GsbusDRwpUQf12qKWN5Jbyyo+Z6DdSP2IXXmxZrqXzjunoZelIepOEUNPDUd2xaVDd4D
 Touw7iB8zWTFr82BXUbePVXUU9oaTeeg38m2QuJ6+6qtaOPF4YDveKE+O2jy9PzDblwW
 yy1lpEDgBX2pt1l8veAaUt79UlHpH/tHMKQ83jgngruPFFndGh0J6SAEu7DGtjb01aub
 EXVA==
X-Gm-Message-State: AOJu0Yzpm7sz20xGYdFH6UJ/DGh67eSQR6agtDQk77OPW0MokHREL2Pa
 Rp3G/mCaE0WOYYfTg2WKfduok/V1t8UBUwzl4CLvQb0iIbZ/11QYKbjsdHiu2qRJYwA=
X-Gm-Gg: AeBDies7WG8H79/pSYJjwuwiUfJQCNoXXolZG142/ded1SpEZn79e7W6hKhw+UaXw/7
 gtdsFRAbZIbRBhtaryynVSQI/FMYjlzsC+undlSgeoofGMEDSqye95r6gBNRjsg0N3sWdkKx7EW
 Q14NGkixEWANMTFP5p8cFEE8pvM0+I3doE+18buI/nCsdAmvWLVlzWCIE9CpSxjae58CaxkfFZf
 oMAx4GVoxWzqqVzgKLvcZq1DKkPz/BUW+abmCPKCH48zZcR1RAaPy5ItEK7+sLZE4Z/eev+u0C9
 EbytMphQcnCYU9aZbv9hs5vTC4DN5tbQeWVzaehzjwTxlQevToUVWIToXBoZoQ2uTKhq88mZC7E
 dZVljI18KjYflwuKOXnqOscvLG4rpur0FQ0Coc/gvHqgGM984MpyXXWbA61AShzy9mgSGY7tcSB
 DB7BrYfY2In6GzsBEinjVxaLCJ/lmK1IVpfcvSoISqjMdYJRo9I1Vf9CUIagPQEojcF+Dn7GudI
 shOrKtIRKHb2NJ7dLdMvCXlaCFSt09sbX20K0Qd63bSCCwdsg6IBPEh8WWl
X-Received: by 2002:a05:6808:c162:b0:46a:c987:ba00 with SMTP id
 5614622812f47-4789e7222f1mr10537657b6e.32.1776193354247; 
 Tue, 14 Apr 2026 12:02:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a080b96esm8586468b6e.3.2026.04.14.12.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 12:02:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
In-Reply-To: <20260321134626.516665-1-sjg@chromium.org>
References: <20260321134626.516665-1-sjg@chromium.org>
Subject: Re: [PATCH 0/2] A few linker-list fixes
Message-Id: <177619335323.2826564.12276159416545433051.b4-ty@konsulko.com>
Date: Tue, 14 Apr 2026 13:02:33 -0600
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

On Sat, 21 Mar 2026 07:46:22 -0600, Simon Glass wrote:

> This series includes two patches to fix aignment problems with linker
> lists. In certain circumstances these can cause the drivers list to be
> non-contiguous, causing crashes, hangs, etc.
> 
> 
> Simon Glass (2):
>   linker_lists: Fix end-marker alignment to prevent padding
>   dm: Fix linker list alignment for ll_entry_get()
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] linker_lists: Fix end-marker alignment to prevent padding
      commit: f9b507748080c2ef52d516345c2431182a83f19f
[2/2] dm: Fix linker list alignment for ll_entry_get()
      commit: a6672a4804debd9de4f7bcc1d2f2a07ff30e1eed
-- 
Tom


