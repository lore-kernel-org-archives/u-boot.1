Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9360B5074
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sADdcpz0;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jrCUTSGc;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=kfM+rfBE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50AE14068B;
	Mon, 19 Oct 2026 15:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdtgcXZY1B1U; Mon, 19 Oct 2026 15:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 797E140687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423665;
	b=BAuOCq00SZVCwrDqAumpOsgoRv9pbJDH9zNj2KQDaIi+eb8fvmP/mYG1Eln4Zrr3vj/G
	 77F58hCqHOIpFRuvhZfFKSmpW9YyXJXy1W51tvtYx5u5LAhK/+hofKEu5jjQ3nhvhH6nI
	 ELkNrGl+rTgKu3Ib38d57kNaj5OOqVzS9wjXdXpx+SWm01bZOMcAOeWHuKlvd7RAnmhV6
	 PcPBQKhlsXVbRd9G7qG7A3cqxJ75qhIx7RA2NhITCG65sSLeo4AHJDN49W3B9DkcWd2Gk
	 eHA57gZEneuNrn6ZoXwbyMQk7VfKut2ZTxnE+nTOpHQv5VstGL3tkFIsvTpwmjdBZOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xVWF1nl9OcqCjeO8DCZutwuY/z2K/V/3UHKSfJsTMG0=;
	b=bPwi7lfsmq7DFrw/eBKwH2wOk4Sj2YZ+7ZbwG7n47Yw/Ocxj0yIdqjPqtAcC6kLH2XyP
	 64oEGtsahrCWqkzNsa532pYzu4Ldm7/ZCAnPnO+lcPGEju019rIGsxYZw2PedfSt/kuC/
	 juO1cy3zHfmaBYeAOj/0RdagrO4o6QPFYrLNkFusG9XTVM08x7aHd0ba232inGOGTVAJ6
	 aHDTbtyW/M8uSQRXGVk6WhfrILkcB3waaDShe/XqY0DKZk2mR1SxRjO6X0rF6JjwlPy65
	 pNMvevFEAGhBCYYzLt7F7WNULgHdst3mWibcdpDF4oOdr1US7v1bMDjljgqK61C4rwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423665;
	bh=xVWF1nl9OcqCjeO8DCZutwuY/z2K/V/3UHKSfJsTMG0=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=sADdcpz0b5A0rpLOWWhmB9c18E7gF6nIEH29mlq6yHPlJ3Z/9z4GSjLM9GuryoHnb
	 gGJ/iF39TwVpBSkePnCE1nUL4TPGu3u0n1ZK8tUmKurwpnxMz3WeChj2v13ajHJvF/
	 sakb2wvy4rJ+bbXU5G7wMpUqWflomv8bYazRPCXWpNwAoRBcIt3K3JuWtEhd1SUmaP
	 5+B7Ym/62oLW16mb9FXQYNaPwyiSbrxuM6cP3fMw55y4PQcUzTEhsCOWfoBfRyKDww
	 MvkZRbvEAZhbyEYDbEioP7xiQybgt0ZN6I4wi4rbEQae4Wg3DcE7HNuxi/fKC/NA6U
	 rGWBNoOIG0QKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 797E140687;
	Mon, 19 Oct 2026 15:27:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84FA71DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 767F580DA9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZtoGT8uDaN1 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:20:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5224780C6F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423222;
 b=lff0BpjvjSVPR/kfI3bYPg8hy9N1TGdQtxNPocEMDC6whpFnCbxMKb+GHaFziWWU6D27
 8JFll9dl1r3k1EmpmmZSeSKHfaJZ8XQTWvW9JZ0/pKKJAUq8I+TREMLQEclLxPhvPJe+a
 JbtbnzEYQSaWqlrk2hE63XKn9ua0m4lG7HNQJsSz83Was4P+vMrBDY6ttbqHxkF7D+puP
 CojRGOXDosyYrpbA4LHNuLTlDsu7VWtqaANincohMEGOtUDjJPIQFoXJzZybfmXoUYfnq
 D155vCfvA5T3Al4VBftAjzANHOg80BjotdyUWGNxusL4dw+JBbYV+LLAWAANA4Rgp4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423222;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=xVWF1nl9OcqCjeO8DCZutwuY/z2K/V/3UHKSfJsTMG0=;
 b=l34TeXnITavujYaaGMyslEmWKHzQI+XQpetqVXlnSdRJBqTJf3O84cA8KX0SWA5J6IQT
 pGAoVPwnL+wiuKcBC57J6HDXwuzL7FrjNcEIGTqk2grNBhyqgrMgeb6m2Uh1J0sMOcbmv
 tuGYB98+ZEHwFgkSmTWBMnQYyxbGdKz6IBBrvuuw7NFkoR3dhl3QXMZ8yjDy0dOJ63ckt
 T2RE6WDhhPraWNSTzctM6b5QofGaEmW3cMtqPFvG4dc0GrgwCzZlVQkVNKsgXDCoN/PuK
 lm0HR0ChlogfV7paZoSr1+Z674iqAqtor9vVSF4+cyREVdr53yOHpATRM5eGOZDTOUw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=jrCUTSGc; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=kfM+rfBE; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=jrCUTSGc; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=kfM+rfBE
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5224780C6F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423220; bh=xVWF1nl9OcqCjeO8DCZutwu
 Y/z2K/V/3UHKSfJsTMG0=; b=jrCUTSGcoquwBF7TxHkE/3kD+me+nFQWFueCwIw+LTSTQhTBT3
 UV9tKHBZElcHCscYRJBXupPWT9syh5Px086yGa4pti+ao8t5Qy/01+2Dk9jxIyQ/EtnrhLAaYmn
 W7uEsrpiS41A4BItxGFKGyOqNGgmYMke2AnapxxK8Dyw9P7pT/QvMXVa2PrKLYCpqKOA2+7wnNb
 KAzL++llrb25NF+LVhJgIx0zUiER+l0uA4k5dBhaET403Zhi+dkFJsufEQwFrRmXjzIv/RRhQqt
 hXjTwGIoXeOh/mC24VQ50Dr53nClDUqzvmnN3WfWqlINmukc5vPT+o9kyMuMKF0qUfg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423220; bh=xVWF1nl9OcqCjeO8DCZutwu
 Y/z2K/V/3UHKSfJsTMG0=; b=kfM+rfBErSBgfd0Bu31BBuNEXfbzjBnZ5kl08pzdbRPylTQW3K
 SWQYjLTB076uHtcKcqpl+fs93GGpVw3lsfAg==;
Date: Mon, 19 Oct 2026 16:20:20 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_12/14=5D_board=3A_CZ=2ENIC=3A_turris=5F1x?=
 =?US-ASCII?Q?=3A_Make_NVMe_and_SCSI_boot_targets_conditional?=
In-Reply-To: <20261018083516.49229-13-pepe.schlehofer@gmail.com>
Message-ID: <97690900-FE5D-4E19-9EAF-81E8B7F96E9E@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:14 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>A Turris 1.x configuration without CONFIG_NVME or CONFIG_SCSI does not
>build. The NVMe and SCSI distroboot targets are listed unconditionally,
>and config_distro_bootcmd.h turns a target whose support is disabled
>into a build error such as:
>
>  error: expected '}' before
>  'BOOT_TARGET_DEVICES_references_NVME_without_CONFIG_NVME'
>
>List the NVMe target only when CONFIG_NVME is enabled and the SCSI
>target only when CONFIG_SCSI is enabled, so that the NOR build can drop
>NVMe and SCSI to make room for the ubi command. Both defconfigs enable
>NVMe and SCSI, so nothing changes yet.
>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
>Cc: Marek Mojík <marek.mojik@nic.cz>
>---
>(no changes since v1)
>
>u-boot.bin of turris_1x_nor and turris_1x_sdcard has the same size and
>md5 before and after this patch (Debian GCC 14.2).
>---
> include/configs/turris_1x.h | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
>
>diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
>index c05614950c7..3a2818d1904 100644
>--- a/include/configs/turris_1x.h
>+++ b/include/configs/turris_1x.h
>@@ -71,6 +71,18 @@
>  *         define CONFIG_SPL_MAX_SIZE = CONFIG_SYS_L2_SIZE
>  */
> 
>+#ifdef CONFIG_NVME
>+#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
>+#else
>+#define BOOT_TARGET_NVME(func)
>+#endif
>+
>+#ifdef CONFIG_SCSI
>+#define BOOT_TARGET_SCSI(func) func(SCSI, scsi, 0)
>+#else
>+#define BOOT_TARGET_SCSI(func)
>+#endif
>+
> #ifdef CONFIG_SDCARD
> #define CFG_SYS_MMC_U_BOOT_SIZE	CONFIG_BOARD_SIZE_LIMIT
> #define CFG_SYS_MMC_U_BOOT_DST	CONFIG_TEXT_BASE
>@@ -266,8 +278,8 @@
> #ifdef CONFIG_SDCARD
> #define BOOT_TARGET_DEVICES(func) \
> 	func(MMC, mmc, 0) \
>-	func(NVME, nvme, 0) \
>-	func(SCSI, scsi, 0) \
>+	BOOT_TARGET_NVME(func) \
>+	BOOT_TARGET_SCSI(func) \
> 	func(USB, usb, 0) \
> 	func(USB, usb, 1) \
> 	func(USB, usb, 2) \
>@@ -279,8 +291,8 @@
> #else
> #define BOOT_TARGET_DEVICES(func) \
> 	func(MMC, mmc, 0) \
>-	func(NVME, nvme, 0) \
>-	func(SCSI, scsi, 0) \
>+	BOOT_TARGET_NVME(func) \
>+	BOOT_TARGET_SCSI(func) \
> 	func(USB, usb, 0) \
> 	func(USB, usb, 1) \
> 	func(USB, usb, 2) \
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
