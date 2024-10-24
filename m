Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D389AD0BB5E
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 05:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA78892E8;
	Thu, 24 Oct 2024 07:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jExaR+uY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CAB8932C; Thu, 24 Oct 2024 07:03:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FE2892E8
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729746208; x=1730351008; i=xypron.glpk@gmx.de;
 bh=QFtewNSED8SlIgV/4wWKH5ux88PDoMk8W3oScZLxkq4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jExaR+uY0qJvtpMNH2E6QSiVXG/PhHOpyfderI9d3xugzueJizkhUMMk951cyErZ
 aFk2ExyWN6ArnhAr2p0JHrIqS8UgcbEi4ond1MSj8/Ow+/lS3sNggxJGp4+smxwYp
 C93y3Wr+sE61bPhzs0fyWqGOiruq4Vi0kBHGnaxQQnJtKSH9wESY0o0A/lXDAm0Nj
 wFm0olT2cGaUjoYOK8xCS74wmHzYgvdc1qTHcd3/ePFFOHOT6AFdISG+x1BmlIErt
 o2g8inYSANt91MrJXALBrFKQExHFqyeEERfiQPnrDelcSBgmcaSXNS8Tp3GOvNGBa
 nwXPdiVPWWn86B/wpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1u3oar3Qhe-017rRa; Thu, 24
 Oct 2024 07:03:28 +0200
Date: Thu, 24 Oct 2024 07:03:24 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/1] efi_loader: Mark a function static
User-Agent: K-9 Mail for Android
In-Reply-To: <ZxemNUOQ8UUQvAqO@smile.fi.intel.com>
References: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
 <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
 <5fc1929f-c931-4c14-847b-6ea9333037d5@gmx.de>
 <ZxemNUOQ8UUQvAqO@smile.fi.intel.com>
Message-ID: <5EB571BB-8963-4B47-86EC-1F1C5424D4F1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wI8GTqxo3UQu0QniR4qtrF12kCdi32zbdgfBgr+42ZBoAEi6mLa
 H2mkAi9ojeAjITzd6h/6DcEZVvll/v0ks+e0Z9y+DMSjgEKToyBXL4kQU2TPgWSM11w1kzp
 k+zOT729jYcu99V6Jtilh0QZ9XDHj5TjLnHeK4PJBw13abkjO6e4vf6V65EBEZvRmy4ir0g
 5G+HuYxze2OnL8kq0ggRg==
UI-OutboundReport: notjunk:1;M01:P0:5VGEgqebE0g=;sr01L3Le62HJFxoo4ex872MZ18J
 8Bl3DNkwNWNV0BV2fwnsq8cZG9wr9YYLkeJfNiy+ec3HdTLt8GB5dJQPoW0h7K6rdz/YXfEWu
 2a9a+VyHCSU3I0SwV3JJio8LPjrY7um8GlMROEENggJgcvw5zZJJfCi4qmjvsZ6M11SCs2Utt
 1GkcsJg/0It34rw0u+gqt9EFdMXCqa7QX8WLOEQd6eBbANmfL0uyZ3LWBknV0tz0OWs0haLdN
 HTDWtkcZnpB0BXjzfJ9cMHExVJt8Pko5qBEthtY2UXkTZL9utkmdX1OCEuMslLA0RplEwYneT
 8/eg/iOCzJMHMSXZBTxJMfwPShTvhxh8CIhqP7lxmIOeAnpZKBl4HhCyLhIwjxpCGfQik57Nh
 30Rw2tGYkQWVgo2LgQq5NZ081AyLcI6t+P2SMJANgP0pWYtONSqx3lMNdXBMkSV5QC3rxcPV5
 AJopNoQeMmX2w/CbkS5wxAhxzqYhngf1gggYpT4GyzezkvkJfUh4hFGp5prW88kFsMa5ni4lP
 d0KbL6y4OcMDnsFIa0uwTMOea1hDplUB/Fc1Vtql8le44UQNE/K6pH3c8cwL+72pXSbmnNIHJ
 3OHUy7zgqyKskjqzHWH8Q7Oo3lREoE8wxEQpZIxyaotkanLH90wqpnJnx5tWXmqRcrmvrX3+B
 FNbPRdy74osuRis4y03qOpt4yaRxZlw95cMM/nbJVoVmYfMdNWd0jHIytnwTMP0VvdZURO+bZ
 5tAPdsutC5AzQm7lO8GVtVOjIkGXvHoAuNaV/M4pdUwKM2TV2yaLRim8ei3p//zWk+zeztifE
 kiD9FaozpHgSb2WRlN+s7zkA==
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



Am 22=2E Oktober 2024 15:18:45 MESZ schrieb Andy Shevchenko <andriy=2Eshev=
chenko@linux=2Eintel=2Ecom>:
>On Tue, Oct 22, 2024 at 08:02:46AM +0200, Heinrich Schuchardt wrote:
>> On 10/21/24 16:40, Ilias Apalodimas wrote:
>> > On Mon, 21 Oct 2024 at 17:06, Andy Shevchenko
>> > <andriy=2Eshevchenko@linux=2Eintel=2Ecom> wrote:
>> > >=20
>> > > efi_bootmgr_release_uridp_resource() is not used anywhere except
>> > > the same file where it is defined=2E Mark it static=2E
>> > > This helps avoiding the compiler warning:
>> > >=20
>> > >    lib/efi_loader/efi_bootmgr=2Ec:388:14: warning: no previous prot=
otype for =E2=80=98efi_bootmgr_release_uridp_resource=E2=80=99 [-Wmissing-p=
rototypes]
>
>> The function is called efi_bootmgr_release_uridp() since 292a4a4c7b77
>> ("efi_loader: shorten efi_bootmgr_release_uridp_resource()")=2E
>
>Thanks! The problem is that U-Boot doesn't have the latest tag (yet)
>that includes this change=2E You can help with managing the conflict=2E
>


Patches should be based on origin/master (or origin/next once that branch =
is opened typically after -rc2) and not on tags=2E

Best regards

Heinrich
