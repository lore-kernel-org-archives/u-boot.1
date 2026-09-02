Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D615C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA6380A49;
	Wed,  2 Sep 2026 12:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkWvLTzbCYNR; Wed,  2 Sep 2026 12:39:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788352766;
	bh=IWrihYj5+nquvix19tAjga08UI1nf052iKoc9IRoi8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMJ0ZY8fEx0OU4psfSHFi12e2059nqhtkCOYp06bDcH60SWyw+14d0YsCOqBp9+kW
	 pNysT2XvjUiy8L1t4oPTucDtMnUqTpp35WsrPbjS7RCde+KON/ggKZVpEt5pHxn7fN
	 rng1SWjiE0NsMrtI3ggtQMVbzO+4TUe/uuIPStZ27elf+PKU/LLuwp0mrDRYZ4zRQR
	 Bf8ZopwvB4O/Q+FtpNS0Q8y6e8h+MywnopxX7iE4xUndaPPI4Y5ZMf2mOqrxt4vL7t
	 mll0NfIrSdKXjYRJO5NJ8JP8S6e/FIwoll0znDBppSKg9wGEIO1TyklaiUJYYWmbY4
	 Z/X/GP7K9fVSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBE6B80F2F;
	Wed,  2 Sep 2026 12:39:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1C5F498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E19C36089A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSVBSbCMdQRx for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:39:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CSeW0rXv
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 511BD60830
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:39:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BF0A600D0;
 Wed,  2 Sep 2026 12:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3F71F000E9;
 Wed,  2 Sep 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788352761;
 bh=IWrihYj5+nquvix19tAjga08UI1nf052iKoc9IRoi8o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=CSeW0rXv5Oz7iI5IBzZG5l0Jz6hJZQkE0sct9z7nQ3CKFMrqPnP3wpH8x/RpDy8dJ
 IKBO7pBpljbCX3hGRNfRvVct4UlP/OOcNeTIv+SA5wmaCIOT/ROqBC2JrjuaLD5PQU
 0RWEXYzQWl6VeQ9jPrHGxV+0ndgceolfsN00k0F2r9rmh+RuL6etqRC21MWzodThEu
 i2uenQKPf/c2kgvy4M2dh6DvwWWftknRbGLHKzUmaD+aKF/o3mntCTUPcbH8cGliqC
 p49r+Qs1LOqRklqMEOdG9lNi2vy+AlBzuGI5EYI2qvxq4ejk8l7EwrKmcmuiV3FkGT
 2V4afrXqIZYHw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, igor.opaniuk@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] avb: fix missing break in avb_set_state() switch
In-Reply-To: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
References: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
Date: Wed, 02 Sep 2026 14:39:19 +0200
Message-ID: <87fqzrn7yg.fsf@kernel.org>
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

Hi Naveen,

Thank you for the patch.

On Tue, Sep 01, 2026 at 15:49, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:

> The AVB_ORANGE case fell through into AVB_RED due to a missing break.
> It happened to be harmless since AVB_RED only breaks, but it trips
> -Wimplicit-fallthrough and is fragile against future changes. Add the
> missing break.
>
> Fixes: 5d4fd877733 ("avb2.0: add boot states and dm-verity support")
  Fixes: 5d4fd877733 ("avb2.0: add boot states and dm-verity support")

Checkpatch.pl seems to warn here:

$ ./scripts/checkpatch.pl --git HEAD^..HEAD
WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 5d4fd8777337 ("avb2.0: add boot states and dm-verity support")'
#11: 

So please replace this with:

Fixes: 5d4fd8777337 ("avb2.0: add boot states and dm-verity support")

(there is a missing '7' at the end of the sha1 in the original commit message)

Do you want to send a v2 with this fixed, or should I do the commit
message fixup when merging the patch into my tree?

> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  common/avb_verify.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index b96cd1ebd7b..09f1534c3cc 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -198,6 +198,7 @@ char *avb_set_state(AvbOps *ops, enum avb_boot_state boot_state)
>  		break;
>  	case AVB_ORANGE:
>  		cmdline = "androidboot.verifiedbootstate=orange";
> +		break;

The change looks good to me, so:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>  	case AVB_RED:
>  		break;
>  	}
> -- 
> 2.43.0
