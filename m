Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A1DC54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFAA87F0D;
	Mon, 26 Feb 2024 14:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K5S/DcyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF78C87F10; Mon, 26 Feb 2024 14:31:02 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9489587F0D
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 14:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d2940ad0e1so1793038241.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708954257; x=1709559057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/25/TEquQpkTbXhe+wfeKVyhsGs8ZkVYO5TIbhuY+0I=;
 b=K5S/DcyOlI40neOJ2IW/y4N3qDWgzMA6Os/VqBY0FbWa5AbAFxyeIh/E7ryHpBE6B3
 hg2yulueMFocndvLOoPMBN2OPoeJnq4u+FFkAbBRM3G296vQirycfbBOoN3exbcnPYhW
 oSHaKG92HqBEj6G4PusNn6nfmdpXSfIxn51DW0NSJrtlGtFAe3z7FfEA/aesEixs1e9Q
 BKeTdmxlPD6TQdI51hjniLHvSG/i/TmDOFYuU1ptTxSXVBZfUbtAM3T3CBsHPR01N4SZ
 6JrJLSjmgXN4TpO44ccfd/6Hcz91XJXvIDW2MzUb9j8r+3IX3P0LT0axSPxo65y37AgC
 tldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708954257; x=1709559057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/25/TEquQpkTbXhe+wfeKVyhsGs8ZkVYO5TIbhuY+0I=;
 b=UC3Z412MBZtK992tkB70GeIv7pR4bt94C/SM/ucaAaNS8udwmtKPGseavgpT/JjdtI
 Ri5gguulTPBjMrZlIpZsIgM0v/iOnsWvPafJSyB211UxUMlFQqjm4i5jTbxjXERaHKpl
 g3uBIEZWFqhHcV3+OnVVLGvMie1PiYJWksjtZkaWd/NUXLrdd8qsRDWmVQYnEFhlJZhQ
 ykl570iLT/CX1i65cUWglRFwO++2HqRxDki0eVtxGCDwhr94ZDE5HHKdIlsS+ZSH1GFZ
 K76zXeCp3o4kew+gJ+Jn5g6g6EVcXKiqwa341i2OAFBRPi5xc7qoxW6z2iIXxyja3+x3
 l8rg==
X-Gm-Message-State: AOJu0Yy2GEB8RbS8ypHZuEhSWQnnjmkeGmvP+vSyU9UVMkqvC4JC3fJT
 34LzM8iufvL/wyDf6X4Hp8npu17faNJUZyBMMrxbsNf21ZfHenp3ikaZPmGno0zYSezG4KidjVw
 cLsPklFoi124XZ8pPm9UsKgjLlC9c21ZYdnwzCw==
X-Google-Smtp-Source: AGHT+IGrHLiKe/orwJ2WZ9nbBdvdoyxs4xZO5cfFc80g/YtF7t2aEjPBSYgANbi+/mxH7A9anOynXoV25xNWhp6xlaw=
X-Received: by 2002:a05:6102:5ca:b0:471:e2f8:bd2c with SMTP id
 v10-20020a05610205ca00b00471e2f8bd2cmr2106994vsf.26.1708954257272; Mon, 26
 Feb 2024 05:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
 <CAFA6WYPdqsD7Xy1EwX7R_+A3UiskvxaTyvR6D9qP45WhUxxA6A@mail.gmail.com>
 <180d7078-ac13-4d56-8ef5-2b64f7f41937@denx.de>
In-Reply-To: <180d7078-ac13-4d56-8ef5-2b64f7f41937@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 19:00:46 +0530
Message-ID: <CAFA6WYOGzrM076RJv6Mp_Qaa7Z8h3hUC4mRf8CerkVUB7Ac3oA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Marek Vasut <marex@denx.de>, lukma@denx.de, seanga2@gmail.com
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 18:34, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 1:50 PM, Sumit Garg wrote:
>
> [...]
>
> >>> +     ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
> >>> +     if (ret) {
> >>> +             dev_err(dev, "Failed to get PCIEPHY reset control\n");
> >>> +             return ret;
> >>> +     }
> >>
> >> Some clk_put() and co. fail path is missing here.
> >
> > Ditto for clk_put() not being available. However, I can add the fail
> > path for the other reset.
>
> Oh, maybe reset_free() and clk_release*() then ?

AFAICS, clk_release*() APIs are internally only a wrapper around
clk_disable(). So actually those APIs don't seem to do anything useful
in the fail path here.

However, I will let clock tree maintainers chime in here if they plan
to remove clk_release*() APIs on similar lines as with clk_free().

-Sumit
