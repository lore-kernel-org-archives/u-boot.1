Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0B5C25B5F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 14:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E73880AE;
	Fri, 10 May 2024 16:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="baskfCCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A33881BF; Fri, 10 May 2024 16:07:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD2288080
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 16:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1715350027; x=1715954827; i=frank-w@public-files.de;
 bh=KE/hscB+K5eBWoN0R14zEE70JvV2oWsHS0DsLnlMaGs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=baskfCCEMAl7ZVaKBnfqssT54eDcpK8No68fXL7/LcZVNXsmJj39gLK5m6DO4sO2
 Zeg7Q27grnNcY1Ob8RHmMTn3WqhIjcS0DyARUbuYHsdjn0oOY+dHeFMb4Rpapz+ht
 CVCUDw1mbtsGVPPjg0axvw+yL0eoGrlFlhfxtH2RVXsVyuwCKxFr1vgSxqlT4oFR5
 ZbWFz0u34+9DJJT2+5QG3o1WYC5AGUGyJLxfdACZG/LQU08K2Oneq+YGilnIsXY1I
 NipbCkgKWYJKNHHePa5Wx6hGC3HnscMSJyq4X/h2tLuYHFVBe8kNoT6GyTRRSCRZq
 WFdMoisaPSMwB25tBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.152.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1sl7Oi0vX9-012swM; Fri, 10
 May 2024 16:07:07 +0200
Date: Fri, 10 May 2024 16:07:07 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>
CC: Frank Wunderlich <linux@fw-web.de>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 John Crispin <john@phrozen.org>, u-boot@lists.denx.de
Subject: Re: [RFC] pci: mediatek: add PCIe controller support for Filogic
User-Agent: K-9 Mail for Android
In-Reply-To: <20240510130819.GR2568172@bill-the-cat>
References: <20240412141051.23943-1-linux@fw-web.de>
 <trinity-564944df-1cc6-48ba-8661-ece741792f3d-1715342246700@3c-app-gmx-bs34>
 <20240510130819.GR2568172@bill-the-cat>
Message-ID: <B563AF62-EB8D-41D9-A5B2-E0E6D561FAC2@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NG8UW38A9p5QuvVoMikQQFIfUDeO8dsZTlmHpxAhg1G5HZ58lRe
 Uiy8O+g/8LC7s5uLk80JnfheSmvdwvAcRcEW0dsrTURgIKOwKDv62yG0qLVQF7kbhHbIH8g
 0ySVAt+FoFhsrM0N5mLAtjCgW0cx1NDOGTa+JAVKbqds5f0kgE4d44SeHp7sAXjRZ4nEJEc
 uUMDau2TeqM24vNSu0sgw==
UI-OutboundReport: notjunk:1;M01:P0:GyDGdONcJWA=;eJJRNg/B0GqDprB9GWAut0eZiOj
 UE5Q3x31kN69jGo/clGvPdMB82m2RYWYAULjTMB8PoVzlUAU1SDyyIhdJ4rgGMbe+9ToUSnuS
 GlQulguD0JLL4hSwPFJrwQkaaVXEwvCul2CWtUBgHxzrn/p0lRF11t/XehyBIhVSZir8S7rkT
 7uFDqepQEYe1ksf7aayWEcwuVrNuUDldDzCP6xNG8YCYcNLFzlbqk1abInEE3QudJFE77mNNU
 8AcYQjrDxcOQGXg47Oc68h7J2eHa1vXUOwng5TObRKUafp6UZmq54zSCEQ7k9WCJ0EoF2Sgmi
 0B0w6NgggU+up5j5ZsFrPg+CSsCLBJrXQK6gu+ExnJQHoqfL+k9/kY/KHzKIppNTf//5O69GF
 Qo9pj6v3UNiygYq39GM8ucey5O/1rBxYpcT7h2zs/Ux9G137GzpVvgY8nHDiBe+DF9zN2ly+s
 Oegmvq1uR0YUjg54m9/0+NS5zyaemKTPOOy7XLxUnkwMdxBOwM+v4DiJcpqokKVCoJ0Q3VxpJ
 You5JlYLbE5fOqASFW+J4dOqOs52mHfe7IQMa6SWlMPbQS0W7nagBg94/0N+pJlapGy1YrqXb
 SB3y9YzaiATOt5b3/338Davg2j4qNgkoAMY7xZZvqr1gYAfszhXqVXc+PtU2EvL4s2+1zO6BS
 j5cwfgisfpiKO3PfMvFD/nL/ZtGn1OLMLi0f0nEoOEEx87Hf6FfsEcuLCF6eJBZEVRzu85uHf
 kYd0LtXn9DtkF5MsJ2jqG3FyZknrZhWExRqp/F9flSZvTVrkvrZ0VcP++kbiNvWWuaHNn73NU
 IV9qb/oJd43RXUeXCGmXhGmg2chV+uOv+HW7q9KvMkxpc=
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 10=2E Mai 2024 15:08:19 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Fri, May 10, 2024 at 01:57:26PM +0200, Frank Wunderlich wrote:
>
>> a gentle ping=2E=2E=2Eany comments?
>
>Seems fine?

> Can we switch to OF_UPSTREAM first however?

Pulling mediatek devicetrees from linux will afaik break network in uboot =
for mt7622,7623,mt7986 and mt7988 bananapi boards because switch (mt753x) b=
inding is different to linux=2E

regards Frank
