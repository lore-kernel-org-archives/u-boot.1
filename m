Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB89C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB9982F14;
	Mon, 14 Jul 2025 19:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LoZWDG3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1A083043; Mon, 14 Jul 2025 19:06:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D1D82E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73d0a11674cso1098141a34.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752512764; x=1753117564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ed6tBNPv5+iPaCApKJcgQTU90XYVan/gZ8I8J+cSQXA=;
 b=LoZWDG3/TU4DPeXRtAPtTmymtukdnU3hUzfAOAsyG0QZKuE4rPftY3xLUpc6ScgN7g
 a78NU6RrmaO85M+JHFS1ghAoDWUv/7oZbBEFfNbHvcZzsBtwn30RudCM2J7nlEvBpMC1
 5k7OKON+9faE6DRWGL/wsn2dwZGR/bmYAHHws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512764; x=1753117564;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ed6tBNPv5+iPaCApKJcgQTU90XYVan/gZ8I8J+cSQXA=;
 b=VaxOCM+QKM2E0cWUv8l+iGcTmfNl41c8Ysg9Q8TduY+VhwifUODTxlPmQSFYeU9hrx
 yI3G4qABRr5gmHLk7qVzYZmbvomGBURjJMf9g9R14ZWNqktTucNH/ypb2yhH4cRxBXKJ
 33uplb13ptAZiH+x6LnxJDj112EAsDN6owf6wq/4SBY+Tcqwq67kL8n/fimqnud15CPt
 hHs4u5OlZGndcNH9SzzDFZoM+c0nvme7BSre3mi609K/DQkSeBVhvqLT2iZTQ7IPBjiy
 lgF5i5cWSx/KnJ6GIMbUY0uBGLBvg/fcMrP0aZzck+qDFujvQjL+yVJ368jwh4/SdOCM
 hYDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUDG0GAuxnV0e2ipmmqQ3zfsyxconYrqIDUzFLisgfbx/fbhalM1q91K20mn7Z5xXSOTmx6Lg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7JDs7wM4RZW3JdhYjy5985iXCIJt44wF8TPKOikE9unOCcWal
 C/rMnUfpjmR73H+zIBgI4vwLwbKbb0GVDuB3taqsw4JJKp4mBL4E0WgTUjU8KtpoCqog6bo0eHW
 Z8Mnm
X-Gm-Gg: ASbGnctBecjBM4hZ2R0AcPlAK5aagXU3f3IX+E10N0cwloRLNyA2S1z+J7miZ14NtbG
 LTVW5NI5vmICWA1bAmAHWBMC19XCEG2Y22beWo8KjUCuq9GZumQmRJI+HxTVoeHjzfITql45dYg
 7rDF3ylbByAn0HP50k8ktK/TUBjXFXo/ksk7fjbPupiNOy09P9Ik86Etu4BqFYtYmhfGDCQfjJy
 mAqpO/13PALD21Qi6XNTRFe71sMFJ34clcjYiGdLwJ5g2kE4ASecw6f534TjL2NYzM+LXaVvnWA
 xtU0NCsfTQoKSIfsWdGuLA5j+L7tlsCWU6ucXzNA0NfvVtHeiBcijgcLYvkR/QFJEyvRAcG/dwK
 LuoFY0Zjne6fDp54/QbxeDgOmcx8ZJHGBzmcaCMyNvjliiEzGhTTtrmVaCYMFRcdqwA==
X-Google-Smtp-Source: AGHT+IEkGtq9b6V394FEokf+E2YD8YrKTXzLnm4JghDqfEAF8caknYh7Iqrq+hR0o4+Ig+IrWP1GjQ==
X-Received: by 2002:a05:6830:8206:b0:73b:1efa:5f6d with SMTP id
 46e09a7af769-73cfb1fcb7cmr7313680a34.16.1752512763935; 
 Mon, 14 Jul 2025 10:06:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b69edsm1624526a34.61.2025.07.14.10.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 10:06:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>
In-Reply-To: <20250714142121.3266304-1-casey.connolly@linaro.org>
References: <20250714142121.3266304-1-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-main-20250714
Message-Id: <175251276267.177698.13561276176534038479.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 11:06:02 -0600
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

On Mon, 14 Jul 2025 16:18:51 +0200, Casey Connolly wrote:

> A few fixes and additions for you:
> 
> * Fix unused access in ufetch
> * Add missing clock for SM8650
> * Port the Linux SPMI GPIO driver and port over SM8550 (other platforms should follow)
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/27056
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


