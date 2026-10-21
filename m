Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84493606A324
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LJ9+4yfV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 620A5608B0;
	Wed, 21 Oct 2026 12:46:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sVO_W2TKvlTk; Wed, 21 Oct 2026 12:46:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4376C60896
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586760;
	b=qJ5xAqwsoaF4tafGgW4/7zeNNfk+a248Airn/dqx01FcZO9UhWGehoZ1rhanxhYYMz6c
	 bG9nxDRibINkR6MA8ibrLd/74VdPBqGILWNQkXI+fIP8e38qWrZ/SZZcp523Ue59p6mUo
	 gKD/qApLeMiJx5Kx6xKPtJ4Lc3Y6IdYP4FcITG4pwOaFSPL9imWun/N8R+IGGZ0UnBEyT
	 RYP+b6SWfUk8wKyJL/Qbfsnmy5G9yHLf7mLdXHcunB3GTM1zHq2blPWAtFBql+fdXieim
	 lQGMcGX1yOnzPWqlIB2PDnN8JRzoL3CoXuCpB+AdB0MsVhS7X5AYJmQ8U+KRd8imXog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kC3J6FQjQiif1KO4FNLuCSDjyO9jWP3N6yJWGn7D1oc=;
	b=J/xhsJtJOec3ngu0aEl3+19kfqbccl0hWqHOLwp0SrdcQiJ+uI7g8LimXpLB4kowgsbG
	 KXsjjpt307tf1taeLWa+S0dAsRa3u8Md/08fX1CwiDoIWMysdJtBqR0hJSyuizFbCN/Zb
	 iFqynG6yaRgAQIW7FRZPVm0gn96MAJJDBvwV+B41Y6e3NdPpWdHyn+Fzy9Rx9WRQWF4Ad
	 66s7hJNoveipkNUg31KFzTLIfuRQZzoY7NJSTI2wS9vKBrnoz2jr6sPHomEofH8wIsPaI
	 E5iHRjgOqW8nt1Dqd+f+uTRzKlitKhWXKhOgvBC2qtMC0ZAoPcb8Pky3OfSqJPl+f3A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586760;
	bh=kC3J6FQjQiif1KO4FNLuCSDjyO9jWP3N6yJWGn7D1oc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJ9+4yfVidMrVJwFWtdAyMsnQCzcVSirzQc3tig0G8Vd2tJ+kEvjiZC98R2XtsXDy
	 U5TSInPah1FC2GKKsa8RF3lO42li0b2GezXcF0IeZfbae2FGYHKi05u7Ops0sqc1Sa
	 uXsNm790/Oqy+yqmmywa6laqcGvsWFEIlgHeW9axMiPzvL93hgZisqYPjJXtIGrUDi
	 woht0n+woS9GI+whKd8GQvGCMRLTz2+N5+LXkIsUlKn/BMk9r8yJ3UE+jQPRrhHlWs
	 PHHcdU1vFh411H/+g5R1odPcMcYluFdU5i3RgDiWY/if/g5d+2mu9tOWLDf4SJmXQa
	 KEnlwROiwP0bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4376C60896;
	Wed, 21 Oct 2026 12:46:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 680BB380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E28D405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6AowPd-kzUs for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 787A140728
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564762;
 b=rI39TQjOBJmB4MixBHl7SgyQ6c8LfBKZfo/wQ+5zCV7YxpClwYhxusICXfKNcFQ1stUJ
 FbB4PMELThDoZP20kc7RBJsSPdsaLr616aHWLImTqSeNHYlppSZWptDk+sdjqajfmzkwH
 pUeOvaRfxJMGKFfV1Y8Ozf4O31A+E2VGrLRraz/lN09/Z5jkZuIlywTFT2fnD5bMm+D16
 mKENwkQJAPZrsVlGI7+it4TZaWYzCrcFv1AA+NTfUygy/U/s3aLub1hVmKbFYqHluhiQD
 ZrveVe2fL42vpE6kvImAUadydRWbTZw0wyZaC1x+ycaM7MqQEi47v/NPxWQNR8+Wy2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564762;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:References:
 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=kC3J6FQjQiif1KO4FNLuCSDjyO9jWP3N6yJWGn7D1oc=;
 b=quxX1lD5/V1+zJyx7IA+8L86HUQpv998zWGmnqzNF+CyzhEq/s7AWHO9SCDuFpu3KMtu
 7ar9y4F9nuyQ2rycqkuzPFn7v+KvHDwGurjmadHIJvSTjpCCa+FkOpr+R4ZO1jmKbscfO
 2M16mIQ4Vad1D1GvU91neYsGFm9VLahp+GWuL3nhCzmameddHXwaKXoyKB0LfKo3Jt5Q0
 EjJEcUI1+HmUIBCwc8x0mhi13WysxshgnnXhvLQEIure2ItsE95idGjRobIecsS1C6NCU
 q+DajXuViNp2lIRhPG60xuzP7aNVypQNdPZ7X+Jm94fz4g1Ny26Rqar83Fry7eX2oYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 787A140728
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:22 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 21 Oct 2026 14:34:09 +0800
Subject: [PATCH 6/6] arm: dts: ast2700-evb: Set TI DP83867 internal delay
 for mac1 PHY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ftgmac-rgmii-delay-v1-6-fce405523118@aspeedtech.com>
References: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
In-Reply-To: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=1238;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=CcVgRGlMghqTTgNmEQBksIJXLVn+8Wkas/q2rjo/lMM=;
 b=IkfgcSxa+JW4S4CR2MmCS87XoP5VFagEPz360Q/4AZAW3O3Zo/iNp89OoH1N9DzWtVm3hXC1h
 opaWlPjMPr+D/FKrZ6UoUsQoC6fj7xAdq2flTCwVc82HSEai5k2czeE
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For the DDR5 variant of the board, explicitly set ti,rx-internal-delay
and ti,tx-internal-delay to DP83867_RGMIIDCTL_2_00_NS for mac1's PHY,
matching the driver's own default for "rgmii-id" mode. This documents
the required delay in the devicetree instead of relying on the
driver's implicit default, so it keeps working if that default ever
changes.

This is independent of the ftgmac100 MAC-side RGMII delay support
added earlier in this series: it configures delay compensation on the
PHY side.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/dts/ast2700-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/ast2700-evb.dts b/arch/arm/dts/ast2700-evb.dts
index e7222d9691f..f8e74c93efb 100644
--- a/arch/arm/dts/ast2700-evb.dts
+++ b/arch/arm/dts/ast2700-evb.dts
@@ -4,6 +4,7 @@
 
 #include "ast2700.dtsi"
 #include "ast2700-u-boot.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	model = "AST2700 EVB";
@@ -39,6 +40,9 @@
 	#size-cells = <0>;
 	ethphy1: ethernet-phy@0 {
 		reg = <0>;
+		/* For DDR5 board */
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 	};
 };
 

-- 
2.34.1

