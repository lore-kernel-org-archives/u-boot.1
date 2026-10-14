Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA965C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75A3740829;
	Wed, 14 Oct 2026 20:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIuqoYp4Zb5A; Wed, 14 Oct 2026 20:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E0C54080F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008006;
	b=q/OA16KGF1ECOT7y67lF+bjok4foTVNFRLFwyeYLmvwWxZu0l6wbTmC2OO867YyC/DKP
	 +KfznjogZBoTqTL/OMoYv+HqeuJEewJJEoJWfXurciTIy15ZYmQztgSzEItLYOHQYuVfp
	 ZxqQPx70Czo2YBIpX7uGc31voFJnQUhhPfQdLAHwsDP3P9fXfE8Si8BO6QDoKC+5KZ7kT
	 JnoFhXJ2G0dFONFZhFV1SnHF1KhdCl8cz0P26/AqRHd608gP/5t/plY0tDLbAglXsOt0K
	 iGHEG6f8v/jeAfKtXv1qMnTMcOrcPLXBu0Y29DtVe7jWvo2eIJtAOn+/diK0HUBojBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Sbw+KHgjOjR7U0GQsNm0LiIt2p/sMK9E1AaVl+BouTk=;
	b=ssu2ZE6VSY9R1GJRxTWhuMmM5+/74VqDxERWXwfRSWSO20UrPVXCIxiYsf2EnVanEbm/
	 oAzl6WmFnegWlRKomPwbNVAK1DvisKwjRj9NBi8hysTgzEs8XIzAKOV+6iQU2p2KIE/4T
	 enexd8rfwjx5TG5mxwqm2QWVmO/kkQnvirTcOBdJfjRahsrjqXylJgE32GV0B20ve54NW
	 bzvQV7UEVXhTw/37jJM5rnGaWTfFPQtL6PWVd810yabkXsg327CMWxIN0+BG9TGnOwRAR
	 GOwasXp4vedz3zGCnD7gEXLzRt/0TF1gwNdTrcx9bPrKI41E1F7tDXkEMD9hvVi5GrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=equDJSZH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008006;
	bh=Sbw+KHgjOjR7U0GQsNm0LiIt2p/sMK9E1AaVl+BouTk=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQylgnYyy6ufKG1aNaV1Vrjnx/hd56PDVelC/w+oR/Sc675z9BkfiZJU/3cLZ9HhM
	 gNs81grXxofqkURa8fU1vXJ985G/ohsQkPZZQfJenR68Sj7KuHjempSy802NZ4M1wj
	 LXy4Px4qUbw1wq31xIX2wJUsHgj27bGv93isxRUkEkGnx1gumQO5LRWZwx6OnyxYkn
	 fnWtzyAb9DMYjYFsMeeGJGuDKfLhruDF6fV4u6UB351Pb9n/jroYJetbjW1GJuc7rZ
	 xTMpfPq3dievvCbFWAD1qxXvwOiXteySM5xvaqxYz7YRbdFs+WuDNoLupMMOwOE+CY
	 7s5adsf12YccQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E0C54080F;
	Wed, 14 Oct 2026 20:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9270E4DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83B764080F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B2EwLiFFHXVw for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:00:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4908A4075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792008004;
 b=J7LgBQaDO6IXMBc7PAb2MEb4zkpnks3tAnOcO20nvNUEvB02pA/uRd0dBiZ5AdTpvbdj
 DUkERu7qnvPoDBWM1TFkIQM7iU1ZNcKTu2ue7fEV0JR0jLqs5z51kWmUXm15l9xpKuXw9
 tguECvaNMHIn3m1nV6Lf/YCm0nWmSWuoIqWbRFy/oP9x6yNAYjV6LmXG10zvtylyfPbH4
 YxWfwkKOZ989zt50gmcA6uvK7rU6XNQn8dhSc2VxoCoHLCikG0w4uS3R33Xy3RmUx1jbo
 R922sWwlRGCMoeklsK+VTGkz7/KGDmhnXMl8dbsYXXUEFIqdO3Y55FPtCn6GaylUwrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792008004;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Sbw+KHgjOjR7U0GQsNm0LiIt2p/sMK9E1AaVl+BouTk=;
 b=e61Q56P5n+ELcdd4TrQV8LIyenD3Mwf6s5LQrV0CxXrYmrMLkJhht8oaKlBBE+Ey96rd
 Sx/gYrWDmCb7S+ujXnWiZv0WKqXAvQsEzlfM/mT6GnSepcmuseGuNp6+gaoLTh7qvIaJi
 AT5Z0O9AK/2bhBR21onDLxhAq6Y2ULFQI3SR9jP8SM3GFlMNKouNzh3qepGcp8rBZDX3B
 4CrZV1zoGQQ1e2mSBI/Wd7yK7YQh9YezDUtRTur6QKN+RwbFDcBsM8rAM1dsQGBpa+0NB
 vwvwlRaZxJjmogdDEi9JV433+uzPvHP3ioJ3GFaEEV49OiKqqLYKA8cmGuq636fXZdg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=equDJSZH; 
 arc=none smtp.remote-ip=79.135.106.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.120;
 helo=mail-106120.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=equDJSZH
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4908A4075F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792008000; x=1792267200;
 bh=Sbw+KHgjOjR7U0GQsNm0LiIt2p/sMK9E1AaVl+BouTk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=equDJSZH0x25wvd5LDz9IIvCQihOuRVBTkvH3liGDZwCV4rMhIObKf6vaZM1OX3w4
 9bYkYg5XO1xuq4jHywePJl6ouOChjQzPnvz/DRW9u0onKcJCmOJLihtF/KI/7Dx+ja
 /4exGKY9iRHuCPAejfFtrN6O6eHSOj/F+TcnITCPYkisTZXRM/SPnztAc66n11u7VH
 sQwqaxQ0045t/yEobxBjkzpUcUuHSirGMXoOqMs8A6vQHAZ86xQUK95ZbsTgijhqYt
 aqtD1oBAmOhQmqcppb3UPelHFxt5Cat5BmMfSIcWd25EkAmwytBK7sHQ8js5zvJU4z
 3cveHRGok19OQ==
Date: Wed, 14 Oct 2026 19:59:55 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v3 0/3] usb: add K1 USB2 PHY and generic DWC3 support
Message-ID: <cover.1792007916.git.DaveWK225@protonmail.com>
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 655894d45be48d88085fa73f2782f7dac11869b0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This series adds USB host support for the SpacemiT K1: a driver for
the K1's USB 2.0 (UTMI) PHY, which the K3 shares, a flat-node entry
for the K1's DWC3 controller in dwc3-generic, which already handles
clocks, resets, PHYs, VBUS and the host child for other flat-node SoCs,
and the defconfig options to use them.

The v2 USB 3 tests also used my combo PHY series [1]. This series
doesn't depend on it, and USB 3 on main without it is untested.

Yixun asked what "polled first and never write" meant in v2 1/2. It
described an earlier FreeBSD driver, not this patch. That driver waited
for PLL_RDY without ever writing PHY_PLL_DIV_CFG, so on the OrangePi
R2S the PLL never locked and the xHCI reset never completed. This
driver writes the divider first, as Linux does, so v3 keeps only that
reason in the commit message.

On VBUS (v2 2/2): the dwc3-generic host driver already gets
vbus-supply and enables it before registering the xHCI controller,
which is what Linux commit 764c2e6e60bf adds for the K1. The R2S
device tree describes VBUS as a GPIO-switched fixed regulator, so the
board needs CONFIG_DM_REGULATOR_FIXED, which 3/3 enables, but no code.
Details are in my reply to v2 2/2.

Changes in v3:
- 1/3: drop the read-back check of the clock enable bits, drop the HS
  DAC +15 % setting and match "spacemit,k3-usb2-phy".
- 2/3: add Marek's Reviewed-by; also match "spacemit,k3-dwc3", which
  shares the K1's flat-node layout (not tested on K3).
- 3/3: new; enable USB host and DM_REGULATOR_FIXED in
  spacemit_k1_defconfig.
- Rebase onto main.

Testing: v3 has only been build-tested. A RISC-V build of main with
the updated spacemit_k1_defconfig compiles the changed driver files
with W=3D1 and no warnings, and builds SPL and U-Boot proper (the FIT
image needs OpenSBI's fw_dynamic.bin, as before). checkpatch reports
no issues.

v3 has not been run on hardware. The v2 R2S and RV2 USB results were
taken with the HS DAC setting that v3 drops, so they do not cover v3.

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633775.h=
tml

Dave Klotz (3):
  phy: spacemit: add K1 USB 2.0 PHY driver
  usb: dwc3: generic: add SpacemiT K1 and K3 support
  configs: spacemit_k1: enable USB host

 MAINTAINERS                        |   1 +
 configs/spacemit_k1_defconfig      |   8 ++
 drivers/phy/spacemit/Kconfig       |  10 ++
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-usb2.c | 153 +++++++++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c    |   2 +
 6 files changed, 175 insertions(+)
 create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c


base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad

