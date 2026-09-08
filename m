Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AEBC79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71DA14064C;
	Tue,  8 Sep 2026 15:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MId3cqyCN9nl; Tue,  8 Sep 2026 15:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 863464063E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879902;
	b=NRfkrj5IHF3Rchh1nF57jC/nn2tEgW8bT3hQJMk95QbDklWMmNwvCCwGal6nt7yO/lOQ
	 o/+UrGBuq4BhoUovDzOobgVFh5peuGUmc29Y6KzOGpKvcru8S6/ogVh/fWIwV8Zghbydo
	 8VTTgRPPpDFfBZIYe5LloH/OS/FHztkJRixly7ISTGyT5EdWhLSPJP1+OKzIWpxkEghSa
	 YMzsIK6iDr0v912iRQaw07jV5ssMU5aMjf2mwISNvdQ3cm0aAfB7k6Fpw0Wwx55L6v8Xe
	 a85j+m7Tcc54JX48V7R2y39YBSx7hGfyrXyrt83qWK8Rt2KyMv+l2lOcjNw7u6sJyaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2ER57ajvPDcbB+0bTGny30AjAqDOoN0Qd/rOFf9IHGk=;
	b=AVHsV8hh3W/7HLeA/pY9szBTxaN14NZwGnNUwy9C7SKcsX+7uExbcc70fSuU44J5YqEK
	 SjDrnsOh/h4KgAc6Agp9ridi20PRpkkeZ5DnYltnZ+2E/C0rdnBhawaKCtnQEC1kVFPlo
	 kvpMw5FWXXatFZ4NtSAc0KOSfVQWF12v8IukDT5+20JEi2oi2m7c4VI2Vxz766oDIGPPd
	 OnRHnBNNO5sYGAiV/Vmx4jHDGs5qH9w1VQqWEKPd2nlgg+Dva8D7NVf7WHkIE2YgCykK/
	 /NKdlsdQB9Hn1FFHuZtSwWpInfq5Eus8SwSXjLeKjK03dscYli5SemRnS4F3AFNUnwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879902;
	bh=2ER57ajvPDcbB+0bTGny30AjAqDOoN0Qd/rOFf9IHGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G9c0H6FOBYVIQh29sf0RUpnyxtdTWwR4RRUVBJa4mZVgpqPZYNVdL/UXh2rKBs+tA
	 v4DnYv1ZS8JpTVX67fEEYKWHnNgjRHLiucpu3ZRUsuK1BXL8O/YjGK3z8K+NWNPVWe
	 GVcobaF9eyZT4W/YQM6LfJNa/+ODo9wyLrtoLCEHvze2P99a2LwStWzvn7AT/A+0/9
	 4yUt2ZYvm88cTmgXDCrQOCPVwGfeQFAKDHnQmvUk0XLmrMKF4exEw4V7IC07MzC8Zo
	 0HkX4q+BrrRFE5kHy6x4jxGIoxZkn9cIf3qQmzYDcviztDK0YzCCA34O4P0zOZx6op
	 8O5EJN7DBA0Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 863464063E;
	Tue,  8 Sep 2026 15:05:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4BF1AEB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB03D606F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVhMDz6MgAW7 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3CD8160719
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879888;
 b=sllqoaJOjx0KTgohRGKp3bJOgNW6DkEOM6ChR1KWKNfuyGRnnLtC0oMCOC1DLiQZeMv2
 K7bMYLGWNkgXU8UQgHuGqrR0X7bCz/fnRFGXkPCj9i6kJI0CB8lShommIvVg8uTb1z82h
 v1v2aMRFN8e+PU4mTSGGoyQnCb/+AnVZ+Vaz6RKXtLY00JC0lrHr7CG/C/SId+6gtlGXo
 GgIsrONlM+z7Z9vaRVzITP7SOtMXF67awHfGvRgTiEnWE/p3xPS2VFXNB3pruULy4h+rt
 /NE+A5GoxS0lvCVev8psPnHBCKOD2uO9hozZJtS0Zyca5AmWUebNrqZlaDfj4WJGHlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879888;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=2ER57ajvPDcbB+0bTGny30AjAqDOoN0Qd/rOFf9IHGk=;
 b=gtUDiF5j5mRpPXqSLXcpI+/twiK8QFaUHGkOHz2hzCfaZ/xIU1C5rVIGgObIgn0Yq7KJ
 f6XmvP4e8j360t0AAQLSD21UUzSKCcIuDSQsUInL8kywNVWLZeFnisXtd8jaFvGBQVZ4q
 DmMZLYfEU2M0nHIHVCT+zo7HD/KL+sZayLICz8ywFO8rRgL74I3xHaVOc1GaIhcUYkw16
 J4jzgCXbBVa4ALqVb2NmIVYYqyZXHnFVp38yM3v+4ruh824/46Wud2le6oi4Vy7rB6kyU
 X5lkz07Jps7YJOFlRg9CFBiFMmYCsTmtURQd1JNu4mSNvTj+e9Rs4WoeMg1aRaz7pmg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=TOWQmbb6; 
 arc=none smtp.remote-ip=185.136.65.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 15:04:46 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=TOWQmbb6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.227;
 helo=mta-65-227.siemens.flowmailer.net;
 envelope-from=fm-294854-202609081503400e399fd873000207d1-fcwkfv@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CD8160719
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:46 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202609081503400e399fd873000207d1
 for <u-boot@lists.u-boot-project.org>;
 Tue, 08 Sep 2026 17:03:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2ER57ajvPDcbB+0bTGny30AjAqDOoN0Qd/rOFf9IHGk=;
 b=TOWQmbb6ZBjHIMEPev6o4sOAdp+UH5e8yKRD1gNTw9ARoL+BtVd0jpy21q69nffboTPpVi
 BgWtvD2qxuw742sUo3kYLAb+Q/9x4NLJlSrhPg79IZQXgFxr/i+hkUmixCAO1+kI6NyE/eaD
 dZNJKQenlJnunzapfixK3kBR6ph33AcLspgT3eG3k0MtIBwwfC/ZWdp61tilkKW/k3VL38oi
 +LektJa1SIwIHmDuLPFiKOea+i3US2x8Z/ahi+cojnhGK4F+EZaa6yfNHdWNBhrsb1pezwn+
 ayHSShug+RAby8UyL10PolMQDEs6NVHMwAEHAovaFSjmtQl+ynNFRDeg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 5/5] mmc: Make "MMC Device not found" a debug output
Date: Tue,  8 Sep 2026 17:03:38 +0200
Message-ID: <3c69f2bdf4a455ab8f0fe686e19e2c1a24c10721.1788879818.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1788879818.git.jan.kiszka@siemens.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Callers of find_mmc_device are generally processing and informing about
errors already, e.g.

=> mmc dev 2
MMC Device 2 not found
no mmc device at slot 2

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc-uclass.c | 2 +-
 drivers/mmc/mmc_legacy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 698530088fe..cd930807802 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
 
 	if (ret) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		printf("MMC Device %d not found\n", dev_num);
+		debug("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
 	}
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 8f8ba34be71..2a4a8a83fb3 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
 	}
 
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-	printf("MMC Device %d not found\n", dev_num);
+	debug("MMC Device %d not found\n", dev_num);
 #endif
 
 	return NULL;
-- 
2.47.3

