Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6297C3ABC5
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 10:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E35B8091A;
	Sun, 11 May 2025 12:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ASdUuLwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F4780ADF; Sun, 11 May 2025 12:52:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6977F8070C
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 12:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746960725; x=1747565525; i=xypron.glpk@gmx.de;
 bh=w4tbYZa7HkRzbEmlHgd2LBrxWxnlxCHnTY1RBdQpvbw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ASdUuLwcOpO1qtNL93NMJHZ2KcLtjTP5AOHWgSJnT0Y0qnl5+0hgZZ1d0oMDDGle
 uw2vaFY6OdsmYTjjKncAg9ZI4WL697vrcH5LXLfvTiaZ/BjRO2mY2/bbrxIcucCJg
 mi8Y3HOeN3+gcf1CxpiK7wyXgSNF53QDN5WdJj2AVs7WPFEGoTNhvCt9G6hpOFjYc
 Q9qWDBC3bq+LHV9eSiPa5Dp+MbmKphHiIsK7FSGib1s/cnFyLEPwjx9d7hxvZtJds
 L/L9hasKqRCTOH9G5IbVIXxVbqml7fDnmJEQDz1+N8FCmiNvpEgc3sEAlWFCuaIYT
 B+hxP+I4g6jigZwAIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.72.50.244] ([185.109.152.96]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1vAJjl2dLo-00zPR2; Sun, 11
 May 2025 12:52:05 +0200
Message-ID: <90eb6297-8b7f-4549-9bb2-5182f7e904c6@gmx.de>
Date: Sun, 11 May 2025 12:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] scripts/Makefile.lib: add PLATFORM_LIBS to efi
 linking
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250508183034.3439777-1-adriano.cordova@canonical.com>
 <20250508183034.3439777-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250508183034.3439777-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JdoHKC6Ymyg1uNhqu3o+azf9u+oX8bU2hrQOkevN2ME/eek56pn
 AjF5Un6oi0eYzKkVnprHUAu2DZxnRvXxnzoksXfbTGseyYAhKyrDJAxH02lumm36iR0rz0l
 kymttj7VFuscVouz+GF9X8DsAmmdK/M2kxAG76WfFgNcS/vFol/etGTxz0wKrRTqnMK8bBb
 8iUSPLvBeb0ZqzFMf1s/w==
UI-OutboundReport: notjunk:1;M01:P0:X/ejfEwL4VM=;w5O2OE7v9gJsU0ehPtC0grJNxs4
 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
 aLjexrOfYDhz+jm0k7xM5xFAMsGIRFGgZM
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

On 5/8/25 20:30, Adriano Cordova wrote:
> Link .efi applications using libgcc
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>=20
> changes in v2:
>      - Address the root of the problem. In v1 I was modifying
>        printx in initrddump.efi not to generate __lshrdi3 instructions,
>        but a better fix is to provide those instructions with libgcc
>=20
>   scripts/Makefile.lib | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 83fd5ff6c31..3a86cf375c3 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -497,7 +497,7 @@ KBUILD_EFILDFLAGS =3D -nostdlib -zexecstack -znocomb=
reloc -znorelro
>   KBUILD_EFILDFLAGS +=3D $(call ld-option,--no-warn-rwx-segments)
>   quiet_cmd_efi_ld =3D LD      $@
>   cmd_efi_ld =3D $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_P=
ATH) \
> -		-shared -Bsymbolic -s $^ -o $@
> +		-shared -Bsymbolic -s $^ $(PLATFORM_LIBS) -o $@
>  =20
>   EFI_LDS_PATH =3D arch/$(ARCH)/lib/$(EFI_LDS)
>  =20

Building with this series fails:

    sandbox:  +   sandbox_noinst
+ld.bfd: cannot find -lrt: No such file or directory
+ld.bfd: cannot find -lSDL2: No such file or directory
+make[3]: *** [scripts/Makefile.lib:512:=20
lib/efi_loader/helloworld_efi.so] Error 1
+make[2]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
+make[1]: *** [Makefile:1919: lib] Error 2
+make: *** [Makefile:177: sub-make] Error 2

     0    0    1 /1              sandbox_noinst

See https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/1131665/raw

Best regards

Heinrich
