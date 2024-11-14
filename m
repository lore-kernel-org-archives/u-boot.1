Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D0AD68B34
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 16:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C1A88E26;
	Thu, 14 Nov 2024 17:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R7tu7YQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D939B88F70; Thu, 14 Nov 2024 17:16:49 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AA288D70
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 17:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so727105a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731601005; x=1732205805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6m6yCkk1y/nKYyyAeCekNgB6EDFzQJNZxY1/u3D3E0=;
 b=R7tu7YQjIIPMhHLHSvUNV0k1Ay84ZBn5hepS0rjEcMFNs7mR2XZFH09+umpRc249zl
 Dgx8L23InKDVfAu1zSs5UwFNYIOpPyEeXyoCBWI82l8QDigktI7JkqSQ5TXFiIDpSWls
 oScYPGkxC2AcCpWLcs3WC2TL6wqEf/X17YL+wo0m3knJ5UlB7yPr01OEUXhSI6I25fCc
 Gw7zxcmSFf9nyi31FyNqOhlyXxam3LvS0KMMx6xlFQHILGrifHcL8Sthxn7y/+57R3Uc
 eoqGnr8YWt7dX5BP6IkYKLfv4hmF6KvXjly7o5EgjsJmN+jH7dOy8tGLJ4KA2d5yFWJX
 1jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731601005; x=1732205805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6m6yCkk1y/nKYyyAeCekNgB6EDFzQJNZxY1/u3D3E0=;
 b=FvpAA537lecQhozw+IvcoxSvtNWSu6a2v3pgA/hZogw7fDiCCYCp546taslgqo7vQG
 OGOZG6nNSBIsyqAXrp4YVFobGZrA9JZrM0sKHE8kWv+ypborbNtTfpiDaJlgUhNtdKWH
 LEdQKOLeoXcihQDu/3Ijnr0UnESpSOXlnCl1BrQ9w1T+sGAGwsBlHfCT3QlRWkHO0tAL
 XYKFuHK0DDAuZnpnO9dKQz0pGdpwSQOsCqOg3xyZz2tDdZAOi4Zse7wO8j+A+3nNIDVB
 Xi07vKGffeGXYs0lhd/nA1UYLfpKDyoomIiHzPZcgKp4L6p13dhjR7ljq1q3oZaWZ1N1
 TflA==
X-Gm-Message-State: AOJu0YzY6NQsucoBBRHjRS/WnlYj11/GNTHdiG2DBZyGVS/66gvBhDkG
 Yat3s/MEjbuSOh7cBVeVt6wxljrIXsUg2y/P0S0y5AaWCrp2faiBrU3ooqhfCKkpx8n2NqoTefy
 zCtJ/dAoWyC78NcC++bcolsIKLpc=
X-Google-Smtp-Source: AGHT+IH03IFbiQNmzhlqpmBcWl2iq78tJv5tns0SfBZ0HIDvVy2Vag7tiYarlC1dPV6712K8QiYjMsO+NQRXnkXpvx8=
X-Received: by 2002:a17:90b:2d8c:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2ea0636f777mr3666500a91.12.1731601005420; Thu, 14 Nov 2024
 08:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <CAC_iWjJ4LjTopsPuVk2za+eetVUZ-2Mofe-PGOgKv49XkJ71Kg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ4LjTopsPuVk2za+eetVUZ-2Mofe-PGOgKv49XkJ71Kg@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Thu, 14 Nov 2024 13:16:34 -0300
Message-ID: <CAMGU2hVpw=AX7fvbtwztuiZ8TqXvb21JpKZ4m6QCNzMnHdss_w@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] efi_loader: efi http and ipconfig drivers
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,
I have been testing with grub, and with the efi selftest. Here are the
steps to test with a riscv grub:

1. Get grubriscv64.efi from e.g. the following .deb package
wget
http://launchpadlibrarian.net/754414418/grub-efi-riscv64-unsigned_2.12-5ubu=
ntu5.1_riscv64.deb

2. Compile U-boot with qemu-riscv64_smode_defconfig. Enable CMD_WGET.

3. Create a tap interface:
$ sudo ip tuntap add dev tap0 mode tap
$ sudo ip addr add 10.0.0.0/24 dev tap0
$ sudo ip link set dev tap0 up

4. Start an http server in a directory containing grubriscv64.efi and a
test file (e.g. a riscv kernel)
$  sudo python3 -m http.server 80 --bind 10.0.0.0

5. Launch U-boot:
$ qemu-system-riscv64 \
    -machine virt \
    -nographic \
    -kernel u-boot \
    -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno \
    -device virtio-net-device,netdev=3Dnet0

6. Inside U-boot's console
=3D> setenv ipaddr 10.0.0.1
=3D> setenv netmask 255.255.255.0
=3D> wget 10.0.0.0:80/grubriscv64.efi <http://10.0.0.0/grubriscv64.efi>
=3D> bootefi $loadaddr

7. Print debug, check address and installed protocols (optional):
grub> set debug=3D"peimage,net"
grub> net_ls_addr
grub> lsefi

8. Download a test file, e.g. a kernel, through http (here Image is a riscv
linux kernel):
grub> linux (http,10.0.0.0:80)/Image

9. Try boot it:
grub> boot

Best,
Adriano

El jue, 14 nov 2024 a las 12:22, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano,
>
> On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
>> Add support for EFI_HTTP_PROTOCOL, EFI_HTTP_SERVICE_BINDING_PROTOCOL,
>> and EFI_IP4_CONFIG2_PROTOCOL.
>>
>> This series depends on the series 'wget: Expose wget to applications',
>> also found at:
>> https://github.com/0n41rd4/u-boot/commits/http-driver-wget
>>
>> The fist two patches of this series are not efi specific and have also
>> been sent to the corresponding maintainers, but this series depends on
>> them, so they are added here for redundancy. A branch with both series
>> of patches, concatenated, is at:
>> https://github.com/0n41rd4/u-boot/commits/efi-http-driver
>
>
> It would help a lot if we had pointers (or an EFI app) using this protoco=
l
> to test. Are you using any of that for devel/debugging?
>
> Thanks
> /Ilias
>
>>
>>
>> Adriano Cordova (13):
>>   net: net_utils: Move ip_to_string to lib/net_utils.c
>>   net: wget: let wget_with_dns work with dns disabled
>>   efi_loader: device_path: add definition of
>>     DEVICE_PATH_SUB_TYPE_MSG_IPV4
>>   efi_loader: device_path: add efi_dp_from_ipv4
>>   efi_api: add definitions for HTTP and IP4_CONFIG2 protocols
>>   efi_loader: efi_net: add efi_net_set_addr, efi_net_get_addr
>>   efi_loader: device_path: add support for HTTP device path
>>   efi_loader: net: set EFI bootdevice device path to HTTP when loaded
>>     from wget
>>   efi_loader: net: add support to send http requests and parse http
>>     headers
>>   efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
>>   efi_loader: efi_net: add EFI_HTTP_PROTOCOL
>>   efi_selftest: add test for HTTP protocol
>>   efi_selftest: add test for IPv4 Config2 protocol
>>
>> Heinrich Schuchardt (2):
>>   efi_loader: add IPv4() to device path to text protocol
>>   lib: uuid: display HTTP and IPV4 Config II protocols
>>
>>  include/efi_api.h                        | 220 +++++++++
>>  include/efi_loader.h                     |  42 ++
>>  include/net-common.h                     |  10 +
>>  lib/efi_loader/Kconfig                   |  17 +
>>  lib/efi_loader/Makefile                  |   2 +
>>  lib/efi_loader/efi_device_path.c         |  95 +++-
>>  lib/efi_loader/efi_device_path_to_text.c |  23 +
>>  lib/efi_loader/efi_http.c                | 563 +++++++++++++++++++++++
>>  lib/efi_loader/efi_ipconfig.c            | 216 +++++++++
>>  lib/efi_loader/efi_net.c                 | 316 ++++++++++++-
>>  lib/efi_selftest/Makefile                |   2 +
>>  lib/efi_selftest/efi_selftest_http.c     | 315 +++++++++++++
>>  lib/efi_selftest/efi_selftest_ipconfig.c | 173 +++++++
>>  lib/net_utils.c                          |  11 +
>>  lib/uuid.c                               |  14 +
>>  net/lwip/wget.c                          |   1 +
>>  net/net.c                                |  11 -
>>  net/wget.c                               |  39 +-
>>  18 files changed, 2038 insertions(+), 32 deletions(-)
>>  create mode 100644 lib/efi_loader/efi_http.c
>>  create mode 100644 lib/efi_loader/efi_ipconfig.c
>>  create mode 100644 lib/efi_selftest/efi_selftest_http.c
>>  create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c
>>
>> --
>> 2.43.0
>>
>>
