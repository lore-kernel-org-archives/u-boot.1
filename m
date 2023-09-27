Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2675AE810DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446E586DD6;
	Wed, 27 Sep 2023 14:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="ZBAV59u+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8163D86DDE; Wed, 27 Sep 2023 14:00:17 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C7186DC5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso54238815e9.0
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1695816014; x=1696420814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3YhPNSxDPAP7axtTTBtTicjUt1LjIdBxqAOi/4aXldE=;
 b=ZBAV59u+THtVhhASA55q+oqHloGW1IPkiOZxxPaO/vVtq2PNHGajjrgfLUhQmyluJo
 VLOrVNZKz+fBAtcj0MHIFzaH6rMcL/CYozvwspwF5xjun4hO4tIz04Lym5sTa8sFP5y2
 oODRqbmfBABQ+9u1pxYS1Q6Y7RdFIGWO7DHFLKEypiOxYIOnFTAenxOHpEnd3HHOsDXi
 uM/k0rVxDUhzVIz0omhLs7sHS9IthI4nV8VNSJszW2S745KchQ4JgFtleRhTQFgfJJPG
 xGOwkvtL62DvahJ9+nWF04b0dnzWBxgwjENYKf7t7hD4V5Njxm/ptkU//cB+istcKdsE
 5lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695816014; x=1696420814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YhPNSxDPAP7axtTTBtTicjUt1LjIdBxqAOi/4aXldE=;
 b=YehgeN/IBovZ0SeLkkQNCjFjw8so58I9MCR2Byk+HJut1gDJ/0JjDoEbbKWV+qIfSC
 K1JnE9AT1LMoSZru/miqyAudRJmsNrazt+v/Ud9ctWAEXcCz7dvhBoSptjm1Qx4qODSU
 Isw39c+HTDFW7gT7JSDzWXZEUUaXUkZgmtCrh9UdMFrVAfInbn+Iqw/Bq+rVXiwfBOk6
 RT4MhD92kmkLieuqbkGxPyuNh7lfy9ATjDa+i3DHsHXtVoqsJATUpDDmFQYAajMuz56i
 f+BZeCGZwpFWQ+CRVbK9QWB7ub58+p4j7E1q+kAAWu782JzzU3kB8G0bKG+EjT0OMvev
 5BiQ==
X-Gm-Message-State: AOJu0Yzypk1bo1MCD1TmDQaIP0fEWMx3EeemuP/uKACovGcsArMheC3R
 rAWPnFhhqlUY+esBKcCB6TEko94EmgNa0kuCPBU=
X-Google-Smtp-Source: AGHT+IGq18BS9sOVI5WhtMl29P5U4l4OQevJJQWDvO6IfSMKfd+GjBpzbDW1Fn+++r4rEwrPMsPlUg==
X-Received: by 2002:a05:6000:4c5:b0:314:314e:fdda with SMTP id
 h5-20020a05600004c500b00314314efddamr4053842wri.23.1695816014347; 
 Wed, 27 Sep 2023 05:00:14 -0700 (PDT)
Received: from hugo-IdeaPad-3-15ALC6.home
 (ptr-4h549o68tsg3n9xv5up.18120a2.ip6.access.telenet.be.
 [2a02:1810:952e:3700:492a:f3bb:eb68:e461])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d4a8b000000b0031fc4c31d77sm17078557wrq.88.2023.09.27.05.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 05:00:13 -0700 (PDT)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: hugo.cornelis@essensium.com
Subject: image-host: small improvements and fixes.
Date: Wed, 27 Sep 2023 13:59:18 +0200
Message-Id: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Sep 2023 14:24:03 +0200
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

Yocto build can involve very long filenames.  These two patches protect
the Yocto build from failing without a sensible error message and
increase the path length for the cipher key for the kernel from 128 to
256 characters.


