Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A0CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4376581396;
	Fri,  2 Oct 2026 21:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3K4PJiN9Kgv; Fri,  2 Oct 2026 21:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BE7F81372
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976664;
	b=W+FtZkg0YDsiJWto4HN0pzf9jwLEOZLQf6w79pm6SZCMMTzBK1i0enjcYw64eXY9EYdf
	 ++y0cnlGY7Sb2nYXl7dhV1tqI2Bi2FFjWSYSt93KgxdblEJhuF4tcOvzA8ffI8hwXXr92
	 aHsnIA0Twi/+EzjBBkwLrvavHSvOOfUgvKPaBFX3YZ/UhPi0MBBm9lXhltzZ24ODR+HEo
	 OCtFzvsSqKTCUXiQfj9sAMKMZMA6LQKCGibdajhcRd10Y8BM12Akgwm/t54j7qaJzhzBD
	 nYE2ScBoJ5T6fDZZ3z3Lyoy5o7zEuGmJmaiN9lX5IIA9SyXp9Dpv7ic80FIeLxp/CDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9JG0o3DLDkD4k+IP442D0wznfNNKuEF0SxBcPHed86w=;
	b=PxRiNXRvBOIVup0bBzQFEEZ+Stt0iVgkGnedBL7LGc79PqmpzFQBj7Uofwy/24UMxx8h
	 B9WungrzuYDgcQX/HRygfUqBs42Q91yVbJGjVW1H5uR6fBAJH3evUlMubbANqsaNvkcXI
	 Nz9gNeCCIo2/hAUngdGyFCtTwz+ALAiQWOd1kJSRMKS/Gke2WoiWkn38YUaRTn9lJ98nN
	 6P/28vroUhIoOOG69VS0U+b6QwjJuxB9BdSXoorcG6JCh2umXRCJyS8rL3U9S5rb1aj1U
	 N21SsODwM5+mM7eSksZi6tLkcT7NLkbj2lNw8RyXqCaouYZ5VpZHtjtzzNChq0W20ww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=fB4TITFZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976664;
	bh=9JG0o3DLDkD4k+IP442D0wznfNNKuEF0SxBcPHed86w=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XnM/V7rvetLy+CTMCn3pbuUw4FJp3OfrDAlRZO9+Q5wjo85KIF+bIVcFHDJSaDC0X
	 mb7ebSjOR7sGbIf1FHbLakMQKwDmQ3TdT2QwvwjGWvNzD6cpRu4TJ2DXPBwmlY1ugB
	 dT9gdSmPpFdz6OwmatjAzU6kw9lwREPE0YFUb3f/51wUyJAUqHMxN3ve1B77KC0iU8
	 BEk3stkh0PmZnUVRgty/aHN2xAZgyXV/XcjQXYcRXkw8ebk/UPWDKzGzCHUgT2TQCk
	 Sw603A0GiP/t30+qO3rEXvY18Ygi/r/cu/L/faroMFcgXsJNTdcift03ta8PU5B4Tu
	 rxdJEzojjQQsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BE7F81372;
	Fri,  2 Oct 2026 21:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC6ED179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE36E81365
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJWI1XGRY9Eu for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9F47281323
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976600;
 b=gcnBJGBKfdPZc9jMfKt1woNcWt7YWn9IFs33ojRWDURiMwIvxNFjctbcIZ6ulntADGSz
 9QBl3fn0Xx+QJvi4E9i0ni2EmCIFY19Yy8wPHsuHeeAZogiPfXCUzhVH/ppMAIYB5exJ8
 IKSqB8BQqvTHBjKcz49BaJbyEdTHtFKAYMtaKIHF2PSizLxL6hKDEJzPcZHCyLII05fRg
 1pnMWseSvxA7NR/xDQXwNhSU/ZlGnA0DnoGl3QR6azdV1a7ej0gmUaMcuoJgpis47ZqRF
 RvWFQuc7heg79TdJNJMVEQQDpevPtNb3mg9O+XObd5WgCiiteei/gcRHTsCbp0t/lBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976600;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=9JG0o3DLDkD4k+IP442D0wznfNNKuEF0SxBcPHed86w=;
 b=oKQC5zCEiAxzw2GFpKvEKqkxjeohkGf8tp9OzFml+MR7e5O+wuD2hY1X02zIDRZ+6E/h
 qQIdlpEov2KpaQghUPFaHZAKHJDxOHJmwQY98kD7Qa2rMj0EBRE48GWMSmk/AAlI6Fxj9
 ZwnW28kNlDIgO3xPw5R0Or35+AzK16CmtXohZ0PkWOSkx1jcX7FV6Q2Ro7sZ9fzmwW35A
 TxoOSQlDb7Zv/iD+fM+0F4eoWYz376e0SoywYQDX8AwRLYoqZ50G02gsFTNAcaVj96vje
 dJjtvRvEtkOE4ip9y4dJa/Ewbmobej3LNn6277V++IUNFISxB6G6CByjTclkYg6ZAvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=fB4TITFZ; 
 arc=none smtp.remote-ip=109.224.244.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.102;
 helo=mail-244102.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=fB4TITFZ
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F47281323
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976589; x=1791235789;
 bh=9JG0o3DLDkD4k+IP442D0wznfNNKuEF0SxBcPHed86w=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fB4TITFZCWdH0/EgBG3pGuaibl0IEzubX3a0Orjbn0bhZIZKnl7Jc+PypeFOzhDHy
 U841yZqbXm8PuX2dXtchPruXz0PeIgWpYao8sBRwEhlRgPxcJ5ohpzBeLigvkAk3id
 T3oOMW5Flrg7lwqr+7h8tZdx74OmnAZFrAWj08WSzHW+qotPEb/cA5uNf99sW08C12
 p+jP0VE59BBXFMA0H7RKmsR1vRayqHddlnxZAyNiqUzfUtxcTo8Q4QxxPohiNqWZf7
 PTAT9XnpIEEiJSNlvxUI5WTMnjt2fvMIlJ9hpzjWPkxF0uPtciNSskWCAb92P4E4JA
 5bfL2GKFpbnew==
Date: Fri, 02 Oct 2026 21:29:45 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 0/7] phy: spacemit: k1: fix the PCIe and combo PHY driver
Message-ID: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 714564032662356bb443047cd40f97d8766e5770
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:30:59 +0000
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

Fixes for the K1 PCIe/combo PHY driver from "phy: spacemit: add K1
PCIe/USB3 combo PHY driver", bringing it in line with the Linux driver:

- enable refclk and take the PHY out of reset at probe, using the clock
  and reset the binding names, instead of fetching them unused;
- calibrate the termination values the way Linux does, without starting
  port A's PLL in PCIe mode, and put port A back as it was afterwards;
- clear the termination fields before writing them, set EN_RTERM, set
  CLKSEL on every lane, and update the PLL control registers with
  read-modify-write instead of overwriting them;
- add a power_on op that brings the combo PHY up in USB 3 mode (select,
  test control, timer adjust, SSC, PLL lock wait). Switching the select
  bit alone leaves the PLL unlocked and the xHCI reset never completes.

Tested on an OrangePi RV2: NVMe on PCIe port B (link up, EFI boot from
the drive), an empty port C reporting no link, and a USB 3 stick behind
the on-board hub enumerating at 5 Gb/s through the combo PHY with a
DWC3 glue driver I will post separately. Not tested: a device on
port C, or USB 3 on other K1 boards.

Dave Klotz (7):
  phy: spacemit: k1: enable refclk and deassert the PHY reset at probe
  phy: spacemit: k1: don't start the combo PHY PLL to calibrate
  phy: spacemit: k1: restore port A state after calibration
  phy: spacemit: k1: program the termination fields properly
  phy: spacemit: k1: set CLKSEL on every lane
  phy: spacemit: k1: don't overwrite whole PLL control registers
  phy: spacemit: k1: power on the combo PHY in USB 3 mode

 drivers/phy/spacemit/phy-k1-pcie.c | 270 +++++++++++++++++++++--------
 1 file changed, 196 insertions(+), 74 deletions(-)


base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
--=20
2.55.0


