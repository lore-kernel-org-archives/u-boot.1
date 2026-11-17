Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25B606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b2d5ogov;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SUXo19Ev;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ma6Cmz7M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB93E810CC;
	Tue, 17 Nov 2026 10:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIzZZOmCvS_k; Tue, 17 Nov 2026 10:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D96F2810B6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794910037;
	b=iFDf1QT8VD/kxKOQyfZoWVoQHLfW2Dc1x3rnvsl2QuYNh20TVb/HEVxjD/mscFNYfYJl
	 Ak3MeBg3KrLyGQ9L5hBtJo61PqdH7lsA3qRwb/7hD0gpazaUuC/0ycJgCYUILtmAYjbeH
	 qaGmwCU4xsv/FEolCJtZcdpKTvRFStMh767qcgZGaucgWGA7Kv4Q4WuYPzA+HbGEpWVk5
	 E43l2PyJ1f972XAR45vMDcEmBCM3EVn9pybvoq5zQmdrFkpeKIaoW0BmrOfBQTCt8ue0M
	 XsY5YrprXOiF46cLYAkNWY+fwbNAJo1+x05L4hr5IcJd96yIMaPHtNiZNX+saAWnt8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794910037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 From:DKIM-Signature:DKIM-Signature:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
	b=VpBzFrVfSKMle7Se2D3tXELQ3WoWTcE3WjQbLLHfwUyk8J94ardHtZ25wF7xmtuDR9ZS
	 nTy/LSYMon5BaA+9c/T4+POd1v8f3Xt1idYa4YyeRZm4Igknk3AdqgVT7rEdSsh13r3dl
	 aDnQvd7IeHDAMauwMsaytGLk2+LD4rtD1QRHAscNMEhM5C1aDWQUDlRZEqjwFg6L5RWxe
	 91PHESV06O5qY6eUX6GgNYVbV882+mmHYI8oVcsalFYrlUcrBfqRK5xuNqcvL3djLaEPm
	 UqtTpSI5muZ8gkVyaldtXPl1H0ufTXXy7tOLydSJbvcRoEGhdUeF8mVF+kyqdbNd1eA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794910037;
	bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b2d5ogovG2BIWIa1BNlFgfSizWhpo/d8NXrL2ORrrDyrjunA/QREP1NxYtuAfrQVl
	 D9gJJ3wpmS8qQ4JfukLaRPUhhYOR6h1Jtirl60AHW5EBMBr3wT1wvPG/PhcNiO71bw
	 mnItS5hY4hdeRZFyYVfXszhf/D8HCKE0eeklLnV/GM3sAAr8tnCXh61FW3PeHJxWqx
	 dyl13RLAOqKdN86GaW2mD/mVg6WSz0Qt+98s6+LU2v30MB4OczGLoC4+mOK8Gdm/XJ
	 +7g1UVA2crmQonftIpITI0hbBHKcfZlPtauEH6gutr+59Vqma/6rpsAlRyteXaL6oj
	 gvv87cW7jn2vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D96F2810B6;
	Tue, 17 Nov 2026 10:07:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39FC613C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BC0840763
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-KEnQtkOu5o for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 10:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93B644075F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=193.142.43.55
X-Greylist: delayed 434 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 10:07:11 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SUXo19Ev; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=Ma6Cmz7M
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=gregor.herburger@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93B644075F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:11 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1794909594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
 b=SUXo19Ev9QJ7PSS3axSW3MTVROpvyQuds0a7+QPg9Mg8JU9TxIODcz4FnZ2tWQTBwpvbfY
 ZQP5T56iKTuDJLnnRwst8jccLIvyhaw7MzIJQsDxQ1iY3Tc2P58WhXsqGOTZFLGD0hwLwr
 78T6hq4yL8SkaV52XMCAEZBj+q752+fpFziE+FuXqDM7tV18X2B0nUANS9O5GT5zhHeBaH
 VbCcXJ8MqiWz/L3dPtjz08R+UDauXlvk9sSOicUenaOudxtcgqfSh6byDbb/C9JbL4eseZ
 h4jQH0V9Wl2vPNUCelMF8BH7jMVwvaurwOYugCtcvJB7dChdsXYsdAFzZUKgTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1794909594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMIUATBY1utgAIAN6LOn/Oge6Zys2ZFBn2gM0PRItKE=;
 b=Ma6Cmz7MEstXiis6PN+pvR1Ptm2zjn45EvCaxCJ4LOc5M8/5jOjSTJQbZEoJl0+IT1fqH7
 R3r74r18jBLNiRDQ==
Subject: [PATCH RESEND v4 0/2] rpi: copy /chosen/bootloader node with
 properties and set boot_partition
Date: Tue, 17 Nov 2026 10:59:44 +0100
Message-Id: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794909594; l=1309;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=Bqiw1FfGvGVNoZub4FXVBZNHzl5LBu/cGLsw31BKZZ0=;
 b=jgTX97K0eaqIr5+Q2+AoEA6dLYX54l96h2SjjEBZd4ashazStcdpTCmFVjIogbTCYJZTYpAPS
 Yioe6oZwFeEBk7Vv0/oRKAjoL2Dumj3sN/jhGiGbPLDwDa2RF5J4T/E
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

