Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2214C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3796C80E34;
	Fri,  7 Aug 2026 16:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTjcfVYmUyk1; Fri,  7 Aug 2026 16:12:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25ADF80D48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119171;
	bh=JceJu2AvhGH4Q1dPq02j2kYJQ0nAL/oXneLxbxSqfhg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LsLZJFj6LSW2Aj5GEg1SOPB114g3D3Oj8HOWHiIswUhiA5xkebqtcVAMk1Ui0B/+C
	 HOKGSbYSuRYGl/HsT+x97l0ueHaEDwYA16JNoi+WBm9WMZ8BrZQLbjGqCLJxM23hbr
	 1xUIe2zcJ9kY7k65amRXa2FMwn1M/Y3XSow0/sq55jh+k9ONza/GQxr/t+IK1SmML9
	 lHSZmdtMXtW6n+BPZy1wVfI7iKTrXsBRzJhcQKwGh85ohlJM5b5Qnnm/3WuOwezdCB
	 JFwAujlyAYjiyegmxGOIY5FO+BhgoWtiDW5/qEuHAvuhEWjCV0GoVTESbNAQEJxp3a
	 xYIwhw4XXpzvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25ADF80D48;
	Fri,  7 Aug 2026 16:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EEE1392
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4813440A6E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-pjR47k528F for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:52:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E87D140998
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E87D140998
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E87D140998
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:42 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so464013366b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786114361; x=1786719161;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JceJu2AvhGH4Q1dPq02j2kYJQ0nAL/oXneLxbxSqfhg=;
 b=RxSfHumVrGPkJnh1NLlJg81ENl8sO8ySfGMtNd2CGgxwrjdHzGr+I+eMSrDYqaLXMN
 pLygUTsCeVanSnh68mt/gb6+Yt67iKYhUEdj9iALzW4fL2WFub24/UAKm6Joz4EFwzaz
 wNCzhzMS2dgvqQEa3j5izV1ZZRatWSkfHFikUa0cIw+ih8OM/K74iZIOWy1opTwXl/DK
 zKR6g2NawHJf8UdaqKKavRCiz90AZjkbvp0tmQfZIUDrEmzUS+vA0K/HHEIF60iXpX3B
 LykmbSazKO/xysYOW8Z1PP7A7Fih5QskzZj4CK5LoxsO1zzXAnq1+Qk19N9WY2lBBSGV
 rv6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3XzWEcO4cveV7ZMddtUO/i0nuZARlRzw67sQQF9QS9dwxoVtxWPUmirpOckgxVRJyRt2UE2M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzE/a8zvDEc1V1tYgz3rswW3DX7AIJmsYU+hXvqCOXvdzS8bi+Y
 9JNgl58auNzv+h7wuegmVnkL0ECf93YKPQyCZANejcqq4ely9X1mrNX3WazaPRwlFy9vCzEZPFK
 vLM0iU0Y=
X-Gm-Gg: AR+sD12/L6d1UCpezAWfziANVyhTM94+Xdao22VaXh+qvvyHzY95ZgCPk7gdfTlBByP
 gd92aVCJc+IgJUVkvsln6J12bJrXO8xz/9C87h4sP5z4r02ijiCMeVQH+6aCJYjYsp+h4J0x/qt
 spkvtTGlOmNaPGKlNnp4rJz5Z1X610KilNZwwRpXGXGDkfhWOPTZ4T4go/qV2acFDn/DuRaeBXe
 lFMw08RoXjOR/t8jkWyzXQRyGVy7fmJNsevIv4VQJe6LLkTqW8O7L5h1R3Cvd/gmj9Fhn6tTNGQ
 7Tn04IEd4CXZTtI8Vn0h1gZHpoCS00uS5nNqLwVxf5k3j31b4oPUiT5AGdAG1xm8GnBpvo7rO56
 3r+A83tcieFjaCmsb9EOrk0eMBEb2EOkQ06139xzvherAZ9t4ZToGCCA8wnogJkbV1Z3HGipy+H
 fYeM6MH1+ciEfkEoN7reolczIMO36VJUXbkyUK/uzVbzDQcZQEf2xDmRex2QmtNro2zGPhysS/Z
 sKhkCssgIMhiMjwyHtfpHR2nusqSomKEP3/MVr/JzX/VwZLA9w1B1l0LSzqXQbk
X-Received: by 2002:a17:907:c15:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c20873bbd59mr67187666b.12.1786114360570; 
 Fri, 07 Aug 2026 07:52:40 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0050294ea7756f18f0.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:5029:4ea7:756f:18f0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080cc3963sm62218566b.50.2026.08.07.07.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:52:40 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH 0/2] net: dhcp6: fix an infinite loop parsing IA options
Date: Fri, 07 Aug 2026 16:52:20 +0200
Message-Id: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACTxdWoC/yXMQQqDMBBA0avIrB2IEY32KtJFnIw6UkxIrBTEu
 ze2y7f4/4TEUTjBozgh8iFJ/JZRlQXQYreZUVw2aKVb1SmDwRO6hUKLYvHlfcC+bkaqrHGm15C
 7EHmSz+85PP9O73Fl2u8RXNcXXUIgQ3UAAAA=
X-Change-ID: 20260807-poc-dhcp6-ia-loop-935bc1a7d792
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sean Edmond <seanedmond@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Francois Berder <fberder@outlook.fr>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 07 Aug 2026 16:12:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786114361; x=1786719161;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JceJu2AvhGH4Q1dPq02j2kYJQ0nAL/oXneLxbxSqfhg=;
 b=SZFnquBVwBD6EKy1FBvpnlJ+nPn4F9FQvnw1FvnWssSR422S3sNRSpygp8F7L0VOL2
 ScrkQcW8MdUFabt7T1F2k7Rec8wNan5ej1wm3bjResMNIMhjqMTrT6q0L+lDpK2hLTPb
 qIJB8zEzsKviuji3z3qd+mNrUPDEWCHp4wDyWlRlG24Ay5q/9kxf9zGQawf4jbjwxczm
 YLY7uXQamAxlGsrjQzB0gJ9FKt65YURDqoJxx5vgOaVqOQnz77MFN/HPKfI/YVx9HKoW
 +6gywXTDb2EhjrTGLEy6AIADRMS40tvBMKOG2xFQ7kNrG49JnWqVXIBJSa3wXTtN6gyu
 IXrQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=SZFnquBV
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

The DHCPv6 client hangs when a received IA_NA / IA_TA option contains an
encapsulated sub-option of length zero: dhcp6_parse_ia_options() advances
its cursor by the sub-option length alone, so a zero length never makes
progress and the client spins forever. A host on the local link able to
answer the client's SOLICIT during a netboot can trigger this; the IA_ID
it has to match is observable in the SOLICIT.

Patch 1 fixes the advance so every iteration moves past a whole
sub-option. Patch 2 adds a sandbox DM regression test that injects such an
ADVERTISE and checks the client parses past it and re-solicits.

The same parser also reads a fixed 16 bytes for an IAADDR sub-option (and
a u16 for STATUS_CODE) without a length check. Those reads stay within the
received-packet buffer and only reflect packet bytes back as the client's
own address, so they are not addressed here; I can send a follow-up that
bounds them if preferred.

A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Shahriyar Jalayeri (2):
      net: dhcp6: prevent an infinite loop parsing IA options
      test: dm: eth: add a DHCPv6 zero-length IA option test

 net/dhcpv6.c  |   3 +-
 test/dm/eth.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 1 deletion(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260807-poc-dhcp6-ia-loop-935bc1a7d792

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

