Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24924C3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 09:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D473887E8;
	Thu, 18 Jul 2024 11:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U90xF/Kf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5A988A09; Thu, 18 Jul 2024 11:11:41 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF8888780
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 11:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso807375e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721293899; x=1721898699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8iVJ88eXmkNADNphpKDSddPcj0/l8Ta1Mc3X4pkA7c=;
 b=U90xF/KfAElrxP7B0jg0HnZPXXR0g9iUjA5OAWa59ZUIriAZOSGULup8yBYGFkKpCY
 QwQXEpBJ3u45E+11xEv9X7se/BxilKCtNJzdpC6arzkDFw4iTsOefi+rDAndC73i7HrZ
 SVKXhyTWxGxzihC0JD2kCHplrUHglId+FLFAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721293899; x=1721898699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8iVJ88eXmkNADNphpKDSddPcj0/l8Ta1Mc3X4pkA7c=;
 b=mOTEOBpdA+Oaui9WtQpYvqFTCnCwmYu4rIEAYE/Z7Ax1PKp+O9H7KR4s52oDCm/q4k
 DqtzUYMBaBgSA5A9nqB2kSwO9Zv34AJnWaKa0ncAHoxIBqxJVCa/RsDaiRjjlbJXoL94
 mvJ1i+vOZl35FRoDmFlZZwGfTSgq7Mc1HU5O8SoK/rNq5WPvfvD10GDwuhs408A3SnO+
 1Ads7fGbudZGn9eMQaWAFn72gVAv8J549A/lTiFqwcZ7Kxsww/pJwKohDi/NZ0zU8i4H
 kzaGbgi7bCWblReNTQZQd2YLlIpqE4CkubsJu8s4NlXaaTkrroPKIh9h1UuAphYfqEze
 w8vg==
X-Gm-Message-State: AOJu0YzSB/nF1xR91oLCEclZpjQ//yvrEzIY3t4+e5+VSfRF/DABvpKE
 r0Y5l9FoJHWUVW+UGjj9EI7hO3w1mDRYKT16wJ7JlLKqZIX1sMgB4t8EnH2UNJNuG2xL22oerrg
 =
X-Google-Smtp-Source: AGHT+IGKjfNTLKEvHWQ4onM3IbPtvOR6+867t3Tz+83gxMHzCNDUDIZFiF66EpHdeV6Mo442tEtUeA==
X-Received: by 2002:a5d:4bc4:0:b0:366:efa2:f2f7 with SMTP id
 ffacd0b85a97d-36831600b19mr2835660f8f.1.1721293898847; 
 Thu, 18 Jul 2024 02:11:38 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368525f0353sm1064403f8f.115.2024.07.18.02.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:11:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 00/26] qconfig: Tidy up main() and add a small feature
Date: Thu, 18 Jul 2024 10:10:59 +0100
Message-Id: <20240718091125.3788990-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This series improves the code a little by reducing the size of the
main() function. It also allows searching for CONFIG values.

Changes in v2:
- Drop debugging
- Add a new patch to sort the boards by name when finding
- Add new patch to support a 'list' format

Simon Glass (26):
  qconfig: Fix pylint error in read_database()
  qconfig: Drop the try_expand() function
  qconfig: Make KconfigScanner a function
  qconfig: Tidy up some pylint warnings
  qconfig: Correct format string in do_imply_config()
  qconfig: Rename the doc link
  qconfig: Move arg parsing into a separate function
  qconfig: Move arg checking a little higher
  qconfig: Move arg checking to the top of main()
  qconfig: Move getting the colour to where it is needed
  qconfig: Move checking directory to the top
  qconfig: Move converting config args to the top
  qconfig: Move testing into a separate function
  qconfig: Add a return value to do_scan_source()
  qconfig: Move imply into a separate function
  qconfig: Add a return value to do_find_config()
  qconfig: Move all move_config code into move_config()
  qconfig: Move commit code into a separate function
  qconfig: Move progress output into the class
  qconfig: Move the last two operations into their own functions
  qconfig: Use the Color object in Progress
  qconfig: Drop col argument from Slots()
  qconfig: Move operation check into parse_args()
  qconfig: Allow searching for CONFIG values
  qconfig: Sort the boards by name when finding
  qconfig: Support a 'list' format

 doc/develop/qconfig.rst |  14 ++
 tools/qconfig.py        | 414 ++++++++++++++++++++++++----------------
 2 files changed, 264 insertions(+), 164 deletions(-)

-- 
2.34.1

