Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDCC369D3
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 11:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE3F88B63;
	Wed, 25 Sep 2024 13:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fNLjkL83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD5088B79; Wed, 25 Sep 2024 13:42:00 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F67788B59
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 13:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5365c060f47so7797491e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727264515; x=1727869315; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVHleqf8v87ejrsn38JtdS+UO9N14bNGVN+hummuiiE=;
 b=fNLjkL8377eTUD0YF+3UKPIVA75DJv/VvMscZ2zog1Q1lI3kN79Bmq6zEYahwMgYdw
 Q40XIXv3wLOmfllSEAP/OXZ2ys8VyyzYmHxaQn5L5DYzmfPr6N/P0tRmG8jFReqBU4MV
 ffXsxDI98iDWHIdpmVjy/+rZ+uoBQA7i6r2uG+H6o+SVSMr4lV37ZjQc3LI0L4jmZL7F
 i77k4/uVJTRwIxApAeVhxsnDdgWY8XnZXIPi3Yj5yhPtb/tp7U83iYK2yshLQyXS/b+l
 SCs2KNDt+BPqRigx61d8AD4/MbpowazY5q1gBdpL39IFcy7cvfvRS4GXCtpz3e88fU6W
 rARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727264515; x=1727869315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVHleqf8v87ejrsn38JtdS+UO9N14bNGVN+hummuiiE=;
 b=Yyfo6CCfk7AbctYPbVcwYqp0cwniHyHDxQScyjwPpr+yAxM+G0mR1Re6aYksIx7CDj
 tyyKkD1EaTKBMXvHhTBew+QiGwgcLGr0zbLVK4bKHbUsuzqEzwcXUUir4QM/JOGv/vkU
 6oYUksEdfeytFOhhk1o9t/TmiP69+NJe9iLBYtJpW2KIWCHQ/zOykKMUZ535puqxfLpP
 5Yy9FoR8futzf/4i88pTV5ixDXU+wZYqG/QsrgEj/N1tufv/hy99bYmhEP2hmfu/Egay
 aepPWg5IImRSvW7a/dOvk09b5yBjYyYqaiR47A2Q54R+RD5m6k+FGw5mtgi88OtVnvLz
 swPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj5jJKByuZcb7Ch2Bt4j0u1YHJ/aTe2fYFs4w2Ckw9i/k5sX56wlrDFXlSxe+OVpH+BHNHoRs=@lists.denx.de
X-Gm-Message-State: AOJu0YzPTTgvttCD200qoVXU418Mr9lPNUFtPWzITSALsFQF75Lkf1vS
 lGG1OOZ48cgNzgv+UkqD0DeC/hfANmSXU95HRabYzGxEsnAy3VECOycvVKF5hIhTBLhV5KpBnqG
 vMDLVaTjWcK76fhLiekjtUsi/Ng0=
X-Google-Smtp-Source: AGHT+IFttmH183T+bFX9y3Ev0VgvWTshSTjj2IvNHT0O9ADdS/iBwPwTOhO71uK/HuiIFvilouS5inj3OAVHfDpBceQ=
X-Received: by 2002:a05:6512:3a8f:b0:536:536f:c663 with SMTP id
 2adb3069b0e04-538704986fcmr1438555e87.22.1727264514379; Wed, 25 Sep 2024
 04:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240924073200.27578-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240924073200.27578-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Sep 2024 08:41:42 -0300
Message-ID: <CAOMZO5CfFJq7T0eVkP7+sxhz0RMxNkmk6rTvoXfP+CufXfgOLA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 primoz.fiser@norik.com, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 24, 2024 at 3:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX93 FEC ENET port supports two mode: RGMII and RMII. For RGMII,
> there is an internal /2 divider, so the freq needs to set with (*2),
> otherwise the speed will not reach 1G and cause communication error
> in some network environments. For RMII, the clk path is
> ccm -> enet tx_clk pin -> pad loop back to enet, no /2 divider.
>
> So fix for RGMII mode with freq multiplied by 2.
>
> Fixes: 09de565f76b ("net: fec_mxc: support i.MX93")
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  only update freq to RGMII mode

Applied both to u-boot-imx/next, thanks.
