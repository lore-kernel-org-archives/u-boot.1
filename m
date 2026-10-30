Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B4606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gHPHn/p3;
	dkim=pass (2048-bit key, unprotected) header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai header.b=lsywAPLw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D984F80E09;
	Sat, 31 Oct 2026 01:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tmiqDodW7fH1; Sat, 31 Oct 2026 01:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F1F580D93
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793411916;
	b=hWDRYhv4CEmh0gNpDLHlcfODqmxzpnd/oEiPeSNLp6aD3qB/Kitnod/KcsYe0Sx5UvlI
	 nfO4L6NXj34Q6fkwIVNnZksGKGPh4AcgUUiuIzFJTP8OFHDpkIbrrtepMWyiFcDaWRaXp
	 2p8h9X2O7rMxDilp9g5to/YIaUbCobnutRzltskFjoVg22/YU3rUWNcgSIugWvfwZm6AN
	 L2NxS4raxXdMhKzRB0cGHZ0ZkmJUQRedZhrnmKTeEj/MNlCVxPnqHuySl+d7tAOYNWXdI
	 ooQxY00o9IZLgi0VnD+1G8PnOQrpEr3r8RaqBnVAPG3TxL8XjBWlBOAwXdymcwXYyEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793411916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:Received:From:To:
	 Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Info-Out:X-Proofpoint-GUID:
	 X-JNJ:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8dyNBs6ObNLn1TZmR/Y/EOj/VrBkP5ZScLmzBnMqclA=;
	b=Xmg2ZvVg3cIii5wCCVVZHlKvmIyXV9yWQDMTtW2Un2Zz5M/djTm8kTcGozSeXzgk9N9p
	 LO+0K9UMPuqOQEg9MoUqupMARHshZpPu/pPG4QZZzkDzCDQQCjsFxhAVBoYplpFkeWHnV
	 vP3/dxykhKRPKV5MRj3/p7hoZp4xG3JdHss2wd21sP67esO1yzuXLuCZx49C/WhuymHg5
	 F+RAXVlu+4hJKkoLx3Ztz51gB0sTyl8MmEPXoqK/Hs2ET7LW/zz0D9ak3g/n6hB2ZnPAB
	 LY3YI1/b1NvNrFO5UGFOIewnvSJC/Ezfl8c/beyawa1YtwWfeJw193cv/ADDSEqTA5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=me.com;
	dkim=pass header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai header.b=lsywAPLw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793411916;
	bh=8dyNBs6ObNLn1TZmR/Y/EOj/VrBkP5ZScLmzBnMqclA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHPHn/p3TyKEdmFeDTX8gYT77itR0LCUzs3UnlLzZVW0Ij7h75TGoQK2dvJ0QrCss
	 a8vt3QW9yReH3fYcWXWXwmaB7zv8Sw/5kMqCW6mt/7n44DIPMk+v1ZFqzFEXPLPNyE
	 YmDRQ6VfCTkCkzp2PJ6bpVjU1BuvUWscqkh9gao/CSQqAifI3lYvFkuIytxHlYKNBF
	 4y6n+bxyUTLaWMsE4pJX3PqrhrGLPmZTHMi76SEqeMSNOnCnjqAY47lXgzwT4LMGk+
	 12dE33Mv3cjeJDMchrLKQSN5lmWYqFzKQIyWPE9EeObhayAxHNXo7pa5izaF7OsJEj
	 cy6Qwa38vRJaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F1F580D93;
	Sat, 31 Oct 2026 01:58:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D15C362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E1C0810D1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxNVdNVMKPzE for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 23:14:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0A9B80DD2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:b747:3003:200::44"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793402071;
 b=JBmVH9BIts4RFKTwSCKnYVlkyM0kolsNH6/eEJnLgDnYWpYA5uk6O1QV1AzLPUism+DQ
 J9CEa7Kh8SuItbgtc433MvKd3n1FjdIYIyMiGTfm+bugNvWVEX1oodBiywByjOcPqAh85
 2n8t7xbAvx02UEaDvZmHbAc5T5IlHZsFEscICHOLtXaNg0Em4y6io2AWD13IEhl0KMMJP
 9LD/avGvdm0VTMigujfKLYfwTQtg80Kk/B8gV3NDNErJ0+HaIz1NpSCXks26ifcumkZ1E
 gNuM8jZhndgN5e7ngephke962KliyY5TiPAjkcvRZesOfcfeHk6j6XTMhmITmBip+pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793402071;
 h=X-Greylist:Received-SPF:Received:X-ICL-RepId:X-ICL-Out-Info:
 Dkim-Signature:Received:From:To:Cc:Subject:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-ID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Info-Out:X-Proofpoint-GUID:X-JNJ;
 bh=8dyNBs6ObNLn1TZmR/Y/EOj/VrBkP5ZScLmzBnMqclA=;
 b=hsqOLjd4lZh+cVgGtrOxFS8ZIgQR2W1N0ztZCK7mM6nySWZ1l6V8sKW66xfwNqRgt3De
 n9pYdb1e6wTZ6swIlvbOXDkI1PyYDPM/MU0phmGjUvJvZ6pg5BJ/LM5Z6VJJCE3o2Knmw
 goQNv+O0Y0CTQCUbY3q4XIJWdhwzkYEYk2KAe65uMNmuCqQ8h2hKgJ622pRDcniz2mGAR
 jE0WVQyiPoTR28MOSotdQD7a+2PwRez7LzgJTFbsI28OI9gD+4Re5bbxjsmI4ze6JfBbA
 PAnGqGsbD75iYTO8mzaxMYKZxplVN/QcbiolsbH4Z7wQgWfG44dGdZQElblxpePJKYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=me.com;
 dkim=pass header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai
 header.b=lsywAPLw; 
 arc=none smtp.remote-ip="2a01:b747:3003:200::44"
X-Greylist: delayed 1798 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 30 Oct 2026 23:14:31 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.a=rsa-sha256
 header.s=1a1hai header.b=lsywAPLw
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3003:200::44; helo=outbound.pv.icloud.com;
 envelope-from=pepp@me.com; receiver=<UNKNOWN> 
Received: from outbound.pv.icloud.com (pv-2001g-snip6-7.eps.apple.com
 [IPv6:2a01:b747:3003:200::44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0A9B80DD2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:14:31 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPS id
 2E96C1800146; Fri, 30 Oct 2026 22:35:25 +0000 (UTC)
X-ICL-RepId: 01a18ef4-1fda-7722-a44c-14319e7f9514
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhBBkMCUxxBC0sdXAdZEhVdRUMIRxtyHVxWUAJaS1QUBBVWQ1QEX1BLGw5bFwNXHFZFXBhDCV0FVxwdHUFFWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQWg4cE1YVEwBeDw9MCE8KXgRSC0cISQRaGVMCSABOHVQGWARICEoAVQVdAkUBSwtZA1NyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1793399729; x=1824935729; bh=8dyNBs6ObNLn1TZmR/Y/EOj/VrBkP5ZScLmzBnMqclA=;
 h=From:To:Subject:MIME-Version:Content-Type:Date:Message-ID:x-icloud-hme;
 b=lsywAPLwlAlq/MNzhEwC9UvDODygFI/QrMV9xK41PfZIoo0EYMm1GHzM2fnMkbJmOZehjFUtBasUUR3aJQfQBIEEMf1pcbJB+OFDRYGoSq/sUY4XbTjBZRTvMyou33/w5E9TAQ5mYhBZwJ6ZYGkAUNEsKwWu7ABZ67k8bUOWXdK0kynDtd8gdMo92RB91ABR7wzWMNpdv2mjT91+4ravjOJthIh4Hum3UwL0XE9kjPbrhUt+yVvMLVsydvqqiwO+LLFdtVYzzatzIjA5Ru/a3CKfitM+uSMrLHe2ilsbJjWZePdgB/P+MZeBkcjP3rD5Z7HQMy9hgUY6vlXjwXcSQw==
Received: from [127.0.0.1] (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPSA id
 C1182180013C; Fri, 30 Oct 2026 22:35:23 +0000 (UTC)
From: Peter Esselius <pepp@me.com>
To: u-boot@lists.u-boot-project.org
Cc: Torsten Duwe <duwe@lst.de>, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/8] Almost complete Raspberry Pi 5 support
In-Reply-To: <20260925105432.0F27E68C4E@verein.lst.de>
References: <20260925105432.0F27E68C4E@verein.lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Oct 2026 23:35:11 +0100
Message-ID: <179339971177.80896.9136812382605838448@me.com>
X-Proofpoint-ORIG-GUID: Ane1xiEydauwMGZckA2W2V3gIJi355cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA5MCBTYWx0ZWRfX85sU1mRQcsDt
 WsBRnig+3aChX/W+95Qa6HXU+7LPH/M3tycRmof/OMS/vpmUz0fb2lxcdlb0MlJqfrAZVZ13+H9
 gxSR3hh3nh8v+98ecplk+USIaTnVgaMZPNYBbQSIeOwooLs90qRep+xhvrclmPM8QtV0vE0kJ90
 bOdeXHawAjWcSDh5chzfwkR+UlMNy0iwy1+F6/QvpcH8wj5JRm64gTUudEU1+C8O4yUUl94oUpa
 26JiQSyuFd9lQS36T+7gE4uSimJQtpJkvD8xr+6RGO2WnRqtb8WGPthS8OzoOVSFF00VFd5FDlZ
 trgGxir/eRiiaTbvsOozvKB/djmT72x4COlkddEEcpUPswR//kNxtV0XwEaEU8=
X-Authority-Info-Out: v=2.4 cv=ArvjHe9P c=1 sm=1 tr=0 ts=6ae51baf
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=deLJwN4FMxAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HHGDD-5mAAAA:8 a=2HwQzjjHsc0aI9Mmx5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ane1xiEydauwMGZckA2W2V3gIJi355cd
X-JNJ: AAAAAAABCLvCtZ81B6FIRBDOh6hHQqrOG/7LiqYtnFKx6vrp8c7iT388L34ddsdq7zoq9O
 fpVLvbCKUsyx4FDpIq6dg11RTgYwgjnx/Z2PnXN4PgB9KnKvKxmdbPBeXzeNLtToiLuUwI
 URYeahx42zPD22Y8apzNCb5qQYoCtBZKY/6iYcnWapejFjjpHaqq8+6OsDVRuiFqUhv81d
 JfkcYUTmlGy5FZfXtC3DjPPAAClF9QSQwzHVAnpCJbiV0qJlFdCXpbxu2sD4ZywNRt4999
 BAvJhSYXp+V0fhbEI9p5QjCxQuuTTQm+2CE5Wrsb67CqCOzjWdleW0jcSSL/uH0Bs2lsoS
 4YSEmJMrqTnsq1vwVVQ2ecyLVxgwHByphGFhGlo7Vv8SXIZTxY2K2oigbh1TQn8F2ShaHZ
 gSHKIHYRe0kQEUoz7IdakUkqGhLtUXazsELdCge/PomKOO/STc9bkoCQ//WzXgrDhBid4M
 qC4pIXsiC0llNRjbvI8Lq8pDBw6s3BeSXRdv6RbwpUZCh1zgfDA9oujC4ULhbBoz7HhG4K
 3vqpBJc3n8rzhYvS6l41+BiZRLO4vh6Sf41B0BcqfT5tDmkLaSv/6or2C55xpwSOcALnYC
 o2lXkGiHrH5B0l1512OjKguy7U5CNPcW49J2UMlFltPI/MBXw4mKbfKh1cNICiNTXcHT4z
 sETen1rxLwKbaxNi38u1h6GWTfYt0MGzfw28jC6wAf86MSULFJZGPfFWuaVNbqlttZuuZG
 WmHN05PUQ440iIEFZjmRWtoTZupML9TN080BiTciYB82xc7Btz9pMx2oWaUHe2DjKBX4n7
 m0SjB5D3sCa/uHUyQ4IUzZnbRJyYCiiwGeaZxH9MSsKyujpFft9ZkZEoCzSzs3Y0dtbpR1
 WL0twMKdOggzcYznyWl1BIBAv1PpRGUGPhTLSb7Dla4BwOJf5EXyDTlIfK1grJ4KxRZWUc
 GTlKS4L7FXTXL0f/xS5fsA29LL+gbbg5QxL8ZnA0fm2w5uZ0jHBHwrFISTomSaf0SQ2Gsf
 sSsl7ecNMF6BN3F55UbIgofVa7IRSwL0cSm8CuIMSwK55K1KLCRmxnMB/ypAFS2nioqBwH
 eQ3v6Mua1bhSM9mqrWYY3kvwgFYRKxn48BRhuAc3cz8lqwUoumhPb4yO2+BkmRl2Ig6NDX
 HyV3iTD3Ur4EKpCRWu9+Y9pmwmRTFPlDk+lL/HEx7SymQ+UjvnBEbLjQ==
X-Mailman-Approved-At: Sat, 31 Oct 2026 01:58:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Torsten,

Tested-by: Peter Esselius <pepp@me.com>

I tested the NVMe-relevant subset (patches 1-3) on a Raspberry Pi 5
(4 GB, Rev 1.0) with a BIWIN CE430T5D100-512G NVMe, using U-Boot 2026.10
plus those patches and a one-line `boot_targets` follow-up.

Hardware/software:

- Pi 5 4 GB, non-HAT+ M.2 HAT, EEPROM 2026-05-26
- EEPROM: BOOT_ORDER=0xf416, PCIE_PROBE=1
- config.txt: dtparam=pciex1
- U-Boot 2026.10 with:
  - [1/8] core: skip parent device nodes without a DT reference
  - [2/8] test: add dma-ranges UT for dynamically created nodes
  - [3/8] configs: enable NVMe on RPi4 and RPi5
  - follow-up: boot_targets=mmc usb nvme pxe dhcp
- SD card removed for the NVMe-only test

Results:

- `nvme scan` finds the BIWIN NVMe.
- `bootflow scan` finds the NVMe ext4 partition and boots extlinux:

      ** Booting bootflow 'nvme#0.blk#1.bootdev.part_2' with extlinux

- The NVMe system booted; serial console and SSH work.
- With an SD card inserted, U-Boot still boots the SD first
  (mmc before nvme), preserving the existing fallback:

      ** Booting bootflow 'mmc@fff000.bootdev.part_2' with extlinux

  Removing the SD again and rebooting returned to the NVMe-only system.
- The `boot_targets` line is required for automatic boot: without it,
  `nvme scan` creates the bootdev but bootstd never scans it. I have sent
  a one-line follow-up patch separately; would you prefer it folded into
  the series or kept separate?

Thanks,
Peter
