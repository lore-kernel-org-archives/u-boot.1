Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142F1C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6130810E4;
	Thu, 17 Sep 2026 17:19:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1s6MGv0-xbaf; Thu, 17 Sep 2026 17:19:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C781810EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665584;
	b=FVJkJmehyNP7w8S+5qTU0HhnSTyXqQeUZeG1T3dLjGv3tZJZtAOpiGGa5smaMPmAfEzJ
	 hRsSepjw2X5wTXqdLB56mF3wgxHFi0RaU7tdLHlqj/re8uZMcq/yZZ9Sf88BZVFgi5Kpd
	 vk2H1KefFSXYNZ1/phyEjwgwKeezy3tPBpE6dMIEIO06CqsVIMccq2cfYtUrWw3ai6kIP
	 zjd5oyEBj08FXDGvKGdba2p/n+01eS0pL1EmIFR5sjFRpeag0a3UI0iRWEhWqLrCMfXC7
	 uPnMrxj4IZlfODQ88Gf3/btcx4oh198/JXANZY1nXBbEAK+xhDqnxlbpAYG7JRMm3zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OhN9U8NKSYzg3xgQKTSqY4zN2BHI9PvvkBovZr5UUMg=;
	b=L9Mu8Ye5GdMy3PlQ+YYJJgZ4gQW+y6nk4DlSyX2A81dokmtMktWv4iB+HVH4mB3P/7I8
	 fP3mAgHsn8e256r+k0Um3IBi/RK4sDhBk/9l13zVeV7A/UiiFYQY57vL4EhMa41w1W6ta
	 KQqvMO/Vt9YwIz5xt2PuGAywThoYFv8iP630voEjsIxLry5vcJ9TtdkoUFeWucOmW+vFx
	 JxXpnDPuQXVFnhkWhdAPLzJZesDnqMOgWAIwB6JT746jKDStkZAtqmXUKe5W/Fnd4m4Eh
	 FhB5CJP/Que7I0myzmRl5drTdC0dAZ2I7+M28pdLIjp5ihpNSK+NPGwauiMZQMTasqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665584;
	bh=OhN9U8NKSYzg3xgQKTSqY4zN2BHI9PvvkBovZr5UUMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sy+rYsVWtUQ5UjU1O76mVneoCvsuN5/TNhQNBp646l4dAXuHttCkhvtp/QYWGzVVJ
	 t+PcKGL3ErKwnMBBEcGQeC/cMR+mG/4oYZp5/L90ybQ5dpAO8E+XM7KtHKTvcWCG1h
	 j8jWisjBGJ2b62Ouuv+rNMiNdQQx+dAr0jUrIvAoxULROA3GWR1tdDd0r3qUM6nOzx
	 mcN2KUJ199+uEEup3TFVjweajZMH3RXlPZl/8VMO8Z8wxQh59U4ucOQBWw3kLeuWNC
	 RlXN4n8gL5OIiTO/syp8TRlcm6KkLHXfZ6WPPv+q3Vvoc/jqK/M+wgs9Y/5x4iUGeX
	 WE6dnqq/NDwPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C781810EA;
	Thu, 17 Sep 2026 17:19:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA0713D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F038D6084D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KIFkDe1uC-Bz for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 68A1260B58
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665529;
 b=qQC8UoUevuVHlx34WbK4enuksqRJntsko3aSxFOrlMml+Z5nJ8uFh4xcLRSiO/QlVjx2
 e3J9tIUOpsf71VBuK7vetAMBV7igeNBLk+gfuX31ftc/UZ2lc75ZfimzOm0SsysYXsdtc
 5l2FCFAwJxuRMvxF0bgXODZBd8w0C5pEU6FIVRLPqwuMoe1Ks5u1XnNemgn+K8SHeIGy4
 LTU9FKHWzLII4y4pb7BllH8Vyjar46JcqgrhS1sN9JT1qkce2JaNaUaW428PfDBO7zZV0
 RkyXHt/40WL+ZbyCTbgtfwXSblRNgEucto7oNf0mLtX8wxx9jCJSboif5VQ+0uPQmQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665529;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=OhN9U8NKSYzg3xgQKTSqY4zN2BHI9PvvkBovZr5UUMg=;
 b=I29VafmPDYXSskvfwzhfAf3I1pei60Q9tPSIyUR5sIjpu/DtAwq8c4pbl9bovEbP2Qaa
 d7NT6VEmZFQIFjarLHEdKPh7bnJ808TQ38jbt8gstvjLuziMvQ+Wwgj/9KQisxe2y4/AN
 nUFDzc737sogLoqQOh2GsayfXfQO4oht4lOTNCkPN9vFGoQCuRDtw52sLfUXMMyq9fAxA
 MTD8v/LJRIJGj2pv05r7Gto3Es1CyY9eMDAVY8ttTFl4cStmCizfdVghoijq9Pe1pCrEK
 WnleVJOoXL5Ohih7aV8f0qcaO6jMkQ4ueGMQydlnF4qZ/Z/66TKUmSp7xJrpVDhEJKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=V5gV2AHj; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=V5gV2AHj
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68A1260B58
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF8F1596;
 Thu, 17 Sep 2026 10:18:45 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E57603F7B4;
 Thu, 17 Sep 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665528; bh=BMSY/BXCXueCeGTrj0h80yPdDHoSqv+fJ4bFeHfh3es=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V5gV2AHjdQI1NYqt9yefdTKaRP9gqLZACgNretnNq363QMPwzbRDcsodVq5SfrEy2
 OZ/qEIUhg9uZ7umhjDWNX16nvmOaTaoNBOYnse7KrzvHHMILd5hl0npPUBwze9KqH6
 eP86xW7aIKpxwQ9kcwQNVVZcLzibftfMUZNatzKg=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v6 08/24] arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
Date: Thu, 17 Sep 2026 18:17:54 +0100
Message-ID: <20260917171810.4122899-9-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add FFA_MEM_RECLAIM positive and negative test cases

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/dm/ffa.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index e80f9024b8b..fc84667bc96 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -179,6 +179,27 @@ static int  test_ffa_memory_share(bool test_ack, struct unit_test_state *uts)
 	return 0;
 }
 
+static int  test_ffa_memory_reclaim(bool test_ack, struct unit_test_state *uts)
+{
+	int ret;
+	u64 g_handle;
+	struct udevice *dev;
+
+	ut_assertok(uclass_first_device_err(UCLASS_FFA, &dev));
+
+	if (test_ack) {
+		g_handle = PACK_HANDLE(SANDBOX_MEM_HANDLE, SANDBOX_MEM_HANDLE);
+		ut_assertok(ffa_memory_reclaim(dev, g_handle, 0));
+	} else {
+		/* Provide a wrong handle */
+		g_handle = PACK_HANDLE(SANDBOX_MEM_HANDLE, 0);
+		ret = ffa_memory_reclaim(dev, g_handle, 0);
+		ut_asserteq(-EINVAL, ret);
+	}
+
+	return 0;
+}
+
 static int dm_test_ffa_ack(struct unit_test_state *uts)
 {
 	struct ffa_priv *uc_priv;
@@ -236,6 +257,9 @@ static int dm_test_ffa_ack(struct unit_test_state *uts)
 	/* Test FFA_MEM_SHARE */
 	test_ffa_memory_share(true, uts);
 
+	/* Test FFA_MEM_RECLAIM */
+	test_ffa_memory_reclaim(true, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE);
@@ -297,6 +321,9 @@ static int dm_test_ffa_nack(struct unit_test_state *uts)
 	/* Test FFA_MEM_SHARE */
 	test_ffa_memory_share(false, uts);
 
+	/* Test FFA_MEM_RECLAIM */
+	test_ffa_memory_reclaim(false, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.43.0

