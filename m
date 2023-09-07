Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A75EC8745
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1374886A04;
	Thu,  7 Sep 2023 17:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S1zFFsnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE5C868D7; Thu,  7 Sep 2023 17:45:15 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E56A86A14
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so138975466b.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694101509; x=1694706309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7y3rbO1RzgxKWnNXsWIfcygwrDuRBorBovsktP1bzXQ=;
 b=S1zFFsnvLFRBPq1OfWmgI2uNiBE87La24ukXHl6UCVxPiAJ9uk7GbIXZweBSGra6OV
 n+eLotBrR8HLnvcDf4OWGv7296O6kmVURN6o2qDjCQ2XD6agrya162PW0mgpkmMuNaxm
 cizo3TrQd2lAbqwsyJDEM2tJN4AQJ5y/zf/EUWH72E2SkrRlhZryYRNakg+w3wCjI+qe
 obzMQrVD6F6kWAl4Si7OHAqwQ0x3Nc/Sv0VgaWz1oP3rifVVUDhlgwqyjNLgyrr69BW+
 wd/JLWJUQtFhD8ryO1OmKO8i8MQdsHnzuTS1mNmw9Zu9MbBlx6lNEzf4fW5w2aSamIT1
 EDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694101509; x=1694706309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7y3rbO1RzgxKWnNXsWIfcygwrDuRBorBovsktP1bzXQ=;
 b=Ol4upAyyOZ/eNvSNvFuyKmb2owNFZfdyJU+qNBU5LTHKdpk9fAPtcO+/VO3IfR471s
 WhMbfgCi2fbK/ZBCJT0+I6mYEhsrpBDcFk9dx95If7sI+cnzkK1Gq1AzaC+cl089o0IL
 wF98bDcBQLSKRuQQmtXpk3hWKB0Mm2n7KfODC2CPWYnl80ksoEeFjUulHOUU1WzybTBv
 UsWaiYhnOpU2EPXjkN7RHWz1GxafXP6FOKJOg+vSpcOBqSbbjEB1bbl2IxXMpXmdf0fX
 97ZHu4ELmodpPBoCsWiIPC7lYWwmb5aLE1n9vEUKqKrQadJ0DKmh2FTHI1PwzoqiMLUX
 msLA==
X-Gm-Message-State: AOJu0YxWtRviTlWipYdVVX5gMa0t6VxkMeswdl4lQ8p9lRygE46Luw4k
 CMjlRQgOKfCLP2rszg8za7FJ03dmr6N29YNpD5Bp/ex6GfRB3Bi0xgU=
X-Google-Smtp-Source: AGHT+IFsSMDALMntfmkytMS6y++xu5h0PtPgrMpcaEPOiEZpdTlfFIZ28v9U3GiDWFrUeC3VhpcphJs05uu0eQxJmPs=
X-Received: by 2002:a17:907:7616:b0:9a1:aea2:d18d with SMTP id
 jx22-20020a170907761600b009a1aea2d18dmr5156466ejc.48.1694101509521; Thu, 07
 Sep 2023 08:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <CAHTX3dKEqFNMQf+-FSO7oZerT03fQb1Z1BYvN3-dfpmoPtZQFg@mail.gmail.com>
In-Reply-To: <CAHTX3dKEqFNMQf+-FSO7oZerT03fQb1Z1BYvN3-dfpmoPtZQFg@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 7 Sep 2023 21:44:57 +0600
Message-ID: <CAD8XO3Y4jc5NStvfyY=Nj2pG5on-a8DkVPZUShNHgcd+NZr4Hg@mail.gmail.com>
Subject: Re: [PATCHv7 00/15] net/lwip: add lwip library for the network stack
To: Michal Simek <monstr@monstr.eu>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

On Thu, 7 Sept 2023 at 21:21, Michal Simek <monstr@monstr.eu> wrote:

> Hi,
>
> =C3=BAt 22. 8. 2023 v 11:38 odes=C3=ADlatel Maxim Uvarov <maxim.uvarov@li=
naro.org>
> napsal:
> >
> > Hello,
> >
> > I'm sending v7, with all v6 comments getting fixed. The only thing left
> is a pointer
> > to timeout callback which 2 applications use. I will rework this timeou=
t
> > in next v8. I started take a look at it, and want to fix this together
> > with background applications support in v8.
> >
> > changelog:
> >         v7: - more review fixes.
> >             - support of multiply eth devices, were "ethact" selects th=
e
> >               active device.
> >         v6: - fixed review comments for v5 (thanks Ilias and Simon).
> >             - lwip is not under /net, so prior applying patch following
> >               commit is needed to create lwIP merge into U-Boot:
> >               git subtree add --prefix net/lwip/lwip-external
> https://git.savannah.nongnu.org/git/lwip.git master --squash
>
> I think you should integrate it via .gitmodules as is done for example in
> qemu.
>
> The next part. I tried to use buildmain to build the whole series and
> I am getting a lot of errors.
> You should fix pretty much all of these errors to make sure that the
> tree is bisectable.
>
> Thanks,
> Michal
>
>
Hello Michal, the first version was with .gitmodules. To  run  buildman you
need to create a subtree commit with the above line first, and only then
run buildman for patches.
And I think these series of patches are not friendly with sequential per
patch builds. It's split into logical pieces for easier review.

From the log below I can say that subtree commit was not created. lwIP
library files are missing in your set up.

BR,
Maxim.


> [u-boot](lwip)$ ./tools/buildman/buildman -C -b `git rev-parse
> --abbrev-ref HEAD` xilinx_zynqmp_virt -o /run/shm/ -sSed
> Summary of 18 commits for 1 boards (1 thread, 12 jobs per thread)
> 01: Merge branch 'master' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-usb
>    aarch64:  w+   xilinx_zynqmp_virt
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
> +to binman instead, to avoid the proliferation of
> +arch-specific scripts with no tests.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> 02: net/lwip: add doc/develop/net_lwip.rst
> 03: net/lwip: integrate lwIP library
>    aarch64:  +   xilinx_zynqmp_virt
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
> -to binman instead, to avoid the proliferation of
> -arch-specific scripts with no tests.
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +make[3]: *** No rule to make target
> 'net/lwip/lwip-external/src/core/init.o', needed by
> 'net/lwip/built-in.o'.  Stop.
> +make[2]: *** [../scripts/Makefile.build:397: net/lwip] Error 2
> +../net/net.c:128:23: fatal error: net/ulwip.h: No such file or directory
> + #include <net/ulwip.h>
> +                       ^
> +compilation terminated.
> +make[2]: *** [../scripts/Makefile.build:256: net/net.o] Error 1
> +make[1]: *** [Makefile:1857: net] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
> 04: net/lwip: implement dns cmd
> -make[2]: *** [../scripts/Makefile.build:256: net/net.o] Error 1
> +make[2]: *** [../scripts/Makefile.build:257: net/net.o] Error 1
> 05: net/lwip: implement dhcp cmd
> 06: net/lwip: implement tftp cmd
> +cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
> such file or directory
> +make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
> net/lwip/apps/tftp/tftp.c] Error 1
> +../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
> lwip/apps/tftp_client.h: No such file or directory
> + #include "lwip/apps/tftp_client.h"
> +                                   ^
> +make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/tftp/lwip-tftp.o] Error 1
> +make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
> 07: net/lwip: implement wget cmd
> 08: net/lwip: implement ping cmd
> +cp: cannot stat '../net/lwip/lwip-external/contrib/apps/ping/ping.c':
> No such file or directory
> +make[4]: *** [../net/lwip/apps/ping/Makefile:8:
> net/lwip/apps/ping/ping.c] Error 1
> +../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
> such file or directory
> + #include "lwip/opt.h"
> +                      ^
> +make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/ping/lwip_ping.o] Error 1
> +make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/ping] Error 2
> 09: net/lwip: add lwIP configuration
> 10: net/lwip: implement lwIP port to U-Boot
> -../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
> such file or directory
> - #include "lwip/opt.h"
> -                      ^
> -make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/ping/lwip_ping.o] Error 1
> -../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
> lwip/apps/tftp_client.h: No such file or directory
> - #include "lwip/apps/tftp_client.h"
> -                                   ^
> -make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/tftp/lwip-tftp.o] Error 1
> +../net/eth-uclass.c:35:2: error: unknown type name =E2=80=98ulwip=E2=80=
=99
> +  ulwip ulwip;
> +  ^~~~~
> +  return &priv->ulwip;
> +         ^~~~~~~~~~~~
> +make[2]: *** [../scripts/Makefile.build:257: net/eth-uclass.o] Error 1
> w+../net/eth-uclass.c: In function =E2=80=98eth_lwip_priv=E2=80=99:
> w+../net/eth-uclass.c:355:9: warning: return from incompatible pointer
> type [-Wincompatible-pointer-types]
> 11: net/lwip: update .gitignore with lwIP
> +../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
> such file or directory
> + #include "lwip/opt.h"
> +                      ^
> +make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/ping/lwip_ping.o] Error 1
> +../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
> lwip/apps/tftp_client.h: No such file or directory
> + #include "lwip/apps/tftp_client.h"
> +                                   ^
> +make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/tftp/lwip-tftp.o] Error 1
> 12: net/lwip: connection between cmd and lwip apps
> -../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
> such file or directory
> - #include "lwip/opt.h"
> -                      ^
> -make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/ping/lwip_ping.o] Error 1
> -../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
> lwip/apps/tftp_client.h: No such file or directory
> - #include "lwip/apps/tftp_client.h"
> -                                   ^
> -make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/tftp/lwip-tftp.o] Error 1
> +../cmd/net-lwip.c:16:23: fatal error: net/ulwip.h: No such file or
> directory
> + #include "net/ulwip.h"
> +make[2]: *** [../scripts/Makefile.build:257: cmd/net-lwip.o] Error 1
> +make[1]: *** [Makefile:1857: cmd] Error 2
> 13: net/lwip: replace original net commands with lwip
> -make[3]: *** No rule to make target
> 'net/lwip/lwip-external/src/core/init.o', needed by
> 'net/lwip/built-in.o'.  Stop.
> -cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
> such file or directory
> -make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
> net/lwip/apps/tftp/tftp.c] Error 1
> -make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
> -../cmd/net-lwip.c:16:23: fatal error: net/ulwip.h: No such file or
> directory
> - #include "net/ulwip.h"
> -                       ^
> -compilation terminated.
> -make[2]: *** [../scripts/Makefile.build:257: cmd/net-lwip.o] Error 1
> -make[1]: *** [Makefile:1857: cmd] Error 2
> -make[2]: *** [../scripts/Makefile.build:257: net/eth-uclass.o] Error 1
> -../net/net.c:128:23: fatal error: net/ulwip.h: No such file or directory
> - #include <net/ulwip.h>
> -make[2]: *** [../scripts/Makefile.build:257: net/net.o] Error 1
> +make[2]: *** [../scripts/Makefile.build:256: net/eth-uclass.o] Error 1
> 14: net/lwip: split net.h to net.h, arp.h and eth.h
> -../net/eth-uclass.c:35:2: error: unknown type name =E2=80=98ulwip=E2=80=
=99
> -  ulwip ulwip;
> -  ^~~~~
> -  return &priv->ulwip;
> -         ^~~~~~~~~~~~
> -make[2]: *** [../scripts/Makefile.build:256: net/eth-uclass.o] Error 1
> w-../net/eth-uclass.c: In function =E2=80=98eth_lwip_priv=E2=80=99:
> w-../net/eth-uclass.c:355:9: warning: return from incompatible pointer
> type [-Wincompatible-pointer-types]
> 15: net/lwip: drop old net/wget
> +make[3]: *** No rule to make target
> 'net/lwip/lwip-external/src/core/init.o', needed by
> 'net/lwip/built-in.o'.  Stop.
> +cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
> such file or directory
> +make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
> net/lwip/apps/tftp/tftp.c] Error 1
> +../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
> such file or directory
> + #include "lwip/opt.h"
> +                      ^
> +compilation terminated.
> +make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/ping/lwip_ping.o] Error 1
> +../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
> lwip/apps/tftp_client.h: No such file or directory
> + #include "lwip/apps/tftp_client.h"
> +                                   ^
> +make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/tftp/lwip-tftp.o] Error 1
> +make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
> 16: net/lwip/wget add port selection
> 17: Squashed 'net/lwip/lwip-external/' content from commit 84fde1ebbfe3
> -make[3]: *** No rule to make target
> 'net/lwip/lwip-external/src/core/init.o', needed by
> 'net/lwip/built-in.o'.  Stop.
> -cp: cannot stat '../net/lwip/lwip-external/contrib/apps/ping/ping.c':
> No such file or directory
> -make[4]: *** [../net/lwip/apps/ping/Makefile:8:
> net/lwip/apps/ping/ping.c] Error 1
> -cp: cannot stat '../net/lwip/lwip-external/src/apps/tftp/tftp.c': No
> such file or directory
> -make[4]: *** [../net/lwip/apps/tftp/Makefile:9:
> net/lwip/apps/tftp/tftp.c] Error 1
> -../net/lwip/apps/ping/lwip_ping.c:7:22: fatal error: lwip/opt.h: No
> such file or directory
> - #include "lwip/opt.h"
> -                      ^
> -compilation terminated.
> -make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/ping/lwip_ping.o] Error 1
> -make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/ping] Error 2
> -../net/lwip/apps/tftp/lwip-tftp.c:12:35: fatal error:
> lwip/apps/tftp_client.h: No such file or directory
> - #include "lwip/apps/tftp_client.h"
> -                                   ^
> -make[4]: *** [../scripts/Makefile.build:257:
> net/lwip/apps/tftp/lwip-tftp.o] Error 1
> -make[3]: *** [../scripts/Makefile.build:397: net/lwip/apps/tftp] Error 2
> -make[2]: *** [../scripts/Makefile.build:397: net/lwip] Error 2
> -make[1]: *** [Makefile:1857: net] Error 2
> -make: *** [Makefile:177: sub-make] Error 2
> +make: *** No rule to make target 'xilinx_zynqmp_virt_defconfig'.  Stop.
> 18: Merge commit 'c773d79082011e8d77cd4b125c07a84b8348af39' as
> 'net/lwip/lwip-external'
>    aarch64:  w+   xilinx_zynqmp_virt
> -make: *** No rule to make target 'xilinx_zynqmp_virt_defconfig'.  Stop.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
> +to binman instead, to avoid the proliferation of
> +arch-specific scripts with no tests.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
