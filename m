Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA21BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 840BC606F3;
	Mon, 27 Jul 2026 11:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77loO2HTmPa7; Mon, 27 Jul 2026 11:57:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A3C0606E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153475;
	bh=SQopVWoUiE4JlhoDnN+OBslhsLQ8ZlZVk1BIERj+J6g=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CukL+0MG5Q+1VZuDuEsLGs4ng5edZjzpxtK3j/BOOWjt31CdfNNfL2MgR+AEz+zjm
	 uLOLMuGj0Tl1kfLvdbGsjkvbediP9Kg5Vbk47SdTUXMyPuSkcuBBVBi9uEA5kxSmv1
	 3Yi5QpmecTuPwpaO15Bq3IuAQ8DzsZrcRW/xSko0nlfffWX1jijEmEnQyw3VVAd+zn
	 t4C3EXVViS49OqDcnlTcGW5qzWJ+gUHoAfuqinfwj4TNb12AN2Q9i6pVYWsmljY1ZD
	 5ROfy7ml+SmE0HqAnU2sMUz0NaNdLub9JY6gdMNL/yV07eiKHoU2BIQofnH7/nGyMc
	 GUID6mt56bDtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A3C0606E2;
	Mon, 27 Jul 2026 11:57:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B3F26C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75A3180D47
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXinF0OnJInz for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 165A280D4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 165A280D4F
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 165A280D4F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:48 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxp-000Eou-1s; Mon, 27 Jul 2026 13:57:45 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxp-000Fh8-0y; Mon, 27 Jul 2026 13:57:45 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH RESEND 0/4] TQMa6UL: read module data from EEPROM
Date: Mon, 27 Jul 2026 13:57:36 +0200
Message-Id: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBHZ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3ZLC3ESz0hzd1NSCovxcXcMk81SzJAMDA/PkJCWgpoKi1LTMCrC
 B0UpBrsGufi5KsbW1AHJQVY9oAAAA
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=SQopVWoUiE4JlhoDnN+OBslhsLQ8ZlZVk1BIERj+J6g=; b=Qk3W68R2a9vifF36owjMiXnAbd
 WZNNgFbmGWXn2Gvj8vJgz8O+t2va9afSkC3to6d6+4NsId6O3px2Ll+1rOHKJj7a4bJ9FilGZOB5M
 anKJKujvLXSGTUAtbScaQlbGv2G/4BSkp+paP7SBUbG4MXMPsTDENhRCcIslUP/5IWy0QDnNxmpOu
 3wgIQ6iCiDPSALgRZ/gO23K4fmd05fwr6CBCfurjDwyvWskBrjDg8tOwjqD8xSjBsXSr4Man+8EIX
 RjaCVn+GkBm5p+Zi8G5sP9gLwg2oK/0ytGelI97MN2csCLWQAKJJ3ARokqDN8XC/6bIzDmG1Ht6Mw
 aM57+l/A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Qk3W68R2
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

Reading TQMa6UL module data from the module EEPROM
using the tq-EEPROM-sysinfo driver.

Resend to the new U-Boot mailing list after the project moved to
u-boot@lists.u-boot-project.org. The series has also been rebased
to branch onto main. No functional changes.

Link: https://lore.kernel.org/all/20260701091122.1479350-1-Max.Merchel@ew.tq-group.com/

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
Max Merchel (4):
      sysinfo: tq_eeprom: select NVMEM
      arm: dts: tqma6ul: add eeprom nvmem-layout
      arm: dts: tqma6ul: integrate tq,eeprom sysinfo driver
      boards: tqma6ul: select TQ_COMMON_SYSINFO

 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 18 ++++++++++++++++++
 arch/arm/mach-imx/mx6/Kconfig                  |  1 +
 drivers/sysinfo/Kconfig                        |  1 +
 3 files changed, 20 insertions(+)
---
base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
change-id: 20260727-tqma6ul-eeprom-1b7e6b0007cb

Best regards,
-- 
Max Merchel <Max.Merchel@ew.tq-group.com>

