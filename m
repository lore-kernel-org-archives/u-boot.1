Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B79CD343F
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 07:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81BC84CD5;
	Sat,  9 May 2026 09:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="M9VWxLAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B23284E21; Sat,  9 May 2026 03:55:00 +0200 (CEST)
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF42284E14
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 03:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1778291696; x=1778550896;
 bh=Ow549ydh+H1K1EpPvEGDXc3AeFciuF1jYfPul+fDvKY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=M9VWxLAEqfkylviBuZbdXd95ngvb/59SVHULLLSIw325AySaZBYT0WdpLAk71bgZB
 T+evy9GkXbPa96EuKiISriwdt2S33+TjnsWatlnCAY4msE7fV9GlU4dZRj0gNSujBI
 2rdOCK8qT9ILeQvA5apcz+AGWrwYQW1rzWMAKM7yz9qlmderl0lBPCcv+UoLTL83i6
 vnHCikx7Sx26FX+dwDt7bTydPe6HxalWHXCqoUawQcpqLuZDJvC1Oy1131mcXVq6MU
 bTOFZOJQnA5tGJ5pwtcmNG+Ak1nJhWb/L9gJ2NZ14R9g32bMdHvL2G6zR02NsFco+p
 oYRunu1wMknDg==
Date: Sat, 09 May 2026 01:54:51 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Ben Schneider <ben@bens.haus>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
Message-ID: <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
In-Reply-To: <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 63609e4df3278a8eca4e047d24839d9f1b613a9d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 May 2026 09:03:20 +0200
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

Hi Quentin, thank you!

On Thursday, May 7th, 2026 at 2:58 AM, Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>=20
> It'd be super helpful if you can pinpoint which commit between v2026.01
> and v2026.04 releases is the culprit.
>=20

Git bisect led me to 284e1a0 x86: Increase SYS_MALLOC_F_LEN to 0x1000. I'm =
really confused. This board is ARCH_MVEBU--an arm64 device, not x86. I chec=
ked the good commit twice to be sure. Any idea why this would cause problem=
s?

Thanks!

Ben
