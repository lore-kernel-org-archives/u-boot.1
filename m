Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300C7C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 08:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A4C87CBE;
	Mon, 29 Jan 2024 09:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="YC8JEi+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2B6OoxjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2383087CD2; Mon, 29 Jan 2024 09:43:25 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA69B879A0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1706517802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XIp7dfENNgtZgAlTFytqATQD3qG6GMu3gbzdWtOZZM8=;
 b=YC8JEi+nblVD4DHf8W5kUEJRLby7euKqt9MKc92R8WpaY6mipxCFqZnx48uLSRKUofNpOZ
 QU2knSx5owKMWfJ8gnjLvlSI6sNbtSECc1S/L2qak8arRq5HtiD2phPSoUFWifdFfXiVpU
 JW/KybCEpSZdL97OoYcnOS8v09mWFsLfM/Zbp0fVvLKlwYZL20+cHL36h1lW/gbUEKeZdG
 TTOQ2EKbfEnmjEQsB4om0uLwys+xPiDbEQaTKA6y+foDWiUp/r9+xU0eIuDDl1RxDYWGwI
 3C4eY5OH4PjCur4NCvK88/ZoO2Mn1cjTq7cCCSDyVy2liKbA5hRTFacv/1XGbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1706517802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XIp7dfENNgtZgAlTFytqATQD3qG6GMu3gbzdWtOZZM8=;
 b=2B6OoxjY8Q908wYTdQbvZp92TN5xBh6Sa4Z5aY1qnuPtsYIsNT2q3HBQckkT+6PdRpwJrU
 FvI9vJVcj+xSadDA==
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Torsten Duwe <duwe@suse.de>,
 Nam Cao <namcao@linutronix.de>, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/2] Add device tree nodes needed by OpenSBI on Visionfive 2
Date: Mon, 29 Jan 2024 09:43:07 +0100
Message-Id: <cover.1706517351.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series adds 2 device tree nodes. These are needed by OpenSBI to perform
reset/shutdown of the board.

v2:
  - rename "compatible" property to match the one in Linux.
  - extra clarification in commit messages.

Nam Cao (2):
  riscv: dts: jh7110: add power management unit controller node
  riscv: dts: starfive: add regulator device

 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
 arch/riscv/dts/jh7110.dtsi                       | 6 ++++++
 2 files changed, 11 insertions(+)

--=20
2.39.2

