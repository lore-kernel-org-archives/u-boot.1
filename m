Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2B606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=re34rho4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWomyfO4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D4CA6087A;
	Tue,  3 Nov 2026 13:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5O5-K-ZZSA7; Tue,  3 Nov 2026 13:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2ECD760848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711148;
	b=e19WLFZQmAdr1P6jS8/mSCVxlyo8LeoAlwBak6DdP9uSj75Kutgpp3VfrkuIuyanAHM0
	 Z1OAizQ4BBPDxzblV7pcCdF9T3MTIFbP7KCPcyAUMsG62yNYaaNAmWIgaLxsgn/gP0rb2
	 nQmuIjaZjPlGlPEwdElEbT/zD/C5l+QeSE8rHpcxQj618IgykkdhWRs6vJTLRKMpbXoMj
	 edLQ/pSOd+ufx+93qtWfUUGgGmVNxJ0S7OK1ulJo5HYL06/JnR35Z8ShoVjqOxn7j3cKU
	 L7f9WDsdsc5IOrdDtPRj5B5M83Dt2RmdyNuyWy7Yg9+PmmDiPgtJIMKNSf/1RaMEP3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=2w4FxGjH6lHbMXcsD4j73jucnRFcTQzdorF9Ixnytc8=;
	b=H60m3byCMb9o3PW6jY1isdgGgt2vZ29jVY11ETQBC1MXNAqgeV7fDbVSrpTh9fS6mRBV
	 CVWnXupZtDfevVpXTkybWlx4UjOHxX1Yurlpttb7lEwyCy/95PJFtTHelkLtI+dAD/f4w
	 cf3+eleKEi8BM7/DDy6HH8RH8DQW00UH1Uy1XC9QKodD40YnIRqoqSD1u5g+haTpE+kaE
	 VCNMQuIEG4XQhWoIPZ4Y/fStGQqV4HCVyBMBOuiBAYkPjcckIGSAKCMRkS+IWOnLCAVDB
	 RJ2zLh69RpufwOlShgwkCFnF1iu2NuPlO1wYVsU3eoAMoYtWZQC4jRJTCUqqgZEEqcA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711148;
	bh=2w4FxGjH6lHbMXcsD4j73jucnRFcTQzdorF9Ixnytc8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=re34rho4wBpvMCyeqYQU8t9bO4HvDb1Rt6mbroI+GqE2Np0MhFuV5WzycOfxX/Ue5
	 QzLTYj4YW5qrwnokeGvlffLk1yybEzbMrNjddYdVLMMzktKT3D8oZ9EXdIsdHtfLdM
	 EAed9eHnYrm8f5WPVdnWySpi5KE013M0Vr+kToKnUCglpITrDFxFVwJXZ+hRkekIHW
	 WrHULZnSNA2WrG/bPwBT7jyM7IwHfTDQKL9FglmfZ/oUphJHUHJeuVGZyNFnnYdaEv
	 sVgMCmEmPcdXBLcTS2HsTRKRV2COLGjf++AocYru3rwxZWhJA6WxBj9K6VbGbAdGJE
	 6WGHhpstpdj1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ECD760848;
	Tue,  3 Nov 2026 13:05:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1177111CA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 033BE80E03
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZv8sIFqkbfc for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D04AB80C66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702234;
 b=j/11mHQbv0s3lOtmfqM5YT4De12nF3xAblp5vBSOcpq+sA5x3p1IIQXZ9XlZQviCsFSM
 Pm4GDwJZG3FnAzM3ok7Vw4wb9pg14RFEjkQqIl+iJrZ7Hhk8mUSOexs5b/Gm5ut///ObE
 q8iQ/70vKyBSAS+Qze8JvyFoJXmaAb74ns7bINonzM33BOWXjWFIsAbAuuf52dJmjCdPC
 GGui7DkNKGl7/uno2wVQoE3U71lkzb90yeiOcKlMqpOc3k4XyxBEGtVKi3g1ulyu44e7i
 rUgvLj5xfdrRI6U4W83FhcpCqVpZ6dxkv8/II5pPYpQBBH+a4XgnUNwLfcWZO99bGCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702234;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=2w4FxGjH6lHbMXcsD4j73jucnRFcTQzdorF9Ixnytc8=;
 b=mHdNBqLlc2ouzib9v8XC6bowbq6ktGXAZtEHSzQxTS1oQgRJ5PI6Eabe07rwrjf+Uljj
 Plq9164g9i7Q1R5IWDmp7fpY2QQzL0+UWu+fUVlHS3d8nHtRGNk+DC5jP0G2kx97qV8Zb
 M92MhamHRUb1XdPWPygT8pHIiuRjyOfXM9J4IO4Cv09l4THtclWB5rd8pwHQnyNUa2UxB
 m5dvbBwAJehTv1ycRqMJB3WeYew9KcA+n+8o0Pe6CR7UVaZsxxMigH8tlrf3Way1+Icfm
 kOJhiy9XWzf/Aua+DjtX+f8ibl9V5qa61nnR+fV5r7fUvO2BJfSLKzR3XiLgrgi3dOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HWomyfO4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=HWomyfO4
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D04AB80C66
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F24E56022B;
 Tue,  3 Nov 2026 10:37:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702230;
 b=iXxt6aonfLg96EivuM60XYLxRQHiJNN25vmjP/pRE1goBnQUGv8MXSGXM+mwJaA/LP6w
 /XeQTRNT3lF52Yv1PEmHDyzkrUiCejAuhN0p7f5iLbLneC3SeUPkI4Ifglwq5eW3+SKg2
 Nkc3+Ywfvr1EJcuMuAcJbJSM15H436FtI4iW0O0wFYyPVerJ3YtMbrOr6frYZDO8dPgaj
 s2WPJcRCN5C9C1RxQ6u1dyNH4LQufhDik7ePtY8tzi7GegZFlogZ4KD/O5kwpM6wZ19sp
 4nc6C7W1UQCas6bx/20giszCVVj3z+90l3Mhkt/MovkprdU2k0Bfe2ECkXQ6C2TVFmA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702230;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=2w4FxGjH6lHbMXcsD4j73jucnRFcTQzdorF9Ixnytc8=;
 b=OA0TxEuRUBFRf6KfsvreAMxUn0fhO9UKiQ8nOfZ3lKBzH6uKENrmZSH09ZZPZWArz7Hh
 MD/+IGWRpHdPA3MxHg0O2vsLXPblbCAu2bCcSHnZC0a8BfK1j9zIFax0edZbr8YtQpl2E
 hXl9MDtsGZEOjmpqHkqZd5ei8qYZan82CC3irRFPogin5KQB1Ode3Np0lsW9lcwFwiVKw
 RQ7bkJsRlmwEQIAS1Nognwnah5Qu6vIcA/70Efdc7ptaYK/VOeFxdvhy+g4QNCJiuX6CU
 5If/gwglmSSYFIMd5iHlV7WPNTVRN4W/EZpof0gH692COLpfd1OSDC4tA6wYVL1bWug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 667631F00A16;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702230;
 bh=2w4FxGjH6lHbMXcsD4j73jucnRFcTQzdorF9Ixnytc8=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=HWomyfO4E2qbiv61l44ha43dPcpsgJn2/EsA/3U8Lb/zLOSUl17k32Wl5VjRcX1vu
 STb+rOv6bb6qYDXluUDxxaXYBXpJkbsMn1a+o2HgdIx0j5Ec8RXQ2VHFYCJVvc/Pz0
 npM24QmkLfqtsamfxZtHTFvf19Nis1v5WJjmDz5HKJWCOifMYS1itRnlSSOzoo5IWa
 Pf7Yc/Wt0VFmPWbZb6pFAY/WtEgoz7SmupqE3jdmm3iHxrk23QAx8qwS+ZeyJWV3wC
 KvRQ8rTqDv842EB4hcUPrqLxAXukq/hV94Nmcrro/EVXacjZuVo/HRkohKvEyXcuD2
 yjp+c9tnxnIVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BB680468C5;
 Tue,  3 Nov 2026 10:37:08 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Subject: [PATCH v3 0/6] rockchip: rk3528: Add FriendlyElec NanoPi R28S
Date: Tue, 03 Nov 2026 18:37:05 +0800
Message-Id: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw7CIBBFf6VhLWYY+nTlfxgXtVA7JgKBSjRN/
 12oGxfG5UnuOXdhQXvSgR2KhXkdKZA1CeSuYMPUm6vmpBIzBKwFCOSmN9YR99gGDr0aAECOZVm
 xZDivR3putdP5w+Fxuelhzom8mCjM1r+2uyjy7nc5Cg4cSlQ1Vl3TYnd03s7W7O+a5XLEPy4mV
 ypRY1N1Skn17a7r+gaei1qC9AAAAA==
X-Change-ID: 20261012-nanopi-r28s-0adc0003f445
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=4liYhmnYLrrZwdDx6nHPrOMRX6nbxZznefQdnWGlbKc=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwbrnjXeY/ropPmtNbf2HvdLThfvr3v62Gl/d8Cul
 OKvHg3/OrazMAhzMciKKbJ0Sn+e+OXxhelfb07KgpnDygQyhIGLUwAm8vkkE6v0iRPr/r9YtzL4
 h5TPn/an95hj7h2bY90XKq70NSaY3XCuXM08ndPOwrsmOufK6vrvDPY+q+I12z3/Q5DhCyEz6+C
 od0wcNzuvlZ/eMsPu+y5m6Qdq/d53492sN7OFR3z+qv19OW/h9+pQ+8Un93H1ZH7OupEh/VE9ON
 q+flnPlt3ic5o/R7wSEawDAA==
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=5A3AC293DCEEAA41A8A3266A910205A0AEB09D84
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/20261103
 with auth_id=1393
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: HystericalDragons@proton.me
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
based on the Rockchip RK3528 SoC. It shares most of its design with the
NanoPi Zero2.

The Linux devicetree and bindings for the board are now in mainline
Linux and devicetree-rebasing. Import the three relevant commits with
U-Boot's tools/update-subtree.sh pick dts command, retaining their
upstream commit references:

  e9eafc0ca521
  f7f1ea96945d
  d0f6e37c635b

Patches 1-3 import the bindings and devicetrees into dts/upstream.
Patch 4 moves the U-Boot specific parts of the NanoPi Zero2 into a
common rk3528-nanopi-u-boot.dtsi, following the split in Linux.

Notes that `Assisted-by: LLM` tag is not required anymore since Linux
7.4, so checkpatch reports error for these patches. I have no idea
about how to deal with it, so I keep them as is. If I did wrong,
please tell me what should I do instead.

Patch 5 adds a NanoPi RK3528 board target that reads the HW_ID on
SARADC channel 2 to select the FDT in SPL and set fdtfile, in the same
way as the Radxa ROCK 2 board target, and moves the NanoPi Zero2 to it.

Patch 6 adds the NanoPi R28S to that board target, so that
nanopi-zero2-rk3528_defconfig supports both boards.

Build-tested with aarch64-linux-gnu-gcc using
nanopi-zero2-rk3528_defconfig and BINMAN_ALLOW_MISSING=1. U-Boot and
SPL compile, and the FIT contains both Zero2 and R28S devicetrees.
BL31 and Rockchip TPL were not supplied, so the generated images are
not bootable. No new hardware testing was performed.

---
Changes in v3:
- Rebase onto U-Boot mainline ab4dc5aacf9
- Import the mainline bindings and devicetrees with update-subtree.sh
- Widen the HW_ID ADC ranges to the buckets used by the FriendlyElec
  vendor U-Boot (Quentin)
- Merge the R28S MAINTAINERS entry into the NanoPi RK3528 entry
  (Quentin)
- Collect Reviewed-by tags
- Link to v2: https://patch.msgid.link/20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me

Changes in v2:
- Add a common NanoPi RK3528 board target that selects the FDT using
  the HW_ID on SARADC channel 2, instead of adding a new defconfig for
  the R28S (Jonas)
- Add Jonas Karlman as reviewer for the R28S.
- Link to v1: https://patch.msgid.link/20261012-nanopi-r28s-v1-0-042d62597829@proton.me

---
安容 (6):
      dt-bindings: arm: rockchip: Add FriendlyElec NanoPi R28S
      arm64: dts: rockchip: Split out the common NanoPi RK3528 parts
      arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R28S
      rockchip: rk3528: Split out common NanoPi u-boot.dtsi
      board: rockchip: Add common NanoPi RK3528 board target
      board: rockchip: Add FriendlyElec NanoPi R28S

 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi        |   3 +
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi             |  16 ++
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi       |  10 +-
 arch/arm/mach-rockchip/rk3528/Kconfig              |   7 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS          |   6 -
 board/friendlyelec/nanopi-rk3528/Kconfig           |  14 +
 board/friendlyelec/nanopi-rk3528/MAINTAINERS       |   9 +
 board/friendlyelec/nanopi-rk3528/Makefile          |   3 +
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c   |  60 +++++
 configs/nanopi-zero2-rk3528_defconfig              |   3 +
 doc/board/rockchip/rockchip.rst                    |   2 +-
 dts/upstream/Bindings/arm/rockchip.yaml            |  12 +-
 .../src/arm64/rockchip/rk3528-nanopi-r28s.dts      | 160 +++++++++++
 .../src/arm64/rockchip/rk3528-nanopi-zero2.dts     | 290 +-------------------
 dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi | 291 +++++++++++++++++++++
 15 files changed, 580 insertions(+), 306 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261012-nanopi-r28s-0adc0003f445

Best regards,
--  
安容 <HystericalDragons@proton.me>


