Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A1606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XPm4lQ0A;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=WJzIPABq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8384608DC;
	Mon,  9 Nov 2026 17:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aeBgnb9fE009; Mon,  9 Nov 2026 17:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AEED160819
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245710;
	b=c9B/TvGwEBzNCysUPHgoXRGec2ljMRCvnTApfL5iM9lauX2Gly3UWNANE1+oXisvgnDI
	 WONa3FcwzN7+5e/whcO+kok3WoYdTJZnfaPNNQa9ASD7T9cHcEpDPDErayXTwRrneAvJh
	 TUaVHWKPmVCgBgA2i0+Ys2hSkKvKn3gdtvxr1zmUDdHf8lMXzKFqcelvHUbjLiiB6Noef
	 6zd1evL/D1emKjS+bb2C1HLFmDH3erAHUylB2ZMEO4QU1zw01rF/Be66jdX+TkYwDwe4C
	 eYYTp/f1ydTznT3i1TI9nIrja/4fKBN7VQRQ7hFNL303MY0FcjO/oaYDdQCAkjR95KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wr6/F2qGRX2OUnnvnnop7VEndLD59wn6J+s5qGOt3Uc=;
	b=W1++7ASi1n5qki7rkt4xw14+6m7l9O8nA+D9c2BgzjVkhKshi6dpDr364VBceSpdv2ok
	 J7l3d0Ka8dSrycByZzCEXJxY/ZtIizSy8vDUqc8YWG+01x4dvRWU+OtMnqRw1LMjvmswl
	 zZpIEt+TVah5AtAAdOVWEEMI3x3GlgOMmQ9TawVWm3hOmbvjdJcFk7GFUB4fNmTffqAGg
	 IzwvH1ZoCipM8NDDTYiHP9W9+qU6C7PyVLIAPM8JwPVQ0EwMGDiUtl+R9UairjKCb7cDa
	 OUf8ou4w8d3J7GscLv+zeVjm/qyIUAbiYCjHq8WhKX2mzvhnCjhtiyZHrP/ZZ5B5+qg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245710;
	bh=wr6/F2qGRX2OUnnvnnop7VEndLD59wn6J+s5qGOt3Uc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XPm4lQ0Ax6z74g+ZIgDOfrmIQadocwFsOA30uT5QpLtmMlGEMZfUTVIh9baMVLIQJ
	 HtIzTI2e9duEHSpvg3xJacVcxopS3qLDwpfIPNTeej+6Dp7hgltHem5p6watFhALJQ
	 oUgOas1a15Xi6UC/EVBhbQxlpqzM3kcv/nib7o8Tgnq2RPYZfx4heSx7my5gkNSSiM
	 f+MkIcMV8q+K9Nz1ZtD3kqOq6vxuiEQhry2f9OJw9lewve5nlDyTUyheGG/kgka/dm
	 CltmiVQ7QYFDFfm7AP6TwvBVN0fpB6Ec4HIjE/QHQmwMyR7mMQQ1JwuKIDH8GIfbPn
	 oELZNQNobzNRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEED160819;
	Mon,  9 Nov 2026 17:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C46D28C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E0724074F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vR6XpUsUwNbg for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0EBE4073F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=WJzIPABq
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0EBE4073F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:35:07 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jNcP34y8dzKmBv;
 Mon, 09 Nov 2026 18:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1794245703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wr6/F2qGRX2OUnnvnnop7VEndLD59wn6J+s5qGOt3Uc=;
 b=WJzIPABqG/nY7oVG8m+cs8CxQBhAjXxohFMoCF0vBdqikmTGbbMPUC6HUXiU02SW0I/lln
 PUcLAmcgCkPLYr96J95mtCuGil9BuKonBqNGLlhds4rL7gupmNQ/NTxjmgSrZhMKF3ZOn6
 aPUO8nhVRiTCEmHdaA8PwSsoj3ADPgV1+iTeCzB7Xhae33FAN/4eACrXD2ZgHFXV1y4Som
 zs5HrqHUqN5oGAe0SK1hlDi8FUJip4ZXznmwCXffjwWHgrOkSaa4xnEXVVTWmxZD0x2g5n
 bsMTIewmaM5zixXLFkxSbIstupZxzi9VZP0KA1miFkmfQIxxGVUDcV1OOvRSkw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <f0f4c3f24d0a9b5afcd72f9fb7ec1d282863d24d.camel@dirkwinkel.cc>
Subject: Re: [PATCH v2 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
From: Steffen Dirkwinkel <lists@steffen.cc>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas	 <ilias.apalodimas@linaro.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao	 <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>,  Julien Stephan <jstephan@baylibre.com>, Chris
 Chen <chris-qj.chen@mediatek.com>
Date: Mon, 09 Nov 2026 18:35:02 +0100
In-Reply-To: <avH_uOLH5Op_WH5j@macbook.homenet.telecomitalia.it>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <avH_uOLH5Op_WH5j@macbook.homenet.telecomitalia.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNcP34y8dzKmBv
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-09 at 18:16 +0100, Carlo Caione wrote:
> On Mon, Nov 09, 2026 at 16:13:07 +0100, Steffen Dirkwinkel wrote:
> > Running u-boot without caches is slow, especially if using rsa
> > signatures. This series turns the caches in u-boot spl and proper on
> > early.
> >=20
> > Measured on an MT8370 module (Beckhoff SM0101, not upstream yet) with T=
F-A
> > BL2 as DDR loader and SPL loading a 2.7 MB FIT (BL31, OP-TEE, U-Boot,
> > SHA-256 hashes) from SPI NOR:
>=20
> Hi Steffen,
>=20
> Could we add the early-cache Kconfig option David suggested, initially
> enabled for MT8188, while keeping the implementation shared?

Hi Carlo,

yes, I'd do it with default enabled for SPL, since MT8188 is the only spl
platform so far:

  +config MTK_EARLY_CACHES
  +       bool "Enable caches before relocation"
  +       depends on ARM64 && !SYS_DCACHE_OFF
  +       default y if TARGET_MT8188
  +       help
  +         Enable the MMU and caches before relocation, using temporary
  +         page tables.
  +
  +config SPL_MTK_EARLY_CACHES
  +       bool "Enable caches in SPL"
  +       depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
  +       default y
  +       help
  +         Enable the MMU and caches in SPL and disable them before
  +         jumping to the next stage.



Or would you prefer the "if TARGET_MT8188" for SPL_MTK_EARLY_CACHES too?


>=20
> The problem I see is that V2 changes pre-relocation behavior for
> all MediaTek ARM64 targets, while runtime testing so far is limited
> to MT8370. A separate option would let other targets opt in after
> validation.
>=20
> Thanks for working on this,
>=20
> --
> Carlo Caione
