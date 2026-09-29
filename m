Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99D9CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84D8D608A8;
	Tue, 29 Sep 2026 12:53:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hs9sAyHbrrlq; Tue, 29 Sep 2026 12:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A73B360809
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686379;
	b=ZnQh3jWolzxHscJcFcyLci0LxBuP8MaqG9sikzcv80aoTN6dBEoOHSUqslG0h8bxnLZm
	 tDBhBLMB9aRspSz0M2KpIg7AVvZWUUtVWo7TIeY5G0iye3+PAio7iIEHerIIHcDxqOvit
	 pLrMSPOyPNt14uuDny2Ex6AvhsIm9uAuiuPhhx/dRJKZfV35cD5siKKbSciP9bGwOuiun
	 0Ej0/mylgnCZHDp2B/ebEyy9yVSo7GLoUo5jZQHDYy4mXBmMjp4eu2TESSyfapA6sNMz3
	 0LhxtPh0DrUN0Z2+bK2WJo0sH0qpUE2E6zG2h0mhNBlKXbrK6luhowRhDnzyB/AZrNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-Originating-IP:X-MHO-RoutePath:
	 X-MHO-User:X-Report-Abuse-To:X-Mail-Handler:CFBL-Feedback-ID:
	 CFBL-Address:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cj/HQ8KTPBVtUKOWIrt0QJcxpHEbk0SsumLzx7bXy8w=;
	b=IsSCgJs+pHmo/wol3WvfKDDfY40JgA1UQ4DoPaQxWK5LLsQb8G0eTcuQirQ6x2ElX1td
	 e+nJRvSVsFNbluR0m6f1QuXq6/0XTmzVmBB/xIuPExTI16UYmE+BG6idu4iFRGoo/hMID
	 yuK9aI4FyyPhUmBR/zrv7YCfu6QfGSmt0lmf2E0EDRzxzEudNk7jtmLxW97WL99ks3oU+
	 v/rP4NXTe3in8WjLqQGmUFiLGUsBmw6IWNB/InH4oSK4mu80hyMYNd62jqnGkVpyTsywu
	 fa2x0eI2saX6HSpdbSYtb9eCsY8Pd26YY7Cs7X5cdqz0IhS+XNHggpz1iQQjz5pX2cQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686379;
	bh=cj/HQ8KTPBVtUKOWIrt0QJcxpHEbk0SsumLzx7bXy8w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KZrr8WacH4mWwDaUo31YAMIVBrc88q/TwWDt28YXsvU06f8ILzGPSY1a8ZuhlSTVK
	 AVwQaVBBQYOO16BuV61/ImGdjeZDPZ4WFxM9l2zG2D9MYXWHy7LSYm0SlqcrQqHBPx
	 kph8MsdAW51tv5TwWNiL7pX4eUzeXGTz0QOQv13rIeJ0oUbXJNVAHp967ouIW3VFV8
	 TK6n1YKv1MXutOzGCkf4PR50CkQYtEjU3qMhBdimsMKTsNd3QAvLupT0EdweDa+1W7
	 ksR4bIEv1E9wiokSln3BKd29bqaGWdsBpQNtd6qCcspmDbq2B2qYFSeznpy7Krdm94
	 CXYXTL8uHkbrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A73B360809;
	Tue, 29 Sep 2026 12:52:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C30432A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61E7D80ADE
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lC80NpXMEkkJ for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 07:01:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F637809CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790665283;
 b=PcnHEmd0dovD0FMIIX86Xkl40Hke4kHtCqxpKE1/kCtC1HKV2ZDAU91AIB18YYs/dQcq
 FcZchIZgMmaATIyUmZmwScrWG5vWAnG+MI2Zib1+K/kScd05kOZr899EaZNMmzDLWXx7H
 fu5cEFAKGteV+aUOJX3ghuscroED0oSbi8HrY9l08zfBjD4nuSNTszUdVgQ1Nd3e6LTya
 gtVFoymDHD94FoXHhuHOGSIei9/YNUD99rcdfJ+1gzDMetbUfxGYzCd/lecF1vyi9JDZd
 d+KVrut3b96ZZcjTxKq+fYqjDsQ5Gb89I1vx+76jxMGIwFYd9YfButQJCIiiNxJf8MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790665283;
 h=X-Greylist:Received-SPF:DKIM-Signature:DKIM-Signature:
 X-Originating-IP:X-MHO-RoutePath:X-MHO-User:X-Report-Abuse-To:
 X-Mail-Handler:CFBL-Feedback-ID:CFBL-Address:Received:Received:
 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=cj/HQ8KTPBVtUKOWIrt0QJcxpHEbk0SsumLzx7bXy8w=;
 b=oll9+xH7/qyjbswGgCR2aFtJWbLy7DZ75lu9PP6malG8wucoU/8vRABKbtDwFmjFhss1
 s3nSRAk4xYqgU6d0Mi1ImZGC9R3Zl2kc+631ZTuTVDS4V5Wf/T/La7Scer/6JCnrON7tq
 zPMMQHv/cKtCDJEaStLYeuVd7gIeUtr3PQxYFujvfpoNd8y9NFoTJ0whHDc+BNx32rzAb
 aKS0pfzZkoplleDb9sXyUW81hQWSasyegZHw91JVbHhmGn4v+RCj47QAcLTVumvf53R03
 cf+IK/Ziu4mjak3qmz56JUmWj+zH0RVEGbEVv07pv8DqMYYcJ1vTErD9hIakF6R/bRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=hitachienergy.com; 
 dkim=pass header.d=hitachienergy.com header.i=@hitachienergy.com
 header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=z3PCOmXG; 
 dkim=pass header.d=outbound.mailhop.org header.i=@outbound.mailhop.org
 header.a=rsa-sha256 header.s=dkim-high header.b=sWiKNCG5; 
 arc=none smtp.remote-ip=18.158.144.38
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 29 Sep 2026 07:01:23 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=hitachienergy.com
 header.i=@hitachienergy.com header.a=rsa-sha256
 header.s=duo-1630306886989-947ac67a header.b=z3PCOmXG; 
 dkim=pass (2048-bit key,
 unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org
 header.a=rsa-sha256 header.s=dkim-high header.b=sWiKNCG5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=18.158.144.38;
 helo=out-ip0052.fra.mailhop.org;
 envelope-from=tomas.alvarez-vanoli@hitachienergy.com; receiver=<UNKNOWN> 
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F637809CE
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=cj/HQ8KTPBVtUKOWIrt0QJcxpHEbk0SsumLzx7bXy8w=;
 b=z3PCOmXGWg2hZDNOSRhxu9InBXTWLVrRmu3o8pdVzCPdqlHSWnlxsdNxQVBF3l6zdVfhCqk/2Dm9+
 KFUpapiQO+1WFM1NyeiiCxs0ktJLhPd6he4PZyxvSGl8A/LRtVKGWQqTGIYE8WyO/3+SMCe71mXpno
 HXw5p2j2Joujiolo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=cj/HQ8KTPBVtUKOWIrt0QJcxpHEbk0SsumLzx7bXy8w=;
 b=sWiKNCG5umzc1EvDZ1yenrwiVYyOmM3SJFGllccG8Q2LHcd41O56iOwxlsFrejJ1HrDz+gIhICJ2c
 WzgPySKiBwF3nolSQwNVlzCSnJveNXFrNmI36GuEzZ/lkPYD4zTc0S8StUGoQNpq2qIzfi8OZTbKy2
 vgUweUfQ6zbgVduzldDgTQ8qWHns5x9+CN5XtsZh6JqFM+hgTFT9TF7BpoSadqO8kJMi5t4Gzw7bDF
 VBGK0ANPWMGLuKUTpT6Iee0X+z5sgcaLVYz3g0udKEKXuxWHg9nzQiJequ/IYUe5PksLxygkr4eU/B
 mrquMtNhtYz0jnFmY6LgFngfJ3x0WdA==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 68ece650-bbd3-11f1-89f7-a985902e7010
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 68ece650-bbd3-11f1-89f7-a985902e7010:7
CFBL-Address: prvs=0732dada77=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 68ece650-bbd3-11f1-89f7-a985902e7010;
 Tue, 29 Sep 2026 07:00:14 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id 8A29A136B;
 Tue, 29 Sep 2026 07:00:07 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 10C6560B7D47;
 Tue, 29 Sep 2026 09:00:07 +0200 (CEST)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.u-boot-project.org
Cc: mwalle@kernel.org, peng.fan@nxp.com, trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH] spi: fsl_espi: check user's LSB_FIRST
Date: Tue, 29 Sep 2026 09:00:04 +0200
Message-ID: <20260929070004.3560005-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:49 +0000
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

This flag was ignored and always set to msb first.
Ran into this when trying to download an altera rbf from a T1040.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
---
 drivers/spi/fsl_espi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index c5bc603b5c0..80ed734e556 100644
--- a/drivers/spi/fsl_espi.c
+++ b/drivers/spi/fsl_espi.c
@@ -325,9 +325,10 @@ void espi_claim_bus(struct fsl_spi_slave *fsl, unsigned int cs)
 		out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
 			| ESPI_CSMODE_CI_INACTIVEHIGH);
 
-	/* Character bit order: msb first */
-	out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
-		| ESPI_CSMODE_REV_MSB_FIRST);
+	/* Character bit order: msb first, unless the caller asked for lsb first */
+	if (!(mode & SPI_LSB_FIRST))
+		out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
+			| ESPI_CSMODE_REV_MSB_FIRST);
 
 	/* Character length in bits, between 0x3~0xf, i.e. 4bits~16bits */
 	out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
-- 
2.47.3

