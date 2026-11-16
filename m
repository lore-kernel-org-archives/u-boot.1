Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A21606B1BA
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k8Iel+xw;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=UoD1SdMJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 468D260769;
	Mon, 16 Nov 2026 11:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id breHSCOMNUti; Mon, 16 Nov 2026 11:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B70F6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827149;
	b=Wm1gToQsftVyZLYxV6aFB7d7LCiP0xqvhg29S98M+vF6C+tykSPOpTghZJ3zcvUP90JA
	 6Gx8T+YLdvO0wDHJUioN+Drbkwo4TBJdkFhkKdJ174W3OsJsDZ2mk3Tfm6OB3MSwyC6LK
	 OYkKp8cFDbwTuHysSI5MX08ZdZbh5Q1pAahlTrw25WVZnMcNk4ctOsrWdai9EnbQkxf+S
	 7KGKOqgS42mUkkntWWd69nJTLCPR7zSlOe4NHeyfnvZgmNsl1zvPy1UEg6e1zIoa8Si5V
	 sbXS3i9u/31eTgocezSaj2IKIi8suvCtrqoY+wGWrQI1uSjKF2/VDVRsu1qVDndfSMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f9hP2/ZVSXQj0dvGvAwmsYWkkDuPzeE+i7Ky7CEck/k=;
	b=UgmuoLLC9vEcZtM2RV2o/p52hUKFu3NYXMnKU/GA1rn1wxdt+urPKfHU3Tv+nYvCWbWw
	 XWqPHRhBldGdtSvWm7aOQOie8UZdyUUTKFgJaxK+IfAsIBcpAKbIt1DFeqMvzo/lPEQD4
	 vee4/YCoA8gz7DTvunVNM4G2Ns9SP8/sXQGG4p1+B7Vf5wGFH6/dKDf6YOEG0eoY80elO
	 dbN7+nVQyynKD9s/n1kpKILGcawI8ROwaOSRPS8oc+pCR8oBP/nuMp5DiTEqylK37gcEm
	 tqss9qtDDfZmutNqdCoppCucdB3U1gqe6ZB7amFrVjeMHYXgjhWiCYnyCQ6PCd30p0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827149;
	bh=f9hP2/ZVSXQj0dvGvAwmsYWkkDuPzeE+i7Ky7CEck/k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k8Iel+xwKw30HGu5qQXorfEBbEEQ7tJBMAn1VVneEmz1BBkfbF7qmYwFBSbzy+lKr
	 PSL67rGbmSuaPwiSJSlb12JNEs91J24WGPCZf5BsJksIoeT813BvgJ/2KfibWUBY1f
	 NkXCPhlzkl133wwHUmnSVHAFFii6gFF6U1vRYglP2bNbp7Rr6Ry9kJUC4UVV4VGg6L
	 zRhwbqad3t3PD0exyGqcRTZa497oBm1JrlWL87ra3T3KqZPiWpMDYgsDhZms1haWOF
	 8Z92cNmYUkHD4aNno3/ibqZsDRrF1D1tDdpVTPPzogns0+n5tT/Rd6n0F9HexIMKHf
	 0dYAVa7rJRyKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B70F6067D;
	Mon, 16 Nov 2026 11:05:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F802FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E116405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvdOOrIrC_s4 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 776D9405CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UoD1SdMJ
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 776D9405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:05:45 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSlQZ2JvFzMltx;
 Mon, 16 Nov 2026 12:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f9hP2/ZVSXQj0dvGvAwmsYWkkDuPzeE+i7Ky7CEck/k=;
 b=UoD1SdMJlf6EOssNUfqJkQSLA6ixZq21XRUjpkxxBq+kcPzW0sitzPCWhPKSgBm1xnCn68
 Jb7LxJzGBLgxUN6RjhIE/1w7SewCqaE/JlQ/KE7kOHOvxIkdtU+3BIrNBSHZQghRKew9X3
 pZ+jMI4Sdc9Sqiq/zHF9MVduF02zRddtZazM/WaqyWvgc5J56fpVUmICCsLtjK4t90qOuF
 jFqXiD96Y+uX8mbYLEabwOF4NUtM2TIoY5cc1kZQpnkFaZHdRaNhtVY6hGbGBzJOKTHZhf
 GdT9Uquk3e3pwFwr7no+bs+9y2Oz0ZtGJF7kHzC/+KOi3eOWoo0yosxUmJzSTg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] firmware: scmi: sandbox: Fix SCMI reset domain ID
Date: Mon, 16 Nov 2026 12:05:27 +0100
Message-ID: <20261116110539.3394297-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7eub8uagj11315our4k7hn1a37k6ni9r
X-MBO-RS-ID: d583ffc2cd1106ac935
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

ARM SCMI specification DEN0056F 4.0 chapter 3.8.1 Reset domain
management protocol background states:
"
Protocol commands take integer identifiers to identify the reset
domain they apply to. The identifiers are sequential and start
from 0.
"
Set the first reset domain ID to 0 to match specification requirement.

Fixes: c0dd177a9986 ("firmware: smci: sandbox test for SCMI reset controllers")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/sandbox/dts/test.dts                  | 2 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 895ecb97e87..47793d7ead9 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -2008,7 +2008,7 @@
 		compatible = "sandbox,scmi-devices";
 		power-domains = <&pwrdom_scmi 2>;
 		clocks = <&clk_scmi 2>, <&clk_scmi 0>;
-		resets = <&reset_scmi 3>;
+		resets = <&reset_scmi 0>;
 		regul0-supply = <&regul0_scmi>;
 		regul1-supply = <&regul1_scmi>;
 	};
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 832bfb55711..9cb7a560451 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -86,7 +86,7 @@ static struct sandbox_scmi_clk scmi_clk[] = {
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
-	{ .id = 3 },
+	{ .id = 0 },
 };
 
 static struct sandbox_scmi_voltd scmi_voltd[] = {
-- 
2.53.0

