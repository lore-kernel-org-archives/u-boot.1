Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C3AC3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D4688049;
	Thu, 11 Jul 2024 16:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dpIOAqYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE92188155; Thu, 11 Jul 2024 16:50:49 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B2D88009
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E7177CE17ED;
 Thu, 11 Jul 2024 14:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F601C116B1;
 Thu, 11 Jul 2024 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720709445;
 bh=uxs+nS4ovmqfmgWsESycOMJFJWQ0CwLd1wPsOwEBxnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dpIOAqYa4keGl0BYuOot3fjKj/UY59+pBUfwTyuoJDXo6aIZ93bhvsoWuiAr2maLe
 DbVgkKzlm6mTION7Qq52DOCTv6UGjyvn5yHyLyaOmbNfhm546c7STHjICl9OUbzqyg
 DllUNmosjFVxxZmYAosIg9WpraIUPcuYOTI2PY58Tgbv/t1Lhb6LZ34qSUpo73Iu70
 sj7HaOkt8n8eO5PDZxfMg1+r0Jrbe/+387m9q51kNarv7+bAR9DrxVNtD4p+OkOyim
 mgmWcP/682/9MVQsZ+WBt7y/G50aqwqiFDNGjJf71GPhlQIZIXrZz/bbKr4Jfr6OXE
 uHt/bDWRLMxkg==
Date: Thu, 11 Jul 2024 16:50:41 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] board_f: Add support for CONFIG_OF_BOARD_FIXUP for
 XIP images
Message-ID: <iw55bvqmzexikj3zsytrc5no6o6q3fbfyyqemoay7ydrusy4i2@x6npwe6as3w3>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-2-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163326.386950-2-marek.mojik@nic.cz>
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

Reviewed-by: Marek Behún <kabel@kernel.org>
