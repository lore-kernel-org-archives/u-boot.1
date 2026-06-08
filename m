Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE499CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733D183EEF;
	Mon,  8 Jun 2026 11:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ohxkAhaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB678466E; Mon,  8 Jun 2026 11:17:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B7D807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DDC5600AE;
 Mon,  8 Jun 2026 09:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAFB1F00898;
 Mon,  8 Jun 2026 09:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780910266;
 bh=Mo3a0Qw6+jdJ7ZlQPWr+SSPhpxDHAcXlPDDUyIyxgYA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ohxkAhaYzXat97fqP7+sNzXJgGuhc1MtZD01DZiJKcQC34dOzebl4c0pt3lifFeJb
 /jRTYf1IGbmsCJ2XN3a7wmLu9mq31pZZxqw5PxIt8KL82IM+fOjFMWWwUXvip8OyYl
 ziCPUnaz2Za2SJe9Sb1HiRCTKol+GEl5A86p4RRej8tqfIze9Qpq8UY6dk7Ft8F5Pk
 Lk9qxdZQkJuY7zEghdqAwOV7toXcmD/nt3X5yQ+FKewJ8up2jqpnDVV4opQmNYAz31
 zkrmUivoagpIP79OZBUO9ZTjeE2YeWvsa5/zPHkpRY/9fexX+2ZR8XHH/lhM9O2RDk
 yDMCrwNaWEZog==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Colin Pinnell McAllister <colinmca242@gmail.com>, u-boot@lists.denx.de
Cc: Colin Pinnell McAllister <colinmca242@gmail.com>
Subject: Re: [PATCH v2] android_ab: fix slot selection
In-Reply-To: <20260525003158.11319-1-colinmca242@gmail.com>
References: <20260313201415.255744-1-colin.mcallister@garmin.com>
 <20260525003158.11319-1-colinmca242@gmail.com>
Date: Mon, 08 Jun 2026 11:17:43 +0200
Message-ID: <87cxy1xufc.fsf@kernel.org>
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

On Mon, May 25, 2026 at 00:31, Colin Pinnell McAllister <colinmca242@gmail.com> wrote:

> The boot selection rules state that a slot is bootable if it is not
> corrupted and either has tries remaining or has already booted
> successfully. However, slots that have tries_remaining == 0 and
> successful_boot == 1 will be disregarded when picking the slot to
> attempt.
>
> Updates the selection logic so slots marked successful remain eligible
> even when their tries counter is zero. Debug message now also includes
> the successful_boot value.
>
> Signed-off-by: Colin Pinnell McAllister <colinmca242@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> * No changes, just sending the patch from a gmail address
>
>  boot/android_ab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 13e82dbcb7f..f2b1110aa24 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -289,11 +289,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  	slot = -1;
>  	for (i = 0; i < abc->nb_slot; ++i) {
>  		if (abc->slot_info[i].verity_corrupted ||
> -		    !abc->slot_info[i].tries_remaining) {
> +		    (!abc->slot_info[i].tries_remaining &&
> +		     !abc->slot_info[i].successful_boot)) {
>  			log_debug("ANDROID: unbootable slot %d tries: %d, ",
>  				  i, abc->slot_info[i].tries_remaining);
> -			log_debug("corrupt: %d\n",
> +			log_debug("corrupt: %d, ",
>  				  abc->slot_info[i].verity_corrupted);
> +			log_debug("successful: %d\n",
> +				  abc->slot_info[i].successful_boot);
>  			continue;
>  		}
>  		log_debug("ANDROID: bootable slot %d pri: %d, tries: %d, ",
> -- 
> 2.34.1
