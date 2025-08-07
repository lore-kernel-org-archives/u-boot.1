Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2949C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B807E83C46;
	Thu,  7 Aug 2025 12:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dck1k2/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E6D83A26; Thu,  7 Aug 2025 12:04:15 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C674C83C46
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so437377f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754561047; x=1755165847; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EXdeBW/H7RP7k993IVsC1jLetE6W3MyWvtt/jd1yjX0=;
 b=Dck1k2/sJ6ZnrpKbY+jZlAOrVPLC8tcuu6GiFtFpBfptUV89zb/JGxaYs8ZjIcE5Ce
 nmHsxYHbajYtVpvfOryVpflAat0FS6EQQHWIHKATWmI8hcatqV+jbcyljVwqlASUz00l
 gCm0pCFCH6E/qEKfNBohhoDU/mbV1uotGfeqJ8+ceRFHWuaIRqXgTQJUGTggA+aaEh4o
 7xQSGKzq4xJxJTs19mHUPi0f1GLlI/qwadIZFyMQwNoW2Zmxb/vsqVFgDg8bh6skR7F8
 TD+14H7jQYvUrg22+V+ibvi7b+gOVD5EAyuxJftnMQhC9sdqW9ANNw6D+kd9PHv1FGMl
 xbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754561047; x=1755165847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXdeBW/H7RP7k993IVsC1jLetE6W3MyWvtt/jd1yjX0=;
 b=Hai0xwha6z20zvkZt9dKQI7jbEwzAQsnN60cxs/J6wzIG9otx9COSnK4f0vx0b6m+z
 SgImDy3y9TE/+7MnoMhVaN5TCSx8NMBUU/O1EUEzyEFaoMmHTmnPI+A37XZDgX5o49Xt
 gGJacw8cOrUE5Bdh44HabPH8yS87V6+SU1Wm1eYQVY6FMcBRAqhuR/QPh6JnoIeXW9yh
 FG97lANqcHVHk1AMJwEusqZudBTJar8S9Vm/8p9g/bqFBdJdDrm9YpDd1M8PeHS1X/HM
 KFVb9Ab83YC2pKm/uwIiSTqIO0z3WMryyPz3sA5YzrF9ksW+XApQvJyY062tlqeI4V0W
 tO6w==
X-Gm-Message-State: AOJu0Yy8lY4hoe6M88qDuzmeWZceQFfVsjLw7wEAYTDPY1uvqBlHK6jx
 B95ADUTdp5YlRda9vQhKxhBgHwwoDDic5DquW8Y3ZGsuMqL8O2WxWuKlRSQeT0tjfsRbncj1cWZ
 HdGnmXqc=
X-Gm-Gg: ASbGnct6FwvIDsnMDnfNG468eiGliLRkoVXHV2VAKXE76JdfJyvvVsrOZaTOApu5dhC
 JvltufbZgZWBRd+8jJq6NpsaTKzyCyGTW6xXVIx0spUVr3Wyk4b6MFaPz90H3cl1JP8XyqBkMfA
 Jlkkg8lio/xdYXNBsyIyGdK1k+w9T62AWGfd1UEnzbpgIE6BXk6BGemGx6S3/xW203FmL/tpXlw
 klp4npithkV0yyyKpFEQFXuuMFbWsDzaOXIMjel2KtdzTAVS5Xkr8Eom5xz0kCjWx2kP2pduxy5
 9Ae6K50TTu3E3+Sq0ahJAmx+BrAijtr0F30idRbfuvGXy/ZREnxJS9+0F5/Gp3UTlJk8UVAxkWv
 RPsrJsdTUw0g5QJThhr9WicBE7vUXndFzhK1uMT5Oj+UGruFNTt8=
X-Google-Smtp-Source: AGHT+IFKXXaAoEDPifWZi+eU9cqDc8OzlMei8/bghwAY0XucppWGX3Yga/gQYl/jpadw4wrkzk/yNA==
X-Received: by 2002:a5d:64c4:0:b0:3b8:eb9f:a756 with SMTP id
 ffacd0b85a97d-3b8f9f21213mr1877345f8f.11.1754561047097; 
 Thu, 07 Aug 2025 03:04:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm358481575e9.25.2025.08.07.03.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 03:04:06 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 11:04:02 +0100
Subject: [PATCH 1/4] pinctrl: single: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_misc-v1-1-eeb564a1b032@linaro.org>
References: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
In-Reply-To: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In single_read there is a switch block with a default label. All cases
in the switch block, including the default, return directly. So any code
following the switch block is unreachable. Remove the unreachable code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/pinctrl-single.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a3802d22d4f..c96b293aadf 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -109,8 +109,6 @@ static unsigned int single_read(struct udevice *dev, void *reg)
 	default: /* 32 bits */
 		return readl(reg);
 	}
-
-	return readb(reg);
 }
 
 static void single_write(struct udevice *dev, unsigned int val, void *reg)

-- 
2.39.5

