Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CAECA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ACB760E05;
	Fri,  2 Oct 2026 22:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_SjNkUyQ80l; Fri,  2 Oct 2026 22:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 288FC60E30
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979021;
	b=HvQyQBVz5HzC3ChQtAACHy4HGB5m8Y432Kbu6/m3TXUlinFYqMosGxWu8CW8XDR0Hs3E
	 8xzBFSG6C5nQzbek4TPeZOlJ4rESYD8n2i3z2Y8OdiuJhePZmoTAPb+zlAU1SuLIiiosM
	 /rRb3iOnvNRb/UPaanoOy/KPWKV/t0z1AHMFGg2yQpxp/vs+F5tylPM1gdCvysvp8WZep
	 NOBkDTCfNFl4WMM8LZ0Zg3853LTBUu8dHfGTKSnukrllPqpwvLEjAA31JgR/9kYaSAYZb
	 NOBDA7H7yLki3FnXf0yxkp5twhhbvlJ7GhH+PfUKojLkP0CpE3HwP0K8QX3cIMde14Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s8MeuKBluOm3MuKs3qE84qtZUYn1v6RgFgBN6JWWs94=;
	b=idhiMx4BH+JuDt3GndJLFizWGWnpsMRB0yPnmSzgdu6P/A9UoFYCrFfXSILEA22Aw4KW
	 lwOZlbvLU/bI42E/gOpMuo5VNDj9OHAF8FoyPW6SNPcoqHxO6QTQQ3bqBP1xjLOkXy1ef
	 XeNDtoy7TXqxz1lvkjqTFS9gf2UVPzuDGvYSvVVmhF7xzLRKP6QhDfKBYLjxGVEXRzJ6D
	 T/t8iVcRRcfPGgpXbJ6qhCFCgxX7DEHUjkNdSbz0bnX1Wd6eGZCU2SNyPqQcVnyqcv832
	 DbgbvThmljJsIFg1dB/10/6ZZ0bt9/M1K8+fCs74kqSRTtto4/bFwNA/Jnrf5SxcCpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979021;
	bh=s8MeuKBluOm3MuKs3qE84qtZUYn1v6RgFgBN6JWWs94=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kYczYmzp2FYqYw1uBRkOTbxLFQuNSYDZG4PmjndFNnWJ2Yw6Lautx1K5p+MJ3kZli
	 FNgdrwFqsS8Gz+Ub0pyawWhQCOtwyzUhTN8P2ft2krKROabn9RHu/uIbGnL0kF4r1w
	 d8BES0TSHX9v9PB3Z+njr6yTHfPOd85BIi2N8Nd0eaS9uMLwpLiEpMmpeU9oR4b4t2
	 TNdtbca39cDAgb39ghKd9y1qmrYD4yDhRFHecp/APB0aSb6bm6nu1BrY6Gw6+wQzV9
	 EVukLDGoZ/fCFHlAqmn7FOJQrEpXLf7wP9wMeOXiVKuBdsvtT/sw7NcGlD7IuUsX0b
	 Ov/RDfL/j5NgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 288FC60E30;
	Fri,  2 Oct 2026 22:10:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F069C179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D687140585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfyznDFqYPy1 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 22:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3552D40061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790978852;
 b=eL19Au5Qq3ZlfmkswJxZbnP8nG9+R/VVoMlvFyy2NsbfiAic6dWsRhzbD/QW6SIx6+9a
 FCy4cJAf6fEMyf65DEcfxGKL0alGu+CMXpYJbJ14SryoZb8I9nqMxyNXE4uCtb34xLHl1
 dC+CsYgOrFqbKlnpcKCq87tXtIyRBbunKqVsKKGRkR/QRniwje3mi7+Rur2b333z67pBZ
 D8dAtEo64wm9Hr6JMBpnmjVNU47ehWo7eZbgI4eaHVeUirIB+IWTdrWD8G6sm2nZS4w5i
 ZFCqHdZzfWqudlHeML9bH68viQbICzs4b3PfC+2nAVxw0om/nFiKdMym+lmJmzY4KsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790978852;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=s8MeuKBluOm3MuKs3qE84qtZUYn1v6RgFgBN6JWWs94=;
 b=eHKlZXBb3fmTHa1h+bK+eXonyYfimeqbw4/6S5SYEmmyYftpGKxVdp9/Bjv6eJX1QMMe
 rMMXm8lmlHLsgwBzFGf46Ln8cCBjajoE8P1yYQ840qZie900/NuZjImyyKPXWv5RIfXop
 qTmw6jXSMXsqiCiL1wyxCeQSh5JVIrP4Oo5dm7wU7o+HFC6ddYLF8EmRuQy9PGB1RSDEx
 f9KKgkrdehggtpdkzYH5v9PFNm/eIVRXQgVFRSqyv0GwWFZMp1nmExgazqbLM2hPePLmQ
 9X396tYdH9h8ikP9Ok+cU7l1iDcdfy5e2DFilDLlYQAwoSl8ZDnaWfNt2EZjuHU+TvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=HQzB3JI5; 
 arc=none smtp.remote-ip=185.70.43.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.102;
 helo=mail-43102.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=HQzB3JI5
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3552D40061
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790978849; x=1791238049;
 bh=s8MeuKBluOm3MuKs3qE84qtZUYn1v6RgFgBN6JWWs94=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HQzB3JI5ywt4gvQPnEaDUzgwpiRwC6Tn+6osC5fhW0AqgmhtL6YnntFy36ERTmV4N
 nS13NYjAmflgvMdlmnT5FXBTlaTlW+GWA/mVGa7KCw/oYGpJANC2sYh+O9tIXvPRQd
 gIazvN7Ot2rZjsEax4PUdYEjO3W7nF7pyvcYvpgkYHBGjx0Bxd0eUIyfsHNyRp6PWv
 cJl2cE0CqrrHqIdtTkUPe10vMozo1i2Y6u0Zf2w69nJX485mN6k8ExDOsBr5OyJzPN
 GCZytNIRLYydfXFjjxApLe11IIDRQ2jnOcvHNq1Tb0N5O7MaA/spmluiEgKc6XjoHv
 4hNSJgp+oBQVA==
Date: Fri, 02 Oct 2026 22:07:23 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH RESEND 0/2] spacemit: k1: SPL robustness for boards
 without a PMIC or SPI NOR
Message-ID: <20261002220719.314821-1-DaveWK225@protonmail.com>
In-Reply-To: <cover.1790976767.git.DaveWK225@protonmail.com>
References: <cover.1790976767.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: c924fb95913e64e90700d121842bd042f2510608
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
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

Also tested on an OrangePi R2S (K1, 2 GiB, boots from eMMC), with the
same tree as the RV2 runs (upstream next plus these series and board
support that is not posted yet):

- the SPL logs "No PMIC (-19)" and "No SPI controller (-96)" and goes
  on to load U-Boot from the eMMC, which the boot-mode detection named
  correctly (BOOT_DEVICE_MMC1), so the fallback order was not needed;
- FreeBSD's reboot resets the board through OpenSBI and the board comes
  back up unattended.

