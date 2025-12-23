Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A51BE6FE51
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 23:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AD384191;
	Wed, 24 Dec 2025 00:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUWsdgY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D970A83F50; Wed, 24 Dec 2025 00:15:46 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA4783F50
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 00:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso5786243a34.1
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766531743; x=1767136543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dEeliqJVOGK1YAxz443UnvxUqXPBYg+0C43CCmwmBVk=;
 b=OUWsdgY5BdmKt5/oPOKa6+RGWKNIrQ290CxvL5bZjWkY8Sdt3S82nDEQYhcdDbpNNC
 d8vzG8ihKGTXrud4j7GVkPdSIY9OK/UfreJkXLSarn1wi9liMhpT/tAP8w5rJxWQ7OSv
 4x3FKXUssspOP5tQfdFATs1PCw7RII3lYX165HPi7rhLzvCLliuBxxjHvaRsEcSb/Ren
 nbjZIwRpPzpvQEkxMkW+jjyNzDP+dAxHVzADzWV4lRIR0wU56Nzila9L645F8RLgfuSE
 bQjvL0acEKf5NlHaFYChzSB/jP4jksRbv5bC24+sE8o+IjeHozem0f5XFWhN44HIyGsP
 wasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766531743; x=1767136543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEeliqJVOGK1YAxz443UnvxUqXPBYg+0C43CCmwmBVk=;
 b=d5DFpLt/osbNvWIzNPlJJdFmXpvY8yR37L+k7xDrY4epGbnPg0RECx+Tnt6TtBxzag
 NlwCayzrBWnsJu3qBl6gVgpSh+Hi3nogceH/3t3Zx2K4WKNuJv7R2mXQGG15qEnGNott
 9LeHnoS1Onn4O+hdjqQbkXJ7PqSE+azqxqN17QkzZpf28Lygcxrd2wjZoXMSt6U2ZQw4
 h5alfYqqDWqs6IgUIbI/umKFMkZXf1zWKFpoJhMDE5mZyFb+7IAWl0gF63gl//4irS2m
 +OJvq+Anjt5QmNkLrbjsahjtpUbrcmYPKQtHlZBaxReZTTlfIgP4K0idrJYQL4wpVmgE
 kUuQ==
X-Gm-Message-State: AOJu0YwU+p0g/ryQTCiUCQzpiWkuXOmpcENAcZNJ73XDM55mlGJYZfMR
 mTqs3g1uxSUu0znP1tmVFifDVPDJZqBPNCbQWdyJFEx/xGPc74011SfCBi/aGd0s
X-Gm-Gg: AY/fxX6rWnuWfrlH0POWGtjOsU+sHjoX5lyXZBvMK26/P0dB1HIIE78Siz9WcuFIszP
 r2eHSCRvj9jw7KNxXwBCY1f1qlSFVXCQryORoVdbJJ9HLrTm9XEhl/lH6eV/4iIsvna2EIlY8+v
 0tzh3fweZ7nFTB/T5gk/pz4yuH2whJt99OI8YfGqPMDaN16oYweqCJ1fLt9qmUupBlZJHnCfKxk
 rfEGz7CW777e5bR7Gkz5NuyMd8dHwvnKEFG98qNL1G/VOuSMydZZIAdm+gLUQQRNfJwEvwWcORU
 AhNGxlNQb4nZk0ZzxmR2gdUpBYSFFwRGFtL5dW4wDpL5qd/3yYWBoLGKWZza80ILu4r8PYkrDqB
 /jG7np+fvStwkumMKsRorUeEI8iz98BhNRm2q01adUChbGqzfhLdcuSvqbykzO1Z3dw/8Vd3qWV
 vq4uiCIRSp
X-Google-Smtp-Source: AGHT+IGPpWo2C8iAxlLhfeARdmnunapvKax83HmyGcPJ3jkSiIDW9MPLcCdRdVucW7BP+63DQxquSA==
X-Received: by 2002:a05:6830:6c0c:b0:7ca:f4cd:db57 with SMTP id
 46e09a7af769-7cc592fc20emr9549234a34.17.1766531743028; 
 Tue, 23 Dec 2025 15:15:43 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d4f62sm10352037a34.19.2025.12.23.15.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 15:15:42 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] USB Fixes for Gadget Mode on DWC3
Date: Tue, 23 Dec 2025 17:13:09 -0600
Message-ID: <20251223231311.1983423-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Chris Morgan <macromorgan@hotmail.com>

In order to get gadget mode functional (for fastboot and ums) I need to
pull two patches in from mainline Linux. After applying these two
patches to U-Boot I am able to use ums and fastboot on my Anbernic
RG353P device for testing purposes.

Chris Morgan (2):
  usb: dwc3: gadget: Don't send unintended link state change
  usb: dwc3: core: improve reset sequence

 drivers/usb/dwc3/core.c   | 31 +++++++++++++++++++++----------
 drivers/usb/dwc3/gadget.c | 20 +++++++++-----------
 drivers/usb/dwc3/gadget.h | 14 ++++++++++++++
 3 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.43.0

