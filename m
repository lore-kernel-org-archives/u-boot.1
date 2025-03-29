Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA3DC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 05:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3F2809A5;
	Sat, 29 Mar 2025 06:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67953810EA; Sat, 29 Mar 2025 06:08:37 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB158059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 06:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1tyOQm-000000005FT-2QwB; Sat, 29 Mar 2025 05:08:28 +0000
Date: Sat, 29 Mar 2025 05:08:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, u-boot@lists.denx.de
Cc: Thomas =?iso-8859-1?Q?H=FChn?= <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH 2/2] tools/fit_check_sign: make key optional
Message-ID: <Z-eARwyqRb6B7dR-@makrotopia.org>
References: <bf6a90e864b713db41bf788797554649eeaa0732.1743217745.git.daniel@makrotopia.org>
 <1f0c5a1f7e84f638f921278284ff6245d78e730d.1743217745.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0c5a1f7e84f638f921278284ff6245d78e730d.1743217745.git.daniel@makrotopia.org>
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

On Sat, Mar 29, 2025 at 03:13:01AM +0000, Daniel Golle wrote:
> Allow invoking fit_check_sig without the key parameter, allowing to
> validate only checksums and hashes for unsigned images.

Sadly I've missed making the munmap() of the key_blob conditional as
well, and while glibc seems to be graceful about munmap(NULL) other libc
like musl are not.

I will fix that in v2.
