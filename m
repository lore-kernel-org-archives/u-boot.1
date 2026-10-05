Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDCECA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 19:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1E5B80C0F;
	Mon,  5 Oct 2026 19:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J02Tbmg65aUJ; Mon,  5 Oct 2026 19:21:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 544BE80C10
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791228114;
	b=SwBkvIY3g/JjGKi9aTMEK9tnh6vd3tMAMih9P24HpFbHX4FKcfVYMFOLB9t90jQ8lqV4
	 wfxMax7wT6xHlaFj2sJneof17QsbFpSWrdJoPRtF8iDWthPYw1+6LX9AmK8vtoOzSjoOG
	 rW0LmOIm4lZ0/nSuTzOYOuD+8B12dO4s/S8iMSchiYy8PdMlQZVheXEyWRJMAvdXHcC4M
	 5I6VXzfI1QDDOZ/kn+YbMJhostj5Lm53vzp1IzQsI5RfcaDPOPKywM7i8FMcYTWZdFlCd
	 ArggHN5uuuoD6WLOHIaLNi9oFMetaGxkCUiS8bLbjHadprexfMGRLSO4NNUCbgAw1YQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791228114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wOz4DnzfmU/HYeLrl7a2IRmweJrrBl1OmC1LGZrrjZs=;
	b=kdYjPaDLsr/fqxBOz12YS8NYByKcKX702/DEfVx+Bsw1TQTyyLHAMQJU/mzUre/Zn2HW
	 5kce3Aldvo/p5NSFXMQK6Be1N3fBt6IRQtekTGbi0ajsdFMSeFz9Ls25jBoFQq4s+Umft
	 6qgbgFM6bkCuVgedf4mGrfQ6exCLfXBEGS2x+jQ+lDqCRLat5UwUswKYbvENSvPHLwEDj
	 ciHYTODiIOM6SE7hK/z0DS2YBB0A5iUNB0BlhyFHVoIMiAgeC3wdtfIQwK7bm9KcgytHi
	 kX5hY9H3bNbcdsxG9qqYxih9V5xnaSxkKD413ljtHuQL0fOL+MjEmFLH6mZy8Hdg7/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=QE62kwqx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791228114;
	bh=wOz4DnzfmU/HYeLrl7a2IRmweJrrBl1OmC1LGZrrjZs=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DX83HIYeBGKegSB+rKopbWlvdksuEaXuc13Pu45tHVuxdd4eGsbW3mSpuM1MWOUKo
	 Cr+qVh/NzYpdFRG76tifocXeVcymEES88FMxgfGZkLhwFjiHBlbzOtis+4+g7wt8No
	 l4MfV3LjbgkaHIWllMd1JesZK+9NBqa3iFL2PtLTtE3owjACjqB9HOlpmT0J1xOwos
	 5tsrsahQ8C3HLIQdhjxsxVi7MFmg68FEzrsNl/gm9l8GhJsy0WYTbUWd6Pc4S4mSIy
	 +FCAXi5i4BPmnDkCvvVRx1u/18YIVIzMDdRnESBRfKOGqNpxxTQRXtY/r7uwyZs0EX
	 b9E1tdej3rNpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 544BE80C10;
	Mon,  5 Oct 2026 19:21:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5EC7933
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 19:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BBD580AD0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 19:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9jHPP-pfV25 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 19:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F19D280AAE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791227865;
 b=hJjZSLkpbqkmmPTuoLdttf74Rl2DR9FkSUOZoy2niFZ2v2MQX3A4n3RwgWOQ7dKQUJhu
 zGeQ5qnsfhYvnOwq2MQc6jEpias4cI8lpG9j6JCoxqNzKdAUNAdbuFpPbisIeFFwV7miN
 08TvZtkT5rPjyB/UeXuG4Ab/LeI8Wa5/TEMmFp3ZkqdUt1YabzFKtmnq8Zy1PVTiWPJig
 Yf27uQNmEcdWiRnxPy1mF7MjJnQRoC7dAB+byhXMFXBKK4pn6ecMk/VYdby7+DYHXqaYl
 kJVbggWJJv+sbpCKEass8FNxVsw51y2psqHe8umgxAZ6YcZOIas5mPGZctaP1/ImpAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791227865;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=wOz4DnzfmU/HYeLrl7a2IRmweJrrBl1OmC1LGZrrjZs=;
 b=P24Mh2/6r+/GR203gf+szhifsqy8Wrfrw9NL1SJXbxlZkabkWjCQsm1LISxCQ/k/6lpx
 QDhIczz08YA0JgpRvsdgv8S5gkPEKslziMxTNxsmFmKw9S8nNlO2cl5cJD7M1AwQqFm4Z
 KyHueV+ivKc6r3C5Dg1IFVS9HCSOE1iQLegj02HUyudENnTWnYTkc9XIh9Q8nf5taV91Y
 u8E68hDCoL509C2nj2WKrlezhzj1Xeycu86UhtshdMFi4vs5YOLAX3vLOua5vAdT14oIZ
 AZtPgdy8eQ0j3L5sq9ucC8MqhxiiHPwlF+0xX/J+HA1vZcQ+DHQuERpoSbnZitJyDYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=QE62kwqx; 
 arc=none smtp.remote-ip=185.70.43.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.103;
 helo=mail-43103.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=QE62kwqx
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F19D280AAE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791227862; x=1791487062;
 bh=wOz4DnzfmU/HYeLrl7a2IRmweJrrBl1OmC1LGZrrjZs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=QE62kwqxNngB2nu75/HOXZHsbCBxgdabif4Wml3MVLg7YmLONQMHZgFtMQoa8pFF0
 PZXP3KzvdbpzCUiqDFHfDt0K5t4L6A0wtSAfYMH/UtmVMc0Gc7oKKyFjnA8RE8YACm
 yym9P0PeBCkeyqeuERCUR2eS3wJVanv3JREL3/eKly5f3XQbsc8fCaOb+3oMdck28r
 dIT74zv8RosqCFQn9VmwukuXwcA6UuBjFTCS2wjhzsROEikLlXc8DDIk22EklVG8Ey
 wZUjFnO4fveu+SSJA9JBx1rkPV8jupztucamX4e9AVcZ76iscybSC/Avl2Q79bIAz+
 vBXQD8jUGubag==
Date: Mon, 05 Oct 2026 19:17:37 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, spacemit@lists.linux.dev,
 u-boot-spacemit@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v2 7/8] reset: spacemit: Extract common K1 reset code
Message-ID: <20261005T151511-0400.common-reset-tested-by.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: a6be6694cf38154c84d8e0d46eeb1eb921c83e42
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

On October 2 I tested the K1 reset consumers on OrangePi RV2 and R2S
using a combined build that included v2 7/8 from k3/for-next at
f4d1c8807a, together with my unposted OrangePi board support:

- OrangePi RV2: SDHCI microSD boot, PCIe NVMe link and scan, USB 3
  stick enumeration, EMAC DHCP/ping, and FreeBSD boot.
- OrangePi R2S: SDHCI eMMC boot in HS200, USB host start, EMAC
  DHCP/ping, and FreeBSD boot. PCIe was not exercised by U-Boot on
  this board.

These are historical K1 regression results from that combined build,
not a new isolated test of 7/8. K3 hardware paths were not exercised.

Tested-by: Dave Klotz <DaveWK225@protonmail.com>

