Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFE0CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E85D605D7;
	Tue, 13 Oct 2026 15:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5ucJ7_k_eRW; Tue, 13 Oct 2026 15:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 653416078A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903968;
	b=I2Bx2rwFtMekI2e16RXaTmdBU5v18pcRnZdYg+e6ecjQP6fnq0PgChcTKtH8anM/8CNI
	 aH9A2h8wbMELWT9Vg0kbCCK8Dgtq5rGjAUg3QpG5SJqeYrZhzt42/31dfr6v88SkaeCm5
	 R7jDSuYuURsyvsZp/M3KmB98hOeZsQ1K7zWkoHJZFFOu7SwBU6VETJlKhWGYvfzB301gB
	 K5z4ax6/S9JY2gt7ZwyaHRPVn3ve1R1Aadk8qLzRsMYwcyXOl4Oi5OLd3lIaU87YEufB5
	 +Db7pB20ttJURVoi2e2m/x5exvxZuAAc1XQCtjYNQziCIx0y9KWVFmxSVJ8LsogCGhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8/pDpmArgVXfEw4SyxHl/pkHHzBQ1pJjRuSV+cH0Ivg=;
	b=QTs7DhHqUUVjwHFTv2Sy6n+nAZrFhjj9c6XS9i9+/Er0G4+dkbKJfp+mxVMMN8R9QYtK
	 AOwuDmayn8v8blELQVIUZpq+RWKfZVVBNhnyaW0EFdNornwdPl69mAgQjfil1vEu03X4g
	 yHs4qEoBLMdRsAgHxN/8U/qoTJawMXlFtv7atZ4//5sZHCiaomyQy1iKIK3PbcY4N1AJ7
	 4VoX6Wh8ruCvD3oYyUhiNe/2sF2AFaUoKwTmg9QyCmrHdZc69FAlOiJrhfiadNlBUzVgQ
	 mXsrRr2xPgJukYj2VZFybQYOOkoxn1iOZ8JGytiQaDM8o05almtKKCDcPmIq7vB2MbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903968;
	bh=8/pDpmArgVXfEw4SyxHl/pkHHzBQ1pJjRuSV+cH0Ivg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UB+ZWHMTBmElVVXLbkUt4Za35zcfzA4uzM5wA714feoN7JX/tWEqS3BtSxgz+y+k4
	 Qv31B7LjS4f2+Kw54j0RCd7+HnqiExQq5vPW2irGGMnP908ANt/MmuANSdEYE0xMnD
	 bnb3QnvcE5vpiKXkiyvqYdtG5BwIomjBjLEdE6VkyxdLQR27dE4i9ODM7Ix6WpgNWd
	 I22wX/TyqkGfnKrC2nrYTlZJ86DKardrDA09HW9exSowukmR0x/7OntXd88srOS585
	 5mE/kStIJx2kNdRthHpDF4H/Cd9V3ZCstETT+7KmucRC6VmomDG59C3JenN30B7BxK
	 DhVtSoonPqfTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 653416078A;
	Tue, 13 Oct 2026 15:06:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C50AC129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B65974055A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_aVzM9AlbKo for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1F6140554
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791903966;
 b=KY6AlTCg3mJMWitXCXPp03Ur2p9tINmORlRHrOWS/nu0+M3JzTqnrpX0kAiUkIH3hsC9
 XnaoV/g9sQAKNWUNQG3SE72UXqNMrl3nydmJkSZdLluZUHxs3eOxiQnMJKheeXDSz/rYm
 Jipq75bCUd46mmYfWyQo325rRLOvyFMIQ0J4MnD9qIQ19GAnLF/UaLLP9fF7ZBPGopJWL
 fHp6Wafb/t3V43SsyuGca6vwHHpWsDD17pmrv/frCXYB1cD5cN/NLuvvKRsLVM621kM3a
 p0yp+8HwxYBJfYlIbgLnv9wchTKTvHtEtBZIujqYjgqvx166bRmtUWSYvbym8oQpmAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903966;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=8/pDpmArgVXfEw4SyxHl/pkHHzBQ1pJjRuSV+cH0Ivg=;
 b=hlkcGKTfKMt6fRALO09h9vt0tfPQ28VhueDejnCMMNE4QYf8AgsNEm2SKkClG3zDfCJV
 px1UPKfJq8T4gi5toR6pQyawho6jbkYqsxj9bWAqDMx6QjOvO7jeFiQ/Xx34DtEMc0Kr3
 wO+tlpgpI8ubfr6J23FKujChDfBs3mOtI04WcjguAihjms68kFej/+AUxZWR3GupYvO9X
 vHN4QivcLpdYkbZGviQBpaKNd+CmsXwmkDQRDRvMUPdAPHbJjePmlXvoJ0iVkmcAYilmL
 gVeqTRIGMT241SqWyRgSTSA+qK6oyZc+BzVHlAGI/7KxCj2zWMkCT5eGNqv8PV+UYPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ezh6Qojc; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ezh6Qojc
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1F6140554
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:06:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5293960A5F;
 Tue, 13 Oct 2026 15:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F111F00893;
 Tue, 13 Oct 2026 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903964;
 bh=8/pDpmArgVXfEw4SyxHl/pkHHzBQ1pJjRuSV+cH0Ivg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Ezh6QojcXU+d8DSwU/L78kpW6PXzMY7tAZg9+Cb5Alu5hzr5tmnnHiXg8AuRjWU9A
 UsChR+OpUGRCjug0Y2U8V+r1cyShL8YjQdpXmSM5Ib1mvBRNIZ41tbUTXLoK3U2SJ3
 7aUF3rmF/qlZgvuDHSAFiOPWEQBJRnHy0tzTwqbscZFD+NPZc15g5CHEnPuvFbPfaF
 et8ZTeODrwdpWcmLbBUUv4l23N2VuLmdLfO19hmdrxx5C27I237mETSCQfhXcJsY/2
 S5WvlAUjH2v+wWvqjaxlbcdthWAPHklSv37qWI4V1Dkw1uzGq8WVBGMDK/LMBJHJHz
 hDrbe82YJxKrg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Petr Hodina <petr.hodina@protonmail.com>
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>
In-Reply-To: <20261002-b4-fastboot-dot-width-v1-1-93bb3cb13179@protonmail.com>
References: <20261002-b4-fastboot-dot-width-v1-1-93bb3cb13179@protonmail.com>
Subject: Re: [PATCH] fastboot: scale download progress dots to video
 console width
Message-Id: <179190396169.325627.14553755944264948015.b4-ty@kernel.org>
Date: Tue, 13 Oct 2026 17:06:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Fri, 02 Oct 2026 22:52:57 +0200, Petr Hodina wrote:
> The download progress indicator wraps to a new line every 74 dots.
> On boards with a video console the row is usually a different width,
> so query the active video console's column count and use that instead,
> falling back to the old default when no video console is probed.
> 
> 

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] fastboot: scale download progress dots to video console width
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/21604de81a0ca9f8427214384ef0575e9ce1a6ec

--
Mattijs
