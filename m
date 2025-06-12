Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E30CC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE1482CCE;
	Thu, 12 Jun 2025 13:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d7XVI6qw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B095A82B7C; Thu, 12 Jun 2025 13:39:11 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681F182BD9
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBd2552850814;
 Thu, 12 Jun 2025 06:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749728342;
 bh=uEg24meS1EWX9gpaYillmSZRp3SPjY75Igt0ZL9tmFY=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=d7XVI6qwyoBu+NauLhE1iH4liO1AlcurKSicRAuOiNZFzn0JP3JkMJYm1bY0DYTOX
 zvB4DvlRw53s3Dbmcpah5X0c6za0F99H549nFI9irpjczzAbT5740WKheedQyWZzlj
 sqL/V3fOfoheICIr2p+1/M9Nt5iO2lcBV0A/ipgQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBd26h1905288
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:39:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:39:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:39:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBd2f01922437;
 Thu, 12 Jun 2025 06:39:02 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 12 Jun 2025 06:38:54 -0500
Subject: [PATCH -next v2 5/5] binmain: include ti-fs-enc.bin into
 missing-blob-help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-missing-blob-help-entries-v2-5-36f1c8078155@ti.com>
References: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
In-Reply-To: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=bb@ti.com;
 h=from:subject:message-id; bh=xOavI7EFFIkG5/FYYFW1FFvYGLRq3urmpOZdWvKeNQg=;
 b=owNCWmg5MUFZJlNZk8PmsAAAbX///7/rv7f07K63P7aX8VW/d/tv+e6Pvvf33nv59rDj+e6wA
 RtqMZIAGgAA0GgMhoANGgNGgNAaZNAAZAaGmQGjTRoAHpAYTBGmmnqaMJpvSIg0aDTEaDRiaBpk
 0DQAGTQaDRoZB6Q00DQ0ADRp6gbSNNGTTE0NBkaaZDTTQxDQ0ByaZBo0A000xBkMQMQYINNBgQA
 AGAgxMQ0aDEZNABo0MgaaaAAAyMQDB1gU+HIRKhVESNpHc1EHIkSR8gFWr1Inx9B8lfjBADokOs
 B3Qwn8OV1GPz2Q464GwKm9d7l0Yag+CMBWH6ilhXyueODIj3jfkAgolgb80nfiXwNQXZpgOfsnF
 T4PX4RbFMZ9adDRmtrzbuB7rZPBIgLYQd9tmcNrTCQIwTjlYh9cod8aP3CWFvxuf/gzUpD1zJ2i
 T6+Udf+WAnbhfNxZg60yeNUeZv6SqQDxwHQk1eNxglogR78qdYfQ5cug7iLVCmY/zdfKCAaZyRS
 SvvFUXSk07BmgZ2Cpr7N1loPvQxCG5XIisYMOMjgukdXIQC67EjkMmXbIzjYyEbuIUAC54AjXUY
 TzRjRSYrUaVgkrQpHueg0belFuMsWBQYtG0hlWpe3TYPwmhjil/d4gGAC1/Fc9LvlAmue8lVWwo
 4DgBk0IZOhv7/F3JFOFCQk8PmsA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Now that the TIFS firmware is marked as a mandatory component to a
successful build, provide some helpful descriptions to what it is and
links to more information about how to get this needed firmware.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/missing-blob-help | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index 3b16a9b1679c4d3003da08c8a49c7acee2293538..d2ed35bef4d05abbb3a8e54e5db524e848676c53 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -70,3 +70,14 @@ Have a look at your board's documentation to find the latest version of
 the DM firmware binary and how to include it in the build.
 
     https://docs.u-boot.org/en/latest/board/ti/k3.html
+
+ti-fs-enc.bin:
+You are missing TI's Foundational Security (TIFS) firmware which is
+critical to provide foundational security services like authenticated boot,
+and firewall management for the SoC. Your board will not boot without
+this firmware.
+
+Have a look at your board's documentation to find the latest version of the
+TIFS firmware binary and how to include them in the build.
+
+    https://docs.u-boot.org/en/latest/board/ti/k3.html

-- 
2.49.0

