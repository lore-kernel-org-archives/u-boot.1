Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE1AC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75A1980E0E;
	Wed, 16 Sep 2026 09:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eS1U10X8BWoX; Wed, 16 Sep 2026 09:37:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BB09A80A7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551474;
	b=rHXHQkHkLDuY9ua9bRTM/u7WIfTZFxlVK8B5oKPtww2f60Y0Uz/KcAdZpl1/p+V1AMVa
	 VuhYne+njLs+DHvyKyX/e19znVYYhlQAe5FddLSE9IyufnrSMfzKg1o0wN+nvG4MFUptz
	 0tL4O/kQNgJFjEj1F7BUUGd4l1qycW5mtpa8FqcWERnu0GnNQ4F15klQXLyMGOUskF1yv
	 xBDbF9eFtkaQUNpebzmm3WmU54LK3gybSAgamjBXWOMEvYDyJ2Q+GebxFJq1Gv1zsCl2v
	 Hj1ZVtQ8R/HIzBRA8ylAkdhV+uw7suun6SCoF3LAj6w7ZJLvMI1pKkPVxeUsWJzbXaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JGUhb1912eUvwq63rCGK9pOnEDCu174+QT3ICBfkFcw=;
	b=EgI/FXDvJxo0KqiXaBB4gxodJvNPnAYzo4OnFe0yn5CFZ4mCVg6ziizVSaQszCVOyCn0
	 YbqSG7y2CzaK1qI3JqguFJO6d57SWSX76YMzgs95LobtDbGBCxV5flsM8sYI8QZuPwTO4
	 R3TzemWMiDkKs3F0plbQu0vG5bLQLdwMuPlVl5Wz55UwoPOGr8iJOK9ol46MsxdHqf489
	 B61hmAAjvA2z3i3EiVKKYU4P7pN4nj3Vqgn0Gs3CnNQzjoymgUvQzcKnBPlcA8QOPHOhk
	 Il53THUKFbkpYMv3cI+jhjF8snkL3yUaAWDZKdG2pspKuChkK6Y7j6lx75NXAP23QoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551474;
	bh=JGUhb1912eUvwq63rCGK9pOnEDCu174+QT3ICBfkFcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeUuI06U+Tezg4w9/EcPGeP2uRrubXVVSge7+CBPnToecmcEFDEahPQhJeQdmB0PU
	 osN0YRIsRc2twN5b3KTvRrHlDa+tkrCGff3hj6WjXsMKKbr++yPdGSPn31iWfPSndR
	 ZnCAs0tXp6TW/hkftO63+YyQG9ELz9rx+8AnN/j4E+LG8NjfTwacXMnYE+x/Ltdak8
	 ZrBBUvNfjrY3bBodplBrWaophRTXdwcyPOXBLUijIidgI764SMZSl4y80Ois/Jqasb
	 MRmWAfFefSNbXR/2mgoUVE+yL5AFpkCvqj9ZJSsbIpD1x2hEqmEvSGZfHzadvr+Bar
	 iNXUJPvhVFXjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB09A80A7A;
	Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD7A1224
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94160607EF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWFat9sjojAZ for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F3374607F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551473;
 b=QBLW4qiLKx7gm/zCVMjGK7Ga32B4S0DeT8QK86Y4tqnsEjGeWGmun8TREmq59DDJVFP0
 b44LmNoyrqSDccqbiH3zOe7s/O4iax3V6gEuzuoGM/4fYG2b1e7MztmKbqXa8ZyFZ65sH
 WKkpGoC+i/upntlAuvFqB53JqGMr/RIHFbxqFpUKblmCq1d13aohua42PIhtE9zcdACGk
 X4UvQ4+ISvCx1MKchm404ge2WKMemccGy6wkrtm0tsKToLaeIAEDOa3NLOFmIbVzLAFdj
 uPaoDnYZktAQiuQ3uPfNz0U2c2ikoJhd1N+Al4h8x0g8s9kQnD5V579nUQIbBQOumhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551473;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=JGUhb1912eUvwq63rCGK9pOnEDCu174+QT3ICBfkFcw=;
 b=UHWc/C+0oywWBKrELdKSVfl/GSr/fJpj1c794x+o9GNyXF5RCJk/jEvyvqjkXKYh9+JF
 wqPPekbDjUVM2xZpFBkS+yUy474ndNkWBmKFQMl0clHSQSgIBNrj8oVu25V0com9WDeRS
 5BS+1Ed8+K/3DJdZoSAL8+QppcHjWGZNXZl43X5Mgj7V1LJyeBiggJM8Nwa2V9Wv2oXkx
 BAqB+mSQmV+XoTY4M4IEcgc5A99XvTkeIMEh00dq9znmrbY3RlEcmfFf7z7zqeYyEJb5Q
 mnZqveQmdJ+0DSJJM1IzgwhxnSw8PYAn0qFzRbSLLeGOfZA32SbrBrQjcHIKt+zMCWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JxpxCLsM; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JxpxCLsM
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3374607F3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 748346053D;
 Wed, 16 Sep 2026 09:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E97B1F000FF;
 Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551470;
 bh=JGUhb1912eUvwq63rCGK9pOnEDCu174+QT3ICBfkFcw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JxpxCLsMnZdeVq+3woe885kYXLgXgwhXnvO8Gruz86KCMhNsXRoU2XapJNea/VRwB
 jjFQOvWDvOb/UpnkhuxJQp46f4sYtwhELN/EJq/83QghyJESshQqaI2F5S56d3zkPT
 9vB5CBcaETXg/+m4Fzo+MaD0SXkgOIw00lOykYowJQt5cDIGAxI8/H/bj33Zqf3OQf
 aoFnPlI8GPdvjyB5H0c7JRynwVVBsaHGOZ4XMnuAGfhVTdNipZ7xPxyV/Z3ifAtpqm
 haIoaiuNhJoh66QC6gM50dos4gSydmGUKxx46HR1EmtujH8dDYT8CRtVdZKA4CfZoP
 sajqVdNFFFagA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:38 +0200
Subject: [PATCH 6/8] mmc: arm_pl180: Read FIFO in bursts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-6-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
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

The receive loop currently polls the status register for every 32-bit
word read from the FIFO. This adds significant overhead to large data
transfers.

When a complete FIFO burst remains, wait for RXFIFOBR and read eight
words before polling the status register again. Retain the existing
word-at-a-time path for the transfer tail.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 9c18b666e4d2..5912e9d721ce 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -141,6 +141,7 @@ static int do_command(struct mmc *dev, struct mmc_cmd *cmd)
 static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 {
 	u32 *tempbuff = dest;
+	int i;
 	u64 xfercount = blkcount * blksize;
 	struct pl180_mmc_host *host = dev->priv;
 	u32 status, status_err;
@@ -150,6 +151,19 @@ static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 	status = readl(&host->base->status);
 	status_err = status & (SDI_STA_DCRCFAIL | SDI_STA_DTIMEOUT |
 			       SDI_STA_RXOVERR);
+	while (!status_err &&
+	       xfercount >= SDI_FIFO_BURST_SIZE * sizeof(u32)) {
+		if (status & SDI_STA_RXFIFOBR) {
+			for (i = 0; i < SDI_FIFO_BURST_SIZE; i++)
+				*(tempbuff + i) = readl(&host->base->fifo);
+			tempbuff += SDI_FIFO_BURST_SIZE;
+			xfercount -= SDI_FIFO_BURST_SIZE * sizeof(u32);
+		}
+		status = readl(&host->base->status);
+		status_err = status & (SDI_STA_DCRCFAIL | SDI_STA_DTIMEOUT |
+				       SDI_STA_RXOVERR);
+	}
+
 	while ((!status_err) && (xfercount >= sizeof(u32))) {
 		if (status & SDI_STA_RXDAVL) {
 			*(tempbuff) = readl(&host->base->fifo);

-- 
2.55.0

