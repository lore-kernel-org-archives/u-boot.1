Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02C8C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 21:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6658081E25;
	Thu,  5 Jun 2025 23:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="gGTJaoMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B00F81F0D; Thu,  5 Jun 2025 23:52:54 +0200 (CEST)
Received: from sonic312-20.consmr.mail.sg3.yahoo.com
 (sonic312-20.consmr.mail.sg3.yahoo.com [106.10.244.210])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7127D8091A
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 23:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjvazha@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1749160368; bh=pMGMZBRYqNHKaWbPLd2bIMvhTNCSS5WBWpUWLECXIbk=;
 h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=gGTJaoMryBAjK40hBbWl+Qb08PSjP+QILZz9b46J/aXit5acTmzsY8CN//4GpJk6sNyBCZfng9y3TtlqL+H33uFopljHvFwSm99SbAUho/qqGkdcCoIlYtS2BmTMBgl4EYGBYq6kL69C2sdcV9LynwFO6mOhdi6AwBWK0svE5ZELRjc1pq+ijnKMqrsitiLGw5CgUoRngrKn8c0wwe45Lh6saMWFR2jmhHxp96VryCwvcrat76r8b9yhGGE5nDjhRj31YfP/k7ryI69oSWUQq6SPcFU6xOjUVRJF50cuvuhqohtX68YYGu9kuuvkA5Q8IZFuEpOZvpVGHzxX2CLgDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1749160368; bh=PM/fJubDErg+iAwEpT3VPMI0Vonx95VV0UHLKROEj8j=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=uF+idfUEJA8KJRENVlLcS+hrZv+9KXrGxJeNzAvApVTCjkEdP7CREip5Ge3ay31PCeeFMQOXlxGQX3wfyYDpWpypT14bdBVbqO1ipb2jpZ0yb3aRZ4xrYCpyWMaXycAVxulIkeu0rbWd6YWzw3UfpWzqtan1LTOrGUywrWHutKKYOCsMoPewtdZur3NfVtT3L8WrEjuHhslfFjwDxHjMCCbME8TQUf73vUj1apYi/WzCGviobSfMRJOabE+VIVAWGtyhXoTx0quA73Pa761hwH1KYFrn0PZn5e9U9ZHhvXqwJ67FB3SmNy/OpiTMuDVy2L9lb283Lq4NWVi2fdiVmg==
X-YMail-OSG: KnxEVTwVM1luOP60DtpOTTPTLaBJdigEJdWS74J3upHOZRdACbK1LREQ1C41W3Q
 U6JJ9tFW8hixGRuHDaqyb_tc8y3i59hibFQxsks7_d7hR0ZcLshS1U8BfCjadNXSv4k7vRf2ZDqO
 dxpbTRc9_hO7mDu9mHHa377ovUF5hFb060u34dTgxLMoUFOxZun4jiuCvVHRBbYMoPIgRtOCTO9L
 KdZsZqsAAdQEXIg4GeDkq3VCa1pGAws_Xdlufw6XhI0PtY4CZMx8OFkV.9hxzBpl5mn._i1wILfF
 InQIt9fUQtIC7g_5suRYBdw0gaIM6a7JisVPsigDWRK6WhBycZRioYzHd6xZBGTjzMIZfordc9wj
 H9Fjz.N1Gt6byeruh97QTFGihAOC2rt16LsijBjtqukfeXiHz.kzsI1_pXaZVj8SfVI0lxSkB3L4
 U9.M3kjuu.7TD2M4MXKj99gSrSi9jHA4YJeC18jYMlNTSi1C_uLbLqbelpqJQIF7DzPKGNJ6Y8qB
 NuIikgdYS6eLYs1vBY.gfcLi2AWUfqIAyLpLI1phoS_xauwTA0riM99.Xnk4SHk2OK4Yz0OwImsR
 DdzNGaHoPZJB63RNGSOI1n3wIVR3e4763vqh_zKb0f2Hb9g.6q01YdwHL552iQ_GBkSpmf.V8SQM
 G1LxWf7uHyT_ggaRByyaY1QBUAnVoESMNCoi0ee3.JxxTNexGaUUClEZxCz_KjDRKxn2vRB8hn9n
 hS1fhHJ8NkPcWXfVaAC5JHqASkKHirXwbRWk2d4nN6K4Mf_fl7jny0rttozMUqD3sOAxQ3151Tl8
 TKAr_KbLtRlOBGyQoJhpBYyu6CndByy9h1pv3ZR_.2AFc8aG17g.T8pp1gmI4kfUOXohq5m62rMU
 fOYPPXKqGgfF9ah1wq2kAuKQzYo_UrCt45cuGO17aS9DPgpoKz27svlpJud7buh7z.67BAbErvd4
 hU9g8lXZ_yWSxVKzeqdY_DjeeaecbfCHi26M07ajJJ6rSkl2qQ6GLsAoMbWz2V7INI0rE7ZYao2f
 Mc._AUUjQ.yc5ZpRDwHXamoroV7K1IqDYf77Ax.lr_ZgSUL0gHVJgA3ypeaK0_Q.i.8vO_RJAbjW
 JZTExxctsq36.uRgfmFGY2eCjQq8UNsIQsF_tSsLFQL5kcWZPqQrITvSKdVr6fbKDr3ZRZr1F8Bp
 hUUS0kOhcpPH44RLDtOZ8yF873KKbSkuqgVQqmbc6MymUmZiPCUPXJzk1enlcQduoqtt9jiYqcJo
 UD1E5XQ7CCt41Le1Y7xotmXS9JliPfyerEyoIdGXC9NWNq_Vac9EBW.IRwge1tvSHAe9_Ldhvmiy
 iaHQh_WEUyZ_MstZ5Pr8YwKM37rpc2aVrZettA4bfikjZykQT8378FNih1ZNnwSE.zNznk3YavbI
 zICAAiFEl37z9wv96gY0XpMnHdy7gq2JZqCGB8XuhcpIS0XM7LEgRFo.r34kmtoBIfmyFc8oBMgI
 cp4kxTcQupNBOZc6WuyACMTqrDitfwNYm3H90rsmbFJBtd4VnWvZnyYbGvKS3gZJcs9lq4_8LS5R
 IysDvCrw79wnA8.aZ_aZ9eeh3GsPcfkgvzYHWR8vdWP474sQzelWPsBqhK3.n7Th2r7BT8JyJjLg
 klAq.K4Z9ZVkgJK1OUXc2A6FVEI4N2MwdvAvffxfN_gZY2xO9xk_7bcJ4ccaJ5RvvSAKB40lU4zG
 lrK6tsL2dz5Ln.gLBUiRDUTBuVhgIscpl2ycRy.ckVnzkiZEWiLu_o0onDbBd.RWwMJPhyni0R7X
 3qqAg1zl8.f4UwpryBoD8KgRIUAlvVYmLC0Ekm9QRMY0OhX7eH2f6doqobDTboB3dWYQZYrlsBGm
 NiYWV.MZ0hqQ6n5zI0qjXR5qaL9xB3EfwH7rOZnTEjlnzV5iJFPoLigSDHQhddHpoLotyFDtTHy.
 QkVxkVEVu3CpW9c4b6OpvYN6wBB2_atSOGJXiH3nVZ0t.IKcomNiD_SjQJ97cgexQ22r1DXMFoc2
 kAdvqwP6B5g6DKf_w6NuDbyrn9k08fVg9_Xs2m6xAb2C33fg_GIPTbuu6ha_QXJgd.KQd3qk1qgk
 mKaT7xAOygsy9FnsQ0DpbqKYJDfToOP5Dd7vsAbeWo2_qfm2TThUE2tbM4M9kNWidGgLscwwp33C
 yrRliXY02yqbdTXKL5nXPEPjH1.80fVDKO2khDxWaXkehkhjFv7nnMddNKYpvXIVpnG_MtCRfKsb
 YEOl.gs0Tw.6vXLLzSgs6MuJHT66REzpSIIOa_d22mbNTmiGSALf1H6G.nU5fb563q74YObGnkTg
 -
X-Sonic-MF: <jjvazha@yahoo.com>
X-Sonic-ID: 654e3dfb-9349-4a8a-ba7e-a0fae2909170
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.sg3.yahoo.com with HTTP; Thu, 5 Jun 2025 21:52:48 +0000
Date: Thu, 5 Jun 2025 21:52:47 +0000 (UTC)
From: Jojan <jjvazha@yahoo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Jonas Kvinge <jonaski@opensuse.org>
Message-ID: <851157797.299472.1749160367219@mail.yahoo.com>
In-Reply-To: <294e9037fe8b9502b41a06e9ac9363f2d5204b07.camel@opensuse.org>
References: <294e9037fe8b9502b41a06e9ac9363f2d5204b07.camel@opensuse.org>
Subject: Re: Raspberry Pi Compute Module 5 support
MIME-Version: 1.0
X-Mailer: WebService/1.1.23956 YMailNorrin
Content-Type: text/plain; charset=UTF-8
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

You need to take raspberry=C2=A0 ( custodian version)

Making sure you're not a bot!

|=20
|=20
|  |=20
Making sure you're not a bot!


 |

 |

 |

=C2=A0But it is still missing the device tree fro bcm7712 ( RPI 5 is bcm771=
2)But you can Dow load the dtb file from the pre built dtb file from raspbe=
rry pi images
and=C2=A0 use those=C2=A0 device tree sources ( using a dtc )


    On Thursday, June 5, 2025 at 02:13:24 PM PDT, Jonas Kvinge <jonaski@ope=
nsuse.org> wrote: =20
=20
 Hi,
I'm trying to boot openSUSE Linux on an CM5 using a sourcekit io board
(https://sourcekit.cc/#/).
u-boot seem to be stuck with the logo on the upper right corner, no
text.
I re-built u-boot using the latest source from git from the next branch
and also set CONFIG_LOG in make menuconfig, but still no text.

Is the CM5 supported by u-boot?

Jonas
 =20
