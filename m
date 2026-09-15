Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2D5C88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11C6F4067C;
	Tue, 15 Sep 2026 20:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUQ8inrbyD8r; Tue, 15 Sep 2026 20:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 636784066D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789505537;
	b=WUa9fYRnF1ouZgUN1gDWqPdp/6tLI3TwemdW/YtrO1O/0SWwywHVY3Tm0drGZclg+l2O
	 XTKv93cOrqwUJHr+gvSoj5J4FTmKhmdFr8ayL5BOqoPPPvv9uj6Q27QSuL5yAQmSkLlHD
	 0Wza7QRF+um2p6BXxuECT2HdvD7ayMFuQXxl43eR3ohIdvWz8BupLO5G3g7cd38N/1Abr
	 /fB964UTAyYa44A4iTJFlnpP/JtRZqT9QLaD1fg9vb3XDCbrMmPHzKzNr3Jlqkes63w8/
	 P3G4kxm13Mxv5xmHH4rmg8RstM6ySEyiWO57SY7h/a4A3bCTLGuTMxA+5zuO+9vfhWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789505537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9NfZpupV+ZzlFVvla8veUvnnClATrjY7VplqXyBRtW8=;
	b=MVQGEBMkxkyf5VVyBWyceDrtAose+28AhwilC6R/DjPWyiruh6hdlaxa5eePcst3RKL0
	 +HsCpjeu2UpBgxQdAUqMENTYkAav4r2JyE5oUdtnyQPdAbyn6Km1qCQO3pdaaP9rRi94F
	 4CBQGL7TXHNR7p51e/fm2n8omtz0wcfjrMj/09CfmlIG8oH34ZnAvOmfc5pf/+tB+mMyD
	 zDh1skxIBtr742ShTqF6u4oUd2V4zx5OCR2Xv2fvwWzVYjqRaQxMvBmqv5Zl607icS/Vg
	 o1EiyuetbBPkZzpVMeEuupOvUgfZrMXl2S6w7747F7NtaNztl/NwmIlHvaNxGOn+9bQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789505537;
	bh=9NfZpupV+ZzlFVvla8veUvnnClATrjY7VplqXyBRtW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BiOGFvsidj+y+K67EXTfoViyrMEUEqmeC7Ns08nHZjJ1/mJ/ryO+CFkil0l742mdv
	 0SE7xzrZnQpVWIN97+5cDADA7qqpJ1LbcXSEbJpOKGeLqHTRbFVSRjyRNvNCHI2iaq
	 G9/lFE9t2rLr4ReEkWR0xkJ74t9+9lPjMrM1ntJStHyXPUkSvCJ4soLxh1XVVaVM4x
	 RRAX1qPTbia+/WkHi2MO8ctdm+OnUnw78lKoS7eBb8HV03CzS1IjRuVhPHI6vHOxce
	 4JlwdFOP8bzupvNgQ685x+fSYGbHPVODaG4tmUPwnrtM21oxfBj4GsWA+66LyYHRF2
	 6rGfjF0BrPOZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 636784066D;
	Tue, 15 Sep 2026 20:52:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25F222D0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1795B80AC8
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZ-toMjWVkhZ for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 72CB580AAA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789505535;
 b=JduV5zrdSxcxJ4uHvYSlRwyE5BpOedlYqfNzcqGaN2G67hj5Us8TtY5fW3Pwvh7SerOB
 z0nvUHTjhHlj+LNSzL7vS9C5qSsU1VCaJIZ5LYRgLrMfJ/7LOqkxODrRDg9qnpxEwNXEB
 TlOCt2Lis7vQvh7/jdrfeVG9kNRvom57ouye/mmJILI+GsBn/9kkRTtXdJCn0uZvUo8y/
 lQu3c8IY7+sCZDulDrJw4mesGbeo4qbexk0z2E4k0vOOm06toyU35Zl365nA5eSTXAL7a
 K0Ha9ci+fXn+ZhZYKdoKJFzwJaKqznU0se6WtXwnohc3oA+PRIPFTUcfJ+YC1TGZPSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789505535;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=9NfZpupV+ZzlFVvla8veUvnnClATrjY7VplqXyBRtW8=;
 b=P0CEyVqSlcyQSQQGKotOMClFm4wOU2CYOv7jNKQMODryezyeZjgxcyusZH1VR8rgwUOK
 Iu0l+QiLmuyULLZ8+GFL9wqsHAZp4Wee8+bW7dDZjxRLB+cgZ1x0ZYdEzDEYPu87GeLGK
 MjpTV57q34JBdvOpuxlAJsE2wRSHZhiwR5jarLSiRCj6ltuzEHEp845wJO/RmBwxfIY1U
 3CbIhZWz4hjVZ9movqo+R94MJivYmAtcp1axqcr9Zl31hufJ88gt4r7iJwtvhBMvvmAOK
 9mFWEJY6ZEsoyDLt3vRK5FAhNLpRjnqQ2hCUukr57DgypabUsfKWkCGIdet34aprrYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=TR1wIq3Y; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=TR1wIq3Y
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72CB580AAA
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:15 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7613120B7169;
 Tue, 15 Sep 2026 13:51:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7613120B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789505489;
 bh=9NfZpupV+ZzlFVvla8veUvnnClATrjY7VplqXyBRtW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TR1wIq3YKNksHYo3Of8f1Sx69do6br9eYDRMi6AgFBKVdh+13eTIpYicutKpIvCG5
 5FRXPNiaXrgUOgsEnB5My/e469ztM7RL12gG/Q0u12nY13l3+7Psrh7H77sS1gp5FA
 9Gbe0mMD0yJpz0IAUudhTwSkKtIqiYHogybTpFpg=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Date: Tue, 15 Sep 2026 13:52:07 -0700
Message-ID: <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
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

Three independent hardening fixes found by internal static analysis and
code review. They do not depend on each other.

Changes in v2:
 - Dropped "boot: image-fit: add overflow guard for FIT decompression
   buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
   as the allocation size and as the unc_len bound handed to
   image_decomp(), so a wrapped multiply cannot leave the bound larger
   than the buffer, and image_decomp() already fails cleanly on a bound
   that is too small. The claim in that commit message was wrong, so the
   patch is withdrawn rather than reworded.
 - net: tftp: replaced the four bounded strncasecmp() comparisons with a
   single check that the packet ends in a NUL, per Tom's review. It is
   smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
   and it also covers the dectoul() calls, which v1 left unbounded.
   Retitled to match.
 - Rebased onto current master (a44f46af0aa).
 - No change to the NFS and ext4 patches.

Daniel Munic (1):
  fs: ext4: widen ext4fs_update() block-group loop counter

Drew Kluemke (2):
  net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
  net: tftp: verify the OACK packet is NUL terminated

 fs/ext4/ext4_write.c |  2 +-
 net/nfs-common.c     | 10 ++++++++++
 net/tftp.c           |  7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.49.0

