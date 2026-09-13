Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED1AC88E66
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A1AA80DC9;
	Sun, 13 Sep 2026 23:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5Ft2vcDj2j5; Sun, 13 Sep 2026 23:20:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A914580D13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341614;
	b=Ds+ciXwAR0ylDbG/lNX5C/rMhP7f22b4BHAf9fz5tZviCrylKLVPw5U9HkZk53JZ5ahT
	 wFx1hAPa0FL6j2p1eRMvxtHeIbhrLhInfefLuPcFEvQKqrflR1Z4kocT9Sx35a3v8vAD7
	 eaIj+vvLbgBkNdql1eOBBAYGtthT3mRkNHQreXI7lE4UA9LHOBhpd+IVZteBC57exTdpO
	 64pSeQ923mWS4sMJWPGa9YM1jicY9fnDPbxf0mjRGWpVGlxNd0YVC4IDAOOm7xnXCIDix
	 gOncNCUJVmO8C3YWEFjn+0YDyHycRmsa08q1KZpvMmXTL8/v+RsGfLT6LzJlAoWtNug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=En2kMJAGM59gyhcScSthq3pmV15oZRdHLZk85ZfJ+Nw=;
	b=VTmfdBZZq8krNJQEa/6QEfEhDuv8+ncSj0MDrfwagOgyN3+xvJNE4lnr2yfOCEUDYIRr
	 YtEK6fTeh5iKdjhTL2Qx7n2Kzd8qvYy4Rbhbxhbz3qhvJTwxKThmiIBWg4zjI537iwS+u
	 NmMS19CHDr6Ow8/u7KxwWXenduupqDjhR/4DVJE+DJRyjNycimGzBw4lNmgMW3RqXlcvP
	 XYEzFr63fQb7At/ymOG5lZHXT6h9eWMMtv/0F357n92rWPALEVD0ElDHVq/UE/j9/R6uw
	 DWa5bo6SaOUNy24DssxMb+tV0HEE23lI3rauLOR5DRuFytiBoMKdv1Ans890kNHkgBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341614;
	bh=En2kMJAGM59gyhcScSthq3pmV15oZRdHLZk85ZfJ+Nw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y5hAFJ3CswsuKi78FcAkRpHlNNpbABhj9pCVGwWbqqnDxy5oA+iiF5B88QOGGt31Y
	 w3/h4ZuQS7VTeOO1WI47TXcs/vtYTZB9n2KiCYagBk5QXJJgMOXrhlPwnncdBxn+Rw
	 qnfNewFwCK8VoW3sMgTG4BW3NDCOGNktTR4BKb48YsEjjE6FO8+bsDrsNtPff8v632
	 lCbDqQuS8+Oj6znFzIokI2HXsupBIKB8y5mplceAhxVRBri3F26Ban41AmoTM0AVIE
	 CjzpYA3v19P+Wa8pBiNLYygPpLW4fEtqbPycRwnSb0k8REGFMr24KBWZ+wM20iOL71
	 OeWgqhnsGPjGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A914580D13;
	Sun, 13 Sep 2026 23:20:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C059B24D
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A696640022
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2idlDejTWqd for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:53:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 39D7D40076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314788;
 b=Jp6rDVuJkmMdFuu15ZFDhLhvB98FSdj5nmaIagWOAo1/lFGzgHNB4GvIzfTLT4KHbDwk
 wXIs/136Pdf1NRwz5rGPXMmFX/E+DfDTNslZTS2cSs+P5LyJX/0FukSGPvFJ0IziQVqko
 Mh1gu3BCllo24qeSoeKqsU4tRxsc7SMweVKDaF3BIxPl1gTW8B4jCmb/qjme82/eIYFDr
 N/naGW+YBbq5qLZYJVbs6a+wtw1fxm627vJ6GdTx+LsGeHCZ6bJ6M52o7tknJw08/WMaa
 auL9gbHTqKM5R2bdR+gBB/+J7BBBiVUyNnHgLxa1HHT5hhmu+WQkwrRjIPnxtPpVlgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=En2kMJAGM59gyhcScSthq3pmV15oZRdHLZk85ZfJ+Nw=;
 b=dYNLHMvIczyCkn2zlW1vrWbdXtgc6OiRbLKaA2h+kIp+a+WAq7LboM1J2E4+0rLfHOei
 C/YNq3Qae/0CRl31kaTNTyvx11gxUF7KrYolLa6+q1eVk1mvf2+C1/YAWAjvUMw4mAHLL
 3wdJBftU1fS2zB8JX2Ks5JB3CsALSTjmvHVjTy+DxTdd58SOY7DeoZGS50p0R0sSEK+St
 49z1Saqua2QlHGlDW89IYzpEzyvx6wAhEranzM3cMQ8mp3Nk7oyZPreQQT1/wji15RUoy
 z+0mESmVA5RKSYdVZyK7BNmUa0uwf9yJq/r2vwb1QRTP683XfNGdf5osMCiB6SRdBVg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VfRyAv3G; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VfRyAv3G
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39D7D40076
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:07 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-9120eda2195so27226186d6.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314786; x=1789919586;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=En2kMJAGM59gyhcScSthq3pmV15oZRdHLZk85ZfJ+Nw=;
 b=VfRyAv3G3XNVjZsP18sZq9teZdymXze1/PstgZgzCvCpy7oT6ES3qdDgheK4ticht8
 rGvIThv3Fw39uXL13aEE35y1LERSO5OXH2rGE2qmQV9lomo6fQ5XN4lFfZzy+JrSnJwX
 TzkyI0oEQ0Ib5E3bwWqN3eBou7STWGZKIL4KYXoL/KI10Duw7TtS0pGnL+Pk88Xl7YdR
 SUfZADgfFQ+3zOdwryUSiqhgAvbi6MTAiAlQGDkvtK16KWg3nK31RobK2g4+RP4tB/LH
 qtMhzRDMEesuCFRo98tcE60tSJZaOugPJ8wWVBZZKf4BIGNr+j2v7LIL1b8zWGMpZz5a
 UKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314786; x=1789919586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=En2kMJAGM59gyhcScSthq3pmV15oZRdHLZk85ZfJ+Nw=;
 b=DeNeNmckTvrRBn8HHbhYATn2D/Bh9oKrUfSzX5WY++ODT/4dxOk0IUJ6nNtNs2bBeD
 /QJIQdul9iL/SA2PiK0uyTBI2ujPj+IEQto5azFVvNO0QJMteB9xzyf9O0fEDFMCtoMp
 E9sfyG7oRhAQu06KT11XwxlpihHbMkwTdIkrohMkExMfASYS4npxxBGsdc7LYklTNeqe
 8BGa1sn0cLwRgO68tLMjYRSFhIN443QW43hQBnoHPk2B73GOOQNRdqZbbs+wndti7vTC
 Ved+d8kokthLrze5V+ohIO/XPf0AxMM09IxrIlcIysrpjIVNuM9d0wdryboqXjAZDjMz
 IVFA==
X-Gm-Message-State: AFuF++l9PDO57tqLgWX1dmhmPkrnQRRgU2gHLyk26nV39b9v/Pm6iACL
 0qBXCSvTSEPOFuc4eUIxvrURW1qPogJZ4X3llZgiuep5trAURdiNv1zHUqWmzQ==
X-Gm-Gg: AYBFou2BCij9pnRPJF8f14dJdtHgUiSYpDb/3a2LSZj0205DqFvWb0WnVgME/URovWe
 gXdRrkHkOvfm00UVVDl/dt7aXNPXMr90UaECtOns0HpaPmMOCXYZr6mC23+9/hXlh6/2phWG00j
 EhAl6DTPHYSDfbss9zBJcheviNMNYeC+F34yJf7gEFkVm19IsWTGcMGeGLxMPd5TMyoZ4S8UBXR
 Gr4ju7s++E1KUR4xukrUpatKL3TkjuaEOQKV5ugl1j/OlOmpJTn+CYbYGreMBkmtX1iJYGCyQ3w
 Kw3z2vIkpuL5CDRobqGUiYsosAcHulmcSapx0wdiJ+IO7bTGVCpVWE+efZ5AEWPqFHHBQ87Gc/O
 jEBh3Y28QMVw5wWfUS9UbW7sjV9fz1jY6IXYYGvk07jRq89IKuJU8y3v1MZyVzKDgymO1vXUggt
 30utIfKb4PWDtAHVMyC5VpUInXMIGTla/ZxIZDLjNL3P0Yg0ukTb1r6sHHpRHwTq+eNcDoa0/jB
 lK1+xndWwq9NwMWy95ndT8JaWydScJZ63nYS+ak4MVc0GBeqzqN
X-Received: by 2002:a0c:f413:0:b0:912:77f:a696 with SMTP id
 6a1803df08f44-91226b5536fmr28782266d6.9.1789314786633; 
 Sun, 13 Sep 2026 08:53:06 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d3a50sm72993386d6.40.2026.09.13.08.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:53:06 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH 0/3] board: beacon: Remove i.MX8M Beacon EmbeddedWorks boards
Date: Sun, 13 Sep 2026 10:53:00 -0500
Message-ID: <20260913155303.84201-1-aford173@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Remove board support for the Beacon EmbeddedWorks i.MX8MM, i.MX8MN and
i.MX8MP development kits. Each patch removes one board along with its
defconfigs, config header, U-Boot device tree overlay, documentation and
Kconfig target. The final patch also drops the Beacon documentation
index since no Beacon boards remain.

Adam Ford (3):
  board: beacon: Remove i.MX8MM Beacon EmbeddedWorks Devkit support
  board: beacon: Remove i.MX8MN Beacon EmbeddedWorks Devkit support
  board: beacon: Remove i.MX8MP Beacon EmbeddedWorks Devkit support

 arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi  |  130 --
 arch/arm/dts/imx8mn-beacon-kit-u-boot.dtsi  |   88 -
 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi  |  196 --
 arch/arm/mach-imx/imx8m/Kconfig             |   33 -
 board/beacon/imx8mm/Kconfig                 |   15 -
 board/beacon/imx8mm/MAINTAINERS             |    9 -
 board/beacon/imx8mm/Makefile                |   12 -
 board/beacon/imx8mm/imx8mm_beacon.env       |   19 -
 board/beacon/imx8mm/imximage-8mm-lpddr4.cfg |    8 -
 board/beacon/imx8mm/lpddr4_timing.c         | 1979 -------------------
 board/beacon/imx8mm/spl.c                   |  128 --
 board/beacon/imx8mn/Kconfig                 |   21 -
 board/beacon/imx8mn/MAINTAINERS             |    8 -
 board/beacon/imx8mn/Makefile                |   15 -
 board/beacon/imx8mn/imx8mn_beacon.env       |   25 -
 board/beacon/imx8mn/imximage-8mn-lpddr4.cfg |    9 -
 board/beacon/imx8mn/lpddr4_2g_timing.c      | 1440 --------------
 board/beacon/imx8mn/lpddr4_timing.c         | 1433 --------------
 board/beacon/imx8mn/spl.c                   |  144 --
 board/beacon/imx8mp/Kconfig                 |   16 -
 board/beacon/imx8mp/MAINTAINERS             |    6 -
 board/beacon/imx8mp/Makefile                |   13 -
 board/beacon/imx8mp/imx8mp_beacon.c         |   34 -
 board/beacon/imx8mp/imx8mp_beacon.env       |   19 -
 board/beacon/imx8mp/imximage-8mp-lpddr4.cfg |    9 -
 board/beacon/imx8mp/lpddr4_timing.c         | 1881 ------------------
 board/beacon/imx8mp/spl.c                   |  126 --
 configs/imx8mm_beacon_defconfig             |  151 --
 configs/imx8mm_beacon_fspi_defconfig        |  152 --
 configs/imx8mn_beacon_2g_defconfig          |  141 --
 configs/imx8mn_beacon_defconfig             |  150 --
 configs/imx8mn_beacon_fspi_defconfig        |  150 --
 configs/imx8mp_beacon_defconfig             |  179 --
 doc/board/beacon/beacon-imx8mm.rst          |   55 -
 doc/board/beacon/beacon-imx8mn.rst          |   53 -
 doc/board/beacon/beacon-imx8mp.rst          |   52 -
 doc/board/beacon/index.rst                  |   11 -
 doc/board/index.rst                         |    1 -
 include/configs/imx8mm_beacon.h             |   40 -
 include/configs/imx8mn_beacon.h             |   28 -
 include/configs/imx8mp_beacon.h             |   25 -
 41 files changed, 9004 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-beacon-kit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
 delete mode 100644 board/beacon/imx8mm/Kconfig
 delete mode 100644 board/beacon/imx8mm/MAINTAINERS
 delete mode 100644 board/beacon/imx8mm/Makefile
 delete mode 100644 board/beacon/imx8mm/imx8mm_beacon.env
 delete mode 100644 board/beacon/imx8mm/imximage-8mm-lpddr4.cfg
 delete mode 100644 board/beacon/imx8mm/lpddr4_timing.c
 delete mode 100644 board/beacon/imx8mm/spl.c
 delete mode 100644 board/beacon/imx8mn/Kconfig
 delete mode 100644 board/beacon/imx8mn/MAINTAINERS
 delete mode 100644 board/beacon/imx8mn/Makefile
 delete mode 100644 board/beacon/imx8mn/imx8mn_beacon.env
 delete mode 100644 board/beacon/imx8mn/imximage-8mn-lpddr4.cfg
 delete mode 100644 board/beacon/imx8mn/lpddr4_2g_timing.c
 delete mode 100644 board/beacon/imx8mn/lpddr4_timing.c
 delete mode 100644 board/beacon/imx8mn/spl.c
 delete mode 100644 board/beacon/imx8mp/Kconfig
 delete mode 100644 board/beacon/imx8mp/MAINTAINERS
 delete mode 100644 board/beacon/imx8mp/Makefile
 delete mode 100644 board/beacon/imx8mp/imx8mp_beacon.c
 delete mode 100644 board/beacon/imx8mp/imx8mp_beacon.env
 delete mode 100644 board/beacon/imx8mp/imximage-8mp-lpddr4.cfg
 delete mode 100644 board/beacon/imx8mp/lpddr4_timing.c
 delete mode 100644 board/beacon/imx8mp/spl.c
 delete mode 100644 configs/imx8mm_beacon_defconfig
 delete mode 100644 configs/imx8mm_beacon_fspi_defconfig
 delete mode 100644 configs/imx8mn_beacon_2g_defconfig
 delete mode 100644 configs/imx8mn_beacon_defconfig
 delete mode 100644 configs/imx8mn_beacon_fspi_defconfig
 delete mode 100644 configs/imx8mp_beacon_defconfig
 delete mode 100644 doc/board/beacon/beacon-imx8mm.rst
 delete mode 100644 doc/board/beacon/beacon-imx8mn.rst
 delete mode 100644 doc/board/beacon/beacon-imx8mp.rst
 delete mode 100644 doc/board/beacon/index.rst
 delete mode 100644 include/configs/imx8mm_beacon.h
 delete mode 100644 include/configs/imx8mn_beacon.h
 delete mode 100644 include/configs/imx8mp_beacon.h

-- 
2.53.0

