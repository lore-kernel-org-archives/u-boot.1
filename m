Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F3FC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9808867B;
	Wed, 17 Jul 2024 17:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kc8VbX1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41D788464; Wed, 17 Jul 2024 17:57:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E130288636
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so45120485e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231837; x=1721836637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1dJora3nmnHJybL7M121hwfGXl2QjoMobJ/IfWM5Pxg=;
 b=kc8VbX1+4rBSMnwb+IvUssWL9V/xH1rO3od+WWfi1PDwulMX/2e3V5fg+kVj47NcB2
 kMJivmId/Ptmc9KMvyHGOH7lGBLsFZGpvLOusDelRRS28NaR2n9gl6U43dPX35L7mVMM
 aeaJ+4Zvnw/p5pek0OtQFVq697urV1KiZ8bak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231837; x=1721836637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dJora3nmnHJybL7M121hwfGXl2QjoMobJ/IfWM5Pxg=;
 b=fT63Ly0DTUHlKkMewaI9p2rI3l/kTPjjwt/5Lcomx04Tkd1Cngoeb4J7UWeeelZ3BM
 I0mCumH+LojWWSxPBetNDqbtrzMohs0kSxbRWqg45CMhruffN8jTUc56mgjCv1RRw/CU
 HwjzLj7qixL7+993t/lU5O4F9hqOZ76KceyvulutqQG/uZ32pqpWv3If1gYHsIE5hLuu
 xxAftYyTsvSGEX0BcNttIucoiSKDlPaasIJnA8CVpJ/n6rTvYLTtfZJjJ6fz79yLD80I
 T7ybrm5q8HObQAf37ObQ8BNRSJ5ZCFHZVczJsENe3yC0BCyi4Ays2Q2g9qZFykD+BuIn
 XgmA==
X-Gm-Message-State: AOJu0YwEavc5+7JJ8QzZRAlQ89JFjwP9xqp2vvVUZEjFlni/3NHOXVbN
 bVBMefDn4CeQMkn3/JbdeUTAdVhO0FtjuO1ZhvedGg0GhwB1BZHxvcEhJGq+StUftK3XNOuTJJM
 =
X-Google-Smtp-Source: AGHT+IE/qvZ/jsEWci1Y1eQqUc3mK8gUXR8JCU2E0gP6R63UM/uUxSF9EBtBnRflZONAfLmHxOSZkQ==
X-Received: by 2002:a5d:5f88:0:b0:367:947a:8e2b with SMTP id
 ffacd0b85a97d-368316526c6mr1518772f8f.36.1721231837011; 
 Wed, 17 Jul 2024 08:57:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 00/24] qconfig: Tidy up main() and add a small feature
Date: Wed, 17 Jul 2024 16:56:48 +0100
Message-Id: <20240717155712.2913651-1-sjg@chromium.org>
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


Simon Glass (24):
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

 doc/develop/qconfig.rst |  14 ++
 tools/qconfig.py        | 403 ++++++++++++++++++++++++----------------
 2 files changed, 256 insertions(+), 161 deletions(-)

-- 
2.34.1

