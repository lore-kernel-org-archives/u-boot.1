Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FA1C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CDD5608D4;
	Tue, 11 Aug 2026 23:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPc2yj8bm11l; Tue, 11 Aug 2026 23:05:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75BB5608CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489506;
	bh=BiJXHuCoqufgoVqfQTe3anZBO50pUrGoC6kq3N3SJqA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HQqTqiuNzCyg6WV4Xif8Oe7xOv8QSWW3RBW6w4WrQEF4MrY9JNJVyUAgcrQEenM1d
	 NgrMOEVUoUXG9W3C9cpRQvJjCDJTfRtwdPreLF7zsPKqZvLBFQW+wB6Ys7/BNQTRlp
	 gCTsqQLx1kowXLYegxGE0SS6HS/83LdzN2Te3kAr37Cf1LN+Nix7g5KbAQjj2on0le
	 ePfqxN2SYTSQbcBI2nDe/ZSIlWVypXwcvjTl8XA4JuDPqmFH38+Oko5dMWhjOl+K5p
	 zqvIcZ2yrSseP5Yag35yOf3bI+FjLVJ37pkIwSd+/QEAIpjy2cd7VlsV/9+9Mkmw6j
	 FPXMBVxFQM/iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75BB5608CD;
	Tue, 11 Aug 2026 23:05:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9514A1F41
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C02A240360
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:56:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhejAmer4t9Z for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 18:56:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A07EE4035D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A07EE4035D
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A07EE4035D
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:56:45 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c2020421077so30705666b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474603; x=1787079403;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BiJXHuCoqufgoVqfQTe3anZBO50pUrGoC6kq3N3SJqA=;
 b=BFLy3TN7Ln5MuLW+Rz+G9IKnXW7uMIDVvH08sg3nqlFOz978xa4oh6+n2cWTdIe6UV
 +RtTFG0L9fmXtx83/7UR7UXrkfcy/GxPi2/KCm39v5XgRwv52pmxhar3WZYJfW626duL
 fX7MzUipbDHfvNebeTqLADCVcR+uPctdMG5z4RAPMhubs7EaTZclteQOzDsYpQJalb9A
 EGefCNjyl63MPEMByESQgtvTXkNWpYv1E1Jr0zLwUG19oUzLO27aMiPstcXrqR1uUHor
 qWWjFaf9j5Jb/octhKmYwi/vcVR4NKP3J8Nbm5avlYsn7/7Vj8jfVZcfuDaygafxjz62
 HuSg==
X-Gm-Message-State: AOJu0YyaM9spy8sUdgBjnGhmLSEYkTiIHGLfRi7wCcTN/DidQscsU/PE
 iKjf4y1j05rLulppoX+6+HC2oeFpA59AEBf4A8IVJgTW7kyyH4TuTiVxDQ/0bskcP1Y8pU3mWr3
 g8zI2xZc=
X-Gm-Gg: AR+sD13uIBgy77TRBGoK3JnsbuownV36ovNUHsVk87nTaHU2365AA9tP2QKTFo/9+sW
 fTmE7hplxzFa/E4DJzjBgGpObMvixHkSwxUe5KiOsxKQi+yx0trLa0r+4BeK+VGpBmb1pholhBS
 sRxg+IeEe9CECY8asXY0ZVT6/IGfOxdiNdwcM7hDs6wZjgE5fCXlJpgpEWVQHTedsUY2SyvOepP
 ap1H2i0spOnriOT2JB1S26vGO2CVAV0BRCbz1uGt1Yg6+bjyl1wtDVqL+jQvOs0z1hRMvzSpnz+
 tKypeWcRYeQiyO0C7wKhUlakL8hojYA7aQknSYJf1aCpGy4dGmiwoFPT6ol8+4pWJsWGvoprEF5
 BhRy0VrIqXv5oYja+Fn3M4NfdIV7l7iHhinSu1Juuohfzsq+NrZ48iUSyUJApHxps/+dtWVO23D
 qj0mAmwa27a8kw1E0/kPk4gBYVgYCr7iLLKx7tTJQcFVSbOvhs9HwslP0oaxUAEhDCvmnRfsgQR
 hZwcGGALtNpA3Qr9Sxp5uf36eIEYSHpJuX+y2mM6mQAiGpaRgvwRw==
X-Received: by 2002:a17:907:d1a:b0:c20:724c:bf36 with SMTP id
 a640c23a62f3a-c20e60e0e91mr269975566b.2.1786474111599; 
 Tue, 11 Aug 2026 11:48:31 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ec88f5sm950529a12.19.2026.08.11.11.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:48:31 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH 0/3] net: lwip: fix use-after-free bugs in the wget and dns
 commands
Date: Tue, 11 Aug 2026 20:48:11 +0200
Message-Id: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtue2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3ZzyzALdjJKSgmTd0sQ0XWPDpDQLU2MD86TkVCWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgCDiMAHcgAAAA==
X-Change-ID: 20260811-lwip-httpc-uaf-31bf85307bce
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786474603; x=1787079403;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BiJXHuCoqufgoVqfQTe3anZBO50pUrGoC6kq3N3SJqA=;
 b=XvEoZ3ulqQEOkwUWTd5frn30PLLBQuRyf/TKcMutx0FJzqBjYGVb7NYptwKsaY9Erf
 cjizk0cUQ8y9TixN4xU1ZXDK+8Y1VgJIeBc2e+Njxi+7CpXeDWX9L+szgMmV4CD4Ykhi
 0zh0Db/EAepbjOXwLXa97Hs44XDfdLVYT1ssCe4SPfis2RQl+3Hs1teUue3XPAK21i8g
 EphJyg6PVxcPzQRtbZijH3Sze9izRkX6gRcZ3umZWorKZQAvwnkJtYYK0102HDNu7HYP
 R4pDPeLNYDvEfn4p6jUqjOaHW5jFpHOB5rxeue8BCsGcaMBcuR/8CJkbsECOAEwpXwPh
 QMaw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=XvEoZ3ul
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

Three use-after-free bugs in the lwIP wget and dns command glue.

Patch 1 fixes httpc_recv_cb(), which calls altcp_abort() on a store_block()
failure but returns ERR_BUF instead of ERR_ABRT, so tcp_input() keeps using
the freed pcb.

Patch 2 fixes wget, which keeps its transfer context on the stack and hands
its address to the httpc callbacks. Ctrl-C while the host name is still
resolving leaves the connection up, and a later callback runs against the
freed stack frame, writing attacker-controlled data through store_block().
The context moves to the heap with an ownership handoff to the lwIP callback.

Patch 3 fixes the same stack-lifetime bug in the dns command, for its
dns_gethostbyname() callback argument.

A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Shahriyar Jalayeri (3):
      net: lwip: wget: return ERR_ABRT after aborting the connection
      net: lwip: wget: free the transfer context after an aborted request
      net: lwip: dns: free the callback context after an aborted lookup

 net/lwip/dns.c  | 38 ++++++++++++++++++++++------
 net/lwip/wget.c | 77 ++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 91 insertions(+), 24 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260811-lwip-httpc-uaf-31bf85307bce

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

