Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E3FCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077D983FB0;
	Wed, 13 May 2026 13:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vizd+D3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF3E845E3; Wed, 13 May 2026 13:11:45 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55543836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B3254058D;
 Wed, 13 May 2026 11:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B41CC2BCFC;
 Wed, 13 May 2026 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778670701;
 bh=Cw3uwMXsAj4Z7YLZ7++smDSVhYDcpJjAVqqMTWuQLSs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Vizd+D3wV/ZCPoaCusvrRAn/fTmVq+ESEETR3PeBp0OzIPA9T7d/hNTbkS7/LY9Z1
 hZikkne6AFANsRjFl4aOfADbm0mgemTGDaUsSPHKjoloQptmBqrJrJ1E/6cleSGhDa
 WcQHV9INC72JG8BQ7ZNJdZtL6F7BszaaFlEbHZjPKxj/9yH1yY/kk105GVD18YflbE
 SiZ7ZUdSP0GYwQKXXNNB2hI35ZoLa98svgY9enNfdvuJ3KzWSdqsv8zqLcAYnm07yK
 PagAMsdqZP461m8I3wOICBRluwgKHDQIZEap6H6YuSJbYh3cPVmCnxnc1QZGjnA2A/
 kGCWD4AJLzarA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] usb: gadget: f_acm: Fix memory leak in acm_add
Message-Id: <177867069882.265747.8221600445313980097.b4-ty@b4>
Date: Wed, 13 May 2026 13:11:38 +0200
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

On Sat, 09 May 2026 19:22:41 +0200, Francois Berder wrote:
> If udc_device_get_by_index fails, the f_acm struct was not released.
> Free it before returning the error.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: f_acm: Fix memory leak in acm_add
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c8f68234422b8afb516fea2336b678750f10ba5b

--
Mattijs
