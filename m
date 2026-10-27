Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7D606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KUSiKaTH;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=VOL/AY7d;
	dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=VOL/AY7d
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A76F4606A8;
	Tue, 27 Oct 2026 19:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syIev7gRH4SB; Tue, 27 Oct 2026 19:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D232F60687
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793130186;
	b=KG6OrGtIfORwR5s4BoHvBlR+jxQ20ZUN15CHp7v706FSZfUNVYKJUTtMt+dUwLdaw12N
	 e8sZl39MFHFtjHpABoNJ38TbhedcOpT9iJNTKUUKPVYTg1LaV4LQ4Ke5+SkdNMa0UL9Wx
	 j1Dt51JaVFRlVTFFGKpTtWDAZwpVfz2Wh1iAsP3lro85RTruawgl9wpAAgdEa2rzf9TbE
	 D4Dze13oNlTCqvrVcuFEPBVpdiO2ttXlRPnBfoJht4wH2MgP3VOPxz7Rn3LAzW58NjMtz
	 Bipe9qOegVQpVY1M5daw+OkusxxOO9BmGfOm0jC6INAt1E6anfBnkNZ9De2yNhRlTiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793130186;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JZvMhX9I+pKGbZRHAZjqHhljTynSJW5p9YDYV5+mpCI=;
	b=hC8X6O+CeQEOzLXd3sMfloxD9uyNkpFpFbD6j3QtV2HF1ONdQ6eZyY3qtaGWRfnc+gd5
	 qXNRmbrB8G2k6mr84QQ7JUw/jqJoVc2bmhKbot0b0t8ABO3hAv/zXNWAjR8q42xRo6xNn
	 GmKg6k7INsQyTTyCu7uf2LV5TgAh5ne8EHtbhbGsec6TYanfExY6HCQpcGSjPPgN6tE+T
	 uab921/laRcBVdfrroL1r+gek1Nm+eRwk7iEq8kK4kWmU0xoFOW1ikyvmmKf4pA8aQLRI
	 OvUKhyEujd2utrME9ovTSvJmRPjGUNaHFxH6Gb1YsD2T5l0962gZ8UFcKrTa4VAPWXQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793130185;
	bh=JZvMhX9I+pKGbZRHAZjqHhljTynSJW5p9YDYV5+mpCI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KUSiKaTHOH93AiYKhljFo71W5EE/C/7kr+yaELJqzdx7ovWEzAZQPfcZhJvFERk8n
	 HwqoydWIiJAkScwwjZmuJwmOcodiMWrj0r8HkBg7YXFVrCA0cJa8Jwhs55t0XIcNIP
	 dINl1nx3XOZpizyGOfmpA8NL360t4fXDphqIYMZjcWslZgT+zNbJRAC7ZO/29X466s
	 3Hmg/hfbTiR13VEumzkTOX8pLWt5T1j9yX9+qoh+tSqOi0ypDanD1CCa8xFkz1Jmvd
	 uCsTadds5iSqPyUcwdw1VUthRgMMI0hPyabP1s3NyOAUam0EnsXPLnj0OhUDLKJgky
	 OwXlH8ArvoErg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D232F60687;
	Tue, 27 Oct 2026 19:43:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DB754D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8412F80A79
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WYtnw3dN5GCr for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8C8080F80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793118805;
 b=oJj9JNsuNam9c0vEHwlhZzfmRv5kEHz8LXcwCBoouf4zB52fUTJNu2FdV+9nZiJO23Ag
 yBEuk50P1wHUdOsJoywH8h8K8tj3AVTmkCkHG3BpLJZ1otbCaV4fw5p6WIgK9iJpwjKDv
 D/w69ILObs1NltMMXTd5jhVW7tnhNZ5jSpbAu0u67YE1WDgaAPkT/dU5zmfsf6Na5KH2w
 RtykkTgjHtN5Yo2712rMUtp5fJUu9QdiXDP2bIFT3wddkwV45bF0pCTU/yl5WQozP2KHZ
 Vy0d8JX+99/d0NzWfESW1R6hyPnuwCvcn+HpoTnYI7FAC9K7el3jmVBaMw39sHXTtSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793118805;
 h=Received-SPF:DKIM-Signature:Received:DKIM-Signature:Received:From:To:
 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=JZvMhX9I+pKGbZRHAZjqHhljTynSJW5p9YDYV5+mpCI=;
 b=FTPc4e+sX3Knfk1XvAnamEwfLXnvo6/a2GBKU6KvVDPx3Riq8ORVLEtT6g+qbWVBqfia
 2v08jm3YaKa5TT0Ckv/B1rv7qbNaMU8+55/xlbaK9yx+13vC/6gkdnVTAFWXVosLA9Mer
 nFHIYDlSTwR9Kw4RfinDszrS4x/KsfjiEu5cR4bOsgeqlnf6cVT33GqW9JDKX1LIb7xVx
 g4/t5nSHn0fJw31/r4lTt6gkJT7UnzOOMEi+9eblRIasA0qtpvHYzn66qIhrwpbfJ5iL+
 Z/1Y5ONoiu8xQ7glvUYfAO7MtkKO+Gkf/TxlLq69rzjD3um1LuBNETqyAb/idajIahQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b="VOL/AY7d"; 
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b="VOL/AY7d"; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=VOL/AY7d; 
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=VOL/AY7d
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8C8080F80
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793118800;
 bh=JZvMhX9I+pKGbZRHAZjqHhljTynSJW5p9YDYV5+mpCI=;
 h=From:To:Cc:Subject:Date:From;
 b=VOL/AY7dJ/7vuKd8xSXVY3WtI+TT4RdzGfQ1COPZ7wyNCsI0FIlOEo/Rp1uglT+km
 HY+/z5v8EeyFN2TuT10+ThxyMXdOlrDXBu9uMXcvUxG19nf/txhN2J6rL6Y6Fes/gA
 wG6xEOxqq07LxeJh4YAmturiHvDbF4XX5xBw4Da0uDh2GiB56TVLstGLzRm0vh3OuF
 TXYORyo48QfpaC2Qw4Q4kbmE+lRiIGN85K7JBhZqSeoZRB9mdb4jI3IfvJdPhHfv+D
 dTFf9xCOVfZAoprgknnO9AkImjgTSrj6jmvtjQzywagL6uSTn6TCC/+IzkwVDlW5wR
 U9OXHuYt2roMQ==
Received: from mx1.emlix.com (localhost [127.0.0.1])
 by mx1.emlix.com (Postfix) with ESMTP id 712735F87C;
 Tue, 27 Oct 2026 17:33:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793118800;
 bh=JZvMhX9I+pKGbZRHAZjqHhljTynSJW5p9YDYV5+mpCI=;
 h=From:To:Cc:Subject:Date:From;
 b=VOL/AY7dJ/7vuKd8xSXVY3WtI+TT4RdzGfQ1COPZ7wyNCsI0FIlOEo/Rp1uglT+km
 HY+/z5v8EeyFN2TuT10+ThxyMXdOlrDXBu9uMXcvUxG19nf/txhN2J6rL6Y6Fes/gA
 wG6xEOxqq07LxeJh4YAmturiHvDbF4XX5xBw4Da0uDh2GiB56TVLstGLzRm0vh3OuF
 TXYORyo48QfpaC2Qw4Q4kbmE+lRiIGN85K7JBhZqSeoZRB9mdb4jI3IfvJdPhHfv+D
 dTFf9xCOVfZAoprgknnO9AkImjgTSrj6jmvtjQzywagL6uSTn6TCC/+IzkwVDlW5wR
 U9OXHuYt2roMQ==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 599F75F861;
 Tue, 27 Oct 2026 17:33:20 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 1/1] tpm: use phase-specific CONFIG check in
 tpm_uclass_post_probe
Date: Tue, 27 Oct 2026 17:32:52 +0100
Message-ID: <20261027163252.378154-1-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:43:02 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CONFIG_TPM_RNG has no SPL variant. With CONFIG_SPL_TPM=y and
CONFIG_TPM_RNG=y, if a TPM is used in the SPL, device_bind_driver()
then fails with ENOENT. Thus, make TPM_RNG a phase-specific symbol.

Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 drivers/tpm/tpm-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tpm/tpm-uclass.c b/drivers/tpm/tpm-uclass.c
index 0fade2dcc0a..26cfda90ec3 100644
--- a/drivers/tpm/tpm-uclass.c
+++ b/drivers/tpm/tpm-uclass.c
@@ -156,7 +156,7 @@ static int tpm_uclass_post_probe(struct udevice *dev)
 	const char *drv = TPM_RNG_DRV_NAME;
 	struct udevice *child;
 
-	if (IS_ENABLED(CONFIG_TPM_RNG)) {
+	if (CONFIG_IS_ENABLED(TPM_RNG)) {
 		ret = device_find_first_child_by_uclass(dev, UCLASS_RNG,
 							&child);
 
-- 
2.47.3

