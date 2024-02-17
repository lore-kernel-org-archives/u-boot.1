Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE62C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 16:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AE987C48;
	Sat, 17 Feb 2024 17:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="YU1yk9hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D71087C48; Sat, 17 Feb 2024 17:33:44 +0100 (CET)
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564E8878A1
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 17:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=therealgraysky@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1708187620; x=1708446820;
 bh=67nAN77g/69tQuNd+qB7QKa7txIouHTSDMCMVSoIQ0M=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YU1yk9hbiQDLlBbUBDP8l7JjRrGqEBtoMKl5dDdqi63EvuwIt2mrG0faHBAjSaWsw
 Xfv8v+Sum0sig7/m7N3OXgQ4/W9FrAVtd4UijgP3q6gFReLs9ilzLZ+KVO7/F3qPGY
 g5jyIsfvDXpKEJfMG9aDa5AOlbHIQJAVldeIKadHk+WBh0MitOnZUHnY7J3bgNJmQj
 XILRyNUoVVyRpli7E3HGMIGZuGqaDfkIOIjA59Qk1wmrAfeUfIVg7atNLd9an/mzHd
 25KqVFZAaYsR3eNYaQUw4++iBDBrwz4KO8apf+VSL4Hx5tQG8XBnVeECZXtGz6KuV3
 rdAuPjXbUNtaA==
Date: Sat, 17 Feb 2024 16:33:31 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: John <therealgraysky@proton.me>
Subject: Booting RPi5B with latest git
Message-ID: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
Feedback-ID: 47473199:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 17 Feb 2024 17:36:06 +0100
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

I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot the=
 vanilla kernel package (linux-aarch64) with the latest uboot-raspberrypi (=
2024.04-rc2) just fine. Yet, if I take that uSD card and place it in my RPi=
5B, it does not boot. I only see the "U-Boot" submarine logo in the upper r=
ight of the screen/no debug output. Any thoughts are appreciated.

I built u-boot like this:

unset CFLAGS
unset CXXFLAGS
unset CPPFLAGS

make rpi_arm64_config
echo 'CONFIG_IDENT_STRING=3D" Arch Linux ARM"' >> .config
make EXTRAVERSION=3D-2024.04rc2
