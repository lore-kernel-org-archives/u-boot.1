Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61488E9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3E286CC0;
	Thu,  5 Oct 2023 15:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jYuWHBpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0612386CC3; Thu,  5 Oct 2023 15:04:52 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCC986CF7
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 15:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so8763965e9.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696511068; x=1697115868;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eWGMJQgeWuMhJTfjjEXZ1R5uMyVfS3TYn0Ywj053tZE=;
 b=jYuWHBpJp8+l095LzJCMENoRRYVnnCiJxsVD6Xc9kockcB2g8+Dj6Rhq+mm1idqSFH
 3qVjfn7WoaN5q6J0JCcPTpVfNlg2/PT3fO5yL3EceWP/wG+FD+n2/WPRRyqMDE95Kfi9
 p4yu/bVYqzNdGO+kNBqkNJY6ozBZi/2Eu4HuqUBXjHTT6rTDyer7m0E0ivNWag8X7+7Z
 EEu32yiGuj6Yj3Qqgk4nlL0ngn2lqzHLfT4PVDRX2kKXnSqd6pr8ABbRSNtbXitUpnPR
 r6zKTxBRNH52lHtQWZoabOkEL2R8ZLA9eBzJl6HgrcvFoQp51DsvRaCO3KSbgxFOUq9l
 C+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696511068; x=1697115868;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWGMJQgeWuMhJTfjjEXZ1R5uMyVfS3TYn0Ywj053tZE=;
 b=ZL6kgAUmCA7aE4laYfPa6ImocXCIMG+LmOK/3ki89HMEtkD0EhfGTxRKDYlBF/rYG2
 dJonH4azXRUenh6XoUtWK924GQLui4E8Zs/c33Do/v88ukjgjAnx3bq0p1yGFI48gJkF
 QUBgfew6mFb5vzPGGZ2OuWgBEZ+CBEOvI5f+VjJw/iHLa/FxEhD3MwmltEddPu2zIVam
 ZZFxzLHKMiW6UPigyjtlAuqClxQb4ypAnnhuV73J0BT1QO10Jttcbwr8ULtspW63sd0/
 nzAXTH7opFFvULAhEBB8LJVrUC5fD0mF2Eh3QmhUxs+YgwrqeY6D2gtLi2LW2+3bud0N
 uWIg==
X-Gm-Message-State: AOJu0YxIpf9ztF+H1aGPC2yDoPAifDXhLV9UkYFruvGg3eOHPXrbTsVg
 8L03UGZUFVx1SW44/QTlY4qc8Q==
X-Google-Smtp-Source: AGHT+IFH8D7pCmvVdqx08++EQ/YL9gYemAlvQWwqR0GYq+OcgR1bshfqkwiDm5zetz32aFb7j12RhA==
X-Received: by 2002:a05:600c:446:b0:401:bdd7:49ae with SMTP id
 s6-20020a05600c044600b00401bdd749aemr4865194wmb.18.1696511068195; 
 Thu, 05 Oct 2023 06:04:28 -0700 (PDT)
Received: from [192.168.2.35] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003fc0505be19sm1466983wmr.37.2023.10.05.06.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 06:04:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
Date: Thu, 05 Oct 2023 15:04:24 +0200
Message-Id: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFi0HmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNT3dzEkpLMrGLd0uIkXbMkC+OUlFQjU7M0AyWgjoKi1LTMCrBp0bG
 1tQAB8uCNXQAAAA==
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

From discussions with Marek at Kernel Recipes, it seems that the USB
subsystem in U-boot need some help.

Since I've been asked and I'm willing to help, I've added myself to the
maintainers entry.

I have also added myself for fastboot since I'm interested in keeping
that functional as well.

Note that I have no previous (open-source) maintainer experience so I
will do my best to learn.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Mattijs Korpershoek (2):
      MAINTAINERS: usb gadget: add Mattijs
      MAINTAINERS: fastboot: add Mattijs

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 65b9b3462bec2966911658836983819ab4e4823e
change-id: 20231005-mattijs-usb-6b83dde256f0

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

