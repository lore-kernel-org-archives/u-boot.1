Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F0CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 17:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA66E40BAB;
	Fri,  2 Oct 2026 17:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyZDJVyO_dsv; Fri,  2 Oct 2026 17:42:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C0FBA40A48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790962962;
	b=b1iVkJZjVOr+l6VKbG2jClWQ2xGzvx92QV4sACpXPE2d2ir47ZPaR1Wu5H5PWc8eqsgl
	 DNKCwAemMTEPXBIfXPB0dTRajvsdnuJatatWf3/VZTr9Qzg29g/zbkDYk5dvsnQixkfDB
	 oi0SUl2Q6w67o0oRRJXz9Hkm9Q2dsDPhVSnD2TYZceDt3gN+2xUYFqt1fcPdDGVN9zQH3
	 WMkU4kXg2bZHS+8VGoQGSfEeq/t/9lTWWRDSE/szxhfXqTpukErOpSfkZ9p6SLYYfOixE
	 mNtMSBjIcy6GCD7V+UW+WS8jjL+NAW4dH6PGFNingZ8u6T3b2oCwDvNUHKv5pANnB+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790962962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iSTSVYeLyJJV8+eQ0jAa8ljwQNg3PwBEJEe4iO+R9P0=;
	b=DupatMHPoHXMO821tY0aamV8e6uyG2Tc39ZynTdNBYWkp6fq5ZidePlXEp8c5Oo8y1bz
	 KE9GpTEyGnwiflNU9Q0DSFUeex9d4zLtkzjt1IHqoDXOz+PgJj3KVD/C1epkJNZ/izEYA
	 8abzg26gERqAwn5ZO2sXU8b3l98HW3RdY9xUr+TZcO1kF6fG93G6ijug0uBcZ/cd/d0pF
	 OVxAp+7kWx6g39ObljuhthxuVlWMtRdJwxrtWJsMZKRs8tTsvuVQZQVyYJ+cH1KdvTQzn
	 qc8WbkmdeiPrGoeBbEG0r4Vda0TxrO5r+FSStT1gfgN8Y2DEO0RT3eBp6E1f09945bQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790962962;
	bh=iSTSVYeLyJJV8+eQ0jAa8ljwQNg3PwBEJEe4iO+R9P0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rJjWU2NN1fhGt6ACd5b3yo77X1qheyis23xc6GoStT1WnUDzOfyZaAeCeSlHKd8V2
	 AEdu6yY7u0e7G3cvVaC2xTO+5mCJtP6bqSlOH/UvjXaxZE6F2ftBrJhypx8VwK4ct4
	 YiZ3Ab8pU82ihWpLhLj6obuzV3U07HGo2YmKTmGccQoz6E4G18zX26CFD4CO/xHcon
	 0xZDOOSs1ZO4ua9q7CYsQvs7HIBdOk7k2WPgwr05n2onTEnVC/EuEJfShWWan8+bz7
	 rU/Pazf8wmoO8lseRaxQB7Va3Kjjp4Ad5a0uTdPeiJaGFyq6APnm68RdOb0OmjnaOL
	 k/3eSlcsaWB9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0FBA40A48;
	Fri,  2 Oct 2026 17:42:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B595263
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CD576069A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LhATItL8Z0Dm for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 17:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E17C6066C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790962960;
 b=b2pDtecA3rfD1dChBnbE3hH/trlYRcjOCs1HTmw1d5WVIVjxiQcjA72ibzs2nSmnAMVd
 joVilHt7ihI/ABN/GaFVcPfFpMVKAM9gl2/eMEje1K09Pg472t66MBF2kwJrg/hCYhfvN
 GbuisXuTTxbq/s7ru3MHNd/rYv2270teL56Py6NCBtFIYO+C8xxUgjwsRY68UJx0CBxQP
 JtQ8Siwdn6wIFBlAowo/d72fwcrmW2cIwCcj+6f6KEYP6tTC+GkwOpVbAxPma/DRLtUrJ
 5k7mkrLtP2qBqMwannJ57Bq5pBzGPxYaDgGTSO7WsqGigr33EUredWfsvt61KAHoeLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790962960;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=iSTSVYeLyJJV8+eQ0jAa8ljwQNg3PwBEJEe4iO+R9P0=;
 b=Kv4vg2yQZScL2Ui2wh2tMrur2oSgCNoX534my/1ETbUAj8rcB1d6hqbmLu/vV0eQjIYD
 RC0Bck/b3/EJf7jMMS3LhzROQGuLO5LujJtgrFQ35LyOlplsXX7qIX6Tzt8i60zsHokDY
 33D9AIYDkMsrxnW5hhiH/Wmd5hvJezy9SS8rPOGkNpYMLU1nsu+1K4zj31aEzJm3pnlqL
 IHGeCc136f6m+t2bEq1Mi5sZi+Aino6NFipgDeAasmb9ktYIiZroBOOAE2rNcPWpcc2N2
 KFR5HaSosQdysYEHYOzfW0CwpvksVE218rezhtJRNj9IUy9QlOyi+PlIZ3vC3xuBhnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=h0SKyy0x; 
 arc=none smtp.remote-ip=84.16.66.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=h0SKyy0x
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E17C6066C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:42:38 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hxGMJ1b9Dzkgw
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790962956;
 bh=iSTSVYeLyJJV8+eQ0jAa8ljwQNg3PwBEJEe4iO+R9P0=;
 h=From:To:Cc:Subject:Date:From;
 b=h0SKyy0xUaQhdOotvA6PgJj41HNWigOnmKEFVyoQmNW+QcMvpfnlxvgKxjl+NwMXD
 Gm4mXgwKPJHMfBCCbtGOiKOswDQhAoFu0dztlGcZlqUVlgk0T7NFi7hvzAnri29K2m
 TQlHwAKE6g2VEWTHs2pUJP7xkOIWXO5b+O1Jwxgv/QfFyiCDBRpZX1lSf0akwvZa1M
 Y2tQRjbByjInPMLrkjFqb92YqtgJrhHyQRaFcPouGSpJbUoj01XUz2A3O02Bt0IdrS
 l8pfNaL/kB0sorjZah11CWFJj6qcQQnbDqIgxwGOKeaiqL6qVKMRkpaF+je4jfhMgo
 mxlduc9E5ze0w==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hxGMH4RVPzDZr; Fri,  2 Oct 2026 19:42:35 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2027.01-20261002 into next
Date: Fri,  2 Oct 2026 19:41:31 +0200
Message-ID: <20261002174218.250429-1-u-boot@0leil.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Tom,

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1442

The following changes since commit b8e0086b585791a771416ce51b58ce0097bc0b28:

  Merge patch series "Cleanup MAINTAINERS entries" (2026-09-17 15:13:22 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2027.01-20261002

for you to fetch changes up to b177b194d9e4af7631a23b2a9227edfcf937f8b7:

  rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region (2026-09-24 10:38:54 +0200)

----------------------------------------------------------------
- Fix PX30 TPL wrapping around SRAM overlapping into BROM reserved
  region,
- Support for new devices:
  - HINLINK H28K

----------------------------------------------------------------
Chukun Pan (2):
      arm64: dts: rockchip: Add HINLINK H28K
      board: rockchip: add HINLINK H28K

Jonas Karlman (1):
      rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region

 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi       |  11 +
 arch/arm/mach-rockchip/px30/Kconfig                |   4 +-
 arch/arm/mach-rockchip/rk3528/MAINTAINERS          |   6 +
 configs/hinlink-h28k-rk3528_defconfig              |  55 ++++
 doc/board/rockchip/rockchip.rst                    |   1 +
 .../src/arm64/rockchip/rk3528-hinlink-h28k.dts     | 318 +++++++++++++++++++++
 6 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
 create mode 100644 configs/hinlink-h28k-rk3528_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-hinlink-h28k.dts
