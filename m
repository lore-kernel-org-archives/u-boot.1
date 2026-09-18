Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A832BC982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6502840BE4;
	Fri, 18 Sep 2026 16:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EyfVrrYFcp6D; Fri, 18 Sep 2026 16:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7FEB540B97
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789749403;
	b=nUTZTBLZBnH4dx5BTaKOxHwS7vK+66a01K+zqN2VBsv/Ao3Le4h8GEpjbLiKzu32xyhS
	 ziJa0g8lmkA7Ut9iQsxJ4AVzfx2bS9CU+Ndqt/F6JuSP9iNdEHIZkpvDXK/Ld8uIPvpPR
	 sth/4qlJv/56QVFbouYMp/W3bBnr92CR766Ot4d/mvceR2ppmlA7qZjzB1so++mFhCQYF
	 +xvrazaFd6Ii4xX7Q9yksVUhxRGAC4/FCnM3fHkq1ZUNjo/CHn3TDZZsycDD0HaEtxXwx
	 FmDrw7rJ3imLtDoNjajQfGKR4/xHd0A81MthtfoZj4fNMAdVyVRlKkWK2BX2QJNLOPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789749403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NHFsSDpg/chqVSxxEVXRKLLoAaarMWvKFUpjJLzCT4M=;
	b=JHeDutodMiQL57SrZZ9J739ZfVl2oR1kFsgWNPXl5i8CzS2HlD+K3HHF0CbvaQIc7/O0
	 J4ISlO3okcYXAo61Tnfrt4ulgB47j4742kx/uprkOVlKO0gU/R6JKZpUVBxJxoFXAocFf
	 yrO7gSbJRehXBzXxMvUfV2U7LGOwLmID5kH/T3t7sasli4l/jovofJzjdGzIukheEgqJa
	 WWV75C99d9PAudqtfbl3+9eYS6xn10P8bkqFvg+qACu7Qay4Wwn8wxAKltalJ4D7EF2+X
	 1gtprVbiJj0S1rDrjOkI9ZhY+4phdqHxijvmAMWHAETvLYe1AufPRdE8qk3vI7Zhydw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789749403;
	bh=NHFsSDpg/chqVSxxEVXRKLLoAaarMWvKFUpjJLzCT4M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FN2COO2d1DtHXq0zzfsNkaQSpJsHJPQm73DAbiOKZ16nlq0GrBzM2otBO2oMrKTOJ
	 YXd/hOyaSd0pRsclhaXWc7p3wcqYDzxNptkp2KtQxR1A4h0LcRCGkEBHlthzPrAuYS
	 QGpZlc+sjfsqPEyjhZiOzXsmfcZLUbAKFYWdKwf4gSdr5jqL55WJy4zB97EENWfGhg
	 xdTTTKvau0qvFe6px7Wn81ya3SHTm7A8yPUWCPmFkoRO3lT+bH52nAQFOj72b3KpzU
	 I6RVt48i0yoncAc0BAFSkpNsQepjc987oudJhBJeWnt8rVCN2pGdHct/ZpM95Vn+YO
	 sCjdxxoeV5ocw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FEB540B97;
	Fri, 18 Sep 2026 16:36:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E92BB362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA7BF81326
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GBWX4jl_yuP for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B6A1781319
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::1909"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789749400;
 b=bog48cP7THLziZCacArtMX0edAIBW/na/SQuJ4amBHl5Z4bTS6keYoJVyb0qEAdSfzWm
 lD/h9cKYbje1KzJq6rbu7UKPQsp+k2gOdzq/nBYPJG1APG6s1LsiZWDBrRJOciEQtzSvB
 XeF4fRUkXOdO+AiOm/YKIOjfGOLxy7fbUy3vnmvMigqVzpFZ+izV6RlG+cqHtTn7VVBX/
 lEPdwzGCk1S6LU102xJhkPIXQaqkQaiPYzZMeu9QTQpeu8M0rTE0jAUBsn7L4dJsFpOYM
 icWWHwAgcSbfI50KSdasfQdpDcK+gHWOI66NuZ1rEkDUhTZu4Jwk9WCBQM1tn9QY6jA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789749400;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=NHFsSDpg/chqVSxxEVXRKLLoAaarMWvKFUpjJLzCT4M=;
 b=Nzlkcg+NocU2r3AvNhArw3mvWjmf2Cr8JD4GhvzbwNGgnhnQOzvUOOc2V/rUegKFZIpK
 Q6S1MI4oGNE1y+izE4af8Thg+W+lBNoNVuVJB5sn9aneejhL4NMrkYsOzyA+QIrvRwRLJ
 AeO4igW2gW/cAL/kHnooKr5zJTogRebWqJizRoyeSFRH04J9dIOJPbF90sSdgZyd4eTQS
 BINEYVTc+w5WBgzQCQNXOp5eSFg0dw6R+hxGunvKNSXvl6c2heNJxRPB4HJur9ACA/rl5
 Yd986BRNLsmMXI+1IBpdu/fvvGQL19uNAZlOnUh17Sika6Z/r85dKIBLTB5DE0gw5pA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=RILdG+hW; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::1909"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::1909; helo=smtp-1909.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=RILdG+hW
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::1909])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6A1781319
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:36:40 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmdYb3Yl8zrmx;
 Fri, 18 Sep 2026 18:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1789749395;
 bh=NHFsSDpg/chqVSxxEVXRKLLoAaarMWvKFUpjJLzCT4M=;
 h=From:To:Cc:Subject:Date:From;
 b=RILdG+hWFxqerpdsSDeq0FBmCsaQb6oKksgszZ/Q9g5xXbbEGSrMQHwiq6uDSeAp1
 wtIActUd7mUw7+JurPSZkZIB5W4X1GrNyoiFNWvROub0v9V67nGdUXGkk+zVA0hH85
 a+pFgcAZOBPlu44uU5OrpnN7E7nyZymZU3we0knFaNWtC74ClJfZS/6rSawPPS4ROx
 kM/jmGKUJlFx7tqJltcKro3elXQ/dLQErWMddgZvycTJOWijB19CZN1brpmmKz9n3w
 GTTYB9cFo/NobibbzLAQdc3XfaJQRQsyYibIuMxinAz3ld2wrG497eIKuSvyujsoKM
 pv3UI/kPzjUZg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hmdYb0Hn1zN59; Fri, 18 Sep 2026 18:36:35 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260918 into main
Date: Fri, 18 Sep 2026 18:35:24 +0200
Message-ID: <20260918163622.351793-1-u-boot@0leil.net>
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

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1325

The following changes since commit a44f46af0aa17e48572e0d46c0d082886ee353c3:

  MAINTAINERS: tee: update Jens Wiklander's email address (2026-09-11 10:22:58 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2026.10-20260918

for you to fetch changes up to 508732ba45b8a328e2b38e9fa02820904922e421:

  board: anbernic: Fix the RG-DS Kconfig target guard (2026-09-15 11:28:55 +0200)

----------------------------------------------------------------
- Fix fastboot default buffer address for RK3328,
- Fix incorrect build configuration for Anbernic RG-DS,

----------------------------------------------------------------
Pengpeng Hou (2):
      fastboot: fix the RK3328 buffer-address default
      board: anbernic: Fix the RG-DS Kconfig target guard

 board/anbernic/rg-ds_rk3568/Kconfig | 2 +-
 drivers/fastboot/Kconfig            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
