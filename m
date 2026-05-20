Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ACBCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 09:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDA88460E;
	Wed, 20 May 2026 11:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pU5rjgSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2C2846E6; Wed, 20 May 2026 11:14:34 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D238D844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 11:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso4308181f8f.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779268472; x=1779873272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eZX9G5OYgmlmPqPfXIuxzLuZzFwmhhjZDBi+tayHOIw=;
 b=pU5rjgSC7gpFsfWYLfqU4eNvwX7FmajUmGG23yEENbnv2LlLkdzywweb3eyshiRosF
 Qk22KD7yITLF/IKNoyBXZQ/6gnAVsxw+mDmBWIUsV7HIzhnaRxJpQj1axo0/s8fp51ck
 +Fxs28mHDkeYfpXc90KOtQMo/3/I/1gSJQlK6EI1MG4CNa3qixDuPl9C3hbUwzIs5681
 YGNHr+SFmg3btXABq4R3/fl8Kx6ytC4/xtK+jAS+32lZXfCP4QLAuqNBC/kK9m8anz7W
 tVv2EDy+UX5X3I+In6CLNuOSutdjar9FPxWOCwDN7CsoyMybRalVXxIkNeTBZZ09AGvy
 wKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268472; x=1779873272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZX9G5OYgmlmPqPfXIuxzLuZzFwmhhjZDBi+tayHOIw=;
 b=fS5geN5dI0jFaYTfgFWqX1OY9Ik8OtZMhS13cSBrYbQBD8iqjq2mhTQcLbdHKfehiO
 UN413qf6eEjRF6rRg395lZHewX8UqtEXj0ejDZODFVjpSOIKm9eLn0g54LVf+n3z6IIo
 FwcIBIsuy/nERpb3f7e9UzSDhK1qp6eelYxB3aq6LztJoHWVhtAx7B17FnzANLfxakUP
 xEDRcV2kWqJbPkdBUpFqx5TLq1TCzCBgQ7+rWRGUZ+NyYw13MOmfzD8oFNT5nOJ8Iky5
 KHM4aPSdcAzl018h/exkAg9BD7Bd3Cq22tfmJ9G+LOeBRcoQMBs17j4BdOkj1+YdHTdB
 ndwQ==
X-Gm-Message-State: AOJu0YzASQY7x1YWwip+/7bxxcZie6Ho1W6iQwVCT6C8/Rgj699zADmm
 7T5+kfmRDVKqjytjsiTKXTFL7F/n08xNFukl4xTrzCd7OQmb5wx1aWqD
X-Gm-Gg: Acq92OFN0/TdCsdGTJfye/tTWrOgJHqcaX9vOosVPiL2UHQNWqSz+uAFqVHacvB7k0L
 8SzEy8OjBvcww22HXDj6a7b6anpkVzPb9kj1d8NrQvbEuZtzFJ3ynX1he/JCIvF2Bv78jsU6ra0
 hXfWxsrqa7G9gwRsM33x6jIXrvQoQ4zytO8pLp425H+7Vw6tdehkKycfaHI3H6JaCHkJ80jiokS
 lJcjS98xkSa6+zfZMQyl1NCBHMxm6xR6e+VYxlI6NZQr691as+TT3GBqmAZtk2GPBWv2O1LnxYB
 p9xVRLPMrqDz+IiSP+EtqsfbiFx/fIv+v4nLnPrRhlvITCAPtIw2sSpQMrV1MhKv5dG04A7SK3n
 S/3SQ9xd1CW8uvk1VXqr8tTya+lDRmixkISg/CQqMuXJ1/esugWfwpn5uVCSgfmFj4T4Z7wXowo
 qsr9FTLJpy+IP8
X-Received: by 2002:a05:6000:290d:b0:441:1fa5:457e with SMTP id
 ffacd0b85a97d-45e5c36bb9cmr37520594f8f.13.1779268472094; 
 Wed, 20 May 2026 02:14:32 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767ee0sm49115745f8f.1.2026.05.20.02.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:14:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] video: bridge: tc358768: Add delay after PLL init
Date: Wed, 20 May 2026 12:14:22 +0300
Message-ID: <20260520091423.45001-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
up, the downstream DSI register sequence runs immediately. On TF700T this
results in the bridge claiming PLL lock but producing no DSI video output:
the panel powers up, the backlight comes on, but the framebuffer is never
scanned out.

Insert a small settling delay between PLL setup and the rest of the attach.

Svyatoslav Ryhel (1):
  video: bridge: tc358768: Add delay after PLL init

 drivers/video/bridge/tc358768.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.51.0

