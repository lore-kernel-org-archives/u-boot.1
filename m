Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42148C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1822860859;
	Fri,  7 Aug 2026 01:50:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ww00q5KvMJ6x; Fri,  7 Aug 2026 01:50:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A88260860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067427;
	bh=FwAUJir9qCXV12sQEfkidnrweXoLe/QJ/PySfNgbcC0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h9XexFQGbfJyRM2qu9QXWmAdV0qlcD8EKruF5PDLmTFqQAHHsLvxxqB1tuUFCWHRv
	 03DSI8VgN9ylidnzZsPe2z5zvNC4m30bhHBs9gSiJRWY2gGXC8+i84hGVWiIAzDs35
	 BQsqQx7l30Bv5KraqF9HVkovUJdgQSCXvhNxvhTC9p+Y6OBohwz4I8gCATflU3A6Us
	 jm2hDvKvigRlc/f75asOyrPawmddfPjh20SN2E4GOzWxGPaFy75XX8gxuPtMTnJr96
	 AFoIIf2kUQ5DRM/MWxzy5WY4IE05TXr9KXRzgn0kaQdi1eEZpZZtGovY5VSdCcnixQ
	 aIDbJRU86OwIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A88260860;
	Fri,  7 Aug 2026 01:50:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3B74392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8977A40866
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhWfFNfJ6MNl for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 18:38:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3407040813
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3407040813
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3407040813
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:06 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1677c91969so302602566b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 11:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786041484; x=1786646284;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FwAUJir9qCXV12sQEfkidnrweXoLe/QJ/PySfNgbcC0=;
 b=YGneIuYr+sFIfC7Mc4DqeXXfYHFuQv25Ue/7oCsOupKaenrJgi5rVrky7EeJoDJK8V
 NsZ5sSGfMUOOM+Nh58m7hXeFRa1pre7ZnNzAD5tyop6jYlyBddveMcJiKs+8OYPdK72j
 BLzSEqsutGLV58ZwEL0NTPWbLWnkdiEyBjQYbJ82xzwFhqyepo9QSytyfHmUvu/vgneB
 thUuy5uGuOfPaXkpEg34kliQQU0GuTg3BCT58NLFOtyT9Lzs1T262SKv6T08xWd1ZZxU
 fcL40fg7VbEc6AMYirXb2I/7HfR6RGRNM379WPoQWN9PJOAXSAHWTeJc0Hr8vq6G4gLP
 HEUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvItO/Q7spXD53o6UlfAVf11OPV7NEPPVCf3icfzOBRJ6n9MimRPtaaUsz2tqZB8fp81Xdkd0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YztbxjSpaXa68nI8oIoJMY12t7na5V46s9yqpg93zGfUbNTAuMi
 POWgyZTxelbZdWtEydYF0HNV1jWHLF3BpZnm4Gqme4CHcCDfQD/BI8kXc59WV0ThitCKzQ8qpM7
 M0IJH6dk=
X-Gm-Gg: AR+sD12m3BFrR2CgiACsFdMFEdnefoIZRdgUdAyi/sAAEH77EYVE82JmQYY6LOF+BW2
 smDAY4SkOz1BApXi3/o8P4gC0HfS+Gzj7WLyNTBm+eC1+jEd7HJKOlY0Oll8TdmL4cZYJyHi8z9
 5JkcoUm9axHti6C0JSVXthMKsen9kt5KhJtRxzB1nL7IWTFc7NThdvYJoKunHFeH+MVvTSiz/bg
 FAqqXG+kIujpJXtIz0u8NYvme2USJLwiyzez/fwNWimP7KFVrGImQnD/OYQnt0WBz1pJCzE3wAc
 9M1aGP/lsf/uaygnFUljLPC2t3H5ANyX8DYSFjEq9vfBbwsxPwqx0ovWmWwruqihiQCiJbEKaXi
 OHoH0ras7B1LuepzNUFz16lNSH+yWlyS2/LMWUkB7/aXhmMa5FNnNoEqcscMrwjJbAyeW56VICh
 Jrp+w5BkQryilM6LnHYLigYwcxGYI85afdgop2wLR/KaAxL9yk7H2+6K9Kn4uA9lwFAmHNt4tee
 J9qkXJCioxsAaMvVrX7CWEYQz/ngJl5nKBncieLYwr6/iawUJNwsg==
X-Received: by 2002:a17:906:ee88:b0:c20:3042:3887 with SMTP id
 a640c23a62f3a-c2039ca7e50mr729242366b.22.1786041483482; 
 Thu, 06 Aug 2026 11:38:03 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00156d21543c815f45.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:156d:2154:3c81:5f45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c203642435dsm290075266b.44.2026.08.06.11.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 11:38:03 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH 0/2] net: dhcp6: fix out-of-bounds access in the option parser
Date: Thu, 06 Aug 2026 20:37:49 +0200
Message-Id: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3UdGoC/yXMTQqEMAxA4atI1hOIHSkyVxEX/YmaWVhpHRHEu
 0/U5Vt874DCWbjApzog8yZF0qxRvyoIk5tHRonaYMhYasmibzBOYbGocFMbMSWPZCOxN+3buQB
 ql8yD7Pe3658uP//lsF4zOM8/eZuqtHkAAAA=
X-Change-ID: 20260806-b4-dhcp6-serverid-oob-06d0eb283aac
To: Sean Edmond <seanedmond@microsoft.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Argus <argus@byteray.co.uk>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786041484; x=1786646284;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FwAUJir9qCXV12sQEfkidnrweXoLe/QJ/PySfNgbcC0=;
 b=WX7ftKGFkkBolNLdsaqeJV20FvAbH1Uh6z0XIsF0OhgOvA8q+o5SGXWTxXX6RLTFdC
 ijdQB4dnN1O/s6OSVvYJMIMLg3MzQUUxf+JNJuV52OsJYufVvrWX0Ieef7Y3OiItNBn0
 p9Q0qr3bQMS/YzvsXrQ8bfaDQYm8+nRar3HvQ9tb3Uo6sd1+EEci0pQoKEvEnyqhSnad
 b38InRXv1niA5itNJRCbqTNGCbJkPkKm1iNxPUi8VKZOBVpDOs9Uq9NGDz/hBoXiMmCP
 Zerob6nD6gmMzq4dSefhLTyEMu7QR7LP49yZYaLILSvGiNTQ+4lNVdmRk57+1fwsjk5E
 vMIw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WX7ftKGF
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

The DHCPv6 client takes the SERVERID and CLIENTID option lengths from a
received ADVERTISE/REPLY without bounding them. The SERVERID length is
later copied unbounded into the fixed net_tx_packet buffer when the
REQUEST is built (an out-of-bounds write), and the CLIENTID length
drives a memcmp against the fixed client-DUID buffer (an out-of-bounds
read).
Both are reachable by any on-link attacker that answers a DHCPv6 SOLICIT
during netboot.

Patch 1 bounds both lengths at parse time. Patch 2 adds sandbox DM
regression tests that inject an ADVERTISE with an over-long SERVERID or
CLIENTID and check the client rejects it.

Based on master (baa64b2f892). A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Shahriyar Jalayeri (2):
      net: dhcp6: bound received DUID option lengths
      test: dm: eth: add DHCPv6 oversized option regression tests

 net/dhcpv6.c  |  12 +++--
 net/dhcpv6.h  |   3 ++
 test/dm/eth.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 4 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260806-b4-dhcp6-serverid-oob-06d0eb283aac

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

