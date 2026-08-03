Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE52C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72E8540635;
	Mon,  3 Aug 2026 12:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FIRG1oBu4ASP; Mon,  3 Aug 2026 12:16:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C080C40541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785759390;
	bh=jaasSxO/RumxUkhVCBjve6zUrFuH87QTe54R/HIH9DE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FwHGZMuLtxrIkSRgiauQ3K2Zqk1IPBLP4yUvIwRiHxMF09Y0/1qZscG+auVjo1WCX
	 ze/6CyqIWXs+eVMp0g9333pnJSBwYezXS1ofDQ3Eud59YhjCyqXrG7p8BTXa1DEqNu
	 NIDEtGIZCQHd8UUDV6nlmPyd5Aui/uVk9NaAAA8rTbIGQ1HsACNaQrXwhNnAFPguVz
	 IZMTEGZZGpIvGB9YVbqxtbFh5BjUd8sfNt7wiLaA5Fzwz2tTzPpp4gr6NUBb819RAV
	 J1XpKAwlBOE5sx6sokoGaMXrfpqx5MobTbj0c4P14m2CFgbZQRJ9y8aiiRocqOxMVl
	 gHfVQ4JYupKwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C080C40541;
	Mon,  3 Aug 2026 12:16:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F21D6218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D04B96076A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20MsY3jTnjps for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:16:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EB35F60768
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB35F60768
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB35F60768
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:16:27 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5b01910b499so2825591e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759386; cv=none;
 d=google.com; s=arc-20260327;
 b=oNI4+tk7p+khltmnPZHOUqKaf30ivKDY5//nAu3mjGqwClUFfaOi3eHjA4AUy6Tlke
 NobMwq056zkKqslgjo7aH2V7DB7tcqLZyYgViE/l59XrtZvGBEisgdCE5BpUuDNJt1Wd
 RHWRAdJ7ZOQZTBohmpemFdV4r/9HPI6al2M+Lb4BVzJx/euexLx6CG/2Xy9t3FN+dza5
 DwoTGE2h4uQ9TL9Hf5XjfC+996mXfJaxCkSTJrOAiqAbjobQfKiY4KFK6kxNNVPuagva
 1ktt/aT42eQdgx/8AZkKMMUPp0P0ecfYMVTGIbEvCNujg4n3dMoOewbZnRGO3gFTsFdy
 rQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jaasSxO/RumxUkhVCBjve6zUrFuH87QTe54R/HIH9DE=;
 fh=svFw78k+QH0+FcVnqD15d0U3z+jQVzzU8uhZp6CyumI=;
 b=l+HNhaEu+IJnaxEaKF3R3a5aCL+m2ytdMoBUxiYtaLvtADIRHu6NhoKXWyLW+LF7mQ
 5BYRZME2ux1N6a8kkH3BC2TqDq6TnUA7ZPRuO2RRF5Fo1krbtzllLsR7S5Qkk80Uwyj9
 SSx+QvybZLfc5o8uDp27OL7YrwfGSiyz18XbXZ4PjiMYnZSdhjjsmc2LKsocqGDEg5v5
 Dv/A2zHFZpzbSbjl8DLbsCKsj9WStKYnRYs6ytLKfNtFW9E1VEsAAgq/PXuIav2WZkjc
 /N2DggsFLC5Mg/f5bHVSWrNnJ3xArNqkoo656tLhmC9+ICdLSGUVOd1FCqWHJ8hBT2Zi
 +qKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785759386; x=1786364186;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jaasSxO/RumxUkhVCBjve6zUrFuH87QTe54R/HIH9DE=;
 b=CxmhxqT6yC8G2YWjE8UYPvbxt7wMSFn7Ib28/PAIt02Zohy8MI0xnbnZJWLmNqUt8r
 gjy73MW8tgQzI7Y2O3Hks92NIpa0NfjJC598iDpqTeZjnT8cxp/Z9HCmQkguDWmQFbZG
 DSCjQ7HwK/QrDwhyCwYL1+7NE9owTBomhsyL3w9tlo+YQJo844oVdOkEavQYyZ5nE2gO
 hx8ZGAVWL8XlNAWh3QypOEsyKe/PgVBfE2MW1CRNTbiU24HkE8fVlNTzxXqOyp0pPjAb
 5EdcYr9dHErlA+kipMYhse+A7PtaI3D1MPxzk/hxSq7fTimTdnygrfP7lNvP+Jqe8/qB
 5nmA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4ANU702GJ8ERvgii+iI3PiK11VkXUyvDc3PC253SNlAl8cLTbPzhNizyTo+EJ0dUL7UwUZfU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz8XHUVLCnwqXwPXw734RhEeT5MolF+cldJ2pHEyHjngbRqiXui
 c1ZopJ39ZSnsnThsyAOQjsOMsstLsFkF5yFWTuLmtfphmHWmc89pV3fv5H7oBkWsJK82d3auqIT
 o66KDrqSlXkrekpyL05ySHPpQI9h8BVQ=
X-Gm-Gg: AR+sD10oJpHGdYNrqXL9HazOiHGVdx/xsRF80lYPaAudnowlnsWC6R5BHKMKegusQxi
 jo8mewiYBqtAbUBHHy9Uqq8s0p9UxoL7sYhYmCz0Hk7g8dtYdH1f3jM6pD7UjKPnpN8QIJU/C+P
 rHw5BxgEzZWiYXfG2YHCmNI23CXZksYNMV49DUPY0npGzf/VT9TrWM37JguXHUCrv1kQJW7z2Mh
 kKN0zO3sXg4k/gHDuBXITQXIElLCWkITlW4ZmbTgA//4L21pBkgPlRp0+wnhwQCy2FCxRR9LLuw
 wm+XuCRMgveLBdidu0tFs9J2FtwPhmuQeeCgBsUc5xkyAat5eTLDpMtGrYLeWU0mbEMseddXIxk
 6EU70I8J4aJrouFcyPNf1tuPgk18LbnvPEw==
X-Received: by 2002:ac2:4644:0:b0:5b2:a353:e4bd with SMTP id
 2adb3069b0e04-5b2e4f74c67mr1161266e87.30.1785759385404; Mon, 03 Aug 2026
 05:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
 <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
 <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
In-Reply-To: <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Aug 2026 09:16:13 -0300
X-Gm-Features: AUfX_mwj6VdWDQacpKYxGIqIuJAbtczGeIOuS_8vJgsuMxlwW7PcaUi95WUzHts
Message-ID: <CAOMZO5AhOZcsAc6DThNDcXudk5fWrm1gxgzwvETWX3hQ+Pj6=w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785759386; x=1786364186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jaasSxO/RumxUkhVCBjve6zUrFuH87QTe54R/HIH9DE=;
 b=fxW0NT0IZ94+W7f3/GvMhvFgFgC1X8kweAU+7NMA/PSs5ckQ30X8ADDikcKFnxyiG9
 /uEcvbW+B5xgbaSA0xF5NhW0QP7+N0gFeiVrdiG7EbbO/ZyYxYsB0VV1Pj8I5pTBjBNO
 m/2YSCgtI2AVR4406KhkvY+zCH58LKvDIfacaYHXtLGRTWghDqYn9LUvAthWc7rkXX8R
 8lV2o/o4J7b2rYaFG4Bz6yHv20e14ihfb0/nZMRtUSZ6wzzRmY01qsHNHZMC2ik84aTq
 Ek5Al8wHMcr73PxxmiPzFJAr5zq7ZlkkTDlfR1lbpDzho+vTi9pxkuwAq48P1TGlWMmH
 gbvg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fxW0NT0I
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

Hi Joseph,

On Mon, Aug 3, 2026 at 4:36=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wrot=
e:

> On i.MX95, `netc_bus0`/`netc_bus1` are internal pseudo-PCI buses used by =
the NETC subsystem for register access =E2=80=94 they are not real external=
 PCIe root complexes.
> Without explicit ordering, `netc_bus0`/`netc_bus1` may be enumerated befo=
re or interleaved with the real external PCIe root complex,
> making it difficult to predictably identify and target the true PCIe inte=
rface (e.g., for NVMe, PCIe Ethernet, or other add-in cards) in boot script=
s and environment variables.
>
>
> The `pci0`/`pci1` aliases fix the enumeration order in U-Boot only. Linux=
 does not use `pci` aliases for bus ordering. In kernel, it use 'linux,pci-=
domain =3D <0>;' instead.
> I prefer keep the alias in u-boot.dtsi instead of upstream.

Why can't U-boot use 'linux,pci-domain =3D <0>;' just like the kernel, then=
?
