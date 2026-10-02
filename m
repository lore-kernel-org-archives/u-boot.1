Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8BCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 235F36065F;
	Fri,  2 Oct 2026 21:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QSw17UelmKcv; Fri,  2 Oct 2026 21:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6847760D58
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790977127;
	b=nu1voczpCnVlM5c3SrRbscAlO76u6EpHQz5Aet1Wzte7Zm4pC9PgUMiR4rCdS96OFp0M
	 YmJFNhNEcstL03r8l70sB0tZfF761kuafxHIZGwzCS+2jFjKi2o40c9R8mVqITrPlsnyo
	 3aQIXOOSAs1YyvsN6AUrfrEQgtMkhMzimiDK4Pvxlz80ptGPYcyxtC+oME7g8uGP4co1c
	 AbDAIhsKpkbSibD8Mbwg1k8NMyG77ixEp03yr6b/ZRNyfiHh6c0HcQyAQVpWZ3W3A5Wqx
	 pwD5gqzDn9NvrDlRleIFQTaOHKXd4Fr1wpdq+I3b8F6gLv3IE8212wW2jclNQUwg7UA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790977127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=4k3FgKGfk0qOJwcbjWYE3cNlfAE5FcFxu3xpZCFX2lo=;
	b=eRBy/tvUYpW+nCPeUtcuiUOLtuA7YPSIuXIxRoq9MlFU+ZsWM0owNK1/05jnG+dBjbLI
	 Ha4js/vWqSJaUFxlhr2I4DAwKhHIzlG7ai+QJvDQ6iykWrKidF96bTVB4EFcejtiQmAib
	 6W4gKLATqo/tzQZDy5Vcnv26Y+HwOdfZzdAAswBZ+RtrRyFJS2WQ2rw+Qw+CGCV/MQQH4
	 OubXKmI0nET2VBxD/N6/eggS/bwonKm+TTvmtPSshQvH1v7VK5i7cJwjKUmVZlA9tpZu6
	 zq8qqoZPVYpJnRwRxVri9nboHVdxDbn3WcTNb3qOSGdbhfj4nkTu5YFMnWupRRx9fjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790977127;
	bh=4k3FgKGfk0qOJwcbjWYE3cNlfAE5FcFxu3xpZCFX2lo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=ZS9ABg6ddonSQfWGw26Pa/SSJJmsLiiasltlX47cuGp2RsBqpdYVbEelkagyUFMYp
	 VG3vHRpeLbUHORZgI8IdoD1CYINQOzXqF8/AcmXriElfgqHvzDhVI/1u1ozt0czikc
	 fomgx2/2/ok6nAZQbxjmaWZKSjDbG56EeYYFuZy4QHAspT9G0zsgEn5q9W2FvAU572
	 aNLxPLQP197CXR4HtWvS/qOWVCrYMYxbdzHlHSrRa/JWW/xtpfaPD1iPXTR4w+r8sx
	 ny3VIDT+tMkPDsb5FQ070ehVwybps5cZOKfT0wKkT7NCS2Kryzh9jS5UI0dnbxKG/y
	 hmhJ76cRmQCFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6847760D58;
	Fri,  2 Oct 2026 21:38:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 029A02E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBFC88141E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iG_6TegxDFXl for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D6F38137E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976987;
 b=Zgtc4LSP9OKg7fb/hoW0zUn6i3ebOIQy7ZOQyl0dffkmH4cgwSiRd8/6cJhYSxgp0dp/
 reEDSQ8SsV5tPOQDrgdJeUa6bx5voag+V1Q9igvgMHgKV5E3YjOueFxJhKFWp6rjJWx5F
 pOwKX24tL1TO72z0kis8kn6oqD8fH9MJZzexHRMO+7gDG849NazMETikXToV3MtUkJ5x5
 O4/vT3diicuC4zaqyxSFcMm6fJ6fBtC5vqAWs27eWdwANP+nW21hM9RHp7JkzwHEZWoKB
 xCaR2KdkIZY/Ix+MjThhsg/eAOx8HflE6swDhXyLMjq+qAS35483tyEO40XyzicAg3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976987;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=4k3FgKGfk0qOJwcbjWYE3cNlfAE5FcFxu3xpZCFX2lo=;
 b=TasnLusJchg3WpgvGVM/ZrvJlqZCcMzD0KEeIZqb9AF+VRlO38EoZI4jcLXZV51BLIT7
 RJanp7BeIZn70XIo8bhA6PkQDDXT6U+f8jKjrm1d63PhWVPsikMrHL1TC3hZYZ/PxERlR
 rpKzJfk4U5bvoK1zKenpLcrzR4SU4i6+36CQ96tNedQ3iafC3ouKU0FQG5tco88060MIg
 8EWFIz5vo+f9dQ3FYHvqjd12wS28QP5UYX/KfBsiNcCV3GUYew1Mi5VvHvhlDhgxi5lXb
 66M2/BCpTMWZ5mCGKy95upIkSNU1oJ5ECBkqefK280TEm0wLvwk64u3h2Xhpht4orhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Qcmng0bv; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Qcmng0bv
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D6F38137E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:36:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3547040A1E;
 Fri,  2 Oct 2026 21:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C51BC2BCF4;
 Fri,  2 Oct 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790976986;
 bh=ebMirJnZ+oq0/JIqSz0p1LeHrA9UF0iWdnl4yQEDS3U=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Qcmng0bvK9oUr4J9+XPQyL2Av3JAL5M2DawsGzo8AHrOfno2OEKTtu97rTIPNOIO6
 qlQY2XJ0qzfhQSXN0F7U7mobxVFzZr8dOIAQ6t1CFJlXWx5MoDaddemV6EsslJPtNa
 I9QV+mSRhnbs0V6xDtOnbBETcLbucyEVOSVkP7oghalAxHSrY2DR9BZf+EoooAsIj1
 yatal0UsbIJw8BftQveS5LZcjKlHFWSbxoozaakTSJWjRLobTWVsGFdO+GDw4DduE9
 2vtMtimUsnXcaisvL3LchZsldj7qs1/SoFrCQUgUmZWp1E8Fedyagi9jUXr6cdBwyJ
 upaBpcuTR+QOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DAD39CA5FE6;
 Fri,  2 Oct 2026 21:36:25 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 02 Oct 2026 23:36:12 +0200
Subject: [PATCH] spmi: msm: bound the CMD_DONE poll with a timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqEMAxA4atI1hOotQrOVYZZ1Bg1gn/NjAji3
 a26/Bbv7aAchBXeyQ6BV1GZxoj0lQB1fmwZpY4Ga2yRGmOxcrjQNKDOg6DPyDnyeV3mFmIyB25
 ku3ef72P9Vz3T73rAcZzNJIjNcAAAAA==
X-Change-ID: 20261002-b4-qcom-spmi-a3c44ca5d952
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790976984; l=2461;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=XhcZAlmJfd1XOgfLGQ5RB4F4aui0FVa7ft96ZW0ZEi0=;
 b=o/JC8t6vYtNO64vaEK3kT7VtVYTm8RR3MYxug3HIW1NgdYlQEWxgdKCa9o4pOpGWlPltvCnXb
 WKbq4Gv0l4rCoqeUhxa52+5ggRgzlSrSV8Zn69yCc4cR5gAEMh/TeXy
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:38:45 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

msm_spmi_write()/msm_spmi_read() busy-wait in inifinte loop.
Bound the wait with readl_poll_timeout() and return -ETIMEDOUT on
failure when the PMIC peripheral does not respond.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Tested on Xiaomi Pad 5 (nabu) hardware: pm8150l's WLED node
on usid 5 never returns CMD_DONE.

msm_spmi_write()/msm_spmi_read() busy-wait on CMD_DONE with no
timeout. Therefore one unresponsive PMIC peripheral hangs boot
indefinitely.

Bound the wait with readl_poll_timeout() so DM can fail that one
device's probe instead of halting the whole boot.
---
 drivers/spmi/spmi-msm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index b89dd0b406b..92cd42d8627 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -12,8 +12,11 @@
 #include <fdtdec.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/iopoll.h>
 #include <spmi/spmi.h>
 
+#define SPMI_CMD_DONE_TIMEOUT_US 100000
+
 /* PMIC Arbiter configuration registers */
 #define PMIC_ARB_VERSION 0x0000
 #define PMIC_ARB_VERSION_V2_MIN 0x20010000
@@ -161,10 +164,10 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 	writel(reg, priv->spmi_chnls + ch_offset + SPMI_REG_CMD0);
 
 	/* Wait till CMD DONE status */
-	reg = 0;
-	while (!reg) {
-		reg = readl(priv->spmi_chnls + ch_offset +
-			    SPMI_REG_STATUS);
+	if (readl_poll_timeout(priv->spmi_chnls + ch_offset + SPMI_REG_STATUS,
+			       reg, reg, SPMI_CMD_DONE_TIMEOUT_US)) {
+		printf("SPMI write timeout (channel %#x).\n", ch_offset);
+		return -ETIMEDOUT;
 	}
 
 	if (reg ^ SPMI_STATUS_DONE) {
@@ -231,9 +234,10 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 	writel(reg, priv->spmi_obs + ch_offset + SPMI_REG_CMD0);
 
 	/* Wait till CMD DONE status */
-	reg = 0;
-	while (!reg) {
-		reg = readl(priv->spmi_obs + ch_offset + SPMI_REG_STATUS);
+	if (readl_poll_timeout(priv->spmi_obs + ch_offset + SPMI_REG_STATUS,
+			       reg, reg, SPMI_CMD_DONE_TIMEOUT_US)) {
+		printf("SPMI read timeout (channel %#x).\n", ch_offset);
+		return -ETIMEDOUT;
 	}
 
 	if (reg ^ SPMI_STATUS_DONE) {

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-qcom-spmi-a3c44ca5d952

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


