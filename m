Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87241C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 22:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F165040853;
	Thu, 20 Aug 2026 22:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6DxJL5p0wpm; Thu, 20 Aug 2026 22:15:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787264120;
	bh=Xtnu1Q06Ar5dWxEmRrL7QJLEhEpkG+69QpHcGOnDvv0=;
	h=From:To:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asnhGOyq5VoPa1JVJT8nKefoXvhIhmk/QqAjr9FTTvnzM+zI2v1c+h/OPhOT68usX
	 SP1oHsq0fOTdLDWFEVYbqXOH0squIAATQtpt11lxZWNrn8wGmx3kVKUdW+N+P9tLc+
	 sWhwdcps2danCYzfF1zcYrgU3UmSjW7rS6FwDVAaXkplnElfBs9duU/p8EWG/hYA2K
	 ecmNtIuBZiNahBr/KZYZO9AqvzVqxCDuADjuTrpZichOPuAqXGm5tIStDsncuHgHtc
	 6MKOtscmQXjsQ+BSDgV3WXJHGySsBx+u2V1cKwVTsQm/Qax2oU9yJ2JRG07H6ydLcA
	 t6uQYdEoWUSWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6980440816;
	Thu, 20 Aug 2026 22:15:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D417C39E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C97D9401EF
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:58:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeNt6TqW3gIN for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:58:34 +0000 (UTC)
X-Greylist: delayed 469 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 18:58:33 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca
 header.a=rsa-sha256 header.s=mail header.b=VezoQq6I
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=132.204.25.50;
 helo=mailscanner.iro.umontreal.ca; envelope-from=monnier@iro.umontreal.ca;
 receiver=<UNKNOWN> 
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93631400A4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:58:33 +0000 (UTC)
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 5617E80320;
 Thu, 20 Aug 2026 14:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1787251840;
 bh=4y2QBiqZ1njR6Wfx8l2CLBoY8j4OB464O+Y2tPT4ZA0=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=VezoQq6Iwb4Uajy12SL/S48USgjpcmiF0adZYeJYJl3fSD1YRhHXBsf0m/WgcCtRi
 8OyTrleKtY9R07gdUdl0zNc7gT8o2wFVuExMzok0cClLC5V9n8to6gqxEo2FT6YeJQ
 lqoKFA2XyKoN25Q9lu5gSiCVbB86zFDicX7//WSPLKPYDeeQZlxVLqX1RoqeuZLFpk
 kazq4HeHoPkNv14bV4UfVEomtYYdCF5Kb4E7gdl6zR0WZUXlgqTFRNmVpoYOE9NwG4
 lrfGFjmjrCptg7P8YZEwn08ose0ZmLB3TvQE5ZSmOODVgDm9AOGrm6Vng/Bviqfutg
 036quxaPYYpTA==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id A24B880316;
 Thu, 20 Aug 2026 14:50:40 -0400 (EDT)
Received: from alfajor (modemcable181.99-80-70.mc.videotron.ca [70.80.99.181])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 81DCC12034F;
 Thu, 20 Aug 2026 14:50:40 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: u-boot@lists.u-boot-project.org, Carlo Caione
 <ccaione@baylibre.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
In-Reply-To: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d__17726.0234997206$1787249364$gmane$org@baylibre.com>
 (message from Carlo Caione <ccaione@baylibre.com> on Thu, 20 Aug 2026
 20:08:24 +0200)
Message-ID: <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d__17726.0234997206$1787249364$gmane$org@baylibre.com>
Date: Thu, 20 Aug 2026 14:50:39 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:15:19 +0000
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

Carlo Caione [2026-08-20 20:08:24] wrote:
> Some recovery and initial-provisioning flows need a standard host protocol
> before usable firmware is available in persistent storage. U-Boot already
> provides fastboot, but the implementation can currently be started only
> from the U-Boot-proper command line.

I'm curious.  In my limited exposure to U-Boot, I got the impression that
the split between SPL and U-Boot proper is mostly a "technical detail",
usually mostly hidden from those who install it onto a device: you just
take the combined U-Boot + SPL image and write it at the appropriate
offset on the relevant device.  And usually if SPL works, U-Boot
also works.

So a bit like Jonas in the recent "hotkey in SPL" patch for rockchip
SoCs, I'm curious why/when we'd want to add to SPL functionality already
supported from U-Boot.


=== Stefan

