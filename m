Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4162D68B37
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 16:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAADD89082;
	Thu, 14 Nov 2024 17:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VIIZEui3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231CD89072; Thu, 14 Nov 2024 17:34:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B60D289639
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 17:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731602036; x=1732206836; i=xypron.glpk@gmx.de;
 bh=LzucFwjA8LEOdrzIBZrpZlcpqtAmScIz5O6xArWAAgI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VIIZEui3m0BjA1+aBT6qGw9BeZDW3hBIUl/fFQlk5Y7n/RvrGrheFtk4jz+xPl+J
 JcNpFgSidg8I2yjO0BBWAgnYHV9pXPbbQhK5oj0I+H0yzOlqAvNBuAIdEKRj7hHhW
 Ru8G30fuWTcn4IOX3FEfhiMWJCvvLYL+DigSS5PegQnNNHgoGscYEnmmzjOfuttyC
 WffY2uUM/vWuhR4i5Hugz2HRT+qntgYXINPJ9rf35NE+WOk2vUtHr7+4DXp3s02jP
 mjYI8tY2eFVP+QczQ6DJfRP0yo3LFs2orBmEbE7ygNF+aGEM6Cd0qwginwF1e+Kjj
 wDU9U3yblpkHRMhqqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1tvj5c4AzT-010OPD; Thu, 14
 Nov 2024 17:33:56 +0100
Message-ID: <8bf6fedd-3219-4bb7-9589-fa7647122a82@gmx.de>
Date: Thu, 14 Nov 2024 17:33:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] efi_loader: efi http and ipconfig drivers
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, =?UTF-8?Q?Adriano_C=C3=B3rdova?=
 <adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
 <CAC_iWjJ4LjTopsPuVk2za+eetVUZ-2Mofe-PGOgKv49XkJ71Kg@mail.gmail.com>
 <CAMGU2hVpw=AX7fvbtwztuiZ8TqXvb21JpKZ4m6QCNzMnHdss_w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAMGU2hVpw=AX7fvbtwztuiZ8TqXvb21JpKZ4m6QCNzMnHdss_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JueKJsnWclHcJYlipHvqrmFZFKwx9/B28lEXN5teq3TkXgTTi/W
 NqEp/DMM2FCWmY7Wj1CHMx09S0Z4s/J3oq0cP8AX3p1xICIr/h2as9jW/XAW6r64E/dFkl7
 CUlBcITybCe+YftD4dv4Ti3A24O9HOpzO36GIUj3FG519P98hgRgZU8tViCQ+L3R2T7r5WR
 TsbKnQroME1KonqKX/wTA==
UI-OutboundReport: notjunk:1;M01:P0:KGoD4GfV/KU=;yabjsihgjdcrGYRfGnKx3Opa1H9
 XKmfzGLzLssoKo1eSAB3CLEsl+BCdpX+qKEccMPD7SDZr8IL8EjB/P8at23MfEoC86x70MNBT
 R1xKHv/8Vq/VeP5oOEevXeHvHIPyuUxOhLbv+qQH1II2hWqDh99xSeaq45I1YVRMYVliD++uH
 NVK3DdvKKC0hjAlo3SIawB+0J3WkmPUSKGOBn6j2slafV2Qndo635ETTsalMulsqK9rhbGney
 CdbDP5Sxd7My9b4RC22obiMKYsakQFRg5xZFQBTN0M9Ra3zQ4w6crFetPRvHSUq3FfNdG8PW1
 DDM/yOVABCLReAfTOXutzkFIJ8mlmmfr4BIrrMA0bp1xOwc+6xNh8xvCpAI8D27US2ilc76lB
 VS7paA+zR8FbTGxU4y0VTMjflT8j/bgsiLuE4E2cFofLrCMBTeARXnYDXvR/E66Oda838/4r3
 tne6IwmBsDCs0eVxi1A4VTt5THiJVIrVw5wgLnNkKC4gYR+LYIyVscH4w/YGs1wRGmgrfxmRt
 2YEaWsJ02WhICSh8zOTfjFRteANYQ1z8QWKbJzuychGFLqTbagX14/jjxqeIREqUuTM4XVwoZ
 ew0wTMGsl62oDMr1D7Su481wLfx0lD4GEabPa2ZXkWuFKZCGIIALYcmqIkyB3efKA8NbfOS9E
 jFMKd1fyFsbn2KWyRZeQIW6Dh1IbOt79PvNanCSXj9ceG1gFx37XqSHcw324zPZE1ihs/B23K
 MuMlTm7Ky7094jOpp3R1GpzY93zrn45buGbBuFrP2y9lbJiH44C7LPi3kLXbfJrybF4rF+bgF
 kQdH+BsvTxat+tIsq9XLMWyXwOFUaetLF1RNiSXypT9Lu54RJcIZtktCpBHX7NlYfujHoFaRl
 b9ji0EmX+kLdmdovDdqKgylwFOmyGViX6iOhzzC2fxgA2CV5tBJ2mFBVQ
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

On 11/14/24 17:16, Adriano C=C3=B3rdova wrote:
> Hi Ilias,
> I have been testing with grub, and with the efi selftest. Here are the
> steps to test with a riscv grub:
>
> 1. Get grubriscv64.efi from e.g. the following .deb package
> wget http://launchpadlibrarian.net/754414418/grub-efi-riscv64-
> unsigned_2.12-5ubuntu5.1_riscv64.deb <http://
> launchpadlibrarian.net/754414418/grub-efi-riscv64-
> unsigned_2.12-5ubuntu5.1_riscv64.deb>

If you are on Debian or Ubuntu you can use

dpkg -x grub-efi-riscv64-unsigned_2.12-5ubuntu5.1_riscv64.deb target_dir

for extraction.

On other distros

ar -x grub-efi-riscv64-unsigned_2.12-5ubuntu5.1_riscv64.deb
mkdir -p target_dir
tar --zstd -xf data.tar.zst -C target_dir

target_dir/usr/lib/grub/riscv64-efi/monolithic/grubnetriscv64.efi
is the file I am using. That one has all the network modules included.

Best regards

Heinrich

>
> 2. Compile U-boot with qemu-riscv64_smode_defconfig. Enable CMD_WGET.
>
> 3. Create a tap interface:
> $ sudo ip tuntap add dev tap0 mode tap
> $ sudo ip addr add 10.0.0.0/24 <http://10.0.0.0/24>=C2=A0dev tap0
> $ sudo ip link set dev tap0 up
>
> 4. Start an http server in a directory containing grubriscv64.efi and a
> test file (e.g. a riscv kernel)
> $=C2=A0=C2=A0sudo python3 -m http.server 80 --bind 10.0.0.0
>
> 5. Launch U-boot:
> $ qemu-system-riscv64 \
>  =C2=A0 =C2=A0 -machine virt \
>  =C2=A0 =C2=A0 -nographic \
>  =C2=A0 =C2=A0 -kernel u-boot \
>  =C2=A0 =C2=A0 -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3Dno,downscrip=
t=3Dno \
>  =C2=A0 =C2=A0 -device virtio-net-device,netdev=3Dnet0
>
> 6. Inside U-boot's console
> =3D> setenv ipaddr 10.0.0.1
> =3D> setenv netmask 255.255.255.0
> =3D> wget 10.0.0.0:80/grubriscv64.efi <http://10.0.0.0/grubriscv64.efi>
> =3D> bootefi=C2=A0$loadaddr
>
> 7. Print debug, check address and installed protocols (optional):
> grub> set debug=3D"peimage,net"
> grub> net_ls_addr
> grub> lsefi
>
> 8. Download a test file, e.g. a kernel, through http (here Image is a
> riscv linux kernel):
> grub> linux (http,10.0.0.0:80)/Image
>
> 9. Try boot it:
> grub> boot
>
> Best,
> Adriano
>
> El jue, 14 nov 2024 a las 12:22, Ilias Apalodimas
> (<ilias.apalodimas@linaro.org <mailto:ilias.apalodimas@linaro.org>>)
> escribi=C3=B3:
>
>     Hi Adriano,
>
>     On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com
>     <mailto:adrianox@gmail.com>> wrote:
>
>         Add support for EFI_HTTP_PROTOCOL,
>         EFI_HTTP_SERVICE_BINDING_PROTOCOL,
>         and EFI_IP4_CONFIG2_PROTOCOL.
>
>         This series depends on the series 'wget: Expose wget to
>         applications',
>         also found at:
>         https://github.com/0n41rd4/u-boot/commits/http-driver-wget
>         <https://github.com/0n41rd4/u-boot/commits/http-driver-wget>
>
>         The fist two patches of this series are not efi specific and
>         have also
>         been sent to the corresponding maintainers, but this series
>         depends on
>         them, so they are added here for redundancy. A branch with both
>         series
>         of patches, concatenated, is at:
>         https://github.com/0n41rd4/u-boot/commits/efi-http-driver
>         <https://github.com/0n41rd4/u-boot/commits/efi-http-driver>
>
>
>     It would help a lot if we had pointers (or an EFI app) using this
>     protocol to test. Are you using any of that for devel/debugging?
>
>     Thanks
>     /Ilias
>
>
>
>         Adriano Cordova (13):
>          =C2=A0 net: net_utils: Move ip_to_string to lib/net_utils.c
>          =C2=A0 net: wget: let wget_with_dns work with dns disabled
>          =C2=A0 efi_loader: device_path: add definition of
>          =C2=A0 =C2=A0 DEVICE_PATH_SUB_TYPE_MSG_IPV4
>          =C2=A0 efi_loader: device_path: add efi_dp_from_ipv4
>          =C2=A0 efi_api: add definitions for HTTP and IP4_CONFIG2 protoc=
ols
>          =C2=A0 efi_loader: efi_net: add efi_net_set_addr, efi_net_get_a=
ddr
>          =C2=A0 efi_loader: device_path: add support for HTTP device pat=
h
>          =C2=A0 efi_loader: net: set EFI bootdevice device path to HTTP =
when
>         loaded
>          =C2=A0 =C2=A0 from wget
>          =C2=A0 efi_loader: net: add support to send http requests and p=
arse http
>          =C2=A0 =C2=A0 headers
>          =C2=A0 efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
>          =C2=A0 efi_loader: efi_net: add EFI_HTTP_PROTOCOL
>          =C2=A0 efi_selftest: add test for HTTP protocol
>          =C2=A0 efi_selftest: add test for IPv4 Config2 protocol
>
>         Heinrich Schuchardt (2):
>          =C2=A0 efi_loader: add IPv4() to device path to text protocol
>          =C2=A0 lib: uuid: display HTTP and IPV4 Config II protocols
>
>          =C2=A0include/efi_api.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 220 +++++++++
>          =C2=A0include/efi_loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 42 ++
>          =C2=A0include/net-common.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +
>          =C2=A0lib/efi_loader/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +
>          =C2=A0lib/efi_loader/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +
>          =C2=A0lib/efi_loader/efi_device_path.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 95 +++-
>          =C2=A0lib/efi_loader/efi_device_path_to_text.c |=C2=A0 23 +
>          =C2=A0lib/efi_loader/efi_http.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 563 +++++++++++++++
>         ++++++++
>          =C2=A0lib/efi_loader/efi_ipconfig.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 216 +++++++++
>          =C2=A0lib/efi_loader/efi_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 316 ++++++++++++-
>          =C2=A0lib/efi_selftest/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +
>          =C2=A0lib/efi_selftest/efi_selftest_http.c=C2=A0 =C2=A0 =C2=A0|=
 315 +++++++++++++
>          =C2=A0lib/efi_selftest/efi_selftest_ipconfig.c | 173 +++++++
>          =C2=A0lib/net_utils.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +
>          =C2=A0lib/uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
14 +
>          =C2=A0net/lwip/wget.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +
>          =C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11=
 -
>          =C2=A0net/wget.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
39 +-
>          =C2=A018 files changed, 2038 insertions(+), 32 deletions(-)
>          =C2=A0create mode 100644 lib/efi_loader/efi_http.c
>          =C2=A0create mode 100644 lib/efi_loader/efi_ipconfig.c
>          =C2=A0create mode 100644 lib/efi_selftest/efi_selftest_http.c
>          =C2=A0create mode 100644 lib/efi_selftest/efi_selftest_ipconfig=
.c
>
>         --
>         2.43.0
>

