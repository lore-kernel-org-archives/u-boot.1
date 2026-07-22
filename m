Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B19C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9E58407EC;
	Wed, 22 Jul 2026 08:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVRz_TiD1MOA; Wed, 22 Jul 2026 08:15:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82057407C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708137;
	bh=aLUGOGw0UMWjBCviOHlscJn/JnxCUG0wExZOA2rlspI=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=lc3KvmUzHSL+SYDGf4kRt7VdEOinRrqFbBU4TGBCrc8h2OFXcfgPvESiw/hHBhzpj
	 xbL6ShFMtTncwsJM5+xJd7Zp4mirv5MGq6P7rETO/sHtsfxuydlB7MBzKNHXZBJx9v
	 dPOtGl9YLXp1OrsFgegRzIpTcnjnaTgyRt6wOAmXSZwcYBSrh+qlpvXdmYMNOzfV1q
	 Lc1RujOozAULCM8SoO/jZGNkQL5iTMQQjlMm5hKpYRqo0F8CroWoMlf40W2ToPieHg
	 g984/XNzeeJ3mJGNFQhbQvC0RMjgSuEuqIPWwaY0PUgy48nZrJpQzbamwI8BmGtZJ3
	 7SLljG/cnFhXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82057407C1;
	Wed, 22 Jul 2026 08:15:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2EA01331
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91356400F3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hoQVKRU90BgZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:08:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CC22B400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC22B400D8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC22B400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981318498B; Wed, 22 Jul 2026 09:08:19 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E90803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:08:17 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69c7697d523so7884042a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704096; x=1785308896;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aLUGOGw0UMWjBCviOHlscJn/JnxCUG0wExZOA2rlspI=;
 b=HuSwxkJPTuhb+3pt2U0eNSVtTJuajvupKSAC/vJk5sah0a72Iqc6ytjB5i5uYV6qh3
 HiWOeCXe7yaHxCrzt/8f1l2EwjPy4AtZVI9Gg8qtmQSOVlf1uhK7LRadX3GcIbZ5FDgZ
 QlKfwv5jTBJErLYnKp8uIUzYgQdDTM0niJq4tAXdSndt3owTMvAHJoKoUzr7BIhPmlvc
 tMEh30qpu2P8e0zeOQ4ouVUZ+qVyHmNuIFMo2h8GAwcxKUdeiBO/9rskQd4WOMuJIb7j
 gUrKmQQlIBsiyutceGPZAz+gmm2Bb998LJ6xsJB8k0afD1ylEWImMjVgeJia6RXRTP3Y
 u98w==
X-Gm-Message-State: AOJu0YxDryeKmHS+NZ4w6agUHi9aH3pQ+C+Zdvub1na0mgigEPXayceE
 4jSPQwHPMIzP2COCarAZdzHLUkWpvuP4/oufjNX5ebOJ5bY0khh2WvdswrCP4w7Nadh20pPJOkU
 w/vgamq4=
X-Gm-Gg: AR+sD100eb1LOY73N4/tDutB7IMDZE546ddThCJ+iTZAklPWE/JRLYaX46f9UIRvqlr
 hUIO7a6lSMe5LPRWfqXw9O71IuM+d6R1pc3kQpKetXWF1vwFGVk5bcOhdY4cGXucqCjTheFPlnm
 93ZYGDsgH4RIYxw2gQxnIS84DH5++IXUWqa5Z8/R3hVRIkvltGy/+0U4ToCeqIXL4nKuXBzv6XN
 KJfKL58Z1qMLX2mkIDseZQ5GUjPR/RflKKikllTR5tx7PpewrjWtY7CZOxMt2oYtlYgABDF18T8
 KLkgx1Fb+VEkIAbEaNTKwWSlAHeUHCzzobphCorZVZ0CaMqe/VKq86/g47SCbtXExRikSilfSHs
 S09+aao6hff6Z4JWWimH1BB5E6N7HoejLf66STS7pz8bCzuV+ldY5PBoCoIwuVK3WpistE1v63L
 3GNSUskohC9ptOP7k706Ty4Si7pBM1sdYh+XIWHmEvg/O7Uu+/yQJW6AnZOYsabQ5yWQ==
X-Received: by 2002:a05:6402:2b90:b0:69f:4b79:6374 with SMTP id
 4fb4d7f45d1cf-69f4b7965ffmr97227a12.13.1784704096085; 
 Wed, 22 Jul 2026 00:08:16 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed000709884cf8c8be3b.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:709:884c:f8c8:be3b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f35039aa1sm501347a12.30.2026.07.22.00.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:08:15 -0700 (PDT)
Subject: [PATCH 0/2] net: fix out-of-bounds write in IP fragment reassembly
Date: Wed, 22 Jul 2026 09:05:58 +0200
Message-Id: <20260722-net-oob-fix-v1-0-2c711321540c@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZrYGoC/yXMwQ5AMBCE4VeRPduERhCvIg5ag3VopUUk4t0Vx
 2+S+S8K8IJATXKRxyFBnI3I04TM3NsJLEM0qUyVWaUUW2zsnOZRTi50PZq6HwBTUnysHnH+am3
 3O+x6gdneBN33A09lg/pvAAAA
X-Change-ID: 20260722-net-oob-fix-4b8fc8adeec6
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 22 Jul 2026 08:15:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784704096; x=1785308896;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aLUGOGw0UMWjBCviOHlscJn/JnxCUG0wExZOA2rlspI=;
 b=T7TDNesXCOfENVAW/qqYFiH2kIDiYn15ihHSk5tRLQIMebJwg1yPZGgNRQsOtI8TCL
 a0aXzEDMDgeocuwvn5SM2krTy2ByFk1xiuneFA6y/GPcmYk4Q12J67uaEBysK4R4klXE
 OYxWoFmBIbhLULH9J+d+4OoFsLreq3tyYcJEKz8hAqZyryWMP3y5wpvsV9uhjCLY3Kjg
 p8Njagt9ZrdNiAfdqRlVd/GfTgT8rLInej/+M9+cVFrsVeDAIbkSM6sDP3u/njNlEl8o
 6jQY5IHLpvLYGy6OQmTnmCEFolx34cRksAj0Pp05tl6pdGOIZnMSSh6vpCcS0auiLoIN
 Hxhw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=T7TDNesX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="T7TDNesX"; 
 dkim-atps=neutral
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
From: shj via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: shj <shahriyar@byteray.co.uk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This fixes an out-of-bounds write in IP fragment reassembly and adds a
regression test.

__net_defragment() writes an 8-byte hole descriptor that can land past
the end of the static reassembly buffer when a fragment with a non-zero
offset and the More-Fragments flag set is received during netboot. It is
reachable on the local network segment while the device is in a receive
loop (dhcp/tftp/nfs/ping). Patch 1 adds the bounds check; patch 2 adds a
DM test that reproduces the overflow.

Based on v2026.07 (fdfe2ec48d5c).

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
shj (2):
      net: fix out-of-bounds write in IP fragment reassembly
      test: net: add regression test for IP reassembly overflow

 net/net.c            |  4 ++++
 test/dm/net_defrag.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260722-net-oob-fix-4b8fc8adeec6

Best regards,
--  
shj <shahriyar@byteray.co.uk>

