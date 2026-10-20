Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1A606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kJbbfhSn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaK3PaKK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55CE160831;
	Tue, 20 Oct 2026 07:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05HFaXAaXtFT; Tue, 20 Oct 2026 07:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EBA7607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792480877;
	b=QMpvU8fnoUf5LXVcZ9Fx9/4rztA02g+hTRMLZhhBVqqmQdP6Y3UNRZUK917/3tKxm2IZ
	 M7Dk59/zhwn31Ne6PCQIILJoWcxuUwVGgMBMLMLnbqnnUQERD5RUswT2hPK4YnWz820Kj
	 U0DQc5pgIlawJfqJSUSXl5N6dChQtZNwelKaJ2R4qIXvLLunFrSfdKmSyPzYhWR6n0VEk
	 rZU/rYCV96XJD08DFht7rw66p8RDrV3bQeNXaT3o5hONxN1aeJYehrzdJtAnuNw0wpzNH
	 ufF42+LjrwSDUJcX5VDaW4kerC+Y0XTrYZyCtXtptf379fan1d/rghtVum0vUQfprCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792480877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UjbSW1I5s4k0hWV2ro3LZLJ7sx66WuD7fqj11QOsNx8=;
	b=CbIZdrlN83LQwTnEKFu+WQD8alf0Z+oIhPCNFCxEkMXz7w8wiVMLr+n28NZ7u7rgbEAG
	 aWbu4RdwdVrq6r82bzL+RV9AZE65SH432qBl7q2jTfvmrosh6jzS8vLEtIchnYJe27k+l
	 1vQh3hXWcqRH6tHBNe4hh9yDgdrc/jF10ulpcwm0SD6OCOXLUV6SMOwMc8NpD49Pxa+u+
	 PTkhglbSbZQJvLK7RgRPYeYpfbEBMnY4G2johOh75wJdaJor5XjNW/LPTSARaPHIhyyBB
	 w5PdPJr8nUpn/oLxdker9cwkDDQbpDrhHcb8wChBqr5BIQScYdta60sELNr9h+pmQXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792480877;
	bh=UjbSW1I5s4k0hWV2ro3LZLJ7sx66WuD7fqj11QOsNx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJbbfhSnprNw+t7Gogzq47HBsSoee4nxalG8/WqvM4g0+BpHMiXM41vT1cimawqA/
	 ilfSUhd23hu3oyD1wdZccRxlXeuvdmNuKpROFiflXJDwjjyP34fRlSZIz37CGfEFzn
	 6rJQjmZt9FRTRACQWRaTaA9bQWVp/pfXllz4JCcZAl+4hk7MSD4XpWO5+ZxiQAChY+
	 Qo32xsi+nsfaD3RBC+jH1Ttdvl0Hrwawof0NB7cZOt35S0OdexrIESFG8zu3UJIuXm
	 WBNP4Z6HRkz5jlaf1IioSowUl9D0MFxFHgP2WIoQpKzasLMUMPuXmEImfzG11LvX0K
	 /7nkR5JovtSTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EBA7607ED;
	Tue, 20 Oct 2026 07:21:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A70CD3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A49BE407F7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TewyvWEJcIlF for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:21:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C831B405A2
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792480874;
 b=r1oJqo5xavn5z9FxIMDJAJ+Bh7i33VEd0z3eXr4v1xNoeIJx32/U3Ix5NuzBzF47YTH4
 vPaHYDxngrLOvr2T7gjj7rqwuwVONjI5z9sce6/vvQO5DLiO2gdH8VK+HhYcvnbXMMCy0
 7ZJOGQkVqRgkocDWCF94cegWSD/WSSV1WgP59SXOveqTQz72zRWT94G0NDzLZgI0OTODc
 Orn9SoheFLn8+XtlhLRcEGdEvK2fnUpz4pGGrf5SKGMZcNIknY8AnqX6NU7Nz/dS2XJi0
 sJkGNEzPObUSOMFTtqDdtLj3AZIzflUhMunO8+/FrRb7MQJFIt5CZV7uOT0MTzvM1JQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792480874;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=UjbSW1I5s4k0hWV2ro3LZLJ7sx66WuD7fqj11QOsNx8=;
 b=lISw07XLnl++F8DIEdAKpw1XFs4ihmxXDN3X/cDzcXKRJkBPn/M4l/PC7TZhVSiwrJpt
 OUm5UO7DcmKVTByDxdjCpHwREbjlfg+brSeym6dN+Gv/Mz9SgkTBMnKjbJkh7KL1iOEBR
 Cm48VOHiEuuaRPzajwowvyPegYPhJHScHU6YXQJ44pMMUFKd41CZmGUHDyV/pZhjfa2MR
 IHGfy0kd/1x3ek7qNFh1QUjLqDovmw292TH493o2JPNLVRQ5lSIfTKMSZYoFQhZvLCkqJ
 CYfQujHcbVuiCRc9vLvx87OoHo+bjgV6Fg2zgtdctbEDjeC9miNzqU0rYwGsnP/V2pQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JaK3PaKK; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JaK3PaKK
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C831B405A2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:21:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE1F343FB5;
 Tue, 20 Oct 2026 07:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9511F000C6;
 Tue, 20 Oct 2026 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792480873;
 bh=UjbSW1I5s4k0hWV2ro3LZLJ7sx66WuD7fqj11QOsNx8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=JaK3PaKKaAp3B/sacQ1f8LW/lzt/uf3/J72T/Hw1r0yyreaVEBcKfLMpjstk4QVdP
 lJHYCn26Vb/9N8FcwEZ29fM5H2u8n6zx0Drf2vZVUZKo54zihmufUctfAGmTW0Jn62
 reYK5DNcjPZEo6NhHXwXCN34MoOaAAROQ4kGxJqD2C59ZMsHrA+JGCcI0CIHihYv/X
 lY/KvmNZJMwQk1zYA+nXu3IkQhDELw7dUJF+/ZH3ToaCxCh42dI7arbvD2IV9HpwHj
 23456RKdw9SZTvZM2IYxL/Ae3Wf4zjwsgLupGkD4eCqLzAGKJlW7+k0tNfGNwMncoa
 vrA1KXH72hKeQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/5] avb: device lock state, root key provisioning
 and in-place verification
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:21:11 +0200
Message-ID: <xhkdb7bjc6dnc.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the series

On Mon, Oct 12, 2026 at 22:25, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> This series completes the device state handling of the AVB 2.0
> implementation when the state is kept by the OP-TEE AVB TA, and fixes
> the way the Android bootmeth hands the boot images to libavb.
>
> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
> "avb write_pvalue_hex" provision binary persistent values such as the
> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
> consumes, and "avb lock"/"avb unlock" set the lock state through a new
> avb_write_lock_state() helper. Until now U-Boot could only read the
> lock state, so a device backed by the TA could never leave the unlocked
> (orange) state.
>
> Patch 3 makes bootmeth_android verify the boot images in the buffers it
> boots them from, via AvbOps.get_preloaded_partition(), instead of
> letting libavb read, hash and free its own copies and then reading the
> partitions a second time for booting. This closes the TOCTOU window
> reported on the list and halves the amount of data read from storage.
>
> Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
> "unlocked" variable, so the state can be changed with the Android
> fastboot tool. Both transitions erase userdata and metadata before the
> state changes, as AVB requires.
>
> Patch 5 documents the root key sources, the provisioning of the TEE
> digest and the lock state in doc/android/avb2.rst.
>
> Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
> 17 images: the chain boots locked (green) to sys.boot_completed, a
> modified kernel is refused, "fastboot flashing unlock/lock" over
> "fastboot tcp" erase the partitions and flip the state reported by
> "getvar unlocked" and "avb is_unlocked", and QEMU's SD card block trace
> shows every sector of boot and vendor_boot read exactly once.
>
> The lock state is stored in RPMB by the TA; on boards where U-Boot
> serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
> RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
> There is no build dependency.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Boot tested this on khadas-vim3_android_ab_defconfig using the following
AOSP images:
http://public.amlogic.binaries.baylibre.com/ci/build/baylibre/2026-09-17/2026-09-17_yukawa-bp2a-userdebug_vim3_yukawa-android-16_mainline_b25.tar.gz

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

