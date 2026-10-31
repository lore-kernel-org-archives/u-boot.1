Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01C606A31D
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q4u6WAnr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22C6E810E6;
	Sat, 31 Oct 2026 11:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxl_32LMvQBW; Sat, 31 Oct 2026 11:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FA4780D9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445011;
	b=MjyCEFr27UqNWSXlcWID27dTbVHIJMS/C2S1Ap4f6agXrkR+fZ7lDtCUmiK6CWDw4gWR
	 qseP7bxJd8LUY/fxey0wPO+w4bjKdfWkEl4Uwwl5mbzeCWoxFONFpa0TOgjtOQFc5WUH/
	 D5qMOdNkxBqFFPH7MCfzxGcp0TgCt6Du9Qj3ewadqSOcgJFBZ07EaMmoxlrP5VCHbnPWE
	 INLNq1M4cRsTeo+BZpsLDN2+Y8gvglHJaG5wP1nsUHUCVV/Dl5TV1PJtZ5FGceStk53IX
	 NtOQ0y6BBPKqeTCNgPYfnNIz6SsT7vc9c9ZagS0eLFK7R4iDt1qK/mhXv0TaFxlH1HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IJmC81zV8vQsBTlXbqJ0dcj8Dgx6oxSxzMJZBTZxwVE=;
	b=OYQ23jsXX/BKlX2g1+2QuxR4rOubCW/Trcuckts5Qcsn3vcjBdvnjWRYhT4q6orpncb6
	 6vwLBuSEIYItf3PAshXpkiCwOyYZ0HRRc8cm0kNWQIyoJZ/qV4zb/O0QHbRX/8F7Zv7qz
	 QrZkawttK0SRZNH2UWMf0PW+4vM5nMQV4Grq42AV25ZB30VZ658NgLpI3Fbb/VRM7VOjJ
	 9Mk2NFd/xs111WqVuSvmmtYFUeWH6IEW/OgvgVwLoTx+btj9D0vK+GiPHflF0mkn8Skmy
	 JP96GIHhoVdimYE/zg1GRmboBsJXPPDW00yJ3F2oU4jOewam1T7VfgUXQUnymYqLFvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445011;
	bh=IJmC81zV8vQsBTlXbqJ0dcj8Dgx6oxSxzMJZBTZxwVE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q4u6WAnrCe230xMLx9Eodw0VCNUs2Qyd54Y6vskf0uIUXGOvXAhxK7x0NDfdh9U0a
	 feOaFDpa3+chfD57cAx0aCkZv8pZtUL2vWoNMsW0/jigmGciEhwZ1kXDSQzKzONcUy
	 5GCx4QGMBImeSnOCv8pLqKP8LRw7ioqMlAsYsWvCZMlOc2zpYpT234K0Kj0StFcBp0
	 P2txaUlwoL9ZDbp4gVUdLxqOVCr84kDZm7HYE7VBFsAtXXoYqtnSQxn7/cGBuecQXF
	 0mVVQLSlrm27K587U3oE8IcyxqRL/6wxzVbl0Hc+WJi/CpAWOLZAI4MRgRVO57G39O
	 f/Drsg3NHa4uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FA4780D9D;
	Sat, 31 Oct 2026 11:10:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 784134BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69E8D60648
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiEaPIfwvgOw for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AC0860633
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445009;
 b=KTICDrQX/Kx/lk71Mrb+mBY95KAZhbugnQuWzdtTo6SaGcDTmXrEUovKFY/Vj3uXb7gV
 lQcjLSGYNvlSGv3GvnmW9UcqinbSkw6rN/6zQSI84VX/ud2FeNVmtzFygyeuVSjdesTUx
 KMduOadDRh/sNntTSGbSzzMQXc32Py6xN2mBXWAvl/yiGQFN4GyKWSGqRW6VkOiIGNHM0
 xN5i9EvoNeN/pfQyndAGlw5RxC/7X9ROeb1TiT2omXW8y9yivlFja5x1DdjdV6RXdTjfd
 62ILfYndmmnMSNHuFaqfh+1yY4DeecJ4zXKp2jhl9if0vlfguxfAuO3k4YvrQkOWPJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445009;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=IJmC81zV8vQsBTlXbqJ0dcj8Dgx6oxSxzMJZBTZxwVE=;
 b=PIw/vB32V8VUWPsBaFoBaui61xsCkANOD3g6CZxEXiU0oz1ddeMd6XVeCFy6ePb5KQWt
 77D2uvk83eK2qQWZJOE0USw+LBTUL0klEyc9You17hPFE8rCvsPJBl0twcAvioA5nd/Gu
 YFJ8GM2yxioKFoM5lt4eNcVw3KUZyiUOJ1CBA2DvZjXNUwu9cPRa42cX2jnw5jISmrwhw
 BRrVPalVojHtUd5gRBXSRLXHx6IqbNKAqDmcE21xAEwNyfXDrqvGKQ1lLTEoKTsMco+0J
 LcZK6+cpMvwLbVywec3oFxt38MIrffwcLaNPaqiRpvl3FdAhzawfBU0G8Nz3zpzzBgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AC0860633
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:09 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6vD-000000003Lk-38sw;
 Sat, 31 Oct 2026 11:10:05 +0000
Date: Sat, 31 Oct 2026 11:10:02 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 01/11] test: cmd_ut: keep the suite list alphabetical
Message-ID: <ce778cf18393435745aadc6c4174622b0390f625.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The imagemap suite was appended after setexpr in both the declaration
and the registration list, which are otherwise alphabetical.

Move it next to image_fdt.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v1.
v2: No changes since v1.

 test/cmd_ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index fab55d5be8c..966cf44c511 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -64,6 +64,7 @@ SUITE_DECL(fit_verity);
 SUITE_DECL(font);
 SUITE_DECL(hush);
 SUITE_DECL(image_fdt);
+SUITE_DECL(imagemap);
 SUITE_DECL(lib);
 SUITE_DECL(loadm);
 SUITE_DECL(log);
@@ -74,7 +75,6 @@ SUITE_DECL(optee);
 SUITE_DECL(pci_mps);
 SUITE_DECL(seama);
 SUITE_DECL(setexpr);
-SUITE_DECL(imagemap);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
@@ -95,6 +95,7 @@ static struct suite suites[] = {
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(image_fdt, "image fdt parsing"),
+	SUITE(imagemap, "imagemap on-demand storage loading"),
 	SUITE(lib, "library functions"),
 	SUITE(loadm, "loadm command parameters and loading memory blob"),
 	SUITE(log, "logging functions"),
@@ -105,7 +106,6 @@ static struct suite suites[] = {
 	SUITE(pci_mps, "PCI Express Maximum Payload Size"),
 	SUITE(seama, "seama command parameters loading and decoding"),
 	SUITE(setexpr, "setexpr command"),
-	SUITE(imagemap, "imagemap on-demand storage loading"),
 	SUITE(upl, "Universal payload support"),
 };
 
-- 
2.56.0
