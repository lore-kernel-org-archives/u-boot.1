Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D25ACD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 15:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94028485F;
	Tue,  2 Jun 2026 17:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="einch68t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D586684867; Tue,  2 Jun 2026 15:43:16 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A7784855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 15:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=uy0uk9FMemro0wPEHkTGamf9ls126wrXqlIB1C5z3GE=; b=einch68tiV57Q68wH9Yiwx5tYJ
 rFVCBAGuqGkaQHnwfh5aXQu1NEWgu5oRhJQd79Ch+PC+unyMCenphGtMHwKxD9rSRlAoT4jI2c2rh
 zTqNdWqFJ9v0L4Ow90WZhIJkfqdzi2MYfJgGv87u6jScSRQRQ7F4Zv2UX4Kpj4fKt0rSE7vIW5lnA
 DBR9BNfPbLKkAcJdDKfNoHZqOkTA9abATFIMcnlMhdc5Wwly3xvcZ1mp3W9Ebonht1fk5c3uIiq2d
 /tQSu20c2PDZvH0gCk/c7H0d77WKucL/AhU7FVWUc1aUp2nHcOGTshu7XItpAprxl2kuerUYxXenV
 8EcU8Nzg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wUPOk-000DAt-0k; Tue, 02 Jun 2026 15:43:14 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wUPOk-000MuN-2G; Tue, 02 Jun 2026 15:43:14 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/3] Clean up bloblist initialization
Date: Tue, 02 Jun 2026 15:43:13 +0200
Message-ID: <7363008.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260519162225.770071-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260519162225.770071-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Mailman-Approved-At: Tue, 02 Jun 2026 17:27:22 +0200
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

Am Dienstag, 19. Mai 2026, 18:20:53 CEST schrieb Tom Rini:
> hEY ALL,
>=20
> I've been sitting on this series for a bit (as the patch dates imply),
> and I'm ready to move forward now with it.
>=20
> This series does a few small but important cleanups to how we check for,
> and initialize a bloblist. The first thing is that the way things are
> done today, our HANDOFF code can only work with a fixed bloblist
> location, so express that requirement in Kconfig. Next, we demote the
> scary message about "Bloblist at ... not found" to a debug because we
> most often see that because the bloblist doesn't (and can't) exist yet.
> Finally, we remove bloblist_maybe_init and split this in to an exists
> and a real init. This results in practically no growth (between 8 bytes
> growth to 12 bytes saved, with some outliers saving much more thanks to
> knowing it's impossible to have been passed a bloblist yet). This also
> cleans up some of the code around checking for / knowing about a
> bloblist existing.
>=20
> Changes in v2:
> - Pick up Raymond's tags on patches 1 and 2
> - Correct the logic in the final patch to not break TPL passes SPL a
>   bloblist (at a fixed location), as noticed by Raymond
>=20

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


