Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD22C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2454605E5;
	Thu, 27 Aug 2026 12:49:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPsEGU4XhGcN; Thu, 27 Aug 2026 12:49:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787834952;
	bh=g2jB5sCWAp4KH8ea+GZGAGZsefSKituXktIhjbGQjeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emAcWdK+E7BuehKF41EL0D93b2kfRr+RWmN0ON3XjpyrSzV9rDLplktvyNFLF3Ip4
	 NuU1oAZhSizt0PDKVGFqDbxSkSpqAkvytgVcqkcesjASRB8kkLUT2jw+RA9nAv8eP1
	 /FDYea4caisOu6brM7MQbcmKWko95y5UOeVvyOK3UR6nqLCrFi2fC7ciVIEYO1LLYu
	 SDf2jh/tsLLPoItCP8GFMcPhPifO14nkodA/iLEDSQ8Sea7CZHdaYFKXk6LWuSWTpf
	 b30JilQyVQGYQVog/FHnCXVGestHgMn4QFOR53Z5wk+lqwb3aDI+tSHTpDjs88L5T4
	 h/wwz2dYKvzEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4378560643;
	Thu, 27 Aug 2026 12:49:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0F4F1DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2AA480DF6
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PX1t3-7MCRLx for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:49:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=YvOifzlg
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74CA880DCF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787834945; x=1788439745; i=xypron.glpk@gmx.de;
 bh=g2jB5sCWAp4KH8ea+GZGAGZsefSKituXktIhjbGQjeo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YvOifzlgqIt1khC0cgubsxXgaX/oFsAVSsi88fqolPefqwZEzCFxB2s8DsD3gt3m
 GGtAMkZkFTJAjK5G10PQzrqwC2SCnH31d/dAtv/UeehRSx+8vqD4RGPh5kgZ4/OXI
 KMvJeWrALiscc7VTsdiOd5eslBhK/dk6DYSB5uFPgDffb9r2FJpIN60d5Tpc3W0UJ
 M8tPXua/3g2TuXnSzWLJ9m008vpG5k73gueUNq4DjgqKO6QauI0SjhvKOylSC5PW9
 it1GJQ2amHgO7C4Fo9Gstkk8BweeEdGIkAk04ZJoedMNqUlE56QtzQtWGN8vu/Cjy
 XAip0v271RtPDGaggA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1wXcKJ2l4M-00i30s; Thu, 27
 Aug 2026 14:49:05 +0200
Message-ID: <e3cdb9ae-9505-4d77-abdb-b08b1dce452a@gmx.de>
Date: Thu, 27 Aug 2026 14:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates()
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oRoWpDje85MxYzvxtmXjUBiCp3+ifaNglTDyhwcJit+iWANaeOv
 23FYuFdx2qgaY0lROT/LXR0uv6CqwxDtRKu1yUQgPUD7nkktHuFlLUVzfV9ddzQWJyKDxvA
 7ifyY4HkGHKU6z0NHSIX9ZmDQ5FEVGuz/mjXFSfKr1ZLmN5MR+rhbDq9PzJyZjx6keUhhen
 kLBSY//TyOsV2F35q2qLA==
UI-OutboundReport: notjunk:1;M01:P0:fnE1q4ycsnI=;UywMZrFn0FQd1L/SuDcx2GZFiZl
 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
 wWwie65AG2E=
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

On 8/27/26 14:36, Markus Schneider-Pargmann (TI) wrote:
> clk_set_default_parents() already ignores -ENOSYS from clk_set_parent().
> Do the same for clk_set_default_rates() and rely on the earlier setup
> clock rates.
>=20
> On am437x the cpsw switch has assigned-clock-rates for the RGMII clock.
> The divider delegates to a multiplier of the DPLL that has no set_rate
> and no delegation, so it returns -ENOSYS.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>   drivers/clk/clk-uclass.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index c33f415917e9..0069ce9a8875 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -359,6 +359,15 @@ static int clk_set_default_rates(struct udevice *de=
v,
>  =20
>   		ret =3D clk_set_rate(c, rates[index]);
>  =20
> +		/*
> +		 * Not all drivers/clocks support setting the rate (as of now).
> +		 * Ignore that and keep the rate set by an earlier boot stage.
> +		 */
> +		if (ret =3D=3D -ENOSYS) {

In include struct clk_ops is incompletely documented.

It is undefined which error code might indicate what.
This might be handled differently in different drivers.

E.g. zynq_clk_set_rate() returns ENXIO if there is no set rate=20
functionality.

Please, complete the description of struct clk_ops, check what all clock=
=20
drivers do, and harmonize the return codes before adding this change.

The struct clk_ops documentation should explicitly mention how error=20
codes are handled by the uclass.

Best regards

Heinrich

> +			ret =3D 0;
> +			continue;
> +		}
> +
>   		if (IS_ERR_VALUE(ret)) {
>   			dev_warn(dev,
>   				 "failed to set rate on clock index %d (%ld) (error =3D %d)\n",
>=20
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rate=
s-enosys-1359deb9d80b
>=20
> Best regards,
> --
> Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>=20

