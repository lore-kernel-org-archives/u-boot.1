Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E6AC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6093980C68;
	Tue, 25 Aug 2026 22:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N2vxzb9_Mlke; Tue, 25 Aug 2026 22:01:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787695309;
	bh=kZazmfmJ0VfO7mlyrum4Y8jGIHLq11BJVYDrkiKyVY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uin00Z0HNWW7t/k4l72unuq+kHMytVukbKs6aDKlARSXytZtf152BZ9iH6gvc4Wn/
	 dAQep2TtUxieeq1gUEAxqfyzO7LgXLHj2t0MFpcseitfhAh+OqbzQIjfFDEe5gtk9t
	 +hbx18R1HpojYf5xMSN0EfNl1tcyQjxlLX9uXxiiH4EKL3+bXW/xoPytn/0Gv2HhEf
	 H3RUb4Zd+S1sC+ByGbxsX2Ypm1kQpkt3nP969zW9jtkYkybrXxyuq0Hbbu4Q/9aag4
	 +HX8g/v4zOvNl6Clfy4zqUaa/vKKDY806x8awFAJJ41ut7WESSqqfmtmLhj91v0WqG
	 QwRMp6bZAyo9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 834D980C73;
	Tue, 25 Aug 2026 22:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61BE53C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 538AF80C73
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvBVVmwmGhxQ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:01:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=gqiH0Kzd
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C61E680C68
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787695300; x=1788300100; i=xypron.glpk@gmx.de;
 bh=kZazmfmJ0VfO7mlyrum4Y8jGIHLq11BJVYDrkiKyVY8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gqiH0KzdusmZkQZAXaiejwX8qHszGNQYtMRoTQKkhZXpngCXYok5Iq+n6fSa0jpK
 fQCD93LC+6tY2Qeye+i2c93DBoZ31h5HUp/eVCfafpdrwntTRtqJv5puLLbgQHD3z
 u8aDLIk1gQSwwXFh6/Q4XDKAVKav2WlAlmXD/vBQk9ESz1NCDLn/pMbaRuM1lXZUk
 XtgCUSTouczdJS6K8b11S1/sDsyyf/XCFU1KqQaJ7m9LhAa1CmOv/lACNpIz+9LvZ
 rPxslFUv148LOKKOvhGsBkB8QkpdQMCAkqjgjcTUDiXkZXyhg45Apr1R+C8zXFnV4
 XRCKl3pp7p7CHqRerg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1wzXBN2hEU-00C1Ro; Wed, 26
 Aug 2026 00:01:39 +0200
Message-ID: <3c07d839-7031-4927-94f4-b0323f1fec83@gmx.de>
Date: Wed, 26 Aug 2026 00:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 11/45] doc: develop: uefi: update link to ipxe git
 repo
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8+dPqWHfl6BVkWpRfLGjRbnb3kkB6XQwiFo+GOM0Zs/EolMOyO9
 kNWfmmBiUQQTQI67fiakU8tUgkEmM4hcUnEwTug3SVfFIuU2gTDvzTF0CxmKfUqNaL9ccxN
 pREkN2E79RlshLkiyO86afpYOwHfqgpwXI3awg4MCeBEzG+HSjQa5ZFhadgaLc8I2ar08sz
 Zm6L1+KHq+w9sjbEjVSbw==
UI-OutboundReport: notjunk:1;M01:P0:ru+WwrmDGr0=;Py39CosLAIVww24HbK26pRaKdzg
 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
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

On 8/25/26 18:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> http://git.ipxe.org/ipxe.git redirects to https://github.com/ipxe/ipxe
> so let's use the proper link without a redirect in-between.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/develop/uefi/iscsi.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst
> index 51d38cde2438..52fa79f35620 100644
> --- a/doc/develop/uefi/iscsi.rst
> +++ b/doc/develop/uefi/iscsi.rst
> @@ -125,7 +125,7 @@ iPXE
>  =20
>   For running iPXE on arm64 the bin-arm64-efi/snp.efi build target is ne=
eded::
>  =20
> -    git clone http://git.ipxe.org/ipxe.git
> +    git clone https://github.com/ipxe/ipxe

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>       cd ipxe/src
>       make bin-arm64-efi/snp.efi -j6 EMBED=3Dmyscript.ipxe
>  =20
>=20

