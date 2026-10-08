Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74BCA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65B39608A0;
	Thu,  8 Oct 2026 22:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b09TbjyXthWc; Thu,  8 Oct 2026 22:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCECD608BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499501;
	b=muEh2rm4nXnUKsQ5bS0qKAZ2MwlpTkZuo+uQLWFtpvJ3rhTsvrZ3gnL5OXXx2e0m/LP7
	 aTLAsBntMQQWQ+c7ZnAnaRSdataEf3v/n7M2rv5jkpnnW8D1lQxT5OswZ62AaUHPNw0Xb
	 bmsBFMMgIfQc8o/lJ7Fv5oU12q/REbD4OKzckfgGDoxuInDtY8n0AGblCjTSeGWZcyKeW
	 wJKBoDmZlWNHNGwiun5/aAaMYHRRIRePs5bfnwD9dNSLD7AUCUDiR3MJRppEk/8kbybFO
	 vuH3jhVhGbWbw+f6X1YKIAjCkidkB/iXCHpQ6yu2GUDC5QsmVf4dJck74GuDb+QX6hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d8k1TB9uMknTEie1YiahfD+PelilXMerw8yFSFc2U0Q=;
	b=aUF5fniCmZwFZ0Nrv0JzhNiZXU/QtS1n0TrjBMd/lbFs5yivWtvYhlOqIWVxi8mAQVC8
	 M0cPapt1uQt5zwWPZ6MmdVcTbJsQ0qHX6s1V+Hu4xKzuo1LwXfmDXSuAk0JPSHJSkDvch
	 My9FLEQNq3gzD3b3041RNA/dAU1uwn1jXTQq5Tu+bKplF1tVXGqYo76mESuM0wVROkWVD
	 F4BW5tBg9ZR81tzVVcFiH/m83Zc/YHFLnWfBkVlowoQsO8UjzJKw9Mb4RhGIf4l4DL1Qt
	 4LWbUM6w6K9u/lMKGJjLPdzh82Gxv0ZtrRJjMYacQi8hu/wrw8HnNsEWo7drq+a61Lg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Dnqb6bRa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499501;
	bh=d8k1TB9uMknTEie1YiahfD+PelilXMerw8yFSFc2U0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSDFTV9zWnLWJvgj5k2RkrfV5WgLhDC1hng8ezRQ9aHfPnrxyeKuPUEyHq0tsJGe5
	 klbQPorl3LoYPFIzOvzLdn5FutUgPV1CDoWKdGV8U9RC4vPg+MfZmOdLe06uoCHmpU
	 4cdCbF3DCdvu2lKsUoWzrlUzPWg/pKVzcrBmv+zMLyE912IE3IcO7QP7hr62/BF3gy
	 ijdos41tpo4fnJbdLASvSr4LH7fc7WyWdWdnAVM0TON2TTu/cilXN8hBzCYL9k1aGr
	 xkMVlN3B8UqvJyrGcvl7Mna1DwFiuxUVOene7wUj89LODqeVJVdbK7uCXN+UOe9TKK
	 TTjHeK1U42F1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCECD608BD;
	Thu,  8 Oct 2026 22:45:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E4DE1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60C34608BD
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCXaUcHM7M8z for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:45:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B605160891
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499500;
 b=Rn1Sie6M9A0xhyuq+/bS4sYCzuGlqFS5gy/YrNxo3ZuhH+NU8ygSkzGbPTk1zJANrBhc
 aKH5ItmhagTVpDb4zEY01j5HSllukPfURjJp5WabIB6yBaQmXuYMJKadN7iuROxPBjL38
 SpgSxZ1SH80Irq2IjCFIIbLUacZ2qQM9MRyFR3kfegUUTBe79uaqRCDSp9pBJEnIyeoyG
 MUjFbHuX5D6zXwfRJmUNkFDeoGl+bp1jmbWizlDvaZ6rXcz3VWg0afrTUFOUNI8e7BtVN
 ZmAjYq/eiJw0kdBRJgZoiQpCbmG51Guyf7mhHgoflkhzEqm/Q1H4NGpC/vCdjyDgUPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499500;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=d8k1TB9uMknTEie1YiahfD+PelilXMerw8yFSFc2U0Q=;
 b=XWcxHVbaHTtzx4DMIgNwG9a78hbyktMi9ZP3Misv5CJj95Znq+O6JT1zLJ5o5Zj8fdKg
 c9LyxwlNFZp7w+CgxsckasApFPmRt9QxZwY7Bq3JOk6yXGWhB4jZbhOnuqklr4MX0z1KS
 Fx5CG26UQdh1A/y81mVEsFKKeLjtW58qIevUBrRbYpzGHOz+4CwwCT/nuMG92ezedk1LS
 efw51N6u3SN6crSasloounPKznjPASPVVazovdm35uH7icXK5srgak6uTSAh3TISRG+qV
 SUTXRP4uLx4vBPtvY6+OQeRv5Jull5zNV15lEBJxj1OZ7JSA2CNoBf4O3HHmu9Ed2tg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Dnqb6bRa; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Dnqb6bRa
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B605160891
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id E54B6B00548;
 Fri,  9 Oct 2026 00:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499497;
 bh=fiUOkfBXKgzGOa5H/A1ukrUhbBDxDRnQyQkI4samp3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dnqb6bRae17XM5uuGmHkNFYsZtYA0GoJ9PmPm6EI67HImvtAUKrJFIPMpDoB9LPQ6
 q27R/qEaJGeZ3ebrSSE+iw0fAFCeIz0M8mNZ8iAY/W1iEIQuxYJy78AJSUc7J6ityw
 1kLWjlR7UR9IqCQXJs2g31j81yZ04UPMLQaY4XOT1AQCHThQZNS5AWmcmRrEO7FSuB
 B3nhqwAXNICemFp98WcdbSjSums52hiq87A0XB5sKcIM/etnzXkik2/gJVpH75QGg7
 PBXrjcr/II6CV+eNMbaQw3enOqJgVM0cjByZZjoXi/CaW5YqRCG052BNcRVYsQ4DK0
 09vZ9YbQTZxoA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 06/13] board: lx2160a: serdes: report unknown SD1 cases
Date: Fri,  9 Oct 2026 00:42:19 +0200
Message-ID: <20261008224228.512353-7-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
References: <20261008224228.512353-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Check and if unknown display:
  lx2160a serdes: unknown hwconfig serdes1:split, ignored

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

Changes in v5:
- Print the serdes1 value as hwconfig_arg() returns it, no sub-option

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 1cc9c7e5509..57504a2327c 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -515,7 +515,13 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 
 	mode = sd1_mode_find(arg, len);
-	if (!mode || mode->is_active(srds_base(FSL_SRDS_1)))
+	if (!mode) {
+		printf("lx2160a serdes: unknown hwconfig serdes1:%.*s, ignored\n",
+		       (int)len, arg);
+		return;
+	}
+
+	if (mode->is_active(srds_base(FSL_SRDS_1)))
 		return;
 
 	sd1_enter(mode);
-- 
2.43.0

