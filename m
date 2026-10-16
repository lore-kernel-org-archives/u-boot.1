Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F79CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 339FD814AB;
	Fri, 16 Oct 2026 12:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_VSrjYvLTiG; Fri, 16 Oct 2026 12:28:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A50E8146D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153710;
	b=GOM+85HoysfIBCUQLsxXMUfXkI35tKZ671JwgA08q+iicxGq1ieLFhgvwnnwMSGjBRqb
	 CJuU4RrLoWj0InpuOomK1XO84YaykNSnGW71TLsq+X+uZN9QmOv54MCaXEiVWxsDe8lDi
	 XemgxJa1piuOAF6aW63iGNCgyjanebJqg8sZiGLCRCcGO7he4KOWe0gcfEWswHm6hr/FS
	 YimcT7DNWt/d2dmn48BZLypPv02l55QDbjQwq0k1IDdBbEVM/GuqFEkVm+eDjmwhjDRM8
	 lHvnL9ByRZJljrkd0lJ+iNKqUUamGOi07e6KLOvWSc8+lWaJxxRuBwCU+m1h/pRXT6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792153710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=867UAV9EEhm3rnZqMn9oOfTmo3cpJnYrqsxFmfOZ5X8=;
	b=hkk5p7OLEwnG28XJzZ8/a/nQkmcYuKuW4cFVnLY2sdGsa+m/YdcH7VhpWmLYHki2B+4O
	 A1U9gq5x7mmT751+auf7L/S6V8+1lt8FaJMKezFpwEQstRm+EUWdUzE3VEO2AX7zkdGDF
	 6YfHGJpfH1neKufJpQmWIGoXyFYRJN30a/RfnrmU3N8Q3lFwlAOasDs2YiduQrsFuIyCp
	 HLaddE3jKveBvV6TDyTuHOOapBqCKG2d+TdcCbQRlCqb2jEtzyn+oRo0RGLegicX2tQyL
	 rtgH/xtMs2gfFZdtnSquMN4sqOiLvMV98iYf3HvtUYxtzZW8m+b8qDfvSUlnnVPwqjQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792153710;
	bh=867UAV9EEhm3rnZqMn9oOfTmo3cpJnYrqsxFmfOZ5X8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1iO+REL+3ornDmbsM2k9SLC55XqRrfxJ6EETz+3ycZGe0Rg5KzLeDl5JPPtvAUxD
	 G9cUsqML8yHVS7CsMHf+5Ya9iieQbuTcDLUG65xknSMA82J6sk7TwUr/L3Baurmnxp
	 LZMz2bqKwZAC5aJRz4f+23Ci3oBV63KlnlAkZEAO3E26qKkepeUnz5nCTUFpxAFyTD
	 7nPa1toVVn4g4LMVHuY0F5cq/2bG5ZjwKzV0TUZi6RyHenL8UELXcvAVA1nszyakhM
	 AfokTTf+7iiyaFMTgBfHK3vA/xjFfHxLHx+ZGtfc+SLhaFopRd7oR0RB1tVPOxVGgv
	 5i26p+H+sJNqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A50E8146D;
	Fri, 16 Oct 2026 12:28:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3456255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88D8A409F6
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:28:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PKIR2a31wYG6 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:28:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 934B2409DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153709;
 b=K14zlsD+ZJW+5OjdOsc7iv4q0slNEIwIDGoEikbA25RJyGokPTFicm15hxo74zVM6n5P
 5Wnk8kZ7kYjFnCtAqFJOMlaKJN3FeFdNpXawulPoBHlAW7dCqW5gvIFd76mKhqyF2TunC
 r7Hbcg+Q0rdS8/O+oih4QooFvyLMK51DRw9OwcZDDhgKVleMYT9MuaXY0lhtKsn2/QHQB
 GNjiV1kxBJgbAVO6uPDckFiJmzVdX3mTDTTqR3/LF1B3XRKvfTEQibk5w4yv2ekk7pr9k
 PMlyhkKHWC5/JJHLxRyA/3NiAZPwgvT9wdIqh9grrUd4/4g1Hu9XFlsu9WNA2CuNyjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792153709;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=867UAV9EEhm3rnZqMn9oOfTmo3cpJnYrqsxFmfOZ5X8=;
 b=p750VLdM5Jc2Ay1AowISoramljWpxwBRsI6/En+T0qmSN+bk39BXa1FyM94DjHIIgOOi
 NJwdmTWSgbXwhtLO6SRNTAS3L0EtBsKHn/u0/WQoiI7F6jxcRHFIWzqDdJ2mPMnuEwmbk
 Nf6RQTTIVNl5E37UUHy7gXkly+7FMr2bJV1UWuanHypCHyL97Fkg/fUl1WVk2nWh+zUiw
 qJl66sgu89MIGmCoY95K8tGtdLwRqx9Gn+xEoRqjz439HHQeu7z49UhPJ/7f1NT7DQjEw
 Xdv/sKqFeTUOOe3pKLxurvdYaR0phvI38uSUGimMcuPDsUwXTgBrZ+tBEZmijebZm8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LazMrZex; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LazMrZex
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 934B2409DF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:28:28 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5be47aa555cso1300232e87.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 05:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792153706; cv=none;
 d=google.com; s=arc-20260327;
 b=b4/OC4DZmlLYv7Gp/fzID3oh7jkiVFQJ0S5ZMSAxCHaPorKWZwoN0Rbcjnk8lFkXQv
 S3NvEj4yf+rcqyHdEfXTqazXchTUy+m/RDFgsf5g8i3snPSxI9rv9EgzhuawSDhGW74G
 Vy2Hyb1LkUoBUzyAn5hwNpQ35aE3eHxwXA1RZ/+tOjUde82XItZNfeATr94NCYtQU3Ra
 0O4QAKEfO3VAddXE5bsLqhxgZpdQSQrgFTfG9R0sYmrdjwn5qh3kupbBQntTZ3vvcRHf
 bSNM3GHIFfykioZ6pirJ8A+iH8/eyxkvnQuK4TezeXjgBeEgPJLz7gaxY4Aac7FUD+aX
 aq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=867UAV9EEhm3rnZqMn9oOfTmo3cpJnYrqsxFmfOZ5X8=;
 fh=WU73PdqOpkTKBQjDb36zCfTghX4NfIlEaPuRnDToqF0=;
 b=LJSWoG2OV9tE1DGxmaQPU/L6yplhuvqtGBtU6IVPVOdxMpM+RKyKCF43pi0vp2dscy
 Zs4cplTb3hlMYcaHz8usvDYdn1mg1U0x+UacpDIHwY8t0hvr9jOfBlOImgfwkZVmVIjV
 LoSUM103LFmjKHg7bAMlywfse6ckxawrZSYfaV+o5obri8R3OkIRWQJDXj62NpsU88JP
 teWsd8HXUwcGudUA8+2f/+DJ17NBlWjCCQzNwxFEq4uLdXR5gTXjKBj2EfknKpVubKbc
 i/rSSAP1oUSNn4xbS8niETwHHvimBC5zw783beUq5bPwXl5qbUPXoX8R8amINQymsxrW
 SJ/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792153706; x=1792758506;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=867UAV9EEhm3rnZqMn9oOfTmo3cpJnYrqsxFmfOZ5X8=;
 b=LazMrZexgeHLdi0ENX5uVWbqYiFna/qAdAikR2E85QrzJFL3DNPOo6oXstLPB0dL3M
 omOwJ9Lwz24u3EGucdYDDqVuPII6J3zrXUpoU/pJ78CWoHslSBrRQ6sJzsyCmd7ErdU2
 a5ztJR4f/8eYhcsIcyDjvJT8/03uxNG5NEYtuS9OugeWu8bQ6zB9MhCioR0ABns04ilF
 4ouRH2rtBbpzZ+yyOxwkM30/vLAe741z0sE8ZeXlCIO2Z0jBNuQptYlr/MF3JJHaYf8H
 i7r9qnwq5rsYyuFPQPiLXPNXq9dZdUP4WoRR0hU9kxoxZHJUd1uizlLQJxnSWnXbLAyY
 dGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153706; x=1792758506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=867UAV9EEhm3rnZqMn9oOfTmo3cpJnYrqsxFmfOZ5X8=;
 b=yklfU0xJcRI/Mywowhztq5Coym8gz4BjkjhykLOlg7QxdukqJcZN2/BwsUmRF7e44j
 zCia+H2Q/BTNjOScbV/VjzWlnRKtfR8+DO2koSPXtsIpoGBa2VSU55t/gI5GMfB5bOKz
 ZJPfI8sHjAWnP3RXppfzkppHPX0/NBU3unoHWAw0X2JOF6FFzCi+D3CqBV9wfMLBTwKm
 OcJwA5IhcXoZbJdux+4lNDERpgZjtGyo3rgBvXuXbHa01guMdM0hLxEUFQ7R5+b2vLj0
 92zo2KW9MogBf7SGa7Gf1iifGjwv6dgVXsAr3pQuclWACFby5e3mI3ELa2yjxIvAvt0+
 yTlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmRF/TWidZ9PwbCvbhfEd1LGOcXO5AxDcEsL3k7z7or+6S/ZznmSJLWl9fd/jOJawNv947lbk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLU1wByuOXV0XKpp91Lz8f7kTCVYTMaXrWyqZ9QazmykyeV824v
 2i9CupRF86idUk/PkKv3qkoHLcV0TRyxx+7MdcF5z7pt+C8fCts33hneqx2v2vAwGhr44ArakfD
 nqM0YGA3IDFkM1j3/FQreAOBYJEoMmnw=
X-Gm-Gg: AYBFou0P3nQNiu872hWly1jZknIKRTtoXaMnrrmXv9tPnRl3IAAbsaaFYf5mCsOCh5R
 5ndj5HzRPx/zHC5UDSS7QUgDAWUiSPgQ3BQ72anfuyye5vxwdFx6gPMrjWQgK6b3mGejQbPBmXN
 sBLScV3RPL4IVbEVruxMpVusZ6zrnD64d8JyFz4S6iIHEm/n0SlXRlHZZfDdk44SI3IKvtVpHbO
 FE/8Bpy0b3ZfaFD61EDjYCcMV0CtZ1P2CVq2JA2mTGjdq9//v46BJimRJAoeb7G/T0dirf/GfYi
 NXUt4T1wXI2EY+gLR1ZB+jjjtZygZRlj9UGeRaQf2nRim76IgSCCwmdGXlXlggIAuZZmcHBDWvQ
 XQ8lkng2phzOJ1wkpG7qui2lTMdrhW3rBt5RgouAG4503
X-Received: by 2002:a05:6512:12d5:b0:5bb:7b69:6a97 with SMTP id
 2adb3069b0e04-5bcde8d0675mr6736429e87.60.1792153705455; Fri, 16 Oct 2026
 05:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com>
 <20261015-frdm-imx95-pro-v1-2-d354da03ca68@nxp.com>
In-Reply-To: <20261015-frdm-imx95-pro-v1-2-d354da03ca68@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 16 Oct 2026 09:28:12 -0300
X-Gm-Features: AclHuK9sNd3uTZ2Zvwm9sjAF3qk27zNleqx9V-Be-KX5TYuCsMf-PiAB8lqHy_s
Message-ID: <CAOMZO5ABuBK5H7LgbqinjpeTbEKqb_0Z3w3sEVUtihd=2spXvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: Add FRDM-IMX95-PRO initial support
To: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Joseph Guo <qijian.guo@nxp.com>
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

Hi Joseph,

On Thu, Oct 15, 2026 at 2:39=E2=80=AFAM Joseph Guo (OSS) <qijian.guo@oss.nx=
p.com> wrote:

>  configs/imx95_19x19_frdm_pro_defconfig        | 153 ++++++++++++++++++++=
++++++

This file shares a lot in common with the existing
configs/imx95_15x15_frdm_defconfig.

Please avoid duplication by adding a common defconfig that they can share.

Take a look at configs/imx95_evk.config configs/imx95_navq.config for
a reference.
