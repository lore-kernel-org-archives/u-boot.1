Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F0606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iJ9q9Y9R;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uvqxm4/5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 894AC81194;
	Thu, 26 Nov 2026 13:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahNxr2JJVZfr; Thu, 26 Nov 2026 13:33:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8589C811AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700022;
	b=Bq4oFw/Q5tFZ7r7wfWfSzw9CNICg4WWiKxJEUa9OBRA+jpkhgaNBYFgVOTLCkJ0eoyzm
	 Aa6WlTGrkEtXGSTCrZ0soQOJ7LI7C/H0TZGv9ZmS+BYswiuKoApUR43h0b6kpQj9b5LFc
	 ohvP0jhbv0heysRM6hUMrD5FXXSMds9F9BeNeewHBrP0eTgmSfZWdTgglp0z8b7oH0Jwy
	 n1RLS4zzIF/Mw/BV/kNVo+hN6C2awH6dvH9D7pgRbXhkVkXJXw3iEfdMxF/1yxmt37Now
	 MtFMSIZLkTP34PBkia4+toctpt8KRIIIaR59nLRPa+T3C3IP2ZzegkSQnPOm9hF079Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2PghuVBu74y0e2hJuiWP3ty/aww/CXV91XPB6j5lV98=;
	b=VRXLC2lcXV2biBQJFDmSGvnAOXV38FyV6cNjS1fjpOAqDHJJe8gn+szfiRsTF+9epLBr
	 SQ05mF2jhzR9mRkrBkCNjyx4DYKHts6t2JYXWMs8SlNAt86Zh3OjyLR6IE3NE91+sBJAF
	 3k6XD8hGN/8zsvzXDszk/+pEWKxLaPhfSvwTOpH8VcbQhoYASdQur0pVsaTY5ezEiJKos
	 GGylShejUQP3FXS1nUBDN3+5md5wubnIP74tmexn2Gu+FdsZRoOsM/3p3LYh4YlN4UnnS
	 dGP0Oc/MuJoKJf0+yppRZB5rDkkjvd7DdnVE2whtlYSzSdLD7mVflM30Q7xXslPMRVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700022;
	bh=2PghuVBu74y0e2hJuiWP3ty/aww/CXV91XPB6j5lV98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iJ9q9Y9RF8cCNdz0V+95J7jND2pON4P19buksmVDmjXffUeNedK/DDjGUyYKUacHc
	 KdP7yxL9FqlRbM1Z3b0epimCFVhFwimXTPqglRTKBWvUs7ZxdR0csBvh0bX5Fwt4yb
	 HLV5Gt8g7RgK35BiUU6IXAHpq3KjEOzjCoAsCp/679TF0vcNyxCyRiFaIZTDbHdJyK
	 6WBaV5m4upxWDrDvd4fyWqSVVJaqL4pjSENwk+QPY1ExQn3NyGKOrjIFHHqlBGUTbH
	 +c6OcvGaJmtX+UvY2TYq5wgmQDuwU/S8RxjuVjh42vAbnI5XIEQx7LQmoES7Udoyj6
	 2FiUmYaTUjSQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8589C811AC;
	Thu, 26 Nov 2026 13:33:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 027FE1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8653608B0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7tPhT1SjudAy for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97713608AB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Uvqxm4/5
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97713608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:34 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso3958323eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676013; x=1796280813;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2PghuVBu74y0e2hJuiWP3ty/aww/CXV91XPB6j5lV98=;
 b=Uvqxm4/5NjwmQzRbX85houfYaOb/pDX1U/CczpYS6eQlCP/can40BDZiNVnzd5Jj2k
 FOXXjHpnBmTZsbjtxQjqMuetT73mJrT+wJpeugaPw0l94XnuXoA9hVHBw7phJ+6u4bYb
 Y5Cl1ZTT7JS/kh+J3g11JoiRXMCZ1btWV+uplsrV2zvyGBpE0eWvIUZPogNiFWXaZgbK
 ZCPsUYLk1UcyNpPkBm9Lq8aFwMF0Y3BfTGwagt9oXhgG3Zk/3sPwDvhQu7h0B2NuWKh6
 FmaqEENFaFHnzEGmHCdi/FuPCSkH/J3Dtayklb35BtAW+UM0oGMd0Nm1OwkkGUy8nfUS
 FofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676013; x=1796280813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2PghuVBu74y0e2hJuiWP3ty/aww/CXV91XPB6j5lV98=;
 b=wOqIk9BY8M/Ek9U0C9Uc7z3cn2TIYi0+KvFVUy3TeTFu8ggBLmjs1BmBwdt4sNGWQX
 UIuryG4EmPJFFzCsLc8ZLBTf5v67BOWHopFDkX1dMDB5J6lnoP8x3QcQ0VohM7nBlyuK
 huI0j8mA2L6wGtdfPV6cDZiNHzuYrJDq2k4h0RenroxkWFzBTHZuvnhXLFO52W3F3aAZ
 jWbagwqg1CGu+JFZFxKAy3At5eyLfL1ibss6TW9//ipcW372pWZ4AeoL/arOCGT+b05y
 0MpUWSfyDGHthI/JKF8fuhZU2gCaaPzFny9uhbkuePyM3+8Ar448di2msunyM/OZi7X5
 Z0ZA==
X-Gm-Message-State: APuU4Z+WyUg2SY5QRHw8oL+B0RckybYnjO3yDq61dCJi1XDdPW4ij4V3
 vRrkpGOl8Iia0Q3PhJ9ctHjd0bbHT6OzdPGfttD1dbNYK6dxnbJd2+Rj
X-Gm-Gg: AZFdTZeU8dQuaMF3gdP4hnAlfavsIitNs9cXKBp3AOeoXzX3okMuHWmgnr0ITXLvv67
 lVGVksTzlcEfv/mO4KSOD6T5g2OXJoj+pYYnhEWpIYN8Oq+rVRBCxJhs6RJO+ASAG7x6JoWQgxH
 7Em1R0cUloy+iEjYglwNsrHoMEmZtWREzvbxdRDsLt1nOOE2Zw13VBmU3T1h5cHhug45X64pYi3
 3W8EgcHvFMp70tJ4U/hucrkehX7vXQvRblqDg4YgoGIwWPDPMfw2SDRRk6YOeukvu5AQ33nr+Cw
 wwT8AhEG4iws2nt2CpAvecSHDn87lf0OyGgzh+yJ3yJCEpmW64RY3h4gSvr6w+zYnU0TyQfCYTN
 el4SsJzKcazZFauincqBoc4krE60fNU5/Er5b6TIOfAKZc6Ml0WYnO5M80N0F0LlhY5to0raz0j
 /Mlv1Vkme2HQF5DlR+kG+fHqOvqdlUpxBos1EkQ6Nn8F+lOK2bLpZ86zoshW4h56CKDFz2n72K6
 ghuPQVpYxAPcxVLx5grHGphY60I3C6Es9Ezm+UfjbeuUQkuSGBu5fwqhN0hxERR/1TmxdgGBvjh
 gODBjEBW9dnjJuJDsfCMmrQzJgY3uRTXM3sM258qV2iSMhJ5FrAWJoJsWXehaQnfyUVa1kd57j1
 lztXKDgf+18AbbKs1HznOLUdZWBcZ08XJUxiuGtsNSUzAbkDGOYkyFsk81nq8KTRi1Tv43lPtjI
 0lDlNMxBxtuDbaXTHRKQT9StqLChrTJ/6kEls8iwn9mD1fU/IFv/A=
X-Received: by 2002:a05:6820:1344:b0:71a:ee95:bfc3 with SMTP id
 006d021491bc7-71b3947b87bmr14912223eaf.40.1795676013192; 
 Wed, 25 Nov 2026 22:53:33 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:32 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:02 -0700
Subject: [PATCH 13/19] spl: use the known file length for raw U-Boot images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-13-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a file loader supplies a headerless u-boot.bin, SPL may request
more bytes than the file contains and reject a complete image. Without
a size from binman it uses CONFIG_SYS_MONITOR_LEN or a 200 KiB guess.
The guess can also truncate a larger file.

Pass the available byte count to the raw-image fallback. Use the exact
file length within the configured monitor reservation and report an error
if the image does not fit. When binman supplies the expected length, keep
that length and reject shorter files. Loaders without a known file size
retain the existing size selection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 common/spl/spl.c      | 49 +++++++++++++++++++++++++++----------------
 common/spl/spl_nand.c |  3 +--
 include/spl.h         | 20 +++++++++++++++++-
 include/spl_load.h    |  2 +-
 test/image/spl_load.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 22 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..10c495f8766 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -259,16 +259,10 @@ __weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 	return map_sysmem(CONFIG_TEXT_BASE + offset, 0);
 }
 
-void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
+int spl_set_header_raw_uboot(struct spl_image_info *spl_image, size_t image_size)
 {
 	ulong u_boot_pos = spl_get_image_pos();
-
-#if CONFIG_SYS_MONITOR_LEN != 0
-	spl_image->size = CONFIG_SYS_MONITOR_LEN;
-#else
-	/* Unknown U-Boot size, let's assume it will not be more than 200 KB */
-	spl_image->size = 200 * 1024;
-#endif
+	ulong expected = 0;
 
 	/*
 	 * Binman error cases: address of the end of the previous region or the
@@ -279,7 +273,7 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 		/* Binman does not support separated entry addresses */
 		spl_image->entry_point = spl_get_image_text_base();
 		spl_image->load_addr = spl_get_image_text_base();
-		spl_image->size = spl_get_image_size();
+		expected = spl_get_image_size();
 		log_debug("Next load addr %lx\n", spl_image->load_addr);
 	} else {
 		spl_image->entry_point = CONFIG_SYS_UBOOT_START;
@@ -287,10 +281,24 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 		log_debug("Default load addr %lx (u_boot_pos=%lx)\n",
 			  spl_image->load_addr, u_boot_pos);
 	}
+	if (expected && expected != BINMAN_SYM_MISSING) {
+		if (expected > U32_MAX)
+			return -EFBIG;
+		if (image_size && image_size < expected)
+			return -EIO;
+		spl_image->size = expected;
+	} else {
+		/* A file has an exact length; raw storage may have only a bound. */
+		if (image_size > U32_MAX ||
+		    (CONFIG_SYS_MONITOR_LEN && image_size > CONFIG_SYS_MONITOR_LEN))
+			return -EFBIG;
+		spl_image->size = image_size ?: (CONFIG_SYS_MONITOR_LEN ?: 200 * 1024);
+	}
 	spl_image->os = IH_OS_U_BOOT;
 	spl_image->name = xpl_name(xpl_next_phase());
 	log_debug("Next phase: %s at %lx size %lx\n", spl_image->name,
 		  spl_image->load_addr, (ulong)spl_image->size);
+	return 0;
 }
 
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
@@ -308,9 +316,10 @@ __weak int spl_parse_legacy_header(struct spl_image_info *spl_image,
 	return -EINVAL;
 }
 
-int spl_parse_image_header(struct spl_image_info *spl_image,
-			   const struct spl_boot_device *bootdev,
-			   const struct legacy_img_hdr *header)
+int spl_parse_image_header_size(struct spl_image_info *spl_image,
+				const struct spl_boot_device *bootdev,
+				const struct legacy_img_hdr *header,
+				size_t image_size)
 {
 	int ret;
 
@@ -380,14 +389,18 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		/* Signature not found - assume u-boot.bin */
 		debug("mkimage signature not found - ih_magic = %x\n",
 		      header->ih_magic);
-		spl_set_header_raw_uboot(spl_image);
-	} else {
-		/* RAW image not supported, proceed to other boot methods. */
-		debug("Raw boot image support not enabled, proceeding to other boot methods\n");
-		return -EINVAL;
+		return spl_set_header_raw_uboot(spl_image, image_size);
 	}
 
-	return 0;
+	debug("Raw boot image support not enabled, proceeding to other boot methods\n");
+	return -EINVAL;
+}
+
+int spl_parse_image_header(struct spl_image_info *spl_image,
+			   const struct spl_boot_device *bootdev,
+			   const struct legacy_img_hdr *header)
+{
+	return spl_parse_image_header_size(spl_image, bootdev, header, 0);
 }
 
 #if SPL_LOAD_USERS > 1
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index f449b31f594..397fb26c10b 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -35,10 +35,9 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 			    CFG_SYS_NAND_U_BOOT_SIZE,
 			    map_sysmem(CFG_SYS_NAND_U_BOOT_DST,
 				       CFG_SYS_NAND_U_BOOT_SIZE));
-	spl_set_header_raw_uboot(spl_image);
 	nand_deselect();
 
-	return 0;
+	return spl_set_header_raw_uboot(spl_image, 0);
 }
 #else
 
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..2fd99b64a5c 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -713,8 +713,10 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
  * CONFIG_TEXT_BASE.
  *
  * @spl_image: Image description to set up
+ * @image_size: Available bytes in the image, or zero if unknown
+ * Return: 0 on success or a negative error if the image cannot be loaded
  */
-void spl_set_header_raw_uboot(struct spl_image_info *spl_image);
+int spl_set_header_raw_uboot(struct spl_image_info *spl_image, size_t image_size);
 
 /**
  * spl_parse_image_header() - parse the image header and set up info
@@ -734,6 +736,22 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			   const struct spl_boot_device *bootdev,
 			   const struct legacy_img_hdr *header);
 
+/**
+ * spl_parse_image_header_size() - parse a header with a known image size
+ *
+ * @spl_image: Image description to set up
+ * @bootdev: Boot device providing the image
+ * @header: Image header to parse
+ * @image_size: Available bytes in the image, or zero if unknown
+ *
+ * Return: As for spl_parse_image_header(). A raw image uses its file size
+ * when binman does not specify the size of the next phase.
+ */
+int spl_parse_image_header_size(struct spl_image_info *spl_image,
+				const struct spl_boot_device *bootdev,
+				const struct legacy_img_hdr *header,
+				size_t image_size);
+
 void spl_board_prepare_for_linux(void);
 
 /**
diff --git a/include/spl_load.h b/include/spl_load.h
index 31ed5651f7b..6265255f23e 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -74,7 +74,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 		return spl_load_legacy_lzma(spl_image, info, offset);
 	}
 
-	ret = spl_parse_image_header(spl_image, bootdev, header);
+	ret = spl_parse_image_header_size(spl_image, bootdev, header, size);
 	if (ret)
 		return ret;
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18e..46136f058c5 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
+#include <binman_sym.h>
 #include <image.h>
 #include <imx_container.h>
 #include <mapmem.h>
@@ -10,6 +11,7 @@
 #include <rand.h>
 #include <spi_flash.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <test/spl.h>
 #include <test/ut.h>
 #include <u-boot/crc.h>
@@ -24,6 +26,61 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 	return map_sysmem(0x100000, 0);
 }
 
+struct raw_test_file {
+	size_t size;
+	size_t last_read;
+};
+
+static ulong raw_test_read(struct spl_load_info *load, ulong offset, ulong count,
+			   void *buf)
+{
+	struct raw_test_file *file = load->priv;
+
+	if (offset || count > file->size)
+		return 0;
+	memset(buf, 0xa5, count);
+	file->last_read = count;
+	return count;
+}
+
+static int spl_test_raw_file_size(struct unit_test_state *uts)
+{
+	struct spl_boot_device bootdev = {};
+	struct spl_image_info image = {};
+	struct raw_test_file file = {};
+	struct spl_load_info load;
+	const ulong pos = spl_get_image_pos();
+	const ulong expected = spl_get_image_size();
+	size_t sizes[] = { 4096, 256 * 1024 };
+	int i;
+
+	if (!IS_ENABLED(CONFIG_SANDBOX) || !IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT) ||
+	    IS_ENABLED(CONFIG_SPL_PANIC_ON_RAW_IMAGE))
+		return -EAGAIN;
+	spl_load_init(&load, raw_test_read, &file, 1);
+	if (pos && pos != BINMAN_SYM_MISSING && expected &&
+	    expected != BINMAN_SYM_MISSING) {
+		/* The file cannot shorten a size that is known from binman. */
+		file.size = expected - 1;
+		ut_asserteq(-EIO, spl_load(&image, &bootdev, &load, file.size, 0));
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		file.size = sizes[i];
+		if (CONFIG_SYS_MONITOR_LEN && file.size > CONFIG_SYS_MONITOR_LEN) {
+			ut_asserteq(-EFBIG, spl_load(&image, &bootdev, &load, file.size, 0));
+			continue;
+		}
+		ut_assertok(spl_load(&image, &bootdev, &load, file.size, 0));
+		ut_asserteq(file.size, file.last_read);
+		ut_asserteq(file.size, image.size);
+	}
+	return 0;
+}
+
+SPL_TEST(spl_test_raw_file_size, 0);
+
 /* Try to reuse the load buffer to conserve memory */
 void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
 {

-- 
2.53.0

