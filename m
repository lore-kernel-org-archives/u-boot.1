Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332B5C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 13:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D430883C7;
	Fri, 17 May 2024 15:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Mz23VfUY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqHBmRH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3966883BD; Fri, 17 May 2024 15:12:51 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269A4883C7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 15:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 22D201380151;
 Fri, 17 May 2024 09:12:47 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 17 May 2024 09:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715951567;
 x=1716037967; bh=OrvirtWoqPU88r7h9ILiO/rpB+tf2cHTTudnymcDieY=; b=
 Mz23VfUY/0bj71kFXN78YWA0ytwudAkzkkIY2jivLHAjNlwbP86cliVXNPgBF4xk
 cTakTx2MoCWNA58EO54H7TOkwvUlEwdcLR8qyCH76ype1SieKoPzJR/POhhZh65t
 HhZfNZ6Z4as9vR5SGb3aqvYRMEwwr48EWI3eGz2iR2aMI7CW05dNWsJx2yylBqye
 NFa6Ucr0+C6c26FN6MbkBpGxWGX7GZlwfXnzhMfpZ716AN+L8Uk00NsUi7exXyyj
 h2+23oxL/TJUnzF/5+7VFIaQ+m1ZMZBX/Qqny/UM2qt6MlCpShLkMz/xLtwR9GmC
 leSPUVMk5pEuaEI/GgMqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715951567; x=
 1716037967; bh=OrvirtWoqPU88r7h9ILiO/rpB+tf2cHTTudnymcDieY=; b=X
 qHBmRH14zr+xfU1nBWFQ5qiC5U0BT4YDLS+IBQGUV9blJ0JX5ruzK2wjzznHjvj9
 NGO5OyVNGsMY+0C9W+WpAmeY+DD+SeR1W0SGM1VMJqzr9Zej8hUIr3ousbY2K7Ov
 tG0dDe/w/6or6mr61O3PTUvzO8KQPyAnOJeGMrQaWe2gcqDmwpty1OtwquxbCo6Q
 TMyCMZRLGA71M0umxeoSlwcToDQBBNLWdlsMzBsAqavCLkxLNApCbyKP/Q3LHaj2
 ic5d4MpInI5IQwK6vFtqQVIzg5BWH0uzUbCqxjrwWD8OGt1KbdFFReIqzB0meJa+
 /oy0XUm4nUtp0kpCcq24g==
X-ME-Sender: <xms:zldHZqsPTisuuVUDxMZyTLPMpI_ABMFTCXyrGU6aI8-3pKfATLZTag>
 <xme:zldHZvdp6pVIEaWKeJUyte_AYZTcIv3OKc2sa-0yxBrm2dLNDYIfy4rtrPggJiZaW
 NZ9X8Stxyb5MDO0Wms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedguddugecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
 jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:zldHZlxgF0lqF5CA66t7WGKZCJuEegbuTL4dGEW-fW0mcgZ-OmFZjg>
 <xmx:zldHZlMbOgHtqNDRhbxFw1XILhl35Kgkh3x0k6V9VH5xvgCyvxbgqg>
 <xmx:zldHZq_4ESHGGOZK_w-hLey1cHdagluJH5Uk9glrsBcC97Mg_8qExQ>
 <xmx:zldHZtW4Tr73w9rJYyJsikjEeD1lpDXZeCucFCpl90OF2RmhiZL6Kg>
 <xmx:z1dHZhkcEo6Rrq488PPhpzJs8nt3sDQlCdFvXCy-qfC6Fr5nTwGjk8rw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id CAF5F36A0074; Fri, 17 May 2024 09:12:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <4ad0af46-e722-4646-9432-88b167950777@app.fastmail.com>
In-Reply-To: <96451f9b-8411-4764-ace3-45b25f097f69@gmx.de>
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
 <96451f9b-8411-4764-ace3-45b25f097f69@gmx.de>
Date: Fri, 17 May 2024 14:12:25 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
Cc: "Bin Meng" <bmeng.cn@gmail.com>, "Anatolij Gustschin" <agust@denx.de>,
 "U-Boot Mailing List" <u-boot@lists.denx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 01/12] efi: Correct handling of frame buffer
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
=8D=881:46=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> On 11/19/23 20:11, Simon Glass wrote:
>> The efi_gop driver uses private fields from the video uclass to obtai=
n a
>> pointer to the frame buffer. Use the platform data instead.
>>
>> Check the VIDEO_COPY setting to determine which frame buffer to use. =
Once
>> the next stage is running (and making use of U-Boot's EFI boot servic=
es)
>> U-Boot does not handle copying from priv->fb to the hardware framebuf=
fer,
>> so we must allow EFI to write directly to the hardware framebuffer.
>>
>> We could provide a function to read this, but it seems better to just
>> document how it works. The original change ignored an explicit comment
>> in the video.h file ("Things that are private to the uclass: don't use
>> these in the driver") which is why this was missed when the VIDEO_COPY
>> feature was added.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 8f661a5b662 ("efi_loader: gop: Expose fb when 32bpp")
>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>#
>
> Since this patch
> a75cf70d23ac ("efi: Correct handling of frame buffer") the EFI block
> image transfer is broken on the sandbox.

Our situation on sandbox is a little bit confusing to me.

Sandbox requires explicit sync itself to allow framebufer to be copied
to the texture, so I don't really understand how does this work in first
place.

Thanks
- Jiaxun

>
> Build sandbox_defconfig with CONFIG_EFI_SELFTEST=3Dy.
>
> setenv efi_selftest block image transfer
> bootefi selftest
>
> A moving submarine should be shown.
>
> Best regards
>
> Heinrich
>
>> ---
