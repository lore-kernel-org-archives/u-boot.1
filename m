Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F2FC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B19B81A0C;
	Tue, 28 Jan 2025 00:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="izEc1jCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 506CB8197D; Tue, 28 Jan 2025 00:03:40 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A765B8198F
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738019016; x=1738278216;
 bh=mjYXNl9IXxOK0TKIc4XQTjR/ZWXrKLALbSlOyEgk5QM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=izEc1jCG7df7L4tEj/oXyNFbN9SoYxMzX7I/E2g9+sIQlYaWZTiE60tkSNCGp3WKX
 GuzcSzFTRKlaV2Zpu2WKLjw8NeVPlu4zIabZQeEJhQ/7be5AJA+wvcBhrwbPaICd7O
 /i3qR2RtJOpiTjjn4Btio0uLjoIgxFEvx/rml0TSAWuVjDyTripB49l/CXLxbDK3Dl
 LY1f64NeUTsCPtb9k9xrB7RS1b6Vu8vN79hkiD6YsrFy3P53t4t6H+a0mjEXCSCl4h
 4LE3PP4DsEOGdUpv4uwaRQ33/4kJI/6q3hUaAvoK2h73gXGZqJtY35Jea7Tm8+Zdcv
 /VOdf7P79hvsQ==
Date: Mon, 27 Jan 2025 23:03:31 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 6/6] qcom_defconfig: enable spin-table support
Message-ID: <20250128-msm8916-smp-support-v1-6-39587f18cf0c@samcday.com>
In-Reply-To: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 229d477731badb2e408e3dc97a9720cfc7e39e05
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This is used by MSM8916 to bring secondary cores online when no PSCI
support is available.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e4abfdf16bb50503953b79fcaec1263c6b74f41f..c5f0e33fe7cbe69419b80a1a487=
ad6aac76d8ed1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -1,4 +1,6 @@
 CONFIG_ARM=3Dy
+CONFIG_ARMV8_MULTIENTRY=3Dy
+CONFIG_ARMV8_SPIN_TABLE=3Dy
 CONFIG_SKIP_LOWLEVEL_INIT=3Dy
 CONFIG_POSITION_INDEPENDENT=3Dy
 CONFIG_SYS_INIT_SP_BSS_OFFSET=3D1572864

--=20
2.47.1


