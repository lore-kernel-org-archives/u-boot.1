Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96D8C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1095C82B00;
	Tue, 20 May 2025 13:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R2Y502TK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A15582B07; Tue, 20 May 2025 13:35:30 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B4F82A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E62E6A4E8CA;
 Tue, 20 May 2025 11:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CDCC4CEEB;
 Tue, 20 May 2025 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747740926;
 bh=KcXOWbqML8zE7wwzmyYk33A/4c7tPypkrvLAT0XmqGQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=R2Y502TKEjSDz2huGedJnUpyYp7XD6ITzltQjwXp2xaqrav2CZ+aC78exxELCqlBu
 LU4z+T6AWeot+85093oUmm8x54cqUgzDujw3kttHPf6pGxPLpnO76YhZcEfqA5KzyU
 SojclBg90dSLW/At3sK13pf717vWCIr1eK6Rgm66P2Uu/q2ZPoJ4sJCE9lal9yXsp4
 UmlL+DnvdMO3st1iMP3HGpj4WrYtqKrcevma5hTtYthrhn2Yd8fiuPkySL/JNOEM4g
 prFXAU4xJWDZT5WH//sYNQxajxp2VPm7SNAVhrcn/ocN0ShHFFUFuSl+B7Wi6qIIez
 8L0bCxONtVk4A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>
In-Reply-To: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
Message-Id: <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
Date: Tue, 20 May 2025 13:35:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
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

On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
> This serie permits using any block device as target
> for fastboot by moving the generic block logic into
> a common set of helpers and also use them as generic
> backend.
> 
> The erase logic has been extended to support software
> erase since only 2 block drivers exposes the erase
> operation.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/3] fastboot: blk: introduce fastboot block flashing support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88239b5bb04bea2b58f7bf4c3ea72cf832de818c
[2/3] fastboot: blk: switch emmc to use the block helpers
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/25ab5c32c28b9f25fb193f726f239d75af3c365a
[3/3] fastboot: integrate block flashing back-end
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a885bd8c969e25d03bf406207d89b1145c9490fb

--
Mattijs
