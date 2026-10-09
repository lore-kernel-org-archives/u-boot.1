Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A343ACA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68ECD81426;
	Fri,  9 Oct 2026 07:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_ebwUWbRhBk; Fri,  9 Oct 2026 07:25:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96F798138C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530719;
	b=TFgzlQj58n+Z0dAHHmTcBrtwI6agQrgJvK51sgTa43BUML3AlJRUBsbxq2uum8m4TAZn
	 28eTy8mINQUPHk+509m8+z13FvylDJut+URYhZV8u2EBJGrFMt7paWYydwPdT8Y6VJ0Ha
	 rhe8CrGWxEAuv9+ANx+1ggeLUmocN4dPXCGtAUs5Qm45u+DRIBSYZELVxgNVF+EMpHk7t
	 5Dty5JyK1XM7MivHVwlcU5GjYCqzm+18F48erNXPiJhSk2LNFdvQ7eOSM8TLF0yE+cCqP
	 vfQEfI/n6TW+PeDGc1o2mlKY2n1ipJqqhZ7RwUpWxwB6G5GuV49s/QpYshTmbrIwncw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r1+qn8E+3KNQXcQ+o4JZfZSmxuZon28/8gPO8+9275I=;
	b=mDsAiqpAeeEUv/4gg9oZd4T5J7SP2rvlngdXCTm3CxNNT1gvXBaRwTJJRN8eyYdrE1H2
	 iIb0VDyfG5+aKLszNJzo431RSzkQ7hHHo4QG7Qu7NihhCkXObQ7tYAh+eeTmmbscLth24
	 TQTtrsAkNyTMN1XDcKi0wcUe65Fy92oPxC+4oBaGacqC4n7vdjanwItwpnYeyllPT6ejZ
	 B7+a4p6KOew9rVvNctpP8yrsWtXt2vZ3Y7hSJIDBb8iZOF3Gsp3cB+coQHzdaonNAR2DF
	 Zyu5g8Oui6soYNcSEbwYLXO45NkMrqCstkdJakwT/ZGmIhNvQPJEjlaUTo/jWTc4Zmw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530719;
	bh=r1+qn8E+3KNQXcQ+o4JZfZSmxuZon28/8gPO8+9275I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fZfEQ3SwSdSggehidj4VMdtlD8y/m2ae0vi5AHxpMSmFYSTO0SMMw2LTyfdKAZVE1
	 USOm/0ICyo8d1MQYX5a6gLKSXOawMQtuz0J9KB4tQGcd7CTtgIYNNrBv9sPfz1oVw4
	 1rHD5vbJaHx1Xv8EzW/1irMXQwEoirslNxXL1+5EyhCET1tEk/FpS7kSV4L3PkZVgL
	 LllGLntWwrIZBTq+AdlioeqLXpZmtR7zA8OUPig7NlrkZMdwv7gT0RMw/lwzyQhvJ1
	 sWuNvFshJmGbBAO0OzzGA+PVQ2DxdlBpvUOgKOZpu2mzmJjzx91m4mPOxFOkkY9FWl
	 JlZXpWpS8OG5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96F798138C;
	Fri,  9 Oct 2026 07:25:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAABB2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C146E40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:25:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGmvUNsvPNIZ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2C2840061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791530717;
 b=Dj+3AjRFy2fdfGLptkca82zQ+lFlT8zaNJprLsc48nbZJ222/7DIXB7akxR0bjJ+xX/I
 o6ustNkhj+8NygnwY+5kx2qvWXiQw7xotrrl7ciZJCmn2YQjT+HuqSpBhpacw4ZgqM8fA
 6mMt5/qOtvp/Mjcm1ErqzXbwwn7ZV/488JT6bbr6/J5660OzkN55h7SAmiVtTy2PE0aWi
 z/T7ccYMLnLCAg4FrUtACZqW9ztFrP4KVK+mWHSUwaCIEoSCPLBpInoZ5HZns97WM467F
 1kuP2Dz6N5vwsy64AXcVwS0PCbljj7wJs7tic5jkbtY33vCLf9sISwmch1N9EUZzT4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530717;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=r1+qn8E+3KNQXcQ+o4JZfZSmxuZon28/8gPO8+9275I=;
 b=j+Peo72EbtFdqBABCBFuHEUv7peY0NzX8QPDxQv0ENPOhOhFsCjXxxpxrVLl/zC6Y+49
 50M2aM/8/2wvatOytyHIwNxudypWu5X6C+Y6ERMqHXfi4kH8lr/ZW51Nt6ftchmFtk3P/
 2SsRHYrkghAtTAI3NvMb8hZAixTScWXyHhfjMXL3RaJ4b3AoZSUPSvXoUjCOw0IAKjoUL
 asuORaCUyiAQM3bkfJkv1O0BH986FcDQSFK1SXqBe3i3gNfLt+dEtLL4BQG0vHN81S5jy
 HzVjfomkVBg26UfmvRqM+izX9Q3gtwozKet3AHy+E3Cii+J4m+EKzRPQFPa4Lsdf4YQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Hml5Zh79; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Hml5Zh79
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2C2840061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:25:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13EB3602CA;
 Fri,  9 Oct 2026 07:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC4F1F00893;
 Fri,  9 Oct 2026 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791530713;
 bh=r1+qn8E+3KNQXcQ+o4JZfZSmxuZon28/8gPO8+9275I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Hml5Zh79lILX/UNv71xZmBK50zHh3huMYPMbArcdtCcxUlbO219mc6z7JSxpGFHA0
 ZXMMolU5opf98Jaj0K8qgeRmUjF2yAl9MXc2UfodPWGrGUPFLcJsWGcYAjwiFpMHpi
 hgYd1HlLUaVgEAxIHBifvoDGIRSpsY18vQX20FGI8bHbcSZWgkdMk+ZHzbT6h6pICI
 cBEM5xaP46EC1tDahzxiHCjUCVaA+ZLzBqKfPYxNBfDY7WmkBpMHuSZFjpcDYXnnV4
 /elDd8v5HuBKlFZd7D4IEDZ4iF7mHECaUSanlDfHxJ8SkLEPNyaU1GfOAJ5tm8uWPn
 BbU/s+TKjPCJg==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH] gpio: spacemit: add support for K3 SoC
Date: Fri,  9 Oct 2026 07:25:09 +0000
Message-ID: <179153070324.119090.10418028922650705621.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org>
References: <20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org>
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


On Sat, 22 Aug 2026 11:30:28 +0000, Yixun Lan wrote:
> Based on upstream Linux:
>   da64eb51595b ("gpio: spacemit: Add GPIO support for K3 SoC")
> 
> SpacemiT K3 SoC uses different GPIO register and bank layout compared
> to old K1 generation. Refactor the driver by moving hard-coded register
> offsets into per-SoC tables and locating them via driver data.
> 
> [...]

Applied, thanks!

[1/1] gpio: spacemit: add support for K3 SoC
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/60106e0385b47e693ebde5a43cda4941d7ca1bfc

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
