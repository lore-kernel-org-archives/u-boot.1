Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F164EC9832A
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 03:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2541F8110B;
	Sun, 27 Sep 2026 03:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kR3G78uP2LnD; Sun, 27 Sep 2026 03:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B32D281101
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790478856;
	b=sTT+dPhBV3IJKCqGIi3A2hhZoAvmoKH6xudLtqr2wvCWpCYRDoWS5+LLnnu+14NdfTxD
	 J3FdvgRLXhScaSdJ7KgLwDWelkD7kqx9aEO3Ox23++yQ+2sIRMOB/Z2TLrpKNTyZm5EiA
	 urgbvwwXt9Tif+RmeN8iJZQPHu82UEhgv4IbDVQuWnsd/c7zIoQuIPBx5ilTFKL7GUA2q
	 5vv4GcIB1VtDMG6T0BzTqa/ZP48qo8zF5OnVWDMIabI6NtHXAOPpZ0t69fM3TrHAVJuoE
	 t/xQb3iBcH5O6kbaifGOTJJXR1GBPU/8xogPGWw28Nc/t8qt+Cp0uDoQZqFfXfTSdHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790478856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=86zaWEU3be4DlPP0xsPpIB4cRbInjuCElzCGbrFaXl0=;
	b=FMLyIEV7tCoAyO9vwi81wcFK0QdBecoYL5oPCGYP6JN5mecahIszx5uUUic3PvfM79db
	 v1jwDQmSOiDxGr9ejoDZxckY/+cwVVXcSE4sfPL48Dnpx3jGpBCwt3+K5o3LW6PxjF46H
	 KGGLq9tQjlQs57OKLIlzyoPfry5bytwQpqpejx0o/jO4oYmSHcUJmBan2DlcnKYWlRnJL
	 guxNPhFh8qZh2BWdMHQX/X4OBjYA1wqG6HEUPJqcOG4nIqrvtPZMRF5oFCFn832dg89DU
	 1XMWFwpu85un79m8Ka8WkcP75YIH8IFFrkGNAlzvpEpx0PlbkHIKQZaxKgss75HmKNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=P0zKPpo8;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="J/k1E37p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790478856;
	bh=86zaWEU3be4DlPP0xsPpIB4cRbInjuCElzCGbrFaXl0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XsfhXm+JTJCZCuTEs9woCpJo7G7p4QOLAgbaiQPUfzn4KBwvcoYhFdY5WLwdfhrWd
	 2SujOVNkLYvgvzD9ZNjsdGAE4U5yD5Hptps/43qBd1L7n+1d2clIVRL3CarGm/rLMC
	 i4XJGdox/Cz77u1pT9hMk+/ZDHB0fJE47yTjElDMVhNIqH/503e7+Z0DhnTdoDSQ73
	 8Hj4sL4uwIe9x2rF3icZTYvuTObI+Ssx4juxasar09NlViWIeLjSji3X/SPAl7QCX1
	 Nb7A+v0fVvjqLI0YiPp90rvSrjimKE5L0jN8jtFmoMND49kyV6KTxrrmmocNuOmarV
	 ubdzLeYz4gvew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B32D281101;
	Sun, 27 Sep 2026 03:14:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7056194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 03:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7A9681101
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 03:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7WVpgDCSO7o for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 03:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4841C810BB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790478853;
 b=H3vCUvrF5wG9/fstuHQe8DPPK7t/F3tAvN5lWQG2rZS0cBaH1YnFZ52pmljVS3kxuuBD
 kjdWvXevTkV2nslpJhFJFU6Qfe4BPragT9U9LTBv3bVwftxTie1P1yhqe1c7eZmkVaz7T
 gpeg8yAh8hDrhSimABidrQGrYMwPfFcVk0uErPoGXDWNsetzcWa+IqIodiR0fazMOOPaJ
 R0ewBC4eT00FVlRnaqtRJrTFMislUdXx2Q+GMS5jXhIru1tad4WOUt+wQjAX4q8sQGzKO
 VhjXJmAVfyKasEKZrEt0KBnAiCAXUybBfLxFlisXJTLLugxXtzHEoDJG5tpbuF9kNXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790478853;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=86zaWEU3be4DlPP0xsPpIB4cRbInjuCElzCGbrFaXl0=;
 b=i4Joc5WX4jbDvFtVjPN6PGvghxzJSBxE36Ft2BqAJ/DHPnJ7vcqfIHyhr5FiXAobR8Za
 4X/5pe8/HqhGgH2tDhWB0E9t1a8usrmc+Q5NKDLp8abOtmW7RMUeMrrXf5yMDybRe4apn
 Ug7aBHCo3EHvxrrLHoFqbt4H7aBdmEaKeCaCrJ2P7ffevo1SYd5XQUw7uXAFS2KFYOAge
 jscwWxkK+SQQyCHMYms/RB1ojFJaPiyaNTOf5X1EGZdTOpLqkGMa8MJXiIDrmezlfuTWD
 Xfyg2vZ+1cvaHGXOq1LphrO9PglpId81dwyt4mk6dEIb5k4XXaySs9bNQDhRHOhUnVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=P0zKPpo8; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="J/k1E37p"; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+usb@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=P0zKPpo8; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=J/k1E37p
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4841C810BB
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 03:14:12 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hsqKZ4FmnzKp4S;
 Sun, 27 Sep 2026 05:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790478850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=86zaWEU3be4DlPP0xsPpIB4cRbInjuCElzCGbrFaXl0=;
 b=P0zKPpo8ECAltgwFKLUaJGIB7JJSnlPloG8ELh171CCmN80ChAStwgSEzmDIYUCeD6ZAU1
 UT3L5XobkkOYt+5O/EdtN4HOL7VeDkjgYsI2IldOOijdvc/mlVla+I1Bd9Ir+dyEUxNgue
 EkqnuxsPIHE5214H4G2nJIkdkWti6Z5F9wkavjMBHulJsoSK9f7UFcfW5Ii8Xkw5tWZVw9
 4iIJmWxEkJq5aKb0xamUOUrEdS4rAPWVeMU15snJmPEqMUY/SC7xuX26I7rCOH+VPcfuK8
 /C7c7uWcLVeGkl4iVoA0IEEaB97/XObX4mBP9RbDhRNukgtYiYX6KGtvBokdUA==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790478848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=86zaWEU3be4DlPP0xsPpIB4cRbInjuCElzCGbrFaXl0=;
 b=J/k1E37pYqQ5Qqb95iSQB26x/LKojvKxKGBssEksqBsLZmjLXZpi0EyY5OADYDLaQmdyeI
 oeUS/6l7O4wiI1bcmCpa0qQ/JZNcIfRAnhYVEuwtDnxMeG3JYPfuGFQkFGPyrJlSh5mLDx
 uPULbu5gzZMIwRmZQdplmY9q5k8uRaTxpoG8NNcvi/MWNGyPproBbWPlEoa51QZ+HVARci
 euIynnVpXKzL3NiyJSpT4Buf5zLhX1Pn/8tQEsRj9thgrVlGEumoOiRZ1GBfejgjbXNq5Z
 HwfJzPfV9qrLsHXpMa85xK+rXQadLM97Ebmh4sdJYDbuYMYVcrGiKlsHQMNqFg==
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PULL] u-boot-usb/main
Date: Sun, 27 Sep 2026 05:13:23 +0200
Message-ID: <20260927031401.162410-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: og7nzpqs9wpsxtbtxa7mec3g695u3nbq
X-MBO-RS-ID: 1a6efcc4aeadee7c987
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

clk_bulk look up fix for DWC3 controller for iMX95

The following changes since commit a06e89ab05eaa2b8344d521319399333cd760ae5:

  Prepare v2026.10-rc5 (2026-09-21 16:12:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to 84de44e5e71e849a0c3ae983510f292cb8cafa69:

  usb: dwc3-generic: fix ref clock lookup indexing wrong clk_bulk array (2026-09-27 01:42:05 +0200)

----------------------------------------------------------------
Stefan Eichenberger (1):
      usb: dwc3-generic: fix ref clock lookup indexing wrong clk_bulk array

 drivers/usb/dwc3/dwc3-generic.c | 69 +++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 20 deletions(-)
