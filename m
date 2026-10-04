Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22028CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5D84406CE;
	Mon,  5 Oct 2026 05:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02AchrTtOp3q; Mon,  5 Oct 2026 05:12:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BEEF6406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177177;
	b=bWCGjnmu5Fgb8ABcwMkrIHUkPrQ9fPbOs4Rlm5Fmr47PIrFY3BRudfBnBkdLJ4jS3JDq
	 Uv4Ldjuc4jhE0rb8y5Tolbeoi0mQV/kX89ucxwOQjot8wTPNzf3igDAuoY7NbjAfVgxX6
	 3TUEPnYGAJPSjZM3h0VETViQQoIXf8JQUFYoQPZv/MYDyS6fkgg03Tw9pzZX/45UARsaV
	 8+pznL/4h/VfM1K+5xFdxeZj2LlHg5uhiKNWMfrZC3uBwusXPEGrFoj1nf2SWS+o9Vk3F
	 UAGSuhnsCJOluelM+JqM431LpAA6RwwwTvRlSnEjNaF5XfTLV+URlbhbaxuqqLtnmKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=4OVuGlp5LKhTTeJrumV/5lMB+HGizSDZXaXA7RPoOeU=;
	b=AZsGsCiFbBG/hGV+AIx7qxBddrVvehtdRfZc43wElAq0Sn4SXSMHesujXYMNkSiRve5o
	 enjAu+j9lb6csXSl26N0CumgoC17+lRCbHms5n1bmTr2HKYG84f6NXA7TeKL3B2Qky3Hb
	 7PZdz0xaw+rDnZt0phcOw0I04V3tPd8AcsO3hREv/ZoV/oKJDN62bi21x3dImeJTyT0cr
	 auVY1SLCNtL39yzNgB2xJL7+a6a+k1FbpEtbvc6J/DNd0KFkXfPumWxjKylmJMd+yYtF9
	 BymQXd0nwPzW2K2qh0zSZu6JenULQUgloCGAla5yebucGYyAbZ1PGUHa9yqgJV8df7g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hw7Xrvq2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177177;
	bh=4OVuGlp5LKhTTeJrumV/5lMB+HGizSDZXaXA7RPoOeU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xLsn+2lq2OhnWoh/sHHmmXkT0UYqYZUNW/y3wHVjWMnkLlKBCqWcRJWlzASuKLAjJ
	 lSY6K5Lc1XVJGdngDvejP0A58eP0hz946yoxPhZUJg2TP7xCJsW1P09JqPuuVicZVA
	 bfjxVZIQWAbos04t3E0VvlfSOGDEvFlJ3Ns8MV4FRBAVoiZOWLULCqAaXVSXl2KM5Q
	 f80PTn3OMXAubNLDGlDueqkFiDNaNLz4neSZfEzJ+82wKCqZxi7jDth15L8UInGjH2
	 Q4usaGtP6IBYUVMf/aNGudKdAHxZJhuhTS0OvSVo9kWZqckB2R80eLV8l3PSMDpzqj
	 VpbHv9/ifj1DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEEF6406C3;
	Mon,  5 Oct 2026 05:12:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E5D61A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FFC040401
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5QKQ1R1vqAVu for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B951A403FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141785;
 b=GVxTYAKxz2iiAimxPR1v8D20I76ZisBqChONSD3H4UH0MsooCWmfNaqWKK6gOBXXkzSl
 lf4uappnPXndhns6tkPZh/QYMibhyN0AljxfRmaRTxFiAnR4+74KraDs41LKH0DEJzEDD
 FYqQ1DNJZXc+QTh/0H4t3W61rDRggV16sLIhITNGnrwXyLpT2y/ZFp1FKrx4C31D4mMo4
 DrUkyB6mMlJo7OiR2z4ug3x5PvB52uIZK60err6mIa4lU7tAMLj+PyBCupDhSrR2f6GMU
 urjBYpH1J9HVC5ce9iJxK3Vh29jMt8ccw2rKHicCEXL5HDd0ZxYaXX/vU1TWREs+HMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141785;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=4OVuGlp5LKhTTeJrumV/5lMB+HGizSDZXaXA7RPoOeU=;
 b=Do1sUadLrDXZCcF0NLRWfwlHhPom8ypDqFJdvCMjitLKHQa4te6tlyEZYusN4Fy5oA/C
 2d4x4Jj7AFKX/lCs5TRC1+0n/hAc/qay1U+HlkOfdNuXkC8LQpgzBzYZvL25fOlRfDXKU
 OYrnIDUVRkxB1FUBjWLGtgds3T5xfkT2cT5ky6g+Rf3z+BIh7XOB/d3iv3EnnbkHV1GR3
 YutpGJ1dr9rro2OFsDYcMT5LaPxeZfm8R++mjUvCA/wqnMQQQKV221Tk/QsPtzjT8bKEa
 ggfXwvBixW17ylc9p2ge+Fgre5HrXEqsv9dPYspMy9lSjUt+aj+cEB8HFMK0sib37ew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Hw7Xrvq2; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Hw7Xrvq2
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B951A403FF
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 32A51601F7;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDDB4C4AF13;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141781;
 bh=a8FVHhtp1rVHBJ3swFzx1Hvrl3eIVtd6AEe9ZS0tJ9M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Hw7Xrvq2/aH+terL0r5P1/rp5u7J+OuEE0FpTFGQemIVrsAT/TP0tuBts0X4ctS4O
 W4IyYTcjJJND5K+IOOp12qTrnBSmzsuGv3Ch1d/pODVT7TS6ydP+XOCndDvUA2Boip
 oMmKfsTjzvCe79ajIdtRk8Rfdivwi9SFD5QsC/LsTwziRjGVFCJ3VPiYYTmNBKbfhy
 eBNxafi1Bvs2wLCqMLTgh5VzTrxspSj7nTPDoDP6h6yG4/1506ocvPLdqA/SwBKw2f
 1GEULfm9pKClO6ku+jp0tw1K2abroMgj50GRMyK/tmCcl6kORu5wh8uj+Ou4znYePY
 qeJJVawGww1tQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AA418CA5FEC;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:33 +0200
Subject: [PATCH u-boot 1/8] ufs: read product revision and spec version
 into ufs_dev_desc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-1-54e71c95ba62@protonmail.com>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
In-Reply-To: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 David Heidelberg <david@ixit.cz>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=2821;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=bXB1eDEhUhpzaOstVlaGh6u86QpZlwm7fwB+/VqgIwc=;
 b=vz+B/aqJbKtj4GvcPdlE6Af1kYjWEpPxXVNhlC/8imRFnXLu59uccszJbQ2b0zR95V/rxrtfV
 y+s3xagD4PpBtOd2lvlWVuXeJjUF+pZvKK8XPsV1FKUCX3qmMPiFNAC
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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

Extend ufs_get_device_desc() to also fetch the device's product revision
string (PRDCT_REV) and the UFS spec version (SPEC_VER) into struct
ufs_dev_desc.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/ufs/ufs-uclass.c | 24 ++++++++++++++++++++++++
 drivers/ufs/ufs.h        |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..56118a0ee46 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1792,6 +1792,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba,
 	int err;
 	size_t buff_len;
 	u8 model_index;
+	u8 revision_index;
 	u8 *desc_buf;
 
 	buff_len = max_t(size_t, hba->desc_size.dev_desc,
@@ -1816,7 +1817,11 @@ static int ufs_get_device_desc(struct ufs_hba *hba,
 	dev_desc->wmanufacturerid = desc_buf[DEVICE_DESC_PARAM_MANF_ID] << 8 |
 				     desc_buf[DEVICE_DESC_PARAM_MANF_ID + 1];
 
+	dev_desc->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
+				  desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
+	revision_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_REV];
 
 	/* Zero-pad entire buffer for string termination. */
 	memset(desc_buf, 0, buff_len);
@@ -1837,6 +1842,25 @@ static int ufs_get_device_desc(struct ufs_hba *hba,
 	/* Null terminate the model string */
 	dev_desc->model[MAX_MODEL_LEN] = '\0';
 
+	/* Zero-pad entire buffer for string termination. */
+	memset(desc_buf, 0, buff_len);
+
+	err = ufshcd_read_string_desc(hba, revision_index, desc_buf,
+				      QUERY_DESC_MAX_SIZE, true/*ASCII*/);
+	if (err) {
+		dev_err(hba->dev, "%s: Failed reading Product Revision. err = %d\n",
+			__func__, err);
+		goto out;
+	}
+
+	desc_buf[QUERY_DESC_MAX_SIZE] = '\0';
+	strlcpy(dev_desc->revision, (char *)(desc_buf + QUERY_DESC_HDR_SIZE),
+		min_t(u8, desc_buf[QUERY_DESC_LENGTH_OFFSET],
+		      MAX_REVISION_LEN));
+
+	/* Null terminate the revision string */
+	dev_desc->revision[MAX_REVISION_LEN] = '\0';
+
 out:
 	kfree(desc_buf);
 	return err;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..e3368a516e4 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -346,15 +346,20 @@ struct utp_upiu_rsp {
 };
 
 #define MAX_MODEL_LEN 16
+#define MAX_REVISION_LEN 4
 /**
  * ufs_dev_desc - ufs device details from the device descriptor
  *
  * @wmanufacturerid: card details
+ * @wspecversion: UFS spec version supported by the device
  * @model: card model
+ * @revision: card fw revision
  */
 struct ufs_dev_desc {
 	u16 wmanufacturerid;
+	u16 wspecversion;
 	char model[MAX_MODEL_LEN + 1];
+	char revision[MAX_REVISION_LEN + 1];
 };
 
 /* Device descriptor parameters offsets in bytes*/

-- 
2.55.0


