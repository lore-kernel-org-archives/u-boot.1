Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03953C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 09:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 819446061F;
	Wed, 19 Aug 2026 09:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehNmntW3EbK8; Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787132231;
	bh=BD8a3pc4ADyM2I0J0VOotFXEVkjkztBxyscs8JKEaZ8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nBbGE3w5tqqcTdI+QItVsPIlk2NMXkPFJ0L0aSBOJLamusumgf9MvQrnEUkEr6AVn
	 4g3AMjASoBS5gizbYybqt7ijlrHG76oJU1ye7P+2GSzqeH+ZvZYQywzRaQqUWRxZcC
	 V9Coz/U5NXbVac1t2aYrRf6e/pCcwMCTuCMxOTfp8snTF+Yr3QubAxzgElGFPRPzr6
	 545m843m1Z1taMbHDmKVuZghZdTsxYleLTSLqZxr9fC6qEJfKYlTl8eb4ug2S92ZMS
	 TxFaz3iqdDFQmquUExKTWYNLPXLWEyR2h+M1SdJeYpphMZ5R/8JNJZb9bFfW3oAjP7
	 IRUQQgbNlUteA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B76060606;
	Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 25AB72B2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B9D860606
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FtgSRvzRkMCi for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 09:37:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HIl8Zc/B
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 024FD60603
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:08 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so7584095e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787132227; x=1787737027;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BD8a3pc4ADyM2I0J0VOotFXEVkjkztBxyscs8JKEaZ8=;
 b=HIl8Zc/BTP/kHXvWHyl2OGifY8+DdEgjxoLqy6SBGb3oW6T2eFSQu5Q/BZJVTkZmpn
 UYqzfq6I+7TuAe6M098WVRq/Oi8gY1DpNvV/NY/LImOyDuzuQPu4TrvM4Mmo6f4L+DH9
 Z3KUtc8+OGRw9Fgj6a+asiuLvaS/J9BrSXMt8iTlEBUbyTrraJFGjO05++j72OSuT3d9
 ODm3/AyVxLlX6vyrbF7yfSwRA8qhV1UvyB+jiph4BflbfzdgnM9goHKak9PkPIxJ4Rb0
 AEyqm3BoGE9WmnNJ2pcObTg8BrwxJ8cFbljMyhkEqwTDhTtcaxsRMWORVZcHUxs36EEs
 6SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132227; x=1787737027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BD8a3pc4ADyM2I0J0VOotFXEVkjkztBxyscs8JKEaZ8=;
 b=hnJd9fjNZ9MCgsIang+MLqOu4aVxQZirfFVQOtMsUOM9Ue/e+eJzsyz/H0I+1Wyu1c
 mk+3KsHL6fqan+mlLLlSo5Gs51EDoe8AWxOG5zTqAWLLxDmR2Bsgj0FWeb/6goJui8Pu
 tkeqGSE4UL2tSdkWMRBMjFYl8i8Z2mU6wVhQ1n8a21KVMjQzf9arwQuCEicpOefe02Vh
 4qfpoBHXVuHpEbYzRXXt60XynofQ4uy1hw9R8ac3Kt3JnII1k48yfgFWFWh71U71FQnr
 crv/1KI1vBTS+jMuzmT+ZAYN3FHPQX7KchA2HoTI4gXmiLdFzHOmvx+irBc7CIit6Ikp
 eXFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwQf0oLa38GOK1VGhj99ZUWuSrTY77pXAvfnY1fj1ZIMRLr4xlPBHqXOPbLZCRvLGQLcs85LE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwZe6G+13xk/1OLLC8qB0RKhgx6QwG4nRNMZ1KeCcVrVBJrlgDl
 1pZMNEXKmzDw4V+k9ih7OyzyQfVtE1B6zCaWus7dkQKM38NUFjDkdTlJ
X-Gm-Gg: AR+sD13j4/t+9MiRaRV58mn8TYLhzxTaeu3nli/Vbe7ROGFmMETfWxfUQZapqguoi50
 sHEocoicugk2cCbYhs0Xy1AMAPf7GMW8iD4CkLXLLC2E7QvRTNGrZINgapqF/b2dRq7ASDe0hcc
 tqouPEjd1CStdKrLmVWxBuFsmn4FxsC5Mkl5SbYKGmWMde3qTMj53eCcTFXUVsRhEY5kQM4gdAx
 6adj0GHB9GRKP21NgAm0BektUr9R5Kd2WhU8vaZDlp7cuhIzNpRjLWkaVrdjqqYeaoklq00OLOs
 SsvOu554g8A1F0lhirmvJNG+u1qgGRzc6jlxqTbQ7ESYqG5myP7mr8sq4xUOC4ixee73t1o/cBC
 GQuRpS+bSu8YCvYE4VyaEtzEEOx60h9qLLY7GS22TS+cytgCW9ffpy+d+QwnMFe13I/IzOcQ/Y1
 s0wEYei+1+lJRjoUkED7cezhSQwkzI7uq1ziguFln2d8Q0epQhNplfQzwDKnz01FXHjQ==
X-Received: by 2002:a05:600c:a012:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499aa180132mr63581155e9.1.1787132226606; 
 Wed, 19 Aug 2026 02:37:06 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aca21c63sm37939945e9.0.2026.08.19.02.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:37:05 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 0/3] usb: ehci-vf: take the register bases from the device tree
Date: Wed, 19 Aug 2026 11:37:02 +0200
Message-ID: <20260819093705.4143509-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Marek asked, when he looked at the portnr fix, whether the index based
PHY handling could go away entirely in favour of parsing the addresses
from the device tree:

  https://lore.kernel.org/u-boot/1a8642c2-58c8-45fb-a0b6-2ae91076e790@mailbox.org/

This is that follow-up. Patch 3 does it the way ehci-mx6 does: the
controller node points at its PHY and its usbmisc block, the PHY points
at the anatop, and all three addresses come from there, so both base
address tables are gone.

What is left of the index is a port number for the choice between PLL3
and PLL7, which the device tree does not describe. It no longer comes
from the sequence number of the controller but from the alias of the PHY
node, again as ehci-mx6 does.

Patches 1 and 2 remove dead code that stood in the way. The first is a
code path for a build without DM_USB that cannot be selected and does
not compile; the second an empty bind hook whose comment talks about
sequence numbers this driver no longer uses at all.

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND.

Mehmet Fide (3):
  usb: ehci-vf: remove the code path for a build without DM_USB
  usb: ehci-vf: drop the empty bind hook
  usb: ehci-vf: take the register bases from the device tree

 drivers/usb/host/ehci-vf.c | 184 ++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 115 deletions(-)

-- 
2.54.0

