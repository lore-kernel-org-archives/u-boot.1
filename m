Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4162CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 08:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0BF84788;
	Sun, 17 Sep 2023 10:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Em+tZkx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245C685DD2; Sun, 17 Sep 2023 10:48:39 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779858144A
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 10:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d81b9f0487eso2514422276.2
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694940515; x=1695545315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vV6V7u7GwJyQjZuBYk0PAtnND3njzP/Q+29f3xcWzD4=;
 b=Em+tZkx0rELizhb+YDWF+oIBRTQ1zbO2tychl4LHZ+DupjPbzu2CNGoL2oy9C+dq/m
 FMDuIq8Kj5T3yRvzPxPCmWocAniMZMuCV9XD6/MqX2bT93KOOGcJNOXTkC4/N0lC4Od3
 JccsC4OKHYYdKx1xb3cb7ZDC7V9cK57Zh+yyscQJ3imqu/E1/9LDsmvMqUqaSbbauCNe
 AK1JURS/LIf0d/aZ/vmO2u+FlIRXqqnyjPW9F+4tv+qN9cV4kyO2aOyWo0051mf0EQ66
 cSh+jJubP7YHLGn2lgHbsQenw5X18IO5Q/jEq/sNsDA6cCPctmCAdKyw39B20IJclLLG
 CMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694940515; x=1695545315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vV6V7u7GwJyQjZuBYk0PAtnND3njzP/Q+29f3xcWzD4=;
 b=OWmVv/ASS+Z7qZQvKrd4YikKu3gNfuB0e3I2CNCCZpzE9+P0CZ5SISByYrcRZV0bAi
 ST7kPnoUTxjohyw5TYdQ+L13Ta5+yszST0mGqJZiMhWdKnqOqyYtkZANkn9n7EtblLgh
 xMp5tg3ErtvD19vBsnxKjdyLmT7DpJ9RR49axVROSzHZf6iaVqgrVAUfzIk9//EkO5Y9
 JByYPkfC3lAGqiG/zZdL/fC9Dg68xDTz8rkYnZghjwZui+9odvpF42LXg4vCrWeiVyd+
 6G77hi2Uc/Y2CjlCeX8Nfek+IRRzgIj6k3EGWQ/yxyD8S3lBhsNvduEQTfSuCbIf7oZu
 H1ew==
X-Gm-Message-State: AOJu0YwfEX008q7goCIlq5aA6ryBJPaUubO8AipPLRJGNvYdjDNMtz5E
 mL4JCwkIptckLFN4Bzw+wxUbvPVfu8DPnd/nv/4=
X-Google-Smtp-Source: AGHT+IFtfrfrKyNv3xzmz21z+kCDnOA++ZfRHlLIhew7yHoU+beQYW+g2EpdVQes5DNMnrZXZJ8zv2mNYi5qH1yqQ/M=
X-Received: by 2002:a25:316:0:b0:d47:d267:26fe with SMTP id
 22-20020a250316000000b00d47d26726femr5769112ybd.21.1694940515119; Sun, 17 Sep
 2023 01:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
 <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
 <7e069c36-fe99-3701-9572-1363b694645b@kwiboo.se>
 <047fd798-5501-42fd-a5cb-ff1d84043f96@canonical.com>
 <CAC928HaG2uc3CS0rJ_cmRZwDkJXtkP1UxMULqbeL9AvGbfRPSw@mail.gmail.com>
In-Reply-To: <CAC928HaG2uc3CS0rJ_cmRZwDkJXtkP1UxMULqbeL9AvGbfRPSw@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 17 Sep 2023 10:48:24 +0200
Message-ID: <CAC928HYtg1HWEiJZ50p1MuxG1HnD7kmM8X_5gdY0jTe6_EUavw@mail.gmail.com>
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

Il giorno dom 17 set 2023 alle ore 09:14 Massimo Pegorer
<massimo.pegorer+oss@gmail.com> ha scritto:
>
> Il giorno dom 17 set 2023 alle ore 02:01 Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> ha scritto:
> >
> >
> >
> > On 9/17/23 00:19, Jonas Karlman wrote:
> > > On 2023-09-06 14:00, Heinrich Schuchardt wrote:
> > >> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
> > >> prefixed header. We have referring to a vendor tool (spl_tool) for this
> > >> task. 'mkimage -T sfspl' can generate the prefixed file.
> > >>
> > >> Use binman to invoke mkimage for the generation of file
> > >> spl/u-boot-spl.bin.normal.out.
> > >>
> > >> Update the documentation.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> Tested-by: Chanho Park <chanho61.park@samsung.com>
> > >> ---
> > >> v2:
> > >>      Fix a typo in a comment in tools/sfspl.c
> > >>      Add Tested-by credit
> > >> ---
> > >>   .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
> > >>   doc/board/starfive/visionfive2.rst                 | 14 ++------------
> > >>   2 files changed, 12 insertions(+), 12 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> > >> index 13f69da31e..defe2b605f 100644
> > >> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> > >> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> > >> @@ -103,4 +103,14 @@
> > >>                      };
> > >>              };
> > >>      };
> > >> +    u-boot-spl {
> > >> +            filename = "spl/u-boot-spl.bin.normal.out";
> > >> +
> > >> +            mkimage {
> > >> +                    args = "-T sfspl";
> > >> +                    blob {
> > >> +                            filename = "spl/u-boot-spl.bin";
> > >> +                    };
> > >> +            };
> > >> +    };
> > >
> > > This should probably be:
> > >
> > > mkimage {
> > >       filename = "spl/u-boot-spl.bin.normal.out";
> > >       args = "-T sfspl";
> > >
> > >       u-boot-spl {
> > >       };
> > > };
> >
> > @Jonas
> > If I replace the node u-boot-spl by the suggested mkimage node, I get a
> > file spl/u-boot-spl.bin.normal.out which is identical to
> > spl/u-boot-spl.bin. It lacks the header that mkimage should create.

Images and entries are different things for binman. It expects an
image at first level, while mkimage is an entry. If you wrap Jonas'
suggestion in an image declaration, you will get what you need.
Something like:

anyname {
    mkimage {
        filename = "spl/u-boot-spl.bin.normal.out";
        args = "-T sfspl";

        u-boot-spl {
        };
    };
};

My personal and questionable suggestions:
 - Do not make binman/mkimage working in spl subfolder.
 - Do not use a generic term like "normal" in filename.
 - Do not use .out filename extension instead of .bin

Thus I would suggest something like:

u-boot-spl.starfive {
    mkimage {
        filename = "u-boot-spl.starfive.bin";
        args = "-T sfspl";

        u-boot-spl {
        };
    };
};

Regards,
Massimo


> >
> > Replacing the blob node by a u-boot-spl node is possible. Whether it is
> > better readable is a matter of taste.
>
> It is also a matter of default/standard assumptions and conventions,
> and thus opportunities. If SPL binary filename will change in the
> future for any reason, a single fix to binman would be enough for
> everybody using u-boot-spl node, while blob node users should fix each
> one of the -u-boot.dtsi files.
>
> >
> > @Simon:
> > Could you, please, have a look at doc/develop/package/entries.rst. It
> > seems not to fully describe how binman is controlled via the device-tree.
> >
> > * A blob sub-node for the mkimage node is not described.
> > * A mkimage node which is not a direct subnode of binman is not mentioned.
> > * Why the target filename must be outside of the mkimage node in my case
> > is not evident.
> >
> > Maybe a more formal description of the schema in a yaml file would help.
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Regards,
> > > Jonas
> > >
> > >>   };
> > >> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> > >> index 941899a0a4..f5575ab68b 100644
> > >> --- a/doc/board/starfive/visionfive2.rst
> > >> +++ b/doc/board/starfive/visionfive2.rst
> > >> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
> > >>      make starfive_visionfive2_defconfig
> > >>      make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
> > >>
> > >> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
> > >> -
> > >> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
> > >> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
> > >> -the below command:
> > >> -
> > >> -    ./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
> > >> -
> > >> -More detailed description of spl_tool,please refer spl_tool documenation.
> > >> -(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool)
> > >> -
> > >> -This will generate u-boot-spl.bin.normal.out file.
> > >> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
> > >> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
> > >>
> > >>   Flashing
> > >>   ~~~~~~~~
> > >
