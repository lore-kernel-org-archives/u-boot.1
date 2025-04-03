Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75EAC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 09:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0524581F44;
	Thu,  3 Apr 2025 11:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eEdIg81o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7435C81F69; Thu,  3 Apr 2025 11:18:35 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD5181CF0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 11:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 28FCEA466A9;
 Thu,  3 Apr 2025 09:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF78C4CEE3;
 Thu,  3 Apr 2025 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743671911;
 bh=sm5QbiXWrO3a5dyODM6kCvkHl/yilDJPkeorslEeCgA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=eEdIg81ozPGEWZvdDcBJEHLgkUHeynD0egmBqAWKauel6keSMXxLasZKxYP/63A6S
 w01hrkzhwq52dkOJqAFG1VEM7GXAvrgK9fys9fZLvyRhcwWcb9BlHKTbntkc/ACNwi
 BAtszfn2tldcOlUsuJ0S/MKRqmnZ3o1wANB1yth0HriKuJuyoQHwF5KXhQXvEttEKj
 xRdSnE6hpKP/13mpCMAsbs9Uw7L6OvC6sI6rnZImAURb0Fjwm8ioI4V9hy3AErSpas
 5FqXUo4TOK54yud4PT1+SFBtu9Tq6QmxcyXa3EKzN6DTsvyObE8kOqYLybQSvNUv9a
 5S5V5SKOZt6Fw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Gary Bisson <bisson.gary@gmail.com>, sjg@chromium.org,
 mkorpershoek@kernel.org
Cc: u-boot@lists.denx.de, Gary Bisson <bisson.gary@gmail.com>
Subject: Re: [PATCH] bootstd: android: avoid possible null pointer dereference
In-Reply-To: <20250402144219.1875067-1-bisson.gary@gmail.com>
References: <20250402144219.1875067-1-bisson.gary@gmail.com>
Date: Thu, 03 Apr 2025 11:18:28 +0200
Message-ID: <87zfgxhacb.fsf@baylibre.com>
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

Hi Gary,

Thank you for the patch.

On mer., avril 02, 2025 at 16:42, Gary Bisson <bisson.gary@gmail.com> wrote:

> - avb_slot_verify_data_free() doesn't check its data parameter
> - out_data can be null if avb_slot_verify() fails to allocate memory
>
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Another approach would be to fix avb_slot_verify_data_free() to check
> its paramter but I believe the goal is not to touch libavb to be closer
> to upstream.
> ---
>  boot/bootmeth_android.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 3a59a4e3f6..f431b6ae58 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -481,7 +481,8 @@ static int run_avb_verification(struct bootflow *bflow)
>  		if (result != AVB_SLOT_VERIFY_RESULT_OK) {
>  			printf("Verification failed, reason: %s\n",
>  			       str_avb_slot_error(result));
> -			avb_slot_verify_data_free(out_data);
> +			if (out_data)
> +				avb_slot_verify_data_free(out_data);
>  			return log_msg_ret("avb verify", -EIO);
>  		}
>  		boot_state = AVB_GREEN;
> @@ -491,7 +492,8 @@ static int run_avb_verification(struct bootflow *bflow)
>  		    result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION) {
>  			printf("Unlocked verification failed, reason: %s\n",
>  			       str_avb_slot_error(result));
> -			avb_slot_verify_data_free(out_data);
> +			if (out_data)
> +				avb_slot_verify_data_free(out_data);
>  			return log_msg_ret("avb verify unlocked", -EIO);
>  		}
>  		boot_state = AVB_ORANGE;
> -- 
> 2.47.2
