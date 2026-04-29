Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F3FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BBD84894;
	Wed, 29 Apr 2026 16:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TTK8jzi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8548489E; Wed, 29 Apr 2026 16:11:37 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297B584887
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bb3c4d8cc29so570469966b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471894; cv=none;
 d=google.com; s=arc-20240605;
 b=fAP1YQvWglv3IVxj99HbF5RV8yz6Y+UGiT/swkawl+jeYw1VqJVl26MYSVuFqzVgXL
 J+svNd+PATK7qoe6jLt8PSknw7q/DPfGtylUskJoYSY0Ck+SX4/3ms2xfwQBE3dqVpN5
 YSFwI3hs95cHGlBnDr1ov0Iej7rdTRaf1CloSe07Yv4vbwhDoul+y+/XBJJQ8ATgt2g8
 OCCRArtDIOdx/BAlGQAcDncsooQ0zZmnnSbrAew/MO7y+D/f9gVaHc/fgqenxRfHXiUW
 kOC4heanuDbUKMc815xu6s9Fa/7U/LU6y8h0mnFBfKPMRqw8grW35WOotT/8yhni5US4
 R3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RO7WiddpYNPL0AWKmYat0i1OKflVYH2kuJUdbCgQmWM=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=l0krz2Vk+oGaTgzHA0BMxcUwmVGf9KBNDHXrInRLqWP20A8GQDnsE4x+YmgoMkgxRx
 pkvWVNqWyZr+qi5CG7O+NLZYBRCMwMLl1paZ5Ut5ethrutnz7+f7qTORZkTQMNKzNxda
 zUNrZdfcsJno209QlcX2OF83T3+udBHZ7jO+HiYEu0fQMkOflafmXZJkWt2fO+2Q82S5
 vMagzDU1oSU7eLDTnI2LVM3LeE9RLNsuLSHv+Z7Dlyln+rzsp6reNW2bzrZ3jj9PKsVL
 49NsZUDa2J4/8uyLa29HCv33imBqGHx8aMnI25YHuaM43Ld3V/THp6XTRKTtK8or0jMo
 nNyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471894; x=1778076694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RO7WiddpYNPL0AWKmYat0i1OKflVYH2kuJUdbCgQmWM=;
 b=TTK8jzi5UrFs4VBeLHpejDjiGgTLVqf9CsrfdSU5N0hEsaWmUNcMG9objIdMXfMBmV
 z0iptPHoI4ek6cd8uWrYwq7r9TE0UBRYNCeKlwOjRvtOLeiU32jfUd1TTMZgODK32rvQ
 5eDmsm/pOD2+3tKT0RwJUp5XEwGq5QH/Hhwlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471894; x=1778076694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RO7WiddpYNPL0AWKmYat0i1OKflVYH2kuJUdbCgQmWM=;
 b=N42OBVsfvaRlqmh7S4JZ17hPJ0AtywRO4/xli0t4ev2EIjclHv2BjDMX1so6aBm0HZ
 HMYhS4jr5Q4qL83oWP0T62WBp1+/VCBUoeH0llB79QG64FJK5oFK0yg0mugumD2BMnmz
 tKBsjPJ7+G9FiDUBv3gekyhJhPHOk7X+KK7CrVmvdS+6CYoZBeQZ0etQGZrlmi08do1j
 zTUKS+KM76U7CmQtnMNjDz6SwyklpLc3ebYGirrZGEVUAnmJkXOTrqWmoIX8Kviz0JJB
 y2Lx4tXBtytgh3G4MNlohdnso7P9d6YrKzAPg/JCsuHdtgZwmqgcprnqRGnYS/uAd6RM
 RF1A==
X-Gm-Message-State: AOJu0YwnmbmPY3Hj9YpwhsiImq0w48R+KOU2lLPI6g/XoWwZhGtNGEli
 jnC6y7XYYMpZNMuUsWOMekjjZ180OSpY8Kv8fr11mt5cNHUYl/1LCQ+3Q43LJ11TXYTZaVMmsQn
 9SPGebQ4KSqz0SkY+MQMh7LJbIMGGgjT+pk+DHOJu
X-Gm-Gg: AeBDieuJPIPnyx1jEs01JKf9yqwxW1M4OKu173VMajIUBuBlNgLIGFNIM8vjy7CTQnV
 zqQrj1ev9lBmmvowl8cDXJbYxS8RJwcsT3TAWWuRmeL4PPbL5zx3tA+UT6eIhjkVKjeqFNIiXPV
 8RKjJfyd5ltESs1QuNe+DSWzJ6vuwdqP7Y6ohqFrhxzqEUudJ0R4hP8xc3rMY9UXC9uheuKjpf6
 VxwE08dDGNsy4MKoBcwmQ4AKSo/0cGuGMMpgmhxt4kMctkLiQqbBC7KuZ0oVvECMXzc0G52ZEcT
 +eu1reccViwjk/i+
X-Received: by 2002:a17:906:2092:b0:ba9:bb46:345c with SMTP id
 a640c23a62f3a-bb80520b3a0mr323431866b.45.1777471894565; Wed, 29 Apr 2026
 07:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <c3d7aaf8ae4f70a19f66837ab987f51fbe91387d.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <c3d7aaf8ae4f70a19f66837ab987f51fbe91387d.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:11:22 -0600
X-Gm-Features: AVHnY4Jm5uA2CbbiYgWJ1sRZ4Ox0WRFQORkcftTtrdmswteBI9YgMflQgah-vW4
Message-ID: <CAFLszTj=LbSq6TZbfJ_T+VtGChXWLfJHQkr6paO3qnLtkGO+2A@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] mach-sc5xx: Update image load address
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Update image load address
>
> Update the load address for the image in
> each environment to match the updated partitions
> in Linux.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezlite/sc573-ezlite.env         | 2 +-
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 2 +-
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 2 +-
>  board/adi/sc589-mini/sc589-mini.env             | 2 +-
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 2 +-
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 2 +-
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

The commit body would benefit from naming the partition layout this
matches (e.g. the Linux MTD partition or the device tree change) so
future readers can check the value. As it stands "the updated
partitions in Linux" is hard to verify.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
