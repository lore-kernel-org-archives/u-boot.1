Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6EBCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26D4980DEE;
	Mon,  5 Oct 2026 05:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sp44IB3iVHNu; Mon,  5 Oct 2026 05:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B69B80DF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177182;
	b=p4ZnQnZ0s7/lUhfoWtUCIqghKTFZhn29Cn+RE6zWroYd9FApYy7CME18K63wcfVN+B+H
	 hlaRpCu4B3Jv8rStyt/ynJIU9tHFuNWbLg3DzldHk46VgerAvPdWQSzD5fsujFMVPEWOG
	 wyXtI69+CwnEwLPxoc5KI1i8YnNM/uwQO1oJamUa4SkJlhk5lq5licX8Ma+eDvS7dq1Fb
	 KEWbbaklKP7EywJo/dzgZs6bVwuIZrcncdIRDJPpxTe0HP+f+6LtPhYWk4GRLom2jDNl1
	 ifN42oqD6LtkSRC0ZehddYRvFASC8n7WA8EWLH/1gNILVc+KsZ1ATJ14IB3oDopHkBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=fMPVstNj7saFYt1ORSSqrEhSFmvyfLoA0s9dB5y3MY0=;
	b=cw3K6SOO8eeZlokTZ5WvVJeR+dZp8HobYPQr42EbE3BbEU0o7L6aNuGFzaKtAwG/axA4
	 sHQD3ZTDpFKQSIbf18xtbhSgmeHWxbfXAz3+s7a/d+3roqzYx8+rBX92TrSKgE+F+NH4T
	 by/hZzTLmTXcqiyf7NQ04Hn9bx56Ph4RKfSziBs0YyEUCiNk7ix55XFVybkgVeS42p/l3
	 xLy9iKbHX28ZMBHZAq32Dx9L5ywbTI7Tx5CqkXGpBu1la261ZDIUNrgT+dQ34svbh/DP6
	 PnhEZESzJVQOD2/G/53UmEC5uZeMG51Nx1tKykKQdheXYY9i0hQbmyzu3jFXnalR4KQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177182;
	bh=fMPVstNj7saFYt1ORSSqrEhSFmvyfLoA0s9dB5y3MY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ko1wMYpbnRcqQ7jvI13ysbojHuQvVfRd1yDq/PxdexpaioN+xZnbJg1CTvrDBYnzX
	 iTTd2WEMfIQiaw2AoPcdR8LuJtlxUb4/cwEhw5sBC/qJZftG/c06ztMQCrzZKbEE3r
	 AIXPJRSOQ74TWj4El2ZIMz2mAsu1cy/Ez3XK1NUpEbUH+YN1URWF/oqFoB9tqv5tGQ
	 yUl+7t4ncnzsM3JwRdOz9Q0r+ZsPd7seAfdEelSrlU+GpatY0+RIZHKOgfXCKx7wOq
	 NIkRSXoB2OY25moAHSuMUulYetDJCbqP/T+Aga6F8vArSrf44Mtk63JbN82ikNNIpZ
	 BfcDnv4/1mefg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B69B80DF0;
	Mon,  5 Oct 2026 05:13:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7EB2E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3D1B4040B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McTPdn0ns0Bm for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D55B2403FF
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141786;
 b=J3rUFteFU41+gUTEq3LsJaxk1Y+IO7WOcA6gcZdzCTOzRgizz3pv5Iyz3nNlJcHp1vJ6
 WgjRciNVC+5SUeG6419TkDOKu7rccQ4yDZSsrbkiI1VHaQvhuqJKjwqSJ9G11yerGt6nO
 37sQI+OZuuWg+CvWDFNw47j1dUvfNHgitSu88Hysr6cUWfo914aYQV74HM9nuOxqygs7Y
 JHQqweetC+iocZxDJxEw/8vMhLb54F6/e71rtjx2mpkwi0g+jPkEFO+M9U+NTpxN3CkRp
 jvEckiJKaV30NkOfcRaz0M4tf5TvbOYJ46oElSAOLsDeFjSxTMeUaUrg+N0BgJxaO7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141786;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=fMPVstNj7saFYt1ORSSqrEhSFmvyfLoA0s9dB5y3MY0=;
 b=b6YD12GmaG6UZvyQHUtRWhbXLPV2eKX0SvRBQW/Exy9DQlor4WkXU5WjMWSPbj1Rx6bm
 56rNxrvQplWfbfTLXVV3t5yROh7ER2WXkXjIM8+wwkmvA9rv2jM2+QLz7KaF7leLx892v
 g/MCHhTWwjHzwATq8Nik1pzA45A8bWZVRd1d4U93l0A/+NoQGoMZ/a3PHoIYTWv6Gtquk
 W8sxFMoxcWzndMJee8+G1g0qF86rUw4k41Bl2FGJOgcE3fVeNhuUE7rfPacP3/hQG6Ec9
 pJ2wwLe9EkDIBkCDc56ouD7Jfcepo3NZ91kZHSxplw9BwZVwMnzCL/C/OyWnVvV2tdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SQNv+qcN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SQNv+qcN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D55B2403FF
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9491E602C4;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62E7FC4AF13;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=agi5pQmHrh7lOtnn+j5Hl24RW5PfeP8otRDZAYOImC8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=SQNv+qcNl2mKBdkMFlRyWsB2qQN5Eg2RyrZnF4DAoW2LHEBR6KrbbagdQMeZgC7FV
 9TkxiF66bHLIlnUomp0/Pu7elQw9EBdX+IfMPWlX0tXHjMVK6y9uW/Oc1YCW3lMzge
 nNt8lcN6OmwncHvYZ7c8c9GW+M5RmoIo+6028BQ8D80EkecZ9uPUkqWGHs0QhCvIPH
 sm0hIuBP5XsdEa8xBuYbMit4hD6h51l2iKHuY7iyQ+5ryV5sp8XYvcjbt+N3KjTOX0
 gzX1IVqKFeXJQutydohiHKCIzY0gzMe/WEq7gJ553FIO62vOgKRIs0g7SrICU1soj4
 ekGu6o3c2cS7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDCECA5FE6;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:39 +0200
Subject: [PATCH u-boot 7/8] ufs: gate NO_PURGE on Sony Yoshino/Tama
 platform compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-7-54e71c95ba62@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=2690;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=RB+h74HV+WqM4nRvm4AQQuePTYX+eLSW/xgpEIOW0KE=;
 b=Hkv8P2UET3iMnZtpXLd+EXZSqmiysMauD7utCRNOUlq+PURmTtwSs/fL4uCuxTwwWLGA+7R1E
 Ir/zsn/4a/UBmoo7JR0g5sRYtonJlzWOEjYi14LBSd3mH9kN9v9fxaC
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

Apply NO_PURGE unconditionally on Sony Yoshino (msm8998) and Tama
(sdm845) phones, regardless of which UFS chip is fitted:

- Units across batches ship with a mix of Samsung, SK Hynix, and
  Toshiba UFS parts, so a single per-model quirk-table row can't
  cover the whole population.
- Those chips consistently leave iProductName and
  iProductRevisionLevel blank in the UFS device descriptor, which
  defeats the model/revision string match the quirk table relies on.
- The spec-version fallback (wspecversion < 0x210) has an off-by-one
  gap for these devices: they report UFS spec version 0x210 (UFS 2.1)
  exactly, which the strict "<" comparison doesn't catch.

Gate NO_PURGE on the DT root compatible instead, which is reliable
regardless of which UFS chip a given unit shipped with.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/ufs/ufs-uclass.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3cc4fd6bde3..f88949bffd3 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1880,6 +1880,35 @@ out:
 	return err;
 }
 
+/*
+ * Platforms whose bootloader / RPMB layout overlaps the UFS LUN0
+ * provisioning region and cannot tolerate UNMAP/PURGE.
+ * Any erase command issued against the boot LU bricks the device. The quirk
+ * has to apply regardless of which UFS supplier is fitted (Samsung, SK Hynix
+ * or Toshiba)
+ */
+static const char * const ufs_no_purge_platforms[] = {
+	/* Sony Yoshino (msm8998): XZ1 / XZ1 Compact / XZ Premium */
+	"sony,xperia-lilac",
+	"sony,xperia-maple",
+	"sony,xperia-poplar",
+	/* Sony Tama (sdm845): XZ2 / XZ2 Compact / XZ3 */
+	"sony,akari-row",
+	"sony,akatsuki-row",
+	"sony,apollo-row",
+	NULL,
+};
+
+static bool ufshcd_platform_needs_no_purge(void)
+{
+	const char * const *p;
+
+	for (p = ufs_no_purge_platforms; *p; p++)
+		if (of_machine_is_compatible(*p))
+			return true;
+	return false;
+}
+
 /*
  * UFS device quirk table. Entries are matched by manufacturer id, model and
  * fw revision; UFS_ANY_VENDOR / UFS_ANY_MODEL / UFS_ANY_VER act as wildcards.
@@ -1916,6 +1945,10 @@ static void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
 	if (dev_desc->wspecversion < UFS_PURGE_SPEC_VER)
 		hba->dev_quirks |= UFS_DEVICE_QUIRK_NO_PURGE;
 
+	/* Platform-driven NO_PURGE */
+	if (ufshcd_platform_needs_no_purge())
+		hba->dev_quirks |= UFS_DEVICE_QUIRK_NO_PURGE;
+
 	for (f = ufs_fixups; f->quirk; f++) {
 		if ((f->wmanufacturerid == dev_desc->wmanufacturerid ||
 		     f->wmanufacturerid == UFS_ANY_VENDOR) &&

-- 
2.55.0


