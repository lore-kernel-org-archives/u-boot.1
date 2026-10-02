Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D90BCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 08:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C69440A2C;
	Fri,  2 Oct 2026 08:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ozy7_KR5YqDQ; Fri,  2 Oct 2026 08:38:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16F9940A3E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790930286;
	b=Cd7vG8Q7XnaAVyNnu1LFmbxSewJ8fknLCI6239f2654crCSqdxUnhaoaswSRagbOhJ9P
	 5opvYpbWCHbSmFGOYa+Jswqpnc06b4av7KsfB6y9U8o57Cgfu8N82ZbAchVO7wG2ZV1gi
	 yDI0NUhopbqygpxKmJMCDBlgLzUpMDgqmNAXtheU58kb+fi3M8nb4SCxHjDRmLGfSaR0e
	 4AVZF5bu/IE2Go/04rrIpoS9Iiy2LaapIhvW6VIEIXp9R9X3AqVFExaYVTTGCESx6VN/e
	 jdWf2/bIfjVKULm94/o4gwFldP5Hze//7KaIS/B+U867hjvXK9G+ycyxMa+Pn3QrIyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790930286;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6udmjIeM/Rrx/JJO+ZXB3lFArxgz4HDqU30UeaWxX/c=;
	b=r+vJuD+UbvuzLFk+3Uheaah3kI8uSitFbtIlevDEEbLwOe1Mblhda+nn3Gqasu8Euttl
	 Poq0HWKsdmz7qnBxLkuK0eIiVawPdDOTgvQZRW42CsI0p77zhNnJN4kvlIzbLUMvnkTRd
	 73PKmdOjv/Ojb976uNW37dgqEKU/Yp/NME75ZEHljsSjFwC5iHu8YNvdomd3b2mX57WoT
	 z62Di7xO6Tv2W/EpaxObcukJM4Mud9qo7pD1LZnP8C9acFi6nNoPyRSsIsuwuxu9aBbL/
	 yRerdoXY6OZoCoGx5rhp4qpjdqPcKdahWKWHieKmewN8Do8K68g/vKFN7Nc6OH6QV1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790930286;
	bh=6udmjIeM/Rrx/JJO+ZXB3lFArxgz4HDqU30UeaWxX/c=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x+/17QUZbekS/cQs2T4N85gRTFSWC8/EjozxNcgQJcZImkYco5pgnpWSTmebbWym8
	 ICaNzRbFaRbzyoWeEdZecqC8R4Wbp4km26oxW3mHe0NYwPTXj6J7fGHcrA57+W8jIx
	 j63waFSW4k0xT7HFH7knfVTGtgh9+LSh/56HhavM3wQs9PSabCIMxT/dNHlZ06GZiB
	 TjQsNQZ/dJlVUBR+2vIN8jl1bN1AYpCxID/HmutfEVnTVuiF2gjmLMCAgZuydmrwqc
	 QjnFfwUFxB40Oc3dNKPCTfUMPjfHGeadOFcB0a7LhVtuIuDGdYBYErbKRJ4nxnhJHp
	 ObJcsvlKH5cdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16F9940A3E;
	Fri,  2 Oct 2026 08:38:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BB4B22B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5BDF40382
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z75GXq-yzfqs for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:38:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E99D0400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790930282;
 b=D7W9LM9I/VXVxnaXU5JbPJtfTgmmbEqm0NdiECcWDO4Ywl+sVx6sBQ+jvleWgNeQE3oF
 7doHJklXlCt50KLmWU0CZ/2+97PpJ8vBTcyep1X1CGw8nIlcZf4Xg6dchkjC300P8PdxR
 942fURjz9SSQ31HAA/yLxUxY5yU1Qn+IfZrUmCKyOW4+nwmno+S+nCWNpTfiVoTwlF8mz
 KBPHXc9j7Tfx5mS27nQnjulBZtss5a9+BhBLvXzx0ObqLnxSw8kRlHWrCkH1GLW1Be23u
 4dAm0pOR+J4Umz+2yK2eCcLuSGVSvSbdDRo+s3Zew7q6miOBrWCwNnql3N9DR0LyaRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790930282;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=6udmjIeM/Rrx/JJO+ZXB3lFArxgz4HDqU30UeaWxX/c=;
 b=Ek6x/J70a2yQE0YIAGCuxE86Tgs2hSgFZRJVPrn27CmNoyr6/pn4fcZYLU9XZLKY1ohc
 Adw+MZJd6m5v6riT2fbUDyohy+V5x0viEhMJgeNYIYxKMZHpzGtCtcguCG0jXhQbaErWS
 CCuT+R0HYhyyI+n1JJeMMQm3bhqEkfEek1FGkSiXTidfpDT1mU4ITwwSzPkiTaaUXKesq
 z52hA0dig6NkUl8kzIWbtVHVolYpq8GS7GPvvhBQepe47rx3G9lU79qJZVsaiwDn4gO52
 NvRZCw14HwYvlOx+1JDZGuMn9N+cwQky2gque/UAbp+IyNL4SDOgDTDmyV7WHURZWlA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=tZACNIO2; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=tZACNIO2
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E99D0400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A45FD497;
 Fri,  2 Oct 2026 01:37:56 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.11.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F40FD3F85F;
 Fri,  2 Oct 2026 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790930280; bh=ZO9zW3nVg8R11BY7Y4bU77Nj7jpC34GxAdgqoktj2mc=;
 h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
 b=tZACNIO2g288YJyDo8VPWmL4AqXU1vh4VR4gKxa3Gbf6SV138eNLRO9CJrVAriwQi
 Zf2wSLecpYCU/rznIqvo2mMXOYe4UR/Q3+W89hvXV/iNH8spxfZfQl/UDSp1mzFQOI
 PiFix90Bv3TEwmOS+cQKZPf+hK1v+XE8WhfHPm7U=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 0/2] efi: fix and test FMP image info authentication
 attribute
Date: Fri, 02 Oct 2026 10:37:46 +0200
Message-Id: <20261002-authi-v2-0-900f6f9141d5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw7CIBBFf6WZtRgKtQZX/ofpAnCUMekjQImm4
 d+FunN5knPP3SCgJwxwaTbwmCjQPBUQhwas09MTGd0Lg+Ci50oIptfoiEmhrO210vxsobiLxwe
 9985t+HFYzQttrONqOApx9p/9KLXV+2+mlnGGqpMnyWWnjLlqPx7tPMKQc/4CnGdM3KoAAAA=
X-Change-ID: 20260922-authi-329cc6a9a07c
In-Reply-To: <20260922-authi-v1-0-e943530349bb@arm.com>
References: <20260922-authi-v1-0-e943530349bb@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=ZO9zW3nVg8R11BY7Y4bU77Nj7jpC34GxAdgqoktj2mc=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqv21lTI3EHUuY0X/QOfYgW3ihWvzw5YZNEAupt
 WZCZuLdbx+JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCar9tZQAKCRDLSfhWdqMG
 lIbiB/9AyBYNtQNJyXnLwGvcXD2tpYLX5OcniOG+AbQU3sZmDwTtM2EJxQ+w7pkeLy+Wkb1q+Vz
 BEvHOfMxJ0e+wQEDgbg0flDvPd7/yIigeokd7fulHTBR7s3gmPyLobj7+9Z/+EdW5b0iuozp3Ew
 jA91osSt0IutrhWvcIPLNboQZ7u+CMft2IaGpBubd/y/egbD4BgT4dptjRLEmeBkDeJIU/Tguj/
 P+LrHu7ZtFdGy9bBBd+K7D4dnjxIit3ZQ02OXt8yowf6iu8KDY/qPr1lEpgtJiaLBu1v1OGACn5
 EEP3ekYpiScytatVdzlZW/I2vuOFmjtC2OFidi/xiIDYE0al
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Here is a couple of patches to:

- Do a small fix in the UEFI Firmware Management Protocol:
  GetImageInfo() returns a correct authentication flag for the first
  image, but not for the subsequent ones.

- Add a minimal FMP selftest, just enough to catch this issue, and which
  should be easy enough to extend in the future.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Changes in v2:
- Rework FMP selftest with Simon's suggestions (changes details in the
  patch).
- Link to v1: https://patch.msgid.link/20260922-authi-v1-0-e943530349bb@arm.com

---
Vincent Stehlé (2):
      efi_loader: fix image info authentication attribute
      efi_selftest: add minimal fmp test

 lib/efi_loader/efi_firmware.c       |   2 +-
 lib/efi_selftest/Makefile           |   2 +
 lib/efi_selftest/efi_selftest_fmp.c | 240 ++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+), 1 deletion(-)
---
base-commit: c92d8c3c431e37a17c3b37918037dbd7ade32d1e
change-id: 20260922-authi-329cc6a9a07c

Best regards,
--  
Vincent.

