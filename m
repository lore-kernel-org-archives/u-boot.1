Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2762C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 19:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FAC87B6E;
	Thu, 18 Jan 2024 20:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ldl/ZDw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F286387A2A; Thu, 18 Jan 2024 20:18:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1271F87B52
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 20:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705605480; x=1706210280; i=xypron.glpk@gmx.de;
 bh=pgwj9c2woQ33Fwry0ISiUKYomwxKdxIZb0yPKPxzwow=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=Ldl/ZDw5sTS94ICGNn3UP8O9GE+qnO3/O/X6UdHsdmI4VjtPhFYkp1aqv5jK7kDY
 lMBOb2PUL8gdWLajIcTdKRJ1w5IZqgs5wnQvcImz6GbFgWbSO2Cc1ocmCR6BqmGvt
 TDPAK58kDdZH1keE0Xx54k4pD+Sm6g+SkzUpO+H30jrY1jJI+HZmrlP4v9e3nxRIP
 VGwMkxPRhmYew2pWkMvjw3lSBaLiln0qHNaD32DSM+6Bl8pXnxkzPbVz6BG0kXvdx
 C2AIrKU7j5eiN4A6lpxQkSv2HADwgrUY3eAu/ZJke4P0auihYkVOQGezVU9bHr3Px
 39eBkO11R9xu8rCWHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.55] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1qlvka3HZM-00pqgt; Thu, 18
 Jan 2024 20:18:00 +0100
Message-ID: <1cb7e983-dcaa-49e8-8b47-24a1cd058d78@gmx.de>
Date: Thu, 18 Jan 2024 20:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Bootflows produce gibberish instead of readable output
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgXudycrQflTi0yrGothK1oxCRR5obwnsek5vIQ3qMZs4VHyt45
 Qgsf4GkCTwdGnsmUdYEzWe4DCL0lQAIObmQw7GY5FtFWV0b/f5CT53/NZSV/GVzc46vC8d1
 X5XbmYkF3rnqisU+SwE/xQ9uIQW31+/U4+9IOjfW43Axwv8O29ZV9Oxgm4rggJLY5GPFkOA
 3eN/QG7u1NLjqhEA5Gdvg==
UI-OutboundReport: notjunk:1;M01:P0:cUUeuPxSXOA=;QNiAQ/KfTAROXrtbsx+mJzdjl/j
 sdDd0HdY9VTZsKSPQRWGSvhgC+/5yx13TmbQMvb2KspG00e5E0QGeLmrHnnsmvycuXGtj71gQ
 h9Maxj9OHMmqZS+G1qS1gRcyggUxur9jWcH8ZRs2OxtgQscjkW0Y/NuJPHOcTZjp4s58sRN1B
 pIWFxcUa/vs9+zgTV0MbBylQHJXjXnT4t6ekbsC9xJzsJiLFQOYcS8s7MPMZzxvxb6pk1m4bg
 hHCfL6T1nTUBPBwYCcYNsXq+w35WGy+ed3AMebWV9HN3v/xCAMEa2X0LkdG/FHmnC6nOTDqj+
 wNNeYA67osZvQl+Bi7cwOD9SSnX8iYpv9nSPwSfjU5xaIl3dkWMjTtwqaxrwWD6qYH8i35mMJ
 OGFdlnsExK4ONfrbKVh07yKfKI/nnUdtjVr+ovG3xHenPa0McZ0l4lTQhed7ZC6D+Ty9SW9q+
 qyU+M6GcR1FNL0/70j0YV45GGFHC0NnZH1r+B6NLAIBs04nBe7DQH8kGDPmnQg/842PcaXkgj
 X7JgiCy65CM/9kaOpDBl39pLVziNtIRg6TIvRvsVwBEF0/3POUeL3np/O8JoldLgwIOyZxZOI
 KJI74jcLkxvfvgX+J6AGx8pI/gHKxxCEgK/QopIp7kzKRp3TJ+b65a68VhBlm2Phl+FQWBBIb
 iOrOipueAzZbmprukVMaq2EqRWAU/byA6A23NX1zkLwRq76PWJJ4sGSKN79kvWZSAnwnxFg3s
 2sKK5hhFnwL4EKjmkixHnk3kxKd4Lg/TZXDcICZVO5wC7cM4AcdjsQHInizvvvQRTeVttKyyi
 xKUFaNlh2ucxiO3HbyfTI1DAEXkxJD2Clq+jJmTyvUKnx4b0yNfMpwhSz0U7+nQ0L6fhrpqFn
 qSZuxFOMe+Po2vGU2oWLhmMLDvHEPxrD94FF7SWL27SfCJ941QVWtJRzzcFdUJa10cVXJ5v+j
 sPvG63E/+xKZrMuMIjQF67EGNFc=
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

Hello Simon,

The output below is taken from the sandbox. It seems somebody intended
to write a table. But with all these messages that don't belong into the
table the output is not very helpful.

Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filena=
me
=2D--  -----------  ------  --------  ----  ------------------------
=2D---------------
Scanning global bootmeth 'firmware0':
Hunting with: simple_bus
Found 2 extension board(s).
Scanning bootdev 'mmc2.bootdev':
Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
=2D--  -----------  ------  --------  ----  ------------------------
=2D---------------
(0 bootflows, 0 valid)

If there is no bootflow, why is there a table output?

We cannot write a proper table if any other message interferes.

Why do we have so many messages with log level 6 =3D info. Such as
"Hunting with: simple bus".

Please, provide messages that clearly convey a meaning:

"Hunting with: simple bus"
Do you mean 'Scanning simple_bus for boot device'?

Best regards

Heinrich
