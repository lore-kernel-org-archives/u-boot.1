Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52B606A333
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g/sFsWTz;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PenOKJhA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8B7B60D7B;
	Thu, 19 Nov 2026 13:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYVCgbsCNzbz; Thu, 19 Nov 2026 13:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4196760D7E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095221;
	b=cD5/XCREgJWnkYN3OMXqiMcV6K9ei/QJbfOcq9llAudf1hJZG81SDk8y5AICfEnT54BM
	 L9v/a5JAG9dYsW6a8y00/yC6ZLDTaaKuDmjm9j+DiLHu0kvzJbusizOiogd0VVBDKQRya
	 xe2k6Pa6sDNoNfXxv7GTMidmZaz7lRI69fXgLDx8x4LPeUyj9rAae9qu4p3NHumnb16Qv
	 0ylRvAQELx1JocCV56+2eDrVhAdX5vCXBXb5t11bJ55Yu9bO2RGNDUlBYfy7TB7drV/rx
	 LWdYCfGlvYom9Gt682u4xawHXuWNpA3ZjHJA6Ai26G1LcFAmJKz5q7wO6PPKKjlGjyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b+O1Q6z88/Ke4jxi9HUXWM9GWo6gEVmC2YM845Bt5Gg=;
	b=WOUAcMZctl+EaJa2hgeY2sElNOdA3e6EUXykkILoTmtrIB9lliEUzMP1oqNPmSo7erIk
	 ixnZS3IzWbEwwedbVo99+OaIypru1pK+/Z65jx62FsT+bjpe1JrNDmU1AftKZw8T+pe1+
	 QGUPBcIq8yHQiP04LmjZrgsHoDMd/Wf+AuxdbJY5z/Cr9inXfB2LQPj8oPltgz454NkRx
	 zMneZy8UsRlZlRQw+aDuuqpjaYLUOq/EvMkjGgb9iZc2Wqt+48OIusfATwiKWjCND2YPK
	 BSXH0aaLVxPd53v3n/ldcngbv+4yxCGrGa3rQX5rrpa/OcOfr52hSLnUxYYsGivgUUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095221;
	bh=b+O1Q6z88/Ke4jxi9HUXWM9GWo6gEVmC2YM845Bt5Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/sFsWTzAz8bDlw1x0Ze3ZhUp/VRVRx0lXs54SdhBNZSqAA+pImmyU0lsPn/VPv+5
	 SmamikXW3wxhnodgJ71hwS76WXLgJs9msui1rybfyKBDkPOcyQTe1zA6Yamkl5lIn6
	 2AednorHWLz3j4gk7QYGSK3kjdNRam69kwi7Gn/YSty6J6ukKOtA1O2wHTtRR50rCp
	 uMndQnat0kysoCURktDsshYu6RIyWs8g8lBrsPdf1pJhx5V3W3iNMN05Yj3quCQ7ak
	 WxxBb4mKYZAV6xQTdWvNEvPsf2VyeBJYjvct6vPP+gNKE/HwVgcoV+if/HmqwylDL9
	 NDkR+hT6R/m6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4196760D7E;
	Thu, 19 Nov 2026 13:33:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9108B2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8209E80D63
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2uh_qSh8DrrW for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1DDD80D4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PenOKJhA
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1DDD80D4A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:29 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso21872465e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095207; x=1795700007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b+O1Q6z88/Ke4jxi9HUXWM9GWo6gEVmC2YM845Bt5Gg=;
 b=PenOKJhAeAW2NJB8k8JOEhEtMc07/MN7t3Zqqym1LdMK9ANfjAciwA0f/+uAOKGEag
 e/v7p5pvGl0F7qfXEg/XGxR2TBEJGftNXO8iPQoEUwgRIGyUuPnFKbus8oFLs1LJwwuH
 sNhswlnKBqax9wQlbCF1RaFzWSge94wGxnJ6azgq3STZUSQONrgrZKIKbG2MwmCTUqL6
 /aFBrXda+cUiKPFRK2Ux8re6imNS4vJtdkMh3guSBs8cVTMH2B+7QhAHzlENhuka+Qv1
 DS0aMy4JxBwPDi3Edujtdu3xijnE2e0omFtJDOj6ZufJnkeaXwZkSqyViBuMrStrXprc
 XhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095207; x=1795700007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b+O1Q6z88/Ke4jxi9HUXWM9GWo6gEVmC2YM845Bt5Gg=;
 b=aUabg2beR+j2rW8rfI0mU7G7FKiqJrhb3dBfA1h2obQRSrWarwOdroFLb3JnmXbQPV
 /rNzBeYtDXqBRIzqZ4stv72KiI1c8JWKIOCMO/V/0dOaivDhs/D0jMwxAdDbKtdi08Le
 AOXHHCFDdi2j2/AuJdtr103WyiyJBHnG0Jy4AqP3omCp4SB8o2zuJtxqSS6r12BPV8dc
 5nA+zOIg6yTjQxFO1KlqmREFI75iE6AAHiRM7V6l5cjCO89AgpsN/0EonhO04dgRZmnf
 Ux9UC5fL73fakwTEtEfcJU8Bas6lGYH89MFnzPiNJeCb+BWjLR8vZ5JFdVU5L2DiRfww
 2r/A==
X-Gm-Message-State: APuU4Z/HnFp5Ktl44UgYsVDUJDgLR0PQby/wEBkFkPgpvQ5q+X5KOJLm
 alXc9k6lVaPrxhs1eKUnHdlp8BkP31pz8h70/DEAZ58c8KBqFKXw4RwYolxYYr/V
X-Gm-Gg: AYBFou360AwuUKUgg3yDgMgFrR0+FCVPWFLQRrWbymtKprRpGa7lpAs4nuie5i9Ghls
 aNDn+/hhHVbUS6JlZ2AbmZ79Jcrtgocxj+7Vz7WVe0DuGr+q0vnlzsIvuN/ozREptpm9uWjhjOo
 5hwOpxnP3bNMjyGbVnCwGfxY9JFWpX9gGx7rHfw72N5KulXOespd01VwDWaS4M1Na/obZNhw0jx
 j995NmshhkxisSmyJ41OHj4tXbF/C5uw8YCW5P5rXxR+un+y9V0eZrh/zMjQefoUoVxNLOcJsWQ
 rLswmfKubixbJlrgFKb2tU4TSfRLNfztVdxE+XC1mh9G4HjO2k+E2oUe3z7GmIXyY4Ynr64HoJh
 ofqUcV9jjPnBRRGGdr4qE6AsJRepFoPGLJvEBOG16VaLZNU1T+ilVSKINLYQPCT8losxJOYN2It
 qTJswHLejfFSsnr5AsmEbyK/wqzMRkRCpMo1LlAsNX3drd8T0rNEE8h2FGDEbS/hCeQ1ggYrPfy
 7cpkxLtV13pfsHMdreiJKc+eg+0V8bx9WfGXBj33nv8rm449JE34nfQ31KRrRjOCW9wEO4sZZUu
 cSmJl9YVW8Xg7aUf4XgDPoyceLY+35sh7j0ynGUgHx8CHSSk4vpMgkoIbWBUsaB7EzHmNh2n4Ef
 ufQ8eepIy8Vl9Zf49YykoYOal13Rki/W9lQ8iP6l3FGwY7JZgdmdxTHzuFpJ/hEbxhdSKKTmO+/
 AirInNiEXnDPOPNvLVt02sgMuzJea+WQr50WgFqFOs37mVrYAApgLf
X-Received: by 2002:a05:600c:8b42:b0:4bb:7033:de79 with SMTP id
 5b1f17b1804b1-4bb7da4afa7mr117933605e9.35.1795095207084; 
 Thu, 19 Nov 2026 05:33:27 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:25 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 10/14] configs: turris_1x: Enable LTO
Date: Thu, 19 Nov 2026 14:33:06 +0100
Message-ID: <20261119133310.22732-11-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable LTO in both Turris 1.x builds. The NOR build needs the space for
the ubi command next to the BCH code. The SD card build needs it even
without the BCH code: with Debian's GCC 14.2, its u-boot.bin, device
tree included, is 1052227 bytes, more than the 1 MiB
(CFG_SYS_MMC_U_BOOT_SIZE) that its SPL loads from the card. With LTO,
it is 989355 bytes.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
Changes in v3:
- sizes measured again on next

Changes in v2:
- give the size of the SD card build, which is too large already
  without the BCH code

The build does not catch an SD card image that is too large: here
BOARD_SIZE_CHECK covers only u-boot-nodtb.bin, while the SPL loads
u-boot.bin, device tree included. That is left for a follow-up.
---
 configs/turris_1x_nor_defconfig    | 1 +
 configs/turris_1x_sdcard_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index 070428ae25e..d8ce4aed4a7 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -19,6 +19,7 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_OPTIMIZE_INLINING=y
+CONFIG_LTO=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=786432
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index dbeb34dacfb..982a6cb0703 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -29,6 +29,7 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
+CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048576
 CONFIG_MP=y
-- 
2.54.0 (Apple Git-157)

