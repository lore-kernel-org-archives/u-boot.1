Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9262CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5921E848CF;
	Tue, 19 May 2026 18:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IyUe180B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024A2848D5; Tue, 19 May 2026 18:22:34 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB721848B9
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6948ff6b006so2073495eaf.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779207750; x=1779812550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TvaatAdtb0DP4HPyRtNQ3MaAXpO56Aw5p8dIuwB4AKs=;
 b=IyUe180BRoKNCkm59s/MuPrtIf/jPgmT7/bod1YEFlvvNydyeGu3I6ZWW0Z5UIRSsq
 g1nM7fD5A5xKTPiTKoIZqyvLKw6XJcwKRqhbp7qj4LIZIJwAjTIjBSZq3045yF+KTpZt
 +TOg0/mwE2ZTC5PI/4dAycpL7hlWp/0F1WFYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207750; x=1779812550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TvaatAdtb0DP4HPyRtNQ3MaAXpO56Aw5p8dIuwB4AKs=;
 b=F7WGKhIdYvx8mVLrxw9tS9fjYRu+BrDPghDfTot9A8TIDuzsQSSlTN0cq5M3ypxbFq
 zlsCAY6im7hOc2DGWUF5KYUGhn3M+JoZJckZR1IDASiTYbjZDw+LQmQsFv54eOoq3HF3
 /Vdx7beVsL3ToSs33edf68i2rlAOGaG9NS78ymOE9tn7A6oQ6A0GtWiaAr+3Pvjh8MGu
 7AtLJKwod924DCbKYysoKeIksCEgYBdZlvLWKfrSUnbc6tguNeImSC772AsG6e9J+1Re
 hx+YyYszwebhziON5WqBwyRXWsiD0fpwk570LFUmOY+riwyIdhq8Lp917NL4Hu2oDaEW
 mtSQ==
X-Gm-Message-State: AOJu0YzFGphF4rhGnolPqyhIrmvmbyUxg6vduwYuYVK8ioDWBuADS2ka
 4jmjiO+ulhbPqRh47k+WR9S4FaM0Gu0sP0ErqMz79ZoPBDhz63VFlTgGB4SZTNLmJ1NnE32PpfT
 xZxFpoNm2a3pb
X-Gm-Gg: Acq92OGo3KReTnEwEfWn/N+Zq3V5Nuc0uRf94czwD2UdZ3oOW7qsaid73Ov/3NSwP4n
 qRAxDA/+LEJBoOeM2NzGo+/9REk07+EwVMXRQIgfc4csqezN5ZzRsJeuwUl2AHaXlY7Di0pAp2+
 NyOD4ht32WkVBVqzEH6vbYkxP7ka0DQDN6ekVt8Urm2bpUdeaJxCVSOZCaf77vWa3QeNF2SS/Cc
 pSd3ETCZiMAVHI+vqSiW9Mcxl2vapgp7M3pcCXzgVjbl40AYCqX8kV7X+GHaZOKcyMoWa23sl65
 UPPZMi29yroUNs0G/pTmaSH3qSaGG1L2LJvPcDI74RY5t4uCrYXW9czHIAEuyT3tZJ5dokdZEuI
 jo66RO5tjN3wX9NWZ81lRI01GftWBjIfcFvz09i+F8/alo4KiXlTRhRWT7S/o8eiHptCYciijh8
 maQ0qfUqv8k7tqg6U4MqgQfsB1SRF2DiYG+4g5bFkUWbsPa3G6PqC/054o08uyA+YUePsjWJMWI
 iuLZI7hE5ZcTK3GIh1IiWkuHePnLRR0RL9fyFbJrPZRAT+yO4jfZw+/Xp6y4MgE4hiOCA7hbc0d
 Eq6OPTZd0A==
X-Received: by 2002:a05:6820:81c7:b0:69b:8c27:8a0 with SMTP id
 006d021491bc7-69c9bfcae95mr13373551eaf.55.1779207750019; 
 Tue, 19 May 2026 09:22:30 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d0462e85esm7500388eaf.6.2026.05.19.09.22.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 0/3] Clean up bloblist initialization
Date: Tue, 19 May 2026 10:20:53 -0600
Message-ID: <20260519162225.770071-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514175457.4047707-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
MIME-Version: 1.0
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

hEY ALL,

I've been sitting on this series for a bit (as the patch dates imply),
and I'm ready to move forward now with it.

This series does a few small but important cleanups to how we check for,
and initialize a bloblist. The first thing is that the way things are
done today, our HANDOFF code can only work with a fixed bloblist
location, so express that requirement in Kconfig. Next, we demote the
scary message about "Bloblist at ... not found" to a debug because we
most often see that because the bloblist doesn't (and can't) exist yet.
Finally, we remove bloblist_maybe_init and split this in to an exists
and a real init. This results in practically no growth (between 8 bytes
growth to 12 bytes saved, with some outliers saving much more thanks to
knowing it's impossible to have been passed a bloblist yet). This also
cleans up some of the code around checking for / knowing about a
bloblist existing.

Changes in v2:
- Pick up Raymond's tags on patches 1 and 2
- Correct the logic in the final patch to not break TPL passes SPL a
  bloblist (at a fixed location), as noticed by Raymond

-- 
Tom

