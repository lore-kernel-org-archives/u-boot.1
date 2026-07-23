Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57C3C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64AFE608FD;
	Thu, 23 Jul 2026 12:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUiSAiYrOt_L; Thu, 23 Jul 2026 12:48:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DFAF60792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784810894;
	bh=HPPNyjGpOj02ldoHLipyf28hPI1Z2GLHiUCN6vdqdBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YO1W+Y1ckdJMzeriLZ+0rEHKdz7wFiblp+47p0ODOiViQ930M/1Hebc3aOMoAXkMW
	 eGYSOwBsZaBLUraZafF3GQd3PxcLSnDSMIozVuGReztzKjWJko66f0r5zlNZnoVw/w
	 mtXeyvOuGL9vs13CZ6Haf1doTygPclqLmdCiXj41VAzUAJRsq4byI4YbuVHJJUYyfE
	 s4loxcIwo8a+Z3LYdwhMK/u3cEcU/PXGsOuj4GzTRiSErYY3EW1eCMMDoHNFNJbzx+
	 QHLr9CvEpzMISTqI7qQP+ZQFD0MjZtxZSM+Nxsb+bJqlAUr0p7UzAbMUA3yVLRvtt2
	 pkTtsg548M8Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DFAF60792;
	Thu, 23 Jul 2026 12:48:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 450DC3B1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4284C8104D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXGo1d5RknZg for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:48:12 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7839D81016
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7839D81016
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7839D81016
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:48:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940BC803F6; Thu, 23 Jul 2026 14:48:10 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D80880117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:48:07 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B0FB600FC;
 Thu, 23 Jul 2026 12:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319211F000E9;
 Thu, 23 Jul 2026 12:48:05 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, "Nicolas Belin
 (TI.com)" <nbelin@baylibre.com>, Francois Berder <fberder@outlook.fr>, Sam
 Protsenko <semen.protsenko@linaro.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 1/2] boot: android: fix AvbOps and verify-data leaks in
 AVB path
In-Reply-To: <20260712-avb-fix-memory-leaks-v1-1-51d6d5a42631@gmail.com>
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
 <20260712-avb-fix-memory-leaks-v1-1-51d6d5a42631@gmail.com>
Date: Thu, 23 Jul 2026 14:48:03 +0200
Message-ID: <87bjbx98jg.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784810885;
 bh=HPPNyjGpOj02ldoHLipyf28hPI1Z2GLHiUCN6vdqdBM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=JndiaXTKHEQXsQlPkUiJha9iz7Q+dMiQAq4+fxfblNgYYllSnNDg20qsXkimfstnW
 sTYzjYG1vRPxp3mcv1BcheFVrWbrFP3HaVjFj6/RB/OoyGrxK8de/L73CC3P6VC2nU
 ffcffrzODOLFYGFtz8I9Hpircl1q4uX0Hwifm+JSZaRlj+iLRSNqsfG7fhTnWiJmT5
 /SqCdK+t0rS0LEXkQgxhKls7b+owM9EAcNV/OIax4yZ4MHk4fUBxGgavbr3QZsI/a+
 Gw/57zt0dF+rOxkB6s8UrASPtilptWxgtKg9/aeUhzaoMx3vrFQZcPtGGV8zs5l6na
 flAUgZ9aDr6AQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JndiaXTK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="JndiaXTK"; 
 dkim-atps=neutral
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Igor,

Thank you for the patch.

On Sun, Jul 12, 2026 at 10:50, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> run_avb_verification() allocates an AvbOps via avb_ops_alloc() but never
> frees it on any return path. Every Android boot attempt therefore leaks
> the AvbOpsData structure and, when CONFIG_OPTEE_TA_AVB is enabled, leaves
> the OP-TEE session open (it is only closed inside avb_ops_free()).
>
> In addition, the AvbSlotVerifyData returned by avb_slot_verify() is only
> released on the failure branches. The successful "return 0" paths (both
> the locked GREEN/OK case and the unlocked ORANGE/ERROR_VERIFICATION case)
> return without freeing it, leaking the whole out_data (cmdline and loaded
> partition metadata) on every good boot.
>
> Route all exit paths through a single cleanup label that frees both
> out_data and avb_ops.
>
> Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Good catch. Thank you for this!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
