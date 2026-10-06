Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E182CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AFE080DA4;
	Tue,  6 Oct 2026 15:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7DGtmMAh1EV; Tue,  6 Oct 2026 15:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 08E7480D83
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299497;
	b=PCKzdEFym0D1TocNmep+Rh3Jycy5AjvvVfVyswHCvnQ+MAKbXE5NV/t03IO7mwacGAcE
	 njrBrZZArjCAK5knNuZivlEz7qZWoaJrR5W93R2yMEhd9mLK3PNM4ixHGAcV4jCEp6CAm
	 nmXD8De5eaZyfIipxfI0q/3Mts2JQGOQoBh4guKO/GQcc4EitVoZAtOvt7Kua0bkr1wZZ
	 QWeSqEyyAYUAX0wl+lhuYZ5HhuCDX0jAykpkmDcoNsrff3+JGdHlGDZKjXFRTm9Srand1
	 tJ4Gk0+0iL351fUJl6Oq2VHoBl3NXEomBO3B5KZypx3q+ivwQiJuCXevxqQgXdqMXrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QlWPKAXW+00WtVofL73fXYvFO2onA1Uc05l697OF3RE=;
	b=bSZIroi2kGV5HtcniI0EHWAGSPlh8HwkVuQb02EzSjDkB22FVTwqOYevrq+jCzoGfIQf
	 T8/OYeTRBThfogmp5A0iwMYoH9m2PtSxwPUq7FXUDrOBeLTwiplOv1mdDfJYujHJqIiV8
	 JZ7kpFClpDRAzEWaoE+j43TXT/LJ6eigJlIBB5ZObaZx5AxM/aAbiElG3yV/wvE49k6Kq
	 M52VZOt4aP+QwVJJXUa5Nq1InuWztQACi+/bkGBlnIJdBt3MYVUIbOb0l6nY4jTuvH8Pw
	 V/tbEVtADiOGWaiXg51UPhWc7QvQkn8Mf0xocevb38YO6TIMnvaBEZ5CneEdY2jA2pQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299497;
	bh=QlWPKAXW+00WtVofL73fXYvFO2onA1Uc05l697OF3RE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h2jJoDDZvqFiBkbWzkwlu7XfCUGQPvX7Zn+ISv7apQCOhstivngbMv3Dfeuls+mE4
	 8fnmAFLFG3PMD1VqEqWhK4awJMIjFgAtp020ZApgA1a+NCP4Flxtu6nVV2Wgzm0Xk/
	 g3+06mcEkfqkBPZGjJ1deQVpsMrtichPE4tX9J1kiyC4CdSBHLIzxoh2bB76r2mv+j
	 8Km+PWECAtZbCvi9fBXT+N4YO/4DUYLgrQbPAZXedZcEoKdVd7jnV+602EgsKq1FNC
	 50E+sLOuA+4ltIul7ChwASOIFYNhWVgjcFsGA+/HOKngpk/seU5VqSNQFMsxlhsZP9
	 ZBKIjp3GwnGDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08E7480D83;
	Tue,  6 Oct 2026 15:11:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F2375
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CB6540274
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKg2pjlbv9lN for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C97B4027A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298919;
 b=nPr9X0BOFMBGcCpMCHZAwaYqyBPovzDgiJgJ5iRd8oR25JcOEal3GOncpi+UmbHFp8BR
 lAEKvyB7YJ9jjb+ScyMw2PdViugwyObMwhqVcUr3Wvj5kaZjGl4E5KtLHFc7OV/IXAXBl
 VeS7rmZoZ6i6XNWhC80hI+B/hk3LxIQTxzMiMezOGGLsLs8eJAWvDTksaH0RwUxgapVk6
 vbER8bGaxVg4+2daEPOqQWPE2dWWqtHjnirtutSn2KNIioU1dhzyDyOXSQ9p5pwW5mAVE
 DUd/BtJmgbUejvCaUtY0WpPd7LRK0kdUlg5YzakJ1rHcEPLhShDQ0NZ1EZp6aB7jsdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298919;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=QlWPKAXW+00WtVofL73fXYvFO2onA1Uc05l697OF3RE=;
 b=mVo6NSq1Z4H2j/0R6p9zNtlNZJ7/PlLyeO0qtIWVvG1JoTz5+Kpxl05BaiwFTfR9DtV2
 qvIdY7+BdrMHhWOEmLpdIQr2zcY7MvH7tigipuy3sAicn7MV/5QdI9EPQRw6mHcYbihk1
 aQTB8sxgSSGgvQyFMXnSVKhoVIee72QVwlEfQxG3fqnLeCjGRn19VGfv+o/OLTZOLLk66
 eGJHHqYQajEslwwC05cHBMl1vB1XmGk4gZKp1Y6isq75We7m9nFRmv5rv1/6RKACEiPQP
 A6stjTGiKY/Adzo79KZjrKWzviTNEhexHTr6KORrzLD7ksHQ618ryaONXWE1PQxwFLw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=B3eDHBbD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=B3eDHBbD
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C97B4027A
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:01:56 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so15596645e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791298914; x=1791903714;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QlWPKAXW+00WtVofL73fXYvFO2onA1Uc05l697OF3RE=;
 b=B3eDHBbD74EXBGuKAu09KhmHYDbVhkDIOsYTTvfp8yRlS1lbmLit1pscLG4AiOSIL4
 Aoxp0bgCYX6xArUf7RBQTYk5Omx6ENKw/mjuqS8JU0sK2EPHEr0ceP4ojrnmFSOrQRv+
 w7W8OzMnFOO15w772oCd5cs5yG8hoA1Rfg8e8y/E25C+g0SXBb+RIBOvkBtv9w/jEN/W
 xyRbgoR/z4xT1FylffIT3/L39jebHdZaspuqoUok0jyyaJ8qb26EewmuPIAQsmGC6NPj
 LxWgj7A7zWMrgu0lRyg7K2ltEeCKxyGYk71fPvVFYOT71M2sSYNLuaaBm1bZemSvFBlb
 gWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298914; x=1791903714;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QlWPKAXW+00WtVofL73fXYvFO2onA1Uc05l697OF3RE=;
 b=QvkMfy/FMhE43FExpPLarf+P7uoyLbnzXWG6z2sItia5fHZbG2WIB9Ii5NmtXY/tOP
 yXs2XVkW9BCpMUWhO1x1EJVzCaeoHansBm/NS0UvLhyOR7AtMgSNbvKjjjfQt+x0hgZh
 DdbHzx9WTGbpJjNhZe6inIq2rqfl+SZGvDlPQchR9t7vHiQHLvYhBoPCRJq/D09HmV3a
 ulcJy0xZ76gbOyKgiSOQ63so2IBTx6G882z00CF22cFpxDatt5/VjnpQphvJTZ1dMPIC
 z4+DADAHYnorLI2GScl+YVdT+KML4/+kMMrs1ofLCG6zM7lxALgT7lxHgOUmp9Be1lJO
 mfOg==
X-Forwarded-Encrypted: i=1;
 AKwUvByIFm2YOD4hEztQOZ4xZcdHLEz7yS+hPdWlfR3ZMkamTXo4IrCzpmyVjWN94sIIlP+kgO8Dlpg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n/OIkGvK9jZ4GX3iR7igh+RO4aZE/GEbq1gPXzsIHirttNBFzb
 QzP4VUX9IdobUhtfWmdFX/vlYagDKYQeub1Pl9fY/BT8Naz2yssJ5z1GeHrJ4eso3Rc=
X-Gm-Gg: AYBFou3a9uIbY/Z961UpjKoe3seA+c9PCXgdV3U3t+Iw3y/rGFX24uCz3vNSvDp03lV
 hkewYeqmgq/iLRl547J4LYvVsyxBPjQZLAmm2QnslbR7VGyjy/ldKytJJKws6pOUNfRE8eY28rQ
 Nkt/qt+WYcLUURufdglgg3mANtDdrKm9vmIgkbg+sw/PQsZ9QOgvPSYGs9HrOLcRRNM3vI4YbxM
 8Wc/kMIlwVVZ0z2FeqP6ymilJCPPM/Xty8vqhx4Kw99NZ1ZfJ1rebIp0mP4qFzl34FcNE91U1GG
 QVaPwYQuNt5J85tbufqY9DZGqHOcZSIXJOHOjbdP5AynqKfokpidI8W4VHiQrZavlhOYfRa0w+J
 G3PYcPHKTyVE7t4ux5zhQ4/XjQAWS30CnhF9YUD+m0HhwHlJr/72a1mfYoBvGFFnQl3zOTyANqC
 tT98I7OwF/tmXG9QvGvBSA7OyxAbRvNDI1gTdFnjKFR4aM4F6VRoKk1s9EDLyFoxEu6PpT6JTPP
 TvKnuAc0UJObOO9Uy5w79tPmWMxLpoXViw5yHo/eJVUrXmtNBkhe9S2VvrpYYNWtAlIpmE0Z9sx
 +hkIELBxTKO0
X-Received: by 2002:a05:600c:1394:b0:49f:ed8c:6cad with SMTP id
 5b1f17b1804b1-4a17b551dc6mr26910155e9.19.1791298913926; 
 Tue, 06 Oct 2026 08:01:53 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm357622075e9.4.2026.10.06.08.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:01:53 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v4 0/5] Add Genio 510 and 700 BootROM download agents
Date: Tue, 06 Oct 2026 17:01:44 +0200
Message-Id: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33RQW7DIBAF0KtYrEsFg4Uhq96j6mLAQ0MVxykQq
 1Hkuxc7XkRNleWXRo8/w5VlSpEy2zVXlmiKOY7HGtqXhvk9Hj+Jx75mBgK0sFJw77GOED+fckm
 EAx+KUVbwHnmAYFqp0QEaVoFTohB/Vvz945bz2X2RL4u4TST6PtdXy22MOczE/TgMsewa7MGJI
 CgAAmqHJI3V1FpF1nSqJdWhCpLcQg2UM651d81WVj2WzacDD5iLG8fCJ81r7145NBI76uHN4eU
 QXaLX2oAtlfcxlzFd1vNMcm244e2zS0yyyq7TwZIS6JV5lCe400A91aBqJoBudWfQg/1HU3eae
 vpLk6oa0rKDr0uj+KPN8/wLaYrKmxYCAAA=
X-Change-ID: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
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

Genio 510 and 700 need a way to provision blank eMMC and recover boards
with unusable boot firmware. Add RAM-based fastboot download agents that
can be loaded through the MediaTek BootROM download protocol without
relying on the installed bootloader.

Fastboot in U-Boot proper is preferred when the complete download agent
fits the platform's BootROM payload limit. It provides U-Boot's shell and
boot facilities as well as flashing. The SPL variant offers a smaller
executable payload when including BL31 and U-Boot proper would exceed
that limit. Both require an external DDR loader and run fastboot from
DRAM after DDR initialization.

The two paths start USB fastboot at different stages:

   Fastboot in SPL                   Fastboot in U-Boot proper
   ---------------                  -------------------------
   BootROM USB download             BootROM USB download
   (host -> SRAM)                   (host -> SRAM)
     |                                |
     v                                v
   DDR loader                       DDR loader
     | Initialize DRAM                | Initialize DRAM
     | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
     v                                v
   SPL                              SPL
     | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
     v                                v
   eMMC provisioning                BL31
                                      |
                                      v
                                    U-Boot proper
                                      | USB fastboot <-> host
                                      v
                                    eMMC provisioning

This series is based on upstream/next. Generic SPL fastboot V6, applied
to u-boot-dfu-next [1], remains a prerequisite.

[1] https://lore.kernel.org/all/179015047421.246261.8241758059641679018.b4-ty@kernel.org/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v4:
- Use standard SPL/proper phase prefixes for the fastboot DA options.
- Simplify DA FIT-key handling and include the board-hook declarations.
- Enable MMU and CPU caches to improve SPL fastboot download throughput;
  disable D-cache and the MMU before handing off to the next stage.
- Link to v3: https://patch.msgid.link/20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com

Changes in v3:
- Rebase onto current upstream/next.
- Separate the boot-device conditional cleanup from DA enablement.
- Use normal VBUS detection without changing the MTU3 driver.
- Apply the SPL agent's eMMC preparation to the U-Boot DA, including
  reset-pin enablement.
- Reduce the U-Boot DA heap from 144 MiB to 16 MiB for sparse flashing.
- Document that enabling the eMMC reset pin is permanent.
- Use wildcard MAINTAINERS entries and clarify signing and heap-size
  rationale.
- Link to v2: https://patch.msgid.link/20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com

Changes in v2:
- Rebase onto upstream/next, which now includes Genio SPL support.
- Align shared DA filenames with the mt8370 Genio naming.
- Use fixed USB peripheral mode instead of the private force-vbus DT
  property, with corresponding MTU3 driver support.
- Limit RAM boot to the U-Boot DA and use phase-specific MMC settings.
- Separate shared and per-agent configuration, and make DA and normal
  storage-image configurations mutually exclusive.
- Build the SPL DA entry only in SPL and simplify FIT key handling.
- Keep the SPL allocation limit large enough for sparse image writes.
- Select the eMMC user area when resuming boot with SPL fastboot continue.
- Explain the preferred U-Boot DA and the SPL alternative for tighter
  BootROM payload limits; clarify DT requirements and continue behavior.
- Link to v1: https://patch.msgid.link/20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com

---
Carlo Caione (4):
      arm: mediatek: simplify SPL boot-device selection
      arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      doc: board: mediatek: document Genio download agents
      arm: mediatek: enable caches in the SPL download agent

Julien Masson (1):
      arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  64 ++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       |  14 +++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi   |  62 ++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |   3 +-
 arch/arm/mach-mediatek/Kconfig                     |  59 +++++++++
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/download_agent.c            | 111 +++++++++++++++++
 arch/arm/mach-mediatek/spl.c                       |  22 ++--
 board/mediatek/MAINTAINERS                         |  12 +-
 common/spl/Kconfig                                 |   2 +-
 configs/mt8370-genio-da-spl-fastboot.config        |  21 ++++
 configs/mt8370-genio-da-uboot-fastboot.config      |  29 +++++
 configs/mt8370-genio-da.config                     |  12 ++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |   2 +
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |   2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |   2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |   2 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 135 +++++++++++++++++++++
 20 files changed, 548 insertions(+), 19 deletions(-)
---
base-commit: ad2b0f0ef2a2a6bae1896e493e98734e37a3f1eb
change-id: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
prerequisite-message-id: 20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com
prerequisite-patch-id: ebe0842a87ef1a27c9882d7c45823b37ef84e5a8
prerequisite-patch-id: 7df6bdcd4e7a655d86db0447593b2bf36050b049
prerequisite-patch-id: e98c322def69bb8ecec30dd41c05aa62040b1008
prerequisite-patch-id: 553ddc59d4de9ff9f1949875939979cbeab2eaac
prerequisite-patch-id: 8d8c1917bfcee87fecf6077a117c8a11cc402cdd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

