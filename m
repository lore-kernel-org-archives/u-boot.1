Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB935EA3C24
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 10:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F377E839D5;
	Thu,  9 Apr 2026 12:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OQ8hZLox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD458407E; Thu,  9 Apr 2026 12:21:26 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E19883693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 12:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D3AE3442A5;
 Thu,  9 Apr 2026 10:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3718AC4CEF7;
 Thu,  9 Apr 2026 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775730081;
 bh=byX3MAt0xoGVBNGCIRGT+OC364wMzNmo1OEpASfQo30=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OQ8hZLoxEbufQCKTEQ3H+V4ulHzrLjgHvaoAkPp/o/Q7uP3L/6p913IIyDGIZjAvl
 M8UEmyjpJya5oUs78qIGkhGY8BpXjO+Khh4GirIORqaBLPIUOAqrn7RcMPVWniGMAN
 s4nEK/fUi6xP+gupx8MjMTrFakNU4Ezc7GnsMasfZFpiC3x+z+tCm1yhE4Oos3BUEV
 8t4dOZvgYTVRBpraXwghY2f+0wqIFXAJHZupA66WFgNTAjRIL/+axZRPSUEFUQz/MS
 ueoK4IqOWpdNgfX/I22iIyVjuo06t3ly3dbAPyxwqDRaB9HNnkIEJzONaIFpDxAYB2
 cLHQFolw7r1Jw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Colin Pinnell McAllister <colin.mcallister@garmin.com>,
 u-boot@lists.denx.de
Cc: Colin Pinnell McAllister <colin.mcallister@garmin.com>
Subject: Re: [PATCH] android_ab: fix slot selection
In-Reply-To: <20260313201415.255744-1-colin.mcallister@garmin.com>
References: <20260313201415.255744-1-colin.mcallister@garmin.com>
Date: Thu, 09 Apr 2026 12:21:18 +0200
Message-ID: <87zf3ccu3l.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Colin,

Thank you for the patch.
Sorry for the late review. For some reason I have not been cc'ed so I
missed this.

Please use ./scripts/get_maintainer.pl -f boot/android_ab.c next time
you send a patch.
See: https://docs.u-boot.org/en/latest/CONTRIBUTE.html#contributions

On Fri, Mar 13, 2026 at 15:14, Colin Pinnell McAllister <colin.mcallister@garmin.com> wrote:

> The boot selection rules state that a slot is bootable if it is not
> corrupted and either has tries remaining or has already booted
> successfully. However, slots that have tries_remaining == 0 and
> successful_boot == 1 will be disregarded when picking the slot to
> attempt.

Can you please give me more references to the boot selection rules?
Is this just the code comment that's mentioned (boot/android_ab.c:276) ?

I've checked:
* https://source.android.com/docs/core/ota/ab
* https://source.android.com/docs/core/ota/ab/ab_implement
and it's unclear to me from that.

Then, I've looked a bit at the default bootcontrol AIDL hal at:
https://android.googlesource.com/platform/hardware/interfaces/+/refs/heads/main/boot/aidl/default/Android.bp

It seems to be using libboot_control as a static library.
libboot_control tells us that a slot is considered unbootable when:
tries_remaining != 0;

See:
https://cs.android.com/android/platform/superproject/+/android-latest-release:hardware/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=332?q=libboot_control

>
> Update the selection logic so slots marked successful remain eligible
> even when their tries counter is zero. Also include the successful_boot
> state in the unbootable-slot debug output.

What happens if the tries counter is zero and we attempt to boot with
dec_tries=true? In that case, we will decrement tries_remaining which is
an uint8_t (see: android_bootloader_message.h).

>
> Signed-off-by: Colin Pinnell McAllister <colin.mcallister@garmin.com>
> ---
>
> An alternative would be to keep the existing behavior and update the
> comment in boot/android_ab.c:276 to remove the successful_boot
> condition. I do prefer updating the logic to match the documented rules.
> Currently, the userspace AB code will need to increment the tries
> counter for a slot that has booted successfully but has no tries left.
>
>  boot/android_ab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 13e82dbcb7f..93e74f81d4b 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -289,11 +289,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>         slot = -1;
>         for (i = 0; i < abc->nb_slot; ++i) {
>                 if (abc->slot_info[i].verity_corrupted ||
> -                   !abc->slot_info[i].tries_remaining) {
> +                   (!abc->slot_info[i].tries_remaining &&
> +                        !abc->slot_info[i].successful_boot)) {
>                         log_debug("ANDROID: unbootable slot %d tries: %d, ",
>                                   i, abc->slot_info[i].tries_remaining);
> -                       log_debug("corrupt: %d\n",
> +                       log_debug("corrupt: %d, ",
>                                   abc->slot_info[i].verity_corrupted);
> +                       log_debug("successful: %d\n",
> +                                 abc->slot_info[i].successful_boot);
>                         continue;
>                 }
>                 log_debug("ANDROID: bootable slot %d pri: %d, tries: %d, ",
> --
> 2.53.0
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use of the intended recipient(s) and contain information that may be Garmin confidential and/or Garmin legally privileged. If you have received this email in error, please notify the sender by reply email and delete the message. Any disclosure, copying, distribution or use of this communication (including attachments) by someone other than the intended recipient is prohibited. Thank you.
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use of the intended recipient(s) and contain information that may be Garmin confidential and/or Garmin legally privileged. If you have received this email in error, please notify the sender by reply email and delete the message. Any disclosure, copying, distribution or use of this communication (including attachments) by someone other than the intended recipient is prohibited. Thank you.
