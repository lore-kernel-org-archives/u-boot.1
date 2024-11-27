Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03C3D6ACEF
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 15:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE101896FC;
	Wed, 27 Nov 2024 16:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="byby3tIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531B7897CC; Wed, 27 Nov 2024 16:59:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C488907E
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 16:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732723182; x=1733327982; i=xypron.glpk@gmx.de;
 bh=XipHXFQZ6YD+XU6maQRoQqhcg1BcuzNwvSYGOFO+6Ig=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=byby3tIfklbawN2pR5pR/VxZNALEr/JNKORHg5WYfqlBNr774NerkEZvKXB/OCEE
 nlVvl/Jwao2LclnVSkbwFHye6AKwcDHgocQ6dBlHBjcBA9X4TFdal24OkZ/jCeYjF
 Gx314nxIFRy/2+GzIiDR95LKmC8ZVx7XoVUZNK9HUNyO+ojPYzizwDMyTZ3Vz9UHB
 3PBkO/7Gp3J1fenawgOFtlaox1Zrjg6xO9DpI4rNj0RANetRZKF1+fGoCTwi402+9
 TPdlCrdYlV9xXI8+N/+lr1zKyoX/a5uwF7lrYSHYHRH76Erg1epQ588BQ1T7/WjIa
 4ekTnEb98EWmJsENyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1tPA8k2Q3E-0058Hv; Wed, 27
 Nov 2024 16:59:42 +0100
Message-ID: <0047bc9f-b6e8-4afd-a1b7-cfc0c8d8e73e@gmx.de>
Date: Wed, 27 Nov 2024 16:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 E Shattow <lucent@gmail.com>
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
 <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
 <CANV2PTNdcc61CUTF9_zammmAugjVQOth=UFPiZv3=Qw_YX5RkA@mail.gmail.com>
 <CADg8p97RHvZG23fE8grvE5DzScT+okV-6qSHv_gQUiwggKDtJQ@mail.gmail.com>
 <CANV2PTP-17Z-MUa8-3mcAHduxzPqb6VN-ZKZS31XkwQ-2X1+8A@mail.gmail.com>
 <CADg8p97vUaELMimYc52bT6uVpqnLJWWfYPRJj=rJ6QDUcn8iEg@mail.gmail.com>
 <b3279988-ddda-423f-8caf-3fa5e4192fcb@gmx.de>
 <CANV2PTM55_Fb4_=0sGoZ1XQo89X9_UdH3tNWp=ZcT0KSY9o+kA@mail.gmail.com>
 <CANV2PTNmj4nxShO3tspheDSXohw212yj0unJtzokLHPxoOch0g@mail.gmail.com>
 <CADg8p94M5vNY8jo2Xm83ffgt9WW0Zy=Jba6DD=sz4sf_hUKk-A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p94M5vNY8jo2Xm83ffgt9WW0Zy=Jba6DD=sz4sf_hUKk-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Voy9LM+UOgMoesyd1BNn0CrxEW/P+i4Dti48SM4x6eJCUEFYoEa
 1pZEO22SuqM/Gj+2i/XKetinh6GjBhf+2k5X+sx805T1rZT/4I2VrD0hRceUIsX/QMXeIFF
 ce+B0rBFVijCwMO2O1ZaIRp24yB3JchVNVoRcz4eEK0YX0d+kylrmigY+gX/Hrv5jUVHpN6
 HG8Of+YA08xcmwIye4eCg==
UI-OutboundReport: notjunk:1;M01:P0:LOPLdC1zLes=;SHLKkr7c56GZrmfv1Onrv0fHrak
 VXneUhFDd2xhtuHNizmBri3D9EUTr48DajG2LYPaoktPpn/wZx8p/I7kNyi2fVK1pN8lkDGEE
 S647VRB13SRem8qrVSIvYqRBtLKh2qw/IjlTqDFORnn8imT1gWkTbzGXN4ZwSvWZFDGukOXim
 LiLr7SbWVfqq7hLKQMvYmPHB1JE7/Etg1nzylrev3j/Pokvu2yqOihoAK+t+Pa8sFT/ciHoRc
 UZcFIvVzLD245MAi+uba1XYYqtQsUZS81h0+hnceKnRDtFne9mmvYkDIE4cHaVNLlGYz9xC3B
 P0A+04eyfL9MiY0kbQJgRf/LRVJ1CHBsBHFxwjZ9Fv/sqqDR1Oo94YcdVIv7QqmtFRTigoeMu
 lnSW2ZGJyNbH47+tWbDlVLFiSuRBArBs793JYEIi+X56/J3sk62ntqLxH5/Dx5G8eeSulCg2e
 EvySI8fOX4nVZNfRgoNWUSejEcj09RNzQW5mLaUj7GRFszgxK0fxk1OL2OJDtHUtvB5xIJCcs
 OsMeCT88/NdL5Ami+H2VcguEMH50oPFqgCJ6ZK8soKpU0USxYYjDKo7CNN3cKac3CwBsvzRNz
 FiTc7flVGyhbijUINo9dJhkyOsQf06pmyOIurWS1fcjKjnQH/vOGY0Lt9IsxuqHNQz9eDzGDn
 GTGDhMQ2mS18u0VWB3b7bMKO9jva5Fe1ZQ+FZnTRG5do3Rz6Zx1AQNWk/XKzSwuty7PjborFp
 lxYj/ln/wIC8TeJ2xES6f/aXE0hQNCpBetmce52yMM7aijCLfIF3SLSOfg1U5hJCHgXsMCNwo
 13bF+sGHNTAQ4NVoK/BReqzxSkYZwrK4qPA7nm33pFP2Cmb4HF8vml5uCsUzeEWFecxAhOiCU
 ukudPQhuRbjzRS4I3+8duqaxA4uq5U+2ap0xKn+N5JU5WeqNn7lxb/pH8spcgXk+Rz9G2FG72
 ip5WEPt8aksQjG0gjDMkpFBn9a5es9N9A1evLp2tPHgBNu5a9XyGbbJkijK6LnFAKIivScvht
 VGC5rZ10MSsO3gaUu/Oh7pocQ1FkjqNuY+2ZMzuo+lMWGicqwUHnFlw0l+09n3Ojxb5cVpQB9
 8sUslNR7CuM6NxRExlJs2FCofSerqtbXt7O7p4KKrnzlyUNNmpEw6r4o1LswGW71G7DmpMaSI
 =
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

On 27.11.24 16:21, Sughosh Ganu wrote:
> On Wed, 27 Nov 2024 at 19:41, E Shattow <lucent@gmail.com> wrote:
>>
>> Replying my own message postscript
>>
>> On Wed, Nov 27, 2024 at 4:47=E2=80=AFAM E Shattow <lucent@gmail.com> wr=
ote:
>>>
>>> Following up on this with some positive results:
>>>
>>> On Thu, Nov 21, 2024 at 4:22=E2=80=AFAM Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
>>>>
>>>> On 21.11.24 09:04, Sughosh Ganu wrote:
>>>>> On Wed, 20 Nov 2024 at 13:49, E Shattow <lucent@gmail.com> wrote:
>>>>>>
>>>>>> Hi all, (on-list)
>>>>>>
>>>>>> On Tue, Nov 19, 2024 at 9:14=E2=80=AFPM Sughosh Ganu <sughosh.ganu@=
linaro.org> wrote:
>>>>>>>
>>>>>>> On Wed, 20 Nov 2024 at 10:09, E Shattow <lucent@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Nov 19, 2024 at 6:42=E2=80=AFPM Sughosh Ganu <sughosh.gan=
u@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> wrote=
:
>>>>>>>>>>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> On HEAD some commits after v2024.10 I encounter a regression fo=
r
>>>>>>>>>> `bootefi bootmgr` fail with error "Not a PE-COFF file";  The fa=
ll-thru
>>>>>>>>>> case of global EFI boot is successful.
>>>>>>>>>>
>>>>>>>>>> Having run a git bisect I discover the first bad commit 22f2c9e=
d:
>>>>>>>>>>
>>>>>>>>>> $ git checkout -b master origin/master
>>>>>>>>>> branch 'master' set up to track 'origin/master'.
>>>>>>>>>> Switched to a new branch 'master'
>>>>>>>>>> $ git bisect start
>>>>>>>>>> status: waiting for both good and bad commits
>>>>>>>>>> $ git bisect bad HEAD
>>>>>>>>>> status: waiting for good commit(s), bad commit known
>>>>>>>>>> $ git bisect good v2024.10
>>>>>>>>>> Bisecting: 850 revisions left to test after this (roughly 10 st=
eps)
>>>>>>>>>> [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'stagin=
g' of
>>>>>>>>>> https://source.denx.de/u-boot/custodians/u-boot-tegra
>>>>>>>>>> $ git bisect good
>>>>>>>>>> Bisecting: 422 revisions left to test after this (roughly 9 ste=
ps)
>>>>>>>>>> [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
>>>>>>>>>> 'u-boot-rockchip-20241026' of
>>>>>>>>>> https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
>>>>>>>>>> $ git bisect bad
>>>>>>>>>> Bisecting: 214 revisions left to test after this (roughly 8 ste=
ps)
>>>>>>>>>> [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-b=
inman:
>>>>>>>>>> Add support for HS-SE
>>>>>>>>>> $ git bisect bad
>>>>>>>>>> Bisecting: 106 revisions left to test after this (roughly 7 ste=
ps)
>>>>>>>>>> [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow =
flashes
>>>>>>>>>> to specify MTD writesize
>>>>>>>>>> $ git bisect good
>>>>>>>>>> Bisecting: 53 revisions left to test after this (roughly 6 step=
s)
>>>>>>>>>> [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
>>>>>>>>>> bootflow_cmd_label for when DSA_SANDBOX is disabled
>>>>>>>>>> $ git bisect bad
>>>>>>>>>> Bisecting: 26 revisions left to test after this (roughly 5 step=
s)
>>>>>>>>>> [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
>>>>>>>>>> SPL_FIT_GENERATOR support
>>>>>>>>>> $ git bisect good
>>>>>>>>>> Bisecting: 13 revisions left to test after this (roughly 4 step=
s)
>>>>>>>>>> [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not a=
dd RAM
>>>>>>>>>> memory to the memory map
>>>>>>>>>> $ git bisect bad
>>>>>>>>>> Bisecting: 6 revisions left to test after this (roughly 3 steps=
)
>>>>>>>>>> [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any c=
hanges
>>>>>>>>>> to the LMB memory map
>>>>>>>>>> $ git bisect bad
>>>>>>>>>> Bisecting: 2 revisions left to test after this (roughly 2 steps=
)
>>>>>>>>>> [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to a=
llow
>>>>>>>>>> suppressing memory map change notification
>>>>>>>>>> $ git bisect good
>>>>>>>>>> Bisecting: 0 revisions left to test after this (roughly 1 step)
>>>>>>>>>> [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the=
 lmb
>>>>>>>>>> API's for allocating and freeing memory
>>>>>>>>>> $ git bisect bad
>>>>>>>>>> Bisecting: 0 revisions left to test after this (roughly 0 steps=
)
>>>>>>>>>> [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve=
 memory
>>>>>>>>>> above ram_top
>>>>>>>>>> $ git bisect good
>>>>>>>>>> 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commi=
t
>>>>>>>>>>
>>>>>>>>>> A commit is good if Star64 boots and absent the error about "No=
t a
>>>>>>>>>> PE-COFF file" (duly confirmed by eficonfig to adjust boot order
>>>>>>>>>> allowing removable media of an OS installer image on SD Card to=
 be the
>>>>>>>>>> priority, verifying that the installer runs as expected).  A co=
mmit is
>>>>>>>>>> bad if U-Boot crashes and/or has the error "Not a PE-COFF file"=
.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you post the output of the following. Thanks.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> 1) running the 'bdinfo' command
>>>>>>>>
>>>>>>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0=
800)
>>>>>>>> ...
>>>>>>>> StarFive # bdinfo
>>>>>>>> boot_params =3D 0x0000000000000000
>>>>>>>> DRAM bank   =3D 0x0000000000000000
>>>>>>>> -> start    =3D 0x0000000040000000
>>>>>>>> -> size     =3D 0x0000000100000000
>>>>>>>> flashstart  =3D 0x0000000000000000
>>>>>>>> flashsize   =3D 0x0000000000000000
>>>>>>>> flashoffset =3D 0x0000000000000000
>>>>>>>> baudrate    =3D 115200 bps
>>>>>>>> relocaddr   =3D 0x00000000fff46000
>>>>>>>> reloc off   =3D 0x00000000bfd46000
>>>>>>>> Build       =3D 64-bit
>>>>>>>> current eth =3D ethernet@16030000
>>>>>>>> ethaddr     =3D 6c:cf:39:00:75:63
>>>>>>>> IP addr     =3D <NULL>
>>>>>>>> fdt_blob    =3D 0x00000000ff72da20
>>>>>>>> lmb_dump_all:
>>>>>>>>    memory.count =3D 0x1
>>>>>>>>    memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes fla=
gs: none
>>>>>>>>    reserved.count =3D 0x2
>>>>>>>>    reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags=
: no-map
>>>>>>>>    reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags=
: no-overwrite
>>>>>>>> devicetree  =3D board
>>>>>>>> serial addr =3D 0x0000000010000000
>>>>>>>>    width      =3D 0x0000000000000004
>>>>>>>>    shift      =3D 0x0000000000000002
>>>>>>>>    offset     =3D 0x0000000000000000
>>>>>>>>    clock      =3D 0x00000000016e3600
>>>>>>>> boot hart   =3D 0x0000000000000001
>>>>>>>> firmware fdt=3D 0x0000000042200000
>>>>>>>>
>>>>>>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:5=
5 -0800)
>>>>>>>> ...
>>>>>>>> StarFive # bdinfo
>>>>>>>> boot_params =3D 0x0000000000000000
>>>>>>>> DRAM bank   =3D 0x0000000000000000
>>>>>>>> -> start    =3D 0x0000000040000000
>>>>>>>> -> size     =3D 0x0000000100000000
>>>>>>>> flashstart  =3D 0x0000000000000000
>>>>>>>> flashsize   =3D 0x0000000000000000
>>>>>>>> flashoffset =3D 0x0000000000000000
>>>>>>>> baudrate    =3D 115200 bps
>>>>>>>> relocaddr   =3D 0x00000000fff46000
>>>>>>>> reloc off   =3D 0x00000000bfd46000
>>>>>>>> Build       =3D 64-bit
>>>>>>>> current eth =3D ethernet@16030000
>>>>>>>> ethaddr     =3D 6c:cf:39:00:75:63
>>>>>>>> IP addr     =3D <NULL>
>>>>>>>> fdt_blob    =3D 0x00000000ff72da10
>>>>>>>> lmb_dump_all:
>>>>>>>>    memory.count =3D 0x1
>>>>>>>>    memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, fl=
ags: none
>>>>>>>>    reserved.count =3D 0x3
>>>>>>>>    reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: =
no-map
>>>>>>>>    reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags=
: no-overwrite
>>>>>>>>    reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
>>>>>>>> no-notify, no-overwrite
>>>>>>>> devicetree  =3D board
>>>>>>>> serial addr =3D 0x0000000010000000
>>>>>>>>    width      =3D 0x0000000000000004
>>>>>>>>    shift      =3D 0x0000000000000002
>>>>>>>>    offset     =3D 0x0000000000000000
>>>>>>>>    clock      =3D 0x00000000016e3600
>>>>>>>> boot hart   =3D 0x0000000000000001
>>>>>>>> firmware fdt=3D 0x0000000042200000
>>>>>>>>
>>>>>>>> Differences in bdinfo output between working (parent of the
>>>>>>>> regression) and non-working (origin/master) version:
>>>>>>>>
>>>>>>>> -fdt_blob    =3D 0x00000000ff72da20
>>>>>>>> +fdt_blob    =3D 0x00000000ff72da10
>>>>>>>>    lmb_dump_all:
>>>>>>>>     memory.count =3D 0x1
>>>>>>>> - memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flag=
s: none
>>>>>>>> - reserved.count =3D 0x2
>>>>>>>> - reserved[0]    [0x40000000-0x4005ffff], 0x00060000 bytes flags:=
 no-map
>>>>>>>> - reserved[1]    [0xfe729630-0xffffffff], 0x018d69d0 bytes flags:=
 no-overwrite
>>>>>>>> + memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes, fla=
gs: none
>>>>>>>> + reserved.count =3D 0x3
>>>>>>>> + reserved[0]    [0x40000000-0x4005ffff], 0x60000 bytes, flags: n=
o-map
>>>>>>>> + reserved[1]    [0xfe72d620-0xffffffff], 0x18d29e0 bytes, flags:=
 no-overwrite
>>>>>>>> + reserved[2]    [0x13fffb000-0x13fffffff], 0x5000 bytes, flags:
>>>>>>>> no-notify, no-overwrite
>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2) do you get any errors when running the 'bootefi bootmgr' comm=
and
>>>>>>>>> other than what you mention above
>>>>>>>>>
>>>>>>>>
>>>>>>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0=
800)
>>>>>>>> ...
>>>>>>>> StarFive # bootefi bootmgr
>>>>>>>> Booting: mmc 0
>>>>>>>> error: no suitable video mode found.
>>>>>>>>
>>>>>>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:5=
5 -0800)
>>>>>>>> ...
>>>>>>>> StarFive # bootefi bootmgr
>>>>>>>> Card did not respond to voltage select! : -110
>>>>>>>> Not a PE-COFF file
>>>>>>>> Loading Boot0000 'mmc 0' failed
>>>>>>>> Loading Boot0001 'nvme 0' failed
>>>>>>>> EFI boot manager: Cannot load any image
>>>>>>>>
>>>>>>>>> 3) What exactly do you mean by "global EFI boot is successful"
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't know what the correct name of it is. EFI can boot with wh=
at I
>>>>>>>> am labeling as global EFI boot and searching for fixed path names=
 (?),
>>>>>>>> or I guess it can decide from EFI variables what to do which I
>>>>>>>> consider to be the user-configured EFI boot. One of these (the
>>>>>>>> user-configured EFI boot) is broken since the regression.
>>>>>>>>
>>>>>>>> U-Boot SPL 2024.10-00989-geb052cbb896f (Nov 19 2024 - 14:39:43 -0=
800)
>>>>>>>> ...
>>>>>>>> Card did not respond to voltage select! : -110
>>>>>>>> Failed to load EFI variables
>>>>>>>> ** Booting bootflow '<NULL>' with efi_mgr
>>>>>>>> Booting: mmc 0
>>>>>>>> error: no suitable video mode found.
>>>>>>>>
>>>>>>>> U-Boot SPL 2025.01-rc2-00129-g7fe55182d926 (Nov 19 2024 - 19:56:5=
5 -0800)
>>>>>>>> ...
>>>>>>>> Card did not respond to voltage select! : -110
>>>>>>>> Failed to load EFI variables
>>>>>>>> ** Booting bootflow '<NULL>' with efi_mgr
>>>>>>>> Not a PE-COFF file
>>>>>>>> Loading Boot0000 'mmc 0' failed
>>>>>>>> Loading Boot0001 'nvme 0' failed
>>>>>>>> EFI boot manager: Cannot load any image
>>>>>>>> Boot failed (err=3D-14)
>>>>>>>> ** Booting bootflow 'mmc@16010000.bootdev.part_1' with efi
>>>>>>>> Booting /\EFI\BOOT\BOOTRISCV64.EFI
>>>>>>>> error: no suitable video mode found.
>>>>>>>
>>>>>>> Based on the logs above, it seems like you are booting using the
>>>>>>> bootmeth efi_mgr? If so, can you try disabling the bootstd config.=
 I
>>>>>>> might be wrong, but I remember some issues with the bootstd efi_mg=
r
>>>>>>> method on some other platform. Also, are you available on irc?
>>>>>>>
>>>>>>> -sughosh
>>>>>>>
>>>>>>>>> -sughosh
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> For context, the Star64 eMMC contains here an installed Debian =
Linux
>>>>>>>>>> OS in the usual way with Grub2 EFI on the EFI System Partition =
there,
>>>>>>>>>> and that image boots fine from U-Boot v2024.10 also when loaded=
 into
>>>>>>>>>> memory and using 'bootefi' directly on that memory address.
>>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> -E Shattow
>>>>>>
>>>>>> Confirming that some discussion about this happened off-list with a
>>>>>> positive result and now awaiting a fix.
>>>>>
>>>>> I tried to reproduce this issue on the qemu arm64 virt platform, wit=
h
>>>>> 4GB of DRAM memory starting from 0x4000_0000 - 0x1_4000_0000. This i=
s
>>>>> the exact same memory map for DRAM memory as on your board. I also
>>>>> modified the value of ram_top to 4GB, as on your board. But I am
>>>>> unable to hit this on the qemu arm64 platform when I try to boot the
>>>>> Debian image with 'bootefi bootmgr' command. The only difference tha=
t
>>>>> I see is that on the qemu emulator, the OS is on a virtio disk, as
>>>>> against mmc in your case. So I think we should try to get to the roo=
t
>>>>> cause of this. I think you mentioned on irc yesterday that you obser=
ve
>>>>> this on two boards, so there is definitely something going on here.
>>>>>
>>>>> -sughosh
>>>>>
>>>>>>
>>>>>> Thanks very much!  -E
>>>>
>>>> Hello Eric,
>>>>
>>>> I reproduced the issue you had with the Debian installer on a Pine64
>>>> Star64 with 8 GiB.
>>>>
>>>> try_load_from_media: file_path =3D
>>>> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e=
61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/SD(1)/SD(1)
>>>> no file name present, try default file
>>>> try_load_from_media: final_dp =3D
>>>> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e=
61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/SD(1)/SD(1)/HD(2,0x0=
1,0,0x1da800,0x1000)/\EFI\BOOT\BOOTRISCV64.EFI
>>>> efi_load_image_from_file: buffer 0x23feab000, size 0x11d000
>>>> efi_load_pe: efi 0x000000023feab000, size 0x11d000
>>>> Not a PE-COFF file
>>>> Loading Boot0000 'mmc 1' failed
>>>> EFI boot manager: Cannot load any image
>>>> Boot failed (err=3D-14)
>>>> Card did not respond to voltage select! : -110
>>>> ** Booting bootflow 'mmc@16020000.bootdev.part_2' with efi
>>>> efi_install_fdt: fdt copied to 0x000000023ffba000
>>>> Booting /\EFI\BOOT\BOOTRISCV64.EFI
>>>> efi_load_pe: efi 0x0000000040200000, size 0x11d000
>>>> error: no such device: /.disk/info.
>>>>
>>>> So loading to high memory fails though CONFIG_BOUNCE_BUFFER is enable=
d.
>>>>
>>>> With CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy booting the Debian installer
>>>> image succeeds.
>>>>
>>>> In efi_disk.c we call disk_blk_read(). But CONFIG_BOUNCE_BUFFER is on=
ly
>>>> evaluated in blk_read() same for write. This should be changed.
>>>>
>>>> CONFIG_EFI_LOADER_BOUNCE_BUFFER should not depend on an architecture.
>>>>
>>>> @Hal, @Minda
>>>> The MMC driver not supporting addresses over 4GiB, is this due to a
>>>> hardware deficiency or can that be fixed in the U-Boot driver?
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>
>>>
>>> A combination of these two series remedy this issue:
>>>
>>> "configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER"
>>> "bouncebuf: Allow allocation from U-Boot heap"
>>>
>>> Tested on 4GB Milk-V Mars CM Lite, 8GB Milk-V Mars CM Lite WiFi, 4GB
>>> Pine64 Star64.
>>>
>>> Sughosh can you please add to your series my Tested-by: E Shattow
>>> <lucent@gmail.com>
>>>
>> ...
>>>
>>> -E
>>
>> Postscript I'm getting failure when 'load mmc' a large file, but
>> success 'load mmc' a small file. Same applies for 'bootefi bootmgr'
>> whatever file access it is making.
>>
>> Okay admittedly I am frustrated and confused what is our testing
>> methodology here? I don't actually know what is broken (something
>> unspecified in an mmc driver) and what we are fixing (preventing the
>> new behavior which does not agree with the old driver - how?).
>>
>> The problem appears to be a broken mmc implementation and we are not
>> fixing that by these buffering tricks.
>
> As discussed offline, this is because you are trying to load a very
> big file, and your platform only has 8MB of heap region. And I don't
> think that loading multiple MB's of data from mmc is an unusual
> scenario. I am thinking now that the original change which I had
> shared with you would be the most appropriate solution for this.

I have not seen a distro kernel with less than 8 MiB recently.

Shouldn't the driver work in chunks?

Best regards

Heinrich
