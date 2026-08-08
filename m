Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC0CC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97178606F8;
	Sat,  8 Aug 2026 17:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lzBsVIAjiWHw; Sat,  8 Aug 2026 17:23:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A05926069B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786209831;
	bh=CRH/2CJ5BTHRo19EigVvy2SHsN4v4Je3Ac7l44Ux4TY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJtcxhrO3Rx/TegFb6Bc5j++v670GQ1xxCAo2rhs+mKbxPkyxBENdLcTz+OBK02K0
	 72oPqpXQ+FkT84BH4DqyogZE3x94RX1wpH/m9z/WrPLBX1AMTrsOiInjWjWxw8ORu2
	 JTt9bvEGaeHNdsARzskAMjw3jmYn2ZSr6V7/4GZlK4b1P6jETTEZ/u+HvTg4Ylplqo
	 cRsxGRVZuvR0wTOmEx+LrtxatErOZXnPFFPFx6TlnQoLJIeH0Rfn3q7nbeWplq+PY1
	 YyVyn8+EbQzit4vtU7rCHz4kGjurFhdHON+DENfpA6ATJw1pbtSvMItZt5bqiLKul4
	 NO9+5MV4LGgpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A05926069B;
	Sat,  8 Aug 2026 17:23:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3DC62F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95ED6400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_AGpOEZRBMN for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:23:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6CB954007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CB954007A
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CB954007A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:49 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so795595a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786209827; cv=none;
 d=google.com; s=arc-20260327;
 b=hcEGXaVawD6EkFDNKKcG7zJPsDL5cjgIZAUXY3WOKZru6bgqy0JywbJXE7zMPDtADe
 xqlcCfwRwLHLTWSmVSeX5fjEwKcIlbgxzfzoVFnIDpsrvMxfdYmF1rlcWaJweb1/nqCD
 G8L3nK1abeWt7ZpDoR7nyYNoQgbxhAFbwSiClYfM0XCVwtjBbTwRHKGbezOOoz4wDzpL
 GsBmptTi7HmiMCw9wUcqxNDR28LHb9PjQEipmqd/095TnvsG3EF8T2Xmu1peE6xQeMaq
 6I8/PNAhhv6tuAGRf7Hhs0Q0ZMs2ZkVCPyU0STNeFisfOcbv33/nSIc/aAuxcwSGUrHm
 rWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CRH/2CJ5BTHRo19EigVvy2SHsN4v4Je3Ac7l44Ux4TY=;
 fh=9KsWKwxDCCVG7rxgs92CAzC7QzWKSeYqsKHwsec5f2Y=;
 b=WzSMTuWlYoy0A6Ml5BWS80rAIYn5PmsddQZaFvLlocCcTzYawQRHVSn6NFubI7gLd0
 6Va+e7DB2CaRz288lFh3MxQ9TD73TD4j/JLE5Wtx8s32njn9otUTaF2+wYDow7RYdXIA
 EzKuH7MmmhLNVwhMhCCUPTShpnaBWBpuiUfmAzPyXoStP5hzUkjvh6Pup3m6BYBmY/+8
 Mej93HNvLZ4naA5hmkUntkPivxmkjktumqgxdtnPRgXjuoE7WuLDMo3IUcDxCYYnB75n
 2Q+7guYKtzDJrGyOSxZiO2NxQX/X1A9zFc090boCm6LxDwv3MZxYKGQU7Jt+AH3bQ48g
 DPDQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209827; x=1786814627;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CRH/2CJ5BTHRo19EigVvy2SHsN4v4Je3Ac7l44Ux4TY=;
 b=XmOKmN9dO0RLjthomqLrQ1jUxRTRmWcu/BlimxqqJL8J537Zn43ToH3Lqlbr6v6z1a
 1raLxmeePHL6YXbCM2otFpKrLne0XAmS78XKrKwKoypNXNBOpmHgy/zBuwjCt04IO56j
 KQX0+hALaerz6AbZbJ1hKYTBtIoGMNz9ZV468JGLCHavBLKhlPMRSvLWHhYRe9UROozd
 FHkgTGe+1x+T736c6AGcyGjee5sTBNgnicsLhLQsP9+ugmvpkrjPZthsXzyqyx3UJ+vf
 PJwy0K6MzN3i4u/aJZYHVDbp98T4rERzQyyfy5IZHpVjk7bdtVRIvDvJjie1UIRJMb34
 tg+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmHDtHEoj66yCNRc7ygFq0wOc1ig2vYp41gQcnCvSUnWtM/IfkpQIedN3OF5yMQm6+k0H3mqw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwlTqK6cJCBqVg88zuC9RcZJb5C+Hx0Y0EL2Y7ZRMsfOZ22hRO9
 kNpGZMJAh9isxlkUSjaqFKomIaq+GSH6pOT6H/ByfDvsEBD1LZG5YXuUNFXD54+NhLKklxbOV7e
 DDqGwSTdV3MwzlaNjiwGzMQ8Te8BOoAJIC20C6zYG
X-Gm-Gg: AR+sD11rVBxoIql5l9VScTBrkL1bBJ7+8kRXS3sm4aWvs3HvjC4orjDtrKaJGgjpI2G
 oojzB7KOAAwfQI8kNLZ1vsNJ5sT7qEGIA1/ULnqkQmPv7GY/Kwwm5A/54V0NbjoG53cFepG/PfT
 YH52zICrwHwZkvio9qu1em3Rb1SPkuN8T2cxNrt0HdAzjIyxGgl55FrFqCfWWv2BWfcmN03bNB2
 QnRnX2Z+hxTBImpgnaDE+moIC/iJ/cg+WlrGVYPHQE5t04sfhVqdjEnJJC2DeMS/0RmzUFgfzfB
 WJknV7csPxki8JBNPiZNgh8lCzfbokSx2cUdjWckF+s=
X-Received: by 2002:a05:6402:5515:b0:6a1:f95b:8ced with SMTP id
 4fb4d7f45d1cf-6a1f95b8e6fmr1856538a12.4.1786209827539; Sat, 08 Aug 2026
 10:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-b4-android-bootmeth-oob-v1-1-31c3450ae0be@byteray.co.uk>
In-Reply-To: <20260729-b4-android-bootmeth-oob-v1-1-31c3450ae0be@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:23:35 -0600
X-Gm-Features: AUfX_mywHCViSAWe6Yw4IS_qkWForQvRhw9lJZLhNgpBTTb5y-Kk2HdP9bNpzto
Message-ID: <CAFLszTgZqL2P8DkYf4y8Uyio8W4-jwZpRgKvnAsjwrr3VBB6zQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: android: bound the boot image read by its
 partition size
To: shahriyar@byteray.co.uk
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Argus <argus@byteray.co.uk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786209827; x=1786814627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CRH/2CJ5BTHRo19EigVvy2SHsN4v4Je3Ac7l44Ux4TY=;
 b=JfydLnifmGza6rsPAYiH574a2Gp0U7j7ozjZ9+ZlRcpb+VHENc22OcG+1XG4HHlpOo
 MvZK33EQCINKKHcgy2rVS0Kigl6HYXBH23abcZnVKQrYJMfsTB7Ka085lVFbC3YsxrUI
 ZkUq8UOcIbfWyFeuAPA1IVuJ3QC1D4QSNEWBA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JfydLnif
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

On 2026-07-29T19:02:09, Shahriyar Jalayeri <shahriyar@byteray.co.uk> wrote:
> bootstd: android: bound the boot image read by its partition size
>
> read_slotted_partition() loads an Android boot/vendor_boot image into the
> load address, sizing the read from the image header:
>
>         num_blks = DIV_ROUND_UP(image_size, desc->blksz);
>         ...
>         blk_dread(desc, partition.start, num_blks, map_sysmem(addr, 0));
>
> image_size is priv->boot_img_size / priv->vendor_boot_img_size, taken from
> the boot image header and never bounded by the partition. A header
> claiming a size larger than the partition makes blk_dread read past the
> partition and write past the load buffer: an out-of-bounds write of
> attacker-controlled length on media a physical attacker can supply. It is
> reached during boot on a device where AVB does not gate the read (AVB
> disabled, or an unlocked device).
>
> Reject an image that does not fit in its partition before issuing the read.
> Both the boot and vendor_boot reads go through this function.
>
> Fixes: abadcda24b10 ("bootstd: android: don't read whole partition sizes")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
>
> boot/bootmeth_android.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
