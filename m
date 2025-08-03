Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5CEC87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 13:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A8F83D77;
	Sun,  3 Aug 2025 15:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="XXvb1vnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F32D83C67; Sun,  3 Aug 2025 07:37:43 +0200 (CEST)
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812C783B5F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 07:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=safinaskar@zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754199455; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H9AzClCi3k+oNYOq6yEiqN8+34cnWCB7wd5K5QtK3wmmdFlCK2CE9lqQLSXdzzSBAqTiEp/Xio0/0OL3tbSXOQIbEJYG1rtxSFJUr5nwetAzIZSpS28XL98cWCjN6rOeVOL0FEeVxVfMkFJi3Z+Bne3DZamdSBWJmR8luWSMLJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1754199455;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uNtZJHyZcPkDXLG8r9ce8cxjzpDn+uFBiyaXx4l5l3g=; 
 b=Afafj5xSU903PAfcYldt3xKc55fMsmPSKdiMMabBIupDXD26zxz0vbrADWoUItORB0/z/KvcsMA/PD000jMRqRwY9AUQiZoYdIdTEa+TJ4NZReQ7l33rfvf10AMuROvtTuxXLWNBIemwHIYEGarqijcyn5DMiWmuuf1uXCaWqMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
 dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754199455; 
 s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
 bh=uNtZJHyZcPkDXLG8r9ce8cxjzpDn+uFBiyaXx4l5l3g=;
 b=XXvb1vnLZqJZyGhC1LJDlmbnXEe8p3+AqIB+R1JIbtHzKBNdfZKuD/v3YpV2FogM
 eaWusv98yMKt4GwWvkk84isoxB1DRFPA7Lj/JU2BTZSgfJUBwP6TkCl5bCVeYvGO6XV
 wBKcI4/pxEqUyq7ZJ+J3Y74+7dVRCFzGWihs+sas=
Received: by mx.zohomail.com with SMTPS id 175419945230494.8601369148763;
 Sat, 2 Aug 2025 22:37:32 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: dinesh.maniyam@altera.com
Cc: alif.zakuan.yuslaimi@altera.com, boon.khai.ng@altera.com,
 dario.binacchi@amarulasolutions.com, ddrokosov@salutedevices.com,
 hs@denx.de, ibai.erkiaga-elorza@amd.com, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, jit.loon.lim@altera.com, jonas@kwiboo.se,
 kok.kiang.hea@altera.com, marex@denx.de, michal.simek@amd.com,
 mkorpershoek@baylibre.com, sebastian.reichel@collabora.com,
 simon.k.r.goldschmidt@gmail.com, sjg@chromium.org,
 tien.fong.chee@altera.com, trini@konsulko.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: Re: [PATCH v7 05/12] drivers: i3c: Enabled Kconfig and Makefile for
 DWI3C
Date: Sun,  3 Aug 2025 08:37:23 +0300
Message-ID: <20250803053723.1655843-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728065612.6039-6-dinesh.maniyam@altera.com>
References: <20250728065612.6039-6-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b13e5688a6ec0e518533a8e2000018c77c95a07c6d06827cb24d43a861ddfa80bd2ff456086079:zu08011227d8aed6f020ba8b0c6c200680000011f397fd8de61840b3af7de33164462c85bef701a895428041:rf0801122c8ae8cbd9af1991af8e764ff30000463a51f3c360b4acd658740ac493771f40c487e62ca25ad2745404242815:ZohoMail
X-ZohoMailClient: External
X-ZohoMail-Owner: <20250803053723.1655843-1-safinaskar@zohomail.com>+zmo_0_
X-Mailman-Approved-At: Sun, 03 Aug 2025 15:22:51 +0200
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

You wrote "Synospsys" instead of "Synopsys"
