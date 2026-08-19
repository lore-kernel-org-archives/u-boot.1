Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A1AC5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 15:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C8D4057E;
	Wed, 19 Aug 2026 15:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3W7HtaxBmlej; Wed, 19 Aug 2026 15:30:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787153429;
	bh=6fpGcaN66v0gONivoFXC966UCHypSYO2K0ehiuYk8U0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ntODK+GLY8nOAz3bzrlTtxSy2v8dK4HlUquJXh2UJ+iZs0oGaLU9VNPFBl6qDwNCQ
	 QVMiMnpWuzoCUJ6pPpeKBhcOI6gDLLVGm2LjDqxmF20r6B6OAfHFjkiV3jh7ODz81J
	 T4svUMqGZlEEIsccnDq1/6xwWpYmQVmj4FMmxk8W5NMB3axFtKSBQWItmKREzXkozm
	 siI1XS2d+gKSc4wibsNnDHzuuI/V/VP+k5YfsKYrNdVxxb/+b9CG6BSLY6Jsg7dueU
	 NpKiqajQlVU1bGdiBlykA1DTmj3SWLJe5TuatljOrsJBXBHvcMZJvQNBNWlsBWEywW
	 +5YqouA93Y1dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A02674054F;
	Wed, 19 Aug 2026 15:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 413EB1460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26FB2606F4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmrFBveiqEAo for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 15:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=petko.manolov@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hNBTGnyN
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38AB9606EC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:30:26 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47362928f65so1066665f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787153425; x=1787758225;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6fpGcaN66v0gONivoFXC966UCHypSYO2K0ehiuYk8U0=;
 b=hNBTGnyNtdqP5raj8tQxBuhH+H49vA38j84Ou15q/m19d0BUx6FU+OFxT0h4TOgsPo
 gXhzm0QPEJ+ErVr31l2oe6hOA/Pi8pKcAFmMAFK5vFdRnEfo48AEy0J785JN4ADYwmJg
 LK6eHN0vNpAkNWdi/qAdufq4zioKZI6zLPPZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153425; x=1787758225;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6fpGcaN66v0gONivoFXC966UCHypSYO2K0ehiuYk8U0=;
 b=Jp5MmUruNco+JSip89jLmH7sPdWdvVgF/C5DrgB/aut+vps07ktNr3JehBJz4KcA57
 oQsD3axF4mrtdXAI17M0viQEzkGD/FO5rGS0K9me7LPrHuEzt0ijTZv28J4JFX4cH+6X
 sedmpdQzjqpRtJCy03zu2BSTDOwAk6PWoAiRttgVZJW0My8CJpzx+DA8l9+Y6Wu3WNMC
 HZS+OinDh2r4K/pQJ70ZlBNolCa1x5GZflVXz4LQEMiQRom+AtZr4MIENMg29J9zEDQx
 8ET5uUVH+gdhiVVqNCMOWXDeFfWGf5fUnrw4frgUIKJvSOrR5wefuv25wxBR+B20YhXC
 cI2A==
X-Gm-Message-State: AFuF++lQSJLy2s36ra/lSk+dWsZww68cjcZ60uKLR60N3JK6PcOX/tCR
 kSHFuJ6QHsslzamvTalVPS4E1jqX+0FPuo8WBm/JFYalYxfsXvta8GL9P/evdzXWx0IKOLPBO21
 L5cpF
X-Gm-Gg: AR+sD10etEQd8nox64JMYWNrxrSq19lvj7yyoQ7HrfrpiEOYnG56oYhrlZiqVX6ErWv
 eaqPx8gO6YNABX10diPIcWUfcsP6mdQgJ3ckTFlAfRog5+jh3GVyC/9dwpHvaJXiO0EwMC2wXcq
 jjK+jfNcSDyIxXGe6b9UPkidKEh8Y3a1Ii4vIFkgf0EjdFED1z2f0gq78nC3kzr3HvpbelAGJO9
 W+gAnxtfj6Ev/kOn+eso0DXsHRkoSYifxY8m6PAuReUIONDuKtQa3M6GDT0ImOxL5/oKxFpuP5r
 +i6nBfqw+l5cW41c2t/F5oXct+FCqk3J8OEsvofUJAfBTvOpzYsY9oeuuC/zQIS0GYD6brJTxxo
 vS88X9EiNfBK8/+0CpM3vs+S+MjYwdeVqD+4qUOnmRM6QOSNuOdSgGft4xe3PsuZhCGL5LUyHM3
 O5EmCZkxSKydxtQXfnuou0G4ZkDbfvKBinzvviuX3fxlUXi1+24uy9Z+h+TNxWp9YRBEbvbTipU
 QZP1Q==
X-Received: by 2002:a05:6000:715:b0:481:57f7:6015 with SMTP id
 ffacd0b85a97d-482b1e96130mr11393881f8f.6.1787153425115; 
 Wed, 19 Aug 2026 08:30:25 -0700 (PDT)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c85sm7143214f8f.1.2026.08.19.08.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:30:24 -0700 (PDT)
From: Petko Manolov <petko.manolov@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, festevam@gmail.com, uboot-imx@nxp.com,
 Petko Manolov <petko.manolov@konsulko.com>
Subject: [PATCH v1 0/1] arm: draeger: Add devicetrees for Draeger's M48 board.
Date: Wed, 19 Aug 2026 18:30:13 +0300
Message-ID: <20260819153014.834228-1-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Adding the device trees for “Dräger M48 on NXP i.MX6 (Q) and Intel/Altera
SoCFPGA Cyclone V” board variant.  It has both (the SoC and FPGA) on the same
carrier and they are cross-monitoring each other.

This is the first of series of patches that are supposed to upstream Draeger's
entire change-set so that eventually mainline u-boot should be able to start the
kernel.

Petko Manolov (1):
  arm: draeger: Dräger M48 on NXP i.MX6(Q) and Intel/Altera SoCFPGA
    Cyclone V devicetree.

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/imx6dl-draeger-m48.dts           |  24 ++
 arch/arm/dts/imx6q-draeger-m48.dts            |  24 ++
 arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi  |  20 +
 arch/arm/dts/imx6qdl-draeger-m48.dtsi         | 369 ++++++++++++++++++
 arch/arm/dts/imx6qp-draeger-m48.dts           |  78 ++++
 .../socfpga_cyclone5_draeger_m48-u-boot.dtsi  |  66 ++++
 arch/arm/dts/socfpga_cyclone5_draeger_m48.dts | 132 +++++++
 8 files changed, 716 insertions(+)
 create mode 100644 arch/arm/dts/imx6dl-draeger-m48.dts
 create mode 100644 arch/arm/dts/imx6q-draeger-m48.dts
 create mode 100644 arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-draeger-m48.dtsi
 create mode 100644 arch/arm/dts/imx6qp-draeger-m48.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone5_draeger_m48-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone5_draeger_m48.dts

-- 
2.47.3

