Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677BACD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DA084E28;
	Sat,  9 May 2026 02:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JX24KLB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D292084CF1; Fri,  8 May 2026 23:32:37 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA86A84CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 862F63FEBC
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778275955;
 bh=axynfVotHajRHk0PEAyKEmbt+sNEM+EclROkiy3hfr4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JX24KLB4mUFCFx1Ir7Bzias4zb7zbYN7Jy/P9q7U08pnY0vH7TiFVf6LUiwvVjtCZ
 CI2WXY+aw4IUCwX98rcIDrHSJecwDZ4myknYC2qXOXB5DMN8z2o+Aloy3InlS9Wuoe
 RALFlQdNtRGHsIgcp+o65ZPxrzAzHV7jSM/S6QORqE6MAn9lzm3f5XFa/zFC11KgDe
 Wwpg+2H1rytVee8iUjXznC1GOj5AlBSv3T76PzIalenXwNQYuLQNfU08765os10ZUn
 M5EbNylwz9Gw72c8W3rbWc4ZV6EUoGanBZmWf9rU10efmWK/m/aXWQnJjIJoJZSDRt
 KgZsu+XPOBX0kH6oGH+WCNlJyx+ccM7Ud5LHAStMqMgcClVVIEyOhsD/UqBjBEizbq
 ef9H0QyWbSvJNDREUqnJ/HQHZyEFT3kPtt2NRYCo33kvYh2qA2TiXuSt3SsNyUbJ1c
 TTnS9GXDS264dCeZDawpI9AzNvypDQIkFev8Uo4m1vrJh7qte88UMg2bu4g0hO686+
 WLuQgcBIl7ddmh8GcfzGqJ/lffA1RoJGJ4AeIXdj4iMshgKGOoDIZg+hvSD6roFSAf
 lN8saph2j9CwyJ0q2GOZBXsnmfEMPJGZ1HLwrDaXHa07dopWJ0DN8Ip2zhVEvAxiu2
 EM7fhk7XT5Dq08WzW4Rt5t4k=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa6c3a77cso1653045b3a.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 14:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778275953; x=1778880753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axynfVotHajRHk0PEAyKEmbt+sNEM+EclROkiy3hfr4=;
 b=ZNxAPvEgyduSnSfudZRYJgBuIhhKKZJ8M2S3WUwd/K9zEHrNaKj1uRdnWTWEHyvaJF
 vjkCeGj1dPu9IzabUZh/j9Xbvzx9I8XBMU/etLqIkpGPaca3nhl+uIMJX01YctbcmtpG
 xz0cnTy/O9ZM9kb/y/D3YGp/rDkwYsGcfLRl4FtTzwGzr+beq+fCY79g5QgSdVa3mbdT
 DotIy84D0cWEu7fufcCsPxBwzYl3CL+CPRl5yLCUQPMG9TeTS3w456YYxsGvdYMoft/S
 Hyd1/O5LfeJ37MF49k16AGNbUybqteDZfXhWoQeCIrnmB6t9WKR4hBa+5C1iQgBzEYSc
 h3fw==
X-Gm-Message-State: AOJu0YxTIT7/o4dAJoxuS/JiM8wyBG8K7Wq+Hcx8RrCQh5xg7MnqgsMu
 OvSsEDjl7fGaZlOZRblDPyJ7K9v19N+jJzx6c1G+u5d2LrMPLzS8AAGUXhU3RsJXj3EFlD+LzSv
 hu62oriwuFHxnfCJaRgQ+zTYNc+/oSb/g0L3oHdh4oEaqLehVKmqHPTrK9bO+wTaotXZl+Ump8s
 /fsYCatg==
X-Gm-Gg: Acq92OGykEPqBa66eneIcuSwXdP5Nmj1aL6DK2z2DGD2x+0lb2d9sVVeecDb9ZG3XOP
 ga5vqFqhQvQ8jaTeNLrnSATygMqoZyOwHmvdA8FM52x/E8d8YmJX0/7TMVPH5GzwEqI1zVF/kl1
 cPzasLUIDJaWcFGWw2CGujbS10VaDHGGU3azlJ2txwIcXAYOIsnolBEBwOoXIH17zOegknjcxJd
 1OKBg28x/uvsVRvtMhJhmxDLAIU1uM1dz/59X6ib3E2qHOqd1L1hrEG1Bzx1lEiUBbBgNFc8mH/
 m7GRmyDdUoHsH1eci7QQD4ZyvsdWH5VAhwizTdYRPxxlxYI0rQEL9XlNXfW2A3fEi2NkGC2I6Fi
 5/0stqDl20dMYVLM0G1eciDVKjWbD8R+PXe8M/WLj1m0iohMkmhSabbpIGBerzKdrk2qSC+q8vO
 8+HuoHHpQpXBnWgyk=
X-Received: by 2002:a05:6a00:aa82:b0:837:6bb9:acb7 with SMTP id
 d2e1a72fcca58-83cf1e48de4mr4689503b3a.0.1778275953309; 
 Fri, 08 May 2026 14:32:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa82:b0:837:6bb9:acb7 with SMTP id
 d2e1a72fcca58-83cf1e48de4mr4689487b3a.0.1778275952883; 
 Fri, 08 May 2026 14:32:32 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83962e7e3fcsm16196751b3a.0.2026.05.08.14.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 14:32:32 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/3] boot/fit: use fdt_for_each_subnode() in image-fit.c
Date: Fri,  8 May 2026 21:31:58 +0000
Message-ID: <20260508213217.3807786-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:19 +0200
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

This series ends with replacing the verbose fdt_next_node() + ndepth
idiom in boot/image-fit.c with fdt_for_each_subnode(), bringing the
file in line with boot/image-fit-sig.c. Six of the seven sites in
image-fit.c predate the macro by 2-6 years; the seventh was
copy-pasted from a neighbour in 2015 just after the macro landed.
The old idiom is legacy, not a deliberate technical choice.

Converting straight to the macro turned out to need a prerequisite,
which is patch 1. fit_print_contents() reads the default-config
property using the loop variable left over after iterating /images
children. With /images defined first in the source (the conventional
layout) libfdt's walker happens to leave that variable pointing at
/configurations and the read works. With /configurations defined
first the read returns NULL and the "Default Configuration" line is
silently omitted. fdt_for_each_subnode()'s post-loop value is
unconditionally a negative error code, so a naive conversion would
have made the missing line the unconditional behaviour. Patch 1
reads the property from confs_noffset directly and removes the
layout dependency.

Patch 2 adds a regression test for the configs-before-images
layout, which had no coverage. 

Patch 3 is the mechanical conversion at all seven sites,
equivalence-preserving as described in the per-patch message.

Aristo Chen (3):
  boot/fit: read default-config property from the configurations node
  test: fit: regression test for default-config print with reversed node
    order
  boot/fit: use fdt_for_each_subnode() in image-fit.c

 boot/image-fit.c          | 109 ++++++++++----------------------------
 test/py/tests/test_fit.py |  53 ++++++++++++++++++
 2 files changed, 81 insertions(+), 81 deletions(-)

-- 
2.43.0

