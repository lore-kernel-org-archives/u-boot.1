Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9565ACA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20D3D80AA3;
	Mon, 28 Sep 2026 14:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHiB5NJUX7CE; Mon, 28 Sep 2026 14:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B5C4D80A7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606245;
	b=Jv0C6PIVXqs4krwR/5Y29C2bcx2j04OC4aWdswxvnESTi3I9Ur25NHmhHe0cybyBSJI5
	 x9BDLgIKr5QiTr5SqJzqBJ+o4dm1g2yBRzffEPZyEDyJk4lkJJka1rSTzY+Ok37/TxVLQ
	 0xFPMwDZsdCSaViSakxoOfMI2aL8XU8NdgY2re8WvHNtFu81eShvkYL97t1GFMxuLaRDm
	 IDVpel4iQbTIRBFXEFEYK52Ppl9FdO/ogdBrIUzjnxTJsq+zVtuEsGr4wSlDK9QRe3Chk
	 /FF0iiRIFna746yqcUM3GGHhARvxrmUhFDiBwjkhXR9QFdptgFEZMbAfhGyxoKw/DGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2thW5/HpHryF0vTY2EIRnJ9UmopsgzmciIMlh9hp+AA=;
	b=jxzoRo+4hEQOTw4lW8PLhIxSAQs23IiGQKILIauC8w3UVeYe8Y4cwLPOcPj0wmxwcHiq
	 OXSmvDLUxyuFnJHkO2HTg81NRiZiV/Y+2oV+4o2xPqwTfgIYW3d7gvagoshXCL5Jbturd
	 zTt4iJbpeUIWD57j+0aRm+3q+alkSMPuZLGpjFtWYACCaqE9/BFqIBdMnVkuWL5X4Vgzo
	 Guugbybkq4OlgKYwnZmlJK/wkAvOsWBZrEzE8wCdnmIwCKOghbH8EBBWMfDISfbjiuIbj
	 YqlF1WDWpLGizRErI4syx2RuF6+I15CbK2BQJf87VeIf2HEdVmDjhsbENH1ZGv+bogg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fIzdiK1K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606245;
	bh=2thW5/HpHryF0vTY2EIRnJ9UmopsgzmciIMlh9hp+AA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJC0N816Ib7CPBHPLKypmOZMfDrEofR/ZpGamt+ItjjBWYdizCMyiYzfEt51sZzXt
	 o3VzSh1sVYx6Eks4fBUW5rTFhY2WHlYNb6Mf4pS39a56eNt8V0UIJH8BB9hD7gptP2
	 RlSES1/HwqioBgk0ugyJcGvEiSzQrYQfQn0ohvenPAUsG3FI0HA4Lory6lIshwKPWd
	 Y9ZDIP0jRFMB0ClEto7cykqqbtsGmkKfwqFgjoeTkWmgIM4JRX2Y1s2xa9mAEH6VYl
	 DlOzGbvdrmbrN20x1Zi4sv/lh/KuZImLj/4i3hfUvNiPWiB+v4vW6tizRtOB0im2vo
	 Zx/zd9YDHaymg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5C4D80A7A;
	Mon, 28 Sep 2026 14:37:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D356361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2A4180A7A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1qc5VvJEHrt for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A00680A4C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606244;
 b=VkLn1iFujNJt0DGUJOCk0Xc+bbZ9Lxw++Vd6Qttboqrxp4slSyoY6lmRunkxJ4tMr7zP
 qIs6PgZHTms/5uwOJaIEGTcPi70Zc/dAcppfJ3x4G6w4F8wzhRrT8jFcR0kfyeJunOCy7
 CUnmAeVJ5f+bgZCb8XUdpsn1G940SEYwDU6i1vIT04IJOP7LndRf2c30a7t4LrJGv3o+B
 nyrN4HJrE3B/LIX0TFFkzPm7Tm6R0SmV2ki7wOF8L3n2K7uls328vI2Hw2lVA2v+Bxb90
 PxuHmbP8yWbFfQOy3pF3WLPweFMT4IWenp4E9eAPnbCnDkay9Qq2Amo01vT9SWwKtxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606244;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=2thW5/HpHryF0vTY2EIRnJ9UmopsgzmciIMlh9hp+AA=;
 b=ATpRC3SgwYZJgu/aRofQgREUs0jpScya1PltAHWhHQ+7dbHnQ2KfUABVPj5nmMkkedQk
 YRwyuK70Z2h0uUFSIMdCL++f2uq7vQzKEvhe8zOkIhizPo9YZo8G9GsrsvYEm63cmz4wz
 uHpihm0jkMc+QbkfnigofToZRc4niBNO6cMPcTvbz9fkv1Gu5UGL5BkOyTF7TgMMpX0Gn
 xUrlzgE+t5r+4ocAuHaQbeQ/V3AWTyMvJLFjppKVTbU0UQ6zwqfWCq8Svx0xDoXLEEsE2
 5Z4Zuzkz734SoFFxYo9ctWuaQaMC9Mce3FX9e6LQk+dgM5U8/gI2mM1r1CUqK1Lml6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fIzdiK1K; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fIzdiK1K
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A00680A4C
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:37:22 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso5261678a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606241; cv=none;
 d=google.com; s=arc-20260327;
 b=mJ7TxWGrhZtgI0rBU9PtOTU1MNbj8KQUu6v4RNq8pCcoDhk6gTVf8O9E/moQ/YMi8E
 j5gYLE0IPsq9Y2UB/nUAyUEZ31xd4TlTLUa52Y+/BDQPZZ88+7pWB2K7MSIoHvjk2Qo5
 Cdu9QAyTIqgHjnxrjyncMK+OLRhTs38gRW+N64fqDCrlgq/jXPuCDgOzF7ZTy6o/zs7c
 4HifoTpTC9jfmgDeajDRMehlT9lexsqD5RkD8QFOjrnQdjTJkmb2iig4iPXxI9X7KJ+4
 0+XN4xCNFdGBZ54Z3rnBPW+XnMY5eDnHntAsFdpwpFtKg4B1rV1dGynLdfMduSp1hVwc
 D8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2thW5/HpHryF0vTY2EIRnJ9UmopsgzmciIMlh9hp+AA=;
 fh=hifdh5QWUWtgdU9JyegremFrLkchp+4Oh5S8KKqkvYA=;
 b=IfC4i7rC3uquZsPA9JpxqH940gcoOgB7vledyc/lJKh9Vzxyz1lANogvC+NxGjKtlT
 lA45eDQjOgkNY8Up11nH8a7Zu07s6Qtv1zV01qm8ndHuXTn1av7anEsdKlsK42uAp+Cj
 AwXcSH771iGg1MFRLmC1JHySVIBP0jE0SYxhopYn1zWo1dAstqEJk6dsn9FQy4HW/Eh/
 0Uv9fzE6BwFrxlmJ3yzFWv3vZGGOyUVFLxrnwFDK4EWflX744zGdMd4QkGHBhhFnonYC
 RPqBTX5i7ZUya5GN1q4tZE2+Te0lI5Ij0VuxAUQ7AtLgH+y2eoLyQCoWWYP/GqsZEtd1
 JZnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790606241; x=1791211041;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2thW5/HpHryF0vTY2EIRnJ9UmopsgzmciIMlh9hp+AA=;
 b=fIzdiK1KkcIxaHqH0en46/qWgfn9UZykop0W1QuHUxbCCNbbK3y60sJtY7H8TrlsX4
 y6qdzD6zQKD/VkIbx5ex5beugaS2TWIm0t+kweSm6n7LHlBG5lOBHNNjGvkjvPgqVoHG
 9B0PVnrJRytjXzDy0lZ6M8BGOMkFQLB+nzksY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606241; x=1791211041;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2thW5/HpHryF0vTY2EIRnJ9UmopsgzmciIMlh9hp+AA=;
 b=vAe9jIp/xE5ZkWFxhzc4aNtZ77hbfRcKvI/Ica892PaRGfPCRD0GWxhhHE08AodZpQ
 Lo1CJ26khQMJnYXW+U9r3R96waMcsrQLORvFg9m8jpAJS8KRzKEVVTDhYdTmsdsaN1lP
 G/3SizWu9njkuKYSDMBzo4DRE+i3wXCQNH53D5Faml6TuG90Yz/MurfojwjiVq/ye4As
 HtP4r0gVbHh6XwlTO73myYVZyiRCw4QZptPIslQuApVxAr+ojO2pTVQC9qzp+oPBJDbd
 VM+Xfc2AdFxNJUHPmMU5bmBre4tVtTiILn7J34PwwqORE7GgPWJBZ+zmC1DU1ilsQqp6
 +zFw==
X-Gm-Message-State: AFq9FYJDdw9klHwjR3YGHV9kvsSt9yLgW3LjIxjlNqzveLPWvKTaoCMd
 Dr3MwmooBK/wKUD9QcM3Tia0BV1hhg80cY2WcnVEZj1oF0UDaZ1COhzCF8603TetkVCe8luXIed
 WZ8LAOjaTxRvuAc1il/Xi1pxz+B2ti6uevQbNHAH/
X-Gm-Gg: AYBFou2bOXgieDPZisoCL1SCGcbNmSie/JJ+piGOS/jh2fXypVQzqfUtHSotP2soa80
 8UNgXagRG5j9w4bOlDAlqL4G9/34QiABI7P45PiySDG7wGWbUJ+vsc6tEU3Q1wsAPTePJYytZtS
 GDP+YDJnNnuzC8heTEeH1lDZEMi/9U8+0Ir1nOSx1IP5cZgeCDvQ77lxdG7viYPTz4fBb3z5QgV
 EbrH3qygB62n1RX88qSUCHZ/HcHNHASfSaJPvD89MXy5G2YloAyAxy01He0ANa9mb305ZysxGI0
 hJXdcmXQE3KjtTIiNjHPVMcKhLNrDzsNG4vWeSDfzpnHKgWnKoFmhi3IG2oj6oHv
X-Received: by 2002:a05:6402:3552:b0:6aa:82f:8093 with SMTP id
 4fb4d7f45d1cf-6aac90dc803mr10268406a12.37.1790606240801; Mon, 28 Sep 2026
 07:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260926005853.1727-1-m.legenovic@gmail.com>
In-Reply-To: <20260926005853.1727-1-m.legenovic@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:37:09 -0600
X-Gm-Features: AclHuK-dU-197SrcB2aNy6E3Zm3cnIz3PqBCmytNW3ZQ_bI5iAhjlgYSeLjEUJk
Message-ID: <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Milivoje Legenovic <m.legenovic@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmail.com> w=
rote:
>
> After upgrading u-boot in Armbian for the Odroid M2 board from
> version v2025.10 to a higher version (it doesn=E2=80=99t matter which one=
),
> the board does boot, but the boot process halts for 60 seconds,
> and only continues once this time has elapsed. Debugging via a
> UART cable showed that u-boot hands control over to the kernel,
> and then freezes there. The only difference compared to v2025.10
> was the SMBIOS table. After disabling this configuration option
> everything worked perfectly.
>
> Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> ---
>  configs/odroid-m2-rk3588s_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

But I agree it would be useful to know why the kernel can hang in this
way (I didn't even know it looked at SMBIOS tables!)

- Simon
