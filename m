Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7662DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 21:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF2E870DF;
	Fri,  3 Nov 2023 22:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IdXuo58S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA628708D; Fri,  3 Nov 2023 22:44:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6589E871ED
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 22:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699047840; x=1699652640; i=xypron.glpk@gmx.de;
 bh=wJyWxzvtuNiksL6mOammCe1ZlQMFKiuvYE81tXa6DAE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=IdXuo58Synj87D1vI39ScRIc+mo7+FffEFGRA9yo07XhrQcwYwaddwq0NeB1WBsl
 9bQInZ5tpuHp/uiNY2YC3Rr05PBnKcxCSfWDR6WHe3V+A52CUZVyYGRD32OXt1PiC
 c9z4NeLT9RtN3wupmITRV96loAq/mjTJw3ETCul+df04yVea8SModBIAr90UV/No9
 B7DiCXAf+qb/gihEPDNOjB7UAiya8A2mSecJls/4IovknLEtKD008zCd7zjrHfjfK
 75Jh4ylO1q46l0xdnLKKZSXR43q5Q5Sip86B3HR5oVTBq/RN/e4AJW70E97h68slt
 +8zgh5VH8WviyqLutw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([159.148.28.2]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1qpaJK0gmU-00SBD5; Fri, 03
 Nov 2023 22:44:00 +0100
Date: Fri, 03 Nov 2023 23:43:56 +0200
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
In-Reply-To: <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
 <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
Message-ID: <3F64E74E-B384-45D0-A53D-E8E3343CD528@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YrrHfcIdC6vod+VKoGhXGruoC8aaMZ0oqXA9HBF/M29jp5WGVLa
 guSeyOp2T9WFZfueBkXkhODKeac6wWPNgK6MrIsLkYtWoiqwGmYh4VUWKjRHCcFw70EQWtt
 r7uNdMLQy879U8s1M4/nnvpRupnYRhruZCnz1doXIWGjTS5a+ta7vdy089n/+bQTRiXSpNo
 6O1cUjLinp0W/Itf/oV8w==
UI-OutboundReport: notjunk:1;M01:P0:24A40KJWEMo=;vtGmjI0/vj6NqL7dcH6gnsms6tX
 qvTyB+vcPV9PfTbw5VGDgF+9KFU4cMnLb0QXkQrtxYn7YQwfEImoHjSuyvS2EyExe9gNOM99j
 hsR3mnfNWO2x7DcIG9GgpIUWh6SPzM1cpts5r+IjrP8jYswJJqS0TV6yQq5D7ZcSBd8BeU7tZ
 JMDQRg5USESz9NCo3qv+zRpLiAZetxO3voq5bvLTNiISsJoNP3eeDD/jRRKqTfvp6HgrdBSgv
 ZlCgXw661v+zvdpCBjAlH+sHmF/jkSeVGXp5UQc8qNZ+pu4U9U03q6hLiU+iASpLVoL3Ra7QB
 2avlJc7olHWKCtSFE6BYPpIaHwMo7I07JyVXnyFa0neykJh6tkEOdzQjyvD9lvc7TRBTWtNPv
 bGsHgG2v72fwj2VqzFnGfvP315L1PSTLi3AijUJZGy4qvzVD5JrBs1r4Xr24Zur3KJlSKEo3C
 U8HRvkjajzH9yFwr6LADGSTYUAkSTDll2GvH6X2lRBlvzFqnYgt5UvhvJIhJeG+9AsP4brE7Q
 JEPhiFWBWCRoQEbFuRgMBoKfauHdRgfI83H6vFZOrDi29djVlgAtNJxN60VkLWcC7zHfO2Nik
 Ro2gvTozBeFpP/+m0E7fG22SeyUPyqU1ZsKwFuDl0soSlWFmXiG9Hf2rtNnKB67IX/xVN9p+G
 oER+oPlq04/Ogtd8iOgMmHAA8TjvljWNYQCPZqszrh/vZSsIYky++H58TY/oT/cYara3FFvXl
 vC3QjaXyWMaBy1Ijq+fHUBtDHaijruVYv0a5aqnnNO40KYQTfXm5T7fCMAibgutiEkn47cSlv
 w4CWv0ZnqZtt0NYlOyWuUdbp6O2f+jvklW2dcFA2JZxrmSkflQnwdeLT7VIkE8vnJ4fa/eAbm
 eh8K/kEDnigtR8FvAcOk4PQUWOMrUaIhm6r8tJAG7/KuUPpcO3w9QfIBg2pi98STG1wdpJ1xF
 bForuyNmYrCuGio/AfOwNqVAH1I=
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



Am 3=2E November 2023 20:14:46 OEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Heinrich,
>
>On Fri, 3 Nov 2023 at 11:52, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>>
>>
>>
>> Am 3=2E November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium=2E=
org>:
>> >Hi,
>> >
>> >On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium=2Eorg> wrote:
>> >>
>> >> [unfortunately I am not receiving email from the list at present]
>> >>
>> >> Hi Heinrich,
>> >>
>> >> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede> wrote:
>> >> >
>> >> > On 10/25/23 04:49, Simon Glass wrote:
>> >> > > Hi Heinrich,
>> >> > >
>> >> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron=2Eglpk=
@gmx=2Ede> wrote:
>> >> > >>
>> >> > >>
>> >> > >>
>> >> > >> Am 25=2E Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@ch=
romium=2Eorg>:
>> >> > >>> U-Boot typically sets up its malloc() pool near the top of mem=
ory=2E On
>> >> > >>> ARM64 systems this can result in an SMBIOS table above 4GB whi=
ch is
>> >> > >>> not supported by SMBIOSv2=2E
>> >> > >>>
>> >> > >>> Work around this problem by providing a new option to choose a=
n address
>> >> > >>> below 4GB (but as high as possible), if needed=2E
>> >> > >>
>> >> > >> You must not overwrite memory controlled by the EFI subsystem w=
ithout calling its allocator=2E  We should provide SMBIOS 3=2E SMBIOS 2 is =
only a fallback for outdated tools=2E
>> >> > >
>> >> > > That is not my intention and I don't believe this code does that=
=2E EFI
>> >> > > is not running at this point, is it?
>> >> >
>> >> > The function install_smbios_table() only exists if CONFIG_EFI_LOAD=
ER=3Dy=2E
>> >>
>> >> That is because ARM devices don't normally need it, right? Anyway,
>> >> that option isn't related to this patch=2E If ARM devices started us=
ing
>> >> SMBIOS and had another way to pass it to Linux (other than EFI) then
>> >> we would want to install it=2E
>> >>
>> >> >
>> >> > We have:
>> >> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
>> >> > This is invoked after efi_memory_init()=2E
>> >> >
>> >> > The EFI specification requires that the memory area occupied by th=
e
>> >> > SMBIOS table uses one of a specific set of memory types where
>> >> > EfiRuntimeServicesData is recommended=2E So you must call
>> >> >
>> >> > u64 addr =3D UINT_MAX;
>> >> > ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
>> >> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
>> >> >
>> >> > to allocate the memory=2E If the return code is not EFI_SUCCESS, n=
o memory
>> >> > below 4 GiB is available=2E
>> >>
>> >> The root problem here is that x86 and ARM used to work differently=
=2E
>> >> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
>> >> table as part of the 'bootefi' command=2E On x86, the tables were
>> >> written on startup, so you can examine them within U-Boot=2E Clearly=
 the
>> >> x86 approach is correct=2E For one thing, a previous-stage bootloade=
r
>> >> may set up the tables, so it simply isn't valid to write them in tha=
t
>> >> case=2E So we need to separate writing the tables from telling EFI a=
bout
>> >> them=2E
>> >>
>> >> So I have fixed that, so ARM now writes the tables at the start=2E B=
ut
>> >> using an EFI allocation function is clearly not right=2E This is gen=
eric
>> >> code, nothing to do with EFI, really=2E In fact, the SMBIOS writing
>> >> should move out of efi_loader=2E The install_smbios_table() function
>> >> should be somewhere in lib, i suppose, with just efi_smbios_register=
()
>> >> sitting in lib/efi_loader
>> >>
>> >> Also, why is efi_memory_init() called early in init? Is there anythi=
ng
>> >> that needs that in the init sequence? Could we move it to the end, o=
r
>> >> perhaps skip it completely until the 'bootefi' command is used?
>> >>
>> >> Another point I should make is that it should be fine for U-Boot to
>> >> put something in memory and then call efi_add_memory_map() to tell E=
FI
>> >> about it=2E What problems does that cause? It isn't as if EFI alloca=
tes
>> >> things in the 'conventional' memory (is that the name for memory bel=
ow
>> >> 4GB?) This is how efi_acpi_register() works=2E
>> >>
>> >> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
>> >> drivers/video/rockchip_rk_vop=2Ec and other such files)
>> >>
>> >> >
>> >> > >
>> >> > > The bit I am confused about is that we don't support SMBIOS3 in
>> >> > > U-Boot=2E I am trying to fix an introduced bug=2E=2E=2E
>> >> >
>> >> > I would not know why we should not use SMBIOS 3=2E
>> >>
>> >> Neither do I=2E Perhaps there are compatibility concerns? If it is O=
K to
>> >> do that then we could go back to my previous series [1]=2E What do y=
ou
>> >> think?
>> >
>> >Tom responded but I missed it=2E In part it says:
>> >
>> >"So, can we please start by just doing the minimal changes to get the
>> >SMBIOS table done correctly for memory above 4G, via EFI, and then sta=
rt
>> >the next steps?"
>> >
>> >I am OK to do an EFI hack for ARM so long as we agree that after the
>> >release we will revert it and generate the table using generic memory
>> >allocation, not dependent on EFI=2E Does that sound reasonable?
>> >
>> >I don't seem to have received any response from Heinrich to the
>> >various points I made above=2E I cannot see any response on patchwork
>> >either=2E
>> >
>> >Regards,
>> >Simon
>>
>> All memory below the stack is controlled by the EFI subsystem=2E I noti=
fied you of the function you need to call=2E I can't see what information y=
ou are lacking=2E
>
>That is fine when EFI is used, but what about when it is not? That is
>the piece I don't yet understand=2E

If CONFIG_EFI_LOADER=3Dy and booting via booti,  it does not harm to have =
added the SMBIOS table to the EFI memory map which will be ignored=2E When =
booting via bootefi you will have a correct memory map=2E

If CONFIG_EFI_LOADER=3Dn, you are free with the placement of SMBIOS=2E

Best regards

Heinrich

>
>Regards,
>Simon
