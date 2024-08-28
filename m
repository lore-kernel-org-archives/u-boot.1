Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23B1C54FB3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65E08875C;
	Wed, 28 Aug 2024 16:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="ueR/kCFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D761E88860; Wed, 28 Aug 2024 16:03:08 +0200 (CEST)
Received: from mxe-1-50f.seznam.cz (mxe-1-50f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:50f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0940D88703
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 16:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-6f7b5db655-grmdl
 (smtpc-mxe-6f7b5db655-grmdl [2a02:598:128:8a00::1000:50f])
 id 39ab4603c75ff4a93925c81b; Wed, 28 Aug 2024 16:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724853783;
 bh=OXOFgjicuxOgZu6aNqdgDZpXLx/IVrIfMZL8cF6c0dA=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:References:
 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
 Content-Transfer-Encoding;
 b=ueR/kCFr4TpTKlEJLIkGW60DVfRMesWlmZCyXy4mkIVlYtv99yD49x7ac1m989ZZ0
 8o0pBmx4DXtyecaPXyK5MTt4cupM8sf9r6vR2pJGpJ+nEAJASubc14+nA2gR3G0eCJ
 AAsHJzXD1XNko3VXB4LMWz0oCKAXyI9t4Ll1bTnfg/XeusiDb0cgNK2QW+NLWhRf/j
 tSqSwdr7DiIt7GclA1SiQk+TN3qzJNfZxC/DoNmFR74ke4HZh75rCp6+OraH95PLdL
 i3n8gArFGeYtCJya29xPApTEE7A1kWLFcQc0fCPSV8EWKbwOatbrqxzjSpQllT2xYi
 T+BofX361YIhw==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Wed, 28 Aug 2024 16:03:00 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Marek Vasut" <marex@denx.de>
Cc: <festevam@gmail.com>, <trini@konsulko.com>,
 <francesco.dolcini@toradex.com>, <tharvey@gateworks.com>,
 <aford173@gmail.com>, <peng.fan@nxp.com>, <ye.li@nxp.com>,
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v4=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_?=
 =?utf-8?q?state_of_GPIO_pins_in_output_mode?=
Date: Wed, 28 Aug 2024 16:03:00 +0200 (CEST)
Message-Id: <sh.ZbzP.6RjIZzPMVJL.1cpouK@seznam.cz>
References: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
 <6076e0bc-a7b3-4d48-b180-32443fb966e0@denx.de>
In-Reply-To: <6076e0bc-a7b3-4d48-b180-32443fb966e0@denx.de>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
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

> Changelog is missing, what changed since V3 of this patch ?

There was a typo in V3 that caused compilation failure without CONFIG_DM_G=
PIO.
