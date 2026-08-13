Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3323C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B1CE60ADD;
	Thu, 13 Aug 2026 15:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4afhibOftb-3; Thu, 13 Aug 2026 15:07:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 285D5607F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786633652;
	bh=P7jF8wVWRAUu/zq7Vg1R20cxlDaRmco/q/4Tgb9yJg4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X4Skx9XX1tOSIEKlpWzhJlix8+/TlGT2AWHcWkzRICmK3JMkoGc1gUGvL/mYkGFe7
	 wlP+uUHNJ7VJ3P/35muXfappiXLze2a5KIvXX+XgH7rKMq5kuH9GswTAe0FwlfHKzT
	 aPhVI0MAEMyMPaApefde9JaCVrNCvWQPM7HUy5BG4PKJjxC5HLTBq3CYtqcy1JHRNl
	 qLCvncz3Y01M47U+kncLXmoepBA9sjZBdUcI6GjxuSD7xtXgDduwsdpKxb/6JCqqLU
	 SQgEgbgSAjLMWjvyubt5WSdUKcM4irRuqfTHTr8GUWlx/cIEZ5kfDMABxixZX5tcqB
	 FPGe7yCKOfNjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 285D5607F0;
	Thu, 13 Aug 2026 15:07:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C645EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1C7840987
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwT5iuYVwV0a for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:07:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D2F6E4096F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2F6E4096F
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2F6E4096F
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:29 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so147075e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633648; x=1787238448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P7jF8wVWRAUu/zq7Vg1R20cxlDaRmco/q/4Tgb9yJg4=;
 b=K8Vo4KFoD9vOGD0nPadlY2XDHdg2IeWXmOuF4U3VSS9mbRcnb2LbtjuS1qMUYR3WH8
 XvBnI49t9KVOQqzIP5a4sVV5E7tQk6Pif2ux+oRpz8lO+GfkSainKRKZweTj6k3WXony
 0wjnbrHBLHazCrBdPDEKpidkYzL6APtKj0PYVbWe7W8KpXIAP8nyvKoP9iXDrp5Qxj2t
 YfN13Z0p22afiGNnn2P0SCZ2TRGSC6X7gyAl7D5Nt2nOQY4LaFWsP0PzLUnP7nli/b0T
 oOEW3SP6329wbJbb6GgGKpOPMbXDeDB46u7IObC2vVpaBFs8xjkX2wPU4WUT+wICHnme
 xdvw==
X-Gm-Message-State: AOJu0YzoZyt9gKlUtp+HN8g4VY0/gVy4Pfyx6R3HMQXiTZKWECvpT8Wh
 2KjJqv4ejCPw2JV2854SnJQk749Mcc46qOTlpCAKyFquFpL8VZsH9lHr4sPeO+XD
X-Gm-Gg: AR+sD139sKgwcBSCQetFqLT9B9B1o9KNvDVuy9wxKeqelY6j9X2sjHXHMmjE/DcwO7A
 4KAjkQg8tX8ZaMYpOqIL27fbnwNR1X2gxdnAf8IHTs9fN50oPnG2mmc5hBhYdUdGa1loJ2BcQIY
 3E/WXKFhFwz2ID7DunvJM8d3JSSklG1z44bzkaeylNOdSxMFl0e2hRtFVLvaXPJaoxwPyuPfcGX
 SY1wIb48WWk1S4Dih6I2DV1xXhHLPDAv4Spy21UHvlpd0wVWt3wWRcs1M/e135did+mgxR1hmk4
 6ZLLeASr/g27hCEUHQA1XljJ/niqXpx0UdeKnVex3SZWYSkJpyYU69qEv+8ywbATmfpaA1egqgE
 zWOszePFQdsNk2JhVIh6+yMkPuyCV5zIEi+ghXh0VE2TD1Q+HbtxXp1UaELLCn+99QwGgzY0e91
 G/uaPLUhGsgITZMvqLuYSeSwWaWyQDb1raB5LDfcXpPuyuwKPT/lgvc+BPRVGUv2t65A==
X-Received: by 2002:a05:600c:4744:b0:499:7900:f2ac with SMTP id
 5b1f17b1804b1-499821d626fmr66301455e9.15.1786633647467; 
 Thu, 13 Aug 2026 08:07:27 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03cd0sm76265185e9.1.2026.08.13.08.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:07:26 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 0/2] colibri_vf: fix NAND boot and add the board documentation
Date: Thu, 13 Aug 2026 17:07:24 +0200
Message-ID: <20260813150726.2184452-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786633648; x=1787238448;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P7jF8wVWRAUu/zq7Vg1R20cxlDaRmco/q/4Tgb9yJg4=;
 b=p0usldwU8jLqXI3p8YrcgK7gaLJMehrmZ1ofSUfHfsYcn1sAyM7sJtCbEujhzamhUS
 Bk4HzUBE9qj5+INAYFEGQ5bQsE0psioySWyX8vw+jnSGkfbWUIuCex9NXpXR/yanquLy
 RMy8224Vx5slCZXY1zGCGG+m5oy5rQEet85v7SJFo8n+m60uJuPSULYPlmIr2La7cYNp
 dkkEQOaEOWFb+VTDjPN+nFyrC9xseZNth9biUbyYXwcAhqwkAp9eO298hcm+V+lwiGCe
 dTznPSMmsMHVndeM587nJrwl8336BQquaB938Ip5GApePDMKJp5ARgTHZJOrQ37u/vuC
 TYzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=p0usldwU
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Following the CONFIG_TEXT_BASE report [1] and Francesco's suggestion,
two patches: the first restores the text base the Vybrid BootROM
actually accepts, measured on hardware both through the BootROM NAND
path and the WinCE-era loader; the second adds the missing
doc/board/toradex page for the Colibri VF50/VF61.

[1] https://lore.kernel.org/u-boot/20260806124816.262259-1-mehmet.fide@gmail.com/

Mehmet Fide (2):
  colibri_vf: restore the pre-2017 text base, the BootROM refuses the
    low one
  doc: board: toradex: add the Colibri VF50/VF61 page

 configs/colibri_vf_defconfig     |  4 +-
 doc/board/toradex/colibri_vf.rst | 70 ++++++++++++++++++++++++++++++++
 doc/board/toradex/index.rst      |  1 +
 3 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 doc/board/toradex/colibri_vf.rst

-- 
2.54.0

