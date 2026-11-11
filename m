Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE71606A32D
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uGDkUYmG;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FG2FIghN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BBEB81221;
	Wed, 11 Nov 2026 16:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCcP1uDKbaSE; Wed, 11 Nov 2026 16:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32916811E1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415105;
	b=WB6qO6ILuZckmmR1CtZp+TIhBiXIq+tDhuVG9WVzT7Fy/BG0gdv6mc4AZzvaM0qufd0C
	 LQyJgoFssnsL4Uy8BBQKRiBNK8pBksQIFL/fnkFgu/XsyNeFGVh6KHNki6qKjTTVY5kkp
	 9S1ky2lbRsLP6lQ9M33odELhmaG1HmktDjpNhQCzXW7b6R9oYYJi88H5XQQrCpppOZy8G
	 C6bhsdDjqTxIqJENzr+QOvcNeYnSo/2QtOFf5ZCI3HtnlOMvuiEXfDea82ikYyy7jbv4k
	 cNNAVmPuzV/xyBosz2uhv0iXk8v2JGLjI0DJ/1dYEhbVMux9ayTodTKAuGJwSjER2nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Euxi+f/62Ho8a+4RcBbP9E4Ll3nSJpYGD6mAnyXqO5k=;
	b=foV2BIgbjLW9dqZRWqpS6DgFmLZHw0wpGRneXzoe0qWjLeh2+9SkPLIT4SSW1lrrV6jq
	 bLRKM0l2aSbBebKqfsyPCK98Gw1ikhIiZhugNIXdS/OSUqURwK4stbP1uwC28EeCvgbBb
	 sGxSz4+7QGUdioC8sD+Balzk0m0DGFbC2RqMmN1I4bp6U4p9EzhbSst0RJVaGqnBIvJn/
	 Lr/yF1jHXLdzZZL8Ie52qCx00w99QOY1AurjTjZiyMg9AZW2+ekNk1N1S/zse++Z0T+ZH
	 hV7jJPdpUhpf08RH9ZSnu0dW9SX4FlRL2BJ4B5kjtD4qxIQUg3PwQcj6c2eXIcZXSVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794415105;
	bh=Euxi+f/62Ho8a+4RcBbP9E4Ll3nSJpYGD6mAnyXqO5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGDkUYmGd/XWlQyA26Prm4ZwlKEmvQihr8sEZhb6eoPc2+dKO+W/8rWqLxnnYtOv4
	 Q94FL5BQ5fY5Yl02GCNl9aGLtZsK7zcbY1tt4Z2TmGRd2pSDCi/gq5Uy6DZzYlTeed
	 hwjmZsiNZJxxPICemIt7Zn7d9aZyhsPGzRiwZgLtlZX7CN6RvmRvHz7ZK9riVNgrWL
	 uVZonSYJimv45RvQt3as0SbqOtP2LnrDOmqsWlgBZUT2CX11PXVHymr94oR00/uk3c
	 eXpkQDMyOEc4K5Rg9ryVCX1+drxHav5GDgqCG/zikbjB7Yl2DSerItt9Ha/cvb7k3R
	 H89nA4udHdUDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32916811E1;
	Wed, 11 Nov 2026 16:38:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E60B0335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBAF1403A8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgYWIZ537PGt for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C75A24016D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FG2FIghN
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C75A24016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:38:22 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-91f0b9f0b1cso5010026d6.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794415101; x=1795019901;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Euxi+f/62Ho8a+4RcBbP9E4Ll3nSJpYGD6mAnyXqO5k=;
 b=FG2FIghNpJa9nI97Kj4agPqiIEvXlM4A6YftpsXDFZ4loRC6rxiybsVMVkhNBoyun9
 ksIKQ4O8uvDZsThv7RUwS5Dzcn6WVAhHZYKLnp0xOAzaGqO1pRbYKEXR6zYroFDLRHzF
 6isWBScw1aPwRlNHl4yicCNIbnlXv9OiaxirzYBFZp4ot6gnoJZ6Ga3SGUfB+d0+MQ8T
 guC5x5HUou8AbxEQxOCpNqFyQmf2zOkgp7z3UbU1v0SrwVbzsuoM2YiLA2hcNzgXXG6O
 uoZA0jF3fqXLwhAwdvt8yxklbL06xz+iLYNDw5m7sgi6Tr2tdfGM3hfHDdEOLUbkDgPD
 1j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415101; x=1795019901;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Euxi+f/62Ho8a+4RcBbP9E4Ll3nSJpYGD6mAnyXqO5k=;
 b=mlq6XvFvdRNmxZkOeg6mx5enMGP6PKh4Hd9HhOcLmJOA6TVjeKSDc7odSRuX11W/bG
 TyhC3f3vT4KkSYS1krXqNdnJryFE0UuXe9JVNzEXAiXyz0AufW5azlY+1JubJAh9s3MZ
 IfzbmaavFGTDz2CBq7PbvPR2Kh5LPvRPq+6801pVIMToA5rcXc5+9LeSwYGB5qy+RaVv
 kyUFW0P9rbd6quRf3B06eHMb4Yt4MHICvkHRyBWX88+Of4NwipuGfwhDEs3yeQ4zJ++T
 vWWJq0b5eIlf+e05SQO5X2KE+VLwh3OpLt6J10MKeKwVxVYWTPCjMhgiLJ1fKJ/DDfec
 Iz6w==
X-Gm-Message-State: APuU4Z9ml5EQXxS9YMnfJXjz/s6wX9WOm7NbuDByTP1rwtY+iXu70QO6
 mDfKFtuEu/n/7Q7EKttYNpM/ZlT3wVC2iRBqeZHsvlohTyGL8BZv51MqqnsbacTmKc+AxM3QbMP
 vXMatUw99+P2+W6cGOOnj63zWVw6sLAYRvgft
X-Gm-Gg: AYBFou1fvSTrnapVTHV73N9EAQ1Xm+AyA3a0x6QdoKJ+N8mjAQ8On4UEplU69XReRTV
 Pi+bmhVstCFXBpYHOx0iOKbp/rByLzng0jQFw2nrGBgh2RzYVQHo5CyVyor1lSsm8IJY6ye1C2n
 9y+DTdObNoav5MwjLlImATOF/hU/kWVGSSXSD71xmhEdWcQ0LugIYsaiBriw9KXxYFJFuVKfWLX
 3IuivcyHlFcIDAuM+PBnjtzENRssXEdciZ3BkLeEkIh+Q3gZkXxfM3YIyEd5clZhhSZhn/R9+BB
 mqlkz3w/Q99MgJyXFqxFigP+CAVhQ06fgMm/wzXh0C5IFBIjlYFvJc7JobLeIlLbztttS7v7aJI
 K+2DjYfJ/8NFogbLvAUoFX1Km5AN1MBZNbVus+IYd/hjMK3wcsg8Ld00xVWKexVrchi4sEL4AbQ
 YvxUJal7WRJpUWC8G2PduZrENH8TwJDpmp6HiRX+2P8T8cLT+JAnxwZfrR8iPETDCOqOFodDvh9
 zg46FKEaxSPbclIkQsgI6KdHjTdKcqfhNrbEzaQWWLGKKrOJbBpbogI
X-Received: by 2002:a05:6214:224e:b0:91e:e532:1082 with SMTP id
 6a1803df08f44-91f04072793mr51550686d6.15.1794415100820; Wed, 11 Nov 2026
 08:38:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260906182552.Horde.mWSnZmjufjhuBgLpFbVVWrJ@webmail.your-server.de>
In-Reply-To: <20260906182552.Horde.mWSnZmjufjhuBgLpFbVVWrJ@webmail.your-server.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Nov 2026 16:38:09 +0000
X-Gm-Features: AclHuK-itcSSRTTG6zGNdhXZNy0CrDsXacBKU_XWg-HHE5EC8Q_ejFI19XOR1KA
Message-ID: <CALeDE9PxcfjUfMzREyLH-Y=A78vOO=7L3pqGqsH1HqDkFfdYwg@mail.gmail.com>
Subject: Re: rpi: copy few more things from the firmware device tree to make
 rpi-eeprom-update work
To: adel.ks@zegrapher.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Adel,

> I have an rpi4 with uboot, archlinuxarm, mainline kernel. And
> rpi-eeprom-update fails with
>
> ```
> Device does not a have a Raspberry Pi bootloader EEPROM (e.g. Pi 4 or
> Pi 5). Skipping bootloader update.
> ```
>
> An LLM helped me fix this with a patch in the packaged
> `/boot/boot.txt`, that properly passes through the sysfs entries
> rpi-eeprom-update relies on

If you're going to use a LLM please actually read the contributing
details [1] on how to format and send a patch.

Please send a properly formatted set of patches with appropriate
commit messages using the correct tools.

Regards,
Peter

[1] https://docs.u-boot-project.org/en/latest/CONTRIBUTE.html

> ```
> --- a/boot/boot.txt
> +++ b/boot/boot.txt
> @@ -7,6 +7,18 @@
>
>   if load ${devtype} ${devnum}:${bootpart} ${kernel_addr_r} /Image; then
>     if load ${devtype} ${devnum}:${bootpart} ${fdt_addr_r}
> /dtbs/${fdtfile}; then
> +    fdt addr ${fdt_addr_r}
> +    fdt resize 8192
> +    if fdt addr ${fdtcontroladdr}; then
> +      fdt get value fwrev /system linux,revision
> +      fdt get value blts /chosen/bootloader build-timestamp
> +      fdt addr ${fdt_addr_r}
> +      fdt mknode / system
> +      fdt set /system linux,revision <${fwrev}>
> +      fdt mknode /chosen bootloader
> +      fdt set /chosen/bootloader build-timestamp <${blts}>
> +    fi
> +    fdt addr ${fdt_addr_r}
>       if load ${devtype} ${devnum}:${bootpart} ${ramdisk_addr_r}
> /initramfs-linux.img; then
>         booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r};
>       else
> ```
>
> And suggested that the fix be upstream, please find attached the very
> small patch with the suggested (untested) changes that may be useful.
>
> Kind regards,
>
> Adel KARA SLIMANE
