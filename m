Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D760DCA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A29C80F70;
	Sat,  3 Oct 2026 12:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nUip3NbWxe5K; Sat,  3 Oct 2026 12:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E1414810B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031680;
	b=M5b7miGf84HIF/NryM0VUosqtgFsnEzIWUR7qUKJmayLj8ds8Tg8XYbqcviLNRLAUcU4
	 BVKeRS3J+/uNMTjvIJCBHvTyKwuiuTrX2R5NdL77meaAh9sUUDSZRyEPhFwO1dwb3Kl0b
	 pe3rM0+J3lMLnZKnoNEaJeiv+njhVL9crPpXmpzwlxUjAYGXKFJYJs0SC4w3LRiwShN4g
	 bKKze7CtkuOxUEyCf8LKbaivoJaSNsVpbLFcaebJe22zTkejP2wkD8LDk3pBYkmCSSEvo
	 WZ2Gqr6hlxznrmS7Bu7Z/ED0t/wwZBK0f426aUJnB9BscDa9MbQkYXLuOgnCtDRAAFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=0W82c1akBx1E7eZ4ayJkFTbzul4AR0pNcgODrzI9qxo=;
	b=o48Ac9QdB0TfkzQuHvWbSwXX8F99N4wO/VoWC6zNRgf0GF8GKeiUUXuROP130Vd23kN6
	 vRwrnaTpvnWOGUL9arK+IwWggxzyvVujyMu9o2QP2FFfzF3ped7kye+RobK/H1pHjsFdd
	 TAMzDc/+8sTPKiuD1et/oHk+SRKy43IpihxYGlyz6tbWsoI1PI/PJRmfCB9gNmk2XSsTf
	 rMlitNqXAfckwdsJPH26l0ZzdyFrG1rGwlcysd8ziGmwBbKjvp1giTge7RtUp6VUv8res
	 TEFo0Jut/Um2hmaQQuAOO/qrvDxopjczVrEZ80pQ2KRhafc0q1WLTIpcyN4UmDCyQnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RE6aKbwN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031680;
	bh=0W82c1akBx1E7eZ4ayJkFTbzul4AR0pNcgODrzI9qxo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=DWUXdT/l5QLRUwor+0D9CLzim5JViLAtgGdhRsEnstb5XFtjdoY7hEtcx6dCZ45gz
	 HuapB9NtzNYWkyBTb5B5RIoXr5vajjkKQy3FQpTGgo56PlCm5wtlRbAtdFvpmkD/On
	 N0uOnk47IYkBKUiocy17T/8oZsQKxEKLtpGSflcpdZXm+yUdgFWZ24LboHNfWHp2Ng
	 P13tWVCAiBiMWeOtKbrUdBHX4cNYUIe1+UKwIV3vY/ShNTE2tZC4AhkgLffeydH83g
	 YQ2Z9yIVEmTwxbMpVXubBjOoMi10eo8MaEsxzqIWJJnrunMuFwP/2cQKDA2LNkOCP6
	 uNDHbEf73gnxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1414810B1;
	Sat,  3 Oct 2026 12:47:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 574C934E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48F9D811CE
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qnpVRJM-QJv for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D868811C8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791002220;
 b=CgwgzZ1kec2idpL3ltWDnNZNSNbJSMniRme91nBBNmnoEi4kCcObWWcg0aPK62Kgge0B
 /wOgWGrZ3odqusuw21jXJKcspZk1jjk3zWNxvYGIamN74D5pReThfnkOvwkxAItKLQlKk
 LRDM/j23JK0pWuZOEPs0Pgjps/X7Muk4HoylQUs7SwbiZbe25A+pTGaS+GCO+SgqQvpAX
 ozBr210oONZGVP711zS5MESO/BtyWxl5DgxhP83ysUZ5peZ9C4jtqiZpwnKVKNqSSTIc2
 Q4HXEM7M+/7ZZASHddHczoDNLNDXv2AsuzKixAKF4yk/bYwo/2/93D7axg0XzB943zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791002220;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To;
 bh=0W82c1akBx1E7eZ4ayJkFTbzul4AR0pNcgODrzI9qxo=;
 b=JuHxhGZTC8J/kZizd3/lxFcQnptrSMW/vsg5a2OzNBaj6Zmf4JNeLrDret8tADcXX2KE
 wx+9umuuA+Jvn1hWdyVNnCsQ6O0HkmRfUYjG13buHPX8W3n4FRCJJwsnWgsZCd9+XVDQR
 yZpVkH11mjF4p6Y+mMi5kL/hLqpACPKuYdELnmkWNsPmdQIJocw0FOXFJUmXOQSXQhD2o
 I7FIK0LyfW9ri9+76WViBHeG3MzIi0I/RsI2I0//ddjUcO/6iuZWMl3H2u7Zq2yJkEBVB
 wn8cKkNDLCZYpH83P592a+zjUKEtcvFskhpmGPhChtHOv5F+9FZBF60yPnfCnR/plJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RE6aKbwN; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RE6aKbwN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D868811C8
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:36:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DE11F43682;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE718C2BCB9;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791002218;
 bh=OidSXasQZk7bkSAOandgD1nP0OTio/kipKejGpilY0M=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=RE6aKbwN1Tclr1FzEw4+1MCe7sMYBClOhigzn0Fs2cRXIbmY9bnGxvunn2sythfmH
 oaHpEQTZgsoDojSGaVViqQL2IFY4Q89bvmxcQH0qvnOh46+rchy1itoqIgU2cBestl
 0kBwo5sy2k0kjnbdlNyT5furhVm2eFMUJ00tGemTAsdd0nycJ9kY+J8PaujhK+g+CZ
 fFQtY+HyZsPQWOnfAguBy7YEr9y2tClwFhB6V/cPzxgK5Qr5peC4Q7RZQobQ8j3KeW
 KmgTJ6K+WMFEbpPKlh5+N2pWi318AJTizpMDYtlGYwWY3Ycvw+q3yofAVhfhNaSB0N
 5llPYgtt23B+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEBCA5FDD;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH 0/2] ata/mvebu: set up each Armada 388 AHCI controller
Date: Sat, 03 Oct 2026 07:36:54 +0300
Message-Id: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaGwGoC/x3MQQqAIBBA0avErBvQDImuEi1Mp5xFGkoZRHdPW
 r7F/w9kSkwZxuaBRBdnjqFCtg1Yb8JGyK4aOtFpKYRC4y3jftFyYuHgYsnorJG6J6nEQFDDI9H
 K9z+d5vf9ABwKjvhkAAAA
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Aaron Williams <awilliams@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=OidSXasQZk7bkSAOandgD1nP0OTio/kipKejGpilY0M=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkH2jK6HQ4J1XP4ahzpfKF087j267zsrCOpQp7/Pv782
 bOcWTqjo5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAEzkMx8jw8HiQE6+ay0N1sp+
 B6/OSm8Rl+pO0voRX5m14+ud/dMN9jL8L/8atvJWm9Dxf6nNO2cePa74i01x5pe9HrXpvL4hXtU
 5nAA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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
Reply-To: iav@iav.lv
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Armada 388 the second AHCI controller (sata@e0000) never gets its
MBus DRAM windows: board_ahci_enable() only knows MVEBU_SATA0_BASE.
Pass the probed device to board_ahci_enable() and use its address.

Tested on Helios4 (disk on sata@e0000): scsi scan now finds the disk,
and the CRC32 of blocks read in U-Boot matches Linux. Builds: helios4,
clearfog, mvebu_db-88f3720, octeon_ebb7304, octeon_nic23. SPL SATA boot
(clearfog_sata) is not tested on hardware.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (2):
      ata: ahci_generic: pass the AHCI device to board_ahci_enable()
      arm: mvebu: set up the AHCI controller that is being probed

 arch/arm/mach-mvebu/cpu.c               |  9 ++++++---
 arch/arm/mach-mvebu/include/mach/soc.h  |  1 -
 arch/mips/mach-octeon/cpu.c             |  3 ++-
 board/Marvell/mvebu_armada-37xx/board.c |  3 ++-
 drivers/ata/ahci_generic.c              |  4 ++--
 include/ahci.h                          | 10 ++++++++++
 6 files changed, 22 insertions(+), 8 deletions(-)
---
base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
change-id: 20261003-ahci-mvebu-windows-dca164e1308e

Best regards,
-- 
Igor Velkov <iav@iav.lv>


