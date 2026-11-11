Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980B606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yO4FdvKr;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Kq+FYkvC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6427740ABD;
	Wed, 11 Nov 2026 10:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogY13jaAP5vO; Wed, 11 Nov 2026 10:22:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD19C40A8D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392522;
	b=iPT4dv1nTuASF3TlIVJvmMjJYxFoNxtDsJcCBzt82H7IDNnPHhW05hyqExCkmK+HLdxL
	 04sEwzHjqwAIJAOrzvmDMZozGg4c0BJsYTzPMlEl/u+LBoD5wjo0tBeYmlVMeCRR/x5KT
	 TD2dfu6JgEE/CuRaPGP3Q+wfLGiZNxi7PuJs+YVqFTkwTklDbe2HIenqRh7MPUccaD/ap
	 misO2nOpAQA/t0GqbEyTJe46QomQ5mAO0RY20J5vVRCklVBO6SSGcqM1pO2Fo8AJLSPVV
	 ebiOTWqXoZM32H7Fob3PoHYcKnO6CGI00BJxXqxrYUeSyhGHn05BE5IpgDB/2pcu7hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4ghfM53NfZfGS7XIu0SJItrKKYQQK+frLEG+J4Sho4Y=;
	b=sE9wzv9faX6eBnOyHNUjPICTYx0al96VsSGTEaeMt8KJtsZ99KDnqEk3LFOC0uXOaRE3
	 l1hlLekDgRK9Mb3ilOcrGWAa+Chfs88E/DSdrD/dyJaKZW+w/W535XhHbk6Zyg2UDSCSA
	 ImJDjo2cFE+saBsIhZ82b0O45vm9kw1QKdgU2u1PyPOC6zjvkDfaHqidSM+5gCp0dldbW
	 ABLSCckt2mOFUGbRLOPR80IGLMyYilctgcbZ0DHkkjnKzIHbx0ZbiNUW11UPA066yLemw
	 faJCJqRFFH31qVgAnvUehEiEodZe3dve/H3QTcNWgqhgTemaCWux57jwgDl6DQOpTnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Kq+FYkvC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392522;
	bh=4ghfM53NfZfGS7XIu0SJItrKKYQQK+frLEG+J4Sho4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yO4FdvKr6aXU2V30Q1u9XRz/ZLT4eBEHqKdvMW2yJMCRLLmKM4nFI0L7Cnyw1URHL
	 PCt1jjpeQ6Qi/KclYjO5nXaTfOaxMKvbpi6bY/3KEMnRfyUgiQKlGQTvuh+F0AyDbo
	 X1m0M/FbP44yUohYh+NZhndxmebm/4KTt5npdy7duSrgnJJm+toU3aQEwulJMgRmRt
	 FNStvlLEYPODnysA5jqSHw9xy9vq3x09gp6QGPq+ZB2SHUuI0+0Dfo6zaHx6jnpzQi
	 INQ1lONHo6LnytlLJdncWuCfz8OV/B9zcPLwPds7EpwB02uomYbGLB9adi95g6vLSp
	 fXB3JtjnLtQCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD19C40A8D;
	Wed, 11 Nov 2026 10:22:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FC94731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7730840AA3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BQXzIzGtRRd for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F068640A83
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Kq+FYkvC
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F068640A83
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:53 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so1961224f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392511; x=1794997311;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ghfM53NfZfGS7XIu0SJItrKKYQQK+frLEG+J4Sho4Y=;
 b=Kq+FYkvCnM+ffJ8+xHTWqdPhkfOGAm9Q10MpR5l5BWKJMTV+DutpV9nsYaKVW1sXtw
 eLE26HOXFaN6oDK9IejRuwicuroa6GSsUlRkxO3WmJJ49M1mc7BaMKTXOtlAjDPrTSTu
 4FSSjCmUU72rAh0P3KNtmY3jCXeFYYAFUDCqnSh73k65tIFqgkIklxI+irLU0XVbHDV2
 USEa4mLcc7KHjuUD7L4tpqzwT0otH3TPvA4nMfwuns45WFZkGwvYofrKfyT1Qzq2RByC
 SMndRXiKhs+qsp/ypQr/UWc5qDcPlD7xjhiZ+uZDkI27V/EwJyzJDTfsm4FdqIP0z0zT
 fbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392511; x=1794997311;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ghfM53NfZfGS7XIu0SJItrKKYQQK+frLEG+J4Sho4Y=;
 b=F8GTYRz12PM40+foK1KzFu/nz+envstnYE3esoLFV5hycwt0u11cKnfDNOeXwYYXNh
 V3OjW5Y8TFbd4N66Dn+Kn5/rO/EWpGV+/Gy6D++El9JHnChhvJmoP7okibRJZVUeFP/3
 XDkRyXxs6lDrTGJg8Sx7MXjgaWve3p653PcgS0VJEAEbInp3PPpbl18nb0YtjAp2SpAv
 syV9ZQpaydDr0X75QesaX0L25fLKaX5boWwSoVmyp+/0Eh0nEwiSmDTiYw9Z6Z73bjV5
 46CzmuYA7ZXiOm46Z6fvmmA15dsL7I7HRMIj4eX5WrKThHiKZ1U4F9iiurRkwphRpQaG
 fFUg==
X-Gm-Message-State: APuU4Z8mHy48snrLaEOL1ZPom1EbAFgf1msilrbOa2I/rh2qSr2rXLgZ
 /knoxWTnby/u/nPbHqDMhvfq9H7oesS8Lqr2P2JlYOufyMeT0EQe09ghhr85+GRHKYg=
X-Gm-Gg: AYBFou1JihCj/j49V5HMBnnJVTa4w+qfPbE88S6xb9wc1d9W6X/+KTJFxG3QtwNpil3
 OIlq4qnQPT+6xCleDF2I6HnKL6ubT3erqiq3/eM3dX0WC+mKyPOEL3NYCSzUUJKIYSzrS3iI30y
 IVguKF7+T9bkUGTdmye5tBFXq2uPmSNvB/KAYsT4b8XRDuOLyGzQJPkeic+xMz7F1lTHofQEfuX
 v8WU4VIcrcmq2cong5+X4cZVYBcIQGPUC/dwzM/t2PkE9oIkqVufPW3t+Ovp7pEUuW1hVQXVrZl
 EJY0asntCK/Jlbzeg/lhvFQg9yiFVs7IqyI/6N4GCOiwvu+zUPGNo2R1qpEfyIoKiqy+3Rjp9ka
 CG52sYBt0R27mFqQB0Q+CDRVeiB6aZGc4AAW72g+OvUIIjCIRk+Ul3CD2O+6EnnbQF/PkftRYyl
 ARtXpA5zP+34EitSZuhwKoeMwWYfUEKyMg2ELcA/0Fo9fKBd2L1LHwgynV6TP81JviZL5gICl3G
 h7buMBqB5JV/IiwaBYdyaxjYJ52j8AVvjlHXnad3aQ9DgDXuwOVvXDnZftt7PcOTh7sYVICiy7u
 csIRUxGcWn6ZxwTD/tCPAxgiQ2lzjwujaxbc+fxUgcXfEABm7bEL+cRz2eSRFqWF2og3oB/eqFQ
 IX0BaIaRZ3hV9SIk636gG3H15znX9oihCk8awCfDPs7rycQ==
X-Received: by 2002:a5d:64ed:0:b0:48e:6f76:dea2 with SMTP id
 ffacd0b85a97d-499c69cb701mr2838692f8f.38.1794392511493; 
 Wed, 11 Nov 2026 02:21:51 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:50 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:39 +0100
Subject: [PATCH 6/7] configs: add a Genio 720 UFS configuration with OP-TEE
 RPMB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-6-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.16.0
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 720 board already provides a merged UFS device tree, but its
default configuration selects eMMC. Add a UFS entry point which reuses
the common board configuration and selects the existing UFS overlay.

Enable the OP-TEE client and Qualcomm UFS RPMB transport on this UFS
variant without changing the default eMMC configuration. The device
tree already describes the secure firmware and its reserved memory.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8391_genio_720_evk_ufs_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/mt8391_genio_720_evk_ufs_defconfig b/configs/mt8391_genio_720_evk_ufs_defconfig
new file mode 100644
index 00000000000..47904f93e91
--- /dev/null
+++ b/configs/mt8391_genio_720_evk_ufs_defconfig
@@ -0,0 +1,7 @@
+#include <configs/mt8391_genio_720_evk_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk-ufs"
+CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk-ufs"
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_SUPPORT_UFS_RPMB=y

-- 
2.56.0

