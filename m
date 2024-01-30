Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755FFC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BF887D9B;
	Tue, 30 Jan 2024 13:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bmYYJJso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D0F87D6B; Tue, 30 Jan 2024 13:49:36 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3AF87D18
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40eebe7767cso31370705e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706618968; x=1707223768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZXo2YjXtoozcNJ18ESXIxMj6BbyD9yg5EXylra0Uu0=;
 b=bmYYJJsoI8nhWmAyUWX0CAGTYSXhIZr7rMU0HTiLTEF0iTD7aKewZTA1o1QCpIvgLO
 xHF/ODiGBnfrxY6fjKNQSk179UPbAnCYvAiQf67WI+/sCizoVyAQolqXpesZ0I9F1OZW
 oXKeE54hkJfER7KPcKTYIkaTJzNeUwJDAkjPYVCruCuTUUmXQh6HCCA1jbuvqS49TMKi
 VK+AMTcYw9ZCifjF4h4HOPqSbORl4IEHVAD/soxZGzwvWlubAgjpu8aC5B/KUC84Pyy2
 pE1g+5ObmfEip0SsTDq+Ot+BdmMf80KpXITJbKYr99N2YTuqMJQm/M7KP2hPuTXu87fG
 T3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618968; x=1707223768;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZXo2YjXtoozcNJ18ESXIxMj6BbyD9yg5EXylra0Uu0=;
 b=BBd/aFWhNw16tXHGbRkJ4vvSurspzgmbeCyVmwUxVRW3SfhteBmi7iF5ZLsNvPIn3f
 xGy8pb8JZJ6FYyCxf9dTanBix9DybOHcr9T4Akdha5L7qYfUWffyY2qjLxYsUkQ7bJ8s
 heitiH1YYQg0SURkOhEWvPN3bbO5TgMWRXUmPbrqgsid30jroPQD5X2tWeujqRakv8n6
 axJSd9ubzY63WTguKxrzfeBTOWGvZZJ7M3bWv1aDJ9yFeMgDc3+joQMoQMMVZKEbCl1h
 OeR/rKk41iL9zPXWI348OJvC7jNQAqHe7mHymi/xnDjqBkrJLOUMsW2s3AlrUcQByHzQ
 9yKw==
X-Gm-Message-State: AOJu0YzN76qnMhRE/NtybL8PVPwlR70bDsuZ97IcIjW01JduV6GiB27t
 5uo+aSVnQ+FWpZ636oJxG1aARWzjDnOrgqB00PX8jc306dTohmyc
X-Google-Smtp-Source: AGHT+IHkdTZODpsW1BfkY5tFq1Kfd4WTpQTAzjOj/qP5fmhvK/zIgX7iAjUXGWGjfvkyj5OFpA48Eg==
X-Received: by 2002:a05:6000:1544:b0:33a:ed19:9f37 with SMTP id
 4-20020a056000154400b0033aed199f37mr5187460wry.47.1706618967653; 
 Tue, 30 Jan 2024 04:49:27 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:2d72:bfc1:4136:432c])
 by smtp.gmail.com with ESMTPSA id
 e10-20020adfe38a000000b0033afcc069c3sm1202764wrm.84.2024.01.30.04.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 04:49:27 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i . MX
 U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,  Yannic Moog
 <Y.Moog@phytec.de>,  u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
In-Reply-To: <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com> (Primoz Fiser's
 message of "Tue, 30 Jan 2024 13:25:15 +0100")
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
 <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com>
Date: Tue, 30 Jan 2024 13:49:26 +0100
Message-ID: <874jev2dgp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Jan 2024 13:53:57 +0100
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


Hey,

> Can you re-check, please?
>
> Maybe check your include/generated/environment.h?

Thanks for checking. It is strange that you do not reproduce that one.

My include/generated/environment.h looks like:

--8<---------------cut here---------------start------------->8---
#define CONFIG_EXTRA_ENV_TEXT "bootenv=3Dbootenv.txt\0bootenv_addr=3D0x8350=
0000\0console=3DttyLP0\0fdt_addr=3D0x83000000\0fdt_file=3D\"oftree\"\0fdto_=
addr=3D0x830c0000\0image=3DImage\0ip_dyn=3Dyes\0loadfdt=3Dfatload mmc ${mmc=
dev}:${mmcpart} ${fdt_addr} ${fdt_file}\0loadimage=3Dfatload mmc ${mmcdev}:=
${mmcpart} ${loadaddr} ${image}\0mmc_apply_overlays=3Dfdt address ${fdt_add=
r}; for overlay in ${overlays}; do; if run mmc_load_overlay; then fdt resiz=
e ${filesize}; fdt apply ${fdto_addr}; fi; done;\0mmc_load_bootenv=3Dfatloa=
d mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}\0mmc_load_overlay=3Df=
atload mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}\0mmcargs=3Dsetenv b=
ootargs console=3D${console},${baudrate} earlycon root=3D/dev/mmcblk${mmcde=
v}p${mmcroot} ${raucargs} rootwait rw\0mmcautodetect=3Dyes\0mmcboot=3Decho =
Booting from mmc ...; if run mmc_load_bootenv; then env import -t ${bootenv=
_addr} ${filesize}; fi; run mmcargs; if run loadfdt; then run mmc_apply_ove=
rlays; booti ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot load the DT;=
 fi;\0mmcdev=3D1\0mmcpart=3D1\0mmcroot=3D2\0net_apply_overlays=3Dfdt addres=
s ${fdt_addr}; for overlay in ${overlays}; do; if run net_load_overlay; the=
n fdt resize ${filesize}; fdt apply ${fdto_addr}; fi; done;\0net_load_boote=
nv=3D${get_cmd} ${bootenv_addr} ${bootenv}\0net_load_overlay=3D${get_cmd} $=
{fdto_addr} ${overlay}\0netargs=3Dsetenv bootargs console=3D${console},${ba=
udrate} earlycon root=3D/dev/nfs ip=3D${nfsip} nfsroot=3D${serverip}:${nfsr=
oot},v3,tcp\0netboot=3Decho Booting from net ...; run netargs; if test ${ip=
_dyn} =3D yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; if r=
un net_load_bootenv; then env import -t ${bootenv_addr} ${filesize}; fi; ${=
get_cmd} ${loadaddr} ${image}; if ${get_cmd} ${fdt_addr} ${fdt_file}; then =
run net_apply_overlays; booti ${loadaddr} - ${fdt_addr}; else echo WARN: Ca=
nnot load the DT; fi;\0nfsroot=3D/nfs\0"
--8<---------------cut here---------------end--------------->8---

Note that fdt_file=3D\"oftree\" which explains the issue on my side. Do
you have a similar environment.h?

What u-boot commit are you based on?

Mathieu
