Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79523606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D+AOWBZ8;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=LK+Pc3hu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C19BC60D8D;
	Fri, 27 Nov 2026 16:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-dGaEtG3RSV; Fri, 27 Nov 2026 16:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6832160D84
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796010;
	b=XkJKO4EICa/R08GHtVaQj7Huoy1VkHRDihLZxq8r+P5VmFQelTpG6zDHmCSX0QIRlgZB
	 qlYs+38+4bRqLkis9ieYLO8MfGOPRQ/pB8UdOF+zlQSz/8jfNSEyIMtmwi75sLaY+rFzW
	 fdGexDr+YC9Az5eLDPlaYRokXPWVENkCFAMvgJ1gfno/pW4a4G3gARyoP4s8lNODsUNWa
	 MkafhXEex79x0c6tJ4Mo91IFr8ecfvN8L+WM8k2a9hWZV5vQF5J21MuBLBd8ss3YKEHxh
	 Dfh6uKN3en1bVzbJBt4BYyYVqZ4h18e03fHeoU97XNxdzJvYZXXtnWBukYaYm7VWKvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6qqs54pkX9979YrmzTEafnEsgfjIUaY5E0JuxN79yi0=;
	b=sAw6GES91+VvdnEhIofx9hcmvrG/dh3EFXQGJvrmhf4etA2XQlHA81BukiPearRuB3qM
	 llCd4XgZEYzNTSIsKabuBncX4so5ZSI6ptxJPZRnIzdw4BvB4KjyU3oOes1xLt6axZXf7
	 UU8sZPOJzo1LE0biqMeTCx6QL6aCk9FpySLc9NTXQmZ4Dr2D38yBU6eDg5IRNh6XPeeBB
	 ccB4R+Zy4lepie0gYCcs8FWOdhUN6a70jv1oisioTxt4zmCD7wOYTXN5+vVBdwk+v+X/C
	 JKm4VmDh5lqDy/b1SEU281+idBLAnDWqERywWTxwdsa1omx1/uKKFcBuk1S8GtmT/5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796010;
	bh=6qqs54pkX9979YrmzTEafnEsgfjIUaY5E0JuxN79yi0=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+AOWBZ8j07/ragsfTk4rHE/YWlaMMjWM+x5arC6okzr6HBgYZiwW0+m3ArKne1d7
	 439UNnK4VtUezF/MX7E5KrE4xEXGPRX2xDF976vQRkp70D04Prz60mUcLAZlxz4/ZJ
	 1Mc251nA18a0EIZDhJhjCxWDRLlamEAnZ3LpuPgejsPfuWzg14mUq8yB/cQdt6cyo9
	 RbDNgNyEYfbN2KckgSayNnLg8dIYoQLZMR45Fpn5ZuGbTJPB1fBiCziGQbD4JVv+t7
	 w3Ln2lxc+7IkSB81YxkKDp3ZY/Alw6wf9y8fiR1AGoKnemdsqjDRoIEzHtA2/EzsDo
	 ED3E4ZyxkKHGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6832160D84;
	Fri, 27 Nov 2026 16:13:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E167D2DF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3BE680F8B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gqqxGN0vLDzh for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 15:08:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF93481095
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=lee@jaeyeong.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=jaeyeong.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256
 header.s=protonmail2 header.b=LK+Pc3hu
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF93481095
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
 s=protonmail2; t=1795792114; x=1796051314;
 bh=6qqs54pkX9979YrmzTEafnEsgfjIUaY5E0JuxN79yi0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LK+Pc3huW/5xwYet0k05+l2K+kP2p7/OLe7zg4g2xMFckXqnJ7Ny/ghHAcNJHjKL0
 LIRPxGWt/rzfEkOkli6zmDRAYU3bog0E0raOCpI0TX3xvy4BBQmbe8JPuONQy5iFsq
 f/+RIsID65hSwms9matjip6KwyObWiaXrSYoEq1wKlT8lbS5JkBDXTkOFJgQPZ8EDW
 qvsZj3jr28Hi8DuNj1QQveNNnJF2qiWB8MeMSTxck1EmcZk4tpDyqAnSEtvfCYEqoz
 JcMU3as74xJ5JNv5eRoTmC/UldEkTB53Bq9+EN5tUw1c78qn++t94RNFBSbJsrDaKl
 DFJIo+dsUqTfQ==
Date: Fri, 27 Nov 2026 15:08:27 +0000
To: Christophe Leroy <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] serial: mpc8xx: prevent DPRAM overlap with SPI descriptors
Message-ID: <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
In-Reply-To: <179024275173.70674.16356876476594066413@proton.me>
References: <179024275173.70674.16356876476594066413@proton.me>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 932fd87bf3c62f27f9de206695b2e6cada92bb2e
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Nov 2026 16:13:27 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MPC8xx serial object starts at DPRAM offset 0x800 while the SPI
receive descriptor starts at 0x840. The serial receive buffer begins at
offset 0x14 and is followed by the one-byte transmit buffer.

Limit SYS_SMC_RXBUFLEN to 43 when MPC8XX_SPI is enabled. A value of 44
would put the transmit byte at 0x840, and larger values also overlap the
SPI descriptor with the receive buffer. Add a static assertion to keep
future layout changes from reintroducing the overlap.

Link: https://lore.kernel.org/u-boot/179024275173.70674.1635687647659406641=
3@proton.me/
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 drivers/serial/Kconfig         | 4 ++++
 drivers/serial/serial_mpc8xx.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ebc251d891..73c36ea79b0 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1201,6 +1201,7 @@ config SYS_SMC_RXBUFLEN
 =09int "Console Rx buffer length"
 =09depends on MPC8XX_CONS
 =09default 1
+=09range 1 43 if MPC8XX_SPI
 =09help
 =09  With CONFIG_SYS_SMC_RXBUFLEN it is possible to define
 =09  the maximum receive buffer length for the SMC.
@@ -1208,6 +1209,9 @@ config SYS_SMC_RXBUFLEN
 =09  If using CONFIG_SYS_SMC_RXBUFLEN also CONFIG_SYS_MAXIDLE
 =09  must be defined, to setup the maximum idle timeout for
 =09  the SMC.
+=09  When the MPC8XX SPI driver is enabled, the receive buffer is
+=09  limited so that it and the transmit byte do not overlap the
+=09  SPI buffer descriptors in dual-port RAM.
=20
 config SYS_MAXIDLE
 =09int "maximum idle timeout"
diff --git a/drivers/serial/serial_mpc8xx.c b/drivers/serial/serial_mpc8xx.=
c
index 9ce3fc3d9ec..feb0c905594 100644
--- a/drivers/serial/serial_mpc8xx.c
+++ b/drivers/serial/serial_mpc8xx.c
@@ -36,6 +36,10 @@ struct serialbuffer {
 =09uchar=09txbuf;=09/* tx buffers */
 };
=20
+static_assert(!IS_ENABLED(CONFIG_MPC8XX_SPI) ||
+=09      sizeof(struct serialbuffer) <=3D CPM_SPI_BASE - CPM_SERIAL_BASE,
+=09      "MPC8xx serial buffers overlap the SPI descriptors");
+
 static void serial_setdivisor(cpm8xx_t __iomem *cp, int baudrate)
 {
 =09int divisor =3D (gd->cpu_clk + 8 * baudrate) / 16 / baudrate;
--=20
2.43.0


