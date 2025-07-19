Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE06C83F27
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 23:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9193C8334F;
	Sun, 20 Jul 2025 01:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="gOM+ytsH";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="kQOj0UIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88CC1836C3; Sun, 20 Jul 2025 01:24:37 +0200 (CEST)
Received: from e3i311.smtp2go.com (e3i311.smtp2go.com [158.120.85.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90B983096
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 01:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.ntqud2use1umsm3=lrvebj7cu79b=0br6nt6xyn0bwx@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752967464; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=OrG1qX66eg3BXCYv5AmiN2zNq1q+rR67evZpbrk8JuI=;
 b=gOM+ytsHqvLdvtTOUEGvr5VnqTyNHL6v/IJ3j2LH/rviRfcsZRa5AYIR7wg0gXBhZKWF9
 dk6Yiz6RA7eE6+rD/UjFm8PMWbUvYwN5ndr7gqpK7vm1tFISWo3aNxfvdoOqQjhe5m6RaE3
 3IImgTxCgMD8lyAC5DzlXkSHjSe2H+NecujtJP8+fQWBeh0vTG935BROCcJ7Ui3bX7GWO/d
 kPXQ3ISHZGCpt5Xg1ALrq4r0D3zjzsGi0kGxGuWWn3lI64h1iVa/6Le3mYhhCOYYoZCMrBZ
 cng299Gql5UGgAKxn/vBIwtIhS3rwz+h0Ng1kHBZR3CHe9kb7b5TOWj6XksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752967464; h=from : subject
 : to : message-id : date;
 bh=OrG1qX66eg3BXCYv5AmiN2zNq1q+rR67evZpbrk8JuI=;
 b=kQOj0UIBVb4MY++yBgcZ8zUDGckZ2a5XIlcpdYmdSUph+1nsRvC2vrnOeagw396Bl1xoY
 CFmSuN9PFjHV0vceS9Hm5Zy48gzisP+C6UVNMPvgehbM9nMGFiGRBypq4PqXDViEWnP8cFP
 WW58l783ahflhDUVLOU93CIWOnKEYHfeV+xTZ58ZpUm+eFRUHfAhhIroGwDk4hoh3vtAKNP
 yVzqtiVgWUcy5WKZkRWJdNurne7Trp/AWJy85AXCcPbeadEnZZD1jsTv5USAUwoLAMSq9xA
 UdqE58hYfmNft42tUx21DstpnzgyawfKkETyts0qQ4qUlhawjkkM1iExfysQ==
Received: from [10.34.231.120] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFPI-U24dJf-0B; Sat, 19 Jul 2025 21:47:48 +0000
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.home)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFPG-FnQW0hPvgzA-o7oU; Sat, 19 Jul 2025 21:47:47 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] riscv: Set SYS_BOOTM_LEN default to 0x4000000
Date: Sat, 19 Jul 2025 23:46:33 +0200
Message-ID: <20250719214650.214931-3-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250719214650.214931-1-sputnik@on-the-web.ch>
References: <20250719214650.214931-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567sbw_ypmfcu
X-smtpcorp-track: PG2Gh5h77qpl.2v6LYJiaDB4Q.lbL3lA_V5II
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

Acked-by: Michal Simek <michal.simek@amd.com> # xilinx_mbv
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

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
