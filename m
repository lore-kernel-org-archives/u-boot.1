Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC4F3380D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81BB7840CC;
	Tue, 17 Mar 2026 08:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Pu92FK2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F75840CC; Tue, 17 Mar 2026 08:42:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13351840B5
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773733360; x=1774338160; i=xypron.glpk@gmx.de;
 bh=6wxok6xJ2ffvgRnPNkHPEcl9QKzoG/sCuScELPter8M=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Pu92FK2SsWHFaRqQxk7iTJxK89fsE+k7y4329Y19FAaauqYjbFAK3tgHUWRRvmFM
 J6DGVL8/dsnPu9J4gixKmUTHnpCdDkqTXaqkn3mkjkdF4ozBLyXsqcGkJovnfkaF6
 BYGqemondBumcf/uLIR3UkHoK/+gP+Pr8Z84WCCbTg7Gc6oAVKBWNbp9cWC8D9/JS
 rJKgssXSJTjfHZ/NGLcDOezMTDCpBNs+GB5avotZwQhaQ5OVrWeWuLDYX+gnBp0Iz
 jcnsdHitMHBR8C2ax79mlmo3xKYqIikkPx623qptx1RW0TNMuTkKFsZNLE3O2wsUp
 iIJw6m7DTe13NeFSqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1wFxqN2PjP-00Vr87; Tue, 17
 Mar 2026 08:42:40 +0100
Date: Tue, 17 Mar 2026 08:42:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
User-Agent: Thunderbird for Android
In-Reply-To: <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
Message-ID: <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fu5MEjvjSGlY/RuWcplM9nq0efOn/ZWw/8ULzVh9dpK3acINiFg
 qxbYSvcu4VXT02CpCF6rrxI+Kh9QsoUYf/cvL4mhGn/EUNr8QRZEmQw5a36rwl0TN1VUXMK
 bggwFzMSPcaWRx/MBuyenGGeRTgOGq4wdmAdP4N4eAvxQbqUcMqdPF8aFIVFl3112oMazRD
 7W59nImdkmTGLQFZ3xWAA==
UI-OutboundReport: notjunk:1;M01:P0:Py/lOGiPjXQ=;rxUjKFosjCX6l/zzcILFRt9+VJs
 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
 kfH1PQjy17c
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

Am 17=2E M=C3=A4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias=2Eapal=
odimas@linaro=2Eorg>:
>Hi Tom,
>
>On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> As exposed by "make randconfig", we have an issue with the dependencies
>> for EFI_HTTP_BOOT=2E As this is implemeneted by running commands (as se=
en
>> by what it selects) it must depend on CMDLINE as well=2E
>>
>> Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>
>In theory, you can configure UEFI with a set of prebuilt boot options=2E
>If one of them is http(s) the device will boot even if CMDLINE is not
>selected=2E I am not against this patch, but we will remove the
>possibility to build a firmware without cmdline that just boots to
>whatever is was preconfigured
>
>Cheers
>/Ilias
>> ---
>> Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>> ---
>>  lib/efi_loader/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index b5f81e0ff530=2E=2Ea9b2f813e1d5 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
>>  config EFI_HTTP_BOOT
>>         bool "EFI HTTP Boot support"
>>         depends on NET || NET_LWIP
>> +       depends on CMDLINE
>>         select CMD_NET
>>         select CMD_DHCP
>>         select CMD_DNS

Having to select commands here to get network is what needs to change=2E T=
he network commands and EFI_HTTP_BOOT both should depend on configuration s=
ymbols for the protocol implementations=2E

@Tom: Do we have a target release when to finish the move to the LWIP stac=
k?

Best regards

Heinrich

>> --
>> 2=2E43=2E0
>>

