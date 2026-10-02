Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CECA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0726260DAB;
	Fri,  2 Oct 2026 22:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kyUY2320Po5w; Fri,  2 Oct 2026 22:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B22560E00
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979012;
	b=VzFP62GfPee28zlhm1AF50w5KkNDqQLcGSr+DRjj/yKtQn0kEfjae84tln4GVumqXSqF
	 gxRl6vEvINNrgfad5O4BV8i99HVR3D6PfiAIMrEXCzGsWrXYFRykWUgaMP0ZCiz14JYu/
	 6PG4UYdz4rCSAMp02hi9AoJPt7h+36ZzQ3orDIiKs8CcoQWQoGCn2/biXalNRqp8tpSKV
	 foPl1flPxBmbv14CD5+hm5RZInBi5k0Oly53XXnoYjUAJ7g9Zl6NffPJovZRTmfdrfIt8
	 v5FvE+ZW1LosuX/GPdtWT562BPXQCW6IHU5qMAhyKc0XtjRCat0eSwQWS1/30LyWkNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZTnR8Zv6VZyElASX+wWLdhqHCgeLBcuobVrk2nWZRug=;
	b=WSflOKbCtO8/EzaYAtx74fRLIiV9HVLln5cK1KH4CRaZG3Ax9f93jMVpZ6m/SXYo1uLf
	 Sb6kZ2XUHFNr3KnmEGb/Bxv6HNaHqNiB4Y5T5DIZ2oRSVFHpCZFel7AnnyiQydlCoNF4N
	 kSunOt6zSNEBJ+OJ6gZhb8XlxcTKZ8+o+b9/Bb2Mp4YwPHh76ilUBax0+w3cDMW3izC5O
	 3Wa8FMjTUPXtkKv2kSBIeEZAljxWLpiK4TYIdc14EsKpHTuJkfIboQ+UaSMWOTlD/lHcv
	 YlbpO0sLrrG9cQX5GkEmmrMnS9hm1a6j+NWgt+WgTDQpnWhK0uCBn6pJycLxetpxuFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979012;
	bh=ZTnR8Zv6VZyElASX+wWLdhqHCgeLBcuobVrk2nWZRug=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bErntpMYMY23Z7ZuC+m4Q0j6gTjBrCR8xKUdDWsEN+JmCclS806WjXP0ASc3Hg4iB
	 xshyBqUd0qQexyorns/mDdKeLpP7NwGusS9hPSJehb5qF/A+FgnueseChLGG1etv2T
	 FPY2Axx99PgxraOhVIYcsBQrGweLM4N3RVFu7iZ6a/H7lAyKxnDdCYrTibc5m4hnKj
	 dZZzB1FyXjZgjnF5UrAMgqfu95kyZzd8xgpSvGdcgkT9h8YIumlPJzY3DIsX+wl8z5
	 9UTWlTU8avswAHepfx7zHukGjBF59LhENwDbVK6CvfzYqD7RtlAXuv++JqVrNTdrkR
	 Pb0FuAnlTJNMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B22560E00;
	Fri,  2 Oct 2026 22:10:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 739FE2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 564A440BB8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMqRiP1_GTjn for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 22:05:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0CB5D40BA0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790978743;
 b=WPiOXD18lX4n2gONgjaqbF166IX8A8KeGCtIUsnf2tozYjQuX1xIhrpNfz3WSL0GPBep
 0uzucYRM+Ag1w4jPMZdbYGVA9/7kXPLw6E5KKcGRMhf/GtMHHGZG0SUIiXt7v7FnVuReW
 fJ1IR8iapCXv9XEp2doAX+KtVbKounyNrHYCgE0dwPTh0Ae1UafTzGvJ2lp00jo8kT6Lc
 IDSaC+6uQI/BIO6GLY7u0ctzhqovRyuXZwnntZvaXVI7avvosrsBVuWBwDbOZ6jFjZsgJ
 LSc9EBh/yxdGni6+YW3zNs5DwI2csaGEuMH+Ay/0T4GsJNLbh+S6pYwvOJVh9ukWP2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790978743;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ZTnR8Zv6VZyElASX+wWLdhqHCgeLBcuobVrk2nWZRug=;
 b=abnTTWNEtvNJasLNideEilBxIie/IMnRqMoGQCeFokiDyi2wSV3dUcvp8GEzaP7cCEw1
 c8eP92gJz2IBqTTY7b7T5z6nHLVhJQEFjJsHZ/tnlQ8I7Z3+V6hnIf0tBslM01f2QD9Gt
 14UpomfbJtUjV9p8KjcoGftDrXdInCpSauG722jVTWn3zLOZRASfjdMc7vYDwMtMZWgUL
 KjXrpruEMCJ6E5QEL+wvC2d+zV3OAFKkfd2ePdFps3KY1/obDngiiosRmfHKe9G+ynTQu
 62jubsT6lGtgxcga1AJrZKliR7lti9lAyKqj+uoQWUdWlKLS4Ly+pUveorCD6bTU7fQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=hOQV7rHn; 
 arc=none smtp.remote-ip=79.135.106.29
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.29;
 helo=mail-10629.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=hOQV7rHn
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch
 [79.135.106.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CB5D40BA0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790978740; x=1791237940;
 bh=ZTnR8Zv6VZyElASX+wWLdhqHCgeLBcuobVrk2nWZRug=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hOQV7rHnuO0Whni4xeS9KFxzqmt+jMf2ZpYXmUVR2e59IlhpWNyy4FsKXB/t1Wc2G
 PBr88Qf3l8poXmjgiSPRZA3l1/2WggM6K8C9RLg5nFlT6LGNMGDwZ8CwxUB1uDvxqx
 V67qTrBYttEWv6l3iXlYxYMfR0f2rF+WzcdHBj6BO0AkD9fylrnbGqAD4fg/9WIjTa
 Ftt4jnn88Q19xsdKifDXlHMaIPrRKYF7d4dx8Frq1nGZmOlKDoI6fPE1g953wXUo7F
 EFjopWR0EiJxwbr/gOjqYqikFHqG5wGfIP2ON28WzloPyzX+/DIhzSI6zdKxQk9QY+
 bjw/Imro5dZAg==
Date: Fri, 02 Oct 2026 22:05:34 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH] clk: spacemit: program the mux when setting a mix clock's
 rate
Message-ID: <20261002220529.313639-1-DaveWK225@protonmail.com>
In-Reply-To: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 9b2d9d3165236a8ef5d09676c68bd77c8a4f4c94
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
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

Also tested on the OrangePi R2S with upstream's K1 SDHCI driver from
next: the SPL moves the eMMC io clock from 409.6 MHz to 204.8 MHz and
loads U-Boot, which then runs the eMMC in HS200. The tree is upstream
next plus the posted K1 fixes and board support that is not posted yet.

