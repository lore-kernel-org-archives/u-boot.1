Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BD8CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CE4843D6;
	Thu, 27 Nov 2025 15:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bfZT7Xiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B00843D8; Thu, 27 Nov 2025 15:02:50 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5FB8437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-37d056f5703so8995611fa.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764252168; x=1764856968; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrCk01vanYtQhk3nRDA5+ZR+Embwtyi6twr9brcWgvI=;
 b=bfZT7XivcmIX+NXQyX+DUah/U/GFEuJXJgWlxmQd0xzBrlS5/oqTWp0wocrkRg2OXP
 fT65s2ejZMmXAuLcJgvKVJnL2vf69OVnldo/wNOCPTWpi9HqE/1y91saBf017EPDB/kY
 k/rIQKXJWWwQHmqIPBFzo3kUtK0lrZtGMrlrXygHrdPgMua1tMOJP2toR4JUmpygN5uT
 FHcomeeLk5krNxvObDTwmf5iGO0Eeil+e4HwX3HcyjAuDc4FGcSDotG1WR1LVlvC51Ed
 mybNUdzqlWig1sFAj1F7TZYLuBGu8UFCM2KDIkjrYJbytsCmg/7qHEykS2EYzTs2RrmB
 jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764252168; x=1764856968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HrCk01vanYtQhk3nRDA5+ZR+Embwtyi6twr9brcWgvI=;
 b=AjmbIJ3bfkiJmq/99u9Bl/cxJDwQtym/8zLg90duFfSkt63LVP7AHoG2MTnUyU8fnz
 ZficHhl6twTI5Vj0epg6Qsgd0aIYvqMTDpzMLSZZ1Itp1gLColqbt7sqD9ydPPLosu+B
 ox5whnDzkaCe1HM8nTpf8yTEheC8XAzBOdu50RylHC2GPRNDk1THMncWtPbHh4PeT1iV
 Qi5giF8HuaNWV3wRjmTAEBEfQu5aJMfGjulQFJqUEIpgBbOtZFWmbTq3yEkiMoKdpdHA
 JTE0zOlaoD+k9hmPKXKca/5WcQxTJvIQ3BR08TuQFvX72ManvSOKcD1mt6WURhrx71zW
 xKNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkip2Uv5xClXMKq2Ds4PF0Ypa/ItLzb7mjqd/BBrMF4b4Ca78kIv/sfIl1J6mbajcyqyKENhU=@lists.denx.de
X-Gm-Message-State: AOJu0YygN3JVWHwo8A5rKKMO+8RSDsUUApcz5X+9YE8lgiQDVbbTtcrV
 pcbNIyLO+LiLBO4HG8sgfesI7NC16yAA9dskfPvSMypI73eX9yJg9MEeOYGRYwJ4H+nATrUbybf
 yECG6pcwXjBW3mfoU9Q6PhIyGgrwqito=
X-Gm-Gg: ASbGncsCRDRYONFDnDtpIgNOUZLDGEUzqWy7WWTvuF0biI/afIDRqbHDSh/tZoFMzhS
 PseGb5TagFafdEWtoxSk/Ray4d00IjS7AS8r/6hb0eLzl4SquyE7lz4HIooIGfhBTsr7L5Zad+r
 J9+zDyMdn52hviA2Hab3fcqdO6EZGSf/WxdotovTwj94qOd0lnuE4HifTZHLBGnYU/k3ROTte0I
 +MJ6gb4lMqFRdpI7vxoDrEhKaIhAcT1wW6djZCKC+jrBQFsq1oJ60qMgEuz5aUalBqyAmZu/hxT
 90nP/vsiC/Mt+P3nLXqm7HMJhG8=
X-Google-Smtp-Source: AGHT+IGu98qthqpqwnG5iDLg8e1Ok1VHuTYQc513pTsjv20zjXLvp2jqzzI8Hkn97Wyq851awLbQhDwDo7RrrxM/aww=
X-Received: by 2002:a2e:8a87:0:b0:37b:9de3:28a1 with SMTP id
 38308e7fff4ca-37cd9187359mr57597661fa.2.1764252167445; Thu, 27 Nov 2025
 06:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
 <20251125163524.GQ2125796@bill-the-cat>
 <2db22e-6926d980-129-2e0bef80@48422766>
 <20251126145621.GS2125796@bill-the-cat> <2fe6d5-69284500-3b-1b12cb00@46524667>
In-Reply-To: <2fe6d5-69284500-3b-1b12cb00@46524667>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Nov 2025 11:02:36 -0300
X-Gm-Features: AWmQ_bkAWY2JCfZ-EQxdxlpw780FeGcUzbqc1dJfBX6zylKr48FeKB-rldSV4wE
Message-ID: <CAOMZO5DcoH2NvA_AhQbCKb_BLJKk9+=NgRmEbJE84k_dxfPWyw@mail.gmail.com>
Subject: Re: [BUG] silent hangup when debugging lib/fdtdec.c
To: "alexander.feilke@ew.tq-group.com" <alexander.feilke@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
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

On Thu, Nov 27, 2025 at 9:33=E2=80=AFAM alexander.feilke@ew.tq-group.com
<alexander.feilke@ew.tq-group.com> wrote:

> I also have a mx7dsabresd but I cannot bring it to boot with a master bui=
ld unfortunately.

Just tested booting the top-of-tree U-Boot on a mx7dsabresd and it boots:

U-Boot 2026.01-rc3-00004-g0ae3dc6809ff (Nov 27 2025 - 11:00:04 -0300)

CPU:   Freescale i.MX7D rev1.0 1000 MHz (running at 792 MHz)
CPU:   Commercial temperature grade (0C to 95C) at 36C
Reset cause: POR
Model: Freescale i.MX7 SabreSD Board
Board: i.MX7D SABRESD in non-secure mode
DRAM:  1 GiB
Core:  107 devices, 21 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (128s timeout)
PMIC: PFUZE3000 DEV_ID=3D0x30 REV_ID=3D0x10
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial
Out:   serial
Err:   serial
SEC0:  RNG instantiated
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot: 0
=3D>

>
