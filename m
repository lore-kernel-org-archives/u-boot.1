Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB4FF94CB4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCEB83E76;
	Wed, 22 Apr 2026 00:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VuWRqWEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0790C83FFA; Wed, 22 Apr 2026 00:43:56 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16992839D5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso755138166b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811433; cv=none;
 d=google.com; s=arc-20240605;
 b=CEdH6TokjVJZmgy4bw4eLZvWNrQXbCxkHzYc8/v3X86gVntjGiRKHBZ0/zEoTjVLxp
 1rCjvrqAmCAFOAjMug9BBw10bqWWFmmfz4Bof83QaAd1wGJkV3Yw+SMZ/UWoa1/sfmGi
 76kaydwR71hg4x8yK8xcPSZwHEPEsCptUnwF7wZO9toidE5bHLvLQgRRn9bdRk1jdgCO
 Q9qCeZd4PyiGRYByDzb4REouWWAupvbCBWN52k9MER9XtDueWSFbpDkr1MWh2SyfVprp
 GQFaL6mMV4Pn2jiby/iMhTRi9HH/0TMO6UzaI9ILbkJRWtFLE8KLlhrPzVckYpa+O2NN
 VecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sERvdl/fx9UQAfIj581HEBcDF8fCkBcpMoN1EH9bpYQ=;
 fh=b/b+yr9z4XxaI5A5qEQnsMBRDFDpyiCKmVLWUAngCcA=;
 b=PqlN/YrxNQhsnywlXosplxpkcb9CqNAE/Zh+21cjqpkSrvV9zmo2yjIFjCigDZCGk3
 rQ95dLndivCTYDFwR3K7Ehw/Zu945jUitSGUCusxpaeun4z0YCRR48MwXBt9+AsGl8jT
 /aqEqfjWEI4elPBLHbAHntcizv7/tW/+OrOU1v5ZdM7XkAyoVsDFHLdP4Ub8Y5/9zosM
 UCaFQDo4mE1m8ue+Hh4YsEeW2PdIAjLlPerwy+YnOZjsNaTwb78SE3CSv+fjEApi/21e
 81EyYKEzdYUEqkr2vGUZDWOiiz+OwzvVjteuhQ6NU/q0GJb/T18l6+lLXYzEIvO6qkzJ
 OBtg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811433; x=1777416233; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sERvdl/fx9UQAfIj581HEBcDF8fCkBcpMoN1EH9bpYQ=;
 b=VuWRqWEbOnD1eaPD6IWXy43mJ6SUvXOAs5x97FNGpvlVKYmqFZx3YFjOOItncGTko6
 nQB6xoNEhB2ThdTSOeGbdqyVZ+CbGp09NgtLA0k+biq/VZLNwxHM6Ik+WjGLtxYdxxb3
 39KHC5dztUaF2dzXAVid3Im0SW7PdL0ivyvrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811433; x=1777416233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sERvdl/fx9UQAfIj581HEBcDF8fCkBcpMoN1EH9bpYQ=;
 b=FHnyEdK6YiANncJOdFkyOZijeb6mhBTDivFDOanUApQk0KZDCD7wSgbpSV+gvZrxFQ
 aGz5uoI7x3kS4t1KRgV/uwbEmmYAhdFSBJONysesyYjgQfgAPCorzT60LmwJNVCS2TjZ
 PYgJauymm7ldDFwNu4T/YFapdmiAT7zrwDTbtkeQCihSJ5REEq/Lh1MufJgSkOhGjGas
 Jn7bupv1wgkCfnaHrxndk9dNWeH20dhfbs2U7tPFdXkBrG8c0ojjXLyYAAZ5AieMefZ2
 T3PkeKNwbdzcpTOoq3wlgP1dD9YiIQ5y6b2pAELq4nfc445ha6c5U7E735yOd12BWYEn
 J9YA==
X-Gm-Message-State: AOJu0Yyqw4qRunNLkuApcUhtEYI+jjl+RM8m6xdAPg6oO8aBmnKjaaOh
 PQ3QBlu0HFqrHlANbUqGl1BPNilk0yy9dBIrUidv3gSwOrhJ603JJLDPZt4q3OZw4aOBr9sN1u1
 8oC9a73id3FyhAbOiihghDTJQnI7CzmawtiOe+QVj
X-Gm-Gg: AeBDiespsW+JLD+x3Y3SmvIibH8BaN7CNvznpaE5vFzInnAoW39TgPSWtKl4h0Rt1m8
 pkOyOF3y9OgSTKAQNoqBz5k/jquGeScjnspm8V7ZSSToo/UyMTg9Wn6YGHxSofP7BaPoy8sPWCu
 b5yD+wADvpB1Y5yiJmsyw30eTbp54NBPFeF9JilfQ6jTNrbsg1m7WppDhLCiphb5V7+DmfpFHkR
 te+PASMxGN5/P0Qs+d3QevNL3emhSZqz9aJrRGzSGX2O7/dtsb+kUwiG2fGBUUwMKqASuAoIGsa
 8nXCVFPdJJyAqHkuZRPdmKaqu/jcJzg=
X-Received: by 2002:a17:907:70b:b0:ba4:b8d6:c336 with SMTP id
 a640c23a62f3a-ba4b8d6d9c2mr987322666b.43.1776811433502; Tue, 21 Apr 2026
 15:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <d58f3c216c5f64a11afa9ea3e32e543abab208f7.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <d58f3c216c5f64a11afa9ea3e32e543abab208f7.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:43:39 +1200
X-Gm-Features: AQROBzAjSnaYg-27W-eYGcAjj8TUleNGA4Y3ri2UNw6n5VrVXZCrl-xvE2F-k_M
Message-ID: <CAFLszTjP5boNfiA+i=G1VAU9Ypn5DowEA1bstqZLx8OEOM_P6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] cmd: ubi: mark read-only function parameters with
 const
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 21 Apr 2026 at 20:36, Weijie Gao <weijie.gao@mediatek.com> wrote:
>
> Parameters like part/volume name and buffer for writing are not being
> modified by the callee functions and should be marked const.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v2: new
> ---
>  cmd/ubi.c           | 41 ++++++++++++++++++++++-------------------
>  include/ubi_uboot.h |  7 ++++---
>  2 files changed, 26 insertions(+), 22 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> index 05fb9634d81..a949d1b80dd 100644
> --- a/include/ubi_uboot.h
> +++ b/include/ubi_uboot.h
> @@ -47,9 +47,10 @@
>  int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
>  int ubi_init(void);
>  void ubi_exit(void);
> -int ubi_part(char *part_name, const char *vid_header_offset);
> -int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
> -int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
> +int ubi_part(const char *part_name, const char *vid_header_offset);
> +int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
> +                    size_t size);
> +int ubi_volume_read(const char *volume, char *buf, loff_t offset, size_t size);
>
>  extern struct ubi_device *ubi_devices[];
>  int cmd_ubifs_mount(char *vol_name);
> --
> 2.45.2
>

It would be nice to have proper comments for these functions.

Regards,
Simon
