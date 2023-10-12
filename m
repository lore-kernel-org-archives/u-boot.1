Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB2FCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1881A86C9E;
	Thu, 12 Oct 2023 08:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F7RqD5Cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD89E86B7A; Thu, 12 Oct 2023 08:28:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617B886B7A
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697092077; x=1697696877; i=xypron.glpk@gmx.de;
 bh=KwwOGtAnd0hfgu4fS+Gtoq8kalqBbj3CZk+Xk3dr+Mg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=F7RqD5CyvFv53gabmCJmIvIqn1Nc7Nu7Bweze7Jxdx23CSrR29EOJmYw0daUfGWqC87CkmtKqgd
 b142edKf/H62N2jEvWngVVkY6Wh+yXQkDV/0wWNs8MCQhFZmQMgZ6jw752cTr18RL2uidxVuFvqvN
 kytWCPuFEa51esbYG7jOAtGVtLKfMrLIBK+deYCC37hBOtsTkDHU/RptXcoUcewbaTfAUYjzBH3g8
 A1ul7XEV5yQ61AYQ+VQnYOQ/eM05aw/dTZ0QtVmMrVgDUiF4nto3afkSz+Esx5rPWAxlffwdOR5J+
 n8NTzZ7ZlntSx39DbJhM3mElmycm9G0SHIBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdefJ-1rPblE1FcP-00Zgod; Thu, 12
 Oct 2023 08:27:57 +0200
Message-ID: <227b7449-8327-4748-9bf6-10d6b8dc1435@gmx.de>
Date: Thu, 12 Oct 2023 08:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: use well-known guid for auto-created boot
 option
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231012053200.2337061-1-masahisa.kojima@linaro.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012053200.2337061-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zgu7viYpHzQ7GescgPg2TJ+jKRwAeA7lpKBv3nJtBVCI3Wf632Q
 w1WI+C8onmhZZ7/U375c+SqYXBm8P+HXE3NEQBXfoJYr000CPL6sXcQ13rU1j7DvmW0bs3p
 L8p319n5C70W3fkQ+FSKLwXB5esezMrtKWJuJi4xhinwcQ13jP18fBqufsla+gzvsmJTIxC
 FJZP5cowvahGZVNPF2C3A==
UI-OutboundReport: notjunk:1;M01:P0:K0u7GEc2TyE=;J4h4eRDhn4zAf8lDzLtCsjvWf11
 X1ABNmTnaAXef11DYNtXIa/D0M533RPd31DV0C2cV8KcqYb22bzpOp4AdeRdjSDCXj/YoKdr3
 TV8phUmIlrGFIsxenyF3SztJ3FeRJ6tdqWzvSYWea+X7//Gn4QzBogpuVUKJG8ixolQYM0dQ0
 JVsrp4NJEvshLICT/1OspuEuRiADcLIEocByMM4kEfhzisTs4tjgkdKbtO6+7sGn//T38QY4T
 UUMHMsfWBXMeUolBnEMC+wDDdSLM4zAeoxrANGMOg8DWezZKfe8uXPb0qOpey5LoT7qis43NH
 jKsGMKCgBbgVPbr/996awzQHW/DuKJ60Ur6iJg/acCt0NviwV0GQvRXaI+DjZn5uNL6AS4x5H
 iUrSSCrHolCRtCN7NmGLtmn5fb5SMxMFiRuFzk5sTTFOrGXHOS3FD2mjsVytYw2YMY/I/ozFw
 5ftwFOzS6Q8myoDhA2Dsez5qDQk3OTIdFwKyXA89lX/wQ5OVxGP01wl57YdJbcX/4Rp2uyU8q
 wvWlsah7ToADOEQj/jokGG1kYlB/U8dX0NVt9D8Owi/1zqBdQV5Jkssb60KZnP2ouoxUAJu/H
 xrEfnAwQTGEGkSkebF9gwmzO8XdqiAG2Vm9IbyTndNXcdgkWPqCoLbTE2uALUGrRfxeDXlIer
 nhEQtCP36tSGyMmpACZgdE9vhBPeMLi12VdBHRf+vWCEN8yJEZZRn1Fd8ZSIZ9Rum7El8ey84
 TOd/Zowt3YbwNE7IbVSQZ+rFx5X4vLNXljAMZX+Uo/rzvLk4hZJ/uMNIslE9J59jevj6/q5R2
 nQMO0XsoeT2UdxW+vwyU2kRvXVCTFzb4VJ01qKmvJnuhqVP0pO8EFRlzs9WNoHkRT04S5g+vV
 Vp/uqMPENsuDdXtSfs1tGdJMgL4rhQmH8XPhX2lXprDb/gaTa2DH3mMFblTrwxjWbtC8DWLny
 anAIXv3juztVDUY+ZT4wYoTfd90=
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

On 10/12/23 07:31, Masahisa Kojima wrote:
> The boot option automatically created by efibootmgr is identified
> by the special guid appended in the optional data of boot option.
> The same mechanism is implemented in the EDK II reference
> implementation, it uses the different guid from the one currently
> U-Boot uses.
> The guid indicating auto-created boot option is not defined in the
> UEFI specification, but some userspace tools such as 'efivar' package
> are aware of the guid used in EDK II as auto-created boot option.
>
> So let's use the same guid as EDK II reference implementation.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/efi_loader.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index c4207edc91..106006127b 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -149,8 +149,8 @@ static inline efi_status_t efi_launch_capsules(void)
>
>   /* GUID for the auto generated boot menu entry */
>   #define EFICONFIG_AUTO_GENERATED_ENTRY_GUID \
> -	EFI_GUID(0x38c1acc1, 0x9fc0, 0x41f0, \
> -		 0xb9, 0x01, 0xfa, 0x74, 0xd6, 0xd6, 0xe4, 0xde)
> +	EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
> +		 0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
>
>   /* Use internal device tree when starting UEFI application */
>   #define EFI_FDT_USE_INTERNAL NULL

