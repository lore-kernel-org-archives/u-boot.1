Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49540CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 19:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 634CD40681;
	Mon,  5 Oct 2026 19:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fn9mCMtXK09; Mon,  5 Oct 2026 19:11:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9240F4065D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791227513;
	b=Kz73AeazmETujiMMNzJ53MUWyVyLJpaAZjbUJrdLfiEytlaOHGVMKdq1n1zFgbmrw1MT
	 Cnqei1+/lXUhFw90O/87p+k296aK9AO2GZCIRzuTGc8M9MClHGU2qwpJi+kOwR7bINyq5
	 +F5PfgUJCpDX4AjcZQsDHSgXBVo4oxbRTVYSKIgTeentGuy1DQF0UDq2YXhVzSNFXWqOD
	 sAVVhXEkSprp85Ni5QmTLwJyWzSUQeBjhQt7DILZEHbf3dYRBq9Myy4m3Aang4/TPxNys
	 mKe20jwYO7MXznj6RsQgSQ6HNNzzcer3/lHkFz9ZyUYdoraGd+U7QoWI5Su7AQ29iFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791227513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bazphCU4FsrsLJ7Hr4ZLsCJ+aCxclFWA0FEhBRhFNI0=;
	b=fS4M78CB6shCONq+tCGohq5cVVnLwJhSfTq1a1XLlvVX+s73e0jOGOWueLthT/hXgau6
	 OpM2k88PR+7xS0y95Mo520acScr+BrdD/ZDIenQifKGOm3U7FrUVt8OMQ/+mGvmzCDWMU
	 lE8g/TgvB+/mWP+fGGBHxKivyFMnMgB7uBqI506B6v3f8jhHTa3/JX9hYxsHACJ8EZ5VA
	 UP5W8XqUqQTHZxeSgY7YEB22uvPXYYmhqbIS5qBSICSuTRgBdor+z9gc5pA93Lq2Fxssj
	 mCnfFSArLAzXWUgSqNChP1A9Y5btx25r6tTb/8bVyPSN8L18KYdP/GH1Ela9qLioKKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791227513;
	bh=bazphCU4FsrsLJ7Hr4ZLsCJ+aCxclFWA0FEhBRhFNI0=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AyXyjVf+j67twjEHirq8yHWyHm88KGBYZh8dO6X5aAHOk1s9E22q7tjWmd4LXNYod
	 xUy3f0jzQkmpZL+W38Xv50O6fkbCxU8OUFY9xa7HLPJczquKvjH/76V1RIIWBPKZo6
	 T0tcv989WyekyQDKrN+bJQ5gDc/39DtoOkez5lYCYXEuMZwowfSmvNtiv6yz/+sTUc
	 23eVWnHAjO3JdU6Uf4YAqoVlncZ5xgqqrii/gN/dcQajjJG1aEoBYXw1eyfRoyI4xE
	 x6TfJSe7T7INamaLkHRS0xEi4RcQ5kfK5jXk5bal7AEHTWMSRDviR6GY6vR0c7FctN
	 I44NmxAcIVsmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9240F4065D;
	Mon,  5 Oct 2026 19:11:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FAF8338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 19:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3146580C70
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 19:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZUYgOeCUR6q for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 19:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C32DC80A4A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791227504;
 b=fFCVGzWNnpsGbaXQMTOoSFS7uFPXiNXxWffOMMWyktUbkjOgTKxdG2wOq5fB8/mqXlgq
 1hPS6DaExgjCCaBzZCzvtTQ6uqW3osd6iKzFVQzjh2BlUxiIlAxjlnwVvjmxotyJOgO7n
 7W2TPggMWddaWJ1yfg3Snni/FxQbfWXDwmJFg5cOxFj30L27c+m49UdtxuDZW85Mp9QK4
 eazWmViLR+nKZjKD5QB03GSCuqUq1uXUWUg5pK3+AFzf8bjMyHJcL9dM1nxHuE3XhxGzh
 u5BN8aQbxEYv1cXV1F2ZYQcKJMwyUQV3QK3i6aYFbc922YC5Oq7d7yunmtfa6yUM15g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791227504;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=bazphCU4FsrsLJ7Hr4ZLsCJ+aCxclFWA0FEhBRhFNI0=;
 b=CY7QhHsyhXSq0thUTHbp4L+v8gEg+tNin5FGDt5ZlMkla/ONbkDC6e3FLRbYq5CIf8jE
 Pi/q2VgH6KUttkSVRcVBflGY/MBSibM5pXxLHpjwEgquhuxKjpqB5CsX0TPsRXs76jJiu
 Xz8BCh29UxjHaRNUgN/Cg2jtc966sgX2Ou7odjwa6boSCWvghBLx+KK5WPDdqqOXvUa5n
 ECnSXQwpM9jrAwewedT7mbW3wkh4BC3/k+k7NA2FusK0pGY8+7bbLGzRxUecwxSCirNUe
 e/3ILQt95O+8l18JGRg7NbPabi+wDVlQ0Td8assLzgV2t7bufNIi6mSiKRZcGOA9AFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=lE6DFPa5; 
 arc=none smtp.remote-ip=185.70.43.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.102;
 helo=mail-43102.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=lE6DFPa5
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C32DC80A4A
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791227500; x=1791486700;
 bh=bazphCU4FsrsLJ7Hr4ZLsCJ+aCxclFWA0FEhBRhFNI0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=lE6DFPa5RkRl2DcZFsosGpUGE9+5Z9yJYs1/KlsMc6naFVmAlLt/rlIsQZWJh05pv
 9z3kiCpdMbkFDNtnf8m9IZLYzyKWF+nRytJ0ABpc2plI/c2YLXZGJ3Jg/ld92/9Pa1
 uA+TO6JkBpNYr3sIsx8hWZmGXfRK4dEC4alPTMcFTf8X+gpESMtxgD/lmVxvgU3NbC
 qfCxqEPyQbyim2bULpvO0x9f2bRSArRUX9z9c2W6sldwiM2vzOoxHp36qSLYrR9zNq
 mLcLjmRNm/pP6kdsFCAt62bSflDuFKEM7lNUaSq0xn7ULincBCw7FkxOAHMxOiqS6n
 fLN45knllFV/Q==
Date: Mon, 05 Oct 2026 19:11:35 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, spacemit@lists.linux.dev,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/8] clk: spacemit: ccu_mix: add inverted enable gate
 clock
Message-ID: <20261005T150532-0400.inverted-gate-tested-by.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: e57dd256c83f2538d81475bab0b227701d48cc5e
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

Hi Yixun,

On October 3 I tested the exact posted v2 2/8 on OrangePi RV2 and R2S
as a K1 regression check. Control af2c8f5b7fcc and candidate 649a72433147
differ only by this patch; the working board/DDR/clock support, published
EMAC and OpenSBI v1.9 were held fixed.

Both control and candidate builds completed without warnings for both
boards, including the SPL clock objects. The new SPL was build-tested
only; both boards retained their existing SPL. U-Boot proper was tested
on hardware:

- RV2: repeated microSD, USB 3 storage and PCIe/NVMe reads; EMAC DHCP,
  gateway/peer pings and three SHA256-checked 1 MiB TFTP downloads.
- R2S: eMMC HS200 repeated reads, USB host enumeration and three
  SHA256-checked 1 MiB TFTP downloads on both variants; candidate
  EMAC DHCP and gateway/peer pings passed.

Both variants booted FreeBSD with eight CPUs and the expected root,
storage and connected links. Independent FreeBSD raw MMC reads matched
U-Boot. Both original ESPs were restored with full read-back verification;
the existing boot regions remained unchanged throughout.

All existing K1 gate definitions remain non-inverted. An extracted-source
host register model passed 360 normal/inverted enable/disable checks,
including preservation of unrelated register bits. I have no K3 hardware;
these results cover K1 regression and the host model, not K3 validation.

Tested-by: Dave Klotz <DaveWK225@protonmail.com>

