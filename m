Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53690C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18CA830B3;
	Mon, 14 Jul 2025 15:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="tLi6jUHm";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="i/D5PXpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BBE83045; Mon, 14 Jul 2025 15:34:57 +0200 (CEST)
Received: from a4i432.smtp2go.com (a4i432.smtp2go.com [158.120.81.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75FD83061
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.rgwb3s6cjhho082=oyqmey2bls6k=lxkrsflbjyb4rl@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752500094; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=b7SIyb0OogRqxO6U0LZv7ygSuEozQJCVmQSpoeSHuy8=;
 b=tLi6jUHm9OP8YJccEIbP25DLTjbpB8Vd5fqlQJTzchdaKMFTAalBpRhvFVFEBl+PjCrRo
 ZLiFvaujpeOy6Q9ptzXYL6wHR1hQp/9nwvrJSm7fHGg53BIQo8VJRekDtW2T8pZCx7SNI5u
 Gqx0FNY3WGza26wFbnQ/maDyID4DwK1+wSI6ughHPmceq/Ccaec8jN5r+ylj4ORt6FZbAmH
 egzi9dMSV9oqrBGNR2BvhW58cj5CKghOkQbs8eYgEZePNJOCNZvvHl0Xo30SS0fMUHRg4a2
 Z4QzSa8aS8oczh9sncn5rW/dWximq7D4d9oGUpwHvNFl4Rr7us7mbVXuRMzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752500094; h=from : subject
 : to : message-id : date;
 bh=b7SIyb0OogRqxO6U0LZv7ygSuEozQJCVmQSpoeSHuy8=;
 b=i/D5PXpxFMNSL9MmN6EmsQPAIgjFaHT8tjGCP11ZggQgZNKLnkb+MuNqVYsuzKkOgbtVN
 a6kKonXgmZF4Gz9vOKAiWi6LePycsEgeMYzikqpf7HmHO6XUCyxWABBp/SjDFam7MZpMBXV
 +wIDd50traE7qUhD/71OR7a9o7gNk9qMonwsPoSVJ4SmMgJ7QcrKi3TYViV2s04xNOtZeKD
 A0MRnk0ft5138u0UqwBKVW71gBgkEIR89YXSHl2P3wVCC5ixOkMGVpnunJTQ/07o/M0ihuW
 7vN+Es3EjbHyPWfDMVxLCfVeB+K9mAMcIek6DSUo5ukW9KmAqhoPmkA3T1XA==
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.dynv6.net)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1ubJKL-FnQW0hPlLyG-mhdR; Mon, 14 Jul 2025 13:34:41 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] riscv: Set SYS_BOOTM_LEN default to 0x4000000
Date: Mon, 14 Jul 2025 15:33:11 +0200
Message-ID: <20250714133345.128853-3-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714133345.128853-1-sputnik@on-the-web.ch>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567siVwz3a7gC
X-smtpcorp-track: FSgqLfSImPr4.R_r3NkBprwxf.q6GkUwIE8Ot
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

This changes the default value to the most commonly used one among
existing defconfigs.

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---

(no changes since v1)

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2ff6f003738..54ef7052c5c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1057,7 +1057,7 @@ config SYS_BOOTM_LEN
 	hex "Maximum size of a decompresed OS image"
 	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
 		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
-	default 0x4000000 if PPC || ARM64
+	default 0x4000000 if PPC || ARM64 || RISCV
 	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
 	default 0x800000
 	help
