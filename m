Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D285C88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC8E0812E6;
	Fri, 11 Sep 2026 10:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwlxEmj_6qZD; Fri, 11 Sep 2026 10:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F07CA812BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123742;
	b=ZrYnVApmSt95Zuch+OBYYjL6uzBEYQPMFzPrflhlM/7sm1hdwXzSjsafxs8NR7QVXMWk
	 Fqnoo64NxGrSAKSeo5wNqqxIA4wFpNBD/b57u08usXcwCSUbsZjGSWrO5RBikOYRlMQPo
	 ggUKKhGb6bHNghZeXYDSVI8gRzspM33mALLJFgiAwgBh0ytw7vp4jFVTiRcbS8tKj0WAM
	 9s2RbFZIRnpP+w6yz02eKE/VWoZQNFpk/1hy6pEbIyHBD4txWbxtX2Wkn7tUbu8Arrwm0
	 L4PbtAUUlcc5h6DuqRZovpmKLlGCV2x7zZOLFbGzF188iE/psT+3QBJ/1XHczdtpZ9A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wQ9X/ZzOthIs8PJ5U68TzwECdd66/RZ7Ic/P1nuDtMQ=;
	b=cakxWFdcLVMTn4GM9GJNeIzvmaE+XO0cZ0vuDBHCl1080DkXwrXjf/BKn1eq+mAAxXap
	 mXIsU5pHc0ENdgx0OQ6CswAHuEMtgfYM3luvQ6r82Wo2n/WqgyvXnL2KygFND+vbXNQUR
	 +Th/uZ2FNKCTwzbwRcgE8LEr+sEFADggysmxFa1cM/aUvKld4U6AQfKLnot98B3UXMmn9
	 mZzElOpHL4BYtyPKctibvMde6m+3G/LiBnOMYuRGrCGtk+ini/zCuyBYGeNAGYxY+hkE/
	 r+7ndiqUNcAFpQo6A8VPkAkLUCLMAdTH38LCSsKTgOdwygmDrlOkZdsmXZB0QGPRywg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123742;
	bh=wQ9X/ZzOthIs8PJ5U68TzwECdd66/RZ7Ic/P1nuDtMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FFgfMZ2uK6gTMbcrihrppesEraKhv+xCb4ry16ghUSxAue/TI95PrLcNHjUA0cIL3
	 4dvN5EHBpcVv2WdDs9Ryhj0xf9P3g65Gz1vdDsMeiPrhRAKCTb1Om0dCfeBvijDb+V
	 UJ2agJSzG0ezGzUv3NqqD2flzt92VilPN2G/oRrTHDEfdEhK6sDJ71k8ylH5suRaT0
	 FtNCZyVp4LtNzaOcuCxUondyxlE4UNXjxHqN/l/DsWGgNeSh13RQE+4ErQ3/lkshCc
	 TMNllrgBrgcXss9bV3V7grx8RqRMkZurXP4hVgwEJk4O9Xm23I/rjLU1LBnaMVx5KV
	 qzntFIkrFWZoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F07CA812BF;
	Fri, 11 Sep 2026 10:49:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BDBC14C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49ACA60C13
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvTSMrGYTsQq for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 67B9C60BF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123737;
 b=Lf4fH53f+2yu56N6yCUPKOIp16bcY0q/sv7f7kSC8i8zBHIBNrt+Q25nfw3TZnt1Wub6
 0lnVn1FLPKbmcgaIKdZ3v0rn7fZL5kxfGoH7usKfXkGOJY4DAFThw5Ve0A6PyiXEEXEVy
 WyDHVHz0IurUjUyDL8ktX5zo034T4aBsXJVGU/dw46qB2edWVLspvUuT2QVYN3P+jTrHa
 of69Tex9PzmcfFprJ7hh+Oiz8+IXuEEan1C/yBrF1NxMy+N0z1W/OMotUdMKpEssFM0cy
 bsK/dSOn12x0XYNRxsLDhtRNHF39BmEqAZEA6Az/xDmguXEkhXFb+SlwolcOjZmy6pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123737;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=wQ9X/ZzOthIs8PJ5U68TzwECdd66/RZ7Ic/P1nuDtMQ=;
 b=C4Eaitlp/D62ZXbJYhZsC+EuF+xJKO9ccwKlhgH26k/Ev2asoeVmRZww+r0zLWMKmJOb
 SH4c5L2BfqimjCBEymOXZZqoyUSAo7X0HbO+cpZyVcHj1XslWWDpEoiBphQsDCB92O50D
 M047qH0+MXOO0DEqk6T9m61e49o9dRJ0b+TymvG9SVhu7/I/Vq/nGdV0IAlZgys+A2GEw
 K/WeCecOrbdy3b4j+epZDQhKUjYCFIz6sT43Ur/XphvvVGA6RdegZlT4Gme6rvxYl1y6k
 LDms1h0RNawz4+TpGNOM1BvbZC42PUQSmB0PcAhZfD12NvyCkW0SR37hgyapT7EFUMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=JvKJNOrk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=JvKJNOrk
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67B9C60BF1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123732; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hYzDNGD7KrGec5LuyzgNtkEb3H3mHjP9pgvzt+e+Y7VMj4D4TFNgm/f34hVzEWkBAz4FKWyO2YD8jIsN/7ZgaEk09hDKvSOWjkz4+QvxWBIwt7+y1F6/J2Y0rAf7HbUEQshPwJK1e6zqMTMQoGEA9rJgz9rCwlTGjgGQa2byIvM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123732;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wQ9X/ZzOthIs8PJ5U68TzwECdd66/RZ7Ic/P1nuDtMQ=; 
 b=LBt5KYMoeUZpXcGsMbmmg9hvt53dCVBS6vHlEr9v4lohnEPSJbTwWHTq2xSes50KYoZfHp17Z654TgZEjudBlyLkADSbrGselEX80xh8JfkIk6X5bTCtRJuMk6vtG/jeNPIcYq00U4zlim3dapbQmBbks6RwMaf6X9WACdJtKgc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123732; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wQ9X/ZzOthIs8PJ5U68TzwECdd66/RZ7Ic/P1nuDtMQ=;
 b=JvKJNOrkWp6P+bH1N40Yabgpe/47VW1fhe85VpYAKJZui/qwK4hOMf9Tb1FZyTj3
 WW3qNWwubxNOdLmXH/oWgc+6c1rmBCRlwdB3hia1nUERKju5Jwzl4Tsh4CK07yXAl4q
 n4ok3ZqZTWm86VRiJTFnOMcjIb5XGc5bxksvlwS8=
Received: by mx.zohomail.com with SMTPS id 1789123731631836.7845772377601;
 Fri, 11 Sep 2026 03:48:51 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 18/19] MAINTAINERS: Add entry for LoongArch
Date: Fri, 11 Sep 2026 10:46:03 +0000
Message-ID: <20260911104604.2910944-19-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Add an entry for LoongArch-specific code and documentation. Jiaxun and I
will maintain the LoongArch port.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch, no changes since v3

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9ccca5ca44..ebf1ae4e1493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1177,6 +1177,17 @@ F:	lib/getopt.c
 F:	test/log/
 F:	test/py/tests/test_log.py
 
+LOONGARCH
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Yao Zi <me@ziyao.cc>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-loongarch.git
+F:	arch/loongarch
+F:	doc/arch/loongarch.rst
+F:	drivers/cpu/loongarch_cpu.c
+F:	drivers/timer/loongarch_timer.c
+N:	loongarch
+
 M680X0 ARCHITECTURE
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
-- 
2.55.0

