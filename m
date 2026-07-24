Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00BDC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 15:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5D7F40AC2;
	Fri, 24 Jul 2026 15:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1vel6saf7g4; Fri, 24 Jul 2026 15:56:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04DB940A2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784908596;
	bh=7Y7xE15GikX03dge7uGxlk2wY8g+iaZKlKeaYPuF4D0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8vK7c9WDxEnigeN6hzQ5syW4Dj51k+hNas7A+kmJPn+b1gRLL8AWzr84u2xr22+B
	 1as76srkX5aWe5Lf61tBXX8Waoi1MAGWGMb1B4SXSRIUJpscRA+TSK6BV8euia9o4/
	 WN2ib76SXQ5EVMfrgxECSUxmt/Bvnzh/WM88zRfDE3jjR0A9IGhFSBW3kwlLWJX6TW
	 95+p68z+Dnf0PqplMhRthhNQgOCh4iRsaKzKdEoHgjnfuxu1NvlwbgnMBojdL+MdPy
	 mFsYLQvbbC7hBDuoCB0+fbSv9YtWwRPGrjbtoDS5m6PT6sgwr0gnDrgEK1KGGg32zl
	 oxJeWpnBtANhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04DB940A2B;
	Fri, 24 Jul 2026 15:56:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C974DEB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF91940A40
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvlpwmEpZu5t for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 15:56:34 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ehristev@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EAF7240988
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAF7240988
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAF7240988
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:56:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9C683E76; Fri, 24 Jul 2026 17:56:30 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB72800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 17:56:28 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EB6960A5E;
 Fri, 24 Jul 2026 15:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632E61F000E9;
 Fri, 24 Jul 2026 15:56:26 +0000 (UTC)
From: Eugen Hristev <ehristev@kernel.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
In-Reply-To: <20260617024238.152918-1-marek.vasut+renesas@mailbox.org>
References: <20260617024238.152918-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] MAINTAINERS: Replace Atmel with N:
Message-Id: <178490858609.597915.13862181249455942416.b4-ty@b4>
Date: Fri, 24 Jul 2026 18:56:26 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784908587;
 bh=7Y7xE15GikX03dge7uGxlk2wY8g+iaZKlKeaYPuF4D0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=P05249810+13wuls/q3H1jrd4H1+g3NdQDh7QyQKMTcEr9My//CKqe9GH4zzLco2U
 I0ADFq4ABhu1u8j3M7cnFBVDdUSAa1i9CMbIU+E7fWq0BOnODGUCAnBH9byMvZvSRj
 xnJ8ZEVOBT5Eu/IdlOdUolIqALe6fI4+HhoJTMeZ7YGZ1+Otq9JGbEpYcp0jjiRExc
 qGCta4rulIeYiL9feMYvWio85C+3CCBAP5mbFfX7nVdNaOPbciKvW5nAepAoWXDQRw
 gkWaWySh4sbYcMegBiBLS2WIey+pnTsDTaSS0O42T6YBQJsZp1B2omz+98NmC/armo
 JwVf3NEaH3WIw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P0524981
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ehristev@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="P0524981"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Applied to u-boot-at91/master, thanks!
[1/1] MAINTAINERS: Replace Atmel with N:
      commit: 88386697bb752f0321f1277ebb92e8f405b4ba45

