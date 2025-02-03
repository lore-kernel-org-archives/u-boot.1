Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB6CC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 18:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D4D800CF;
	Mon,  3 Feb 2025 19:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="nrr9To2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 729E9800D7; Mon,  3 Feb 2025 19:03:40 +0100 (CET)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com
 [91.218.175.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B510800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 19:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1738605812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=RWbgpMULkuJ7LwNGfEgS4c4JRTlZdGoMEMzKIfAsNRI=;
 b=nrr9To2lreXycQiqL5BlY2nur8zoNmkImLXJt9mA4C7Oq3Zr12ywtVhLwvwP6l8M0r9NQi
 FSkKdw3+QvFLsNw4JYwNjqUsZQi7+78jGzzTUT2Ftkdi6eUPmPOxXOYlWIhhvkle7ueNpG
 YCUoKiezVJLBcC8nBjeE+jaPVKYvKIljyfR2FBauEBNU1ri/5yUfqeitfCP2wKh+s3qxe3
 LMxkCsEjzLfV/JRDHUjRN97nfUeEB+2LAcsCbMd6i8QpVUws0wxzD38kRdLqlqqiDNHBdN
 a7FQaPA0GsEyVLfx1GchHsHeKha0HQGugyLIGSoWfBZNjB2bfN0x9rDIcOAong==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Feb 2025 18:02:44 +0000
Message-Id: <D7J0B21RXMXK.30JW6VMTRCIZM@postmarketos.org>
In-Reply-To: <20250203-ufetch-vidconsole-colours-v1-1-a9e543ef4cde@samcday.com>
Subject: Re: [PATCH] cmd: ufetch: use 3-bit colour ANSI codes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <caleb.connolly@linaro.org>, <trini@konsulko.com>, <u-boot@lists.denx.de>
To: <me@samcday.com>
X-Migadu-Flow: FLOW_OUT
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

> Currently, the 8-bit escapes are being used, which aren't supported by
> vidconsole_escape_char. Since the current usage maps directly to the
> 3-bit equivalents anyway, let's use those instead.
>=20
> With this change, the fetch output looks as fetching in the vidconsole
> as it does over serial!
>=20
> Signed-off-by: Sam Day <me@samcday.com>

Tested-by: Ferass El Hafidi <funderscore@postmarketos.org>
(tested on S905 Videostrong KII Pro)

Cheers.

