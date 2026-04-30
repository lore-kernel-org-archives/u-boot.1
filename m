Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6585ACD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27138465E;
	Thu, 30 Apr 2026 10:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qE/ivTZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364CD84656; Thu, 30 Apr 2026 10:04:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F2584669
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C29143617;
 Thu, 30 Apr 2026 08:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B90CC2BCB3;
 Thu, 30 Apr 2026 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777536244;
 bh=3Q81mYRFuMcw1CJAX1HiGnTxYJVm/NkvGio8v62bCWI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qE/ivTZ0gpGf5rSMxf/FKXd3W/MyKZPc/5PTIHvLAH65M8QLLnli0XcumWAi9dcd7
 Bb79CACvOnsg/vE/rjnZY2z5XpuTdDpvQVqGISpEni52KHx2cPl9bumrMv52vGETPx
 kkr/oCOS20QTx54tmogyJwwDHoBkt9l+Njzj7raTOGObmHspgoqAMTM0FJbggTxFS9
 SzNhFKC4Vdy91mNBpbACPZzET/40cZuM7NBMEJzE6ekSdaFE5p4Gh+8NDDtCRoXNKs
 hiMdmhXnJjur91gd1+EzuvqnYJlTtVJmO+075TTqntoKF2zn96xcekikd0OO04Fk4p
 jaEo2vxJJqihg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>, Neil Armstrong
 <neil.armstrong@linaro.org>, u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] doc: .clang-format description
In-Reply-To: <20260424130510.275226-1-heinrich.schuchardt@canonical.com>
References: <20260424130510.275226-1-heinrich.schuchardt@canonical.com>
Date: Thu, 30 Apr 2026 10:04:01 +0200
Message-ID: <87a4ukeuxa.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heinrich,

Thank you for the patch.

On Fri, Apr 24, 2026 at 15:05, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> We cannot use .clang-format without modification. For instance U-Boot
> has some for each macros that Linux does not have.
>
> Adjust the description.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  doc/develop/codingstyle.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

