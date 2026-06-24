Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F61CDB47C
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 00:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444D28460E;
	Thu, 25 Jun 2026 02:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="aSRxTwMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7B88460E; Thu, 25 Jun 2026 00:06:20 +0200 (CEST)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5778460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 00:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=f5ptaqgmmndx7p76cguvtev4mi.protonmail; t=1782338776; x=1782597976;
 bh=jVwZI16le5GhXL2CXooU9Ymu07v3/eJcdo3LOyBgBsM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=aSRxTwMss+rjFDsO+xqre5Ej4l09hfSZdp2f7fleOmzQ+BXzEDMRjdyiTHmV6bf4w
 M38trYGpAScfX1EqdhR6XAETN5Yh2XkhQ6xf8x2kmBR9GmHSFnu4/r0i5nghfk5ls1
 F8F8VRneRXCtKN4AICNTQLt4zg80hxfz8Pro6TR8QVSFMiEPasZWK+Hd85KcpkGB77
 0E5P08MYfb8sJ//lxB9j/tsJRZCQQRUIlnA7jgQziC/ANxswpD/7wuXZAXngFNTp0k
 8VIweUPX75E0MQCcXz8hHUmnDTBcqH7i+Jkkkz7iuEAomAFpLPoj1N3XjbyE9DuctS
 A/PKlywkWCS0Q==
Date: Wed, 24 Jun 2026 22:06:10 +0000
To: jonas@kwiboo.se
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: sjg@chromium.org, u-boot@lists.denx.de, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu
Subject: Re: [RFC PATCH v1 00/14] arm: rockchip: rk3576: BLOB-free TPL DRAM
 init
Message-ID: <20260624220551.334-1-johan.axelsson@proton.me>
In-Reply-To: <32dd997a-38c1-4f36-9b90-9d27fb592db4@kwiboo.se>
References: <20260525012824.121-1-johan.axelsson@proton.me>
 <32dd997a-38c1-4f36-9b90-9d27fb592db4@kwiboo.se>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 8f81ab4cd851421c5baf9ec9ff5af0e88879e34c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Jun 2026 02:12:26 +0200
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

Hi Jonas, Simon,

Thanks for the review -- much appreciated. A short status and plan rather
than a new posting.

Following the feedback, the work-in-progress series now:
- drops OF_PLATDATA and the clock driver from TPL (DRAM init uses the CRU
  registers directly), keeping TPL minimal;
- drops the DT / syscon additions (no dt-bindings submitted yet);
- restores the original Rockchip copyright notices;
- stays TPL-only, no DVFS or other complex scenarios.

Still to do before the next revision: Simon's
obj-$(CONFIG_$(PHASE_)SYSRESET_PSCI) suggestion, and the substantive part -=
-
real timing values (the tables are still TRM reset defaults) plus hardware
bring-up. That last piece is the real gate; I would rather not re-post a
series that does not train DRAM yet.

Per your note, I will hold the next RK3576 revision until Pavel's RK3568
series settles, to avoid two parallel reviews. I am following that thread
and will rebase onto the agreed approach (including the TPL size work)
before re-posting.

WIP and notes live at https://github.com/OpenHorse/rk3576-dram-init for
anyone following along.

Thanks again,
Johan

