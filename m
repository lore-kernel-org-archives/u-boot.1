Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E5BC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32AC28085C;
	Wed, 16 Sep 2026 09:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVRjg_WvAFc2; Wed, 16 Sep 2026 09:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5B978807B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551460;
	b=nbBUb0+N8xeipVVbCw8EuioArf/vEWnabeeHpS4UGDcx8CchMxgaQcZwvR24IawT5l9v
	 1OKiToaLS3x6c0HziS77SNrEJOMkJzw7aEPqt78DH46/jg9v/+pRWL+RvEAznutmUwT9o
	 O3xPks88txIsznTkeuJnHV9MNf0A1/QaZfB0lLDjsHbQ2aXZ6OT5JYFfP3X8k5LtMaVfd
	 gucLf0QKucE3a9mL4AWe8dWMKk45SEiQa1QaVGq+nZIz5tD1ygxPHXhFzXosPdpymzcTI
	 Vuq/+91Gv2eYybvMLZD+BVEYWEFI0gBkibAhbjT4Fejv0qpL2QLFhITfPvo0eLIQLMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9SWTfUD1zer++nzvsnpA5dy+r7hN7APkyZVLz+5X4Zs=;
	b=AnWkCTyn6bZuFTxAZlwmOexvu9ix3PpsbQp+mgl3n9wes2cr2/mHN9bcnvfq7Ojw0yKs
	 u3B1gWYQDAz/DQxHbAG+Na2DCsvfV7bdcByJ7ckhRCcr30m71wnnBNUw3AVGlZB0YMBq7
	 bd0ELxUJ7AEEIoVoMTP+Ujh+DHrDdVoFXHxM/8f4yGWfs6hbqyrgbE0K8wXIy/Ox8vOow
	 kgF02J1pAY3ouOs9WvNHrJmuj8NkK07h6YtIlfRaPfx9dtLnFQOGjCHseo9PAwe83Ox/o
	 uyTm9RAkndAIom/QS6NKzsaTidpr7eK3U8/s5wzCQCPXR0hd8ExY+SwnddqQQymwKCA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551460;
	bh=9SWTfUD1zer++nzvsnpA5dy+r7hN7APkyZVLz+5X4Zs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FhsTKXCMQGXY3tbU/uD5m4vRpEI02F5OB64bAKsn8YoL/l7XwrxKkp+QFAWDJru73
	 d62tlFqLhV86v8vuZxcOoNgkoCM1Q38hio8NHD4Fnhldn7hYMTmT2t0dE7B7/71I1k
	 gxU6kKEqIDbdIAhUt8FAGdICXVN4BHR7UkAVj6GSF5O6+G1RgImvGTxmS24Bk/8Jj0
	 HvTa5DpuccGlEwK0s2eq8Fjs7AaxPDJFF9mOy/Zjin8zoFoYXyRzOH5Gtf+BF+2JNR
	 jNGdMd9xDhpY75ng8kxe4D1StP5Ow7UVzK8wvTJkCIkDy7eLDyHSP9vv8f0FP2260b
	 PDhK7JXBx5b+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B978807B3;
	Wed, 16 Sep 2026 09:37:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43EF32E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 359D6607EF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9x0OW9nKSKr for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DEE5605A7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551458;
 b=kYISdWJh6Sk6zNhti/vf3whR495f45O+f530F/e5q0N4HHYkRTBNr2UKMwZJ02JnGZ3D
 FlNGFpnOaWnT6KUyZgl+UTCs3TiAG0yDevqeq6gioOIGC8kj3vo8Ac/cy2oxLhLxubPFM
 UxYBlpx3uDAuiyM0md0QhT683j1gjFDs7v5KwS4BxNuDwOofywghjs3OJgfydb/enHR6l
 jnwSrVwIBNDTL4Zx1DglOV+Ep4sJm7BiC9Rk4J3PRcoDBEG6ucTp6bnx/IuHnJH/xQIrH
 NRZvtJuIf90aZw5lxaYg1vZf5fFCWEcLO4iM8POx+enDpI1gg8/qtmf27otPsbiLMxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551458;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=9SWTfUD1zer++nzvsnpA5dy+r7hN7APkyZVLz+5X4Zs=;
 b=ekZQQUt0+sTkNbhVmEmvf7imBBLLexr45HAFyfbLQjxw++jll0EBcjxcHLEWotoBUd9Q
 9e4w7NgwzxnYJbKk9zwAaN/Xt0/Y8KC/b0Cm8aiyclMMPdNOGlnUS/xWsrB5e2w/AJmFs
 9KYe4hN2oMyjaf3VSfvNMcOI7gu/AgFk7Q7QtFza0JH/KSCan4TZV6aWPaPVmjRzga0ma
 9yonRMwJYpLSf158AkPjReBc+uEho83spQ3FtJ8Poq/ZYguaC3AOnd01jCh51PhHFEpm2
 XsGzWeAXQd04WhF+6MKdOtpgA62xGBam1ehksH/rUoxiOB0zlUBWRA5uEbqkjT1Oaag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aoYSBbd7; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aoYSBbd7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DEE5605A7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FB5544003;
 Wed, 16 Sep 2026 09:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A627B1F000FF;
 Wed, 16 Sep 2026 09:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551457;
 bh=9SWTfUD1zer++nzvsnpA5dy+r7hN7APkyZVLz+5X4Zs=;
 h=From:Subject:Date:To:Cc;
 b=aoYSBbd7iZTkxfBh4yWDiF0pJ5JPppmY6YWjeRqrp+Zt5UK9JjKGYpNPI2yRCiq6J
 VM1orw2S9c83vBJbigqxFMGQbIsIkbEeeKAzqc0nLdTcXHw5eVRJOZqwxm31+QLPfg
 QeVThGysFWBkGRxZTpYForkuppGAhyG9S++eoJLdHkDLy/hkroxJB5SUjUPoL77bV0
 wJ1w8QD5idClKple1EXsTr57yVJ8ZHuPKHbfF4Qpz/nZH2j9bYKHhAOI38ty5hh3O9
 BVGNnxLIOfHmbLqzKmoGBrZdE8X/78pnC+MY0pHbZ0mdN/JC9ExbDz+VpXgMHwsNN1
 25GzJAav577Ug==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/8] mmc: arm_pl180: Improve clocks, supplies and PIO
Date: Wed, 16 Sep 2026 11:37:32 +0200
Message-Id: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBsYIyy7SrSonGogTTQiiO6et
 HyL/x9IHIUTdMUDkS9JcvgMVRYwb6NfGcVmQ0WVJqM0Ojdj2FVLKC7E42LH/kxo68aQJaMnPUG
 OQ+RF7n/cD+/7AXX4gxdoAAAA
X-Change-ID: 20260916-mmc-pl180-improvements-d4790d096b6b
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

I'm splitting out the PL180 MMCI improvements from my other series
so we can merge it as a separate topic.

Configure Ux500 signal direction, gate idle card clocks, set optional
VMMC and VQMMC supplies, and turn them off before OS handoff.

Add a regulator clamp callback for supplies with discrete voltage
selectors.

Keep hardware power-save clock gating enabled; Ux500 testing showed that
continuously clocking both initialized hosts can hang external SD access.

Reduce PIO overhead by transferring FIFO bursts with bulk accessors and
using the FIFO size of each supported variant.

The Ux500-specific behavior and PIO changes were boot-tested on Samsung
Ux500 devices with external SD and eMMC hosts active.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (8):
      mmc: arm_pl180: Configure Ux500 signal direction
      mmc: arm_pl180: Gate idle card clocks
      power: regulator: Add driver voltage clamp callback
      mmc: arm_pl180: Set initial supply voltages
      mmc: arm_pl180: Power down card supplies at OS handoff
      mmc: arm_pl180: Read FIFO in bursts
      mmc: arm_pl180: Use bulk FIFO accessors
      mmc: arm_pl180: Use variant FIFO sizes

 drivers/mmc/arm_pl180_mmci.c               | 145 +++++++++++++++++++++++++----
 drivers/mmc/arm_pl180_mmci.h               |   7 +-
 drivers/power/regulator/regulator-uclass.c |   2 +
 include/power/regulator.h                  |   6 ++
 4 files changed, 142 insertions(+), 18 deletions(-)
---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
change-id: 20260916-mmc-pl180-improvements-d4790d096b6b

Best regards,
--  
Linus Walleij <linusw@kernel.org>

