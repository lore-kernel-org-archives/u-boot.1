Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A99CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69AC2605E7;
	Tue, 29 Sep 2026 00:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eGw-4sqYnMsL; Tue, 29 Sep 2026 00:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BCCBB60707
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640353;
	b=NSThiDU1xBkS+hprcUJZqwvMQjCv5s/V9OBHNgLtpFclzUOthNvM4Nomg71ycX7kg/H2
	 7FkhhV9AaK6qBxZY2UkPRtCNuAM3FtaMLrT1Z5kI/32FUQtk8xwzTkp9ffybXTdNuldLO
	 rPamoMSIEXJNfWKC49aHDN673hI8ocp7a67fcrEpgX8LLTC2kTEz2hgH8L3P8pLDijHWE
	 CZO8/lSDv/6//F4Egkr662H/zCLhSWbUhliVkpTxFy6l7H4lgP5jV0WsqHZt0wPhLqgAM
	 btxKYdotb5mFVKJWbe1wEuDE04MRtMQxC7mqzpXtfDvHxIPagqViIsTkrZx0agVlbuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lkb9Rfd7r0CWkZ8378i3vTcUXUFQ2q6rPRlZU4okdRA=;
	b=IuEjdKMCQv0Hw1SsRXTzYr70Sm6gggTuC+dFw93tvJgopqw0HZ4I9opC4JI3RPVx8pP9
	 Q/XzJCdTlcuGHqPi0Xoem5VlI1LQfHISfloLnAfnQMr2HH3Bpbm7+78X0xCcp0PPlovRD
	 cyU+zClpAnH3IoysEKx1auRpUrthM49YEkhGVscf0kyOJsiyXtrLklck7tURWE757VGmL
	 kOLeNOCJJk5xzlPQxv8a8jPT0wq7aN87M8p16stP33gVvjTLAdpx1VV5aaQvTiW9c0PEz
	 7YfLYSexwWG1jdKfflHPHHlhybT5RAu3WCAcUUT02BkMdSMjGsjsQ/2oL07a21+Jjdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640353;
	bh=lkb9Rfd7r0CWkZ8378i3vTcUXUFQ2q6rPRlZU4okdRA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWQW3S0tHk+wT1brRplu4OowyZkkz8JzJT67zMWH6adyx2LzaeR5vVa0TDhFbj24K
	 YmSZmRXBbEnuiPNagBFFaFKl/nhaiPAH/rw4TOAMRbVnUbKcSx0tz0Lg4dynIPier8
	 CMtP3q7EPQCqeVbEyphwlam/SCAYTNcwM//SGDDX649SKFNKfUqp0ddMn7DpHQvvs3
	 7VjZvlPi+01NjvtT7MhR7m+WaAFQ4HCaxCelBEoP7wvH/1ZHc9SX/Q5RvJOrZu+AQf
	 5oIR1AGHJFFv3Gy+N8rRR83QLeIp/evTQSVoEi7prDO2Xpd0JbP2RzD9KgllMDWsEI
	 s82v8QHnVEAAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCCBB60707;
	Tue, 29 Sep 2026 00:05:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A212417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B90080C06
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6waM748kr-c for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D63F80BD2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640351;
 b=XSUPYgqrr/VePA8kvEo7bUeYJPUKBrQ2Kf685hJAjkSwhWeGhZK0udoSlRLOVMMe4gX3
 aSVtVXVGRuwnKX/TCuLbBskJn3aaXlul59Mmy6RH3dP8nGR20oZmNpIRR3tVor8pzHc53
 9rThAiLkBIC+0TIJCLdO/lG9rHedviCnlizlWZ0rDM5SBEnrJWYaP07s8w1R5+yQ3wH8K
 TKld8xnSFmF8g3wkTE9apvkKuDCR6U7zvBtWatLdhVvGy4c/Tbmi/5hlyzZqShtxeBoTg
 NY7AjotH0L/sLDmC09DQPIsLoYkrctQFaN9/83Ri6M3mHirC+Cu9LWneJRNM8FAYqtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640351;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=lkb9Rfd7r0CWkZ8378i3vTcUXUFQ2q6rPRlZU4okdRA=;
 b=EirR1YgqMZyo3adkvgTxs9jSY90ccSF1A3UjwdGhyUEkjoScc1SyV8kVONkT2+BGKSQ5
 IxK3dQLGwtFrTpmCPIiOOq6uibd8+QrXoojG7DQqlBiVh4WPBi8D/TzCpWcnsDM0vE2yH
 4qxKmhssS4xTuWeIDpnl25ux0NNn1FdFUnTdRa8nAt0YOFK+y1GmagipG0jlWwQFncSHZ
 lJN8HKfFpWgFE91aSxoRH1ruazNouMaKD9KKhO8VeS4f0qao05t7SwZn/AWGon2Un8gVd
 Rgw1zRsa+335TOmYj76wgNi40no1Aa9QVNWZ8W0ihmS+fsdd/sbWqt7g7wkg5xQ6T/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D63F80BD2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:51 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLLw-000000001P9-15c9;
 Tue, 29 Sep 2026 00:05:48 +0000
Date: Tue, 29 Sep 2026 01:05:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 08/11] boot: fit: keep the load message for RAM-backed images
Message-ID: <65e01a6d030b93716174a0536d7a0c6b8edf1aca.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
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

The "Loading ... from ... to ..." line is suppressed whenever
CONFIG_IMAGEMAP is built in and the source happens to equal the load
address. The test is a build-time one, so a board that enables imagemap
but boots a FIT from RAM loses the line as well.

Suppress it only when an imagemap is actually in use, which is the one
case where the data was read straight to its load address and there is
no copy to report.

Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/image-fit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 5d86342852c..aacd3fa3622 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2468,7 +2468,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 			return -EXDEV;
 		}
 
-		if (!CONFIG_IS_ENABLED(IMAGEMAP) || data != load)
+		/* A storage-backed image was read straight to its load address */
+		if (!images->imagemap || data != load)
 			printf("   Loading %s from 0x%08lx to 0x%08lx\n",
 			       prop_name, data, load);
 	} else {
-- 
2.55.0
