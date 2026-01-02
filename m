Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA760FA3728
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 07:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB7C83B4B;
	Fri,  2 Jan 2026 08:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vm0jRI5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED74083B82; Fri,  2 Jan 2026 08:58:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B478A83B27
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767340705; x=1767945505; i=xypron.glpk@gmx.de;
 bh=qTGdWOVveBMIeQoRD9WXBI0BYgzo8iwTBwve447qFTQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Vm0jRI5TAY6Dbk2S/c65HHnlioKHPSDW8tgN4NFv9rlOLgxVeYze6YuXUI4LfAV+
 fuBBbO0uckGUwxspolAFl6dBEJwgEyXcVjKB+gj5TnfnHi1jAOXzygs9aGHliiTc2
 XioFE2XF3g6zPG7r86sHU4U25cx82Ygx0kHgZ7ff/0iLkbFaVNHUPJL7QC7CXUfHD
 JfEblF4kInqOrCkXFovTTXcuLy3oLs16iTOavrWJdbYTzi+Ik7XHwJkETVKkKRDNK
 31DaaMEc7tn3aFbotHr+D0szNFtRW0prCSJccPtaW2iypkrUimbdaMc6BpaGuq92B
 InlJxosvK6zcQbVgZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1w88aZ2T98-00ev92; Fri, 02
 Jan 2026 08:58:25 +0100
Date: Fri, 02 Jan 2026 08:58:24 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Manjae Cho <manjae.cho@samsung.com>
CC: u-boot@lists.denx.de, trini@konsulko.com, sujin.u@mobis.com
Subject: Re: [PATCH v2 2/2] doc: emulation: Add network testing documentation
User-Agent: Thunderbird for Android
In-Reply-To: <20260102010236.39626-1-manjae.cho@samsung.com>
References: <CGME20260102010238epcas1p467cd3ce7ad8d03eaf35e25563da1d8c3@epcas1p4.samsung.com>
 <20260102010236.39626-1-manjae.cho@samsung.com>
Message-ID: <48880848-C037-41A0-8B96-E2828F10D78D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bTzqQq3TwJabHuRAQ2oFx0MB7Tq45cSkW0YGhHAvRSQGpp3f0Vr
 Ig8fm/uLDzajPEQXHasrDBuldZZDQiOQBy7MSOV9pWCkOEili70ISBXPWq9hLhzXQ98Rx8C
 5rHVdpTdVUSHtKgGKTa+1MA1tTtajxn7zncpMqcAjtoPAKKhBW+oaz5ld3B7LvGw6feJl8H
 1JJBJuQmHwHgrBQVTQJyA==
UI-OutboundReport: notjunk:1;M01:P0:3D/wDq0uGKY=;NhGmEpjX3Zk1CEuX8SNdjkA9gK1
 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
 BKhIT9DbbTD7/U1t4pHRepiMVZ7XFBNkFAav0a
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

Am 2=2E Januar 2026 02:02:36 MEZ schrieb Manjae Cho <manjae=2Echo@samsung=
=2Ecom>:
>Hi Heinrich,
>
>Thanks for the pointer - I hadn't seen your patch before sending v2=2E
>Your version covers much more ground (tap/tun, multiple device types, etc=
=2E),
>so I'll drop the networking part from my series=2E
>
>I'll send just the typo fix as a standalone patch instead=2E

No need to resend=2E I will pick it up in my next pull request=2E

Best regards

Heinrich


>
>Best regards,
>Manjae Cho

