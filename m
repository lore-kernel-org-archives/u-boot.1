Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC512CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 933278122F;
	Thu,  1 Oct 2026 01:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7x4LmmQDEV_6; Thu,  1 Oct 2026 01:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BAC708122C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816894;
	b=AJWU1hlxN8t0YxTRszRHkeApnO6HfzdkTJN3L6smzkG9bZ2rD03mVk7ftsFCccjWQrz2
	 CHC0XUvHwrEJlieMTI/ha5J73WCds+n/TMuoVJ6+NNxiQNrxN+9znb7Sjo9GWf2crBUj1
	 yqNOD7qOkE/7pmLWGnNjDOt2M8zkdT2xF+Rd1X4bEJmVvEWeo4M/07Iifo05wakuDJv12
	 i1WF8LrRVZoPHkw8/3ZY9KR66/GPkRq3Dh62oJWWfmPcPu7MNY2Fe9TvOQbxcCMvDWZTI
	 nW6FW/CoO734pdk6gJc7b3f5G1DlbQKoyaD8Q92a4b/L7DxJnLV+jjlKMGW2aJIPBIg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790816894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TJ+tJQnKyfQ3lzgDUBlYEBgXoWLM75BmWrUtsX6d060=;
	b=mFEqGftPOV3YODPbBHaFqVAWuvVc8oOyGgezA9AuBgenw6lWzbtecjvgyS4uHMR4PvH6
	 dQXbgtLqdzUVD41mGnDsX4I/ldKeQAIVTHnWyujX9rN/hC3gvuJIlo9BDC2l/kTBIDGQS
	 UL4kgKE9Nt4b0EmPs7HpDxLsz+nmbg2EVE9mV5zPfse+eiQdqXvFsCzruIGeOq5hoJc4x
	 e75exzuYg4mptjcJx9I2dDceo9q3uENok5DgOBWNpid+YkTzuP+EGrIoUH0Eudil3jwid
	 GbAXCw2+x8UODCRo1pD/ko72L+yph0c2j0v0lDD8i6Kw+Iq4db9sflBBOVNg6wH94ug==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790816894;
	bh=TJ+tJQnKyfQ3lzgDUBlYEBgXoWLM75BmWrUtsX6d060=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDK1m2FxN1Y5F1LqQpAHluwZTwly3kGXWAVBEYTF61qSIkE44JAuIIxxLn1Byk/J7
	 2n0neb3AiaS5Mj7cGCxKZVrGjXT/apIzQCvlQhcrE9bwKRu0+PhAXLFRSuWd2DCx1n
	 KqeqZ1FKm7fCHaW2Tkv//4odHOaFZQSKH3Hsn+eW/mBdY8yKIRGHf9FEo7DlqoL6IE
	 hyYP5DjE4B31ayonxTzWajNjm818zgWGQr5f9GTDP1Tdt4bdaa5U0WvquGO3vA6ko0
	 wPwKBfU2AMBZkVzpEXj95ZNX6e1maqg2sp3TfWvv8L9wuhNyLPEF9Fltpc38ZXMaRT
	 h7BkZ/iSDhSdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAC708122C;
	Thu,  1 Oct 2026 01:08:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FC613AC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05FDF40A36
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynJV71JQiVrb for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B234407E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816892;
 b=ciK8mLBuNODezB/hCQZHyzVgdf9pMB0FfquYhStZybBbaG0XPNDuebvOp8jA8T1HSWny
 z0kAxm7G4T+HAaKUol6AqzY1SmMxWfUbhvySSBR6Xrejkhn/g/99GHG8SSXyyfhG8XR43
 5G+Rqk1JOFgGranFGonZfifv8zlLNLlJ9WNt9h4XSBejCF9TY0NZWWrusQj9Gr71dCZsn
 +q8hPihdUAvRoi3ja1jeY/A80PIzPL+iKujvFcWxdxffWTH1tal72MtNpCRt1gH+hu2TJ
 Y2M8tJtRnWRVi24vJUPp9HKWNeiwlF2e5HuqHVTXT2HdoS1Msyjccz2fzETsjIBwV3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790816892;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=TJ+tJQnKyfQ3lzgDUBlYEBgXoWLM75BmWrUtsX6d060=;
 b=TSZJ8wAdxxC7PayD4WAfvdF8O5GnrhBYAxETXvDknGyaAsXRn4ylmEiejK5TVCI9Ppoh
 70UH6snU/ixnjsTKo40/S1rJRXvf8W0nCxjhvNjYPEzxDVnWLu8T8Mn+n3iqMFF8eumOx
 qnE6S1abYhCTt7y+a0duhMipuKOCLtSqyetLvBllpgabqTYkionGp7pWha3pLITH/p7/I
 AGxss07fbBHEal62jVuohqsN/2c4OHBA3K96gFPOqtXvkiA8nwfHJespVs1P5IJVJXg0l
 15uczrcQatXj6FKtBHQXbGALZ8J2p3MHMAbi0ZYO+VufLLwGrs/sa5345PTBG6yYRgw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BPandcxD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BPandcxD
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B234407E9
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:11 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so9105227a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816890; cv=none;
 d=google.com; s=arc-20260327;
 b=qtpueSqWLj5P7zfxAgLVsEGpm9EgthegELJw+Sylko8RZHJQJSU9O8YrIG84PB4Vnj
 KwNcRLDLN0FovKIcvS5qcX81N1HM+wJzdXf5qhVHhQuhI8uKMjMMIJiCfHDqV2smSNS1
 ezuxVDy/cj4b4bmEGFvnxZkWR4GPU7N1JRFtErZYtPuwINHPr3IXguihLyA74Kn2H9em
 MZXq9MCp1kw+uo3eEa8fKck79DI/WQa2lOjWDxjkLrRsxsv6ffGOdfpY9laThbN9w6Hn
 r/gbPBZecRlavSeoml1qp6g2hnOfBfIM8VgtnA2VNSe6Y+PMzQioOXBG02wUJvbeY4eD
 3OKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TJ+tJQnKyfQ3lzgDUBlYEBgXoWLM75BmWrUtsX6d060=;
 fh=0pJlcDN7nAbr358IqbAvw0MQca72H/t8RTx8SSlDopg=;
 b=BtmQ67t96uuIs2sNRM48ZP+ntvSiALUDFG9CY0yPGTu/d65wZI/iGPpMl/misbKLR3
 Z/vk30thSRdqXIKjyYch5pdKRxK/BxQHWt9FEaTgrSYFnzyl6ISyqt/H4Vsas/Q4OrXv
 oTf6pqkeNeoGppoeelrzSJcb2ROoRsX5v9z273rxO4B9dU0f42KyKoNtGiWHPIXudiWl
 D/o4vDIXmxMPYkLgLQWcXubyiJs+SFMLe1GG/Se2i+qoNZYWkbamipWiuoFYYTLxA0eq
 1TRrG+pX2XK+1vzJhdU2HRprta6Ohk4ZJNhD7wiYiE3FJJ6+XpTVTndIeaZhEyGszIrg
 xu4Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790816890; x=1791421690;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TJ+tJQnKyfQ3lzgDUBlYEBgXoWLM75BmWrUtsX6d060=;
 b=BPandcxDpK6N59flnp2YJD7eLgTX6zqtyp16tRb3IjfYjsoi+g56ed85yDhx8I+B6p
 7DoTHAoW26xmmINXZVM6pF1YEKkfQrOwfnuFhqkIzjbds5gVj1aA+oUppk4wRwKqOHac
 FXMIDTrF/PmYuR86Umlnm9mvI4MFbqRxZ5Uj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790816890; x=1791421690;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJ+tJQnKyfQ3lzgDUBlYEBgXoWLM75BmWrUtsX6d060=;
 b=qsSyfCbV4D8JRfZ40xQ+9kbwspU23gcaPbwPi7IgaiHeCqbUny3WysoUeGsjYba9ma
 x3QpksdFBS8xjitvNm5Iqr2nMf+qfoY8bSSVz+W5xaWdMzPbMboXbBR+rTf5IvzaekpL
 3UQlCnYmEr6dp2qYpC9fMjPdeDYaYlKAZlDa/baxdOYxAboZ14IWoiN5ozvYZLx8Wkf1
 rYJqa8CQnp4PuFRTLYuXbUQgMJDiNfI17UgKiAd110XBvoSdLAgFbQKHJmq7zWMf0lPC
 iIuSZs3NMWf0v3p0nQAMuBGYICbjHkvDjdk96m6RlzcrvGOlb3KECQOaqJVmNFqhotlo
 nQ0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe9RsMbBxj0+yKgvtUzV4rH+Ilc3ADil+B4jkVVmhddAYurPeJ1OEBIdkJr7x75XZNv3aw7vM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKPKyopGp6U2SLbTFBNhEniyLnFSVCKO/CVb/yVBpOmJzNPzCRz
 /7nqGaJuc2OTnRPKVGKPmf0nQosgGLOQClpmTrbJ4xFcEk6epVQ3Le5lixftPr05srJUAJnOnwO
 dPWNQlCpDLX3YqmIkIl/swbdXUK895pEq0Bj1iQUa
X-Gm-Gg: AYBFou17FjhGAPXeRlkJvFkWDjmIGnmtB2n7qkp9F46NA8oXNHnOdcSAImJaNu3xCgs
 Dpd60v0N1WC0NoRiKqGXOFDdgg27YTVCvGtQnoo2G6Bk+U70Vc9219LWbm8sp3Xt9Zv0QhKl1tT
 4EaMs6ktyjpYd+9fdpUCEaQ2oo2l1tqShgeNEqEDBLGJMB0f3NPXMM/sk1JYcER6sh34yTeXZJA
 mB+RsWxOsjqHPjAjHrF8GcgsBohfQrNZs05NVnF4JD0Wyy4f2kXLBAoqBAQr26yqSoOAR7lHKQn
 Ms9fch+As6YjSFifRyNfpifnDTJVeqkypn4KsWwagpV1oCjLzvnaokPaUWRUdIqzMXc=
X-Received: by 2002:a05:6402:52cf:b0:6ac:c4fd:c726 with SMTP id
 4fb4d7f45d1cf-6ae1995216dmr2386408a12.42.1790816889784; Wed, 30 Sep 2026
 18:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
 <20260930-imx93-secureboot-v4-6-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-6-f968a1b14dc5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:07:53 +0100
X-Gm-Features: AclHuK-f2yZ50fNivvbYVY6UF3tLbrs1gymBzqEyFreFvAgRdy2mHe6_phXCIUc
Message-ID: <CAFLszThkaoSY4Xao=wYEb2gRzLeVU8bbCy9RB3BQaw4ODKARDw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] doc: imx: ahab: add i.MX93 secure boot guide
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lei Xu <lei.xu@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-09-30T13:42:33, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> doc: imx: ahab: add i.MX93 secure boot guide
>
> Add a step-by-step guide describing how to securely boot an i.MX93
> image using AHAB.
>
> This guide is largely based on the following documents:
>   - doc/imx/ahab/guides/mx8ulp_9x_secure_boot.txt, from uboot-imx
>   (lf_v2026.04), originally written by Utkarsh Gupta
>   - doc/imx/habv4/guides/mx8m_spl_secure_boot.txt, from this tree,
>   originally written by Marek Vasut
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> doc/imx/ahab/guides/mx93_secure_boot.rst | 297 ++++++++++++++++++++++++++=
+++++
>  doc/imx/ahab/introduction_ahab.rst       |   3 +-
>  doc/imx/index.rst                        |   1 +
>  3 files changed, 300 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
