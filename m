Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED453C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39BC87272;
	Wed, 25 Oct 2023 10:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qPxr73yK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBA0879F8; Wed, 25 Oct 2023 10:02:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EB0871E7
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698220922; x=1698825722; i=xypron.glpk@gmx.de;
 bh=KspSZNS9A2S3bX3hPwrDqgu4tq1jo2Xnv5BBuTjCEFc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=qPxr73yKYJvbf+DsQpw9GtZ9WcAFQpRpEhwMbLvD27CXZN8ZZvmY3kd25vhNU025
 UiZAuxsU1Xl2mXUoHzeNdZG17m0DD2dWKuB4kUDnNn2BSzIsLaOs5qTiKmQrT4oYK
 f3EhyoJq107diowHqKsFkQCsmm77xo7AvWyjwkBP7A64+mK9e7J1jRSVipkC798/p
 dFKGOQpUE8wcnXxZD4DJ7dU0dRCMyUhs5RZOgrEoq6MY1KvNG6317A7xA58aVD8bT
 94YDQuu0FGpNc4fo6Zy9XylXviYKlZAEHdlCPtclpAuKPPSVPYmp//7bEl0WFaj3q
 d8+NM9xaKpHQ+OKg0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1rdvyq28WI-010MMb; Wed, 25
 Oct 2023 10:02:02 +0200
Message-ID: <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
Date: Wed, 25 Oct 2023 10:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNmHprIjc7+edEP5Bu46FUImW0nz8uVPANzS15JKn3H0oigDBQi
 pqMCHaSpDsA65EvD3WJ6/U91PAGjPK+W37Z7rpPlnM6+5Dk7a11pwyYIv8J9xqUVN2Q0FDy
 +ZFe/b/NshmNE4Xr3EdxA/Hpq0bDUp8/kbUYRv/ePl98JGh6g+wzDAabQeQLrYgpR9ck1S8
 zDgpiq89azo54anvbhv/A==
UI-OutboundReport: notjunk:1;M01:P0:tUBT18qlE0g=;WwlR2PiSwmqeiYElIf8vSvxmoSt
 6yztglqPVAHto65VUyPWVpXvR5dCZ2j60Z1CPEqGFKBiZh4JBd/rydWcbCGn/vVXTfq1Sf6r3
 RaeiZzo5oWAlWdd6aHKMFqu4hd9RVIm8avXTjb+LdIHC5SOuJcshTb8kY4TH5eC+CyH6YNaRU
 GBDf1FlDVAdUQ6xhEdFhgPRgugN6FbRTVacis4+eKpcotbYi764nlfoScxsw+dvkZ9xM3QhUO
 +fG11p8GpMH2CpgqybyieYRa/mUZ0ORwi/w90ADB417qLUZhjDWoSpDiV5oH4UQAEWY4bOeSB
 fddKF3bJgNU2CAVylsQc8hM6N+kNdhnIiALy80RWtWiEW+kPSvlgFFrnCcmkMwOqok7FEFkgr
 +Fkf2jDsGxJik5XpvjhX0t+EO/DQZo7KhL/QJau5yYzl6HwX/lRHCWYFb+vGbcmmOYsh8mLtk
 sLsFqVfCNL/KBYHqM434RK2YPwNlaDJPfQN+vnvJYiRW8az+maaX8IifEQ6ZjNKr1T/CLsdRQ
 n9LLbBM25Lx8qM72SRrekFHtRKKZmCreQDpIey37YG2F27VLr7rPUTcRBXQUZrDpWfNtLALLG
 keVZrP4U0fU2sDf9o7OnfuqBT7q7/akfdtj02Jg0BERUMr9w9faN4KPDZJzA0ERExnYZNOvjX
 ToT6Cspw6KhZ4GJzrSrEetpcYCICwVgJvym/x60+Un0rVDPbvAC6u0SnDgQxB2zC9aWxl27on
 KpRpfvjQkuJO8q9Ct45gKGINGer26xfFurk/LYB+Psz2jfBzdLs3OAKANqBR2cFAhltjF1WSW
 UPvwOrenKi0S+eVESvi4Qh6fXLc1swYG2+k3cZSsQHB/42p4hUxQA0jPZTSfgEDiVIPETsg2V
 3js3iycUkSUcuz6pjqRKsODuzrKb95hu8l3MgHUurk1d6xAFBQ0OrkNqjSTXV/T4LYCHzF2F/
 ulRskZ6kKZd2j7elCHVHKeS+KyQ=
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

On 10/25/23 04:49, Simon Glass wrote:
> Hi Heinrich,
>
> On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>>
>>
>> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org=
>:
>>> U-Boot typically sets up its malloc() pool near the top of memory. On
>>> ARM64 systems this can result in an SMBIOS table above 4GB which is
>>> not supported by SMBIOSv2.
>>>
>>> Work around this problem by providing a new option to choose an addres=
s
>>> below 4GB (but as high as possible), if needed.
>>
>> You must not overwrite memory controlled by the EFI subsystem without c=
alling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fall=
back for outdated tools.
>
> That is not my intention and I don't believe this code does that. EFI
> is not running at this point, is it?

The function install_smbios_table() only exists if CONFIG_EFI_LOADER=3Dy.

We have:
EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
This is invoked after efi_memory_init().

The EFI specification requires that the memory area occupied by the
SMBIOS table uses one of a specific set of memory types where
EfiRuntimeServicesData is recommended. So you must call

u64 addr =3D UINT_MAX;
ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);

to allocate the memory. If the return code is not EFI_SUCCESS, no memory
below 4 GiB is available.

>
> The bit I am confused about is that we don't support SMBIOS3 in
> U-Boot. I am trying to fix an introduced bug...

I would not know why we should not use SMBIOS 3.

Best regards

Heinrich
