Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD0CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75AC76088B;
	Fri,  9 Oct 2026 07:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6DVYvB-K7Wh; Fri,  9 Oct 2026 07:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66DDA6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530778;
	b=H8bJ2MkLrQHsIvujU8b984m6AV9+Ob23VA0tquIebLp98+qiJe18SceRDii9HSvsYtBa
	 t/T1IIS2sMny6arVJH1vjiRBehF3TRCXmwtMuYR8FVKY9/OxGczi/H6hJcl5aC+r+oOVm
	 EQtlbz0HCKec7FPcYHEB0t4t2IvdQHl0Ii3SSQS+Emsz2QfQtSWJOf5MQNRgYNExI+re8
	 rZqAJneqXqYV4ldE2w1z+m4Haoqq2EteW5vc/CLkW9qYayTBsc15U6j/ouaKyeE44KpKj
	 c4ctmw7+iJeBTVimUlez5QmYyTTXYcgc9WAtsS/3MVfxzJ/Rr1fflGEB1qhIzrrFITg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R9j20iS9o6/AyqFTX7nD8h4FKx4tYreSSVLg54LPoTs=;
	b=KZ3YQt06EfDWIOaAalRud1wXOjZM2XHgtTYU4iOJQpzNhbNEG+SM607+Y1m0M0LEQWhG
	 2NxonxOVSE4IhvcuMLivHN1H3+nptmWDFtfe4YwjR2eEdgiMmHO3OoxHncguZ0dZ4y8bf
	 sK67ZIm5A7I+yPE1xw4VrweIW5z5nhMbRg/lmcAulN7P79Cpxic2NfXW9zd73A40Vb1FE
	 M4IsOtygOOR8MnelUrZdmB0RBR2oODqtJnYj7AHWnc+mlFvlDCjvdMIszqRKgg8+toGs8
	 L/YVNzqtN1SL5EtvVlg6LCjGEYiE/6EWusyoZW0A0QprDdKKEwckH9Md71sYjN6Sq6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC67uTlH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530778;
	bh=R9j20iS9o6/AyqFTX7nD8h4FKx4tYreSSVLg54LPoTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JmqXngW4ieAo6IMDbfmc+HKz1WhFcDxtY0Xf8tiO733n08ybwRCAzFxVNjq3JCAZB
	 IkeE8NLYl2HQiQgZcaZKyRICBn8YTeQ8PPP4MXys3/99XnWhim1ypfP/9PquLaaFqu
	 g7y4d8kTKkeF8MJn5ar/AGRTtwfev6AmXmRc8I3NS0B7HmscJnQfU9xrIvkYeHGC4J
	 SMOL8XVcLWeRwGtzZn64QjSTBU/2VDi/W1kmc4hVAMB8hA1x2Tk7bQb2I7HrUYg/WW
	 Txhxxuei+sWd7ljV3LiRhX4tNJEmn7IwHSPUpGdwANFtnvzu3c/26oRBhrr/iK61O1
	 lwaay0WKX7Qhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66DDA6084A;
	Fri,  9 Oct 2026 07:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 964A31C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BEBB6084A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOCa6YNssoN8 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A562A606A0
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791530776;
 b=mwxe8puoMwIf7MVCfWePPtUwh0fjd1dX3aPtEusBOiMyef19ju0T/iYzSX5yv9aC7ijj
 fZHOPsrwuFLGmJ/3AHydAyOCgxm1Xt0VHVk749Bzd1FYOnx14zSGnQm9HT335pKe9adKI
 /VNJ0b0REl/RG+5Lvwt7jhVIjBW4j5e9KskGIHROqAbz5awgbRqIWZSKSLOTeUZFgd3yl
 rbTvZ6VmmvbxrpWDHThe7MAI+R2aA5Fydj2uFj4oe+fbTR/a5hZ6/kXgGHSYVTaXUg8H5
 xdZFUKTmb9k+8laNICGwmVE/XrWrwxscBGAgM87TzXA/jYUzrq93uU7Pq/cvb5aFWNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530776;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=R9j20iS9o6/AyqFTX7nD8h4FKx4tYreSSVLg54LPoTs=;
 b=H3gwm/cTDSdornV6L1hzqIUEYfA3p+DXqHT5IND+z9qH9a2wj/SYx3ssMr0W8U7nKluZ
 /Rb0mt3ZkXQgPdnVUAghwy1ZSoVLtyH2F5RARShjGOmdEwpAz9cXhHosoNND/M2zkn7iw
 JKgzVk31YAFf3lY6SNvxJOFmBVTzsTjdsu9GTf4twJmVCtZu08dI4fpN8Na/GLcjUBtjn
 VL+hW6VZal22xH4hCLGih542cxdUxKP0CopAHSvFIWZrroEJCIju5Ei8ov+Mcs84IFxtt
 3+q50TjUC7M1idugGRuzGWIJfG3Pi0PBN5d25QecdD2Fk6UQhTZSogzjXIBUDUFJsLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QC67uTlH; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QC67uTlH
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A562A606A0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:26:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE254602C3;
 Fri,  9 Oct 2026 07:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688151F00893;
 Fri,  9 Oct 2026 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791530774;
 bh=R9j20iS9o6/AyqFTX7nD8h4FKx4tYreSSVLg54LPoTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QC67uTlHtEfKqXkj6H+r3cMJCS/dAhUBhd2q5ahQJtUUJ0KwtaaKLT16Wmpm8vBOG
 9ymJ5NxkDG1g9sNH6E7WHHbiIlyLTLPV4tTZ2tK9tEaSbpD2AfEriy5+zP8odNZaCK
 0Oa7uyr54kqmWV70yGH9wmkbYQgYk+66cOvZoQtOUpbv1Dszn5/nBwWyGYeQAZwTgW
 ZQyHtXnFJnT36OqbV7Eki9Hav5/zUCZR4+iCw6Ictx3EZ6PpSrLYGnHO1hyw5O1O2O
 enoT94lC/FoHHSh33iZgMFSXIpi8i5SR1+BA8/mEWagZEP0q4geaXTAgREIrjciNOx
 3GXguIaxcq3qA==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>,
 Lukasz Majewski <lukma@nabladev.com>
Subject: Re: [PATCH v2 0/8] spacemit: k3: add clock and reset support
Date: Fri,  9 Oct 2026 07:26:08 +0000
Message-ID: <179153072641.119292.15754263087303903316.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
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


On Wed, 23 Sep 2026 09:34:23 +0000, Yixun Lan wrote:
> This series try to add clock and reset driver support for SpacemiT K3 SoC,
> the patches are largely based on upstream linux framework.
> 
> The reset BITs definition lives in the same register with clock
> controller which make them tight coupled, so I'm also putting reset
> patches in this series.
> 
> [...]

Applied, thanks!

[1/8] clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/d1a7fb596ec6717e26e1760c5a3e1adc1294e6fe
[2/8] clk: spacemit: ccu_mix: add inverted enable gate clock
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/d2cc0aa2ba32d231a73a10cce7ba332bb565d21d
[3/8] clk: spacemit: ccu_pll: add plla type clock
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/57ecf2e5448fb0e6ecc9f3266463f1cc82ee74b9
[4/8] clk: spacemit: k3: extract common header
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/c80731fa324700db2c1a5b7725bfbe7ed93d50ef
[5/8] clk: spacemit: k3: add the clock tree
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/efe62df16050cd68130e07f209379c38657819d3
[6/8] clk: spacemit: k3: add CPU PLL rate tables
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/20c4c8b4099592ce172f6cb78b31cb8d9d68f193
[7/8] reset: spacemit: Extract common K1 reset code
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/c2dcfbe319b0e5e77cf4f350531f04c9fa9a7a46
[8/8] reset: spacemit: Add SpacemiT K3 reset driver
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/89269413d4f53b77a86946a78a291aab03f7aebd

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
