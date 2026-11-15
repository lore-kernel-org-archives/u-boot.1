Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1D606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B4j3qYB0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGvDXLkf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E632606E3;
	Sun, 15 Nov 2026 03:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zNBnOOzXuBZ1; Sun, 15 Nov 2026 03:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FDD46073F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794714645;
	b=D0gvgFBBv5tx8Fe5XOW2lcoyN5KegdtiD9AcIzEsdFuQkpTVXQDUCVrynoy8nGml9O5Q
	 fw2rrAp24PB4ij/U7vwmaBUhuCOgN/flpWwNY6BEQ1grXgmcM+QxrSdjlISV19cnKtHpx
	 kdRj0jUtQcedx3feFVPM8URNuGg9OJnCQx5G5eZe3QH1rFL+IeQBd52ke32l7ctcLAhuz
	 RM90VTKgIREqcp04G8r8TO4ttmRuU/JNdLLF9hETX00WQq9FrStA0+AG/w3ZALHXEAD6l
	 b2nMxynvlbauWDe921OS9uPEVRT57SQKf24x0MTovKuMZTkzG6NGWnb5sd4Yzoo1JEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jzBHawrSi2BsPVL+Ic5A72BcVVlzspUs+xjYOYJxrdk=;
	b=devEpsZig6c+KdhXwpmkcd7pgvuYowKINdfMMoqF+3XDEJAJH+ZXZvltZus57cBaf/xq
	 xFzI51QD10aIX+pAiSN9UoGnT0KzZwK9tbiUZX0+v5BLw9j63BnSZv/1ofTurDvZVe3Cp
	 DiAfi6ADqQf9FUBLeJ0FIOvvUsePPuzfhRcFjxLMkeLXXJDajiLUI8mXYWp4IsVAcMFbY
	 c0U4Oyasznfl6SddgQ7ONAGp0NMY1Z1DOFrlkvFTIU+mdmypnGofqo7tGw7cdVP6lOZgg
	 sHjyOPoXFzoRgHIA3taqyOAUjSierjrVoD2uMFCdPeyvw+ZLjoJ3V5jTI/pSJ9Zb5sA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGvDXLkf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794714645;
	bh=jzBHawrSi2BsPVL+Ic5A72BcVVlzspUs+xjYOYJxrdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=B4j3qYB0iQ24hpJbaCmjQpfK/AaHQPlkHQtvHANpIqs3oKBw0J1t/RmQtKHbjJUSc
	 G17Bf2a6Gur8cUUUi5VU2iQihQ0Y/glaTmooMIUG2SAsVHkWevWnHksamtmSXltrET
	 CAsM/Nd8O0lTD0/Ouwi7S2SvNs8StOv3Zu5ldQsL1U32w+ZCnoe/neRah9c2OQTpaw
	 IYRVxPd44cdpw9SxhkrWk/cRcyR21/zI957hCmEhGJzUZ2uOfEt1NvFFPH/cVgrvKA
	 DY83MrGm1Xk0aCVoNMkY37cwOFG4yfhucBexULCnc+eQdgNdc31b3ykhQUm25KSxsR
	 rbVFyyYJRdpPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FDD46073F;
	Sun, 15 Nov 2026 03:50:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6620A2FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57F13606C6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Om-UrszIFQGr for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 03:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83137605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KGvDXLkf
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83137605EF
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 010AA6184A;
 Sun, 15 Nov 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 081CE1F000C7;
 Sun, 15 Nov 2026 03:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794714634;
 bh=jzBHawrSi2BsPVL+Ic5A72BcVVlzspUs+xjYOYJxrdk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=KGvDXLkfwAc88yLsf5YoeA1yBxVlaQNmztpMwyWO3Al8V3AJE1acj5C2M+eua031i
 br+xyb5BMpjCsiVe5NwFj3RsWJJYZ5XZr9pQ0aQj2wDnqU9tmiYXMxX8ynJo4zew7L
 AKjE8cK/Yr01LbppUpc8+JIX44q8meupfLrrz9b86VDl5kOqTgsTgL5pyGhR4UO7PE
 WdwCXbJdIYvVOd01BSgl338mOhq0R4Ux5SAw+Vhw9JTdAvW+brRsJDw/P39XlQUVQg
 JX99sMSHEDPdPM1b6np+pydSrFDWZSrQh9+usDgL16wGimxSuwfODfgK/o8uMIapUO
 rSgeET0EBUFqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8AB3449F61;
 Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 15 Nov 2026 03:50:32 +0000
Subject: [PATCH 3/3] configs: odroid-c4, odroid-hc4: enable Wake-on-LAN
 from suspend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-b4-meson-scp-wol-v1-3-80c3e9f4deda@iav.lv>
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=TR7+WSUw912x4EZh77Z+Wcm/UCk/rDcRO5KtEgwiol8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/dTgiX8SIPuY++9jozibj8weXz5lx9O2Bp++28Tcoa
 YYFe92Y01HKwiDGxSArpsgy4ZDGrYwlV//6e5g/gJnDygQyhIGLUwAmUj2X4Z/u4qVr2R973hUN
 +una0cPo8ftPZuU1sTnL03pm/he5vzyJ4a9Q59b8bzkfdqterz1qoyyiniC4NMzo76brqxguVF1
 u+cEOAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

Enable CONFIG_MESON_G12A_SCPI so that U-Boot tells BL301 whether to
wake the board on the Ethernet PHY in suspend, and describe it in the
board docs.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 configs/odroid-c4_defconfig      | 1 +
 configs/odroid-hc4_defconfig     | 1 +
 doc/board/amlogic/odroid-c4.rst  | 9 +++++++++
 doc/board/amlogic/odroid-hc4.rst | 9 +++++++++
 4 files changed, 20 insertions(+)

diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index f42fa0789d6..55e62f7f1cf 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-c4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
+CONFIG_MESON_G12A_SCPI=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 694db0684e7..1d18070d265 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-hc4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
+CONFIG_MESON_G12A_SCPI=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
index 6994b958cf8..2df7afd71bc 100644
--- a/doc/board/amlogic/odroid-c4.rst
+++ b/doc/board/amlogic/odroid-c4.rst
@@ -141,3 +141,12 @@ Then write the image to SD or eMMC with:
     $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+
+Wake-on-LAN from suspend
+------------------------
+
+The BL301 firmware built from the Hardkernel sources wakes the board on the
+Ethernet PHY interrupt, and keeps the VCCK_B and 3.3 V rails on in suspend
+for it, only when told to. With ``CONFIG_MESON_G12A_SCPI``, U-Boot tells it
+to when the PHY node of the device tree passed to the OS has the
+``wakeup-source`` property, and tells it not to otherwise.
diff --git a/doc/board/amlogic/odroid-hc4.rst b/doc/board/amlogic/odroid-hc4.rst
index 1d37be2d80e..ccf30de5350 100644
--- a/doc/board/amlogic/odroid-hc4.rst
+++ b/doc/board/amlogic/odroid-hc4.rst
@@ -140,3 +140,12 @@ Then write U-Boot to SD or SPI-NOR with:
     $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+
+Wake-on-LAN from suspend
+------------------------
+
+The BL301 firmware built from the Hardkernel sources wakes the board on the
+Ethernet PHY interrupt, and keeps the VCCK_B and 3.3 V rails on in suspend
+for it, only when told to. With ``CONFIG_MESON_G12A_SCPI``, U-Boot tells it
+to when the PHY node of the device tree passed to the OS has the
+``wakeup-source`` property, and tells it not to otherwise.

-- 
2.43.0


