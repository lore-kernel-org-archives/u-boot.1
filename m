Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E1CCD98F0
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 08:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312E7847C3;
	Thu, 18 Jun 2026 10:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TbinGeRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117EC84874; Thu, 18 Jun 2026 10:30:57 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE97F8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6XEfjwKheANfAC8cDkcQ/OvHH+tZh8WWth8op0rXOR0=; b=TbinGeRJb1x5W62Wwqnnd5Zxp4
 OtX08Y9imhkiSc75Itul7QXWsujYVJ6dMigFQtZ99CufIdzjeNkcb3R4FozXDMKYMv+vnmxQnhR+a
 LPfCkMM87GUGAwM1fgBlz8k97yMRAlc736NCzVEbkeic/Bu2IwBS2kkGWac+oYNu/Wfxr63XJ1zWS
 Ionv2sKlyXlMLUF8rFzBYPj9QG10kNa4hzjkepew4NPCSWLqAcVWaWafz/2Mmqqn0bLCchJoW85de
 uED85p4n0ezqMrk9UU5eOmvHirboFWriusWQxzXEuRbern+GCX7sgPt8SeMd4jirTWc5Mk23WKW0J
 6MciR8lw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wa89F-0004v7-2L; Thu, 18 Jun 2026 10:30:53 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wa89G-000LSH-08; Thu, 18 Jun 2026 10:30:53 +0200
Message-ID: <be080a107555cdbad6828af2a36be013ec186477.camel@ew.tq-group.com>
Subject: Re: [PATCH 2/4] bootm: use CONFIG_SYS_BOOTM_LEN for
 IH_TYPE_KERNEL_NOLOAD decompression buffer
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, Simon Glass
 <sjg@chromium.org>,  Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 18 Jun 2026 10:30:51 +0200
In-Reply-To: <20260610194840.GH382693@bill-the-cat>
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
 <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
 <20260610194840.GH382693@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

On Wed, 2026-06-10 at 13:48 -0600, Tom Rini wrote:
> On Wed, Jun 10, 2026 at 11:01:23AM +0200, Nora Schiffer wrote:
>=20
> > CONFIG_SYS_BOOTM_LEN is passed to image_decomp(), so the same should be
> > used for the buffer allocation. Deriving a buffer size from the
> > compressed size if not possible, as the compression ratio may be
> > arbitrarily high for data with many repititions (for example ranges of
> > 0x00 or 0xff).
> >=20
> > Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> > Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>


Hi Tom,

I saw you applied a different fix for the same issue to master. I think usi=
ng
CONFIG_SYS_BOOTM_LEN is a better solution than trying to derive the buffer =
size
from the compressed size at all - isn't that pretty much what
CONFIG_SYS_BOOTM_LEN is for?

Let me know how you want to proceed with this. If you want to keep the alre=
ady
applied fix, I'll rebase the rest of my series.

Best,
Nora


>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
