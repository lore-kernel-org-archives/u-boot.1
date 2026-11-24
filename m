Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35475606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0/bI0FFY;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NQq7vOfz;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=MZtdwk5I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2119140707;
	Tue, 24 Nov 2026 20:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MsUgGvzk6wUi; Tue, 24 Nov 2026 20:59:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2413340674
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795553950;
	b=RqGqQ6ZZkqn+T7pVY2VEOh2QGTyNPcsfOUMK/2GVBAUdmMY0LrBPQ/XJeMUh0AdJstPS
	 M2Qcv8V7rEHld9AALcxTZHVrXZeKXT44SSbnmHe//1XFVaXBak9Lj4eUZxvlqLEMxdaoL
	 /sy80c1aSXW0ISafZXrgf5JZsgPjzuuSvTLIbdh3G+Inm/ykR8kjv02jkt8iPJpLqmQ9O
	 ekv2D7zi0b60Z1lvyFrPkpX0Tb19VQYtlhtOfA6wWynC54Qmckz2HosRSi2hBwOTBPB2g
	 HlKZF3odzm/7Mt49NZcsbFp2dh26UyJL/2bquPcJQW3avPwPrS4CTUVVyoEtJ6sZzvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795553950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=24fQQ/Jy3uyAXg3UcUr9gZ5X/+sTPnE9CLv9ld57/BI=;
	b=jKgYmKWGVe8H1dv0WI/Q58QVRvpxxV7ZXJXnwMZggcW12i5IwxG/Yl8T1Z91GxQWPula
	 8gPdAGlnzdiw+jLFkoiJFCAzV3ao4PcONPKE5YNcPBZQh6iw+67RDHsMuPdCkN96ZrXdw
	 eAM96mhYitKHoCyufFvX+gIvohnKd4lCHwpzwYnIa3Rt73+i2kG9eenC7YD76rBRUKpfa
	 OfB4J8OmZCMCQqlv3YcA2XXLvF93dyOuMPHMBFrIjG9kyYyUaIJKHp2b4jn28ieMNJZHb
	 7hlmOUKaTFXiUnx2bqetFPT/iKkt2uuezVbQUNzlD7yLRTUO/nJ7CmeaWZT9UInZJGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NQq7vOfz;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=MZtdwk5I;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795553950;
	bh=24fQQ/Jy3uyAXg3UcUr9gZ5X/+sTPnE9CLv9ld57/BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0/bI0FFYOdQdmp6nA9MvN1envh6zt/NS7MORdTK3tAmXShHHfaGyOvnl2sBg5fPjd
	 PfJcczXyBemMlvWh7TPqqYTrFq1APX4RTihsrgWWcmYxQOahqH4WTZd48N8P5FZU9u
	 gPlVftDYlSrr+McQv5mRqQQGC1GhEBT/voFkiIlNX9KcUpa5T3kmPeW4sIHzsvYguy
	 nIiF3hQ7tPAnudxKhwJEOIo6GgDEK3Y+d/5OCAe5d9Mh0/PAjaEVgdP7opjLnDZQkv
	 vy4bpvEjtiUtgR2xNG5chgVFdlmYvZK2Om8XHNR4hxGL+9amRy8t2bFRXG25ulLgLZ
	 B91xZcyqc10WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2413340674;
	Tue, 24 Nov 2026 20:59:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B517325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7625B405BF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HcdWSP2joink for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:59:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C4A7405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cbd4=jo=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NQq7vOfz; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=MZtdwk5I
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C4A7405CF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795553944;
 bh=24fQQ/Jy3uyAXg3UcUr9gZ5X/+sTPnE9CLv9ld57/BI=;
 b=NQq7vOfz1jg/lZZ/Boubz3t6lfzwh326JV3WFOLw5IVOz36OxZoDjBRpg6PB4RILXLxR1WGDe
 q1cKRH4tZ8CdYEi5zEG6vUU7U0WhqLlfXJhym+RSKBK03HzzTWMSusuXyuRbzFQWKNWCwQoHU8q
 VhuDd7I2u8RQkvCAbTeISvWMjORJReQ2ZVey2JabyZDHxrPWMDAjnlNmPYRFS3dzW3sxNPJB49t
 Y5EXRZPGqwBGIygEg0vs6dSUF8M85XlHuLLwPNgurCNmWebcFTWe8dNR07hKa588r27mc0ntPjF
 GXcRYl+H/IEqwByAbeBiZeHzcmpHxTKh5FFBQYUv5Q+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795553944;
 bh=24fQQ/Jy3uyAXg3UcUr9gZ5X/+sTPnE9CLv9ld57/BI=;
 b=MZtdwk5IywbYCvnLx0S3FLEKXW2sH7YnRp1Q/n3MTt/6uCj6zm8pAE8W18BmESiRUaqbleLHR
 82x42z/cDjnByAtkiqzz+MMjpsas3blOEFKSPcJLCV/g5zzOUcL2Kr0xpdRcpinEAsvnzUuZJau
 dbA1jstyxbI55kpthaF88/8=
CFBL-Feedback-ID: 6b05fa971eedfc30af5a53c2:660d5c8847a2d966b07fe5bbf81245f5
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b05fa971eedfc30af5a53c2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/4] rockchip: rk3506: Identify RK3506Gx SoC variants
Date: Tue, 24 Nov 2026 20:58:45 +0000
Message-ID: <20261124205846.1536932-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124205846.1536932-1-jonas@kwiboo.se>
References: <20261124205846.1536932-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

OTP data at offset 0x36 and 0x37 can be used to help identify G-variants
of the RK3506 SoC.

Override the specification normally read from offset 0x08 with data from
offset 0x36 when available to identify G-variants of the SoC.

  Model: Luckfox Lyra Plus
  SoC:   RK3506G2
  DRAM:  128 MiB (total 127 MiB)

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- New patch
---
 arch/arm/mach-rockchip/rk3506/rk3506.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3506/rk3506.c b/arch/arm/mach-rockchip/rk3506/rk3506.c
index 7fc41b8bd097..be65a5792c60 100644
--- a/arch/arm/mach-rockchip/rk3506/rk3506.c
+++ b/arch/arm/mach-rockchip/rk3506/rk3506.c
@@ -83,12 +83,13 @@ void rockchip_stimer_init(void)
 
 #define RK3506_OTP_CPU_CODE_OFFSET		0x02
 #define RK3506_OTP_SPECIFICATION_OFFSET		0x08
+#define RK3506_OTP_VARIANT_OFFSET		0x36
 
 int checkboard(void)
 {
-	u8 cpu_code[2], specification;
+	u8 cpu_code[2], specification, package, variant[2];
 	struct udevice *dev;
-	char suffix[2];
+	char suffix[3];
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
@@ -114,11 +115,26 @@ int checkboard(void)
 		log_debug("Could not read specification, ret=%d\n", ret);
 		return 0;
 	}
+	package = 0;
 	specification &= 0x1f;
 
+	/* variant: used to identify RK3506G SoC variant */
+	ret = misc_read(dev, RK3506_OTP_VARIANT_OFFSET, variant, 2);
+	if (ret < 0) {
+		log_debug("Could not read variant, ret=%d\n", ret);
+		return 0;
+	}
+	if (variant[0] & 0x1f) {
+		specification = variant[0] & 0x1f;
+		/* package: likely SoC variant revision, 0x2 for RK3506G2 */
+		package = variant[1] & 0x7;
+	}
+
 	/* for RK3506J i.e. '@' + 0xA = 'J' */
 	suffix[0] = specification > 1 ? '@' + specification : '\0';
-	suffix[1] = '\0';
+	/* for RK3506G2 i.e. '0' + 0x2 = '2' */
+	suffix[1] = package > 0 ? '0' + package : '\0';
+	suffix[2] = '\0';
 
 	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
 
-- 
2.56.1

