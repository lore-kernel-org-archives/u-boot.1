Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B9AE7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 12:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A32F896E8;
	Wed,  4 Dec 2024 13:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sDDM5nrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38166896E8; Wed,  4 Dec 2024 13:53:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C99896BA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733316797; x=1733921597; i=xypron.glpk@gmx.de;
 bh=iR7IGu2IWicyz1c1XCityGOYzrPBsPKX2unsU/q8biU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sDDM5nrMR7XnVtwxR3r/0hI/j7JXHhy4jNysgp8HJphiJpcK1/kxzOWj50pHwqfj
 fSvZE9CjZbGNs3glBDFD1J6htADcO6N7dBMvpCxmenTp9OX7QZFDEE5Vn/3esA7EB
 cufIkjx/ZMAK8MRXY7XuhpuXNI6VD/M7iT9Nb6Y7h+KLkxj6BKTcSANsnLlzTV4PQ
 fNXMDK3fT/mI1NMAwDF7CfzrZ/3+G7fopBwSMwiYZ+3ToAw6Zty1JjuO1a283i91P
 SSb3Z26YWdMuFSS8JGQHZrsCgijBafd5s0FLtRmxo8qo7XiwnjODVsZR1F7LvbVxD
 b+ksu7BKzKjnWLOtoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1t1QcO2Ymf-00URHE; Wed, 04
 Dec 2024 13:53:17 +0100
Message-ID: <08f00178-cbba-44f1-b9d0-170963b31940@gmx.de>
Date: Wed, 4 Dec 2024 13:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-next-2024-12-04
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M0d44QnbJcQZS2R65Vk6kHfRYgkgxPP86Holcmt6jXqgubCTDZJ
 GTJfaXUnZxRaS2w58bMHtY8XKgvF8lg39jZ2BjSuPjc3g/6IkJBjWaRre2tlB6PxgiT/Mba
 u7HXDhwMTm81cwn1bYxlrp5GXpqp7YJ3Huasq/DILhpsOoetuk7EPvQcN6Mu7x/WN+xgClZ
 BbEmo57uQRcjbTthR23ow==
UI-OutboundReport: notjunk:1;M01:P0:UKf9OC4O1gI=;O0SU61oCKdUHE71KFiV0cRPzDXF
 iexWeJiOwKz8Re037Y4H0lcTVbuFFsO1p/XIv8yUhyfRpLEhHN+z4goE6GPgu1LT5VmK3RMzW
 nMRdsdIjb9KCpG3nm7Jz6k6DDh/mudAWpdXGc/2xumLqF5HKjY+ooyNFZyHH5ZoHr1jTZ3rMh
 anICLSezqnP+eVh+185qR1AA6/DoQ7Lbmulm5gn9YgN59joo5pVOutQQQF/aW6Muh3FgNjdkv
 uftr90/PefStkbWwccksba1/cuYlw2K+7EpZhPGzwrowzJ48KUBL7fpKd/CtTPieluusCxztC
 /iryKQOZoIW0Fs3Sxo8ZWx7DLEpyuQe25jpv0+tPbboYrt+sdkaCW2/wtFVZuGwQwinH3YT+r
 m8gbWIaUVfMzTY58HvFEdifNTgx63rpbMI2s0XBOy4PqlQOAIDIh2gK9q3eLIw1B0NA3DDD53
 Pi0TVFP7RVn9gTOkIwJWaqIed6aFXy/qCUJB42rKtGyO8OA2oHCpGHpLSwBPft+Gc5A/Q7sie
 vR3tdLuS7A/rr8Nbe/BGlkhniknJohuliRJvuGjG+NzRy0tqHjiDlavQ7uDpYJFE0Dxhnpote
 wIib8RZOU0V/CWFy5g1nvDNn4l/26upJpGFEycvgsbIMoqgu5GiMdXkIoyBaiQOYKEDNXaowz
 H+G/BU8y3JwUjTjArqPeW98saqcqE0Oeqp3gLG5nxLjg6LYJDXDzekMguxcOtpYd0qcWG4y1y
 16t37u/BlUS3JktsVAYRKULdtF/tcQUrRu6UauthhKCckdif8EvdQWAmtF8Ttj58acFz9nO1l
 YZPr4aFvqMh3kL6bz+azBeb1RQIv93z6jM1gYqdyReHZNETPr/gCOqk1hvWlqmQ+FpEuE7H6c
 hvZrRYHKU1hGPbNcZnbPFpho1OxvhFP5+d+1b6eNSTJcEI/vE2uZfOH8v+OOXq8PONleavX0B
 tVycnkLFAgbXc8Kf0DAsX/AYpgCR7y+dQzsQFurFAMM5IlA6Pa64brda051XzQZP4Vo77LHyD
 4C0m0vNaoT64nw/XbHhZ4scogBDBds0MMyA52MYixwPQfPcahsCePUVsTPWYVdxZ6q/zSzvQo
 a4E1Q4w4GLpL7VEOPfGEmzo+Ji1M8K
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

Dear Tom,

The following changes since commit df863c4aa30ee4e624058f64132b7243c6370ef=
5:

   Merge tag 'xilinx-for-v2025.04-rc1' of
https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze into next
(2024-12-03 15:51:56 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-2024-12-04

for you to fetch changes up to 6caec797d5c453ccba5eeb0bc9194c5939094cb4:

   efi_selftest: add test for IPv4 Config2 protocol (2024-12-04 12:24:38
+0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23707

=2D---------------------------------------------------------------
Pull request efi-next-2024-12-04

With this pull request support for the EFI_HTTP_PROTOCOL and
EFI_IP4_CONFIG2 protocols are added. This allows EFI applications
to load files via HTTP.

UEFI:
       add efi_dp_from_ipv4 function
       add efi_net_set_addr, efi_net_get_addr functions
       add support for HTTP device path
       set EFI bootdevice device path to HTTP when loaded from wget
       add support to send http requests and parse http headers
       provide EFI_IP4_CONFIG2_PROTOCOL
       provide EFI_HTTP_PROTOCOL
       support IPv4() in device path to text protocol
       provide unit tests for the HTTP and IPv4 Config2 protocols

Network:
       zero terminate string with headers in wget_fill_info()
       zero terminate string with headers in wget_lwip_fill_info()
       pass port and server_name via wget_ctx in lwIP network stack
       let wget_with_dns work with dns disabled

Others:
       Add HTTP and IPV4 Config II protocols to UUID library functions.

=2D---------------------------------------------------------------
Adriano Cordova (14):
       lwip: wget: pass port and server_name via wget_ctx
       net-lwip: zero terminate string with headers in wget_lwip_fill_info=
()
       net: wget: let wget_with_dns work with dns disabled
       efi_loader: device_path: add definition of
DEVICE_PATH_SUB_TYPE_MSG_IPV4
       efi_loader: device_path: add efi_dp_from_ipv4
       efi_api: add definitions for HTTP and IP4_CONFIG2 protocols
       efi_loader: efi_net: add efi_net_set_addr, efi_net_get_addr
       efi_loader: device_path: add support for HTTP device path
       efi_loader: net: set EFI bootdevice device path to HTTP when
loaded from wget
       efi_loader: net: add support to send http requests and parse http
headers
       efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
       efi_loader: efi_net: add EFI_HTTP_PROTOCOL
       efi_selftest: add test for HTTP protocol
       efi_selftest: add test for IPv4 Config2 protocol

Heinrich Schuchardt (3):
       net: zero terminate string with headers in wget_fill_info()
       efi_loader: add IPv4() to device path to text protocol
       lib: uuid: display HTTP and IPV4 Config II protocols

  include/efi_api.h                        | 220 +++++++++++++
  include/efi_loader.h                     |  41 +++
  include/net-common.h                     |   7 +-
  lib/efi_loader/Kconfig                   |  17 +
  lib/efi_loader/Makefile                  |   2 +
  lib/efi_loader/efi_bootbin.c             |  42 ++-
  lib/efi_loader/efi_bootmgr.c             |   2 +-
  lib/efi_loader/efi_device_path.c         | 116 ++++++-
  lib/efi_loader/efi_device_path_to_text.c |  23 ++
  lib/efi_loader/efi_http.c                | 548
+++++++++++++++++++++++++++++++
  lib/efi_loader/efi_ipconfig.c            | 214 ++++++++++++
  lib/efi_loader/efi_net.c                 | 371 ++++++++++++++++++++-
  lib/efi_selftest/Makefile                |   2 +
  lib/efi_selftest/efi_selftest_http.c     | 321 ++++++++++++++++++
  lib/efi_selftest/efi_selftest_ipconfig.c | 176 ++++++++++
  lib/uuid.c                               |  14 +
  net/lwip/wget.c                          |  24 +-
  net/net-common.c                         |   2 +-
  net/wget.c                               |  45 ++-
  19 files changed, 2131 insertions(+), 56 deletions(-)
  create mode 100644 lib/efi_loader/efi_http.c
  create mode 100644 lib/efi_loader/efi_ipconfig.c
  create mode 100644 lib/efi_selftest/efi_selftest_http.c
  create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c

