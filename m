Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177F0C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993918823C;
	Fri, 17 May 2024 18:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="avdw0sNc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVRcPLrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CB487ECD; Fri, 17 May 2024 18:36:20 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258A788489
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 57CCF138153C;
 Fri, 17 May 2024 12:36:17 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 17 May 2024 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963777;
 x=1716050177; bh=hfEGXBjB6zXiwex5AZeDBwSS+XxMoUAB+9cw8Qig5QA=; b=
 avdw0sNcTl+mQlPIah4gmQR5bjuhB8J09rykxt8h+z2yvE3M4IdrDovyg5VRp2qy
 CRqRahH+hGR3whBvxhtwXeFJWZ2VlCnHo6NXoM4VnRbU/QfmROHA53QVBQpnN4Y7
 TUuPGRVCI5s0mS6Wbv2QKBmeiAMrCaaTjAAZbBHE2OoKnIHly1O0eg9h7A166eEm
 5nWUfy7yecIQOXbZIHxoxhW7z6++LcdgYXPCwobfQ3VlpzfOTvZwkkqNM24DG5tn
 L36iWbMNi9uDO0ojOng6sQEg3HI+UxwKm1hdqUjN6CXYn0UXcPf6WHajtRZrznFT
 WOWEdLPd3+B13bo1tBwSBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963777; x=
 1716050177; bh=hfEGXBjB6zXiwex5AZeDBwSS+XxMoUAB+9cw8Qig5QA=; b=M
 VRcPLrFHDIB/nwA1a5aT5EL4WwJN5Fo8lX0EfVfdFPL+jaKsdn543GE4Op9bfZab
 /mtAVJxS9nHWPzktfKjV1fwie1xIjPIfg8y2H2JXTZ0iScqGNzV++50DUe/nTOjO
 81lyQuea4g7/0eK8NF1ZPB+nOwIcfEY/U5BdlcCKhUi17eR+kKSZIAw5Itgs8n+I
 Ev+hZjxGMmoRiBvK8kV+EuI+iQ+lY1RYvotBYr1ULdbVelLJYCVk0vVo3aq+e3Q2
 OV5NVJpEl8oR7UF/oLBfKk+d2TP7J3f01URFoy8uUJywFcOBwejxdlmWSV4Blbjy
 t4XGWdHnt29c2PszQxu7g==
X-ME-Sender: <xms:gYdHZlu-k71RyoyL1BGBW-ImWnrb_ccjmjSD4JUqOyEh2wY_GRoEBQ>
 <xme:gYdHZufqxyJ4iZyw2J8gcdDnF9lKRppOaz626f9Y_tzetbZBSPtZHOFGO5Lte4txg
 F0y_xBa9hnoTlncESo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:gYdHZozmfkJhC3H-tl6DH5RcP1IXeEv82guOkwXNqyGcdrnTN1TH2w>
 <xmx:gYdHZsNdHYnti1xztTgwxum4zJpQlm6q980OotLZHKambNklnh2KWA>
 <xmx:gYdHZl_ixYktowBy1GmwSEqq8oZYupiqoP6gHatgsqeCn_R52nrmTg>
 <xmx:gYdHZsVYHQWONFiOpMVfpqLb6d-4k8DBCY5hp4tj4Pw7JZiLON55Ww>
 <xmx:gYdHZhSKJA8DeAZT8fmCry73xVSVpWyKsCSfw-6fL90Qipsjt-pTDjIc>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E91E036A0074; Fri, 17 May 2024 12:36:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <248bc1e8-2fcb-4865-a7a3-dcd2e0df1aa5@app.fastmail.com>
In-Reply-To: <20240517160624.156962-1-heinrich.schuchardt@canonical.com>
References: <20240517160624.156962-1-heinrich.schuchardt@canonical.com>
Date: Fri, 17 May 2024 17:35:21 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>,
 "Simon Glass" <sjg@chromium.org>
Cc: "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "AKASHI Takahiro" <akashi.tkhro@gmail.com>,
 "Sean Anderson" <seanga2@gmail.com>, "Alexander Gendin" <agendin@matrox.com>, 
 "Bin Meng" <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] defconfig: disable VIDEO_COPY on the sandbox
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=885:06=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> Since commit a75cf70d23ac ("efi: Correct handling of frame buffer") th=
e EFI
> block image transfer is broken on the sandbox.
>
> To test build sandbox_defconfig with CONFIG_EFI_SELFTEST=3Dy and execu=
te
>
>     setenv efi_selftest block image transfer
>     bootefi selftest
>
> Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

It turns out that texture copy is only required for 8bpc display, which
we don't care much anyway.

Thanks
- Jiaxun

> ---
>  configs/sandbox_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 93b52f2de5c..80c310b8e82 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -318,7 +318,6 @@ CONFIG_USB_ETHER=3Dy
>  CONFIG_USB_ETH_CDC=3Dy
>  CONFIG_VIDEO=3Dy
>  CONFIG_VIDEO_FONT_SUN12X22=3Dy
> -CONFIG_VIDEO_COPY=3Dy
>  CONFIG_CONSOLE_ROTATION=3Dy
>  CONFIG_CONSOLE_TRUETYPE=3Dy
>  CONFIG_CONSOLE_TRUETYPE_CANTORAONE=3Dy
> --=20
> 2.43.0

--=20
- Jiaxun
