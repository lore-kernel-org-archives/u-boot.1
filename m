Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B5EC8739
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5F9869C3;
	Thu,  7 Sep 2023 17:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="0l6lwdKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C37869E1; Thu,  7 Sep 2023 17:21:34 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AD386854
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7bb34576b9so949502276.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694100090; x=1694704890;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdnJIWiDf8gEvHTl+bea+hgCwmLQH2Z5c/rcFzmg5xc=;
 b=0l6lwdKanchlrsULUh382iaaep00azIq+kgDH99r7BjgvFy+vtUiezi2YBKbql++pj
 U3myYbKvOMYaMzPjKvGSYcNgtGuqfsI/uJyhFYdD8+7Ti48+uws/X4QkDxmJ5VVPHK1c
 EPBIjI36tSWrLFHk/1T2FB0RFxnoa5mu6AefA14Ay2N6qGmEUnV0t6R0B5oe1/Ku1Y92
 ow4+p67DeqfQxen9u/ykZnQiYrhF2qFT8v5mcFYTmjtfQoNIl++TySAcH/CKxE+wEcEU
 m0dQK7vjBvFAFWcEtlb0fcZDbjXZEzuG7tkyrHBIEV27ueKmLtc5jvsK5QWYWbMyR+7A
 zgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694100090; x=1694704890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdnJIWiDf8gEvHTl+bea+hgCwmLQH2Z5c/rcFzmg5xc=;
 b=OLWnuBgkez7FoLWT/2vemgdL3id9HuG/GaYcqor2gFjqufbFyzP2v8IHNRRz87ytbW
 BRxVPV1f5AlvBAZOBfwmDmzserR2v2byi9lHQxMgtVDQZiitV+3LrtOI73eFzftPA9je
 vYOGqL/r5TihrenS2jPXTimCcEdrljBUd1qAQsUKhhspPRpflNIbMoL9zgaqYGntRp5x
 qfd6RkJV2mAdmX4qdwlLpAlUtRAUDfhTjBIi2gg/e6UcV5DCwG1O52XC7Ozns1kVKJm4
 3L8Y5eGdIts+FuJ8t1ivx6hLuGwIG81hSt024e1aFOsaOPPJqUDo/x3oM2g6l1v94mdZ
 s8Xw==
X-Gm-Message-State: AOJu0YzU7zrnAHh67wfEsPjtaHD5n3SVeVFl8NDrmCU6apr6OF8qjXND
 iDxhLiqw3wfNz/UzL4KQVzaw6XfVz8IgNgLIGt8NnA==
X-Google-Smtp-Source: AGHT+IH65L48dTxmENHDcRFo7P+Q1B5RJg4ZIGtDcPV6IB0e1wF6+UJi4Dy9uC37V/LNOiMJ3n56TF9f2YDcGR9EyAo=
X-Received: by 2002:a25:e7d1:0:b0:d78:11a3:6800 with SMTP id
 e200-20020a25e7d1000000b00d7811a36800mr18459767ybh.61.1694100089892; Thu, 07
 Sep 2023 08:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 7 Sep 2023 17:21:18 +0200
Message-ID: <CAHTX3dKEqFNMQf+-FSO7oZerT03fQb1Z1BYvN3-dfpmoPtZQFg@mail.gmail.com>
Subject: Re: [PATCHv7 00/15] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

Hi,

=C3=BAt 22. 8. 2023 v 11:38 odes=C3=ADlatel Maxim Uvarov <maxim.uvarov@lina=
ro.org> napsal:
>
> Hello,
>
> I'm sending v7, with all v6 comments getting fixed. The only thing left i=
s a pointer
> to timeout callback which 2 applications use. I will rework this timeout
> in next v8. I started take a look at it, and want to fix this together
> with background applications support in v8.
>
> changelog:
>         v7: - more review fixes.
>             - support of multiply eth devices, were "ethact" selects the
>               active device.
>         v6: - fixed review comments for v5 (thanks Ilias and Simon).
>             - lwip is not under /net, so prior applying patch following
>               commit is needed to create lwIP merge into U-Boot:
>               git subtree add --prefix net/lwip/lwip-external https://git=
.savannah.nongnu.org/git/lwip.git master --squash

I think you should integrate it via .gitmodules as is done for example in q=
emu.

The next part. I tried to use buildmain to build the whole series and
I am getting a lot of errors.
You should fix pretty much all of these errors to make sure that the
tree is bisectable.

Thanks,
Michal

[u-boot](lwip)$ ./tools/buildman/buildman -C -b `git rev-parse
--abbrev-ref HEAD` xilinx_zynqmp_virt -o /run/shm/ -sSed
Summary of 18 commits for 1 boards (1 thread, 12 jobs per thread)
01: Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boo=
t-usb
   aarch64:  w+   xilinx_zynqmp_virt
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
+to binman instead, to avoid the proliferation of
+arch-specific scripts with no tests.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
02: net/lwip: add doc/develop/net_lwip.rst
03: net/lwip: integrate lwIP library
   aarch64:  +   xilinx_zynqmp_virt
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
-to binman instead, to avoid the proliferation of
-arch-specific scripts with no tests.
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+make[3]: *** No rule to make target
'net/lwip/lwip-external/src/core/init.o', needed by
'net/lwip/built-in.o'.  Stop.
+make[2]: *** [../scripts/Makefile.build:397: net/lwip] Error 2
+../net/net.c:128:23: fatal error: net/ulwip.h: No such file or directory
+ #include <net/ulwip.h>
+                       ^
+compilation terminated.
+make[2]: *** [../scripts/Makefile.build:256: net/net.o] Error 1
+make[1]: *** [Makefile:1857: net] Error 2
+make: *** [Makefile:177: sub-make] Error 2
04: net/lwip: implement dns cmd
-make[2]: *** [../scripts/Makefile.build:256: net/net.o] Error 1
+make[2]: *** [../scripts/Makefile.build:257: net/net.o] Error 1
05: net/lwip: implement dhcp cmd
06: net/lwip: implement tftp cmd
+cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
such file or directory
+make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
net/lwip/apps/tftp/tftp.c] Error 1
+../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
lwip/apps/tftp_client.h: No such file or directory
+ #include "lwip/apps/tftp_client.h"
+                                   ^
+make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/tftp/lwip-tftp.o] Error 1
+make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
07: net/lwip: implement wget cmd
08: net/lwip: implement ping cmd
+cp: cannot stat '../net/lwip/lwip-external/contrib/apps/ping/ping.c':
No such file or directory
+make[4]: *** [../net/lwip/apps/ping/Makefile:8:
net/lwip/apps/ping/ping.c] Error 1
+../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
such file or directory
+ #include "lwip/opt.h"
+                      ^
+make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/ping/lwip_ping.o] Error 1
+make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/ping] Error 2
09: net/lwip: add lwIP configuration
10: net/lwip: implement lwIP port to U-Boot
-../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
such file or directory
- #include "lwip/opt.h"
-                      ^
-make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/ping/lwip_ping.o] Error 1
-../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
lwip/apps/tftp_client.h: No such file or directory
- #include "lwip/apps/tftp_client.h"
-                                   ^
-make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/tftp/lwip-tftp.o] Error 1
+../net/eth-uclass.c:35:2: error: unknown type name =E2=80=98ulwip=E2=80=99
+  ulwip ulwip;
+  ^~~~~
+  return &priv->ulwip;
+         ^~~~~~~~~~~~
+make[2]: *** [../scripts/Makefile.build:257: net/eth-uclass.o] Error 1
w+../net/eth-uclass.c: In function =E2=80=98eth_lwip_priv=E2=80=99:
w+../net/eth-uclass.c:355:9: warning: return from incompatible pointer
type [-Wincompatible-pointer-types]
11: net/lwip: update .gitignore with lwIP
+../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
such file or directory
+ #include "lwip/opt.h"
+                      ^
+make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/ping/lwip_ping.o] Error 1
+../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
lwip/apps/tftp_client.h: No such file or directory
+ #include "lwip/apps/tftp_client.h"
+                                   ^
+make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/tftp/lwip-tftp.o] Error 1
12: net/lwip: connection between cmd and lwip apps
-../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
such file or directory
- #include "lwip/opt.h"
-                      ^
-make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/ping/lwip_ping.o] Error 1
-../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
lwip/apps/tftp_client.h: No such file or directory
- #include "lwip/apps/tftp_client.h"
-                                   ^
-make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/tftp/lwip-tftp.o] Error 1
+../cmd/net-lwip.c:16:23: fatal error: net/ulwip.h: No such file or directo=
ry
+ #include "net/ulwip.h"
+make[2]: *** [../scripts/Makefile.build:257: cmd/net-lwip.o] Error 1
+make[1]: *** [Makefile:1857: cmd] Error 2
13: net/lwip: replace original net commands with lwip
-make[3]: *** No rule to make target
'net/lwip/lwip-external/src/core/init.o', needed by
'net/lwip/built-in.o'.  Stop.
-cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
such file or directory
-make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
net/lwip/apps/tftp/tftp.c] Error 1
-make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
-../cmd/net-lwip.c:16:23: fatal error: net/ulwip.h: No such file or directo=
ry
- #include "net/ulwip.h"
-                       ^
-compilation terminated.
-make[2]: *** [../scripts/Makefile.build:257: cmd/net-lwip.o] Error 1
-make[1]: *** [Makefile:1857: cmd] Error 2
-make[2]: *** [../scripts/Makefile.build:257: net/eth-uclass.o] Error 1
-../net/net.c:128:23: fatal error: net/ulwip.h: No such file or directory
- #include <net/ulwip.h>
-make[2]: *** [../scripts/Makefile.build:257: net/net.o] Error 1
+make[2]: *** [../scripts/Makefile.build:256: net/eth-uclass.o] Error 1
14: net/lwip: split net.h to net.h, arp.h and eth.h
-../net/eth-uclass.c:35:2: error: unknown type name =E2=80=98ulwip=E2=80=99
-  ulwip ulwip;
-  ^~~~~
-  return &priv->ulwip;
-         ^~~~~~~~~~~~
-make[2]: *** [../scripts/Makefile.build:256: net/eth-uclass.o] Error 1
w-../net/eth-uclass.c: In function =E2=80=98eth_lwip_priv=E2=80=99:
w-../net/eth-uclass.c:355:9: warning: return from incompatible pointer
type [-Wincompatible-pointer-types]
15: net/lwip: drop old net/wget
+make[3]: *** No rule to make target
'net/lwip/lwip-external/src/core/init.o', needed by
'net/lwip/built-in.o'.  Stop.
+cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
such file or directory
+make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
net/lwip/apps/tftp/tftp.c] Error 1
+../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
such file or directory
+ #include "lwip/opt.h"
+                      ^
+compilation terminated.
+make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/ping/lwip_ping.o] Error 1
+../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
lwip/apps/tftp_client.h: No such file or directory
+ #include "lwip/apps/tftp_client.h"
+                                   ^
+make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/tftp/lwip-tftp.o] Error 1
+make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
16: net/lwip/wget add port selection
17: Squashed 'net/lwip/lwip-external/' content from commit 84fde1ebbfe3
-make[3]: *** No rule to make target
'net/lwip/lwip-external/src/core/init.o', needed by
'net/lwip/built-in.o'.  Stop.
-cp: cannot stat '../net/lwip/lwip-external/contrib/apps/ping/ping.c':
No such file or directory
-make[4]: *** [../net/lwip/apps/ping/Makefile:8:
net/lwip/apps/ping/ping.c] Error 1
-cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
such file or directory
-make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
net/lwip/apps/tftp/tftp.c] Error 1
-../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
such file or directory
- #include "lwip/opt.h"
-                      ^
-compilation terminated.
-make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/ping/lwip_ping.o] Error 1
-make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/ping] Error 2
-../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
lwip/apps/tftp_client.h: No such file or directory
- #include "lwip/apps/tftp_client.h"
-                                   ^
-make[4]: *** [../scripts/Makefile.build:257:
net/lwip/apps/tftp/lwip-tftp.o] Error 1
-make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
-make[2]: *** [../scripts/Makefile.build:397: net/lwip] Error 2
-make[1]: *** [Makefile:1857: net] Error 2
-make: *** [Makefile:177: sub-make] Error 2
+make: *** No rule to make target 'xilinx_zynqmp_virt_defconfig'.  Stop.
18: Merge commit 'c773d79082011e8d77cd4b125c07a84b8348af39' as
'net/lwip/lwip-external'
   aarch64:  w+   xilinx_zynqmp_virt
-make: *** No rule to make target 'xilinx_zynqmp_virt_defconfig'.  Stop.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
+to binman instead, to avoid the proliferation of
+arch-specific scripts with no tests.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
