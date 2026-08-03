Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C5EC5516F
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 05:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91BB080D0B;
	Mon,  3 Aug 2026 05:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2z5n5mlAKz1; Mon,  3 Aug 2026 05:44:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD89780CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785735852;
	bh=SjtLdB5K4OdRG4CBfOjAC7cI3FuRz9ZsrzsJ7wb7axY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JnGFw0jdzrWMvcjOz7uuF5kPo1NxoS8svf74XehabB0QrvkOtUe0+eDOwcB6D+ms6
	 pOJGEK7lCTNgEvYJ5YaqGT2ofkWjTDhkNo0ZJVWt7pXr79xT5qn5Px1oYnT7wf1MeT
	 SUmXodc3c0HO9UZt2oiUJVjH2D5tcGqeO2SbVQW5qEJUMSxXBA71CVDZFnoJYIVuah
	 hcsG5yUTahTikMhvi5W0dLIMliyEVMbyR/dsBr1oTE43oWHkqOGDuJZJm46jHvugL2
	 AObH4OJltbM2i6jqjX7azvHvCYz8nSHjxuJH4gGAhDaAvFUkkIBQA2MboK0inCGqtp
	 jMPDjRJnWeEoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD89780CBC;
	Mon,  3 Aug 2026 05:44:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C24EC218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 05:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8EA060631
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 05:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9uwHGbw95PS for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 05:44:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BB27A60600
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB27A60600
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB27A60600
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 05:44:10 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6685483aad2so4489052d50.0
 for <u-boot@lists.u-boot-project.org>; Sun, 02 Aug 2026 22:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785735849; cv=none;
 d=google.com; s=arc-20260327;
 b=SaqoSUSj1qefuANAhEIOXH37ydfVUlAKoNazDEsMHxVLE5tYHLek7ZMCi9jDM5hbah
 VRt8KxGlsKyyWPl0zly18ClQFYO4QO0vbLYXPo2w720kF75/kQkTvLp42OhIEecJsOIQ
 NnT7SNRvkHHA3wXFzI6IneKYUzmgVQP3KMozY27HZ7royv5Wqqj9mHqfw57HQdmibJTF
 woo4QqeryBDmEd6uE1usbAqjnG6Hk2u92WkbXSKc6+YDQyr2E/2LS9EcRSdrhov0waEY
 q3Lb02A5RjoChdTUz6I+rcC8aD7l6oSFGqvAutmuwK7TmOLpCnKwZaz0mWmfaAbbABq7
 +tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SjtLdB5K4OdRG4CBfOjAC7cI3FuRz9ZsrzsJ7wb7axY=;
 fh=uskDrwEsn91rgydCGx3xWxxJPw/88IL160Zea4Qi7g8=;
 b=A+W92LhF49o2kduCD1CMdxm6EAOBlmR9+FWbeZqMiBPlK3R417RqVDpLKuh+cu75F5
 Y4cg67TMr6gupDy4cXO9lMWNKE3Ux7xFNw+nPvwL46scNNg2MbI9MSsnb5hlsFy1sgZE
 ONV0RO8BnKrWReNmzb9FqwtUTlaM1IZr62ax+VGvyfQMv6Rc25AatpBlczAnZ2BXJoD1
 59mFi22UHrWdEDrczkhcrchhmOh+HjBr5rd7hLrYmyerw9EjU38nMcQirI2TfzisXto7
 wtxVNn5ELxBII/7RB8I3o5HbAuB12KxbMsm2a4G6pGpyfWAZ04wl6xQsd2LPCz6F5o1w
 2SsQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785735849; x=1786340649;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SjtLdB5K4OdRG4CBfOjAC7cI3FuRz9ZsrzsJ7wb7axY=;
 b=RiqKSKxLDLJT5nfAg37nqGHWocV5iDwaPBK80+7jrupLUu1G9PHdn6R3Ro/4qKx/jP
 /HikdtqtvRTYjbEm4BPIphsatF8gZYjQ9xJnk+SwHVYpCSfMyNnebfO2o0iRvbhoxB4m
 V1M7lvtMR2i48Fu87PofHvBFsloIGdyI0tDwBQbKuw2UhRjgfI9pnrbwwEkFEWaXhEr8
 YSDfIHono/LvSic1qPyIRf8ny12ac0J/3BQv5lqAtoPLW5mF+NUYu1xFvy61RDbhl9yf
 uPViz8FAWjxlYtQdJaI3sk2PrbuKY3G+mAb1G3oT96MbjZK2i0ksL/bwgE2czb2brXe9
 BcOQ==
X-Gm-Message-State: AOJu0YxUqFbGveuHZRO/UI8uA5tQo/CRIM4QCCPH2j9G/QYyxvpKmBJ3
 f/N8TN7x9Ig/OoKNGZ1Uq2YLHN6DAgxvj4ZviomXDlFEjBsAe8eS+uvISSNJxhbbHV9zoTD0LHM
 ZRb9C1yuZVqBL5zwmaIYuMP7dXPU4A9lUW+Nw4Jp/Ng==
X-Gm-Gg: AR+sD10+0JO7m3Jcz0wqnwUiXY+h8xCmcRj0T74p5Pp5YjYDFTRGXIdZul+AfK3wNdk
 Qb3v/TC4Q01opfICj78nhMDKly5pmYCTeAyCFyhzucBusRP16Le37ltGdbA2vMOkDLVc2WI1Skf
 h/94CtfZ1T9yewzftjxlDL73ZL1LdVU0tATTYVL1+1DwRAifaHSyJyI9r71XgPvc2sz6wIygJNa
 3hr5HUTI1/rdOiDmcCuEHMsJgePLdXNI+MN6aVbhXIGsxJEILGNccS7erfG+oJ3QLl+GMF3aQwj
 BezvEFdH/SysvXCsup2pLMhax7YkZjrBTe73Thea0FGOaf3REIrz3rU4QeexXKN+1OMr+K08CKQ
 5FciBNj8ysY3Qcc2SLzf/qJOvvBEE9AocDgqFGDAari1sllGpVkJRKqIntywBfCWVHJ2U5LdgcE
 0LSkcnveCG95Y/Ak13LJHtrLuqMu5uovzSV57M8p0x8Up6POLFCY7SquUBEVpeMikIp7basKmeL
 n0YJBphSL/zvCHBWvBrslE+jQZzVOFBVN9faC7bzhTQ8Mwmfp/es+qjcCBi30txhLAzGTPbxErb
 /LDm1CQF4U6r24i/1AGQoHpx8UT8YY3F5Rivp1MnJButJ7FlPWppAfcv5Q1s/a5HZWLgowjtdPu
 lasnRDqbbGeMX0eUbHt8pAB3+IakQgmWTB5aOJ/NSWY4=
X-Received: by 2002:a05:690e:23db:b0:668:434d:a2f5 with SMTP id
 956f58d0204a3-6694efe1128mr8339073d50.1.1785735849376; Sun, 02 Aug 2026
 22:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
 <20260802213530.134789-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260802213530.134789-2-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 08:43:33 +0300
X-Gm-Features: AUfX_myUxas7KE8olcpLdx2sb3Z0E7xIP1vVowOpfT0O68FzjKDALzVVuqARL6s
Message-ID: <CAC_iWjLCHfKmYTjHFReRhWtadQ30z5YURhwtmRppoejnuWjz=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: renesas: Enable verbose DRAM layout print on
 Renesas R-Car X5H R8A78000
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785735849; x=1786340649;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SjtLdB5K4OdRG4CBfOjAC7cI3FuRz9ZsrzsJ7wb7axY=;
 b=btxbBIiN6x/gSJcrYujis1Xy+UoHC0TC9H8lJcD80U4s/suW5j/STAsSAWAv+GqAob
 DW+x4pj1Efv/bqxBcM6ABPlM6s9q9CFYUQbLxssAZrnxW5KI1AMzzXOcZWTjAyihaAfE
 q09mI+1uedWXPraXyDfDahHpl/yiVrEJ7xmuqjfzWsSexKR4irvtdZcnn3ye+yKwNGWD
 1lnL/VPUccYCZm9GhCnaz+ST/nW37BXQgdlLlOL6+j0knuM1z6PDeUaXCZmwvmmJCI6O
 1JZDSJGR36Mi62lrf0gR6Rzjwdh7+q6Ml3Imnq9QVjEwVPYz2TwwBNbRd8WdlTHwgYIQ
 jX4g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=btxbBIiN
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

On Mon, 3 Aug 2026 at 00:35, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable verbose DRAM layout print on Renesas R-Car X5H R8A78000
> to inform the user of the DRAM topology on board.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Aristo Chen <aristo.chen@canonical.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  configs/r8a78000_ironhide_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
> index f8a1403ae0d..21112c439f9 100644
> --- a/configs/r8a78000_ironhide_defconfig
> +++ b/configs/r8a78000_ironhide_defconfig
> @@ -17,6 +17,7 @@ CONFIG_CMD_CLK=y
>  CONFIG_CMD_MEMTEST=y
>  CONFIG_CMD_SCMI=y
>  CONFIG_CMD_UFS=y
> +CONFIG_DISPLAY_DRAM_CONFIG_VERBOSE=y
>  CONFIG_DM_MAILBOX=y
>  CONFIG_DM_RESET=y
>  CONFIG_ENV_IS_IN_MMC=y
> --
> 2.53.0
>
