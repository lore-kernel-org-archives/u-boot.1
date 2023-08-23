Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7104DC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA40586434;
	Wed, 23 Aug 2023 22:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GGiExLln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB608644F; Wed, 23 Aug 2023 22:35:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E1E86432
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4A260EE9;
 Wed, 23 Aug 2023 20:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27214C433C8;
 Wed, 23 Aug 2023 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692822929;
 bh=HVF/IqL4a6jfQMW/tvdMQOuUX6rIRTEbI73uPMwgZ6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GGiExLlnvhO0DqL5/Y8qalGGVHiqNdy+mDaY4jKule+caAnQb40TcuMRyvzVA2HpP
 dInYE2QnOuSIF6HJH3l4wmuvYecgQnHhlUF04Qhjlfgul9X5Wx8CQyi2OwGzIhWfkH
 RfBMU+mvV29u32PKv92CbDoV2Jdt+WoVEfVLtrdjLTYOonNY92hmwsCwSyHLZ92FyW
 Vqa7Q3cSPMkkDrN1xXODyfQ/w8ghTxy1QpkJLxB/DU9XHgNfFhuvnPZGocs8UvXHeg
 utRA5fd9leWMAq2g3RQ7dC+nQwn3KGSU0YzevrzGkbDHOqrw7qehS2EcTnBkfzB76g
 z21IVU0B8AK4A==
Received: by pali.im (Postfix)
 id 6807B7F5; Wed, 23 Aug 2023 22:35:26 +0200 (CEST)
Date: Wed, 23 Aug 2023 22:35:26 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Message-ID: <20230823203526.domqjv74ttdwfo73@pali>
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
 <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
User-Agent: NeoMutt/20180716
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

On Wednesday 23 August 2023 22:32:18 Heinrich Schuchardt wrote:
> Looking at the MAINTAINER file it seems that POWERPC should be set to
> orphaned.

And this is only just because of your fault folks here, as you have been
completely ignoring any my patches for improving this situation here and
finally after more than year of my reminders more of you wrote me
officially that would ignore any changes from me.
So go and complain to somebody else, not me.
