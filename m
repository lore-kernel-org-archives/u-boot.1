Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5433CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E6BE8136E;
	Fri,  9 Oct 2026 07:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGIbvGHiykYq; Fri,  9 Oct 2026 07:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDEF981462
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530800;
	b=ZJY/IEXIFkhFpvBc84oFk3GyQKs2brOkxiWd705D/HEzT5wOQK0pLD1WL9kzEwNzYkzA
	 RyzIpGRjNKFaHyWrZ6Py/0x+iO9V1cJoE9IhRtCOnNktKojFArWc3BFVdlt4448k3bF3C
	 j6q6CyOw3u3Oysf5ipCYoZUS/B90DV5FrAkihpAi4dFKmfcl1+GPKtEd4p1zOHVb7Ibvm
	 tVBQ0FFV2pud1XuESNdPaG8QqNFdQtOGm8DPPzHdW6AsgA8hikckh8iysArpulwLkSWXA
	 PhyemeZd2IuErEC7hbiY2Hj5qhQAb5Tux8so1pngXMvCBqqraRFPOcmPOrKgfFDKaeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pCPAotWxIo/c2d18a4Oj2sQZnTfhd2zfqcfvGuaAY7A=;
	b=UAyMX+tChEQ9E/e4+AfjiXS6JumjC0bSZfDAj2JHYlmG2+Ui3F+d8jWxgPQSpMjGMhQO
	 iBZYLk1jbZJmcVp1LxYg4K0gVjnlHsH7yMhgoKiXt6xjjExQhENmu/slArU6FV/Il+T+A
	 M67D2z4zNzGSXYKMXYwDnR7vljy/MruSEE8A+NCzZkPo1EMfR250TIJ4h2LLpqpEBbXg3
	 yp3OOHybqCeanVUu5d3dMjoo49kAulnQhFw++clvr/LzXHSZjXjaddKHbq/E8gXjioMUt
	 CT1dJPKBx+Ic2WxCLrppRqPBjP/SZ8NoH3qWrFM7rHQDKsMOlBZyH3r1mUEGUqAigug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530799;
	bh=pCPAotWxIo/c2d18a4Oj2sQZnTfhd2zfqcfvGuaAY7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJJfxhoHXaT34Rzuc4OcBQCfD+hJJDkzMqZUKB2obb1iqjae0GvF9JCSeu3I91/1e
	 NUV+GFlu/Dfa2aVE6s4wUhIig609ElCTNUeQYhk56CT/JoRnLz2ZCqjSbKIfqELsZt
	 tqsqehXxg82k5Jp4TPOPcS/ImsQwvKsE67rB43KewYsaOVuolPW2O8nuLaRY2YzfhV
	 uizijpS43ngHRg6LFAzIGYC9vt/BT4kuo0jfGsPSTvd4e9hSzeTDIiXNMWctb7ovtk
	 /pWiizHW7KEcbO3NFIY20Yz7j8O3UXlfOzWi+Yoc1klYCZCIxBBq03z1Q8/gtqFVq3
	 1iJyuwQS9yFIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDEF981462;
	Fri,  9 Oct 2026 07:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66B4B2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D319400E5
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-15J8AiF3n7 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 870C440061
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791530797;
 b=dEWBm9Ez+jolCYUFNUOsEc4ILh04zImtmML1BGWIIW0+9C72JyDpl2GjawZYaOvjqcv1
 x4rrw0TfZqF3vzAWP3RTr9mpMm2rS92GlS86g8UMHbcBE4eRJY0X3X3Nss3/GKQRhic1D
 D/J2G7WIwXRQk8167b9hfdC3fF9dAhltL2SnHutenPrOeCW3l7eXyyTj29MU8Bu5vYlnd
 21kGbUk+Ocx1AQy5g1s02F8algCrM/N23zRohLyKgBEEbOVzVKuqVa6XeddpjREqCAjfT
 HXHpaPYqUOK1EyZOLV/B5aLI6nSriJ7xPV0436+/6Ko90TNz3y8avumZzCNPiQaKJ5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530797;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=pCPAotWxIo/c2d18a4Oj2sQZnTfhd2zfqcfvGuaAY7A=;
 b=q+bcJh67a1MUbHEiCZ3MvK2cm7uzeKhydNLZyANDKBle0X0+bnjHiymkau4yOY+w6iRx
 0q3Ugrp64/XqKwU9Ins4SdZPgZlEUTwEDfIaUbV5sgf7z4UBb7UFJOY0Z9bu0QaJ1ZVVj
 pobOI/2r6nZ4fkSa3XnE3q+lRag+Oz8naVRRyEZx1vCgCvwVFN9LqkQ5QJmmiRwy9gzMZ
 oeGGQ12wloZt0ApHns2nkOyRHnJ6OTsBlak4xGIak0SXEBSP/PDbI2jFDVR+0l9r5+6wy
 WtbPw3X9VJakmBtGlwKeg8e3UcMcEHCvSjtyUTay0hwM3NrgH/hG+DzJSBYBWdVKxhA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vrn1vr36; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Vrn1vr36
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 870C440061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 019AB602C3;
 Fri,  9 Oct 2026 07:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC281F000FF;
 Fri,  9 Oct 2026 07:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791530795;
 bh=pCPAotWxIo/c2d18a4Oj2sQZnTfhd2zfqcfvGuaAY7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vrn1vr36Zvr9CMgctASzDhMXuvNqZehTAQa4WcOIM9HqFZ9P4a5bTAPT334frJpW/
 X3X3fXuOhAC/vqTk7Kl8knQQZhH+4gG80jLmCDzvk2wVkijjahNGdfx2F4w7DVdpFM
 oOK+RR09iDtR/6yjLzHpYSSd3p0bYQRIgVEKL5M6woaT8poxuSO8XCELMkQ/EYXpMf
 JmDMD/RJEogpdSpGPag5vpbvRS83J7qjffxDUz0HJ/Bw4Qcfkcpap0OaFSAltFsBbM
 Wx+OAfEGGUpyVHroyS8WeDhM259tA58W1/AoQA9vgKoyjnC72h7chIlCowHAwJbA9G
 SMo+Y2plWMW8w==
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Lukasz Majewski <lukma@nabladev.com>
Subject: Re: [PATCH v3] clk: spacemit: program the mux when setting a mix
 clock's rate
Date: Fri,  9 Oct 2026 07:26:32 +0000
Message-ID: <179153078488.119761.1475302118877812369.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005T133627-0400.clkmux-v3.DaveWK225@protonmail.com>
References: <20261005T133627-0400.clkmux-v3.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 05 Oct 2026 17:40:25 +0000, Dave Klotz wrote:
> ccu_mix_set_rate() picks the best parent and divider but writes only
> the divider. U-Boot's CCF has no determine_rate step that would reparent
> the clock first, so the clock keeps running from whatever source the
> mux selects, at a rate the caller never asked for. Worse, when the
> hardware mux selects a source that this build's parent list does not
> contain (the K1 SPL lists only pll1_d6_409p6 for the SDH clocks), init
> registers the clock under parents[0] and the clock framework's idea of
> the parent no longer matches the hardware.
> 
> [...]

Applied, thanks!

[1/1] clk: spacemit: program the mux when setting a mix clock's rate
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/43798d61492bee6e9305a2cfe731daa81a701295

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
