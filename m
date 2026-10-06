Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C545FCA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F0C660814;
	Tue,  6 Oct 2026 15:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IA9tajlJKBJM; Tue,  6 Oct 2026 15:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D52AF607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302361;
	b=QC+znME9yIsykm4Uk94Ey8Wkb8kxiV44WCCrNCP0Vn+4YUXC7x6R+XeJv0JEaRAL070U
	 46vCZCdbTw81+pPf7oCPwygktjFKAxCNXvPOb5E5XaQxqKYBiNgk6qYOP1rxBQ5XePZjc
	 05K0MiX7s/MZl/hUEFkpvNfOAqQQMlTmuX8tocWgLsm612kuEJXrxu/vdQn0I/95NUBY1
	 K13Z/QZOypsD5R49IwdNhDUapGHE+UPNCt54Jnu7daubQO3SFIYpOOoIc1RYwc+d4bVMp
	 TmNLUVTmFb1MtBQr5W4vMVLTIqQahEl0FEep6+uGcXCnro2hbsz/yk1KpKAg5K40GAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K92tpqInLIe/nA4k8GTPbcunj8gbNOgHi9DoWPDeOz8=;
	b=R9To0DuxrQw0ZmwL3zF3PQKKe6bE3BX3IhfN1hIfolkm1kjdbpkyH8GlF36FFl+bB5SB
	 m03DyiWFZSRbe7AYo5cfZpkeoMA6Ax/7ReWu2S2xoD/KTsQ2AMDZzNWZmgI6z90/hnX5v
	 4u83ofE4WgQ9pzietjBZmz3C5RVRZnInXYL0TukTs3Ug35WgqakO70JlaKdG2oyq8VDHl
	 PlRTC80DQ8oOHBILLnc86xb7XfaFW4aduHoV22wmNaOoiqPxTvUUxXUT6RZdIoUdLzZel
	 hD+ftxMdyS615Se4ZfPOIWe69MXWXe+sm2iK4G9GuCxoiquywhQwfbf40uFhwUUggBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302361;
	bh=K92tpqInLIe/nA4k8GTPbcunj8gbNOgHi9DoWPDeOz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kz/qY7xq3dzSWab8FzJQIV0sx/Bd19O3h/hFbhvJFIAEp0hhaAeISHZcnz0HYfWCX
	 /t2J8cCgERd6Z77tHO8tdBz1Fk+DvxxgowOpVHtjEomCCpZswvvKbc3ru2AppQ0KaZ
	 oNDpfxy3KQ9zaHw1yoIvza4EG9wOGlALi8zrbcelW+/0/JUetm6l8uFSqJ+YM7sR4k
	 Glkuh+qcEziLEKjcbsuDSEMn2DnZf4aUyiCgktRPwd8YRYpotg61HRpD5M5+9lxruX
	 sx3vCxyHXNNn/LGbK58+4NiK+Mk+37asMnc6vjpUSFW0fqyxoiedIQIb5p+pe7yfbx
	 8qqPWRiCjO35w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D52AF607E7;
	Tue,  6 Oct 2026 15:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AAEF361
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0145140296
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5ScRJzFO14D for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7C8EF402B7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791301943;
 b=bEf9f/2O5hi4o7xU7pUUdLLP1/ia+BTSjptnYvVbTAkYEKQnAN+s8S7DZewU1tFzfbGW
 OsHVeKFzZ4jIbpe2T9qhlD4h2oIm8bfng9ZU54OwQIiUt/gE1SI5YBb1iIziUXVJDqAcg
 xLOsgYQxnTy3Glj/1FqcAWjtLb5ku9esq0d1fxtn39emajfmGlem8NbT5kl386tg+vMxu
 7hW+E7t0O4SBJiqnsBb5v/ZkiHoIwYy/ltnWOaNLOSQid5nn0blGcUDxkU5WLf9OmafZc
 y5AH1etLrfuTSATn6yQyJS93tczCX4KhCYJZZukFesI9p4vpaNgyqBGGCYY6AkSf0RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301943;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=K92tpqInLIe/nA4k8GTPbcunj8gbNOgHi9DoWPDeOz8=;
 b=iPdS2Afaoe3oSQj+Bdy5QdAlzqGmTQnAh7HpSDyHZjXpgJNEIVXNqX6nR+LMxAzP+tUK
 GSYqcuU6vuLF8htD1f5djU3oFjmmd6wolvSUpBT1mkBsKLpyeHbvHod2GGlcB7D/tX0qt
 B6OXfOUErQtz2Q2YwZJgXFiEQOHLZsSbNjA4hOhhsAAtZqpFSYE2GXbakJ5pNKc9T/8P2
 jIBayqYdmHEdJ4O89wI9FEbzfgGzT0umLUFBSs5VvHYOmCSaD3Ajpk5E9DvTigkZ7e60A
 v88FAIWvfoh1RDUDa/ijjfLEUUgSAx+dQi5qmzJNq7sDuunLTvI6m2hm78AfsBWHGig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=lLWJrLAX; 
 arc=none smtp.remote-ip=185.136.64.226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-664519-20261006155218f51b1f100c0002073e-r_luje@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=lLWJrLAX
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C8EF402B7
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:21 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20261006155218f51b1f100c0002073e
 for <u-boot@lists.u-boot-project.org>;
 Tue, 06 Oct 2026 17:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=K92tpqInLIe/nA4k8GTPbcunj8gbNOgHi9DoWPDeOz8=;
 b=lLWJrLAX7S9qufGQGiSwAh2IV+RFKUcIH91HCJAAqJBcy7mL0ar06CiUhWaq9uAU3EC3e3
 d9ltRxKQTl1Pt5+qDrR+F2ehgR8cbc+WL9aWhbHQSpgwqLdVPm3QeTYNvvhYh5uohN50Z6/T
 yWEs+jCOAfaUPF6YI75Y8IdzDDnP5ml6i039LrAg0QP4I8Z4WDSrg6pSIPKM729gum8KdcyK
 I+S1/BID+VZmD9F9xBRlwWsYTHEFR+Llf2k1MYYNQaDifmMsBPgujLzV1SmTfRknOa+pwGNq
 pRnGMsPie01HvNiBkO7Xodslei2g2NWwq9ij//JPUbzS716wTh0Gsenw==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 2/3] tpm: Add tests for CONFIG_TPM_AUTOSTART
Date: Tue,  6 Oct 2026 17:52:16 +0200
Message-Id: <20261006155217.187050-3-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-1-michael.haener@siemens.com>
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

Enable CONFIG_TPM_AUTOSTART on sandbox and add two tests which send
EVT_LAST_STAGE_INIT: one checks that the TPM is started, the other that
the event does not fail when there is no TPM device.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changes in v3:
- New patch, split out of patch 1

 configs/sandbox_defconfig |  1 +
 test/dm/tpm.c             | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a2708e6fb33..3efbdc6fdf1 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -400,6 +400,7 @@ CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
+CONFIG_TPM_AUTOSTART=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_TEST_FDTDEC=y
diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index 87c5c416daa..46e843787f1 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -5,8 +5,11 @@
  */
 
 #include <dm.h>
+#include <event.h>
 #include <tpm_api.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
+#include <dm/uclass-internal.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -197,3 +200,44 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
+
+/* Check that CONFIG_TPM_AUTOSTART starts the TPM from the init event */
+static int dm_test_tpm_autostart_event(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	char buf[50];
+
+	if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
+		return 0;
+
+	ut_assertok(get_tpm_version(TPM_V2, &dev));
+
+	ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
+	ut_asserteq_str("init_done=0", buf);
+
+	ut_assertok(event_notify_null(EVT_LAST_STAGE_INIT));
+
+	ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
+	ut_asserteq_str("init_done=1", buf);
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_autostart_event, UTF_SCAN_FDT);
+
+/* Check that a missing TPM does not make the init event fail */
+static int dm_test_tpm_autostart_event_missing(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
+		return 0;
+
+	while (!uclass_find_first_device(UCLASS_TPM, &dev) && dev)
+		ut_assertok(device_unbind(dev));
+
+	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_TPM, &dev));
+	ut_assertok(event_notify_null(EVT_LAST_STAGE_INIT));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_autostart_event_missing, UTF_SCAN_FDT);
-- 
2.55.0

