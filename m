Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97197D3B7D5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5ADF8919B;
	Mon, 25 Nov 2024 05:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=yuuta.moe
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B20895CC; Mon, 25 Nov 2024 03:05:11 +0100 (CET)
Received: from smtp.yuuta.moe (mail.yuuta.moe [23.154.81.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6688912A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=yuuta.moe
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=yuuta@yuuta.moe
Received: by alice.ad.yuuta.moe (OpenSMTPD) with ESMTPSA id 4b38298c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <u-boot@lists.denx.de>;
 Mon, 25 Nov 2024 02:05:05 +0000 (UTC)
Message-ID: <4e599a863e476e31434d1bb1d7d5310aaa903899.camel@yuuta.moe>
Subject: Falcon mode without 'spl export'?
From: Yuuta Liang <yuuta@yuuta.moe>
To: u-boot@lists.denx.de
Date: Sun, 24 Nov 2024 18:05:00 -0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 25 Nov 2024 05:39:23 +0100
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

Greetings,

I am making U-Boot boot my kernel from SD card as fast as possible,
hopefully directly from SPL. I found the Falcon mode handy, but there
isn't a lot of documents on it, and it seems like I still have to run a
special 'spl export' command in regular U-Boot to generate a binary
blob. This seems very unpleasant because I do want to build and ship
all images on my computer, without the need to 'run a full U-Boot once
on the production board on every single firmware upgrade'. Honestly, I
am also quite confused why do we need such a command at all, given that
I have my kernel and DTB directly accessible from the SD card.

Is there any way to get rid of the need of exporting the blob? I do
have my kernel and DTB handy. If it is not possible with U-Boot, are
there any other solutions that support loading kernel directly from
SPL? My SoC is Allwinner V3s.

Best regards,
Yuuta Liang
