Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4ABC07CA9
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 10:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C571686FBE;
	Tue, 28 Nov 2023 11:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JbApFx4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6AB8773F; Tue, 28 Nov 2023 11:37:57 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E606A86AB3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50bb83d9e17so897723e87.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 02:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701167872; x=1701772672; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yNloy90UqwFX4IF+z9ADINAW9R33Mjq1z9yn4xTS1CQ=;
 b=JbApFx4co227ftH4bQKZRV8o+gJ5XFQheO9hskG+zTY+1MP5UwMJ+fwZ2eTrYgFisj
 QmwQBI8oIbc0fC9DJRf+kf9XKRSocpbMgWy525F3H2f4TKSuvv60W49BWWWoLQqJoOFz
 jebffXZgJM4yI9GqQCXfGrdP6dOMzehmeuR5GtpI6U5P2wGtejYuqTgiAUcHti+t2RN3
 TZC82wuKzQniUGupobPvXqemIDqpv10kfNsHS7SRdNp7sp6JwA3a6JwL5GOEFihozhRM
 4IwSSR+3L9/qJNcu9ANleFY+eS0QlWanRjhp4+Q+t1uCxzkIu9j0Z88sF1BYG2eQPysB
 /GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701167872; x=1701772672;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yNloy90UqwFX4IF+z9ADINAW9R33Mjq1z9yn4xTS1CQ=;
 b=o1XIb3IgM2ZyOswjIwHuvsW5xwQkYugJQ/cNw8Vi4EFsFYK1Zi+UgKDC/SqzdAYuOc
 i2u1XGVzxAqVlQH+mSTdzxB5y1fQdA8oJJ7tlOjOsKO6tK6Er+QVXXITwKRAsdjoMG8G
 EIv0MNFb9bfyWofR11YCq+VcImuvCocORm8IUfvbX3h6+4Ti7eI76vNK0s+pQMZEKrWL
 5kCzfdiA36KdASeV5bJv1bCfwY2SH+jBpsiDQYIBXjbYnLD1jJ7mDrbXSQfazbm9QbxP
 5jToXMiY1EX4OJqhiRVl27kmhf33m1R4RtswstkrvNP0VLRNC4s0f3BLGh6SQ61l+dxL
 cL8w==
X-Gm-Message-State: AOJu0Yxpthf8XCU6vJ9xdbqz1iY+TU8cXiBRArFTOJbSDsSHmJow0DjA
 ZuZsH3cK9BzfpsN7ofXFtq6WxA==
X-Google-Smtp-Source: AGHT+IGwNPGW5pkVnUPhBsbOMQX82bVXKqumGKUnGHvZJNAMxVa4CFYFvRGHZv3b2I+o8MBpmcDEjQ==
X-Received: by 2002:ac2:532f:0:b0:4ff:7004:545e with SMTP id
 f15-20020ac2532f000000b004ff7004545emr10406092lfh.4.1701167871958; 
 Tue, 28 Nov 2023 02:37:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe?
 ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c154700b0040b4cb14d40sm1664298wmg.19.2023.11.28.02.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 02:37:51 -0800 (PST)
Message-ID: <bf3c4f05-db8f-4643-9335-53e511aeff86@linaro.org>
Date: Tue, 28 Nov 2023 11:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
Content-Language: en-US, fr
To: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 27/11/2023 13:56, Maxim Uvarov wrote:
> Hello,
> 
> Please find updated version of lwip patches. Changes are in the
> changelog bellow.

I've ran it on the libretech-cc board, and tried to load grub over tftp,
and I got this strange EFI boot error:
========================================================================================
U-Boot 2024.01-rc3-00056-g10d85cb3e3 (Nov 28 2023 - 11:17:24 +0100) libretech-cc

Model: Libre Computer AML-S905X-CC
SoC:   Amlogic Meson GXL (S905X) Revision 21:d (84:2)
DRAM:  2 GiB

<snip>

Net:   eth0: ethernet@c9410000
Hit any key to stop autoboot:  0
=> setenv autoload no
=> dhcp
ethernet@c9410000 LPA corruption - aneg restart
ethernet@c9410000 Waiting for PHY auto negotiation to complete.... done
Speed: 100, full duplex
eth0: ethernet@c9410000 3e:a6:23:c0:39:4b active
dhcp_tmo 20/20
dhcp_tmo 19/20
DHCP client bound to address 10.34.56.105
=> tftpboot 8080000 grubaa64.efi
init already done for ethernet@c9410000
Speed: 100, full duplex
TFTP from server 10.34.56.1; our IP address is 10.34.56.105
Filename 'grubaa64.efi'.
Load address: 0x8080000
Loading:############
done
Bytes transferred = 4288512 (0x417000 hex)
=> crc32 8080000 0x417000
crc32 for 08080000 ... 08496fff ==> c79bc066
========================================================================================

- DHCP OK,
- transfer OK
- CRC32 value OK

but then trying to run the EFI binary:
========================================================================================
=> bootefi 8080000
No EFI system partition
No EFI system partition
Failed to persist EFI variables
No UEFI binary known at 8080000
========================================================================================

This is what I get on the current master without this patchset:
========================================================================================
U-Boot 2024.01-rc3-00013-gacae7eb5fe (Nov 28 2023 - 11:29:38 +0100) libretech-cc

Model: Libre Computer AML-S905X-CC
SoC:   Amlogic Meson GXL (S905X) Revision 21:d (84:2)
DRAM:  2 GiB

<snip>

Net:   eth0: ethernet@c9410000
Hit any key to stop autoboot:  0
=> setenv autoload no
=> dhcp
ethernet@c9410000 LPA corruption - aneg restart
ethernet@c9410000 Waiting for PHY auto negotiation to complete.... done
Speed: 100, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 10.34.56.105 (1008 ms)
=> tftpboot 8080000 grubaa64.efi
Speed: 100, full duplex
Using ethernet@c9410000 device
TFTP from server 10.34.56.1; our IP address is 10.34.56.105
Filename 'grubaa64.efi'.
Load address: 0x8080000
Loading: ##T #T T ##############################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ##########################################################
	 199.2 KiB/s
done
Bytes transferred = 4288512 (417000 hex)
=> crc32 8080000 0x417000
crc32 for 08080000 ... 08496fff ==> c79bc066
=> bootefi 8080000
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Booting /grubaa64.efi
Welcome to GRUB!

<snip>

grub> net_ls_addr
efinet0 3e:a6:23:c0:39:4b 10.34.56.105
========================================================================================

I don't see what's wrong, crc32 is good and env variables are the same:
fileaddr=8080000
filesize=417000

Neil


> 
> Thank you,
> Maxim.
> 
> changelog:
> 	v11: - v11 is mosly respin of v10 patches with CI error fixes.
>                  Gitlab CI:
>                  https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18368
>                  Azure CI:
>                  https://dev.azure.com/u-boot/u-boot/_build/results?buildId=7366&view=results
>                  (Azure CI, which is connected to github. Sometime I can see
>                   tftp timeout after some part of download there, but that can not be
>                   reproduced locally. While Gitblab CI is stable. Because of num tries in
>                   CI I suspect this CI was not always reliable.)
>                  Azure and Gitlab also have different toolchains and I
>                  would say Gitlab generates bigger code then Azure CI.
>                  
>                  Also many boards have a binary limit size of 800k (even
>                  qemu has limits). And increased limits to fit all the code. Specially did it
>                  patch by board config to show which boards are failing to build. There I have
>                  a question if we really want to support new functionality for old boards (mips,
>                  arm32 and etc...). I hope board owners can help me if
>                  it's valid to increase these limits.
> 
> 		In this version I used git submodules and friend CI with
> 		submodules. But I don't mind if you decide to maintain it in a different
> 		way.
> 
> 
> 	v10: - fix ping with following tftp command issue with incorrect
> 		ping timeout clear.
> 	     - Makefile on make will init submodules and if needed will
> 	       do git clone.
> 	     - wget - some minor code style changes.
> 	v9: - added first patch describing git submodule for lwip. So
> 	      the build procedure is:
> 		git submodule init
> 		git submodule update
> 		make
> 	    - reworked a little bit dhcp cmd state polling
> 	    - fixed review comments for v8
> 	v8: - comments for previous review
> 	    - removed lwip timeout callback pointer
> 	    - made lwip timeouts works, that also allowed to remove
> 	      static vars.
> 	    - setenv for filesize tftp and wget has to be in hex.
> 	    - Makefile changes always compile it tftp,dns,wget,ping due
> 	      to it can be used not only by CONFIG_CMD_.
> 	    - Kconfig changes - simplify lwIP settings and support only
> 	      one configuration.
> 	    - tested with mini debian.iso load over http or tftp, mount
> 	      and boot it (qemu, arm64).
> 	v7: - more review fixes.
> 	    - support of multiply eth devices, were "ethact" selects the
> 	      active device.
> 	v6: - fixed review comments for v5 (thanks Ilias and Simon).
> 	v5: - fixed Iliases comments and split big patch on the small
> 		ones.
> 	v4: - tested with tests/py/ did some minor fixes (out of tree
> 		build, variables set after downloads).
> 	    - accounted review comments for documentation.
> 	    - implemented dns command
>              - corrected wget command to not use serverip variable and use just
> 		url string.
> 	v3: - use lwip commands for ping,tftp,wget,dhcp if this patch
> 	      applied. Drop CONFIG_LIB_LWIP_REPLACE_<COMMAND> option.
> 	    - docs: use rst variant and drop references to RFC.
> 
> Maxim Uvarov (43):
>    submodule: add lwIP as git submodule
>    net/lwip: add doc/develop/net_lwip.rst
>    net/lwip: integrate lwIP library
>    net/lwip: implement dns cmd
>    net/lwip: implement dhcp cmd
>    net/lwip: implement tftp cmd
>    net/lwip: implement wget cmd
>    net/lwip: implement ping cmd
>    net/lwip: add lwIP configuration
>    net/lwip: implement lwIP port to U-Boot
>    net/lwip: update .gitignore with lwIP
>    net/lwip: connection between cmd and lwip apps
>    net/lwip: replace original net commands with lwip
>    net/lwip: split net.h to net.h, arp.h and eth.h
>    test_efi_loader.py: use $filesize var
>    test_net: print out net list
>    net: sandbox: fix NULL pointer derefences
>    net/smc911x: fix return from smc911x_send
>    sandbox: eth-raw-os: successful return code is 0
>    driver/net/rtl8139: remove debug print
>    mach-socfpga: do not overlap defines with lwip
>    bcm_ns3: fix overlap define with lwip
>    rcar3_salvator-x_defconfig: increase binary size limit
>    lwip: omap3: rename mem_init
>    configs/turris_omnia_defconfig set limit to 0xf6000
>    configs/tbs2910_defconfig inc limit
>    configs/socfpga_secu1_defconfig: enable LTO
>    configs/turris_omnia_defconfig: enable LTO
>    configs/am335x_boneblack_vboot_defconfig: enable LTO and increase SPL
>      size
>    configs/sheevaplug_defconfig: enable LTO and inc size
>    configs/lschlv2_defconfig: enable LTO and inc size
>    configs/lsxhl_defconfig: LTO + size
>    configs/am335x_evm_defconfig: inc SPL size
>    configs/bk4r1_defconfig: inc size
>    configs/linkit-smart-7688_defconfig: increse size
>    configs/gardena-smart-gateway-mt7688_defconfig: increase size
>    configs/rcar3_ulcb_defconfig: increase size
>    configs/qemu-x86_64_defconfig: increase ROM size
>    Makefile: add dtbs to clean
>    .azure-pipelines: init submodules
>    mach-mtmips: inc SPL size limit
>    configs/linkit-smart-7688_defconfig: increase board limit
>    .gitlab-ci.yml: change ownership of the git files
> 
>   .azure-pipelines.yml                          |  10 +-
>   .gitlab-ci.yml                                |  15 +-
>   .gitmodules                                   |   4 +
>   Makefile                                      |  12 +-
>   arch/arm/include/asm/arch-omap3/mem.h         |   2 +-
>   arch/arm/mach-omap2/omap3/board.c             |   2 +-
>   arch/arm/mach-omap2/omap3/emif4.c             |   4 +-
>   arch/arm/mach-omap2/omap3/sdrc.c              |   6 +-
>   .../mach-socfpga/include/mach/handoff_soc64.h |   6 -
>   arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   9 +
>   arch/mips/mach-mtmips/Kconfig                 |   2 +-
>   arch/sandbox/cpu/eth-raw-os.c                 |   2 +-
>   boot/bootmeth_efi.c                           |  18 +-
>   boot/bootmeth_pxe.c                           |  21 +-
>   cmd/Makefile                                  |   1 +
>   cmd/net-lwip.c                                | 307 ++++++++++++++++
>   cmd/net.c                                     |  86 +----
>   cmd/pxe.c                                     |  19 +-
>   configs/am335x_boneblack_vboot_defconfig      |   3 +
>   configs/am335x_evm_defconfig                  |   1 +
>   configs/bk4r1_defconfig                       |   2 +-
>   .../gardena-smart-gateway-mt7688_defconfig    |   2 +-
>   configs/linkit-smart-7688_defconfig           |   2 +-
>   configs/lschlv2_defconfig                     |   3 +-
>   configs/lsxhl_defconfig                       |   3 +-
>   configs/qemu-x86_64_defconfig                 |   5 +-
>   configs/rcar3_salvator-x_defconfig            |   3 +-
>   configs/rcar3_ulcb_defconfig                  |   1 +
>   configs/sheevaplug_defconfig                  |   3 +-
>   configs/socfpga_secu1_defconfig               |   1 +
>   configs/tbs2910_defconfig                     |   2 +-
>   configs/turris_omnia_defconfig                |   3 +-
>   doc/develop/index.rst                         |   1 +
>   doc/develop/net_lwip.rst                      |  75 ++++
>   drivers/net/rtl8139.c                         |   1 -
>   drivers/net/sandbox.c                         |   5 +
>   drivers/net/smc911x.c                         |   2 +-
>   include/configs/bcm_ns3.h                     |   6 +-
>   include/net.h                                 | 197 +----------
>   include/net/arp.h                             |   9 +
>   include/net/eth.h                             | 194 +++++++++++
>   include/net/lwip.h                            |  73 ++++
>   include/net/ulwip.h                           |  67 ++++
>   lib/Kconfig                                   |   2 +-
>   net/Kconfig                                   |   3 +
>   net/Makefile                                  |   1 +
>   net/eth-uclass.c                              |  37 +-
>   net/lwip/.gitignore                           |   8 +
>   net/lwip/Kconfig                              |  34 ++
>   net/lwip/Makefile                             |  70 ++++
>   net/lwip/apps/dhcp/lwip-dhcp.c                |  86 +++++
>   net/lwip/apps/dns/lwip-dns.c                  |  63 ++++
>   net/lwip/apps/http/Makefile                   |   6 +
>   net/lwip/apps/http/lwip-wget.c                | 105 ++++++
>   net/lwip/apps/ping/Makefile                   |  12 +
>   net/lwip/apps/ping/lwip_ping.c                |  39 +++
>   net/lwip/apps/ping/lwip_ping.h                |  15 +
>   net/lwip/apps/ping/ping.h                     |  28 ++
>   net/lwip/apps/tftp/Makefile                   |   7 +
>   net/lwip/apps/tftp/lwip-tftp.c                | 132 +++++++
>   net/lwip/lwip-external                        |   1 +
>   net/lwip/lwipopts.h                           | 178 ++++++++++
>   net/lwip/port/if.c                            | 327 ++++++++++++++++++
>   net/lwip/port/include/arch/cc.h               |  44 +++
>   net/lwip/port/include/arch/sys_arch.h         |  10 +
>   net/lwip/port/include/limits.h                |   0
>   net/lwip/port/sys-arch.c                      |  13 +
>   net/net.c                                     |  44 ++-
>   test/py/tests/test_efi_loader.py              |   4 +-
>   test/py/tests/test_net.py                     |   2 +
>   70 files changed, 2113 insertions(+), 348 deletions(-)
>   create mode 100644 .gitmodules
>   create mode 100644 cmd/net-lwip.c
>   create mode 100644 doc/develop/net_lwip.rst
>   create mode 100644 include/net/arp.h
>   create mode 100644 include/net/eth.h
>   create mode 100644 include/net/lwip.h
>   create mode 100644 include/net/ulwip.h
>   create mode 100644 net/lwip/.gitignore
>   create mode 100644 net/lwip/Kconfig
>   create mode 100644 net/lwip/Makefile
>   create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
>   create mode 100644 net/lwip/apps/dns/lwip-dns.c
>   create mode 100644 net/lwip/apps/http/Makefile
>   create mode 100644 net/lwip/apps/http/lwip-wget.c
>   create mode 100644 net/lwip/apps/ping/Makefile
>   create mode 100644 net/lwip/apps/ping/lwip_ping.c
>   create mode 100644 net/lwip/apps/ping/lwip_ping.h
>   create mode 100644 net/lwip/apps/ping/ping.h
>   create mode 100644 net/lwip/apps/tftp/Makefile
>   create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
>   create mode 160000 net/lwip/lwip-external
>   create mode 100644 net/lwip/lwipopts.h
>   create mode 100644 net/lwip/port/if.c
>   create mode 100644 net/lwip/port/include/arch/cc.h
>   create mode 100644 net/lwip/port/include/arch/sys_arch.h
>   create mode 100644 net/lwip/port/include/limits.h
>   create mode 100644 net/lwip/port/sys-arch.c
> 

