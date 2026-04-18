Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97693F99C89
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 18:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D34B83B99;
	Sat, 18 Apr 2026 20:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UyUsBX3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877CF84258; Sat, 18 Apr 2026 20:15:37 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18CC836AC
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so279069566b.3
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 11:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776536135; cv=none;
 d=google.com; s=arc-20240605;
 b=Mer5q/zslQJkKHXWICDW9inhAsh6DaYKCz6FxICNy/DWPcMc1rpTBArCg7dh5Qp8uF
 3rhUVCLND9NQNXEXKBtCVdxON0VT4hT2AxLdAP/VGPK874r1GaPgOMxbTehi/Bnq1qE3
 IY72+4bU3Z9sXQ0Zw0vEG/OHIarZp4l0dbnv34yWAHO712yaGcrpssUT+ubFkc5YS0So
 YM0Ho+awVOxkq31+IEns16/COJEo1VegISfmIUMvqyJkFrEvL0b5LSUxrjjz549Kfqxn
 Ij2igN/UVcwxgL/XxAoyHpxZPYCfZEbW3RxeinoJ2HZl43txc6N1A7XJduYRTjpLvgh8
 P1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vBXiGLxQPAq4KjtCVTjGRXaSCZsnJ4WGDmM0yvBzkDg=;
 fh=Jb89/owTUo5GRHY4pQV+/8BOSBPV4Pv1XkkttbNWbm4=;
 b=TRvH8a5hD3dINyYeFDEO85MC9utE7aaW9P2k4atDRGr81QcwC2NdbMTjK0HMc36+JB
 I+wVl0y1Tjvp0rjRASTYG0qJnZyhCYKQEg9vDrHUaeVrQObsTRn9/u8iqVzT/7hRZNCb
 1meDiOQCfnVDpiTCAK+7pnaFwn4DsLJOW2bA3jufzm4bf0r57gO5C9c5FBFvg9aAHghW
 8X0Co/1XJPH+Evxhn5kW1QNDLrozzSHWnbu0nxsYUgG5mG7pOjbaavvlgtMOQOsvDgNY
 bHBQCyap+ZDuN7SB7FJvI9SDgEz7lbEj+XFio5AoiHxVAZ/cu7wmJCpUbyNC67M5oz4o
 z4Ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776536135; x=1777140935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBXiGLxQPAq4KjtCVTjGRXaSCZsnJ4WGDmM0yvBzkDg=;
 b=UyUsBX3zZOVVq0SUXole8PqSPwlAYb5N9OkBMwCGiYr8v4H/RlC2nrv5Gc8GtDPW6C
 9j7Lg/k/zCPPt+hHufCGPxPt3Po0kQqT2x8G+2XLMsBftpk3jktfss9e8Mq9TwSMbpbW
 3KJl4pSqIyuiL6C0KFOTOE1Wyv5hVxtqu28QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776536135; x=1777140935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBXiGLxQPAq4KjtCVTjGRXaSCZsnJ4WGDmM0yvBzkDg=;
 b=o+/PU0PPIphz5wgaVdeUwMGl8uaHQlTY04FMzlWXhMTaHRAoC9wflxc5Hft3Nl9aok
 SUfDqHsTrer+CFnzTSPmsODlsgBNNu3jwn+FQSK687nhhkq0E5JyX8klX61aYIpdz8gj
 QveX2kVq15g4TaDcUh2H3/y8Qkxo4++Mxx/H/r5q/SiB6cdssSgbx1Rrxvq3OQYWX+/A
 MgVdqiXiknR+PP5xg7lFv+KGEshUFyqU+AOlCRoP4PwNWpPi8dzHeuqgy/Ba+WPR2uxs
 Ybn9kZnqI86OGg8wsG0mEJXmELLRPwRyKpKMCkK2zWOvhZ8JuxNDlo79u+10/wpUKTBI
 kA5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UqHwzPX7xah1ogLcORhFKO5prdHw3RhW6DusIMMsbcGl6rQK/V5ukuzLpc8IBPlPylA3kTU4=@lists.denx.de
X-Gm-Message-State: AOJu0YwLTg6SqXHT2B1lje/knRbg47pfMlcHgtqQPaOFl8nLMB0Pr3pg
 dGhLiXfs0BykJFrFrfg0gDK/W+dRp7RnDnVT8stegDgNCwA59/5CUXrvj5ZOC9VZZLJV0LgAZUy
 ALPrv8trFX20mtdepX0/BluXKRbaCeQOn6i10YvvC
X-Gm-Gg: AeBDieujNDk0DZWktH3UUV4KjVilVUpzZJLJ+1tXEAkL4eVVxHDF9gN6kJuYkM6CKK9
 Z647D4IKcsA4GjMUuLWdFGw9kyL4nX3J96RNYn169bRWeB8q/xfTAmJwu2pUKnOQNgPiNzgqER2
 lrBkgBvg/iNm/c78sKUoVq9ic2iq2buhupu37FmqhLg06xTTA1ul/uNofQaM+AEm9ZV5Wd/8Orh
 3kFFDPlM2uuk28tc6wlt98/avQfFTD9ykyCoT90kJzb0QZY4fnHSsCDAH9w8IZyEU5XZRoYf98X
 Qm2/58toXuiLhSesJC1i
X-Received: by 2002:a17:907:70a:b0:ba5:8976:5526 with SMTP id
 a640c23a62f3a-ba589766788mr125484766b.28.1776536135024; Sat, 18 Apr 2026
 11:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
 <20260417083050.499955-3-yan.wang@softathome.com>
In-Reply-To: <20260417083050.499955-3-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 06:15:21 +1200
X-Gm-Features: AQROBzB2AX5jueuYg54zsKULTpNviOJgkI1G2-F7wXERJUqnZ76mOnsIXYgUzq0
Message-ID: <CAFLszTiZthe+Mbi-+4BT0YDrEMSxdpp7kRovt1UXPuWd55fm1g@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] binman: collection: Set build_done on referenced
 entries
To: yan.wang@softathome.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 paul.henrys_ext@softathome.com, u-boot@lists.denx.de
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

On 2026-04-17T08:30:47, Yan WANG <yan.wang@softathome.com> wrote:
> binman: collection: Set build_done on referenced entries
>
> The collection etype uses phandles in the 'content' property to
> reference other entries. Mark each referenced entry with build_done
> to avoid rebuilding the same entry data multiple times.
>
> This is important for cases where rebuilding may change the data
> content, e.g. due to timestamps or random IVs in encryption.
>
> Refactor GetContentsByPhandle() to return both the entry object and
> its data.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
> tools/binman/etype/collection.py | 9 +++++++--
>  tools/binman/etype/section.py    | 5 +++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
