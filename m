Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79446C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CA782CFA;
	Wed, 25 Jun 2025 16:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NOAxRFUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF5182D21; Wed, 25 Jun 2025 16:18:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F562803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750861109; x=1751465909; i=xypron.glpk@gmx.de;
 bh=/YS87+SIzCVEn5BJaQDNwAgbOPYwY6Y1tVVnYcRX80s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NOAxRFUgcefzVlQc0m6Yd7Vz73uyOmpOvXOb2uuv73rhbHPHUNJR2BkaRGZ2N45t
 uGKAIK1dpZP8o+KhvNCk+Edhis1eQX5tDmJT7UcMkpL2VlLu9cj8hd8nclDBWHnmQ
 EFGnl8/uy7fKFFZDPMybYzQwDcAoY0nv2By7gXeeAPXvXUQ0tJAj3KlXTKuHI/jc9
 iq5ahsSEXaIGrGrUVyFOKyghYe7ASb6hGYB+JS/wAtpFKCJBaFGvZv2n6fK+FB4Rv
 7LYrWALMPxZP7yVMBbTvFKxKPy8kfl+mcF3mZt+8x4irn7fRcMpXpW+Cet50k7ftz
 NxhEVvYaNikMNeCziA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1uLjnB0QWu-00TRjE; Wed, 25
 Jun 2025 16:18:29 +0200
Message-ID: <012ee7c9-6794-485e-8e0a-5ed0ff23c045@gmx.de>
Date: Wed, 25 Jun 2025 16:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: efi_loader: Sporadic build failure: Error: file not found:
 <path>/capsule_esl_file
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>
References: <BN0PR08MB6951841AE35F95A242553D91837BA@BN0PR08MB6951.namprd08.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <BN0PR08MB6951841AE35F95A242553D91837BA@BN0PR08MB6951.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CnLixl7bsuFKxdAWYXbbAtHGsShQJLSoMZwpiPfiSzcumQjKEAo
 ZMgNzCFzNipdYINge1h2wsdlcKCJcY+NVaIMmBm/UyjPKzpuKLLs+g+U91rpYQuEmPLWI2P
 a4Djh/HXlFzae3Fk1FP2yYyD2mQL70hFjd0AWgnH+MbhlDF4DH8q5fiUOv5J0X+CDJXrwNl
 WOm+GkYubbUuhHjRhsc2w==
UI-OutboundReport: notjunk:1;M01:P0:YhdLpLUJVXU=;wixRRyWYiM73rDSwW71+bX9BjRD
 +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
 Ag==
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

On 25.06.25 15:32, Anthony Pighin (Nokia) wrote:
> Following the introduction of commit fd58c275f6ba524101ba0990e53f5a11ac3=
90bd0,
> we have seen sporadic build failures with the following footprint:
>=20
> <path>/u-boot/2025.04/git/lib/efi_loader/efi_capsule_key.S:14:
> Error: file not found: <path>/u-boot/2025.04/git/capsule_esl_file
>=20
> Upstream commit 739ad58dbee874a3ad3bddd116e995212a254e07 also touched th=
is area,
> and we pulled it back into our build as a test. However, it still appear=
s there is a missing
> dependency:
>=20
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -87,7 +87,7 @@ $(objtree)/capsule_esl_file: FORCE
>          fi
>          $(call cmd,capsule_esl_gen)
>=20
> -$(obj)/efi_capsule.o: $(objtree)/capsule_esl_file FORCE
> +$(obj)/efi_capsule.o $(obj)/efi_capsule_key.o: $(srctree)/capsule_esl_f=
ile FORCE
>   asflags-y +=3D -DCAPSULE_ESL_PATH=3D\"$(objtree)/capsule_esl_file\"
>   endif
>=20
> Anthony

Hello Anthony,

Could you, please, provide logs showing the error and the matching=20
defconfig.

Best regards

Heinrich
