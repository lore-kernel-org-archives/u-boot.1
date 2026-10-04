Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E73CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9746980DB3;
	Mon,  5 Oct 2026 05:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5vFMOudc9sx; Mon,  5 Oct 2026 05:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7EB0180DB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177179;
	b=Kgqn0guHGZpO8bEOpHykP7afM1RGdgGk7bXvNUzw3NBvLsEczmx/K03oC3ya+6vTWdc5
	 CnDH8BZiYij5W8y/IA4Knt8zH85/YwKKkBefipJ1ySz9qI6LDpXqGqeg1ttJNnJwu1W5r
	 hXqR+XWPY4zcoEjYsw3A1kdJJD46fh8JCUu5XTe7cr7oeeph4ez5xN0cM15Oem8aOcthV
	 2kHbckUiVpfhVBSglkci/Htw7XFMh6KWYsaPZFtqbcL2bqhPId3JOXmH3GivSa9rW1mKL
	 17NnYdJnUWWSt5nImJtGbsnm1fVoyNjXckqKKrB7YFHYnphtuhUY5MJCa2a1iDlS3QQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=7FsZoz7fGDINiIs5+1Djr5Zyq8pulM/b2pSg7QnExe0=;
	b=pUFC7VdVxbzl4V6Piitfs8OctCJxB0Gru7m6snzyOXTmi9Xh35DpcLkK2gJ+XfasF/aa
	 0wGBqgVJOqtMBwilMbgh+XcOcwzYaAJxbP2BCkaQCs+QkkAif7hD9250HrdxrWA/fRuHa
	 4QL/eQmGB++/5rr6QnDZ/xgjCf7mMO29QzG/FoKAqkpKiXZe8BXfJliGRJe8TdNseXvPM
	 nPlu1LHT2AkwdQENsPDOfwM5SJX+pB/PtmY1PS2AC3xYuxxtCbVLkAchincVnA7ohwO0q
	 VK26+BPX7ES2jmNhYrzkXQ/hxfju4M5Rus1b/2a+rSgTajAe+dHqv2vFpEjfuMT6lig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177179;
	bh=7FsZoz7fGDINiIs5+1Djr5Zyq8pulM/b2pSg7QnExe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ie5iK9e1/ZDTIbTZ8LUl+QipvAN/hNp7zWADE9Do4ThgJpQvsYL+g4idk4Ef6cQqD
	 nTXzrOCT8dhBToHpp2fjuzMlI4W7Glq1Wbura5+8+leflObZYXouhnKD7PW2qns1DU
	 AwgRXjG3+yYSfXtjTQTep+APz2NRHVVdltRp0GSlHsnRqWenldtfeImWeGhPb+jySo
	 ch7Ns9VIRw3Ixm78XPG2Of+80qS5LsJ6xwfNF0vWvC0hWrbah/A+jwfQeyLb1TX+bc
	 ShbAms1wvkND1p6+eRWVzbsb5Ii0CUnVmuz7XtkEGMtkQdJnffp+36qEni1fbJZQfr
	 KaCTAO4ehpqUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EB0180DB4;
	Mon,  5 Oct 2026 05:12:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A8CD335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 602D04002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ulA7LDRD43KP for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9653740004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141785;
 b=krNAC9nAZd+jMz2Hp58Oz7ez85BPXfBPiwqceYcQKfG8SNa4btWzBuj4lMFyq5UqksMw
 lsMxMOhvPw0Ze2PlVhw8vrIL/JrFeEBdRraTlbM96jNy5lBATUTKUYaO6+OmIUicfihni
 vHU8P29D72u1rP1waeoLVMWqaKD895obDVhINmIJf82LeURAKtl8n4MX2ICEYBeEvooDq
 gStrLfzu7KdorKNj/7UtgmUM/wYyo7W41ms9W3+2rUIMrzNPKS1xxr7LxE9VVoJTH0PNJ
 of8whOShiYXghObCdKzVOg0IR470fMEJFloVR+1muPff88K4Tnj6WkQJJefgfn9pQaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141785;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=7FsZoz7fGDINiIs5+1Djr5Zyq8pulM/b2pSg7QnExe0=;
 b=odo3+iF3hUeG5UPdUHeBuKRkH3DkulYk2aZ4V0ppociaw6YCnw1DcyIQb9FFlzYigymK
 VsyUcvf3U/QOZ2lEhBKDhUSNQGSnIKB+6W4yye60F8JCquIHBjdeicH+TU1VkfOYx58nG
 pgmqth2sIhs5P51XzAmoSLqtUWh6RBI2frz0YX05PmFcWURGydWdmYdIodCNta/z2u2Oq
 ymffq1c1HzAEXEwE0H9ofdm8pTB7MsfPkTPt123qhP10L7F+zSPHQGvf2IcseC6YYTJRP
 /o0YK23XCJS6v71IcsGSBzalkStrScbcrwK4uUtcmb5RH+uoEEHy8hfejhNdqO3taBw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tZdcQyjI; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tZdcQyjI
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9653740004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 815D7602C2;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5095AC2BCF4;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=LPusF6nxf9q9GQoj7NqqpTfEyjtwTWRw+jorOBjvwEc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tZdcQyjInHtMjb43Hqsy+T6Oj0Few/R7dTE/YIdxE7nY+un/e2zj4OBixxZseaVQg
 AxmYhk6rjB7UmHnnduF5lTvpmuZOQ7UmGaeipAZA8O+DPqVg2pz70xYmiR80afLgFI
 LedfNEcf0mUO2V27sV2vaKoludEF4vjBt11sqMtQvbMvjXtpVuyc6J7brtDWxxIeHd
 utTPOC4dwwfXVsyvI7VSEfeNbo4dsTurOhno1f/xYs5jCDMPOYpcehVrsSK1qOWaeE
 2F+bzEA0Nt59cbIVLFXgSbyDjWnHwIUUhK8/erAdMPuY0LskTwuUZVZm+X4b5dSWWf
 BXO3NMiCgEBfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3D73BCA5FCE;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:38 +0200
Subject: [PATCH u-boot 6/8] ufs: print device information at probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-6-54e71c95ba62@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=2712;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=QupSv/OYoIZpSqpoakOWBMqt+riZ+H1acPCcpQ7fYWU=;
 b=8TDvnoydVNdNrlVekS+dkYI73k3h6e08pzwHj3ozFFdFGngrUHAEyZbLVaB4gyppVQNcA/jQA
 +y+wAf6zCmeAd7BnTvYuPw5EF28WIkxo+rAwJwkJQLKBG8Em0ljoxDS
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

Dump the key UFS device properties (manufacturer, model, fw revision,
spec version, negotiated gear/lane/power, and the applied device quirks)
at the end of ufs_start().

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/ufs/ufs-uclass.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 7dfba3ac1ac..3cc4fd6bde3 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2218,6 +2218,58 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
+/* Map a JEDEC UFS manufacturer id to a human-readable vendor name */
+static const char *ufshcd_vendor_name(u16 mid)
+{
+	switch (mid) {
+	case UFS_VENDOR_TOSHIBA:	return "Toshiba/Kioxia";
+	case UFS_VENDOR_SAMSUNG:	return "Samsung";
+	case UFS_VENDOR_SKHYNIX:	return "SK Hynix";
+	case UFS_VENDOR_MICRON:		return "Micron";
+	case UFS_VENDOR_WDC:		return "Western Digital";
+	default:			return NULL;
+	}
+}
+
+static void ufshcd_rtrim(char *s)
+{
+	size_t n = strlen(s);
+
+	while (n && s[n - 1] == ' ')
+		s[--n] = '\0';
+}
+
+static void ufshcd_print_dev_info(struct ufs_hba *hba,
+				  struct ufs_dev_desc *card)
+{
+	const char *vendor = ufshcd_vendor_name(card->wmanufacturerid);
+
+	ufshcd_rtrim(card->model);
+	ufshcd_rtrim(card->revision);
+
+	printf("UFS Device Information (%s)\n", hba->dev->name);
+	if (vendor)
+		printf("  Manufacturer:    %s (0x%04x)\n", vendor,
+		       card->wmanufacturerid);
+	else
+		printf("  Manufacturer ID: 0x%04x\n", card->wmanufacturerid);
+	printf("  Model:           %s\n",
+	       card->model[0] ? card->model : "(unset)");
+	printf("  Revision:        %s\n",
+	       card->revision[0] ? card->revision : "(unset)");
+	printf("  Spec Version:    0x%04x\n", card->wspecversion);
+	printf("  Gear  - RX: %u, TX: %u\n",
+	       hba->pwr_info.gear_rx, hba->pwr_info.gear_tx);
+	printf("  Lane  - RX: %u, TX: %u\n",
+	       hba->pwr_info.lane_rx, hba->pwr_info.lane_tx);
+	printf("  Power - RX: %u, TX: %u, HS rate: %u\n",
+	       hba->pwr_info.pwr_rx, hba->pwr_info.pwr_tx,
+	       hba->pwr_info.hs_rate);
+	printf("  Device Quirks:   0x%08x\n", hba->dev_quirks);
+	printf("  NO_PURGE Quirk:  %s\n",
+	       (hba->dev_quirks & UFS_DEVICE_QUIRK_NO_PURGE) ? "Yes" : "No");
+}
+
 static int ufs_start(struct ufs_hba *hba)
 {
 	struct ufs_dev_desc card = {0};
@@ -2268,6 +2320,8 @@ static int ufs_start(struct ufs_hba *hba)
 		ufshcd_print_pwr_info(hba);
 	}
 
+	ufshcd_print_dev_info(hba, &card);
+
 	return 0;
 }
 

-- 
2.55.0


