Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29746C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C30E860A40;
	Tue, 18 Aug 2026 13:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQRpiSnm66av; Tue, 18 Aug 2026 13:06:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9300660A3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058390;
	bh=VLwCHpFOia2T6NM/RfkbuVfHy6PRS1Muaac8IvZmuZs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wpu6Sz4ejecXm6G4ljxzEukdXE152YFY1G69F+9TWu1b6b+mOIRgIFjyk4BCdob8P
	 1FXQ2WdFIFCOyc2ABkfRE203pGtbRcC7DyKEIOWfnnaRqcIUeC2I/bSG7N7rKuYBTe
	 ZxI3M2TMMdYI0N+blJ1MNlyNwmHXFfQGIq8MEXkUunMCmNsJPSCE3HplMPZnZLLseu
	 WMLKyl3FUfHsxFXwV4S/OEmZ7Is4QLlf7maojllPzRi5vxCRg4unOAeEyM6Y6yK9qC
	 hPYR0L8Z+oTpOgz2w+0qAw4SkKVpl1B+19LTbLz20V8fumEajh/4Bn3yxO6ldzA9XH
	 ZyYGFGGX1ScLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9300660A3C;
	Tue, 18 Aug 2026 13:06:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63C6A23F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 08:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49F3980EB2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 08:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kdj2ZHmCa3d9 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 08:27:22 +0000 (UTC)
X-Greylist: delayed 392 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 18 Aug 2026 08:27:21 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 77D7C80BE0
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77D7C80BE0
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=UWNF0XMa
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=cincinnatust@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77D7C80BE0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:To; bh=VLwCHpFOia2T6NM/RfkbuVfHy6PRS1Muaac8IvZmuZs=;
 b=UWNF0XMahm+TDWTAXmr0xTG06l2e804m8rJIwaL3+YRRWhjZkzTLNxP2AWVEd8
 6+nsSUUH99Aqb85ggvdTFhJfLGSTnhR1GIorBqolfx73Jw7VZ4Bn/4F/G77WrgM4
 bPigqpwc0eLEuRvZLDce+WChm+u1CmFuTfijO9kxYgvrc=
Received: from localhost (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgBXj1+8FYRqG8J0LA--.62210S2;
 Tue, 18 Aug 2026 16:20:21 +0800 (CST)
From: Li Xiao <cincinnatust@163.com>
Date: Tue, 18 Aug 2026 16:20:10 +0800
Subject: [PATCH] net: airoha: fix PCS calibration retry limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-fix-airoha-pcs-calibration-retry-v1-1-5963d388c1ad@airoha.com>
X-B4-Tracking: v=1; b=H4sIALkVhGoC/yWNQQrCQAwAv1JyNrC7SKl+RTykMWsj0pZkFaX07
 13rcQ4zs4CLqTicmwVM3uo6jRXioQEeaLwL6q0ypJDa0MUjZv0gqU0D4cyOTE/tjUrV0KTYF3P
 gUw5t7mJKUDOzSXX2xeX6Z3/1D+Hy68K6btmSdl6EAAAA
X-Change-ID: 20260814-fix-airoha-pcs-calibration-retry-f0c9f06f8122
To: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Li Xiao <Li.Xiao@airoha.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787041212; l=1559;
 i=Li.Xiao@airoha.com; s=u-boot-personal; h=from:subject:message-id;
 bh=mGRpQHrRgv3prI+Q92N/kbx24kNX8yRZW4lSZyUDe44=;
 b=PVj69/q8bVxW10/Qm/JMjabbnV2ztHIA1NwGJAcx860XArUhgzab+Stb2a4LKsA9BgMerYc+P
 BTHZUiYzdstCyLeHZI0qjmhgbA5W0WmNHdgymVD9K1UeDIaRA+qYQda
X-Developer-Key: i=Li.Xiao@airoha.com; a=ed25519;
 pk=whFvj9ShD6TZ9pkt12zNUdf/oL7YL0hkDQsQ5XZzc3Y=
X-CM-TRANSID: PCgvCgBXj1+8FYRqG8J0LA--.62210S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryrtryUAw17ArWfJrWDJwb_yoW8WF4xpr
 4rAr4xJFyktF1xtw1rJw1rXFyfC3sIk34UKF18C3ZYgr1ktrZIvwsFy3WfCryqyryjgr45
 uF47Kw15Zr45XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jW-eOUUUUU=
X-Originating-IP: [58.240.122.156]
X-CM-SenderInfo: 5flquxxqqd33lvw6il2tof0z/xtbC0gUynWqEFcW-hAAA39
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

From: Li Xiao <Li.Xiao@airoha.com>

The calibration retry counter starts at zero and is incremented after
the limit check. Using a strict greater-than comparison therefore allows
one more retry than AIROHA_PCS_MAX_CALIBRATION_TRY specifies.

Use a greater-than-or-equal comparison so the function stops after the
configured number of retries.

Fixes: d4dd6eb29bda ("net: airoha: add support for Airoha PCS driver")

Signed-off-by: Li Xiao <Li.Xiao@airoha.com>
---
Fix an off-by-one condition in the Airoha AN7581 PCS calibration retry
loop. The current comparison permits one retry beyond the configured
limit.

The change was build-tested with an7581_evb_defconfig.
---
 drivers/net/airoha/pcs-an7581.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/airoha/pcs-an7581.c b/drivers/net/airoha/pcs-an7581.c
index 746ff55d72..bc15d9d07c 100644
--- a/drivers/net/airoha/pcs-an7581.c
+++ b/drivers/net/airoha/pcs-an7581.c
@@ -1321,7 +1321,7 @@ retry_calibration:
 	 */
 	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_RX_FREQDET, &val);
 	if (!(val & AIROHA_PCS_PMA_FBCK_LOCK)) {
-		if (calibration_try > AIROHA_PCS_MAX_CALIBRATION_TRY) {
+		if (calibration_try >= AIROHA_PCS_MAX_CALIBRATION_TRY) {
 			dev_err(priv->dev, "No FBCK Lock from FreqDet module after %d calibration try. PCS won't work.\n",
 				AIROHA_PCS_MAX_CALIBRATION_TRY);
 			return -EIO;

---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260814-fix-airoha-pcs-calibration-retry-f0c9f06f8122

Best regards,
--  
Li Xiao <Li.Xiao@airoha.com>

