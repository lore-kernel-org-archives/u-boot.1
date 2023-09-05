Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3840C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 06:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B918653E;
	Tue,  5 Sep 2023 08:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kjeIM443";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104288654B; Tue,  5 Sep 2023 08:46:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76323863C3
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 08:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693896356; x=1694501156; i=xypron.glpk@gmx.de;
 bh=48y3Dc97K1dEStYlY6It6NSIVyih5ZsVXEkrVjCPfpA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kjeIM443Ae7o/GL3RXbfJ/hrVlg7i4j/W9tJ78h4A0qImw2Ptds4eTNwQLBZTtFwSklHeWD
 QryiaaIyBvWa2j6BFgeyY3GoK0CeOLXTP2WIp2ls/7xqtswboE+L3+Aol1X37LSFBOIGW6r/0
 NdmWQrvdRW/F7AGs/6ztxQZ4LaNbgv+PMmw+XW9uNgX1XxOi2/8UM2Sufuul84LvttGNQ/HSW
 qOO4qqAehy9EqO0BV9Lp0KrD2shLxpDDufSbH6lqF/z1H2tlwqaEvlyX5hj4kiWWRv3QqmOTs
 gfMoC+jUsehhC+VACiqzk2aVCiv3QbCPsK4pp+CqGZEi76PBzNgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1pxVQC0BAG-00kQm3; Tue, 05
 Sep 2023 08:45:56 +0200
Message-ID: <510eb72f-cdce-4546-afe1-febe61b9ef27@gmx.de>
Date: Tue, 5 Sep 2023 08:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] doc: board: starfive: Add more info about
 supported driver
Content-Language: en-US, de-DE
To: Shengyu Qu <wiagn233@outlook.com>
Cc: mps@arvanta.net, chanho61.park@samsung.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de
References: <20230822143357.2818-1-wiagn233@outlook.com>
 <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fA1TAkz4LxJKe0ziKspR65JR0R7CWbUY/0t9ebp5srUR5K96rc6
 X3Feqj4SMHEAKVKlx/sTrCcMxU8rh6tk3q1kXBjdHO77SIsGSHm0Pen0ZwmzSWP3HrhEhJZ
 NyfP/B+l3jR0jiEhiOwwQOAwHtEX2B4DQMKglTyrxCIcDqJ3Mg2Ejb6Jv+0fQEx2E8Tm8oZ
 E7gq1fp2BQto2F3DR0LlA==
UI-OutboundReport: notjunk:1;M01:P0:n+8irQijkkk=;gZVW/yCi7fHo4tqPAYqS9/hs0+3
 Xg4X+3z8/+fcaw9lmAyZhdwrGQxg7JSysdfVEJgl3+hszi17tEJQiFt+DQzESEmiQgTFWw0/4
 mTy8k35DF5PoYdsjchvw55oBb5PFlZF4yBpFaq1SXFIa7ldb74PN+P8e4qdidXYXfiP2FBIRQ
 6hO644jr1QlpoI263livACEguJAvHI7fMdUC+ocZ1D3sFeBNvJZOOsSQ6ets9fe77vv5bKgxY
 4IxZMNBpSj+bUx1ikK4W8h0riynF1tKZRcMDGjkK9LziFovg68KVIMKUltd9/YUQuxjkabzYB
 nJdlv+Gkdz1OqV9iUjrcL/gxg9+thSY5hlNrrfKvnzCdZ+RCSyV8murqGLr2Q9Ihqbdky4uQw
 LtI1n57llJjk1m+eiZ5KMKziwx/0av/ZBI71CG0jG14zs9yU6boCWISxDPXfaYOKdQJVKqVig
 3LggGFnHNuMdDMBvyGO7LbGcBiecM61flqfhARSIOEf0UBL1X4NcuGVkIsNJZ42ftZ19L2lQZ
 IVKCxg497p3rfE2jyfKyAAti2PYjIzcquvhmFNoxV5uOhoGC75jpwXsXJIcE3tcB4MDjn510K
 ZDkhyht/5S4ykJbKv/KSFXjulQDIMF7hxyvykUwmA0Z5eTmbKaEXkwFTxjBfQAOfFLB37KZfI
 ln+dNSqVny/HAYgEWvwF7z468bb1fhDhgpqCUQ8aguHb0fyLpxlSmpe4uN7vE7yYzFSREgd96
 DiiA8TOKfxxlfV9tfIbYl7l86YQYV97L5noqStvKcVBXQa1fzRVoqj0+gWOyb8qi+6snWxFVF
 t4niOitNwLyIe8zXIT4347MSu/305109QWNha02IlGyaRq/s4OFJa1+xvwMcMJEi7dx0BLqjN
 n1XHTx9SM8amcjyOvYVCMQ/6QSjE4vbtRYgpBlnru6uL+FVv5a/veH2BLZj1U0IpcszE3RHOh
 C8g5miU3vkYojVOKnBMLUuvGJ2M=
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

On 8/22/23 16:33, Shengyu Qu wrote:
> Since PLDA PCIE driver is added and VL805 support is enabled in
> defconfig for Starfive Visionfive 2, modify the document to keep
> consistent.
>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>   doc/board/starfive/visionfive2.rst | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/vis=
ionfive2.rst
> index 941899a0a4..460f23aec3 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -20,6 +20,8 @@ The support for following drivers are already enabled:

Nits:

Support for the following drivers is already enabled:

Best regards

Heinrich

>   3. StarFive JH7110 reset Driver.
>   4. Cadence QSPI controller Driver.
>   5. MMC SPI Driver for MMC/SD support.
> +6. PLDA PCIE controller driver.
> +7. On-board VL805 PCIE-USB controller driver.
>
>   Booting from MMC using U-Boot SPL
>   ---------------------------------

