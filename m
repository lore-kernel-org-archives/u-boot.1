Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF47C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD93F81703;
	Tue,  1 Apr 2025 18:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j2ajEd8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425A981703; Tue,  1 Apr 2025 18:13:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25554801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743524024; x=1744128824; i=xypron.glpk@gmx.de;
 bh=HSLhxOgTOwhbnuy9xRo8aM6S8O1nyWPCVKnlpnrBIr8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j2ajEd8P6120NOOzF4Fz5p2CB8T9sArvkR8/AN6G/rYhIOQYhNuqulGsswmQuqS2
 se58FHinrVU96dmeNKtwqxqbC17noRqqVZd5BhYdUV0bvy/MUDjsTE/P5q5auP12f
 FLFQy8t+dDHNIsWK1qMaECmlBAcc0FeEY/ab2VieFL/KQXyIUC1Xdbp8SPET8fg4B
 3KdRj8ebFCWAMOx1ststpq4/AgzB2L/+e26w5khHMHqtIaHA3tETLWcCcFXTmXcMM
 ckTySTuEyauqT8gdQYJgHIrDhP+Pbpf6nysxn6eGmSCtWR8UMa9kSwyzkcahZzQL9
 nhN7+ZZnAbzOqPFXSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1tcN9P2fal-00SAHM; Tue, 01
 Apr 2025 18:13:44 +0200
Message-ID: <74ce355b-4e2b-4d5d-b6fc-2ad421be7f3d@gmx.de>
Date: Tue, 1 Apr 2025 18:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "net: eth_bootdev_hunt() should not run DHCP"
To: Heiko Stuebner <heiko@sntech.de>
Cc: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 u-boot@lists.denx.de, quentin.schulz@cherry.de,
 Simon Glass <sjg@chromium.org>
References: <20250401083830.2320479-1-heiko@sntech.de>
 <CAFLszTihxUb8+fsFPztzx0cShG96uXb32pAQ3hyEEFE0Z+JzeA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTihxUb8+fsFPztzx0cShG96uXb32pAQ3hyEEFE0Z+JzeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xSGLW1S81Hcn07vrEwNOXaE3cMcL88q97KFB1bnSiWqeFULHAaq
 UwN7JXaeNKKrKzyCmTgfgL+XQHRU1uk8P2RduaoaNhTREufd9UkiY39Us9q/Dx1EBRhwX42
 Sa9/lMBLn6JzGZc5KXs7EbQVWSahX/WEEzp760lZaLLCNHuBM8nRp3KJ8IhZhvV8LQXJCol
 DyzrGgFiwhZJLmE1idp8g==
UI-OutboundReport: notjunk:1;M01:P0:uIJBPxRR7zA=;q1oUPXtTkmP07uCj1ksBHF9oABZ
 MNTDcCRMwtOWI9ZHNGW8O2VhU6VD+5i5G29STVvU1J6wrktLnhZX8W4IxsYfp46CSNPwktYS+
 96NmZHk/b6EtfAmv+v0tw2DqO/HCqNxRD+FzTBxOYakL6y6mWpoKacp6A9OPXqzjNj9qeCHvV
 YNNJFgdHxJzGDFmU+ivMhQoEdJtSP67XFA5EPjMKJJ4zFlHjf8F2S19rVyXGavvP5ITEUo3YV
 FrTaMNau9RL8+kHHaZR462H//EJYY8+wvFJkK5juXiXr5N03notZmnxzY/PTcaONeNyvZ13xr
 t7JbMiX+ZvsuQgO3xiJtUWghK+JNibvu54X3wULvPij8x12hgMka6wr9+HiMP1/URsbWGeXUP
 YilHY5n7dAC9vJvs+AGy9hYYgCbaNaXRUFlkRvTjySItlhCQ6YmnTxUqguofuI3YSWcM7jGgp
 Wb9cgQWHLVf/djy1m8lM4d5MAduP+hDOXSz3178y2RubgvQWe3rL+lbYm2hKdR/4P/aCXRh7G
 y2A/2sXaIb8qZuADmZnOlIwAiR66xaWqxwiyxmH9M572xWYxTvuIZCPVw9B+XrbdDIu6kmB+l
 hJ/uf7X5a194aTAXit6RwIuWyyfWP1E78fX/V291Dj/YXOoDtE58TUziPGFH3lPGHAVEl+7O1
 uoM8vzDbCeFxgFElVadLyCl+Hw0GnufUqLNsXIrXbfyjFpBmWT7kDmmLL/sBD9tZmM/nkZVIl
 lVHM19mQtGmkAlT9c0WT+ddi7CXtUdL7Gq+ATvfXOW6BtKysCQhEQDA/YXwLFlgZJoprlnOz9
 OVdwSuuVDFJE3WJMSl+BYk+FOXX6SYJm6AWnXY2BrtrWrynX08M5MJGn7OVRfHsSIxye83R1w
 /UHLCOE3PWsiZX9rxEMmBFJgJpR8xfFHovLJmpfppQ6smJzWrz3xOU8RdrXsAKFqbJgEJP98/
 1b1b5tPkbvcmmF7xNqNf41zimiPMhs8YQtyf94XeZLRj/gizUykah3dQWlh/UolCNeD5G+Rrx
 SZxMNH87JAhu+OR7qNnIeHVEQd2aRZxvtJDkqNOnxbhchZCsRaMATwyyXvwGE4NeWHwoD0dtc
 oZ8qYb27zWOKuC+g0Bcc6FIhT35l120gss41MPq7akh1v0I5qN04bqoKkE8G+TJ3l0LC2yqi0
 Mi+QffBRNQbWsHKnKjaSwrHZuRp2mf4hUJrUDubwkxW0l5DOnhQzPeSLgUsC5eAHUxepSs7pk
 nU4B5fkmedGX0pgQVvH8C3UqA2vsqiCUM5mU9Yt3JtDveygMWb+SmaC49/e60s9UJLO/quIZb
 MbS41Vqm3gxnWYuVzXlB+SgkNThm+5Bl92F4DxKduMyATnHoFfim10aoNcuL1AVj0GDw9rrXK
 MX44GKpm+LtTlH+3GWxpyKm+xEVA12VEXifxawiRAZq8nVGoSM29QVdRRhBtDIaiaNH+MOrBZ
 UW8xt/r6xAZb9+FMSAe9oAnttJCo=
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

On 01.04.25 17:51, Simon Glass wrote:
> On Tue, 1 Apr 2025 at 21:38, Heiko Stuebner <heiko@sntech.de> wrote:
>>
>> This reverts commit 1f68057e03206e6597ca8b2be8bb1c49d4bd47d0.
>>
>> Commit 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
>> aims to reduce EFI boot times by disabling the dhcp_run when
>> checking ethernet bootdevices, by preventing it from running double,
>> with the reasoning
>>
>>      We need to call eth_bootdev_hunt() when setting up the EFI sub-sys=
tem to
>>      supply the simple network protocol. We don't need an IP address se=
t up.
>>
>> That might by true for EFI, but not for everything else, because when
>> running distro-boot and for example the PXE method in it, nothing will
>> set up an IP address now.

The removed call was dhcp_run(addr, NULL, true);

We have:

distro_efi_read_bootflow_net():
boot/bootmeth_efi.c:205:        ret =3D dhcp_run(addr, NULL, true);

script_read_bootflow_net():
boot/bootmeth_script.c:132:     ret =3D dhcp_run(addr, fname, true);

extlinux_pxe_read_bootflow() seems to be lacking the call.

So instead of reverting
1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
we should add the missing call in extlinux_pxe_read_bootflow().

Best regards

Heinrich

>>
>> So for example in my setup of Rockchip boards, no dhcp runs and pxe the=
n
>> fails with messages like:
>>
>>    Retrieving file: pxelinux.cfg/01-....
>>    Speed: 100, full duplex
>>    *** ERROR: `serverip' not set
>>    Retrieving file: pxelinux.cfg/00000000
>>    Speed: 100, full duplex
>>    *** ERROR: `serverip' not set
>>
>> As the original commit message talks about speed efficiencies for the E=
FI
>> side mostly, reverting this should just restore previous functionality
>> (and in fact does so on my Rockchip boards).
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   net/eth_bootdev.c | 30 ++++++++++++------------------
>>   1 file changed, 12 insertions(+), 18 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

