Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA06CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99932605E7;
	Sun, 11 Oct 2026 20:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCUkWequcBFo; Sun, 11 Oct 2026 20:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF2F7605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749571;
	b=f1P+mExuOXYD4/4/jge0sZRjlPu8yHbriqoC7atVswKI3b2od1MDbMvOKsqd8MjOtXFp
	 YcltK7V4dP7Rvdc8qRxs+ycAG2JqkKbrLcJd85xFNLyWRSK1hdlu2V3uHbRoJt8Gyz29I
	 IZlNfSeWOmih9oVCd9MtUQJVYoQGKBYCsIT4g4mV90r6/IHhvrDEmD7u1ZBbYP5Ou3SM6
	 OaBlhXEQ55xqNbYhmgw3B7L6AAQvTU5j/2vj5K/uRgtRIWlI5anzVtM7/2hFOIEJ9oenP
	 tOa+rs1xkbenPSr05QmsZ09I71C6RITqryqbWEBJRIJXuEHPfyxCsNDdMalUCoGN2qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=5rsVmsxVfLNCiz35KcSNjGXSmExqpVO9/9c6srwsIs8=;
	b=GJ++FukfiBJIKLdjO4AV3CzvhciiGbkSYfG4Q9FNboZV6+jhaA/BT82jp/1sH4EGtkGz
	 qUEM4urvoiBzv6CrpGTJiDMDZl94BxwmZh70amJQDpXZC5NnwfU/PS2HeYwB5l88J7qUf
	 PRViiY8Oue0cg5yu3MIGGN7Isk84BCcHMWLtwCWi7/hlPVDDjj1VUJ5/cuZpSB7feCZ18
	 iVfWcJdd+e8hP3KaNfupdhi0b4edSPsoZ4qKIAIAHpFfPkmP8P1LNwpOpOHJpvLa1umT1
	 pLwfxt3x++lhfB3PKLnw6RCU7geja1k4ZBTWUcmjArSNzsiD1X6J9jKOxhKNgcEae4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749571;
	bh=5rsVmsxVfLNCiz35KcSNjGXSmExqpVO9/9c6srwsIs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=awqwliGHPzmfdGJV+qMqb0n4Tas5J/Tu5lbcOL1JlOD51dUZ/rAl0sdPpRlElOlpL
	 g8e+Dgld9QwODuhT2WbDI9YfqETWewVVa2oehQxoiBS9ULPTtc/mKqmoDjfRRlrFOj
	 eHjmNm6J0CefWtmHaab42nNKPC/TBkySxlTugnnOXYpI2dqj6t2Q8RdcOUHWftRxnG
	 hwGHcOZ3+SQQpJpr82Q9ZwrqGR3AXkuvy1/jeru4Es/lKtNpEsArw/tVj3lC12SzzY
	 a2dJarHyAD8dZOxLikwb4RgbuCe2Atm1ppP7TDH7q8px7edX5yy8ThX+0RJ+9XfZmn
	 LtHVghtc5xnkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2F7605ED;
	Sun, 11 Oct 2026 20:12:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AD6175
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C44C80CC2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNtlLP966Cmn for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C39D180CBF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747350;
 b=EYWmlxwy/tWvdG3KKB7C38xlr9upR+i2iGQHlgRPBgluXpd32VPrPE9iRm7XK5tL2cPc
 vDwEGh/ksMgUUaR/wARxdtXcIlSy3HB6keh9ZrAnc2geq86O96oyF/vyTOXlNlojvd3H+
 pWcjGlhMkZoh9aZsGf0xTzGE5Wz4saiG0n4t6msMCNsIe5dyYXEXGrUnmM3TYAgwMTQtv
 r/D7H8BQvirEEw+9MEojbxdC9cGAUAVFex3VMphw529UoR0mRMby8fs5vzFK3os8iFZR7
 4UOAmhBCDIX5o4EqHfqEsOYiZ92ezWNFdEjV/7peb2lg2SreCY1/DOvi8p/CHGNhSBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747350;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=5rsVmsxVfLNCiz35KcSNjGXSmExqpVO9/9c6srwsIs8=;
 b=gcgaLZdo8wh9RFnF9zFe+1NTU4DSydavL5fuLgXFUD8KjQRfOzrh4UFoMnYV8RFmjCD5
 zwCr8FdChOB+OhqdrPcWBXZAvR0RFokJqqUXHARwp8zZ4arDiEZlajySQGj7Kg7dS6Rq/
 TivS5aAT34lScpUguH5tzTUbKhsQOrucC7ejjSzrBXlSexzsAPUohZC44Hdc98ypvDC3k
 5VEfoKZezbLPArZeWhp1SuxbNwYL6y1bTCKEGIjsNDMZ3YraR9BXbKiOVxO0D9Vh3v8g5
 EBYei7buiBstymSAdTcFKAR4GNvRNkWfKa6NCIhV+jYhjiuYDhg7FVmTKFLkIh+myaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="l7r/38UH"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=l7r/38UH
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C39D180CBF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 932DD43F39;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78ADEC2BCFF;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=Gh9Z5VpayUa2pNNg1+2Jpmf1dF5spQakv82Po2If3nk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=l7r/38UHywgyVe9MTdhvcnrUssaE/KGEA3u2z/tiaWS40/HNj8jxz0IDf4dsXdQSz
 NC5vjRJIQqO7iS0dltTPhy4nbvvyaYFoonsqoI5lBhLbGNM/2UahqNP7VgLUUpHSNP
 FA2ZsasnsULltbZg2xWp/0LidVOs+L0tEfqoaDR2Wq9juLq55DTCpWK5Zdxn3YH72K
 oZC5DUWswaiWzAMnjVPuwnP1vZZYEU0t3gzzMu22rCRVsvqm9gwK9JkwYB126ST2+K
 M1BmSfDCFU/yDpfbnf0cbNuxINww+UeNDnjx5evPfS7UcJo3tQucDwav6vEJ+9GyKU
 1VC/QPzxhm/gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 68160CA9ED2;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:47 +0200
Subject: [PATCH v2 5/9] video: rockchip: dw_mipi_dsi: tolerate -ENOENT for
 the optional dphy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-5-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=1063;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=yqQu3ZnZakEUhUu0fR7+sJ78EVPikrJxnEe/ewu4lXw=;
 b=vqDW9pq9GpVHwwcnmsLEF+qMRGnesxL3E7+PEijtH8z6ohV36U3zQVUSb2WOFZ1ItgtcHBQ94
 2nFx9RKMY37DXE11kJ3VsDSD91LD9zjOdaSfIfKevGdWgslOReWZHTt
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

generic_phy_get_by_name() returns -ENOENT rather than -ENODATA for a
missing phy-names property when CONFIG_OF_LIVE is enabled. Treat both
as "no external D-PHY" as is already done for the flat tree.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index c47992dfb13..49835587aaf 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -839,7 +839,10 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
 	 * NULL if it's not initialized.
 	 */
 	ret = generic_phy_get_by_name(dev, "dphy", &priv->phy);
-	if (ret && ret != -ENODATA) {
+	/*
+	 * "No dphy specified" is optional and should be tolerated
+	 */
+	if (ret && ret != -ENODATA && ret != -ENOENT) {
 		dev_err(dev, "failed to get mipi dphy: %d\n", ret);
 		return ret;
 	}

-- 
2.55.0


