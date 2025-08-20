Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BFECA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D78F81E13;
	Wed, 20 Aug 2025 22:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XVIf2qrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D9C81FEE; Wed, 20 Aug 2025 22:17:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA188004F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755721041; x=1756325841; i=xypron.glpk@gmx.de;
 bh=IufqXpBHspK3FrzXeSJDJYYOO3gjNhIQFmEJlUTJXsk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XVIf2qrV0f2Povr5wAI5rDSXGrCd+zqo9EFJIks69e/fj+ysNU7hXH7UElMWq7iF
 +RVgDOT3129wKpmKARznXmKSbnU58JN4T73scDWQu0CgaZns3J+bBIb2IUiZ+eFvP
 KbMM/bbZVjvgfk8zrjP2EpWUofygXFRBT/Nx/vbG8EMnJClLE0QsY908p58krYeNE
 R0+ZsUVPLCYkEguSYgdQ+vBM7VSH0kuTRHtmSfF3zSdAoIChXgSpgChnKe0X6WShy
 khLnNXI9tf8eTYml5WMkbq12u3lcneiLflFf5mLhmj3CISaY++kObYodweCQCsmSX
 b/YUK4XHe4kqrbRLBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1v5f8v0YeD-00IJTl; Wed, 20
 Aug 2025 22:17:20 +0200
Message-ID: <16659fb4-2528-4615-bfdf-3e7fe1023ef0@gmx.de>
Date: Wed, 20 Aug 2025 22:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] doc: Fix typo in tools/buildman/buildman.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>, u-boot@lists.denx.de
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-11-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-11-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9f/qldtayu/u6KnJ2Elg+iE+AeeT5QU4pugDgcsZeUgk+xtupCV
 fIU3BXZXZxUM7SKXPXoVEMYbhr2iO5Jsu0L+H7w1I0gWEHR3TQ2TXoPAofkWMjguk+hkSg9
 18MSh5AKJtQbu/KnY0VbrVUsV9ctUk/yfBYsgVkcDSWnlCPWWBORcRCALTfJHCOh6ZoG8/f
 o5F/qpkUdP6GzB9Id6D2w==
UI-OutboundReport: notjunk:1;M01:P0:IYmDfkk69wU=;OAn3XBg5jU8lnTdHCc7KNKfG6yV
 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
 KyFUI8mxSibskKDQ60uLsYX74dSN
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   tools/buildman/buildman.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 3e41d6ec304..2f365ae4ec9 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -1364,7 +1364,7 @@ regeneration of the file -- in that case buildman =
exits after writing the file
>   with exit code 2 if there was an error in the maintainer files. To use=
 the
>   default filename, use a hyphen, i.e. `-R -`.
>  =20
> -You should use 'buildman -nv <criteria>' instead of greoing the boards.=
cfg file,
> +You should use 'buildman -nv <criteria>' instead of greping the boards.=
cfg file,
>   since it may be dropped altogether in future.
>  =20
>  =20

