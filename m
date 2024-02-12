Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A807C4829D
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FAC87CAC;
	Mon, 12 Feb 2024 21:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Kzi+umfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537E687CB1; Mon, 12 Feb 2024 21:56:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5F087BC3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707771361; x=1708376161; i=xypron.glpk@gmx.de;
 bh=yaOfPL1jxsVsQYnauwRjHkE3+eISfA9+DQMPmrbCSpQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Kzi+umfm6fK4XbqwdlF7+oOzyq1hgNUnXgzQCTW4AForqzECJQsPpmStoqETIH/Q
 jCkKiQdxoV3dGgyKgdFrjKpM0Q6606hSnLzG3urntD9QG1+bjmRFBRvDiF9dwfDHn
 qEqT0SaxAn9yyRZlWHo2ZE2W28Fd07ITzUmkzj3rBkRQn3Yn6BPg+6Mh43cr3izjB
 0iBj6nW1rvXQ+kbtD7drCLHCG4q1yKk/0AT10qfgSp1oeG7nS28T/h2kKxVPB3Ibj
 zLUZ2IKIPSUIeI8tw68Iq3hBkIE/MUmSC2DhxKRKYhIz/2DOe929dd0FKmup7hK9H
 /y3TSdKnwnC+CIZppg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1riT203uoy-008siy; Mon, 12
 Feb 2024 21:56:00 +0100
Message-ID: <5c1da5a2-d59a-4b99-82f4-cc12b965b97d@gmx.de>
Date: Mon, 12 Feb 2024 21:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix mistyped "env flags" command
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240211-doc-flsgs-v1-1-c1c71f88933e@t-8ch.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240211-doc-flsgs-v1-1-c1c71f88933e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X3m05iu2Z+t6ish3m3CxxzrnIaEhW02PdcguDYI7WW7dDLrhULN
 X+pd5qaZvAnWIIV+I6mXY33OWHdbRwRMigoyC38TU1vumZxU3bbH+DRUOfH/sBTyB4dkusm
 2UNX5oiAJQqGduvn75DQi6WJc1jBqBrzpe0/KnSIW5U8oToKWb1sf49MDmVyua2n7kLUUh2
 Dx77dL2DYXZb5xTFaEDiw==
UI-OutboundReport: notjunk:1;M01:P0:km6TlZJ9Lkg=;7kNTkadXvtRziNDn4cs/RObLps+
 K3dlK2ERHempwZkK/L+HH8i2p/BBROEIkKeT1vYllS5f4BPczSthNge4GQGVNez0jNEaBS9xr
 aDmttrm+q7YQ6ARo4vuC9GAXweMP3ThtgNvbMwJAIrIX9agNGI4RvO+Dq6JIb3cGcfml96Mew
 Tb4+s4lp7Gv1EVPpKqxffdXE+5x6hOuGXfKzsEyLm6EyqMSFrZVoB924vQ1MyQaExrLVEVJZg
 KCGBVGSENluL899SFksenJXkok18KD95HuCkM7+e0wxv632TCfyiPfr/P0/bDeTY3i5YnllT1
 Ui1Hzz0Uk9yn8xD9PvbsjOV6/nxRkwaeIFGUwNbEkcqIpy4E40JTJMCHmkrfJZ+I2hKncA/GE
 17KIItw8ZAgHyJtA3lh5OjCuMo81RwSgiKon0d8KxDBPNt4Md/iWoRKa8wT9U/fZKA9kBCQGp
 /EVFcQquWR5otOGMg4RxTZVA5Vpi9r9sananQq8YlRYBjAzRPsIfhxp4fZT0/hsqWTLCf902N
 Vxrt2lEHayBcHlFBFiL9xF9C4WUspCSIJpCJRpP+qcqU6cRewfKstuK4a00UM0EBPEaVmjzH6
 SNxscX5yvChpbDoqDMo2OL7pY37kkhxj5Kxn/0sbAaPzsatdP6n6+ao2rufpCOz0n2YPJE4sG
 rFMhvfe4UJ9HdYzE2RPv5PKAXQEDhLC7PPDFJPySGK6g3xHefHiO123m9gfuj72g905bWJ25p
 xfwylCMSpyyfe8JtJwxzDAeGxuk5auKeXWKYCpwAzZ4nvA2Zq7eQTWKrBhTaDFfFOh9js4o4b
 4Xofyk6SO5ZkZ88UQa6UDX0sKjg6YfqY71C9vQWdJ1lb8=
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

On 2/11/24 21:18, Thomas Wei=C3=9Fschuh wrote:
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/usage/cmd/env.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
> index a859e32798cb..a7e21693a672 100644
> --- a/doc/usage/cmd/env.rst
> +++ b/doc/usage/cmd/env.rst
> @@ -350,7 +350,7 @@ edit
>   exists
>       CONFIG_CMD_ENV_EXISTS
>
> -flsgs
> +flags
>       CONFIG_CMD_ENV_FLAGS
>
>   erase
>
> ---
> base-commit: d7aaaf4223d0a2f9f8c9eed47d7431860b3116d8
> change-id: 20240211-doc-flsgs-31daddb198ec
>
> Best regards,

