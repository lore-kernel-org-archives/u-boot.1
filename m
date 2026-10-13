Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2327CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19260809C2;
	Tue, 13 Oct 2026 13:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBh-l7pzn4Mk; Tue, 13 Oct 2026 13:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AB2D8096A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896596;
	b=cHm5hT3G2k/NSHKnHIFLuyE39dX8HpmXpi1OknXLiJvp/0afNV8O6JRCI2EHxG6hYCQP
	 2n7nQDvZvteAqw128aJVxaceoFnydo/DKSNFhe8fV99/MiSlRg13u7Aehs+cIPoLtvluj
	 hG8reza82/NqTyWvzvwcMP4YKFD3Ni8IAp6JwS9/9WOayUl0WGFCs83hMh3cVUFhis37i
	 fSMwncqrXVR3T4Gt9o4i2gissCJ4m1znVAtvuuvRNl17ZCCFaMbgSI18TNtEFDdmg33kF
	 R6TJMRu49xC+XPAcl1GOHiXCraNQkx+3B89hoF8S8BHTt3A0qxp7qpjn1IltQbmZ+Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iLYvdCOJIEipugul/wwTryz3hoFRptKeyF4ttb9+RXQ=;
	b=BADHM/F/Ihh8gwB89nj2N0m+X6Ctq4SmsNAHPjqIvZ9lSXv6sXcT/C7q16brZpj9iOo1
	 RQXLpTB6S0dsech3wmqYD2XqIiP7dU64uBJcO/e2speT30acWIGn6D2eIneSbPX+Nopa0
	 xWja3+3VXx4CRiZCzTjgoyRadCJsVMJ4Cpko9WbFtgGW0topg1JuNhs/rVhR6Up0NEWF1
	 QG+Bjy4AqWO6rCbBR9sKgW5YyFdXwiOVWI9oF0LMSoupjLbMOu5r8rXRq6a1Yrz2BahxZ
	 sqqR/1ajw6xGZoykOSOrtwGDh77cUfHP1ugvbNRHuwvUAOEqCsRYh/nKcoaW0gmfnUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zhuypkbb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896596;
	bh=iLYvdCOJIEipugul/wwTryz3hoFRptKeyF4ttb9+RXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PVV3BcngiZdpx0xYjZ0egWt3ZC7/6tFy1lXjkqSrh9/D/wBuCVuyxI8QLxWyofqR9
	 d5bbLiT41K/QE38GUIQkMpx6LNSpoVkDKv9OFZ8kbQF7cbSrlAsRX00FKNU61RYi+w
	 Olxj2bpp0TVP1NkzLpNrRsoOVKR9kb/HFw0+TgYLLh1mSA8LnKAdd4Y+3y7gKfsMEt
	 oTZjwX/+bHKYB3NPLpbRhOM4oBR4L5uw3yHZLqFxo97Kccnlo3D+u3at+him0jR21S
	 fRWveZiU8f99hEJwEkpJoTsLqNFlPsX9lY+8bJWbZVNiGIZ7Y0SjuJkUZ3QIADFOjH
	 4DCkKrdKkTN3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AB2D8096A;
	Tue, 13 Oct 2026 13:03:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FEA5788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71BA380849
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4ASpVchL_uA for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 789F48096A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896594;
 b=DTy7k8iaAVFpttXhZF/Dtb6eflQHQFEBKGLtH/Ldj6ylKp7c/VQNyBmro5osDLy3V+6S
 WuyXm2p8sHJK3n/T8GqiFhdaVwh/hoQyBV8sDQK7Vdg8GK09D9z9awPTIDy3/uFpnMsoZ
 qT7B+RnRbvK3gfBuY5RDBcqtRO9LRsC5WpzTujUA+EmFIZvh/Fb3aXu8PI/PgzI/8WAS0
 0ZqbJ4nfEnLzFJUW5jbylPMdBddDPb7Tvw/8TreOFGHsfiHpdxNIp6fXC/HbWei6Ewh3B
 Zgvkqe7jNJ1pI1QH+NMnQmSVxEt8Bm/DPRUwDgye6vRIvf2MPcAMgcYMHk5qmTNHr3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896594;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=iLYvdCOJIEipugul/wwTryz3hoFRptKeyF4ttb9+RXQ=;
 b=McgkvH89qAvoEa4SkYwcmYbqsfDSU6t9lfwuFEpSsCZyMG0/fG9oDIBhnxT15Z0WINm0
 Ifh2gS6Tr1udCImh+k506fPUzYYK0whHtAcuCXNX4Ldp820z/kcFf8qPI6yGH3segIAXA
 VJ/m/pZPQmKDQGKEyRjCeTn0oijKOgK9NTAWqcx6EFHbO71gudDIS/IyTk9sAaG2qSS1j
 O0a2MVgHqCMD5hGOTV5Z7k1eZHuhqe6A47cAkDMhcKfM7MzxGwvU6v6E9HQtgNifAq/Z6
 4ZVyT5RAFG3L6tY74RPxuxFhW9hzw+kX4v3Oz97ywuA7d71Aq29pyCY4jw40nUptKKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zhuypkbb; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zhuypkbb
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 789F48096A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3866960A5A;
 Tue, 13 Oct 2026 13:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED961F0089E;
 Tue, 13 Oct 2026 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791896591;
 bh=iLYvdCOJIEipugul/wwTryz3hoFRptKeyF4ttb9+RXQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZhuypkbbGveUdwBhWIFPpTk7ZC8u3Rn/N++eZFuwuxC+dR3ArJ1dC6hosy/gZmqpo
 vE5jsCB30SYqz7ikmDUlIVATs0vAjovNoGEHfzMpj6W+d0C6i6XA1Ed+Zqp+t4MKKT
 Z22DixRJ/h582Vk/zzloAejK5qxmgqLHluYs0JAdZwDbi4fZXCBgEzizL2pHEZGmz9
 tOqMBJdkxfktrFHnLEZ6ZigEV1fP6HUJTqJtAWGiB0mnkSIgZ8HJr+1FbcXHSghu2Q
 4A2UFKZij+BJTHxWeou9dgYwu+81Rxae5hZ3PzFDT+J2FBD47FoPzbOKi0Pk955C5b
 e6uBm4Li3hyHA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com, Jan Kehren
 <jan.kehren@emteria.com>
Subject: Re: [PATCH v2 0/2] avb: Support verified boot from non-mmc storage
In-Reply-To: <20261006092732.3577974-1-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
Date: Tue, 13 Oct 2026 15:03:09 +0200
Message-ID: <xhkdbpkxd7nxu.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jan,

On Tue, Oct 06, 2026 at 11:27, Jan Kehren <jan.kehren@emteria.com> wrote:

> Thanks for the review, and no worries at all about the delay.
>
> AVB in U-Boot assumes its partitions are on mmc. bootmeth_android accepts
> any bootdev but passes only the device number to avb_ops_alloc(), dropping
> the uclass, so an Android bootflow found on nvme 0 or usb 0 is verified
> against mmc 0.
>
> Patch 1 is the rename, split out as you asked, with no functional change.
> Patch 2 adds the uclass and the optional "avb init <interface> <dev>" form.
>
> On your bootmeth_android point: it has other mmc-specific logic such as
> bootflow_iter_check_mmc(), so booting Android from another medium through
> bootstd needs more than this series. The avb_ops_alloc() hunk here stops
> the verification being aimed at the wrong device; the rest is left for a
> follow-up.

Yes, it's fine that this is a follow up. bootmeth_android documents this
limitation (mmc only) so it can be later on.

>
> Tested on Raspberry Pi 4 and Raspberry Pi 5, verifying and booting Android
> from SD on both and from USB mass storage on the Pi 4. Those boards boot
> through a downstream command rather than bootstd, so the bootmeth_android
> hunk is build tested only. On the Pi 4 "avb init usb 0" then "avb verify
> _a" passes, "avb init 0" still resolves to mmc, and an unknown interface or
> an out-of-range index on either bus is rejected without disturbing ops that
> were already initialised.
>
> Build tested with khadas-vim3_android_defconfig and
> khadas-vim3l_android_ab_defconfig; each patch also builds on its own.

I have boot tested this on Khadas VIM3 using
khadas-vim3_android_ab_defconfig with bootmeth_android.

I've also used the following AOSP images to do so:
https://public.amlogic.binaries.baylibre.com/ci/build/baylibre/2026-09-17/

The board still boots android, with your changes.

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Jan Kehren (2):
>   avb: Drop the mmc naming from the block IO helpers
>   avb: Take a storage interface in the AVB operations
>
>  boot/bootmeth_android.c                |   2 +-
>  cmd/avb.c                              |  24 +++-
>  common/Kconfig                         |   7 +-
>  common/avb_verify.c                    | 167 ++++++++++++++-----------
>  doc/android/avb2.rst                   |   7 +-
>  include/avb_verify.h                   |  38 ++++--
>  test/py/tests/test_android/test_avb.py |  28 +++++
>  7 files changed, 181 insertions(+), 92 deletions(-)
>
>
> base-commit: 25a459fd4d2eeef909dd4ea8a577ba82b1fc5e43
> -- 
> 2.43.0
