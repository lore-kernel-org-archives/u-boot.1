Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDA6C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 21:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AEF83B1E;
	Thu, 10 Apr 2025 23:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rqsUHIvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24DD83C3A; Thu, 10 Apr 2025 23:45:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6254683AC6
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 23:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c990=W5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744321521; bh=uwMrnnp+CX6AR9b2YuOyNyUDjV12wrlBn6tuSAxaJt0=;
 b=rqsUHIvxBFs8JnrdhG2QQoxNm0QLt9RlHu6QQ+NeQZm7hIol8VfMw70q5Qia5cX9xPOqNe3/L
 SZier2J/0ht9rjTnk9HqW4a7P5KZxavCRDhsppp2TIhd0HtjPU1hMaf8yGTfxugoTFA+7P4XyQy
 F4Niu0GY5ZbDVKPI4Z7ZH35K06Ia5zbqsNaj/yI5ioUL7hjeocyjMWXu6YovwGeRlyTy6wY3BE2
 LRw5jym8IDdduSn5skHyQZBiVgYWQMKR/TfrHfJgx8uu1hn0ejXjZs4jRmQk+U2u+0qgg7L68Tt
 0iHCJHwTZGEeSUVwkZVS4YpoHIXLzIcxrRtafVJfCSXQ==
X-Forward-Email-ID: 67f83bec0ebe9f861dbcc31f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 1/7] rockchip: binman: Correct the OS prop for U-Boot
Date: Thu, 10 Apr 2025 21:44:50 +0000
Message-ID: <20250410214506.3575404-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410214506.3575404-1-jonas@kwiboo.se>
References: <20250410214506.3575404-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Simon Glass <sjg@chromium.org>

The U-Boot image is currently being identified as an invalid OS in
spl_fit_image_get_os() due to case sensitive compare.

Use the correct lower-case value to fix this.

Fixes: e0c0efff2a02 ("rockchip: Support building the all output files in binman")
Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v5:
- Collect r-b tag

Changes in v4:
- Update commit message
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e508..e9ed1d4b5738 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -50,7 +50,7 @@
 				u-boot {
 					description = "U-Boot";
 					type = "standalone";
-					os = "U-Boot";
+					os = "u-boot";
 #ifdef CONFIG_ARM64
 					arch = "arm64";
 #else
-- 
2.49.0

