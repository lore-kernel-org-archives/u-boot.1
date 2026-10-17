Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACCDCCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37DBD8142B;
	Sat, 17 Oct 2026 13:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxUj_O8ipGUS; Sat, 17 Oct 2026 13:01:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 240B481447
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242088;
	b=jVC1koFoO4u+Vunkx+WfwXLpTP0BcHWYvCp65tOR2aGdcsjH4xw4C9buLzAWLCIm1Rag
	 L6dnCmux3priCm402Xo1+W94HoGJ5xxbWYxtrpznlgFrqMltbg/BDVOwbyMdRr8iOz6du
	 ZBGC/n5Pz1b3pYjrZz5Z2KVqNvtDn3zkoT8gYKVzsktFojI38M0FlHrTTPskPYc/y2qA3
	 vbPhW/fUiRgSNXdpnvTV85PGWtXJCpyjocTSkx52r8fsp5fhzBwdaDu7HlwxQICDlWMmr
	 bO4Y2oPheBxWj4N8ggM5yMfGt5RcH8lmPkd4MsZBhxTvWcVFm8V/jPXMXmmhcDesPHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CVY1/7h4U17c1diX1toyCwAZAvkvLgSV2qgYqGYgk9U=;
	b=SD9Qe8wXluflJSkVIiLv6iDEsdma/otkCF77Q9ZCgewosOaZskcZbieR0JNncOG0rsWc
	 DG15rJOjtton6tWB4BMcMe6gWcDfXfeO+tebBfdwK0YBp+2kZUV48PsOu+TvM/8c+t64k
	 PdK8lxr88BKwp/d/z5yyn+1e2Pp0/xgdIzGAKF6OcJFHMxXBOuMl68LvDwYxX/5e4U84r
	 VsOonIL2o7k+jdWJnLoaNQxCu+bMrjSexqy9dQFxyQogJE4zm46zcdyRdSu3OAg2wZicf
	 3eNJZbwiFJ5c/pO1uHaOuZQ5SgUCOMRnl1KmGCrwoydGJO0s3h8499FErdDJtjNMPbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242088;
	bh=CVY1/7h4U17c1diX1toyCwAZAvkvLgSV2qgYqGYgk9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=0GzWL7Z8IT7e5ZGXeAld9/2fvuF8Fg0J1xTaj02uwP7tSvjQ3YvXskHnyaFYPVsfx
	 vuhs/EKoEIFexM5e7N0/c7XhUCfbVz727KO6jq5TrDIOUpWcDVCSZo57zK8sFHiwUJ
	 TyMX62fXMXuopkl/W/2mGzm8gxVVo6tV9f4VIMkacEHvCTRIVs7AxV98XKjpiAHmAd
	 ZaJ0vxTESaV1gwRGSwUnLcUSreF6ZG8ZqCE9PTSPfXnRHQ7s16tYHIAEa8v8HbllWk
	 jc+fhymxfjmHMpt9bUFkKj6DQDlRLJrPi3uxyBHGZp5hBFX0kRjP6dLQ5AW4l+CSU6
	 X1Zt7Xcv36gfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 240B481447;
	Sat, 17 Oct 2026 13:01:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C922255
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 729D6406E0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHG5s6cOKZEy for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF594406DB
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222779;
 b=QSUj4KdYVulWbm+WgEeARe7wjq0xP2qzAVZiz6s6iQf82vbB4TDvsF5kmM8SOz7Lf96K
 WSGOBhcegKRMfWNJoaEXnNudQmujnsCJN8kmS4AaPtLntOpMVj2zjL1OHLBc2WiPI8oVd
 NXM1B6Ho4ADSl34raOjvAl/DVI+2TxKelGZQIV7iw8kkG3DhRLxiMPKuxU2bSwaTmeELB
 nnkc3CYvEeOj/ix8GsFl+qZZK/Pu6/5Z1qsPeVS0oC1PBkU4FJ82DhS5svHtrsH5l3LtL
 JHeAXQ4/H8IW4MPYxBigGkPeutWF1ZdmhzRmMOq0DyTnXVA8GEEbxwUygM9Jl6/fkCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222779;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=CVY1/7h4U17c1diX1toyCwAZAvkvLgSV2qgYqGYgk9U=;
 b=UB9tkJlEJfrgk29SMWMCqdWo6OBRPb9uJS8vCSpSN6mV6KPG88VyjFMQtMIDnr2qUz2f
 CyYqA1zYI3NobEq89ZGEylutb2jqeoHGoPCuXhMnpVry+j4lxp+kNfR7TrK9rn/jjEhVH
 2S/Im/XHqldff1aeVpjXV3Z0wT8eQjQotQyRmYfQoEUr43HJE1YZcCcOJFZohaeeja0yK
 ovKKOkfcQGTZYfTp0SseNAZ0r8xWfRoryAazUMb9zLHMHCTbrdSw+LJc1bdvbpOpLMvlm
 YVs8QzbLdumrjJNFthAj+oIgFVFfK5kCSS1RbLSUNb6tfMbfA2eAbDVjls7Jxh26i6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZA8EmXfj; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZA8EmXfj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF594406DB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7018F43CCC;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5346CC2BD04;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=SzZOb8QuzcAGlufaSSYdnfP7a0NntrNoOFxJo03vyJ8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZA8EmXfjN4KISKinkfMtCAuT3QohyAnqrnwXBH8nIv/l9b1IC7/1Dh1ba7pJC/SLP
 ryN/ehuieO8zd0835dC5kl1DrHINKmysfBLliDAbHCxKCYZOgOtMSxt8SDbu9nmgbo
 yXDPVngM2pJEvwUMUQWur3S0Qv+uvcQnfU/gzlcS6WXLbKfjFpoiO4bJsaopRnbBjH
 TN9TGBe7yNiWvt+YLK5/l2TZqGdJob/ghqEZQ/3t/iyMpx5N9Zhe3SYn5ApXVHET4n
 g8Fk0/gkiFsbUZiI7HowAh8qaCn3BQyuWPSuNIRlQx9rGii4sci0TcIQ/Ab1fCymq7
 kgew+Wajnhy+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 41ECDCCA463;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 09:39:05 +0200
Subject: [PATCH v2 6/6] rockchip: Allow compression of the FDT in the FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-6-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Alexey Charkov <alchark@flipper.net>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=1504;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=FlQuXoK53s24j1p15W4V8i+V56MKTL/IXnwaSFm7F88=;
 b=227mYOyAh7ZzgX+0y0U8QgiecUpZ+O/BJxxFaicMrjOAMItj1LqEcdaHdioTNuEuG0MKWPa/8
 +3tamPutLuwBhfw3khU/SUJkc3ouJSfJZd3Bhb2FTpu7RaO7WGhqDQk
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Compressing the FDT shrinks the FIT at the cost of decompression time
in SPL.

Define FIT_FDT_COMP from the SPL_FIT_FDT_COMP choice and use it in the
@fdt-SEQ template via 'fit,compress'.

This has no effect on any current board as no in-tree Rockchip defconfig
selects a compression.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 arch/arm/dts/rockchip-u-boot.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78a..3cb571ddddb 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,6 +19,19 @@
 #define FIT_UBOOT_COMP		"none"
 #endif
 
+/*
+ * The compression of the FDT is chosen by the SPL_FIT_FDT_COMP choice. It
+ * is independent of FIT_UBOOT_COMP so U-Boot may be gzip-compressed while the
+ * FDT is LZMA-compressed.
+ */
+#if defined(CONFIG_SPL_FIT_FDT_COMP_LZMA)
+#define FIT_FDT_COMP		"lzma"
+#elif defined(CONFIG_SPL_FIT_FDT_COMP_GZIP)
+#define FIT_FDT_COMP		"gzip"
+#else
+#define FIT_FDT_COMP		"none"
+#endif
+
 /*
  * SHA256 should be enabled in SPL when signature validation is involved,
  * CRC32 should only be used for basic checksum validation of FIT images.
@@ -136,7 +149,7 @@
 
 			@fdt-SEQ {
 				description = "fdt-NAME";
-				compression = "none";
+				fit,compress = FIT_FDT_COMP;
 				type = "flat_dt";
 #ifdef FIT_HASH_ALGO
 				hash {

-- 
2.55.0


