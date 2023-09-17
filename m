Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D796CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 07:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B621863E5;
	Sun, 17 Sep 2023 09:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OV0DsADz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4A8863ED; Sun, 17 Sep 2023 09:14:39 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11F286308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 09:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d7e904674aeso3375382276.3
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694934875; x=1695539675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GLTE/ByQopJFjE/32rZ2MoIsx+VNx4HxLNyZvuAmL4U=;
 b=OV0DsADzWzDX3ob++uW9NED1KCRHNnJs11VwqYJF0XzwAq/7L/JNQsjZ9NCbmheWze
 L7covlXXpnyX+ZX9sLDV/Fwv4poB7C2pUev4pqPfTItrHfTWWAStYe1Y+flKXgiU7SQc
 rP7vItuV1UnY3GNzA3Wz6SoZt2+TPn2jEFKFaIqDjQJ4fFSv66sReiSDme4nXyXyqb/F
 AEAT2OgAtDpVir5x/talLq29UjHyKUFbZ11GNLA96384YsFidBsy90hfh/AhDgRw662n
 vLRUkoGFFhgKlOJJEaJCPQXVEGUsHaG6P8Lj70B+AHqXOu+ILbmc+GSPoktdcYKH1OZO
 VvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694934875; x=1695539675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLTE/ByQopJFjE/32rZ2MoIsx+VNx4HxLNyZvuAmL4U=;
 b=YPoX7CH+BAn25CLIclLdM0aBR722AJlXqm0GTgYxQS33VR1yRwahMlYlpNFr9b+GDB
 OPMLVY6EUc2MVVQLOWNkbepopo6mM7S5+Yd+bK6Qj+KHJon681/f3+4V6rqd/Qn+DDFN
 JWYWHwX1tn4JViHAB0W43uNOPHQritVxKwe5aSK4IuDnDbUP0aw75E6L9TDjtgRljShl
 usAHywLjV9+Z1vAhAJHCyBNTRMouOUNz12Ebm5yP0xSW/YH2BIAtCZefDD4dwzITgjuN
 GLnbNyhK2EhGBaApJznaFIcs0C2WuzKubZEw6XPauG4Mqa7q4S4of4KFHqJGXfWxmnZ+
 2Mww==
X-Gm-Message-State: AOJu0YwwvP6PV3WFk/U5A5wBaH44Rl9A6BfDIXZU6tJtNZOvcK2r+zbv
 kk9gqPy2uXvVGSbnbdkoMfALgtU+Qa6t9mYvw/I=
X-Google-Smtp-Source: AGHT+IFUZoDPmLegS9SyiBYowm9tpEqzn0sVBJhFXqAB4G1Zd0A2mqj4hgvnE06BtBSpoqdL49Kv/t1ddjfNLwjZwvc=
X-Received: by 2002:a25:83d0:0:b0:d81:a0c5:f275 with SMTP id
 v16-20020a2583d0000000b00d81a0c5f275mr5209239ybm.15.1694934875499; Sun, 17
 Sep 2023 00:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
 <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
 <7e069c36-fe99-3701-9572-1363b694645b@kwiboo.se>
 <047fd798-5501-42fd-a5cb-ff1d84043f96@canonical.com>
In-Reply-To: <047fd798-5501-42fd-a5cb-ff1d84043f96@canonical.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 17 Sep 2023 09:14:24 +0200
Message-ID: <CAC928HaG2uc3CS0rJ_cmRZwDkJXtkP1UxMULqbeL9AvGbfRPSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Chanho Park <chanho61.park@samsung.com>,
 u-boot@lists.denx.de, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
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

Il giorno dom 17 set 2023 alle ore 02:01 Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> ha scritto:
>
>
>
> On 9/17/23 00:19, Jonas Karlman wrote:
> > On 2023-09-06 14:00, Heinrich Schuchardt wrote:
> >> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
> >> prefixed header. We have referring to a vendor tool (spl_tool) for this
> >> task. 'mkimage -T sfspl' can generate the prefixed file.
> >>
> >> Use binman to invoke mkimage for the generation of file
> >> spl/u-boot-spl.bin.normal.out.
> >>
> >> Update the documentation.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Tested-by: Chanho Park <chanho61.park@samsung.com>
> >> ---
> >> v2:
> >>      Fix a typo in a comment in tools/sfspl.c
> >>      Add Tested-by credit
> >> ---
> >>   .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
> >>   doc/board/starfive/visionfive2.rst                 | 14 ++------------
> >>   2 files changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> >> index 13f69da31e..defe2b605f 100644
> >> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> >> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> >> @@ -103,4 +103,14 @@
> >>                      };
> >>              };
> >>      };
> >> +    u-boot-spl {
> >> +            filename = "spl/u-boot-spl.bin.normal.out";
> >> +
> >> +            mkimage {
> >> +                    args = "-T sfspl";
> >> +                    blob {
> >> +                            filename = "spl/u-boot-spl.bin";
> >> +                    };
> >> +            };
> >> +    };
> >
> > This should probably be:
> >
> > mkimage {
> >       filename = "spl/u-boot-spl.bin.normal.out";
> >       args = "-T sfspl";
> >
> >       u-boot-spl {
> >       };
> > };
>
> @Jonas
> If I replace the node u-boot-spl by the suggested mkimage node, I get a
> file spl/u-boot-spl.bin.normal.out which is identical to
> spl/u-boot-spl.bin. It lacks the header that mkimage should create.
>
> Replacing the blob node by a u-boot-spl node is possible. Whether it is
> better readable is a matter of taste.

It is also a matter of default/standard assumptions and conventions,
and thus opportunities. If SPL binary filename will change in the
future for any reason, a single fix to binman would be enough for
everybody using u-boot-spl node, while blob node users should fix each
one of the -u-boot.dtsi files.

>
> @Simon:
> Could you, please, have a look at doc/develop/package/entries.rst. It
> seems not to fully describe how binman is controlled via the device-tree.
>
> * A blob sub-node for the mkimage node is not described.
> * A mkimage node which is not a direct subnode of binman is not mentioned.
> * Why the target filename must be outside of the mkimage node in my case
> is not evident.
>
> Maybe a more formal description of the schema in a yaml file would help.
>
> Best regards
>
> Heinrich
>
> >
> > Regards,
> > Jonas
> >
> >>   };
> >> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> >> index 941899a0a4..f5575ab68b 100644
> >> --- a/doc/board/starfive/visionfive2.rst
> >> +++ b/doc/board/starfive/visionfive2.rst
> >> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
> >>      make starfive_visionfive2_defconfig
> >>      make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
> >>
> >> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
> >> -
> >> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
> >> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
> >> -the below command:
> >> -
> >> -    ./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
> >> -
> >> -More detailed description of spl_tool,please refer spl_tool documenation.
> >> -(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool)
> >> -
> >> -This will generate u-boot-spl.bin.normal.out file.
> >> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
> >> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
> >>
> >>   Flashing
> >>   ~~~~~~~~
> >
