Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5320EEB8FB1
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D8086996;
	Thu,  7 Sep 2023 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xq7aLXkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5AA8620C; Thu,  7 Sep 2023 14:23:41 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8498691E
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d71dd633f33so828292276.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089417; x=1694694217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jfW+A2Ru9DuBHVn5kA+6NJP7LOdk812ovtiy4QyRlIc=;
 b=Xq7aLXkUKPAozROJRK4ph0llqLpiGaANRAJBFQS61Ka5poM849SsspyfkKpjIdQMBK
 MHy2qYhyW5A/WIl4mmApS5Ja4IlVDX4WIAEzz22S4VTAZ7iNESRGqiThmYTIjtw9ziqP
 VNRKS++4jDdclCfQgzDRF+Wfwz8CdejYjLCEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089417; x=1694694217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfW+A2Ru9DuBHVn5kA+6NJP7LOdk812ovtiy4QyRlIc=;
 b=fu72I/YYO2k/ftesZVc2S6LOcdFwgXOl9yP4QFGFNYvxDZpttwkd+WqHhLpeUl7tk8
 jYybALhd+6GYoHZanBfT+A2fsej3calyHvUlEC5kN+z2bybBmC0UEsKApkeeQEmzwM0M
 sPmtN/KAiDzjYvdZFxJkGTI2fA0wfzS9nMjxUrfgsEyfCNiklVNhjWx3HiYJ21Q795sV
 EDNp7KI+uC8qUVFibu6ZoagGdTmMTdhTptaCNnPdWFAdbq661iWs/eMaye38q0UNR/Xx
 ZpABLrkji8avpRmSqj+aUHMOL9A5J34kpLfUIByaUo0DHjwPWAe6+SUyYtUmhmSVzoEr
 87Uw==
X-Gm-Message-State: AOJu0Yzp/BOUwjaSnTnj6cjX2dxxqdMyynuGIUxJoBx5qKS31WPFJ+p2
 ZFH8dqweBE14wLxFZ1epYSzuUr7FND/1VGhbB4NQlA==
X-Google-Smtp-Source: AGHT+IEaGUQMYeyg0HHJ0csLuaG7GMrqZHEp2YVqyZ2h8f/52gQmZIZFtPtq7JwK6/ZSW04ELe/4OH5WEeRBuuUQZlA=
X-Received: by 2002:a5b:4cf:0:b0:d74:62df:e802 with SMTP id
 u15-20020a5b04cf000000b00d7462dfe802mr17648828ybp.0.1694089416810; Thu, 07
 Sep 2023 05:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230907075442.156556-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230907075442.156556-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:03 -0600
Message-ID: <CAPnjgZ2Xu+F9nahQsFGTorsBoJhvXvSc8Cw14HbRcAfp69_cYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] timer: document the unit of the timer rate
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Ovidiu Panait <ovpanait@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Chanho Park <chanho61.park@samsung.com>,
 u-boot@lists.denx.de
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

On Thu, 7 Sept 2023 at 01:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> To avoid confusion document that timer_dev_priv.clock_rate and
> timer_get_rate() yield the timer rate in hertz.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/timer.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
