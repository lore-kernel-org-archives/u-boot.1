Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE9C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 00:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F06B881EA;
	Fri, 12 Jul 2024 02:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cnwViKdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACD5881C3; Fri, 12 Jul 2024 02:31:42 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458598845A
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 02:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-595712c49ebso1869008a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720744299; x=1721349099; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfLMoKc9tBHKk3JS3CWbl/n2GwYsw4ltYCz/8hl//mI=;
 b=cnwViKdWOqkP8vG/4JZ0rn8Sf7FBez7f4ON2z9AeFn5gIQozmNI3mnDFCYWzr3y8Oi
 5m/M18mwHuAf684iVS8Ui1VcJZByn3orCAjXLjv32mH4PLrDvZAoyq3fOHWz33p5uEo+
 3QE0C2OTlHLAw5Ax6Zg2lNPm8XPCq2Y3DcJYaiVaKPV2Q26tDiaBv1Sj9++z8JYNlgkt
 A/FuC6tyrxx1oBBh0p9HTgJNJF40OCrB92pxaTUhVdHBvCWI5cZtnewy5rtgwrsZjV4J
 MrTTxKAZH7C1WTaJflpb89J4aEkqbGsEM5WMYeWnKTsU4Faj1goEK8Uc3CvQ/cmOby6a
 tcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720744299; x=1721349099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfLMoKc9tBHKk3JS3CWbl/n2GwYsw4ltYCz/8hl//mI=;
 b=e4wzqHUkfNNuFMb7+5HYHLWfZwvapvvB4o+oagnmE+XlHf5XyEJKvX0jS+F1vaevNN
 3b8bD8oAlum3BKICDqJEfIsT2REpR2ptsBNA0SH24iQ8AH0N1zWAwvdgGVhOSv/TPNnJ
 0v8PkctwPaZ7rQg1MtNwHP1b/HJeYUga37V1LS4iRvvz9lk0hiwe5/apdmS+bVKxUydZ
 bJN0YIKOlnIGLJ2do5GaddPDDyr+Z28ZmXK6AoQ7IM7nQRkwLUEWxZEQPDoB9igULMHL
 yO7N6tV8fvTd3gq/YU2q/m+vaVTQFNo+nnwWqJrnUx/oxwyHZE+RGLFtpCBrhJvDf2xI
 wfPA==
X-Gm-Message-State: AOJu0YwSTPaJsY7W5DpxqKilU9kPzJTJtEfdbpu8291C83CYQu8uKbYj
 ZheFa1Zgd6TX3NHCWKxMRnZn+IS/vmujZV/cfGVV20uEtPO4qwAwet46NbFk6DJo6/TKiwddzLO
 4qwLN5dWCynwx+nCHusYoro5ZRno=
X-Google-Smtp-Source: AGHT+IF4iZh9rMXcRmTQQz4U5t+R2L7SSNxyOCIcIoZU2W60KItY/DkUNz5SXkBAgyLDsLOORet9RTEDfl4j34Q3/CA=
X-Received: by 2002:aa7:d0c2:0:b0:57c:aab2:7311 with SMTP id
 4fb4d7f45d1cf-594bc7c7e04mr5853636a12.29.1720744299330; Thu, 11 Jul 2024
 17:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
 <20240711224620.GP38804@bill-the-cat>
In-Reply-To: <20240711224620.GP38804@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 11 Jul 2024 17:31:27 -0700
Message-ID: <CAJaLiFw8NYAoGSRoyVJ8hh5FC4O-DskvnCb2Sfc9c8dWMyKo-Q@mail.gmail.com>
Subject: Re: env: CONFIG_DEFAULT_ENV_FILE and CFG_EXTRA_ENV_SETTINGS
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Phil Sutter <phil@nwl.cc>
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

Hi Tom,

On Thu, Jul 11, 2024 at 3:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Jul 11, 2024 at 01:31:34PM -0700, Tony Dinh wrote:
> > Hi Tom,
> >
> > I'm trying to move some envs from a board header file to the default
> > env file. I recall that the envs in CONFIG_DEFAULT_ENV_FILE are
> > appended to the envs in CFG_EXTRA_ENV_SETTINGS. As you mentioned here
> > before:
> >
> > https://lore.kernel.org/all/20220810170439.GJ1146598@bill-the-cat/
> >
> > But it looks like envs in CFG_EXTRA_ENV_SETTINGS are completely
> > erased, and then the envs are populated with what's in
> > CONFIG_DEFAULT_ENV_FILE.
> >
> > Did I understand the usage correctly?
>
> Can you please post your I assume non-functioning-correctly patch? For
> example, dragonboard410c has both
> board/qualcomm/dragonboard410c/dragonboard410c.env and sets "#define
> CFG_EXTRA_ENV_SETTINGS BOOTENV" in
> include/configs/dragonboard410c.h
>
Here is the patch. Note that this patch depends on a previous patch
(irrelevant to this test):
https://patchwork.ozlabs.org/project/uboot/patch/20240708043904.5100-1-mibo=
dhi@gmail.com/

diff --git a/board/Synology/ds414/ds414.env b/board/Synology/ds414/ds414.en=
v
new file mode 100644
index 0000000000..03875e4e93
--- /dev/null
+++ b/board/Synology/ds414/ds414.env
@@ -0,0 +1,3 @@
+# Boot to original firmware if bootstd failed
+#
+bootcmd=3Dbootflow scan -lb; run bootcmd_legacy
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index 6391c43474..9dd07f01c9 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -55,6 +55,8 @@ CONFIG_CMD_UBI=3Dy
 CONFIG_ENV_OVERWRITE=3Dy
 CONFIG_ENV_SPI_MAX_HZ=3D50000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_USE_DEFAULT_ENV_FILE=3Dy
+CONFIG_DEFAULT_ENV_FILE=3D"board/Synology/ds414/ds414.env"
 CONFIG_ARP_TIMEOUT=3D200
 CONFIG_NET_RETRY_COUNT=3D50
 CONFIG_NET_RANDOM_ETHADDR=3Dy

Now, I kwboot the newly built u-boot. In the serial console, I set the
envs to default expecting only the bootcmd is replaced. But all other
envs that were in CFG_EXTRA_ENV_SETTINGS got erased.

DS414> ver
U-Boot 2024.07-tld-1-g2b2b95c77b37-dirty (Jul 11 2024 - 17:10:09 -0700)
Synology DS214+/DS414 2/4-Bay Diskstation

DS414> env def -a
## Resetting to default environment

DS414> printenv
bootcmd=3Dbootflow scan -lb; run bootcmd_legacy

Environment size: 47/65532 bytes
DS414>

All the best,
Tony

> --
> Tom
