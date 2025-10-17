Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0FCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DB6839D9;
	Fri, 17 Oct 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="DwSWxgX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0678383F; Fri, 17 Oct 2025 17:30:03 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D6D83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id BE4932629C;
 Fri, 17 Oct 2025 17:30:00 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7FY8BwOXTkoS; Fri, 17 Oct 2025 17:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760715000; bh=gvRvLSQY2K8/TDjUx6ppUdUexDiRLR8TISv49uVy0+k=;
 h=From:Date:Subject:To:Cc;
 b=DwSWxgX6PmWTo8CzF6Q7wUOpij6iDKxcelLm+CEflIeEoEqu5VJp5QDfhO3QQPDDr
 nvr4/BlgAAWLbOczN4zBPXZ0qGJiF90WAA8KqOD9K1aQ94mgXfH56p74JDkFR/tetw
 YcjoCb2/lEx5msbnioQ0Xrr7WmWnwgriTqczNYSgHzrCF1iC7OulVdgop31SL8/0zr
 qxduimrOzYjQkXAjK9QShC/Q/Svm5/FpiZ90O5sB0BlexHWwKX0nSC1IJf4FqZht+Y
 yvMQueu6TfoWtv7biSGP2f2+UnGiK0vUN84xtOsovM5NaiE30AJP0T/LCTsYQtRWqR
 YrUPAaPOC0FOA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:59:48 +0530
Subject: [PATCH] soc: exynos-pmu: add support for Exynos7 PMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org>
X-B4-Tracking: v=1; b=H4sIAOtg8mgC/x3MQQ5AMBBA0avIrE3SFqm4ilhQg1lopRNCpHfXW
 L7F/y8IRSaBrngh0sXCwWfosgC3jX4l5DkbjDKNVrpGCQ6P/US6Hx/E4qLa1ppKT+PkIFdHpIX
 v/9gPKX0M0UEuYQAAAA==
X-Change-ID: 20251014-soc-pmu-exynos7-f0887231babc
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714995; l=1060;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=gvRvLSQY2K8/TDjUx6ppUdUexDiRLR8TISv49uVy0+k=;
 b=sO9yPJkHdCeyDp40CdfMwPxVppQG0tt28xaQc6l/kcGF38m8OKxeAsPEOL3RWZjBPxzZjfDVw
 YdABl5zTb/fCXcFPXAkjVTjNY3Aw4uXHn4XlXHJ7YGRmUgmXEJ2gnTM
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add the compatible string of Exynos7's PMU as defined in upstream
dt-schema. This also supports derivative PMUs as defined in schema.
There's no additional setup required here, so pmu_init is skipped.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/soc/samsung/exynos-pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 233ad4a908f5469e1ef210ddba6d7ec573fd4e15..0f533bcdae52adeafba4790e50bcf97ed34fc606 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -85,6 +85,9 @@ static int exynos_pmu_probe(struct udevice *dev)
 }
 
 static const struct udevice_id exynos_pmu_ids[] = {
+	{
+		.compatible = "samsung,exynos7-pmu",
+	},
 	{
 		.compatible = "samsung,exynos850-pmu",
 		.data = (ulong)&exynos850_pmu_data

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-soc-pmu-exynos7-f0887231babc

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

