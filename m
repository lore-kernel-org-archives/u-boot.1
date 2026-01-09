Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4F2D232EE
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 08:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F0F8414B;
	Fri,  9 Jan 2026 09:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BW62j4AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E2E84326; Fri,  9 Jan 2026 09:25:47 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7838484121
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 09:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B080240672;
 Fri,  9 Jan 2026 08:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE49C4CEF1;
 Fri,  9 Jan 2026 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767947143;
 bh=4RClstSHDBLMka29vt3wV7Vgdt4+c74y4sJd4gphLPI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=BW62j4AALWrVKvVQkAHdG2rQLVjy6aIqqDEG/cyWpLpNQ0RPtCpvYpt89z7m7vWgF
 BeR3/A7J1B4cqNP4tTEc9lSmvWzCJiYAlGRUSRkYnJCKXZI3izZrwh6g3oXuu+8ePM
 xV4oNWsTsKaM2G0LY+9Iepk2R5UtPfgMXN60sWA5XAOPe8kcfQ3oQsrRVUZpOo+IVU
 JWzWA5ngjPiHvM7SwTh+YIMy6Ut0MRR7BMI6xdKPukDa/1AIxBXN3zzZJMbtmGhNJn
 j1znKo8RTCrQvaYjtPECnxv080tv3NQWkuQWGRbPn011zzesETh0rTjG6X9PszzFxB
 cNnxQxh4wLthg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: trini@konsulko.com, marex@denx.de, 
 =?utf-8?q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>
Cc: lukma@denx.de, u-boot@lists.denx.de
In-Reply-To: <20251218142737.3169753-1-petr.benes@ysoft.com>
References: <20251218142737.3169753-1-petr.benes@ysoft.com>
Subject: Re: [PATCH v2 1/2] usb: ci_udc: Check ci_ep->desc before use
Message-Id: <176794714088.404000.8705478218122937720.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 09:25:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
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

On Thu, 18 Dec 2025 15:27:35 +0100, Petr Beneš wrote:
> There are two places where ci_ep->desc could be accessed despite it is
> not valid at that moment. Either the endpoint has not been enabled yet
> or it has been disabled meanwhile (The ethernet gadged behaves this way
> at least.). That results in dereferencing a null pointer.
> 
> Moreover, the patch gets rid of possible outstanding requests if the
> endpoint's state changes to disabled.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] usb: ci_udc: Check ci_ep->desc before use
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6a92e9827650797b6b5290621c1831fe32d6ea4b
[2/2] usb: ci_udc: cosmetics: EP and requests debug info
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8ea70d8132df30c37c9592952c6267c2e9b4e562

--
Mattijs
