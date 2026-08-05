Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C57C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 23:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD4F4607EF;
	Wed,  5 Aug 2026 23:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rEOdNc9x2iG; Wed,  5 Aug 2026 23:02:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5B3560679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785970929;
	bh=qEGWZ1tPl+qHUEutLBDwx8uM2DIfcwNhVR28x1mf/1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxXuL6ToqnwUEVPX2RmXCXUMZyAsz7YwdP7r1eL26o5xxZ/pWcV6tcaviJ8o9OOaI
	 lP7BA90c34RgcCOB27SBQvy3h99VXrYMYNaUM4wBuuDMiItZMOVK932ogvinIWfWVt
	 H3omYYAR7jVUA5/21QMOFP2YpMDSUFYa6LJDMlEhnyz997LnCs5C1LgyMeb8CiB05G
	 ywZo881zipfPEafFSB1D/zAOvqYjqK1Tf3t7ZgXT6vDRwUUMNZCDyjM8iJeofW5Qeb
	 kuw2h4DwqB/rzhav1p9U5Y1oR6bmWzjMQnqIPawyfUugQvtqyuM4oF5/f9J7FtZR7P
	 X90IAQJVg1G0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5B3560679;
	Wed,  5 Aug 2026 23:02:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76D6610E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 23:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68C8580DFA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 23:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmpSEBIAJG6W for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 23:02:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CDF1280DFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDF1280DFF
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDF1280DFF
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 23:02:07 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1412218a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 16:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785970927; cv=none;
 d=google.com; s=arc-20260327;
 b=HgRCrAHKJRRjjrLgmk303CdbcrbsrycD0oPMlfIo0lxb/0n/SZTU6kbs7hWEm4DXrQ
 iwdddjiehUMKZhgzXAKI0+sPFPNI7kOrURKiJbiesF9khyxX+5UrQIG4QKPknpmEvqOf
 PMJI/Elr/ZSsKduzgvdrYiGDM+MOloYK3DiUx5xN2la/NdE0pzIzewO8VEe2lPoNm3as
 1lGer+cbrRoLmK2ZIC8RsNtDK8pUVgA3Uiwfo2b7oo0hFvr5RC2rXSNegunFI3pBFLct
 Uy3CCUjXvQEntaFwzOHugbaFhOJhGbscKtq9KnOnQHKLYCZwYl3mkIB23+s2Ii0qTCrL
 7xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qEGWZ1tPl+qHUEutLBDwx8uM2DIfcwNhVR28x1mf/1s=;
 fh=F1+f8WNIZD1CKDNTd8eX52StAeupcM90kE+rjzEg+w8=;
 b=jDxHoSqfaZ+92Ent8Xx33rUnBCeffYQEBUllvllOYeZq5Ak9rMURKeYU8Gjav/I6MC
 sS3P4OCe0avcnM3FF+JUzoIevMgSkpiNQeRw9E5WYOviobMZYku2bME2PlHEWOScuuJz
 HOLc6fcbX7XGuDxTGPGkdaA5yLQKoZrxyO0Jhoat+DrKZNpwMe6I8RJVMx50eHMMdihs
 7WXsYVwuc4IQv2eqenOeZfgoj42R/q6NsHBbum5dzLWw37xyekrFg0vrphK2yJQLAsHy
 0Bjx2BNWgZO6CwRy2JYjuuaWA7m7yulvW/HGbZS5QuQiIprp/R2Y8T47HUaMa5D9+6F3
 yuTQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785970927; x=1786575727;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qEGWZ1tPl+qHUEutLBDwx8uM2DIfcwNhVR28x1mf/1s=;
 b=KDWg+Ieo9ZpNGgm6pAPba+dGlajUKfOYFTUZKEV747jMp0XhmVEmfmwuJzvMxci89R
 vWC9h5vRsnaApTx6c6aKTBSKdrC+yoYMlCegco/9KzzIOlffxNsC2gpUYSEWqjOW/AzH
 cN3z4UJ1KEKXFjk69sj1yOcp0oKWmNgowtrazycdyF/L/x/rdHBYWiHkrnibloHA0u1X
 zrVgv64xXPspTKvzva7zecx0nagWhdxikPswJlAavhxNbsTM12sTfOEYq5SUJBXJXnLc
 liATecfay9yqkTBO/CShCFpE9s7ShWALp20td4sDz0A3sHdyiZd9nRFEZKtMoyNyOC2x
 TGHQ==
X-Gm-Message-State: AOJu0YwQk0+lFuqWU2gZ6ZzqIfdIZFnmCSlP5W4rzRVblDBksEIn7rpb
 FAn/yLOVCLl0MfrRNthsBu9k4AR+9gEb8kbL1UkPd6f4Ah/Bk1+u0vHxzmlSHP0Wuy9Ns/HPOiL
 BIpskZ2GxgftVJYuuoFhpkPB72Ji+2w==
X-Gm-Gg: AR+sD10b4lzhPPlqcue4N3RT7nLd+Lo5sUiAZvAgJN/F2UCGYGcIGhQyVW/n6tfTbrn
 +/s0Yy3Ct/SdtunlkP3fCcGPtfqCHYhammAkAhYZxeRxYPj1uHLigbwXkFO/DPJcX2UOzB3Mimo
 HN4KmcjEglQvi7ChR/npSblpnvaTPaAEhxzVdIlg3dhlrdQC7tQPa5s7gSBIx9+dq5k89hfNtth
 gvCc0EJxb7Jkvc2T5R1T2sSOO1XcyTmryq/uP8duL4C95LRTzrsm4GFVk2BbkU4zV79Ie+2wf3j
 bRO4Lun1G85ZvYbrXXmEqfpvIWW2UDMfgn349Jid1MIVAa5DGeOonHxBr6/QP0Fc25V9NuCaOv0
 d
X-Received: by 2002:a17:90b:3f47:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-3903c68fcdemr10322112a91.20.1785970927032; Wed, 05 Aug 2026
 16:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785934620.git.caleb.ethridge@analog.com>
In-Reply-To: <cover.1785934620.git.caleb.ethridge@analog.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Wed, 5 Aug 2026 19:01:13 -0400
X-Gm-Features: AUfX_mxc6LVtJ-axDXKmJHu-3DmPNnEXyh45Kg4aet3MW4ESvZ3CHEEuCbuIYUg
Message-ID: <CABdDSeWumWibqCiPf0FnbOZbQZ=95XM8vW4TyTcZ2DS1s5e+ag@mail.gmail.com>
Subject: Re: [PATCH 0/2] sc59x: Disable CONFIG_EFI_LOADER
To: Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 linux@analog.com, philip@philipmolloy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785970927; x=1786575727;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qEGWZ1tPl+qHUEutLBDwx8uM2DIfcwNhVR28x1mf/1s=;
 b=pG1iY3t5efHy+yIqsQQLIoyX684qb3V4G0J0Bd59+3fby9LxVxa8m+QOXjVLtNmHgn
 Vn9kBORVm2Haz3yy8C7Ds9+jV9tOttgh0YGLf0zi9TuGQjR4HkOENX1+jVhijq2f/ceU
 lyuU/TrlO6ZTQRmwWPAk41Umdi79MKGzMsd3lOKaVanCjyVD1dFh8kk41FMjBlHJuSqq
 TgyTrM/zNTr3SGSi8bO/iDQcBcpzgOFqrb6LTOy8SpX7cz+OOJjUeKCqk3xEb44UjwAV
 ANpEVsq73lyjeaIQ5AT4LVO369iOSvL+lMn2bCeHQS/9LVjJDcVuPn7EBDPea7SB+Gga
 jB6A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pG1iY3t5
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

Hi Caleb,

On Wed, Aug 5, 2026 at 9:08=E2=80=AFAM Caleb Ethridge <Caleb.Ethridge@analo=
g.com> wrote:
>
> From: Caleb Ethridge <caleb.ethridge@analog.com>
>
> The sc5xx boards do not use UEFI support, so CONFIG_EFI_LOADER
> brings in unused code in the build. This is already disabled for
> every board except for the sc598 and sc594 variants, this series
> extends this exclusion to those boards.
>
> Caleb Ethridge (2):
>   configs: adi: sc598: disable CONFIG_EFI_LOADER
>   configs: adi: sc594: disable CONFIG_EFI_LOADER
>
>  configs/sc594-som-ezkit-spl_defconfig  | 1 +
>  configs/sc594-som-ezlite-spl_defconfig | 2 +-
>  configs/sc598-som-ezkit-spl_defconfig  | 2 +-
>  configs/sc598-som-ezlite-spl_defconfig | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>

This series fails to apply to uboot/main for me.

I only see

# CONFIG_TOOLS_MKEFICAPSULE is not set

in sc594-som-ezlite-spl_defconfig. and the other diffs are missing
changes introduced in c6796425da45f ("arm: sc5xx: Remove
SC5XX_LOADADDR"), so I think you need to rebase on top of main to pick
them up.

Thanks,
Greg
