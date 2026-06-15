Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFA3CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED1C84874;
	Mon, 15 Jun 2026 09:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jyxQqhTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3896684872; Mon, 15 Jun 2026 09:15:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B9483FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE1A343EFF;
 Mon, 15 Jun 2026 07:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16321F000E9;
 Mon, 15 Jun 2026 07:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781507743;
 bh=02HkZ+RSJ3N+7TGjge/4RVUt4slQBI7Z71cfE2jeLbA=;
 h=From:To:In-Reply-To:References:Subject:Date;
 b=jyxQqhTD6DepQGieL8kJ7v3g6TNejBdOdmAia2UThFQXklwnGRJsCvs8IXCEMarzd
 pMdDqYz8r8hwiQ3QiLV9exqu0BQMeMMz/VzPlqPGgjC1d5ngTctM7Q0mFElkJ6/wIj
 B14rGs/dA1w1YbQJ3Is3eurwZRxEulQlvQXGdbea7KDh6cTLTvn4deOe5RWT2/jEMd
 U3bm8P5ILLhqORJgbIwFoUUHE4vkI+FRgWSHfN7/yFQezSa8UzR+gpkvb6vsaG9m8R
 v7RXtmZx736ie4zt87fEt1zN93gxUYmK2lcndyf0FzKb844B0B+gaoooLgOCZqYIrO
 Kg4McR3pklyDg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Colin Pinnell McAllister <colinmca242@gmail.com>
In-Reply-To: <20260525003158.11319-1-colinmca242@gmail.com>
References: <20260525003158.11319-1-colinmca242@gmail.com>
Subject: Re: [PATCH v2] android_ab: fix slot selection
Message-Id: <178150774110.19584.5409566751338368169.b4-ty@b4>
Date: Mon, 15 Jun 2026 09:15:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

Hi,

On Mon, 25 May 2026 00:31:58 +0000, Colin Pinnell McAllister wrote:
> The boot selection rules state that a slot is bootable if it is not
> corrupted and either has tries remaining or has already booted
> successfully. However, slots that have tries_remaining == 0 and
> successful_boot == 1 will be disregarded when picking the slot to
> attempt.
> 
> Updates the selection logic so slots marked successful remain eligible
> even when their tries counter is zero. Debug message now also includes
> the successful_boot value.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] android_ab: fix slot selection
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/e41e97e6e6061fec5a2fb069eaad662cf6359a93

--
Mattijs
