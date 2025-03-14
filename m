Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD46DC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 23:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1622D82027;
	Sat, 15 Mar 2025 00:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="ho9wfBQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156148205A; Sat, 15 Mar 2025 00:27:10 +0100 (CET)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFBF81F7E
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 00:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1741994825; x=1742254025;
 bh=EVrgCP6hOsaZ6KW4Y+dMV54b91Us4N7iYeGszHRxGiw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=ho9wfBQdy0YfTmuASO3DkKOzYgmcG57c9NTShvHztmjT5J5oPLASwVSslOqrX8ReJ
 VSXsQ1IEiph6pmIdFU/wLKj+tvpKM6FZFfcvWnmweM8Vn+EtKJa3rmh5p4kYSBzrNi
 5ieiaNQIL5wMvpaJIkAR3nQaJG745ggCaHmPDlJWFS7SgXB8I1rKuBNxu2sK2ko/fq
 Vm1U1Q9vZyTCXjXGp8gBhkxfeFZjWm06q0ROqRFoocywoU4WZAc8xC69fyD7fezH+9
 9fZiXtUHpMDLY7gI74ekxtYveyvyX9vXsQHsQC+OBU8qHWCck6JEirwmFiBEheLrKC
 etdABHRy3uszA==
Date: Fri, 14 Mar 2025 23:26:59 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: xypron.glpk@gmx.de, ardb@kernel.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Baruch Siach <baruch@tkos.co.il>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
Message-ID: <OX9trAy3JSNd8o9Ho8NejmCIh32WQR9El_tPJG0UAcHsn_TB3VsPbNFz2l5E0hXPExObST2VM91xgLD5Ak1AvY3xRgQQEHz1LZCwadhyOYI=@bens.haus>
In-Reply-To: <CAC_iWjKGxqF8L=3r1-EuDN=Jmb0rPV+-54+g7x79m8dm-4o=yg@mail.gmail.com>
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
 <at3MKdVWObOe2t0ulEO_390BtudxQ52-_iW2VGgpz0spI-UhNxRfC9TCtcUduXUIHSuBPt7vTR3iC4bOhT1IZTyI9hKIrHhBt8-82P4PIqM=@bens.haus>
 <CAC_iWjKGxqF8L=3r1-EuDN=Jmb0rPV+-54+g7x79m8dm-4o=yg@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: d4105484e9b54cc9235ec9018592f7b488437df8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 15 Mar 2025 00:33:43 +0100
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

> Thanks Ben.

Happy to help. In case the context is useful, I wound up here
because I use U-Boot to load systemd-boot which then, in turn, loads
the kernel. Unlike GRUB, systemd-boot does not provide decompression
and recommends using EFI_ZBOOT[0].

Perhaps it is uncommon to: a) have the first good memory entry
start at zero, b) use systemd-boot instead of GRUB, c) use the
compressed kernel on aarch64, d) all of the above? :)

Thanks for everyone's help!

Ben

[0] https://github.com/systemd/systemd/issues/23788
