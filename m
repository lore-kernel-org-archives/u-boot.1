Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF1606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RqHTGTBe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOmpN/sG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D18C460B21;
	Thu, 19 Nov 2026 09:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDKHIwqilv7w; Thu, 19 Nov 2026 09:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9980C60622
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795080687;
	b=D0SPX3yz85IOzGLtN2yzFgo8v8ud/v3lDaEWblPUZTw2wovAxmL4H4zYVptNI59cmbIh
	 I7BU+c2clQRlyrC5DEXh1zNhDopIGW7rMI3OQt46f/+piqcfIMqtVfjdWDq5O9WjDcr+F
	 kIxJLhy/TQ7uikJULsI+dbXqmExHq46RCwNvWZrWS9Ks0tomjOhEAgH1tRiCVMRKtoeD5
	 ClL+OK9L8/bt85dLfOgfkP2EZ2OAJTLMO9xN2Evsu25iAFZdOLJtaQRztlaw3/jYLUcRL
	 gq+4ZdBMK558ejhkpSg3YrCkhmh4+hLZ0OZ2bZ5CetByL03xJkfu4ArTeNHZuo3cHBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795080687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QqXBkU+UMG2FDReKXdl1Lxa4s5zATlzq3G9tdPIUZNY=;
	b=CJ06Ug6QPV8FabzFbUDEi8hH6cIW4+dou17eopAT59vUdXIYBoDIPTGYMkj9Ktzc3kE6
	 BoCkKfobg8T1FUQDL6tu/eUemI7WcjRq3Xut0BA/5xfncXgHhrajnxq2HxNFYxf/fR6bT
	 6Ori6s4O61/4EKVc47EWDcEI0pl+AdBRzgPqcHUV46svPTlaGkr08vq5mCMS2BNuIu/Zr
	 FpfW+9yVAgIfH18Kqh1Lsfb6VlcrGqILTVYfDs956NPR7j0N0Oq99eS9sebFzjobVMvEo
	 cqW1dBVcMldixobnNAbZJEX1tN+SRFWR50Pgi7a948M/mq6mdbAA7RGVJqRTqEuJtmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fOmpN/sG";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795080687;
	bh=QqXBkU+UMG2FDReKXdl1Lxa4s5zATlzq3G9tdPIUZNY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RqHTGTBeI4Hm/zBqyPpMMddGWqeoT8S1JBMoJCJbo99AwjF3HXpxTsCfipL5xiJAs
	 fBbhF0fepxxKIHbJ41/y57h6DHmRiIrOoWnuzfEdZZG186rwBLvEBphPvEe1yooG7U
	 XjOx/j7z7tr3/yvlmU6MeP34w7yLr5HOMhshwYOL8AgKv++ls+jcnmBCKndMhm06Df
	 OkCMWEQcaWDRyHjYu2FWFmzxUu+unsGWDrJ1lTUBnuMpYxAlW8v5FqAeyK1CKBeToK
	 4cwyn8iPYlWbDIip7lag8yxC/dfyXCyN8uzuI+BaHzlQwyxKRBWJcz8qyTPhdNgm30
	 R44PfU/xb1sEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9980C60622;
	Thu, 19 Nov 2026 09:31:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2347970B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 096FB60622
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFlNkYOmHIfH for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE75860896
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fOmpN/sG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE75860896
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3622621AD;
 Thu, 19 Nov 2026 09:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA371F000C4;
 Thu, 19 Nov 2026 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795080682;
 bh=QqXBkU+UMG2FDReKXdl1Lxa4s5zATlzq3G9tdPIUZNY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=fOmpN/sG4yU4K7hBxTN1do4sY4XXrJDci6NwhvNeE/AwNe61DPL36a9ncIHCxGpGf
 xV8yLGtmCrMerWuuui940mt4Mudh+jHkVbEhwuonq4k2Al2awy90GKPF3O9J4lKJ96
 GGvRAakB1yvCNXzups3OCbo/kotlvvsY3H1CjOSHMFSodFF0Cm4hYaNzqPxm3HC1Za
 WGjHgRL641y4T1lK0n2DjRFqcEtdAfHuA93DJXHuiTd8imCp9hyg9eoCplMQ8MCgv5
 WBJu6k7qJtNJEZwTm9teKwCrEpwhDsHHw15Er56LCveZ9mIMi0lwk03066qp2qmjX3
 o7OVrH61dIXwA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] android: sync bootloader_message.h with AOSP (misc
 system space)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-2-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
 <20261111-upstream-android_rollback_misc_b4-v1-2-47d17e8a5d92@gmail.com>
Date: Thu, 19 Nov 2026 10:31:14 +0100
Message-Id: <179508067427.516692.994258223515304798.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6821;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=GhZM9VWKBNu2AjVzJMScdCjxl2DBGYQRdgM/l5y3QgE=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9a/g0+zf1hE/FrGW+SZFyy08706Y2zHQ79KtUReHW85y
 wlbKg92MhqzMDByMciKKbLovXRavk0+a1+w8FoGmEGsTCBTGLg4BWAiLH4cDBvTliznnJ+dVxx6
 z/5jmaDaNHvF5V3m3Xoimp2zJpWcKfb7H+PyTPK8ku6io1xZvmYz0g8YqO5UzTbXkrGvUVKN+Fo
 bmPCxJSUjlnNr7lT/c9tzE/KUXx5aZJi7/rfh9MUfmxf+unX7tuNExmn31lnoz3AQkVh4N0hy5Z
 cW+W3F8lP7Dj/SEdt1RGZ9Xt2NJ6umSk+PrBJ+Vmtf+8GGW+Dph0qHdB2elM18Ry+32dqEXQr84
 nOl+u32hVvM9oX+qZn5TaN7xTa2noLaW1v/mmRsURTg4ebmejLh3KwqZ7n/n/nUDda9mZPHqJVg
 tKjp3cS+DxHs9acO7lBcFLbtIotyktAXHy5Lrh0lz2LCAA==
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

> Android uses the "system space" of the misc partition (32 KiB in) to
> pass messages to the bootloader: the Virtual A/B merge status, the Arm
> MTE mode and kernel command line flags. Add their definitions from
> bootloader_message_core.h at android-17.0.0_r1 [1], copied verbatim like
> the rest of the file so that later syncs stay a plain diff.
> 
> [1] https://android.googlesource.com/platform/bootable/recovery/+/refs/tags/android-17.0.0_r1/bootloader_message/include/bootloader_message/bootloader_message_core.h

I've downloaded a copy of the above repo, and using the
android-17.0.0_r1 tag, I see some differences between the AOSP file and
the copy we have here.

I do think that these diffs make sense (for example, using static const
instead of constexpr).
However, it feels misleading to me that we say it's a verbatim copy
because it's not.

Please reword the commit message.

More details below

> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>  include/android_bootloader_message.h | 92 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/include/android_bootloader_message.h b/include/android_bootloader_message.h
> index 286d7ab0f31e..9092f74c4db8 100644
> --- a/include/android_bootloader_message.h
> +++ b/include/android_bootloader_message.h
> @@ -27,11 +27,15 @@
>  // 0   - 2K     For bootloader_message
>  // 2K  - 16K    Used by Vendor's bootloader (the 2K - 4K range may be optionally used
>  //              as bootloader_message_ab struct)
> -// 16K - 64K    Used by uncrypt and recovery to store wipe_package for A/B devices
> +// 16K - 32K    Used by uncrypt and recovery to store wipe_package for A/B devices
> +// 32K - 64K    System space, used for miscellanious AOSP features. See below.
>  // Note that these offsets are admitted by bootloader,recovery and uncrypt, so they
>  // are not configurable without changing all of them.
>  static const size_t BOOTLOADER_MESSAGE_OFFSET_IN_MISC = 0;
> +static const size_t VENDOR_SPACE_OFFSET_IN_MISC = 2 * 1024;
>  static const size_t WIPE_PACKAGE_OFFSET_IN_MISC = 16 * 1024;
> +static const size_t SYSTEM_SPACE_OFFSET_IN_MISC = 32 * 1024;
> +static const size_t SYSTEM_SPACE_SIZE_IN_MISC = 32 * 1024;

In the original file, these are constexpr:
https://android.googlesource.com/platform/bootable/recovery/+/refs/tags/android-17.0.0_r1/bootloader_message/include/bootloader_message/bootloader_message_core.h#50

I understand that we can't have that in U-Boot, but we should mention in
the commit message that some U-Boot specifics adaptations were needed.

>  
>  /* Bootloader Message (2-KiB)
>   *
> @@ -81,6 +85,92 @@ struct bootloader_message {
>      char reserved[1184];
>  };
>  
> +// Holds Virtual A/B merge status information. Current version is 1. New fields
> +// must be added to the end.
> +struct misc_virtual_ab_message {
> +  uint8_t version;
> +  uint32_t magic;
> +  uint8_t merge_status;  // IBootControl 1.1, MergeStatus enum.
> +  uint8_t source_slot;   // Slot number when merge_status was written.
> +  uint8_t reserved[57];
> +} __attribute__((packed));
> +
> +struct misc_memtag_message {
> +  uint8_t version;
> +  uint32_t magic; // magic string for treble compat

This is indentented differently in the original file. Why did we change
it?

> +  uint32_t memtag_mode;
> +  uint8_t reserved[55];
> +} __attribute__((packed));
> +
> +struct misc_kcmdline_message {
> +  uint8_t version;
> +  uint32_t magic;
> +  uint64_t kcmdline_flags;
> +  uint8_t reserved[51];
> +} __attribute__((packed));
> +
> +// holds generic platform info, managed by misctrl
> +struct misc_control_message {
> +  uint8_t version;
> +  uint32_t magic;
> +  uint64_t misctrl_flags;
> +  uint8_t reserved[51];
> +} __attribute__((packed));
> +
> +#define MISC_VIRTUAL_AB_MESSAGE_VERSION 2
> +#define MISC_VIRTUAL_AB_MAGIC_HEADER 0x56740AB0
> +
> +#define MISC_MEMTAG_MESSAGE_VERSION 1
> +#define MISC_MEMTAG_MAGIC_HEADER 0x5afefe5a
> +#define MISC_MEMTAG_MODE_MEMTAG 0x1
> +#define MISC_MEMTAG_MODE_MEMTAG_ONCE 0x2
> +#define MISC_MEMTAG_MODE_MEMTAG_KERNEL 0x4
> +#define MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE 0x8
> +#define MISC_MEMTAG_MODE_MEMTAG_OFF 0x10
> +// This is set when the state was overridden forcibly. This does not need to be
> +// interpreted by the bootloader but is only for bookkeeping purposes so
> +// userspace knows what to do when the override is undone.
> +// See system/extras/mtectrl in AOSP for more information.
> +#define MISC_MEMTAG_MODE_FORCED 0x20
> +
> +#define MISC_KCMDLINE_MESSAGE_VERSION 1
> +#define MISC_KCMDLINE_MAGIC_HEADER 0x6ab5110c
> +#define MISC_KCMDLINE_BINDER_FORCE_RUST 0x1
> +#define MISC_KCMDLINE_BINDER_FORCE_C 0x2
> +
> +#define MISC_CONTROL_MESSAGE_VERSION 1
> +#define MISC_CONTROL_MAGIC_HEADER 0x736d6f72
> +#define MISC_CONTROL_16KB_BEFORE 0x1
> +
> +#ifndef __UBOOT__

I understand why we need the #ifndef, but again this is not a verbatim
copy

> +#if (__STDC_VERSION__ >= 201112L) || defined(__cplusplus)
> +static_assert(sizeof(struct misc_virtual_ab_message) == 64,
> +              "struct misc_virtual_ab_message has wrong size");
> +static_assert(sizeof(struct misc_memtag_message) == 64,
> +              "struct misc_memtag_message has wrong size");
> +static_assert(sizeof(struct misc_kcmdline_message) == 64,
> +              "struct misc_kcmdline_message has wrong size");
> +static_assert(sizeof(struct misc_control_message) == 64,
> +              "struct misc_control_message has wrong size");
> +#endif
> +#endif /* __UBOOT__ */
> +
> +// This struct is not meant to be used directly, rather, it is to make
> +// computation of offsets easier. New fields must be added to the end.
> +struct misc_system_space_layout {
> +  struct misc_virtual_ab_message virtual_ab_message;
> +  struct misc_memtag_message memtag_message;
> +  struct misc_kcmdline_message kcmdline_message;
> +  struct misc_control_message control_message;

Same here, original file does not have "struct" prefix

> +} __attribute__((packed));
> +
> +#ifndef __UBOOT__
> +#if (__STDC_VERSION__ >= 201112L) || defined(__cplusplus)
> +static_assert(sizeof(struct misc_system_space_layout) % 64 == 0,
> +              "prefer to extend by 64 byte chunks, for consistency");
> +#endif
> +#endif /* __UBOOT__ */
> +
>  /**
>   * We must be cautious when changing the bootloader_message struct size,
>   * because A/B-specific fields may end up with different offsets.

Side note: the ifndef is now #ifndef _BOOTLOADER_MESSAGE_CORE_H in AOSP.
Should that be changed here as well?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
