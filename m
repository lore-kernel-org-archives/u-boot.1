Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02D5CDC19B
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C0983F66;
	Tue,  6 Jan 2026 14:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hb6q82DL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC7883F6A; Tue,  6 Jan 2026 14:20:34 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C7983F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B5EE6013D;
 Tue,  6 Jan 2026 13:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78369C116C6;
 Tue,  6 Jan 2026 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767705631;
 bh=aXNQX7shPR2V979LfLH5MezYvxrPs5o0XxFLeB8iAPk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hb6q82DL0uN6qzuvhafKfBpL05Rl+GHn6jamT5DSIcy6NDYBn3GaYRiv0DT1b6yB3
 L8RoEBaJf9s7bCwOh8m3ghM31I4xFMqMVhRde0aSAlxZhcksFXTUS1J8wMr2tnRQU6
 /QZGE/ciRoeYpJGUJg09Bcn0HGqNPym0USsRlyYEsbzzZ3Fqxq8pSEO8agoPydAj9M
 fFMYBt4pR1YKHVbQf96VctMK42IbDWVlzmCFee6yePwCOpYPNzYUrdj4ZWaEOLi3Ws
 VOg7WQm3PR0BXSd0VyZJi0pRlvt7sVUnpAXccaGrB6Fo/EV4QiWtccr9vTo6rKCosM
 +N6VPbTOWPnng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Petr =?utf-8?Q?Bene=C5=A1?= <petr.benes@ysoft.com>, trini@konsulko.com,
 marex@denx.de
Cc: lukma@denx.de, mkorpershoek@kernel.org, u-boot@lists.denx.de, Petr
 =?utf-8?Q?Bene=C5=A1?= <petr.benes@ysoft.com>
Subject: Re: [PATCH v2 1/2] usb: ci_udc: Check ci_ep->desc before use
In-Reply-To: <20251218142737.3169753-1-petr.benes@ysoft.com>
References: <20251218142737.3169753-1-petr.benes@ysoft.com>
Date: Tue, 06 Jan 2026 14:20:28 +0100
Message-ID: <87qzs2g9nn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Petr,

Thank you for the patch.

On Thu, Dec 18, 2025 at 15:27, Petr Bene=C5=A1 <petr.benes@ysoft.com> wrote:

> There are two places where ci_ep->desc could be accessed despite it is
> not valid at that moment. Either the endpoint has not been enabled yet
> or it has been disabled meanwhile (The ethernet gadged behaves this way
> at least.). That results in dereferencing a null pointer.
>
> Moreover, the patch gets rid of possible outstanding requests if the
> endpoint's state changes to disabled.
>
> Signed-off-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
> v2: return values aligned with Linux as requested by Mattijs
>
