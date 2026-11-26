Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A36606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vMkdRdan;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/v10vYw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EE48409B9;
	Thu, 26 Nov 2026 13:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WoQA0Q5Gkz6; Thu, 26 Nov 2026 13:09:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7508040952
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698541;
	b=mqT0IKJAG+5JRSF1ggsmArL8MVtNMANgnBFK4tEs9kLYCnbUsbURrkWWBJhd8fURqpRl
	 IsXA16o7VypwuP49SMezi+vo2Va/gAwqe6yhCdBnUjmDydoT9Fm/TDZJnMBy3/Kc3QDxP
	 Tdaw2+d6aaUbs1fc/lun8MiuR9xoVAiqne3eSYKc1ujyRAvNwvAPvFw5ATMb0yJ866sjV
	 GtXiqdxGZPn1APdJ/5pnvein3PMf2acts1XdiNrOEJmPDwfmhBfYJePN5zOmdvxYU9cKU
	 B+K/h7oyfWOXQSVc6Gh8UR/PNUZY+A2fAyHsqf4rQrvCdGTaUH1smCVrt8PTONPHLOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H7pDa5wwoNxKEaSPz9WslsDu8V8FylM1aHQvU4C41Rk=;
	b=XsdFnJ6jT/YdNSvttZmW2hl5fSQDR5dRHGWk4+Lta/1ml4rK+ywT5vOeHDZy5L1bbFkJ
	 hSYHqMe2P8P4c0TlPt0ABkIHhCRIIvkFLMHhbAWcrm7lPCvt05ma2XyMH8aSGaJNBB0X5
	 ukn1TvFw5R9t4ivVSgR7EJRHwM74ip6jNj7gUD394MK29kcTiZApVkHynMU7f3jT5hm2d
	 a1F3UbzGNvEJ1KZ0FC8xKRxiNhckHIB5F0xgQv2auBQd1LQ1iUrmCYzsPmQmlCf1rN3Ay
	 fs9lH5mbNq9B+1JYg8ceMKc1E30aauo5rxOd6yhsZwssffyEzQ3AQHaJOW5UOszJ6NA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698541;
	bh=H7pDa5wwoNxKEaSPz9WslsDu8V8FylM1aHQvU4C41Rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMkdRdan3EqPG0myHMZ1PbFlMEmEis6DnclwA4ZO4yWhvh7R3XsfSBlsxsexhnGfO
	 kcrwnyQUOFKQVv7mCrChRXH/ZzhgHd1N1Vfkm8+lme/iWD/L7FqCJoDEMLTA4sGbRi
	 Zyy7GLwZw22EgY4JEcrOpuYiPFs4ItrMqjVY+mdbjvdQ60NRTh+RHOJcgqV0irar5P
	 2p5dndyFVkWqAxYsLmcGo6XXvyhecvGcrS2gxaRy6ANAsxcMeAdu6JpDsRbKdpXpvw
	 d8uBXgKYpW1iGALIWi+eKeUTsloxlmc0sEvIaMEC0cD4rVoEyXF4uQI836BW3f2KWk
	 YrUY0T+qKgSmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7508040952;
	Thu, 26 Nov 2026 13:09:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18DD032D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3030404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2wEXnlCPe0O for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:08:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 36472404DC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Y/v10vYw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36472404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:08:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF11160D75;
 Thu, 26 Nov 2026 13:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204261F000C0;
 Thu, 26 Nov 2026 13:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698537;
 bh=H7pDa5wwoNxKEaSPz9WslsDu8V8FylM1aHQvU4C41Rk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Y/v10vYwglYrzZ4gQo61pK4l8UV/jaonsFJWcSf1W0IT30KIHEjYEpiWpL5xd3DA3
 69HMRhpnidpGSfeqRYgdvuqSKgs4313vMKsKnF7PuUdqpHtOG2XDNB6AOKfurFWKwc
 Cb0D5Woc91TuRCYI4YT17QH3UOm2jYV61UbzPPJDvPSkqgtNKSqfesv21MGlDVT/UE
 uQeN4vC7H6YemuW1MCNLt82WW8JwZfldyR+QRRlaUC6uleGmBbxYw59BgS6KI918JY
 LZWZXzlWn9C8crAXvuO70ZxN8nTRRr4rtLzvIHCcSNwLxEWraJ4lVXtKHdPsAg+tj6
 pnrQcIbCaaR6w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261119-sparse-schedule-v1-1-bb683a12f268@collabora.com>
References: <20261119-sparse-schedule-v1-1-bb683a12f268@collabora.com>
Subject: Re: [PATCH] lib: sparse: call schedule() during image write
Message-Id: <179569852809.2171115.16314634294768705264.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:08:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=402;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=sanJ3a8s0hXz+9m8PWRiRrZ6M5MNlkl6OEf96zYy54M=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCC9n2qIPWZisclMDELTwubicoUz7478TcRsDM
 nGTV9msrZyJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgvZwAKCRAZDR20Zk4Z
 NTwyB/4hFJuqMWbKpjUtd4e25WVC9mFO8AKcrXzI4exIxxEKAWeTeni7xRi3tJHwsVDlNS/geIC
 QACuT2W747z8PfJ7l9uUiz66QQ57nktBlzBei/ESOq3TLkwlc3rWicLnDFLdlTNOxmdUPCth0yv
 Fjmwuxpwwl9ilU2SPX8mHJaQ7AXTCqQ6zvnQdSz1aLv0YN7ugdBXZ+jj56kl51o4QBJLNY48nph
 +j3K+4MKSXgKFUQ+w3mN5Xq0SKAC9pOVu0Bwqv6HwYI3fKfMW+Gz4SkvFnjwhb1AcUt/RMBy7J7
 x0gPQKbJgJKs7mBfE8V59cYrMfY8je3wlTvaYkkVtHjidUqq
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 19 Nov 2026 17:48:08 +0100, Arnaud Ferraris wrote:
> lib: sparse: call schedule() during image write

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] lib: sparse: call schedule() during image write
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/7cf646a7e9f02eb0326a09ecbbfb8090426a235c

--
Mattijs
