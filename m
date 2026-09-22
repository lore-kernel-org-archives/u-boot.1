Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54081C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 046B16066A;
	Tue, 22 Sep 2026 06:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86IsJMto_p_S; Tue, 22 Sep 2026 06:00:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 20B1360662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790056832;
	b=dJLglVQn1PJEimbPzHSLk7XFjR6qJoQoT2HtmQo8y/Bv4mXXPzYYj0VnH6fEUEJUCQ3q
	 fsSi/k3H1Gy3y3MKeZod/D48TzAOmsX7trkGecitFKJwnwhujuuZni/hFkH2NY8BqpGRf
	 Px5QC8JXJp1U0qm77+Kkm+lYod+6sdmSgnn9P6wvJgj6GGJoJ4vX2Uyh8rtd22s/FeCzv
	 oLV+Z9GrabJnh/Og7cRkbu9J0SjDh8J+qmoLhMEeUDfH6A0gIBAOs6nuEGOZuLtTuLxUs
	 TygSCrTlCya5SIt8JfbKNUli1J8nsGaU2/kTUYpQUZ5mB0QLMSlpkNoDFyyOfEC0rNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790056832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HqP/MWdaX4X5NinmgYo3YsKci43Wpcl1cmIMp2oZadw=;
	b=L3ITw06NAnpZxlLTjRLnkw84IB2j5tjO8KuhWZiupHiuqHThIMUIw4q+aquCOkDRJ3t2
	 VtRcYYN5+mGGlj/LELnvAj1jzLnUpeTDBmuR93yEXofNEPecQoFtQKNgKpjMWQLkCDrqL
	 qluT2GS/7iAHTnMa3v+HF1H2u/50Vdr9ypBV+5VzVVq0m9+PIsGh3k4od2rc6nrgq2CW0
	 fbO/+ePZ8i+OPuq98YGTpVS9pIVXSJzlr+b3QMlJB49+hQ3+UOX9OUrqoXg1n70UEFJO4
	 chyDvIQCczcdFVJbe+rENntoMAL5skdarV8szT+/hB+lOj3uNL0BARJT0GDa1GDUy+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790056832;
	bh=HqP/MWdaX4X5NinmgYo3YsKci43Wpcl1cmIMp2oZadw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pQAyPe2MJSv/nsAtD5ATbaAb0ODyvcutTvRbAKjDvbDVyZYQ3gi04PrpUQfhEqtzL
	 7fadBodCOFQKcEV4E65f/MYr7MixuY5azkOqbZtzNQh0TPEEGEe7y+yvynRPJzd61M
	 IZa8l+aesnPZ9V2Ui14ddHNqX0eRWcX211iq9vYwB/+YncmiD9UwpVF9BXPNSgiJ8U
	 /pi9ZXTF4ug5rkoJt6+S6pkMta+BxRCinqNQhu6EyvT2ULYGK/3SjPMGsXeaz8i0qP
	 R8jFL0u2wBCl17EO15frhCuCL6hmWVtlIxKbB4C3iXNZmX+ETpyLGxWPMlhscIHQJX
	 dGUvNkcrwk+pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20B1360662;
	Tue, 22 Sep 2026 06:00:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E94D913B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB4C380D49
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8BLL-uMkuk3 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E218B80B86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790056829;
 b=XsNqgrJcy6alkArm8kro2kM6q3JYVKlglrpThwi/INZDpFkL72TDw7WBJGIu5u0WBnxc
 qGFdV43NWae6rejNkPjtWi1/GhfmJNg35nYlrYkdW1lRr32s9fl5kuGLoWwwGZQW82JFN
 cOEa0RMHOVMSxfkh/6tpwztln8HUJMyvxXtg51wWu407/0SSfG5UTambtk3RFGQAZT+SL
 WOsrR/E1H3xhhtRHEryG30XfhMEMs5aDUwuGlFpWEOvh/pEen8AdkID+ROTmYNrz7Y1JR
 oXpo+FIh4odhYZvgrjY4kIL6VD/lHISIYWSuxOFP4TB823OuegmmAQeeDJdmbo/wiSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790056829;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=HqP/MWdaX4X5NinmgYo3YsKci43Wpcl1cmIMp2oZadw=;
 b=BRmTDVQGbQRELVneM0hVwkjlUbRIfraunDxUWT0rDgzPA9Ij2wQcNvrqJEvKElm9+940
 zwyRSTqywHaDfeMrAtohB3/v3Ouk0fuayeP38nbWKCo8uKRU24v3EUMKWiXIlyGxVhwX8
 BMn9IRRCs7Pk6YFNcl1x490C7oBytrU51dZChRjQHVPpft6ksbjyRBSKqkIrxM152UEWz
 0u1COtrsMyBPIMrvwm8oGBQIqDovMp2TBlG47f2HWwtbJ71T7np2tctWxYuoQGqJtt1RP
 mUOLDUrQYjSK207TzHiXxrZxEechjSgFTtuSM3uhpBhDMywfHEF/dIheEs/GPVsI06w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HtpQ7Nof; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=HtpQ7Nof
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E218B80B86
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:00:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BA0461053C2; Tue, 22 Sep 2026 08:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790056822; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=HqP/MWdaX4X5NinmgYo3YsKci43Wpcl1cmIMp2oZadw=;
 b=HtpQ7Nof6i+Mv/Gf4D5pMdOYlhpUnqHu2U3eS3ziNpoXkkBBhqrCRZGWMDVTfvCU4Yv6qU
 IciBscg4dBbXIzRxqwo+V6muippHgxjlZxGJN77BbeF11piIVEO578UiqB+uFtX7qcsnpr
 1bzHKZzuyQF5z1ECoCMpfvEvxLJoRZHPAxqi3lY7r6J5SmHGMd+e2YqT02GaGNAlKAruMz
 WQmSBO2gpEbinCiRcNi9OJngpnxOH/oaWZUoijZqZIzMDM/AgYW8T2VbaT85gtBwdNfyWZ
 yJPctMH9UziQNvTHfvRQWLDAvdcHEi+Y9g5DTaxZb8/zYf7Py9iaN9iu1S/pSQ==
From: Heiko Schocher <hs@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: caam: maintainer address bounce
Date: Tue, 22 Sep 2026 08:00:09 +0200
Message-ID: <20260922060013.532694-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

sending v1 of "imx: deal with the RNG self test of the i.MX6 boot ROM" on
2026-09-22 produced a bounce for the CAAM maintainer:

    <gaurav.jain@nxp.com>: host nxp-com.mail.protection.outlook.com[52.101.185.21]
        said: 550 5.4.1 Recipient address rejected: Access denied. For more
        information see https://aka.ms/EXOSmtpErrors

MAINTAINERS lists that address as the only maintainer of CAAM and
get_maintainer.pl picked it up.

May someone from NXP could say who should be listed instead?

Thanks,
Heiko
