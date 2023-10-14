Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1326CCDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E343986F6E;
	Sun, 15 Oct 2023 08:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WxZXItLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7413865B9; Sun, 15 Oct 2023 08:44:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D9986529
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697352231; x=1697957031; i=xypron.glpk@gmx.de;
 bh=d2Sa8Ajxm5CD2VwdpG5gCw3WboP/vW1UO4stPUvjq7M=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=WxZXItLzUYkIbDo4pgmzi87oNHchIe9s5LhAeuL/4rZtFyaVckQJfjU2BMqN+sfjYqpK3OADDJ+
 VQDYVocv4iTO3kMkwYqheMOGQmz1jHvYHojI4YetEjlcvXaxqiZFxB/Gz/AIjJXQzySQbiXBfAERl
 CnvBnE95ZBpA1hes3yYROdyJRY+u0H/d1b1I/sbtfI3gh5Y8JiTicA7pWf1KDAQvbc7XBCC/XS8xM
 zZT9xS8OLetGf7epTXk2zB/Rprp5lBodwSc426T66XgItvF2eQfZmyjWTerzXZ9rDMsm/TwcRWZQA
 WfSZLjxm8tc+5E+YdEuML7K0r/EiYJbhaGkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1qol9y2BC7-0036mS; Sat, 14
 Oct 2023 23:14:37 +0200
Date: Sat, 14 Oct 2023 23:14:36 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
CC: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 12/29] fs: Disable sandbox filesystem in SPL
User-Agent: K-9 Mail for Android
In-Reply-To: <20231014204805.439009-13-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-13-seanga2@gmail.com>
Message-ID: <4D6EDFC2-8A1D-406F-A492-3F1715C23731@gmx.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:vjPHvHfbneUybY80mJSpAJ+8rql2ZkFsbVYIly7CD9oehRE2DXI
 NfPXce4u4QJLozwl2qvMOjMjBxxp36J+0xvdDswhaeuuYsQbYC8c+KCwxdaO25OsZTAvWSX
 e5CF/8xT+Y4jOKEzuvge2vh3rWf33nOnM1GSWzIrjL7jnio07fztV2nuLf8PAuWShAn/E40
 angGEi74RSS/wN4AwrUfA==
UI-OutboundReport: notjunk:1;M01:P0:kSoHNcFe3eo=;17HeMira0cJoagcLnMu1tVJpV6Q
 cHG1L9JapmTfDOkIF1v9JCm27kGdTwEemECrWYND24R9YRtsotQ57Z7Ss8KQH1CfunVutTecQ
 QWBLfj+cL5ydfGB0zJYp1tVaWtaSi8gURhJXPBadRulVHEYrxiv9UNl3YRc0rutINh2JIyEq9
 GNEJ7QxHEctVtDetEp36JAahruTLmy46BEkwkLgf2PH2dp9t02pBjXDfE3KRu78YiReHU0uDK
 V6oAQpmZhg+E6JcVl4LygqH+9liUGPmAX0AGVWkErBm80dFJSerOTcxwnERQ34cfE+QDAXsI4
 z4vzjwLgWbrFVGT5CV4STpVOcE+pYcTQJqzdjHTTjcpztpNZlY4xZhG4Je7Zrgw7qpNptyvca
 NiTIMAYVZpZO5/RqGD0teepm99DdTqIJueA1c3IhDvQYnXvKoJC2/aWeNy/3NLE+xkJOY2rfX
 48qxvvWPgk6vKcQ+GaN2KwRFZIW7o/f0tYmxstgvLLGekcpQSZ4f8wrrzZGplSngASRZQNY5v
 T42kGj8otplEVqu/vAl+sopWLh+4zShM6c2toGIy/4gqvBvCgUKgQ7GVe4LrmbZXpN8GYXFdZ
 YxzBpf2CjjfpngOyzS8o9Y0i4gxbYu32e+7nfEZUWv5rjLXK2tkS3jK5AYJhbtyB9vo9WF5Vz
 h0wWNXPh+XTRhhQ+AiLDOhDyR6K9bhDvAzy/GZaOKefov3BIU/yn93k0u6sjJJPsSoO4YrXS0
 pbZBww6RnGGJGOj62xHb6jwSaD6nvyuUxmdhURzCVoMVTRbQFKPAXimGHNWzBMaTzjjD440Pl
 kd5YIVUBV/dijRpqZpIPJRSZrQeJDhjMp/DGA6jH4IpiHyrAG39aIhtQxbqwZWEArYgSv+FOP
 M4TG5Kt4nl7T43S52f/Vfz0oeL3bKPb+Vpc9s1AbKs/PyGgVlO2UdpkxiVn3TUL+iYoXziOq2
 nc0zA6SoQ+5Qj4gRole1sk8zOis=
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



Am 14=2E Oktober 2023 22:47:48 MESZ schrieb Sean Anderson <seanga2@gmail=
=2Ecom>:
>Don't bother compiling the sandbox filesystem in SPL for now, as it is no=
t
>needed=2E
>
>Signed-off-by: Sean Anderson <seanga2@gmail=2Ecom>
>---
>
>Changes in v2:
>- Disable sandbox filesystem in SPL instead of compiling it in
>
> fs/fs=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/fs=2Ec b/fs/fs=2Ec
>index cfc781bbb8d=2E=2E4cb4310c9cc 100644
>--- a/fs/fs=2Ec
>+++ b/fs/fs=2Ec
>@@ -237,7 +237,7 @@ static struct fstype_info fstypes[] =3D {
> 		=2Emkdir =3D fs_mkdir_unsupported,
> 	},
> #endif
>-#ifdef CONFIG_SANDBOX
>+#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_SPL_BUILD)

Why do would you disable the sandbox file system in SPL for CONFIG_SANDBOX=
_SPL=3Dy?

I cannot see that this is necessary to enable the unit tests you are striv=
ing for=2E Instead we should extend the SPL unit tests to sandbox_spl_defco=
nfig in the long run=2E

Best regards

Heinrich

> 	{
> 		=2Efstype =3D FS_TYPE_SANDBOX,
> 		=2Ename =3D "sandbox",
