Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A96606A31F
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mTVPa5MS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYeK1PSu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0373D40851;
	Fri, 23 Oct 2026 06:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id riOwaZfmhaYL; Fri, 23 Oct 2026 06:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 102714058A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792737455;
	b=TbgEE+zUeIU+6NoBOeK5Gl8ytO//aDNSU77ehJl8+FORa4WfXSv7lb1ZovdX4EB2aE50
	 FC5QPp5EEKmXE4brmWuNnU2jwCVndCoOeCU7bePme7MBNnqoqJjq+gmcDP5H7rcENSGTQ
	 W/2uUd5NitLhWmdDuxx/bVR+80aPoLtX3zZpcH6/ZIxOxAoDxyLPUK2PRmQpF+o3+6ghL
	 pHRKULcvwaO/cpC3/bBaZwXdXDNgMETB9jS0MphrsPgUkYNUTU6ZwDgz/zOgNhKptfgXI
	 VvuYuXHMDHHQno569U2bBsVSdgDiDGDeNrAg92CMY2imtVSVF+7yfeyMYEoZ8a2Z3wA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792737455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KpZ1NhUW2QeZ4z4KbXZwjiDx00tSoIF0uR1fDDDUBJQ=;
	b=Us+p8UouVQTpPTKAiGgTKnIkGy8aj44ECbkG7J3Jwq6Da6Oc1Q3lb+f9t2QAM9l2o5Fl
	 nIidwHE7++Ic0gWLb7TQIb1juVAKWWX+eg0iN/J3CynctqfaOK9p22xIA5aa+0bAn5AAz
	 i+7PL00oWyRGRfRs4xJcGH++BXRdQA8A8mi7b5KZT2kC4F3WI2XnDHcFrlUxUaKIgGlr5
	 TES8bVCYq3FVQDrEEsRv0gzhb00gcoMSUmfazrZkbWHOeeAbhbhnxm4gLozUT14PGvZFj
	 gdmKVdK0vxxnNNsaKK+zfpdXgDxnfB0XLmMCl6ZJW86StL1OzGnwRs+P1QCVmfxpuYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792737455;
	bh=KpZ1NhUW2QeZ4z4KbXZwjiDx00tSoIF0uR1fDDDUBJQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mTVPa5MSss4tJ2hFP/9Rcxa+KXaAJD9Hn5TbftqirnAUS3VXwUnK4uUGehWwRcAD9
	 lnZxDZl35Ec3+42y9UEga4732lcASxFDBVVe6IBsRvydv0X2s+G1TAqxFclmTEKLFL
	 RMcaqtByPcUzw8ykXTcDL8NxIGapniR2dYzz9N/0muEaj2/5m4QlAyMGC/W/vv1LFy
	 ogBI/5Yba+VnOjz/kooBfABSaRREP9oQrfBjobpXR6LpllwReLl1czSGWs6t0oAW/n
	 4s0P+WnPNMfjx01t2sj5V8H8GUaRa1SnvON183XCTxrN1ejxQcdrhvD70FNeaixG8J
	 5VQN4iFwEOwDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 102714058A;
	Fri, 23 Oct 2026 06:37:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 311B31DE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 228BA80F77
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9bHTx9vey0rl for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 06:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2256980F61
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792737453;
 b=o35mKLwAOkKylxoMKf2ONZYOhXAaDw3lv2S1lr+nV/ZR63SHucVUq2ix15Pfkl4HqbiO
 8QEMAe6KialWW77bL7NSvAdegY+WTjohQKukP2lvLLtEEuS16/hbE9JXLpUedRrpSx5hL
 M/ceaQHGexjJiFbPzF4dXa6+bhcRBpfanzV1Yxi8TdYE42ZNDS7H4xwG5KUrCR/gs237G
 Yo9jWi7OtiQahZeJ2q5HbCaIGr4Oh0gQC/FoC42FXVN+Q+4w9hu9szuRJqbQ8OT2Jm/QS
 5gJDp1jKAjBW7tqsAS/99aXdU8OYyoMSJjYM8Jzj52Wx/vtVsCcbsoWB9sKhSjUg+cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792737453;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=KpZ1NhUW2QeZ4z4KbXZwjiDx00tSoIF0uR1fDDDUBJQ=;
 b=UURyi2EAG3je3pB35jTNfyVrrCu+XGBotMqmxZ/ybdtF05lU6/EANeufU3BF8zZZm5YY
 /bMmRz20JyD7RxA1OGWwxeZBbYbPCRZUjMNRZCPJeWYxSuqvLk/JDJqAIa/PeQUIrLZyF
 srtfyClxcp0RpjjRzQ669XXL4qqEKSiIP1OC4JzMxBadombFwnTKQqLRdntlr45aekCJU
 pmZv+Q2jiXqCUXXqRueG73DtPdFRkZx1jt4u3VjwdP+A76WE6+VmTmQGpiPkbtw7NTx6F
 Iy7r0COIvaDXPALBOuMFLIMFem8tSaJS2r7ZNAiM1P1qIJCqcd288SVGSQQh9rVI/5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oYeK1PSu; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oYeK1PSu
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2256980F61
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:37:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 831DB602CA;
 Fri, 23 Oct 2026 06:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12E01F031E1;
 Fri, 23 Oct 2026 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792737450;
 bh=KpZ1NhUW2QeZ4z4KbXZwjiDx00tSoIF0uR1fDDDUBJQ=;
 h=Date:From:To:Cc:Subject;
 b=oYeK1PSuK5uCbF2nbs6a7qIetJsQUd4/RRjxcLD3m4MbBXsFil4tYYONCFVjpZn/1
 uInvTyXPIpK8PHGkY2ENpV13sWXel5HSDcd6NRMB7Ih6PkV/6NwKpJpaydEdS2ZFoP
 UUVq6MUKJs2qhtIa2Il3mBobv9ag4Vopsl99tO18T7jNtlnX8ZVUMkBAaKmKiZNVYJ
 se3ymDWdrz4H2WBumUkZ+/zb+JCtitCXrClsTgwCvRhsy2WPRfCsBVw/wserpervM0
 kg9fdActreSkbkoTYp7HFN3U19KHytxCICpKrloa1Tl9bjAdpjL+IT5Z4v1xZhNXIV
 dJ2XXpcYoET7g==
Date: Fri, 23 Oct 2026 06:37:27 +0000
From: Yixun Lan <dlan@kernel.org>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>,
 Dave Klotz <DaveWK225@protonmail.com>
Subject: [GIT PULL] Please pull U-Boot spacemit-main-20261023
Message-ID: <20261023063727-GKA184714@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull from u-boot-spacemit into main, thanks.

CI for this pull request is available here:
  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1695


The following changes since commit acc808479730e13e74199119eb9b2b9113999244:

  Merge tag 'net-20261022' of https://git.u-boot-project.org/u-boot/custodians/u-boot-net (2026-10-22 09:22:17 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit tags/spacemit-main-20261023

for you to fetch changes up to 53d5fc5d42bf31d3e627bea34a5199d7790d9f43:

  spacemit: k1: fall back to the other boot devices in SPL (2026-10-22 22:57:40 +0000)

----------------------------------------------------------------
Pull request spacemit-main-20261023.

K1 SoC:
- No panic without PMIC or SPI
- Fallback other boot devices
- Enable USB host

K3 SoC:
- Enable EEPROM
- Enable SPI NOR flash
- Boot image support

----------------------------------------------------------------
Dave Klotz (5):
      phy: spacemit: add K1 USB 2.0 PHY driver
      usb: dwc3: generic: add SpacemiT K1 and K3 support
      configs: spacemit_k1: enable USB host
      spacemit: k1: do not require a PMIC or an SPI controller in SPL
      spacemit: k1: fall back to the other boot devices in SPL

E Shattow (3):
      configs: spacemit: k3: enable spi nor flash in main app
      configs: spacemit: k3: enable mtdparts in main app
      configs: spacemit: k3: enable eeprom tlv command in main app

Junhui Liu (2):
      tools: mkimage: add SpacemiT K3 boot image support
      doc: board: spacemit: document the SpacemiT boot image format

 MAINTAINERS                        |   1 +
 board/spacemit/k1/spl.c            |  48 ++++++++-
 boot/image.c                       |   1 +
 configs/spacemit_k1_defconfig      |   8 ++
 configs/spacemit_k3_defconfig      |  15 +++
 doc/board/spacemit/index.rst       |   1 +
 doc/board/spacemit/smtimage.rst    | 144 +++++++++++++++++++++++++
 drivers/phy/spacemit/Kconfig       |  10 ++
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-usb2.c | 153 +++++++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c    |   2 +
 include/image.h                    |   1 +
 tools/Makefile                     |   1 +
 tools/smtimage.c                   | 208 +++++++++++++++++++++++++++++++++++++
 14 files changed, 590 insertions(+), 4 deletions(-)
 create mode 100644 doc/board/spacemit/smtimage.rst
 create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c
 create mode 100644 tools/smtimage.c

-- 
Yixun Lan (dlan)
