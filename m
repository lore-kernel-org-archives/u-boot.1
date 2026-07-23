Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4ABC531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AB3660A35;
	Thu, 23 Jul 2026 12:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShDfrmS6ghwK; Thu, 23 Jul 2026 12:54:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F49C608EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784811257;
	bh=MR5bhVmClHcG+UtS/Fpc2DM9WqbsaDm/IXT+iW7tLhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G3KxKmEl6jxKi7wKk5KcFWIXdZFdo7aJCZw502WNsvyjdHNA4sD/iVo5z2xbDr47C
	 enhOzBbwiGu4Kq/U5FqZv6YwsYmMDsY3cBPx6ELmBvy5pxKvSVLAGjh/Tvk3SGOG4+
	 CsbVLErlSOsuF8Y8FuAWcfD1DdLeBlcs6Pm4XlF7h1uEdQq6DFwg7WqnXD6/7gJ7fN
	 3ttKdbWoV2GsKaxutSQ6R9UbVqrhDKvxTkPmD7e+q2NunK8OkQzrk/Fm3l1w4CQSqt
	 Y1sTwSwTEzv047eJay3s96l7Ff8G+JV5cfQGbW+UN+bnrii+Fb/3LZs3L3wO9z2zwL
	 /Xteokm56oxVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F49C608EE;
	Thu, 23 Jul 2026 12:54:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE30242A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFA4780E3A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCUmErv9VRov for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:54:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9703680E64
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9703680E64
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9703680E64
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:54:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C52D803F6; Thu, 23 Jul 2026 14:54:12 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898CD80117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:54:10 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 669BF600AD;
 Thu, 23 Jul 2026 12:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F74E1F000E9;
 Thu, 23 Jul 2026 12:54:06 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, "Nicolas Belin
 (TI.com)" <nbelin@baylibre.com>, Francois Berder <fberder@outlook.fr>, Sam
 Protsenko <semen.protsenko@linaro.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 2/2] avb: free mmc_part allocated by get_partition()
In-Reply-To: <20260712-avb-fix-memory-leaks-v1-2-51d6d5a42631@gmail.com>
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
 <20260712-avb-fix-memory-leaks-v1-2-51d6d5a42631@gmail.com>
Date: Thu, 23 Jul 2026 14:53:59 +0200
Message-ID: <878q71989k.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784811247;
 bh=MR5bhVmClHcG+UtS/Fpc2DM9WqbsaDm/IXT+iW7tLhk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Srtzjv/KP7JCUVKbdOX0LLabwXD7XXAjdyNrX8TSqezZDGW4JCZ/W8/b/ZedReLZB
 1BGEyfe/GipB6At2+WxXxoYkFDzwSyaT85FAl9gDNx0x3Zj7f6NqJCE+hXBJClLsWz
 rdBYB96V5CLiCkvCZKH3qBeLq9WhE9gzBTEsS6duaE1dtx8HZGoCy3dHWNypbW3vAW
 RszzP4ZceufHgkKUgvVgllreGalqTzOAtiwUyE2Z8ApYeOM+QVHuvlHQcA4Hl+Xx2T
 fQI8zu/nqBuIp8KG/Nsv8PZiP9aIB96Z04PMgoBSf1evwnqzvwqNZ/Zs/viUUtUMSk
 nlJv/IXuccBhQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Srtzjv/K
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Srtzjv/K"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Igor,

Thank you for the patch.

On Sun, Jul 12, 2026 at 10:50, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> get_partition() returns a malloc()'d struct mmc_part and only frees it on
> its own internal error path. None of its callers - mmc_byte_io(),
> get_unique_guid_for_partition() and get_size_of_partition() - free the
> returned pointer, so every partition access leaks one struct mmc_part.
> A single "avb verify" issues many such accesses (footer, vbmeta and the
> hashed image chunks), so the leak accumulates quickly.
>
> Free the descriptor in all three callers. mmc_byte_io() is reworked to
> use a single exit path so the partition is released on every return.
>
> Fixes: 3af30e4443aa ("avb2.0: implement AVB ops")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

