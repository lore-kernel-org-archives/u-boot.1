Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC09CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFBF480D5C;
	Mon,  5 Oct 2026 05:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHwIUg-CdxnR; Mon,  5 Oct 2026 05:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0949580CB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177174;
	b=FCWr9+5W3P5tOn/I+zYhV7A0KQPn4lKoEnn/6icjZMbQBQi246RVpSqxDK9+vDMODy+g
	 a8hAcPKCqTjgZ+cPWbS+ZXuxQ75XuycsqGriwGAbdpyrLJLCYIiZJ9RIDzEJDkcGFj8aN
	 xHsCKcfWyNKqAixX9zkHjKngJ0LXFNabj8yT/S5qRkXofbAoKImCNE0SyHsLkq0JRglkV
	 A06nX+3dgYewTgXUrv3uUWnHRxSITme3zylK805YN3IkC7bPYKEBKScfM/UCq9Rrt0CWE
	 o+HNG7QvXVLHaaDeWUjVKI/KkTYN7lpwZVd4kjspram0u622IwliIA0/e7KGIJI2A3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=aq2GTIom6ogzrcWbSixjWBoAirTPYMBQ/Mp2yqrZBIk=;
	b=cnhwykq3T12EF//uP2ajh3kf/scDgV19TAcT0DVrnls0xenNXV6dK6C+/S0j78UvredL
	 F/pusGVWov0iW3UbCOgA4X2CAu3gvXtI+R+Tjxh15hwiYAFm2dorYHIEemckOmn8t49He
	 31YaXUphmidByCZMyf8pYESj4PPHPpndpSl50HZNzw8yg6ngRcegVtcu06pq7X3e10yLX
	 QDcYE244wX3Q03BAHS7shTh/wesbO62ygNYiW2I5GDbMHwsruUyNorltkfZBcQBVwtDdE
	 B3mrXm0SN6tVdV526qJgFbPwp/YEyVC4q52z8AnX34h9ntE8Pqk1iJWbsPNOApvvjVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177174;
	bh=aq2GTIom6ogzrcWbSixjWBoAirTPYMBQ/Mp2yqrZBIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qUldXYA0wCltpLlpseojgc6p1lahZhOR0wKU/FfiEr69sSRepwoMEYoAyY6mC2E+M
	 WKfFvJce4AKTL6RuG7JIRr/m9uDqM/wLvsBcocByh76OUCIN/DCBY7nnYhuPkbp0Q8
	 dJxiDnTEOBIQ1a8V7SfZiQBZLZpz7B3YDMkxqz7j5iVb6tL5L6bHBnDjhViqfRyElr
	 BGyTY9f9xcwLC/FP72v3AMT9k81sckB8tnPgYlAOXeXVsoJ2kq6zdH5zD9i14CvwGF
	 BW0mLRnYyDyicS6Gi2IBdB//bVAT/hRfyNj/dwDR0gcnU13+E9xzNYSPuHDGOCDgc0
	 vdTBhgF/OeF+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0949580CB2;
	Mon,  5 Oct 2026 05:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E3B02E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 446984002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-Sxdm2LfQEy for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 80E1540004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141784;
 b=VaksbO0qXf5ors2YfinBD6Yi99fIrHErKunhS2ADXqtXfA6j22AahBwwLXhIYPJHJ9c5
 Vbwa0OWyQqYLA2TUKXvsRMhYzPzdvx9E25cQeRzeRXXJ3UvYn9tL7ysWrq9LzM5BgkNwd
 BKR3omTOVLlq6uwBETP78fahtoZaIXblAVwzCYjC2/+sxM7/Q96Wdw7XPHYUYTXt6I7Uo
 HdQkTS+Ne1aMpXLxApR8y6VHXOoUH+jSSTxr0hqYrfUxAkoxTczf/0/RvoAiCf7b/z5Zf
 E1trAQhsyP+9khQR8rTn5bT8vGYmGQcGONkdVOFJbLfIbXMV/i3oCYGqgiWJzsBuKFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141784;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=aq2GTIom6ogzrcWbSixjWBoAirTPYMBQ/Mp2yqrZBIk=;
 b=ifJvinzAYzw0N39nur5cT5mToJ5tTkWQ1wi7qGjPe2AHG90JSkFQhEqOWrmoiN7QN3VZ
 j+u6EE4QN2IgT1biNon0F2PFY6I6gHUdM93D6SybZxcv4HT+9dYEnhgyotNKXOxOglLc7
 RerPkQktEOqjU7Kotv4dKDmfWRztd5BkNDHLxjBR3JsagX4E1rNu7gZP5veZf5uent4LU
 +kioxSmeZRRA92cx1o8QulDg0heM2VJyi5Ej2Pi0fE0TbQhgigmzvEbEx8QXcSb6UGCEg
 ZLKImwENxWfLBd4renRgB7tQ4XHryUzkB9Iw5Y8W7WRw8SB2JV85/pboPIqrwKXanjA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kYSPZ0xi; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=kYSPZ0xi
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80E1540004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5579D60213;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2AC2C2BCB9;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=qF4uZdiIq1mYh6PITQQXrEE8Y48yZUX6phrj8m0nB8k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kYSPZ0xib6lVkQ9vEp3F/7W3JoGMXvH14qmDN2ZkipTCStfT2GmSlW8l5x0GtMWHx
 uF6Mz3MMrsvj01AWLQgRWW1hVHAxfhSGbxv1za4rueIOnfHW0M+wK/gzXGURZCHPbV
 PssHONIGv9LD/55nhoLB8KRFyYrFitVH8kM6HFwX4J5ZFs7iAevLC3xPfwNfYnhIC6
 XBPbI0fXNSPTw1u613aiN84jzi84/knFVsfVYxwx4L8wnu1V5T7Xqp4UYhnDXDv83A
 rt3RydaR7pJbETM0l53PnH/jFB/BumWeNGE/zWCp27MR1Uyfp+bxNsbKsrVRxmUdjw
 VzMzyBAKN2dzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D0A18CA5FF9;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:35 +0200
Subject: [PATCH u-boot 3/8] ufs: program extended HS sync length for SK
 Hynix devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-3-54e71c95ba62@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=2751;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=+Ga7wnGJh3+7X1gT9+waTxAF3OMEBshDXzDZErbQz4g=;
 b=oX5AGAFhQmEhQ0p3R0VPx14L7h0507nFTUQXiq26KoalvcC0E2xcH71eThgvMacydnFgBnmqJ
 R5KEQu1E43fBUcRvxguLk9kp8jWk3ty4TXDUF35VYeJDAjixMymgDDa
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

Add the UFS_DEVICE_QUIRK_EXTEND_SYNC_LENGTH bit. SK Hynix UFS devices
on the Sony Yoshino/Tama (MSM8998 / SDM845) family need
PA_TxHsG{1,2,3}SyncLength programmed to 0x48 before the power-mode
change for a reliable HS link; without it link bring-up fails or the
device falls back to a slow PWM mode.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/ufs/ufs-uclass.c | 9 +++++++++
 drivers/ufs/ufs_quirks.h | 7 +++++++
 drivers/ufs/unipro.h     | 3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 05b95c510b4..fdf62a69c02 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1872,6 +1872,9 @@ out:
  * fw revision; UFS_ANY_VENDOR / UFS_ANY_MODEL / UFS_ANY_VER act as wildcards.
  */
 static const struct ufs_dev_quirk ufs_fixups[] = {
+	/* SK Hynix devices need an extended HS sync length */
+	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
+		UFS_DEVICE_QUIRK_EXTEND_SYNC_LENGTH),
 	/* Sony Yoshino/Tama: block PURGE/UNMAP to avoid bricking */
 	UFS_FIX_REVISION(UFS_VENDOR_SKHYNIX, UFS_MODEL_HYNIX_32GB,
 			 UFS_REVISION_HYNIX, UFS_DEVICE_QUIRK_NO_PURGE),
@@ -2108,6 +2111,12 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
 		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HSSERIES),
 			       pwr_mode->hs_rate);
 
+	if (hba->dev_quirks & UFS_DEVICE_QUIRK_EXTEND_SYNC_LENGTH) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TxHsG1SyncLength), 0x48);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TxHsG2SyncLength), 0x48);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TxHsG3SyncLength), 0x48);
+	}
+
 	ret = ufshcd_uic_change_pwr_mode(hba, pwr_mode->pwr_rx << 4 |
 					 pwr_mode->pwr_tx);
 
diff --git a/drivers/ufs/ufs_quirks.h b/drivers/ufs/ufs_quirks.h
index f5aa47722db..822315cb06d 100644
--- a/drivers/ufs/ufs_quirks.h
+++ b/drivers/ufs/ufs_quirks.h
@@ -84,4 +84,11 @@ struct ufs_dev_quirk {
  */
 #define UFS_DEVICE_QUIRK_NO_PURGE		BIT(0)
 
+/*
+ * Some SK Hynix devices on Sony Yoshino/Tama need an extended HS sync length
+ * (PA_TxHsG{1,2,3}SyncLength) programmed before the power-mode change for a
+ * reliable HS link.
+ */
+#define UFS_DEVICE_QUIRK_EXTEND_SYNC_LENGTH	BIT(1)
+
 #endif /* _UFS_QUIRKS_H */
diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
index bde1490397c..4e163da0736 100644
--- a/drivers/ufs/unipro.h
+++ b/drivers/ufs/unipro.h
@@ -118,6 +118,9 @@
 #define PA_TXGEAR		0x1568
 #define PA_TXTERMINATION	0x1569
 #define PA_HSSERIES		0x156A
+#define PA_TxHsG1SyncLength	0x1552
+#define PA_TxHsG2SyncLength	0x1554
+#define PA_TxHsG3SyncLength	0x1556
 #define PA_LEGACYDPHYESCDL	0x1570
 #define PA_PWRMODE		0x1571
 #define PA_ACTIVERXDATALANES	0x1580

-- 
2.55.0


