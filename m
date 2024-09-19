Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF8ACF3959
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 16:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18E789281;
	Thu, 19 Sep 2024 18:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMOmLE+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526C1892A1; Thu, 19 Sep 2024 18:10:47 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA3E88BBF
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so12114641fa.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726762244; x=1727367044; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTn4+RsDg3JIE8Hl6RFbxPYRm/RSEqjXTsMGBG3iVW0=;
 b=TMOmLE+aHggsp8tVfM+l7Ky+uPc3KaYEaL3G9sPSVU2irVsNVLmH0Llcs0mMJN5j5T
 dU4vR7gbzUsVYvBWpdUgq8P5Q/ZgnLEMQbUa+YwSs4FFpDkQ04nznYmlYZtfKc7oiB4a
 4o796q1sP3bzAtWiLCWi1gnjrX53O1ZUYvQlTnfMCUXIZLUDZ9DuIvbD3Uc0eKSxLCkc
 Mo4Ve2yHO3VCuxWANIdlehQZ/oYdjUIME+onaT+j7DDT7TTvi/FE2gCX9su9VtkMz2dF
 7Sou2KG6tADL2WyorDS/TkTAeO9C1Uq5T0e0VriZSsxeaxkR2uIgDpK7SkTpZNX4F67X
 c00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726762244; x=1727367044;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTn4+RsDg3JIE8Hl6RFbxPYRm/RSEqjXTsMGBG3iVW0=;
 b=FH7/UVQ6RcROOsPeHIQYvIFa5w7npIhlcMLvoh8IALzoJcVnpLNOhW5JsO9XyKUIoF
 2bw5CF0f+laRZZNQEjton90VmTziC4YMA2fH7uDh4PGY5mN1Wj5W764027Xk+4/mOVmK
 ysS0jK4BKQG5W0xvNdRQ99SqQ6VQRZNn+8HCJX1KnLLbTBbznqvm+NkB1mHMPo4etDF3
 PgBkBUo3xz983S9ZhQrGthz8GKMUShxP80Y7BGsgkaegdb9D9eoh+JTIWJmAiTn3j2JN
 6wtmoBtidh4uGa36f+EjEuuxLsTtYTwIKRnNBL9iVei9OZVCSUq+M8mVI/WUWaJEJGSE
 499Q==
X-Gm-Message-State: AOJu0Yx4019nsxgArIjLXNiXeSpto4VwrN1aKrVKfSKcgmIX2tIbdKc+
 fyE5byYCRXROsYEQvstwImAaigLvOMDsC9bFrQ2M2izCfrb436TCpudIoA==
X-Google-Smtp-Source: AGHT+IHflDCk2EbxZfYSOVDXA803q6BvSlHEI+b+/sUdhwMj0R9GHiAgynpc124V0RoobwIphvU1xA==
X-Received: by 2002:a2e:e09:0:b0:2f7:6519:9a01 with SMTP id
 38308e7fff4ca-2f7cb2f910amr736501fa.24.1726762244237; 
 Thu, 19 Sep 2024 09:10:44 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f79d2e1c56sm16278361fa.20.2024.09.19.09.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:10:43 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCHv2 0/1] Makefile: pass external DTB provided by make variable
 EXT_DTB to binman
Date: Thu, 19 Sep 2024 19:10:41 +0300
Message-Id: <20240919161042.3423-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
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

From: Alexander Kochetkov <al.kochet@gmail.com>

Changes in v2:    
- fix syntax errors in the description
- impelement handling multiple DTB files in the EXT_DTB


Alexander Kochetkov (1):
  Makefile: pass external DTB provided by make variable EXT_DTB to
    binman

 Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1

