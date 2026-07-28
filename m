Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF6C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B287F60887;
	Tue, 28 Jul 2026 12:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6Py2GbrscLG; Tue, 28 Jul 2026 12:59:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3708E60873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243589;
	bh=ir82+1TkhsDEKQopE+Mot2SKVUWTAjyTXtxba4vm2MM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e4Fbgw6jiBIRizibFYpaLjQzYS5siSj+1NKZWFvtWNR87fEW8s2NczXqE6Yj+dNvR
	 5lXGCb/kMjv8ClwC5KpJKF+B7vMrDG2DAQDbZy8fijulkY2gllIKSa8drEouJ4aOsR
	 sH9idDNbvvQEd86VA6bnBkilf/ajk69tv/AaftcFKTfNnhYwVoadiJ7F2SctNl+GAq
	 1uhMWXBNDpcI1nPiN1hXATn5x1PCB2vF3TyB0sRkr7YUWIIctNsYCpqKij8vlL7zA8
	 BkuBT4mRH0+5rG4K38/cMuvfbDH2D6Mxln1gR/fFG1zrBJQ+xQ8/xnIHBIyvTz4Ebu
	 +zAL7pkOQEx5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3708E60873;
	Tue, 28 Jul 2026 12:59:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 044E826C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 023934088B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMVW9Z9V4bkq for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:50:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B2AD440889
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2AD440889
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2AD440889
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DAF8493F; Tue, 28 Jul 2026 08:50:25 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DA882991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 08:50:23 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso4940798a12.3
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 23:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221423; x=1785826223;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ir82+1TkhsDEKQopE+Mot2SKVUWTAjyTXtxba4vm2MM=;
 b=iXW8XPGgs43VZZmwMkOx3pP+J1b9wIng6ST3M84q9py3Tjqy7erd53ah89prgs/Xng
 VEDrCda3W1rsGYxmTCx3SEsNew09FOxp5koeZB/tqUI1eS+2AmiaNbe/nRy7jO5HWUKp
 L05il0p20itFrbNQIM6jYTsNxr9cnsqHgL/v6+eTSljnUleXfmtwI4n1Vur2fnHXpvkH
 8YKnuYVSDVOnMarcX3zQ53jaoyZXxW5ji/VcIV9wpkgBpnZVs/TmHUIJv6x/l2EN+Js1
 vkXrBnVvUmypK/fuStzqfrfb/koS6gMxRvsamz7mSi19FDMRzVe9dXP4pbgXIekt/SYK
 ul9w==
X-Gm-Message-State: AOJu0YwLntGfPJ5YpfSCbQJu3DHio7EPVfKMT3W4fbD7zBUMr5LV7lbj
 kIEUITkBUl+J9UuueMN94qSWx/Dp1q9wgk+etR4wH7aRBVSXebex3kJGfoSIHex3t7A=
X-Gm-Gg: AR+sD10i7amq5/2m0RqW9hgf993Npjbxvwttg4/W1shgqSQd3mH4Bjs9IS/SrHPqzaf
 eNfJW1fOD9HWfaaFI5ZbWomg0Lj17eNAz90I75VBliqO8scHD+6vHk1VZxyYaIFzpoSxnMrYSCq
 Em+54F21wyMTcAFS+/+JGN3DriJJ7A9QqsRc+Y/ZcoJtIV/Op3osC6B6y6SKZt7oGF9EZsGUPAv
 IXHXnfeIXhnilCSOj5WPrGN0vZFoIlOVf14sNrRQ92CZSuHaVscjZh9XePsv6JQd4jeoEMYdbKV
 +CqGJxN/a3Qr5noB6UEGxlrYVi2luSM5v37TuqBgWbCZQCgiUzwpsQtWpJA3Fdxh4MlzwajbHUW
 /gm40O+8RR1Dt+olHhw+BHi5T0ucHyfTXrakrjIgWMCXQqxkGwHfin58yvZ+RO+g7r4jYNjS9Wd
 UGRd6Ib7Qp2K9PwgHGUPloftRnnR6wxtCjWNeEmoJX1ayfq+uq2MHferfDdf3DL9uPfnY=
X-Received: by 2002:a05:6402:240d:b0:698:ae9c:2ae with SMTP id
 4fb4d7f45d1cf-6a0349de2c3mr391161a12.17.1785221422770; 
 Mon, 27 Jul 2026 23:50:22 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb55438easm3557725a12.18.2026.07.27.23.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 23:50:22 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v2 0/2] net: fix out-of-bounds write in IP fragment reassembly
Date: Tue, 28 Jul 2026 08:50:06 +0200
Message-Id: <20260728-net-oob-fix-v2-0-eae61b883ed8@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5RaGoC/22NwQ6CMBBEf4Xs2SXtikA8+R+GA10WqSbUtIVIC
 P9uwavHN5l5s0IQbyXANVvBy2yDdWMCOmXAQzs+BG2XGEhRqSoiHCWicwZ7+8HC1D3XbSfCJaT
 F20uKD9u9+XGYzFM47oq9MdgQnV+Ou1nvvf/mWaNC4krrM+lLofhmlii+XXJ2+fSCZtu2L2lW8
 0m8AAAA
X-Change-ID: 20260722-net-oob-fix-4b8fc8adeec6
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785221423; x=1785826223;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ir82+1TkhsDEKQopE+Mot2SKVUWTAjyTXtxba4vm2MM=;
 b=K6P6ZTnvdAaSpjmZSkoLr5lfjdYmQAgppkzZrJ834MaY0hCOVnVpR5J2eWfYwwKXK3
 GifvvyHJJIzG+gIj/xZNRU5w4S7BBll0HQbKIraKZcUUp3rMdiDcnp31muVkyZh5nQ4F
 o5L1lRP+xkcfZXw6NjmG6FlN7mR+hY/FZHuhT+uja+oIxLCRWYHsd85a5CC9VtQYnoi0
 MOinPcvuGRRd5+4ttAJETqAXoVKNwT5mMWRZJRsRPqfjCWvcYTF72p4NtC5g4pj1/pNc
 yTLeICv8UlBt3PyKQOESCy/PAhHKz5ERErmwhkkp8Yqb3YZV+OCIe+tAtcIPTNUhTNH0
 vV+w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=K6P6ZTnv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="K6P6ZTnv"; 
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

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v2:
- Use my real name in the From and Signed-off-by (Jerome Forissier)

---
Shahriyar Jalayeri (2):
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
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

