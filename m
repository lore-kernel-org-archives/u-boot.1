Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81B8C36011
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 12:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180A181E5A;
	Sat, 29 Mar 2025 13:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="G2OLnU+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1822381DCD; Sat, 29 Mar 2025 13:48:17 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E24C8059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 13:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 603AF3FB33; Sat, 29 Mar 2025 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1743252494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqsLQpnIN3vVdy1eHsDOvk6k9CtY/YJWIDI2BiI1dzQ=;
 b=G2OLnU+qqoo0UvSxoX3T/54DtO6AKSOYzgCjzmtBe6pQlbDSif5z8Ds15WJlBF9VTOuh5T
 CftjFuCPY2VC4dL3HC0L3UE+OH+lyaSh+YTtecWzjmo3OOJhjjCXD9Y9T3HCP2Uydlzb1k
 nFZ8DAbK9xTnd7fragBbv871AWHRL/yZe7QDTh8JTZLNocY7foQhzryEPWaZyDX6RRzm4l
 kRBmUeF1LFfC/l1nxIcmfgxEx1SAyz6+QuieS2RfCyIobZ8cal/QjZBqNt4DvcPF3CZGz7
 UNpdvhJ0ZPQA9UfEMWzLgKPWTWlZEEpvisW+SnQy9iZo+IMdju/yMvEdZwZ1HQ==
From: Huan Zhou <me@per1cycle.org>
Date: Sat, 29 Mar 2025 20:48:00 +0800
Subject: [PATCH 2/2] config: Enable pinctrl in bananapi-f3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-pinctrl-k1-v1-2-3083d7057989@per1cycle.org>
References: <20250329-pinctrl-k1-v1-0-3083d7057989@per1cycle.org>
In-Reply-To: <20250329-pinctrl-k1-v1-0-3083d7057989@per1cycle.org>
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>, Huan Zhou <pericycle.cc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743252484; l=625;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=YNeTY80ecGx2zxEHAw9/7mScc39LE+REIPNiyHBip4Y=;
 b=lB9l7/QndxtuRDkkaQMA2EoimQDgKSXm2uChofzpGwCRP3mt8+1SYQpCFOaPi+fO6XwkMeda7
 xywDPz7eu2/C/q3tC+uWJsWKGYN9VHxfRiLicWdmUvjZJJLi9Cppaah
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add pinctrl support in bananapi-f3 platform

Signed-off-by: Huan Zhou <me@per1cycle.org>
---
 configs/bananapi-f3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index 0f12db3db848badda1fc7192aeb0190ac22a269d..12aa67d4f0de580736c21fc3764125ce17726d1c 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -18,3 +18,5 @@ CONFIG_HUSH_PARSER=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
\ No newline at end of file

-- 
2.39.5

