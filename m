Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78BEEE6433
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 08:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F391863C9;
	Fri, 15 Sep 2023 10:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cNAa4Xqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6E98648D; Fri, 15 Sep 2023 10:07:53 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12A0805CB
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 10:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so29562491fa.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694765271; x=1695370071; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEO+EqKxvIAkYVTNoiZeVNK+IUxvdMce5d74RSmh8Qo=;
 b=cNAa4Xqe8qOs32vc4UACdl+OZ2m5gSX5e3DLPyapN8Ydd11kPlcJLE4RtLK8X4z1Xn
 x0LXrB1A2fGU5W0YRW+TByqUGuDUocpaipsyWnLD1gyUVpa8vE29lY6Y7Vpqde07bqtQ
 rON2GXM950v5uszHozTcgEHOuDvn4m5srda/ZU04E6b2uI8z8fP/lKfh/wooBehBAmOL
 otS2Qes3hCA2tuXFtaVjGPInjNHocKmSeUnV3feRvP0sxSvwqLWmocZ5BinIBKjvMwv7
 lgGvkcleqWje0Flr1JLTbgZJByesBXlbqzbe9ZQVIMW0+YxnttsNqCpN3ngl44DfK3/d
 XBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694765271; x=1695370071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEO+EqKxvIAkYVTNoiZeVNK+IUxvdMce5d74RSmh8Qo=;
 b=idZ7yddHnnbeuqOJHQCW2wB/kV28U5f6Q9kOKruZe5SHqPYLQCQE020PpFdWTQe2UR
 R7jrt87pgfHXhkqQvy2WsKYfJ2FRAZV4O1nkobqmmVNdnr9ns/froIDe80+o2VIbWA39
 OAaYulMS+x2XuCP3ewBp7FRfe/2SecLz+HHjKP5a+KaYK8U1yagjmcvuN4aCaQAHntfS
 3qv6LY+8WN+6bsHCXFOnjTxN1pC8SokPRTPbrsieedkgaxDY8+sqImHB+vZ09zjAFFUM
 SxJou8G1EZOicC5DcN2EdeKob6nwRtGN9uw8nwBdXdhui5sKwlgIQZT8KWPG0/WtPu76
 9F/Q==
X-Gm-Message-State: AOJu0YzOKZa1w51zpRtq/8hRooQpNGZZTTRyG6di4Rdaa12OPpMOiA/h
 zvASeaawUJtpHmE9NdaH0XnFjRSyxaeK/ehbuzncgQ==
X-Google-Smtp-Source: AGHT+IExeVEoH1QjVOet/ttaW/c3AzL9AjzE1XnODP7h2RMc2a/4WLAQlh0TVmsiwTldp2Wr/cEbgmofoIQP6odytnk=
X-Received: by 2002:a2e:8317:0:b0:2bc:eceb:6a4b with SMTP id
 a23-20020a2e8317000000b002bceceb6a4bmr834582ljh.28.1694765271058; Fri, 15 Sep
 2023 01:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Sep 2023 11:07:15 +0300
Message-ID: <CAC_iWjJnr1zo354TztezKh=ovD=UVFJ+w2CXweU1cJuFr+eOeg@mail.gmail.com>
Subject: Re: [PATCHv9 00/15] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Maxim,

On Thu, 14 Sept 2023 at 19:20, Maxim Uvarov <maxim.uvarov@linaro.org> wrote=
:
>
> changelog:
>         v9: - added first patch describing git submodule for lwip. So
>               the build procedure is:
>                 git submodule init
>                 git submodule update
>                 make
>             - reworked a little bit dhcp cmd state polling
>             - fixed review comments for v8
>         v8: - comments for previous review
>             - removed lwip timeout callback pointer
>             - made lwip timeouts works, that also allowed to remove
>               static vars.
>             - setenv for filesize tftp and wget has to be in hex.
>             - Makefile changes always compile it tftp,dns,wget,ping due
>               to it can be used not only by CONFIG_CMD_.
>             - Kconfig changes - simplify lwIP settings and support only
>               one configuration.
>             - tested with mini debian.iso load over http or tftp, mount
>               and boot it (qemu, arm64).
>         v7: - more review fixes.
>             - support of multiply eth devices, were "ethact" selects the
>               active device.
>         v6: - fixed review comments for v5 (thanks Ilias and Simon).
>         v5: - fixed Iliases comments and split big patch on the small
>                 ones.
>         v4: - tested with tests/py/ did some minor fixes (out of tree
>                 build, variables set after downloads).
>             - accounted review comments for documentation.
>             - implemented dns command
>             - corrected wget command to not use serverip variable and use=
 just
>                 url string.
>         v3: - use lwip commands for ping,tftp,wget,dhcp if this patch
>               applied. Drop CONFIG_LIB_LWIP_REPLACE_<COMMAND> option.
>             - docs: use rst variant and drop references to RFC.

Something is wrong with the current implementation and I suspect it's
partially due to callbacks.

If you spawn a qemu with '-device virtio-net-pci,netdev=3Dnet0 -netdev
tap,id=3Dnet0', assign ip addresses and try a tftp this initially works
=3D> tftp synquacer_fw.capsule
eth0: virtio-net#33 52:52:52:52:52:52 active
TFTP from server 10.10.10.2; our IP address is 10.10.10.1
Filename 'synquacer_fw.capsule'.
Load address: 0x40200000
Loading:#######################
[...]

However, if you do a ping first the output looks like this

=3D> ping 10.10.10.2
eth0: virtio-net#33 52:52:52:52:52:52 active
Using virtio-net#33 device
pinging addr: 10.10.10.2
host 10.10.10.2 a alive
 1 ms
=3D> tftp synquacer_fw.capsule
init already done for virtio-net#33
TFTP from server 10.10.10.2; our IP address is 10.10.10.1
Filename 'synquacer_fw.capsule'.
Load address: 0x40200000
Loading:ping failed; host =EF=BF=BDHi> is not alive
host 10.10.10.2 a alive
 0 ms
=3D>

Thanks
/Ilias
>
>
> Maxim Uvarov (15):
>   submodule: add lwIP as git submodule
>   net/lwip: add doc/develop/net_lwip.rst
>   net/lwip: integrate lwIP library
>   net/lwip: implement dns cmd
>   net/lwip: implement dhcp cmd
>   net/lwip: implement tftp cmd
>   net/lwip: implement wget cmd
>   net/lwip: implement ping cmd
>   net/lwip: add lwIP configuration
>   net/lwip: implement lwIP port to U-Boot
>   net/lwip: update .gitignore with lwIP
>   net/lwip: connection between cmd and lwip apps
>   net/lwip: replace original net commands with lwip
>   net/lwip: split net.h to net.h, arp.h and eth.h
>   net/lwip: drop old net/wget
>
>  .gitmodules                           |   3 +
>  boot/bootmeth_efi.c                   |  18 +-
>  boot/bootmeth_pxe.c                   |  21 +-
>  cmd/Makefile                          |   1 +
>  cmd/net-lwip.c                        | 286 +++++++++++++++++
>  cmd/net.c                             |  86 +----
>  cmd/pxe.c                             |  19 +-
>  doc/develop/index.rst                 |   1 +
>  doc/develop/net_lwip.rst              |  75 +++++
>  include/net.h                         | 197 +-----------
>  include/net/arp.h                     |   7 +
>  include/net/eth.h                     | 190 +++++++++++
>  include/net/lwip.h                    |  73 +++++
>  include/net/ulwip.h                   |  64 ++++
>  include/net/wget.h                    |  22 --
>  net/Kconfig                           |   3 +
>  net/Makefile                          |   2 +-
>  net/eth-uclass.c                      |   8 +
>  net/lwip/.gitignore                   |   8 +
>  net/lwip/Kconfig                      |  25 ++
>  net/lwip/Makefile                     |  70 ++++
>  net/lwip/apps/dhcp/lwip-dhcp.c        |  85 +++++
>  net/lwip/apps/dns/lwip-dns.c          |  63 ++++
>  net/lwip/apps/http/Makefile           |   6 +
>  net/lwip/apps/http/lwip-wget.c        | 105 ++++++
>  net/lwip/apps/ping/Makefile           |  12 +
>  net/lwip/apps/ping/lwip_ping.c        |  38 +++
>  net/lwip/apps/ping/lwip_ping.h        |  15 +
>  net/lwip/apps/ping/ping.h             |  19 ++
>  net/lwip/apps/tftp/Makefile           |   7 +
>  net/lwip/apps/tftp/lwip-tftp.c        | 129 ++++++++
>  net/lwip/lwip-external                |   1 +
>  net/lwip/lwipopts.h                   | 178 +++++++++++
>  net/lwip/port/if.c                    | 332 +++++++++++++++++++
>  net/lwip/port/include/arch/cc.h       |  38 +++
>  net/lwip/port/include/arch/sys_arch.h |  10 +
>  net/lwip/port/include/limits.h        |   0
>  net/lwip/port/sys-arch.c              |  13 +
>  net/net.c                             |  26 +-
>  net/wget.c                            | 440 --------------------------
>  40 files changed, 1938 insertions(+), 758 deletions(-)
>  create mode 100644 .gitmodules
>  create mode 100644 cmd/net-lwip.c
>  create mode 100644 doc/develop/net_lwip.rst
>  create mode 100644 include/net/arp.h
>  create mode 100644 include/net/eth.h
>  create mode 100644 include/net/lwip.h
>  create mode 100644 include/net/ulwip.h
>  delete mode 100644 include/net/wget.h
>  create mode 100644 net/lwip/.gitignore
>  create mode 100644 net/lwip/Kconfig
>  create mode 100644 net/lwip/Makefile
>  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
>  create mode 100644 net/lwip/apps/dns/lwip-dns.c
>  create mode 100644 net/lwip/apps/http/Makefile
>  create mode 100644 net/lwip/apps/http/lwip-wget.c
>  create mode 100644 net/lwip/apps/ping/Makefile
>  create mode 100644 net/lwip/apps/ping/lwip_ping.c
>  create mode 100644 net/lwip/apps/ping/lwip_ping.h
>  create mode 100644 net/lwip/apps/ping/ping.h
>  create mode 100644 net/lwip/apps/tftp/Makefile
>  create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
>  create mode 160000 net/lwip/lwip-external
>  create mode 100644 net/lwip/lwipopts.h
>  create mode 100644 net/lwip/port/if.c
>  create mode 100644 net/lwip/port/include/arch/cc.h
>  create mode 100644 net/lwip/port/include/arch/sys_arch.h
>  create mode 100644 net/lwip/port/include/limits.h
>  create mode 100644 net/lwip/port/sys-arch.c
>  delete mode 100644 net/wget.c
>
> --
> 2.30.2
>
