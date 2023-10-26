Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A19DC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6923787B2C;
	Thu, 26 Oct 2023 09:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bu2T98Sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE1E87B2E; Thu, 26 Oct 2023 09:59:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923CC87B2A
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698307134; x=1698911934; i=xypron.glpk@gmx.de;
 bh=F5eUsAVjmcoxWDzxFQl+xJTCfHo01axAlQh5rwzM1Hg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=bu2T98SavUtERKJZBRVBMW9sZclPFRXqByfQi90cRFepHBQmdsETJKIYc4wmdLif
 ciN1qCs2Ki6A8kuPnNLkvZdTQSK4ZJZC1sZdtNNBMW8lOKp17WDFSw10xbLJy6naS
 3SWslWokaNOKQivrOnTEBVY2BkhKRESbcZeotMBw25y859Lo5uf49sD0twSXsHOAF
 eYMN87x/SA/0pkguOR4ZgwdDHeApD60tIbbqpxvpWfNV+zNm6241+CPG5FaxXcy/2
 RUwxDZUn4ZDo9KOIM5AoQhDI9pMxZjUbHEcfO2/WxgqOU6UHyIZVoyMHEAG1KoMwR
 JeI9tKfFRu0aJkEYPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwUw-1rloUk0trQ-00uIBH; Thu, 26
 Oct 2023 09:58:54 +0200
Date: Thu, 26 Oct 2023 09:58:53 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org
CC: jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 11/13] fs: remove explicit efi configuration dependency
User-Agent: K-9 Mail for Android
In-Reply-To: <20231026053052.622453-12-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-12-takahiro.akashi@linaro.org>
Message-ID: <1276E605-F0B0-47A3-A80C-F17C6F8A7F3F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OHNIY/OxanHScT8rAej2uWmOv9CAVpsJ8emiTCI6hMpBc8gZMRO
 lZvXutgU0iDNtadk87WmIKaRkaKxfBjemzBcYUc9Y3GS5TGmzFeuLADyTqweM+NAx7wpg7C
 4JlbHQUJDWe16lpnX7dTNE0I76+mTm6sN2CHkA1EhCwDz9cp4C4BdqfDiDRk+hLsaranBj+
 Ld2gmzs2gPyKRkcGPHQow==
UI-OutboundReport: notjunk:1;M01:P0:E4iyQjNFVYA=;NeKl2OsCmAuJj4/8yRuW4zoqaFC
 N+iRCdmF6AWpc6tL7Dx9VvupCaJEcT0pIPrhckwwRbQi1Mxvs045oOWSWOMjhtfEZO2B88VKc
 E0HCkjfyyJ4qx4DOe5Q12XtY9jOBQzg6fQe9gNtb7kFdT6azgBsVWKPjjZ68wOSjPVc+Ldvg+
 n9D2fBENXvfWwnxb2Ig+TCJkMzmVxpWEz93cLKiX4OuYuLDHe9KTmJLfybK686VFifkB4iGBn
 XdGTP7GL25nrF7BqVSpAsnuQyDBJWlAYGCKEDzaNMGP5ysqSWqhKGKkHEC4+8MlYzLNGPbWzs
 PwdZBA+AGxfwQPBUKViofChQpy1ivNlF/W/vf7aS876IdxsPUejTkxNz630NCEZu3/YfGE6+y
 gWYuN6rLZY24Q0Yp5mwCXB3QT24E68vmkgwENl1ypY3qb2YCye3JdYV8ZzTdqi/csbrFFrbq5
 hgmb+82hC3aJWzQHx1VMglScs1zojsUvXuItHkKySRmoVr+oVD1RbpNFG/J1qB+8vB0EYDGvJ
 JJ+Y0u/qEz5WrIFSo3yCXIsmd+o0NmqyWbnwMXovihuMFAfQPGVWrkyYW7ep/Hp7Ys7uMDa1a
 SnpKHsGkh82NZDHKIDHx5BZ0u79IWj/J/fWgoAH6rpnSJJ3cOmqSm0ORGZx3KGfnj9K93K3Pk
 LV7J5dhtWAoQiMMBo9SH6n3vWRmKfGy5qz8d7G1CO4Ssoj8HSuNzB3nNlkBKBoBoTePGq4xea
 BYXQsHlfe4PwWAg2gJuCKNC4kFnKrr9g3FmfPkKWT3bRya90bSSZV5RXhfp+yseHISxwf3FK6
 +rQSVjrZRM2I/fIj5cm5SrQqX7sye1cYEAzHDge6OvS9awXpOEY7RRfouj5ewYdebaKx1nGju
 LdzA8u48OyQ1XbadKimKIWWo18pGzIOnmdScnQ7Lo+wkW6S5bGiFPDZJxulwTGm2Y4TNyU06m
 xPS/6E/qzBB8B3sIMSVvZqrbhZw=
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



Am 26=2E Oktober 2023 07:30:50 MESZ schrieb AKASHI Takahiro <takahiro=2Eak=
ashi@linaro=2Eorg>:
>Now it is clear that the feature actually depends on efi interfaces,
>not "bootefi" command=2E efi_set_bootdev() will automatically be nullifie=
d
>if necessary efi component is disabled=2E
>
>Signed-off-by: AKASHI Takahiro <takahiro=2Eakashi@linaro=2Eorg>
>---
> fs/fs=2Ec | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/fs/fs=2Ec b/fs/fs=2Ec
>index 4cb4310c9cc2=2E=2E70cdb594c4c8 100644
>--- a/fs/fs=2Ec
>+++ b/fs/fs=2Ec
>@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int arg=
c, char *const argv[],
> 		return 1;
> 	}
>=20
>-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
>-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
>-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
>-				len_read);
>+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",

This function should not exist for CONFIG_EFI_LOADER=3Dn=2E There are othe=
r places where the function is invoked=2E Please, review all of them=2E

Best regards

Heinrich


>+			(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
>+			len_read);
>=20
> 	printf("%llu bytes read in %lu ms", len_read, time);
> 	if (time > 0) {
