Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3C8C25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CD6886A4;
	Sat, 18 May 2024 17:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Opex4Bml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 931648863A; Sat, 18 May 2024 14:03:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A285A8863F
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 14:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716033784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NhWlwT/pT1fmUODA99kY/A/9JxHW00PIxAWnT4pFUdE=;
 b=Opex4Bml4mBe6T7oWQlq9nzk8sveL2RXOXXlscU8ugPBxT2WOA4TclJAMpTiqOWkkWR7p+
 YDx8T9mhMdj3Hmu6uuWPN/yX5tj8fnjBDHrUfYUYiObk4vN+4wyTAGmYd0I5ZTS8BmZlg9
 WqcvWLzwC4FMwuSegXcwXxuNdHuRDi8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Bmaez33ZPXSN7V3xp83fXw-1; Sat, 18 May 2024 08:03:03 -0400
X-MC-Unique: Bmaez33ZPXSN7V3xp83fXw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e3003fae2dso65819941fa.3
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716033781; x=1716638581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhWlwT/pT1fmUODA99kY/A/9JxHW00PIxAWnT4pFUdE=;
 b=ST2tzcXc42opy6wTrVh/606rrvY3Erl2WQnnExjk5IQM495hfxEwkay0iIY5EhyJq/
 /zRhxEMQcyOwUWRKsvHrHtIsYmOYsQbi0184JYY4Idf8YGaiXLbNUvs2BOtO1n3PEeRV
 xXFKGwIjjj9e0YHg1ovN5l9PIGBvzKE2b3DW3PCU4VVuhk2ck5FxZhYw60kgpXlaawou
 thjbTKrNHQ51uadECMWCYbwhsB/qdft12FkixhupLo6AorzUQ5BankwHro/spfMgd+U4
 9UCAlysmz8ozs+dtYfg4sWCyoep/mJJeu+Sqn2gaycXvcoe7Fxh3Bw9ixiI9/9+E5uko
 8WSg==
X-Gm-Message-State: AOJu0YwO8xDgoyjw719HYnYoo8iD0Xswdks9/agagwtic+w9OF3JavJO
 4cjICWGlc+mQP/VkMDOdE6c6kXVKurxE95z7MzNMZQBVt1PLM07mdFdgsdBlMXdaV9uAr+6HtMT
 GPbeuijP8KDPOPV2Z68q+ad6UxNDEgqdfaMjPAwAMQ5Cb0bJdrXC/G4WiS3X/NYN+96eGnFiHMI
 Gif7+edRuTULSUzkMVrjS5bvz9nwzmkmjkGg==
X-Received: by 2002:a05:651c:1a2a:b0:2e7:18d3:cd56 with SMTP id
 38308e7fff4ca-2e718d3cef5mr10372241fa.25.1716033781280; 
 Sat, 18 May 2024 05:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw6tM15yh3ZbNV97llvBn6EKP7BOUHpokolEXuLdQvarMbx4e4RpHhMZ+FRQ6ZObLPJzV/ig==
X-Received: by 2002:a05:651c:1a2a:b0:2e7:18d3:cd56 with SMTP id
 38308e7fff4ca-2e718d3cef5mr10371791fa.25.1716033780623; 
 Sat, 18 May 2024 05:03:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42009eda143sm278834645e9.14.2024.05.18.05.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 05:03:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [RESEND PATCH 0/4] omap3: igep0x00: Fix boot failure and modernize
 the boards support
Date: Sat, 18 May 2024 14:02:28 +0200
Message-ID: <20240518120254.204138-1-javierm@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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

Hello,

I noticed that the IGEPv2 board did not boot anymore with mainline U-Boot.
This was caused by a driver change to allocate its platform data before
relocation and U-Boot not having enough pre-relocation heap size for this.

This series fixes this issue and also makes the board support more modern,
by enabling DM for SPL and migrating the IGEP boards to use upstream DTBs.

It is a resend because previous emails were blocked on moderator approval
due not being subscribed in the mailing list. Hopefully this time makes it
through, sorry for the spam to folks Cc'ed.

Best regards,
Javier


Javier Martinez Canillas (4):
  omap3: igep00x0: Increase malloc() pool size
  omap3: igep0x00: Drop unused SPI support
  omap3: igep0x00: Update for DM SPL support
  omap3: igep0x00: Migrate to use upstream DT

 arch/arm/dts/Makefile                   |   3 -
 arch/arm/dts/omap3-igep.dtsi            | 247 ----------------------
 arch/arm/dts/omap3-igep0020-common.dtsi | 261 ------------------------
 arch/arm/dts/omap3-igep0020-u-boot.dtsi |  14 +-
 arch/arm/dts/omap3-igep0020.dts         |  47 -----
 board/isee/igep00x0/igep00x0.c          |  12 --
 configs/igep00x0_defconfig              |  26 ++-
 7 files changed, 14 insertions(+), 596 deletions(-)
 delete mode 100644 arch/arm/dts/omap3-igep.dtsi
 delete mode 100644 arch/arm/dts/omap3-igep0020-common.dtsi
 delete mode 100644 arch/arm/dts/omap3-igep0020.dts

-- 
2.45.0

