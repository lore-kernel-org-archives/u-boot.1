Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8963EC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46807407A4;
	Sat, 15 Aug 2026 13:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qFJH78v3gdOg; Sat, 15 Aug 2026 13:05:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45965405B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786799155;
	bh=RL729nIIOZyYHcd1P65kXGLXjyowRyEzrv+0hCnPR/s=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MlrKxEW0dH0fEg9H+tFL1JwWjiyyDJeasf7gabFn5PtgbDX9GcD/IvfiXcK/X0M8F
	 j5GkyeXOMypH3XigWqSkhze2zZ5dLX6sXSfZcxXsNh89ozg9oLW7ecrjMP4cG+FoqY
	 /8aT1GyyVGGxWS993gkejJ7IxR7Gm2LzC7CECinUM2iFezq1Vc72x875w//L+Q51PG
	 mY4DAGMG24GCgMboMgr3xciTtaYO3kRBeKIPZGV6R5BRBH4+veAi2C+uFMUB7MOuLV
	 jhuY9WyeQkksMjd3PqLRNykhSRy9FEqvSF67TPhRc5jOa9GlUzC37B13F5YmqIgeuY
	 O+tFisD8k33iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45965405B1;
	Sat, 15 Aug 2026 13:05:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 762464CD
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67D676065E
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sE96x5-XhRbr for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 13:05:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 715FB6065D
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 715FB6065D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gyFhVQuN
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 715FB6065D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:05:53 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a1541ea780so284924a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786799151; x=1787403951;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RL729nIIOZyYHcd1P65kXGLXjyowRyEzrv+0hCnPR/s=;
 b=gyFhVQuNOEnmQAYYkxwNwRDX+OFV4tcbynGxPRKUw/BQPyHbiGgLLBLjZvm9Z85Wxi
 E7z04oTHUqea7fhxWY8eSTl61AOxKX65/y0/GblRbSYLmgzvdKPrCbAqqYG50B43f21b
 MQIe9noh0I5eNhz/RLQdKYU7s8ECpXcDXhxCCtF+kTV8zjid9yFI/8qpUihcuo315m4W
 I0oD0ksuELE6NkkDq9jTGcoWMM78anphEVPfppPQG4tfQ9unhMdimvZsVnvzL8iIdwfi
 bmNeTx3DE+8LB+VxSGHwBf/DF1AE7lO76GW3bvgt5t+vHaawGer2/0TA2berXs2mN3b+
 /J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786799151; x=1787403951;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RL729nIIOZyYHcd1P65kXGLXjyowRyEzrv+0hCnPR/s=;
 b=chdSwmppsc6UQNQCLD8tBI+IGkEefff3VzPKSEAulc3vqE4XI/+JM/8p86fZEkdzwj
 yaeR1RPnH0SYy61FQOuUVyLHCvToohovNAkcPFhaVmG7Yo0538sMiakUMWwuzejs2v50
 OYVxAJPR9kLGm5gVAfa9kRfWqdnbiMaAsvfKyw2iOAZ+j3PBLjbbOECqD6Otcm3aR602
 sNfMBsxdoqeSYczkYbhPu1IaqXXLo56o/mdw0lpxABDyEX6bqDaYaowJqhz0vdb5TixK
 yPB1XreHBGsJXEFRkJN+N0bjoPXGcdVXj4sqOs1JUWVq4tbd0SNdYIcg+T3znD9SQG2C
 Rw9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrEz5X0EdnoI+V7KfmT/YKSztrGqvEb3i6vZJ8AH6K3zGXovyWJrDiimVT1yHJCtLvnZRU0tg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz4zCiDvd9zO5TINZls7DVjNotuJ/n33EumoWEmqAQSCOCJvrcd
 D/dlRrfwrzbUvLip8CRfJoOH8+3/gjo2XlDVQtg+Gw9Zu3/X9fanPBF6
X-Gm-Gg: AR+sD11EhTYmF9Xo8RX/ODpU7cJFHAqnJok2YN8/5PlCD9k9vtL8gcEK2HFSQPFESpj
 OUsryS5igJQ94Is/M5OPjqt+lHJJT3W/fno5vJighRiIbbaXBagGtNssst6It6EEvTfqlUeTgip
 2i9apBzS0wJxcnjItc72my+6rrlXJwrIiDrWnzl07gvftbgnL5ThsbEymeZ3A/AACBLiHjtzR5l
 fYrJQioE1yjf+BEQculuyNdt6HqoW0pNeFIFSqVB8GRg3jywG9HFX7dSOE4hKuXr0ZN0g2XLUYh
 o7+sVEvNmfD8uSCCRpJiAcyyfX0u0dGU4xsujDJgOC4VHDb7L8WkvfR6wUHme/26I8UEw6pPyAf
 duzRDgoWNeDOr4xY6qWwHOcXw2ACb1loPc9goLZKolWIMXzZrhEncMiaDC4hXlzpSCFUnqBOzGl
 lsFqa6I5nOCIrJ2pcSkzkcJ92dajWhrR3DjLdOPWXDaza3vB3poHaRTOpIuPUjPa5/54VddKLMW
 u3z2hTcRpbtxGM0+ysxCaKAJFk=
X-Received: by 2002:a05:6402:2488:b0:6a0:d5f8:9ebd with SMTP id
 4fb4d7f45d1cf-6a38a941dc3mr3233109a12.2.1786799150884; 
 Sat, 15 Aug 2026 06:05:50 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21238443adsm220430366b.59.2026.08.15.06.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:05:50 -0700 (PDT)
Message-ID: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Date: Sat, 15 Aug 2026 15:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v7 0/6] doc: clean up README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The removal of README.rockchip is long over due.
Prepare and expand rockchip.rst with more info.
Move the still relevant parts from README.rockchip elsewhere.

Johan Jonker (6):
  rockchip: scripts: remove rkmux.py
  rockchip: doc: add mask ROM mode text
  rockchip: doc: remove TODO
  rockchip: doc: remove README.rockchip
  rockchip: doc: add back to ROM section
  rockchip: doc: add notes section

 MAINTAINERS                     |   1 -
 arch/arm/mach-rockchip/Kconfig  |  16 +-
 doc/README.rockchip             | 684 --------------------------------
 doc/README.rockusb              |   1 -
 doc/board/rockchip/rockchip.rst |  55 ++-
 scripts/pylint.base             |   1 -
 tools/rkimage.c                 |   5 +-
 tools/rkmux.py                  | 218 ----------
 tools/rksd.c                    |   2 -
 tools/rkspi.c                   |   2 -
 10 files changed, 56 insertions(+), 929 deletions(-)
 delete mode 100644 doc/README.rockchip
 delete mode 100755 tools/rkmux.py

-- 
2.39.5

