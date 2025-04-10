Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFBBC369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310CF83AA9;
	Thu, 10 Apr 2025 10:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nfZN8Ysi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C996A83AB4; Thu, 10 Apr 2025 10:49:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C27483A98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B17DD4A404;
 Thu, 10 Apr 2025 08:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08614C4CEDD;
 Thu, 10 Apr 2025 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274978;
 bh=pq6qouoBIyDIMbG8jK30Ta9jiW3xhOwIUflzcn1++wE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=nfZN8Ysid631SLPQvmHPbE/f2bai4MKb2XSWrYcdKHB1B8asoP8CRryLMZxoVoyZ4
 5fTRxOkVCYtgeuG6+ffHv2G1kNdItLPDXhbVhxhK3zuDRmVbJ5plc1bbVuHJDO5KDF
 34ct4906wMTGAoLY+fhcpN6d3yIFVeqjKh/VA4Cke/mkmzACx5SU2DqtaD/nTRTTHB
 0sTE/18IwQrdo8QnTq5eu3+t38Cjs0oGtAcQZvfNxJ6KZD9CRqbbLVtUqq6o2KvYQq
 kLgX8ohmWJZuCXt3WVAYHb+f2+WUMOjjd0F8EGpHQU9G04s4vOofzZ0Hudt/K8Dmok
 tM2giPom6Wdmg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: sjg@chromium.org, Gary Bisson <bisson.gary@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250402144219.1875067-1-bisson.gary@gmail.com>
References: <20250402144219.1875067-1-bisson.gary@gmail.com>
Subject: Re: [PATCH] bootstd: android: avoid possible null pointer dereference
Message-Id: <174427497527.286621.12437470279697256699.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 10:49:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

On Wed, 02 Apr 2025 16:42:19 +0200, Gary Bisson wrote:
> - avb_slot_verify_data_free() doesn't check its data parameter
> - out_data can be null if avb_slot_verify() fails to allocate memory
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] bootstd: android: avoid possible null pointer dereference
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/df50c821e75957113b93e45b363cb22c965e7a9b

--
Mattijs
