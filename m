Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6841C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 17:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B3C86EB5;
	Fri,  3 Nov 2023 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JA4iv4cw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594A58708A; Fri,  3 Nov 2023 18:37:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102C686E09
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 18:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699033062; x=1699637862; i=xypron.glpk@gmx.de;
 bh=vOsGRTs/c9ywxen/gvTcddodA+AqellL1r530bJh6xc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=JA4iv4cwYCAwNrA9+o8dlJ9NllWtxlmNzLaV9v24C4QXb1QpUvaB5RuMbfhr8U28
 8sr8aRgQfzT1TMQmYRLiuSWzc1S2qsE/8eD4ITYID9Pt4ZdOWYlNIpXMhx077mWCE
 w/UMOfYEvdnUVfX5DB3mXLa4bj8yc+7+cZlbTuenohaqcXMrn2JpTYwloTjUj+kwX
 +kTP9kf3JPinCOfSFIct30jtH3NoeUl7zISiMVVi2gmNTfJFsH+FMWgEq+hkuA/Nf
 EL6/Uh/sp+xWcaSIxJoFYJh1+PT+fvAEqIlqHpJdnG3xo1TeIQknRavANzfwXlRK8
 PidkWTOmKzquTFIyqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([159.148.28.2]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1r2HVB3dIq-005Vln; Fri, 03
 Nov 2023 18:37:42 +0100
Date: Fri, 03 Nov 2023 19:37:38 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_smbios=3A_arm64=3A_Allow?=
 =?US-ASCII?Q?_table_to_be_written_at_a_fixed_addr?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
Message-ID: <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1DMe4XhIZvBHcJuNfUJ9cwCBo7pONtWyJzw8IPaSILgIL+iKd0+
 mwejuciVpFEIhJ1U1mdEOXqNC0afi3Nr9EV/cXxDHHk4vxOS5vBIMmPVQk+cBKmwTYzf4+k
 ePNT399zvgONSKJBp7TFjt7BJBGpaESmPr8NrrfBUsGphcvQwlhnZ0w5G+HRskm5LzmO5s6
 OPlhEg7B8Bb8FhAZ4buow==
UI-OutboundReport: notjunk:1;M01:P0:I2hcKpPrMQ0=;s1kL8D4otI1XIWFRAV9BRd3fknA
 OZGgI1GzJs7pc2nhxdY6O2MusfuEeG85aoxyWZcpoWqQLjtiF18qa61KBMxrHDva0Z5rqmbi6
 Zrr19JMbYxLE5QtozUUTXtKMob1fMzvo+wNMetyYfNpqB8IvROz94fOCjsLM5mhejXUekXYH8
 6NfZ8mBz5n3MK+fhrsqC0gG9brTlI7XUqW7E/xfFSFCqN9/R+HPgxNFiXobtn31LzqgQEW0zn
 bzD+F6emcuEEmMidy0Mbnttev9iDuXDV4MpjjVnCw0SS0+K+WuPU+bHYdsojEYc6sJ+hXPs1y
 +47STSprHkZnEtJsM/54yIeCrVyU4/clOQa3h0OY04ZMa3fq7puFyk3rYFkDq85nBrRhoMyks
 bPDRv6+r3ckRsUer7+T0LLRuW9SIbe6hQlt4ioTuJlE/WbyJRJin3sOLIwfwIJPtlFimsnony
 bEdSlOyTUZZgH7RjGuHVzrG+3/rtpCzKVCyDE19SyhrB9RmQB4NlP1lVE8ozRe8ldXG3avqC2
 2z0zPiHb/nnE9iOGXrFM97GmqAZtc5WmyHiWqkwIr/zpPIaROj3HZ8oHgB4ljcWuuZnBjedhl
 JefRq6lyh7PH2yMwxN5SvmZGX/36Rlx6seS5sXiV7+BNfzN3tcFcyaL+F5II2qW/yTJesIig3
 iYFwzvDG8ILE0h5A3kiWKqjEvkakpgLLLIGL1fUhljW9vqFNuG4Yj7E2bKwdw9Zb6MFcSJbrK
 2HF6aql0xHcNtwoqiJja/2fXxiQg9HpH3vuA2pIbBGF+zsCcyOUrVFvNUv4qBxkeL4gNj84jF
 TKvapKe+JBa5ioWa5/GQs7ZBdFsLSZDtXRCvM0Gd5+G1Q5QQ2McIhJ+IaGeChA7lx2SG2Euvf
 dTdGKPgLSSXIvLCq1zoWAmj7S2SGUXjrpGQvWpPUG9uxHKTHWIqQklKQiQmrTj+pZysyq1H+j
 ud0ETgkT6QeeszKxkncRJ7bvmVU=
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



Am 3=2E November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi,
>
>On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium=2Eorg> wrote:
>>
>> [unfortunately I am not receiving email from the list at present]
>>
>> Hi Heinrich,
>>
>> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron=2Eglpk@gmx=2E=
de> wrote:
>> >
>> > On 10/25/23 04:49, Simon Glass wrote:
>> > > Hi Heinrich,
>> > >
>> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron=2Eglpk@gm=
x=2Ede> wrote:
>> > >>
>> > >>
>> > >>
>> > >> Am 25=2E Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chrom=
ium=2Eorg>:
>> > >>> U-Boot typically sets up its malloc() pool near the top of memory=
=2E On
>> > >>> ARM64 systems this can result in an SMBIOS table above 4GB which =
is
>> > >>> not supported by SMBIOSv2=2E
>> > >>>
>> > >>> Work around this problem by providing a new option to choose an a=
ddress
>> > >>> below 4GB (but as high as possible), if needed=2E
>> > >>
>> > >> You must not overwrite memory controlled by the EFI subsystem with=
out calling its allocator=2E  We should provide SMBIOS 3=2E SMBIOS 2 is onl=
y a fallback for outdated tools=2E
>> > >
>> > > That is not my intention and I don't believe this code does that=2E=
 EFI
>> > > is not running at this point, is it?
>> >
>> > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=
=3Dy=2E
>>
>> That is because ARM devices don't normally need it, right? Anyway,
>> that option isn't related to this patch=2E If ARM devices started using
>> SMBIOS and had another way to pass it to Linux (other than EFI) then
>> we would want to install it=2E
>>
>> >
>> > We have:
>> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
>> > This is invoked after efi_memory_init()=2E
>> >
>> > The EFI specification requires that the memory area occupied by the
>> > SMBIOS table uses one of a specific set of memory types where
>> > EfiRuntimeServicesData is recommended=2E So you must call
>> >
>> > u64 addr =3D UINT_MAX;
>> > ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
>> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
>> >
>> > to allocate the memory=2E If the return code is not EFI_SUCCESS, no m=
emory
>> > below 4 GiB is available=2E
>>
>> The root problem here is that x86 and ARM used to work differently=2E
>> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
>> table as part of the 'bootefi' command=2E On x86, the tables were
>> written on startup, so you can examine them within U-Boot=2E Clearly th=
e
>> x86 approach is correct=2E For one thing, a previous-stage bootloader
>> may set up the tables, so it simply isn't valid to write them in that
>> case=2E So we need to separate writing the tables from telling EFI abou=
t
>> them=2E
>>
>> So I have fixed that, so ARM now writes the tables at the start=2E But
>> using an EFI allocation function is clearly not right=2E This is generi=
c
>> code, nothing to do with EFI, really=2E In fact, the SMBIOS writing
>> should move out of efi_loader=2E The install_smbios_table() function
>> should be somewhere in lib, i suppose, with just efi_smbios_register()
>> sitting in lib/efi_loader
>>
>> Also, why is efi_memory_init() called early in init? Is there anything
>> that needs that in the init sequence? Could we move it to the end, or
>> perhaps skip it completely until the 'bootefi' command is used?
>>
>> Another point I should make is that it should be fine for U-Boot to
>> put something in memory and then call efi_add_memory_map() to tell EFI
>> about it=2E What problems does that cause? It isn't as if EFI allocates
>> things in the 'conventional' memory (is that the name for memory below
>> 4GB?) This is how efi_acpi_register() works=2E
>>
>> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
>> drivers/video/rockchip_rk_vop=2Ec and other such files)
>>
>> >
>> > >
>> > > The bit I am confused about is that we don't support SMBIOS3 in
>> > > U-Boot=2E I am trying to fix an introduced bug=2E=2E=2E
>> >
>> > I would not know why we should not use SMBIOS 3=2E
>>
>> Neither do I=2E Perhaps there are compatibility concerns? If it is OK t=
o
>> do that then we could go back to my previous series [1]=2E What do you
>> think?
>
>Tom responded but I missed it=2E In part it says:
>
>"So, can we please start by just doing the minimal changes to get the
>SMBIOS table done correctly for memory above 4G, via EFI, and then start
>the next steps?"
>
>I am OK to do an EFI hack for ARM so long as we agree that after the
>release we will revert it and generate the table using generic memory
>allocation, not dependent on EFI=2E Does that sound reasonable?
>
>I don't seem to have received any response from Heinrich to the
>various points I made above=2E I cannot see any response on patchwork
>either=2E
>
>Regards,
>Simon

All memory below the stack is controlled by the EFI subsystem=2E I notifie=
d you of the function you need to call=2E I can't see what information you =
are lacking=2E

Best regards

Heinrich


>
>
>>
>> [1] https://patchwork=2Eozlabs=2Eorg/project/uboot/list/?series=3D37765=
0
