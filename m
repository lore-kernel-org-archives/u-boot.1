Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3776FCE79D0
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 13:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2718D8615A;
	Wed, 20 Sep 2023 15:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="n5XvW/Jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BDF86B63; Wed, 20 Sep 2023 15:37:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7A386479
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 15:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695217069; x=1695821869; i=xypron.glpk@gmx.de;
 bh=+oTmmk8ML8O6/TtYshDAnof4OHG2702UnHFEx9rQp2A=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=n5XvW/JnkFFvq8orLrmp7Im50y31rLLaUac08L8rDtrNyg1dHLHWO/ecrCulN8Rz0qWcQoLyB1R
 T9ke3adBtQisRFFnzGUQzJVsHaF2IxDRdY05QEaS25rze6qGrfwFfpMi8gwRw4HWNMDrqrC7UJoNS
 7kRCbIOa/k7SoJ1bvTUc5H9j94wTSH/zFzuau9Vj4kW/eapV7ZEMB+iSgV4uDPXI/BE5bzTNh4PuX
 cYxjiELF7XtXd8SD/GLKzP6NQrRRgcHCTxoxr/0YBS6rdD99KjOMcTYRQFtG0+nhI0spo/7Hgfpnc
 8jUF15aR8lqnkYtUiAqUNB1UoluZ8ZjfvFgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1r0DIk1J47-00IReK; Wed, 20
 Sep 2023 15:37:49 +0200
Message-ID: <54f9ad4b-3b76-4c7d-8f82-da9ab850f1e8@gmx.de>
Date: Wed, 20 Sep 2023 15:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/20] x86: coreboot: Drop USB init on startup
Content-Language: en-US
To: Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-9-sjg@chromium.org>
 <6c3f7c16-c67b-4c7d-9d91-0e214702fa88@gmx.de>
 <e40d4f2f-7fdf-d565-eeba-ca27f1fa44d7@denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <e40d4f2f-7fdf-d565-eeba-ca27f1fa44d7@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UcVos0hXHmQxFkNB6o8M+dQPlCvhO+tT5c3N5/us1lCzCONdM9K
 R6KyoxPn5X2GV7dc/0glMBghHlRsvBwnGkLgCURp4yeVrxuVxXGGyXyTy+Qz4ZWPoCSWxC8
 tTQTR+mvhHJKC2CFbl4K63P7G+lSI7HUt0TNWEhd5Ac4oz036RnUvUF8yRlqB84L1sLN6+3
 dLfsQYd1UYc2urJdD/6bA==
UI-OutboundReport: notjunk:1;M01:P0:7towpcnQxbA=;fvzPseddv2izRgMiDEm6AOdcbOB
 tUJbINQKcOLh413oY4qi6kiglpV6t0WpTZJ9TFTsA3NMPvNH7HoJuykiDdRMR4qmv073ns16c
 jUE/eIdtpLF6SWhn4t/6nEkgmJncgqR8oTf7wjSJpAYTzPkhp7zelt6H4cu1FBcjvCtR+fLBB
 rEEOKzUwqpAB1HGa3AMcf0Fjhgk9vRsGUt+vX6052gen1T/3SZg8lKK8r6RRPKhg+Nc1Q1o6c
 t1oI1v4ava2Ts3JbWxbjb6B7CZUZiJ6JiyI6cokZHupZSiNF+7r4WT1+8WXm2GzjFrsyv+01K
 Uwte07K+x4i9LPECCD7/SM9EMTNcnBCyL0q63LCypdibon3cdu4EyFhCT8aaf75h+EdTrWBSK
 9CUKKU8sgBdzfmCKSgM6Vt4A7Dx+60puItMsH8eU24TMlNpWf5CKAaQgtETTZEBSMJOQSychi
 Vjt7jNd6DVefI0+rg3VQKYsJ3zS7BzUVBfxXpRLEfyYUk4aWH0lMpGmMmxRk8qgsOeZ1CIRz0
 v/LzxmnpGXHxD4hK/y41wPAvThz+8nsf1RI7vEyHKgXtCLNCYfRSsC4zIqnXa0POjoGC5KLG1
 64OfQQAMT2kNthkBbZY/jvqGad3YpPYNW/xM/Z2hxu8NH206zMh/Dvt9f12L69Y7tUv61KhCf
 tnNJxbYCHHCJrQbr6xtu6qVt5UZxTYJde16bv4Jbfy3OzgpUg8kxvHXyK1jPK2RXP6OlBLkgo
 R7nErqQSBA3U/6Hdvar2RgwqOuWmghYFjGFKIorgljgEEk2Imjul9FBB2MfKirHFrtfwcpjcL
 G5AWA9GWJQHl+fSu+EdhPIluIft2/C54ORewp/4BM5KinM40yjRxrA0GTYicWoYNldCEib6kE
 roZ8W+xJQ3p5vqABpEMvMjNqRf1WUJma6Ye9NIImkz2n/ySPn+FpmvVZ+9/GO8K6TWybnV3il
 vRl75g==
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

On 20.09.23 13:50, Marek Vasut wrote:
> On 9/20/23 09:19, Heinrich Schuchardt wrote:
>> On 9/20/23 05:00, Simon Glass wrote:
>>> This is very annoying as it is quite slow on many machines. Also, U-Bo=
ot
>>> has an existing 'preboot' mechanism to enable this feature if desired.
>>>
>>> Drop this code so that it is possible to choose whether to init USB or
>>> not.
>>>
>>> Use the existing USE_PREBOOT mechanism instead.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v5:
>>> - Make use of the uSE_PREBOOT mechanism
>>>
>>> =C2=A0 arch/x86/cpu/coreboot/Kconfig=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 arch/x86/cpu/coreboot/coreboot.c | 4 ----
>>> =C2=A0 2 files changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/cpu/coreboot/Kconfig
>>> b/arch/x86/cpu/coreboot/Kconfig
>>> index b97c27790419..178f8ad18162 100644
>>> --- a/arch/x86/cpu/coreboot/Kconfig
>>> +++ b/arch/x86/cpu/coreboot/Kconfig
>>> @@ -25,6 +25,7 @@ config SYS_COREBOOT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply FS_CBFS
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply CBMEM_CONSOLE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply X86_TSC_READ_BASE
>>> +=C2=A0=C2=A0=C2=A0 imply USE_PREBOOT
>>
>> For automatic initialization of the PCI bus we have CONFIG_PCI_INIT_R.
>> Wouldn't it be preferable to also have a CONFIG_USB_INIT_R instead of
>> relying on console commands in CONFIG_PREBOOT?
>
> I'd much prefer 'preboot=3Dusb init' or whatever console command, since
> this is not hard-coded into the U-Boot binary and can be overridden by
> user if the 'usb init' is inconvenient/unnecessary/... without replacing
> and/or rebuilding the U-Boot binary.

Just for the record this means using CONFIG_PREBOOT:

include/env_default.h:

#ifdef=C2=A0=C2=A0CONFIG_PREBOOT_DEFINED
 =C2=A0=C2=A0=C2=A0=C2=A0"preboot=3D"    CONFIG_PREBOOT=C2=A0=C2=A0=C2=A0 =
"\0"
#endif

Thank you for the clarification.

Best regards

Heinrich
