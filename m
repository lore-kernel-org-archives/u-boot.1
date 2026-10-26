Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B076606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FFDw+PWz;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=FHPvlimR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35B0060600;
	Mon, 26 Oct 2026 00:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5T92jX69qGk; Mon, 26 Oct 2026 00:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 869616060E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792975921;
	b=dKoduJWITsl2QWmfn2HOh4JbAJPB5rTgEMXmuSPZTBZWTId9YiVWC9E0F+prpymjCp29
	 bahSsnfRsFQIXSSjcjh9k5R0MjQSj1MlLDwjfeD5CEZrCMZzl2ZuoYjZulpciZVHyRT81
	 XZbew5m3+TclhLXf8E87YoyHRWq01/yOt2U5g9c3DW15Ax1dJpIwpe588BsPYkPkuw6Hs
	 AQ/hPYJcNHFwGitzLu5aOmDYRtXhoNTEnb3N0UX1w3XM+2MngRofyffVgxA3eCKf54aZW
	 O/vkXX985FRZm9x116AWQdByH1jx+XZt41fRGntaI33d06Cge3+K6JiikhHttqH5l1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B2w/D+MJt2jDLWCDhvnaT2BbV6pQTi4M3zNHDg4Z0gQ=;
	b=Sp/rdxPGs3FBk1cyPCgYZEuwYtgMEhaVAmVHhuuYWEzfE5mOBgce3eqd212RsoDgsgTh
	 iZ9BN44xkRbGmwn1beYQVMBp9pkT8pxL2uCbyOxhI5e+VfeD1mKRDOUwg9dgMI7P9TTLE
	 cBma2b/Qpi7plhZGJHo99I0HjgJOJrkXRBduYB7yvPU+U5ZxHlZJxMbSK611n7a/Sb1kS
	 SRo/FTUZY9oVEbt5b78wPwzyfYDBlG8xbzTHjECFYix3uguYLEzAta3qHg4nDwB2iU6I1
	 vgEoMpEB0siN7vXrnE6+2j83RkDCFjADOy/WI74S/Ybtb9LMesOLVTH1laDOSMxoe4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=sifive.com;
	spf=fail smtp.mailfrom=sifive.com;
	dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=FHPvlimR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792975921;
	bh=B2w/D+MJt2jDLWCDhvnaT2BbV6pQTi4M3zNHDg4Z0gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FFDw+PWzDW53nd+jJQl6muc7Zfdy7Cx/3KbLqF6gs2x3yljt4EW09w1P580honKzQ
	 xe2uhkhI5RZHAke7IPAFKEG1QsKzG+FZp/YJIxBQvw4vd9OTj+brGMTmPgQELQb3Bx
	 air5EH1YX+bSy85Zf6NjDkKlURFICo89FnLR8JTCAEVp3pMIGwdnucTBtbBkuODunp
	 GzQDyx5PRu34jEiB1KJ44FJuhAGxo557Ywm4IDL1BYwwiE5/Sk7DMO6u3Gd8gtTsQY
	 c5Ka9HLwbUgs9r7mNskCd4QMrerTIlwSGH2FqcnWLTJcvLkX3HFJq8cs6LsOMm80Lf
	 S7ilFNCH1xLOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 869616060E;
	Mon, 26 Oct 2026 00:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED577380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEC7F6060E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EU3GIuQUy_7a for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 00:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1816E60600
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792975920;
 b=aQVK11YYNmFyk4DhMjPwa2QCnhqVzFz3hjzSx/sgkPEA4PdP4W4bi4VkuSVVW28aTUqF
 c/UOgNvTUZ+9ht5hVeqoHXFXKkBzPBjk88z63vQqmUx73qwbLdGV0S9iggr0xYj5ftmEl
 2VJGkd0GEaexuchy9EvPo7+nXNK8WfwYP3OpdT6NdSwG44MbgJcm5PoXuvl+3Z0W15nG6
 o/uzT6O0cVAuT9swIElatsw8JCdfzpT3wq1rF9yPV0zKS68W6qCQ7K7HkxLp/bYXWmvtH
 GSdrhwueeT46cZ13Nusotzq4OeSa3Y/S5Ae22zPqdj2w1VOsYUz3BLbDsWIoh6kULSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792975920;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Virus-Scanned:X-Virus-Status;
 bh=B2w/D+MJt2jDLWCDhvnaT2BbV6pQTi4M3zNHDg4Z0gQ=;
 b=j7NuPJZdAMV1yQb9VLDTlu79MppHKiux1kuX/UgWsEoTEFuEknnbeEiV8l00kMxCQ0oY
 hmMNN5diovx3uSj8PG+tAczTDRQikD/b4w4atmi/ZE0R/qIw01iYhr8Fqcd7Y6xr+JrZn
 MIGW9bUzYAjLqIB4pcGGiRTUjAGn009EMqVkSWEijpr+iXAn6E/Hb6JbLrgYBdtLL9nhU
 mnS1hQEnu7B0oq8lWtPLhu5AZiwo7RBgr9E0g36SHugqdMnvR//IJ8jbpF+hEDWpwFurj
 7FZ6xyWbgt7F/n1GdwkcB+sIcnn6BsbonsBZsJd4aAjYS8b/+HZHz7CeY3P583Np8dA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 spf=fail smtp.mailfrom=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=FHPvlimR; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=sifive.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=FHPvlimR
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1816E60600
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:51:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24068404D; Mon, 26 Oct 2026 01:51:54 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAEAF83108
 for <u-boot@lists.denx.de>; Mon, 26 Oct 2026 01:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leo.liang@sifive.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1616051a91.3
 for <u-boot@lists.denx.de>; Sun, 25 Oct 2026 17:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792975906; x=1793580706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B2w/D+MJt2jDLWCDhvnaT2BbV6pQTi4M3zNHDg4Z0gQ=;
 b=FHPvlimRkaUKylZeGRWd/okWJZolbgIpDemWVRQsi15EmHgvV50MEfv7fAMUoYfDYB
 CJDDQHA+6CgVoxZ9TwdadcyaKn/Q5bU3ZdO7vG0w3Yo9jmm/YOy5QH71X7iWkx2ichLt
 aiHlvxhNV43ioD/4GMC1+qTop2Nq9rTiLOmrr8VqkEQZFMYsFOMTZEfxM7MHFN0I6AAg
 763beQ/cjMR8Cepk9lvBj2Xl6iUFMVTg8jcIjHrN+CcHofezNeuD3mW8tKvMEH6B/lH6
 /h8QlsbVf8dGyIcynaRufAaj5V/+F6xPiHZjyk6KfoQEPoKS0X0CRN4m3EXCUDELcFiv
 yXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792975906; x=1793580706;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B2w/D+MJt2jDLWCDhvnaT2BbV6pQTi4M3zNHDg4Z0gQ=;
 b=ZC3AnktSKuj7iCQl0ntcQWMkndQOZwENbRZwNX8HFsVMZWe0zSr3pJu9pEAg14ilto
 sSYQngOur2AaN+ZJUT6k3u+wDdjtqNbMBCVkQR4/I5/dD2t051j9gP/vp48vekqiruCi
 1LDsHsbTaIZGD8ypXCGFF68vLpYsZTCB6+lxIfhFqK1ldShpNn55Df+pv4lDPJq6zxjO
 gdSkbMsHn8nkZScIiopuPVyhvjdHQPPpVeawe3nSi7Izbf3rhnrDhHxEkRXREMT9/kVH
 TQql3CFmbex6k8M85lRpjQ6ASanPBSRcFrJr5/qijXWbU9Qo+HGvitg9smFIzL6sldlo
 SgCA==
X-Gm-Message-State: AFq9FYJvKV2FNaMjmi4n1ZCPrp6q7iCLO08vYOqr4P/jm0WJ1vXkP5kk
 wejdlKn3UAoPaPcox3qavtzqli3CiO4v5reFxyZVOC4te6zvryE3HwS2FdLlfeFwhVQ=
X-Gm-Gg: AYBFou0dTd8k2qzJerwlPDSK2c1Cu2WccEHzC7ySvIokpYPVDFbyyQgxp1j/YG6p5Kj
 NVDrabogHoG/J86bTcvNJ+Q+M417WAqPThH6bwVq/0Y9Am7qBqKg1wIXihVrEjae5i7HHSwtw3T
 7GHGXBVwN3sVbNUbfGnn9Mef8kr1GncyerFUe0/ObCEnBHyVQfHVnsefKDp7/6kKyhsmq4bLtWA
 L5ngWoUROqKQEpKTxy/+wm2z6QsU7Yp//SII2qkycgpAoc09KhzidggyceXVaTo1qVzeMX3g3oL
 GebosXh4FN6lcSWrSt4okmLQBZ+woBQ/nFmocVrxzyi6YQ/nyM58pJVBh2myXv992Ru3UFHPrwX
 PjwR9qVrpKyXix0xSLCVoWYoBQAGESrwyNhdqy4MQksvJcyCVc+3Pi/hgl1m/LyIQ9vOTfAiCNz
 C+Z5lbsi5rntE5+K5bf/9MiON/qqkexVHX51VEdzh+2ydpTYXK+n9m1JcDaYLyZSEs7L0Snp8n1
 vlBiF/LuNH7rraizdhsGDdysqSaI4WiYusQxwRhCReXDuHqKPtbNbh3Y7B/1pxVLo5fygq3
X-Received: by 2002:a17:90b:4fc9:b0:3ac:86a0:5766 with SMTP id
 98e67ed59e1d1-3adeb164babmr4281654a91.63.1792975905964; 
 Sun, 25 Oct 2026 17:51:45 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebaca7casm6220813a91.4.2026.10.25.17.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 17:51:45 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:51:39 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Tim Ouyang <tim609@andestech.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 0/3] riscv: mpfs: move system controller configs to CPU
 Kconfig
Message-ID: <at6kG7CVLdxkbaRa@lliang-1876.localdomain>
References: <20260917094452.1043879-1-jamie.gibbons@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917094452.1043879-1-jamie.gibbons@microchip.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 17, 2026 at 10:44:49AM +0100, Jamie Gibbons wrote:
> Hi all,
> 
> This series moves the PolarFire SoC system controller related Kconfig
> implications from individual board Kconfig files to the common MPFS CPU
> Kconfig.
> The following config options are currently implied separately by MPFS
> boards:
> 
> DM_MAILBOX
> MPFS_MBOX
> MISC
> MPFS_SYSCONTROLLER
> 
> These options are SoC-level requirements rather than board-specific
> features, so enabling them from arch/riscv/cpu/mpfs/Kconfig is a better
> fit and avoids duplication across MPFS platforms.
> 
> Thanks,
> Jamie
> 
> Jamie Gibbons (3):
>   board: microchip: mpfs_generic: drop system controller Kconfig selects
>   board: beagle: beaglev_fire: drop system controller Kconfig selects
>   riscv: mpfs: move system controller config to CPU Kconfig
> 
>  arch/riscv/cpu/mpfs/Kconfig          | 4 ++++
>  board/beagle/beaglev_fire/Kconfig    | 4 ----
>  board/microchip/mpfs_generic/Kconfig | 4 ----
>  3 files changed, 4 insertions(+), 8 deletions(-)

For the whole series,

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
