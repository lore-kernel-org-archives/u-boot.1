Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D3CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 06:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BF528119E;
	Thu,  8 Oct 2026 06:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vh132rL_tPyP; Thu,  8 Oct 2026 06:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F2D081192
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791442168;
	b=eAon2FKLEyt0LfXJqg83lx+vkgt5dva296D5Ki1gkJndVxgV6c2tnQsK76j3UuEkSdXR
	 GXs+EPUdfQCZliyXYNGYtirVIfRMtJq9dy5gXv1Dqhkjinf9iInPrK7zU5tmT15pnXx5D
	 jMh6onPGh8fXvTOEguigzL/jMsI1F1O+adntGG9xhPdXRLyu7D6oCzngUFctaul9Vuu3g
	 zfZIliZxvoWIXExaIOsI7pgatV1OIgWhJW1/Tnr6RuAd+GpwEruEkoDaHpKWBloTMvrlr
	 qBJvUD9SKAOJNGuVZykduG90esIgeymAmJl7y8IuvziHbbM7CkjEgmAz4sjS68n8Lrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791442168;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 From:DKIM-Signature:DKIM-Signature:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
	b=CcB5EjCQb24u5E1+MhrXL6sPs3zzaC4SY9jShetIHVcPh9IxtSIjiaGg1H03WnmDUCsU
	 w6sSRO6auIGHz+rQjSCaRrwn1me9/sfYmFmVEsb9VAz87KfP8Rr81v/xI3RQnKDSoQISj
	 53uks2/P+h2b2ccSGKG4Jv/hi5PxmJR8ttDnxMFAUnFV0HD49jgszFAf1LVkhf2TXlgsP
	 L+2A7fIC8gQlVEUOEPsAkzRgxAR4w3ZvC3/Q2nMUWkQUA1zTPbNlRjsOZ//ND6xM/mmHz
	 dOCkDxjYLXYXhNHogyxbpTzzTQJIEPsBWdE1T+iQqDGtDSRETCbT+M4w/2MZFrbUBAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791442168;
	bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OcO22PCn7SHt7uLJC+eURd0Lh+mGB/VhHsf7AAAxfXrN+BiamDzs43MKXYRTAa/1a
	 BtDLXcctbwl/clkR+VBw/KFzM8dDRNaVNbEHzGJ0Xs2v5gZk7AzIwE3B6w3HwiR7VH
	 PVYhEVGrHIujAzgkeaWY7/wmijJoHl3h4wKgOnNPXTXTZhK6zA8eaLWsT+EV+w/UJb
	 IZupYWXfGMDSNYbZJZ8mPiFLtQG7E+GyR5lT12O7KQhKUmlJ8oA7ru2BsKYlvJpCvg
	 YFqO0Mq4q1u/XaeHbrhs8pqXBxMz8A/J8JEioCPc/Zvvh/9nCFHrnav+oCR1IVUCcT
	 rDx1KnvQ69fmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F2D081192;
	Thu,  8 Oct 2026 06:49:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CABD622B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B036B4082D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gb7Kr3nqBOAe for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 06:49:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 391B940827
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442164;
 b=Lj2xLksrN/X6xhl98MF8okkr1Atule7G4yWLHd0EvI3fHvKLuR9KavfFl4fm7WueDEQ0
 g0mE3SpP7bAOGdueDu/WIlrtWKVfUgRGjbVCS1O7+33CZdFPjQc9Uqvj5t4a7IoKt+RUs
 05pHsxiUcDiNgsKiqQ2empxsRjohBu62KmxnAERzo0kcBhInF2+nWgq0YJEGfheJAQNpF
 m6vRt1vzSibZfPr6K5cbSH26sCCGlW1SysHdEPQn01jvRCdC8sY44TCxfvxf2ZWCqd/z/
 euMZY2+b7jpkWbnMD1uEtIFy2um7uOvcsiec+wfSJWJ+6UM++4CYEncuJ+hodbvrpeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442164;
 h=X-Greylist:Received-SPF:From:DKIM-Signature:DKIM-Signature:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
 b=FuBO0SITsgyJseGw0/PAIwzItx/5k87ki0S2NpsDJ1wffpyqZ7u/E7tWPQuUPXCZWFaG
 8T7Z6UCegNuLkr9fV/2sd7eOECJQ7ltVc+FxGjOsQybbz5hbNnzTlU+9kYRoKeXgBxX6d
 kNsC/gaUhaY0fibWijYm6CoX3FQekflOftfPn6VCNcFEc94E8OB0EH5cUTI6iwWW7Leco
 FZpxmxiyMCszthLApk1x8CL7dhadXMV6PfrN4FJpy8f9y6cUBVKezQ+RwyqolA+aCN+7k
 NA3U8bPK6qCQSTSvsSpbNui8ynfhlLcDBKpS2qoC561IpXSh0h599mR0BQMC126EU7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linutronix.de; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=DfeKM+f+; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=OmsA4JbA; 
 arc=none smtp.remote-ip=193.142.43.55
X-Greylist: delayed 439 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 06:49:24 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DfeKM+f+; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=OmsA4JbA
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=gregor.herburger@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 391B940827
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:23 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1791441722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
 b=DfeKM+f+Nr0RQZkdC/Kne0FRUTuxdVegr/z7Ze/QwDv3Hxq23wXg8eo02Y5Pl7p+/TUOwP
 i6QLPd34Dk7yNPbZ9ArlIKKcsnWtbJtKQYFAK+EDB2QR0A+i6zT5W4NWBEYiGO8qIZ7Y19
 VFRmb9eKCVccbRSmcl5uvCTK1qz1oqlFlUgSGj+zKKgaKxDSL89uPnmNqq7tniuwujaMZK
 MBmfl3HfKojl3v7tSK3nfxiEbepPD1g/WiOHww8u38DMNRHBaExzxLKh0V7uQZSVJ5qKHg
 kv+T7CFBOzYQlv3kzeUn55FOcfRTurxsfA/YuSkUPt1jyw2WzokIxAqMCS8lJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1791441722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
 b=OmsA4JbAV0gMNYzWMa31vof2/Zk1vjiAThhghRKAxmR+BPccDxSQdhantf5GCJVUkc9chY
 dr1hBZxN17S2kMAg==
Subject: [PATCH RESEND v4 0/2] rpi: copy /chosen/bootloader node with
 properties and set boot_partition
Date: Thu, 08 Oct 2026 08:41:57 +0200
Message-Id: <20261008-tryboot2-v4-0-0ecf380c0e1c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791441722; l=1309;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=Bqiw1FfGvGVNoZub4FXVBZNHzl5LBu/cGLsw31BKZZ0=;
 b=CZOFJq9WAjSQXgw0ZRd/r+u/Ko+qxpsJa2JSA+V0rA2BSf5OoZCNt7zjVaWnHDyvNgDgAQW4r
 Ye6HMqxUy+NC5wdnu5iB6Wtv5WMbNXYV5ZwURQ8mjH4FybRKSIZhDhP
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
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

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware adds some properties in /chosen/bootloader, e.g. partition.

Pass this node through to the OS devicetree and use partition to set the
environment variable boot_partition.

Changes in v4:
- Split into two patches
- update commit messages
- Drop Reviewed-by-tag again
- Link to v3: https://patch.msgid.link/20260804-tryboot2-v3-1-b0bc282a923b@linutronix.de

Changes in v3:
- Copy the complete '/chosen/bootloader' node instead of only the
  partition property
- Link to v2: https://patch.msgid.link/20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de

Changes in v2:
- update Reviewed-by tag

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
Gregor Herburger (2):
      rpi: set boot partition from devicetree
      rpi: pass the bootloader node through to the OS devicetree

 board/raspberrypi/rpi/rpi.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260803-tryboot2-8c5221376e5a

Best regards,
--
Gregor Herburger <gregor.herburger@linutronix.de>
-- 
Gregor Herburger <gregor.herburger@linutronix.de>

