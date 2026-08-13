Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2358CC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 14:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFEE180E57;
	Thu, 13 Aug 2026 14:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xkdLIQ43wb7M; Thu, 13 Aug 2026 14:14:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBC6080ED4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786630467;
	bh=gSCqSSIZ7KAHpfefXzFMDlIjNG0PcebU7tHzexuW24A=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HOocdV0FvwGAPFlnLf+VkUYA5l5RD6Jv3aJS4YupdRDQMGHtSMdEJNCvwfc3J0bEp
	 QLyZlfvg4UifE8XrqLyJEewEgu5ULp8PR91UI2gNWRvl+u9H2y8ph4GPJdNmaaL2h6
	 TBQ4A01PFga46HxE6JowAgqnyJ9NYJWznu+Jz5Qk9hcjDayMMeZHRnoIecbv/rnWtU
	 lU2YEzNBOFEtef7tuY18TJY5doH7gdtPO23uXMPD7zsNbrn2i0rD115yxGswMI+Pm0
	 +uXvQ4s9sfls+lSoMNoGfeYyGGEyVygli1nZEIGtT16bBbUdy1ROu69vs3OOkvjODi
	 Py2YO/xCnbi3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBC6080ED4;
	Thu, 13 Aug 2026 14:14:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 811361B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7300A409B4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msL5LU0SVjp7 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 14:14:24 +0000 (UTC)
X-Greylist: delayed 88187 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 13 Aug 2026 14:14:23 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 40DAF409AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40DAF409AF
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::42ac; helo=smtp-42ac.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::42ac])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40DAF409AF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:14:23 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLS653kgdzY7M;
 Thu, 13 Aug 2026 16:14:21 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLS644dVNzP7; Thu, 13 Aug 2026 16:14:20 +0200 (CEST)
To: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260803184314.2240153-1-jonas@kwiboo.se>
References: <20260803184314.2240153-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2 0/2] rockchip: rk3576: Disable force_jtag by default
Message-Id: <178663046060.267559.13559215192066049299.b4-ty@b4>
Date: Thu, 13 Aug 2026 16:14:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786630461;
 bh=gSCqSSIZ7KAHpfefXzFMDlIjNG0PcebU7tHzexuW24A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=AbvE1WmbLu+rn8ihtDDrEvqTU32TPJLcsR5QhiR1c45NCYzqBhRrGzti5L+njIotm
 8GyaEzOFK5h2tkhQ+YTV8Sz3MWcNwkjAxvM+KhbDAuo+5tvih4qLer6ypjL3KMxnCh
 QYBfQ/jMyk4j2GmDdKMY/VTsxFEJXQXZR1HC7ItB4PUSWYRtEm6r7R79lOQAXqZQ7X
 SfiWkbcMl/mJ04bULroUI8eSVmkUXUvpQv3utZEsc+I4O5b7p9tAD5JsJn3h/RQJVZ
 Ku/TuO5VfRMsxguaAGPbewLQ+nkxnmCvmaRwVxUjGw+92rzCauvXKwAMdkWvvRS5fy
 xcyxqZLEs9srQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=AbvE1Wmb
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 03 Aug 2026 18:43:11 +0000, Jonas Karlman wrote:
> This series import linux/hw_bitfield.h from Linux and disables the
> force_jtag flag by default on RK3576.
> 
> Changes in v2:
> - Import linux/hw_bitfield.h from Linux
> - Define TOP_IOC_FORCE_JTAG and use FIELD_PREP_WM16
> - Collect r-b tag
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/2] include: linux: Import hw_bitfield.h from Linux v6.18
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/0c68b88ce574ddaa2f94f3e5d747c25db693dc18
[2/2] rockchip: rk3576: Disable force_jtag by default
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/c8cac405f29896362786c7ced1417fd15e7b8923

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

