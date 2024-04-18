Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5091C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 14:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A73D88651;
	Thu, 18 Apr 2024 16:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Bb2V3PcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E3488651; Thu, 18 Apr 2024 16:11:25 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA5588633
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C21C53F8E5
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713449480;
 bh=17QhO2qxzxt+5/oZR6beKjGB3NlmXb816gYLi32NqPw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Bb2V3PcUlx39BkeU9+3nusAw5DpjI+9VH4MHhHMT7JMRL7SsSpiLFuT/PQ+yO5xKG
 rWTGXM6csc7yi20gOH9+x9YCCH1Kw+/NFYyKoW3XZUso9PiOx60VTwzpwytaaDPxvw
 XHkceE8BKB8pl3VJc4rYq8cJiaPKAkYWbyKwWEP7sbqqTF4WW5dmWQAnoquCnQ1U3M
 ItHJg4RftpyZnz4kHw/fqElcBZ9wuRcBKXFh01R0JfLi8+nQYn6PZnYhEp5LOE9Px/
 hGn4Ix0smsPxbKhS6O3+yabc7VVwvK0xTFKKtOTp/x7d6TPhiyXst3fGksPpQgqFeZ
 eQu7gjI7W5OXg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-418df23b51cso4313815e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 07:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713449480; x=1714054280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17QhO2qxzxt+5/oZR6beKjGB3NlmXb816gYLi32NqPw=;
 b=VWjZbzEdTRY+k38pS+pKN6kHPVDNwreI3SCn89TfkVzGS1pyecsVK0YtxgacnlB6mJ
 QLyuI03VF7uu6SQ+C2Ylkh9q9NL1JkDMotUZ7wmqXxsEO9jJn6t3NjXD17WUJKDjXejW
 HwPRhw2MWC4ZgdCuNP8bZAzLKQRfvTMkfnpY0f3hicuGgPV2iRpNAeb5arpnBAXiRm2j
 7OHlPlSfquJoEpvi2JQAFMZsW+GfwEsyHu+IJH3Lt6fE5nnjXk6jfL8H+R7F4+r7P52X
 LlW+1MSjRVnWBifMu8SaaIAtFPqKJYqbWkyumvsiOc9ayJX8Q2D9s7hD6vHBbqQQKJer
 WJBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl2hKmVmXNc2THzq9+tTC3i3bwo5yLluQsXIx2Cd8wRp728E6EwSH6OMUD5pLcDSpl+pdWxhFG2uWkowhfst1O+bqk2Q==
X-Gm-Message-State: AOJu0Yzeeib32/akiJfCn/12W4ws6E3zG4mIG9vTWhqtb1/43EjgYRHC
 YR/M+hDQPt6rDMr71YMbFQO73CT4OWpI1GoDpym2y4c9/vbyELdf2hZ/LPSY9/UrNv5wkcSzDd3
 ylfqe3iN+xjuLaE5tZegHaVVWxQcmPqY8m088fE7Xze9rs0Y3bMLgQBjQC+eouKY50DA=
X-Received: by 2002:a05:600c:5493:b0:418:e304:4a13 with SMTP id
 iv19-20020a05600c549300b00418e3044a13mr1448311wmb.19.1713449480238; 
 Thu, 18 Apr 2024 07:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Ti0+wk4HyUT7TKvlgmT8pkk0OW6sAb/ZdOeZo6g5I5dobKmJ0xDnFHxvDkcrrIgF10dSBA==
X-Received: by 2002:a05:600c:5493:b0:418:e304:4a13 with SMTP id
 iv19-20020a05600c549300b00418e3044a13mr1448294wmb.19.1713449479872; 
 Thu, 18 Apr 2024 07:11:19 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b004186f979543sm6751545wms.33.2024.04.18.07.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 07:11:19 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mailmap: add entry for AKASHI Takahiro
Date: Thu, 18 Apr 2024 16:11:12 +0200
Message-ID: <20240418141112.141948-1-heinrich.schuchardt@canonical.com>
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

Akashi-san's Linaro email address in not valid anymore.

Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 932bd4d9a97..8049856d41c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -15,6 +15,7 @@
 # Proper Name <proper@email.xx> <commit@email.xx>
 # Proper Name <proper@email.xx> Commit Name <commit@email.xx>
 
+AKASHI Takahiro <akashi.tkhro@gmail.com> <takahiro.akashi@linaro.org>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
 Allen Martin <amartin@nvidia.com>
 Amanda Baze <amanda.baze@amd.com> <nicole.baze@xilinx.com>
-- 
2.43.0

