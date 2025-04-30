Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D2DC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 11:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A218283E;
	Wed, 30 Apr 2025 13:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZxoyApG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D383882B17; Wed, 30 Apr 2025 13:01:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65C28215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 13:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746010852; x=1746615652; i=xypron.glpk@gmx.de;
 bh=YrGe7hVr8rNQhLlr20IxBFG/Abup73q+iDbFTs8kLqk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZxoyApG1E1eJC4pH1V/FwHiGxNCKvK/WS0A9hMGtveMYYVqEDH9LFfB44DZYEz1k
 VyTLqli43WjPDxRE9OjwPQV/8FNsrzeSbEOwOgZZWQAN1UNg9eqKay6EggaX7MewH
 7+TyKnCH4PFSuaA+a21oKUJwsZRl2XbC9V8O0Ibj6meE4AFdoIViseaIeqCWx3iyR
 htJlOmMiUPZg+iOEP5sNYUh9PesPgGibIXtb4L+l0E+iF3nJOG4ZUd6jHj+5ECQXf
 X0s0g1Dn8IXOEcLGekhGXacOUbfmeUICpLatwjGHLk68JkI1BO9F5RRKWoCvdgiME
 TNspeboaUnqILsby7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1uH1CP14wb-007Smg; Wed, 30
 Apr 2025 13:00:52 +0200
Message-ID: <0aba7595-018d-4288-a8d4-a262da9a4580@gmx.de>
Date: Wed, 30 Apr 2025 13:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
 <20250429132756.2105309-2-adriano.cordova@canonical.com>
 <5516429f-074e-4ae6-bd7d-d49f020eae4a@gmx.de>
Content-Language: en-US
In-Reply-To: <5516429f-074e-4ae6-bd7d-d49f020eae4a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T0D5bk/H9DpXRfaxhaip2pIV9TjTfH7CfPCTWLA+N7wMar3hkqD
 jzm/zjFBQfzWiTbRgUvx6+qyeUyctYNY2G2yVvBUdyJKtzCYKxf6OiTn4LDwat2QTvKCkp+
 o8+daoCWv9wokZZxpo8+E8J1l0Cplh4Qv0Y/9jO4TLoKNAXTs3sVTJ0I9dAMjiSOOcQBkZw
 yqtYJdYxJUSDaMlFe9TFg==
UI-OutboundReport: notjunk:1;M01:P0:BGrKCVtfR5E=;gM3Dqwyyfqgpf7PsKHzSva8ZZ9O
 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
 Kh0tteI8BBrqA=
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

On 30.04.25 09:03, Heinrich Schuchardt wrote:
> On 4/29/25 15:27, Adriano Cordova wrote:
>> Do not try to create an initrd device path nor try to register
>> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
>>
>> Handle initrd installation in efi_binary_run_dp with
>> efi_install_initrd, imitating what is done for the fdt.
>>
>> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
>> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
>> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>> Tested-by: Weizhao Ouyang <o451686892@gmail.com>
>=20
> I built and installed U-Boot for the StarFive VisionFive 2 based on=20
> origin/master plus this series.
>=20
> I created a FIT images using the its file listed below.
>=20
> I loaded and tried to run the FIT image:
>=20
> StarFive # load nvme 0:1 $kernel_addr_r initrd.itb
> StarFive # bootm $kernel_addr_r
>=20
> and saw the following failure:
>=20
> ## Transferring control to EFI (at address 00000000) ...
> Card did not respond to voltage select! : -110
> Booting /initrd.itb
> Not a PE-COFF file
> Loading image failed
>=20
> We use the entry point instead of the load address when transferring=20
> control to the EFI sub-system.
>=20
> This bug was introduced by ecc7fdaa9ef1 ("bootm: Add a bootm command for=
=20
> type IH_OS_EFI") and is not related to your patches but we still need to=
=20
> fix it.

Addressed by:
bootm: pass kernel load address not entry point for IH_OS_EFI
https://patchwork.ozlabs.org/project/uboot/patch/20250430105546.327442-1-h=
einrich.schuchardt@canonical.com/

>=20
> Afterwards I tried to boot into Ubuntu and got:
>=20
>  =C2=A0 Loading Linux 6.14.0-13-generic ...
>  =C2=A0 Loading initial ramdisk ...
>  =C2=A0 error: failed to install protocols.
>  =C2=A0 Loading device tree blob...
>=20
>  =C2=A0 Press any key to continue...
>=20
> It seems that U-Boot did not uninstall the LoadFile2 protocol when=20
> discovering that the EFI image was invalid. We should have a look at the=
=20
> error handling.

This issue still has to be resolved.

>=20
> The initrd for my test case can be created with:
>=20
> echo 'hello world' > hello
> echo hello | cpio -o -H newc > initrd
>=20

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

