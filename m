Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C0FC61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE8326078C;
	Thu, 27 Aug 2026 12:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cygpOTiezqyR; Thu, 27 Aug 2026 12:31:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787833888;
	bh=RueyYHqVFHPbLdLprKnP8aFE3K3Rlqs/9nnN7UxRmuQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SZE0q+cofHQrs6Vy45jw4VHI7MT+bc8rEEsqypaFJYiSyjP18iAnejdWS8vWhPY0J
	 Xs4573d2Cp1SmrzK57vQJuFINY1E+C4f4C+SBg3wnCTjBDZ75ngmQRYsPfrSNfuehH
	 EAmoU5MDKnWZdTDBsttwSmH/OHrf/F0Wcl5J5wSZHxtchELecg1uWnPNaBvqzH1zOg
	 bCEwI9H6ahm0lAH32L4EXVC5IaFAwSR//dhyBYO8JQldcLyE/KfJeqShTvsfj8zjIk
	 Ved3zztLzpqb+Rrwv3kloyL7VWKBwxnxU7sDGcUb77aXXDP/0pYEEogm/rCzlNX60I
	 wTTea3HXcxKTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25CDE6070B;
	Thu, 27 Aug 2026 12:31:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 807403A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E4DC80D66
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 438SD_7secst for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:31:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ldTU0cGI
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F5D080D05
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:31:23 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so5324195e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787833882; x=1788438682;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RueyYHqVFHPbLdLprKnP8aFE3K3Rlqs/9nnN7UxRmuQ=;
 b=ldTU0cGIpDczNctZ2dB2mqWc1oourzrcb68g1qNfGGp/EBUh0LjiCzTOo2ZcrBor8z
 By5JVStFMRYbNvRJDC2FD6kIrvp+NiYbxPlfV6pGpYAtfbp3JDEvOswFxUkzZ147fHZ0
 Z1WL27fAaLUIfG3dh2QDPp1rEw8hwsZLfRUHcV54qUj1oQrW5dsGT9jyIYKEE0UHOHnp
 3Ufj66jF8W/8Cw6xqrd9w/QElu3jaSoOmg5+2HRb5EFoA2H9XbNF8zwm7MbvheQXPRGe
 09ZjEPab2fZRtTH2M2NNC9lFNe+4pnsQQ7mnvXrnU8GZ68Q7YyiqQ1IpvU1xXy5x3Cww
 qiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787833882; x=1788438682;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RueyYHqVFHPbLdLprKnP8aFE3K3Rlqs/9nnN7UxRmuQ=;
 b=M2mgXVSvs4YezkSx+YszUzNZCiXE7i7JArpe48eCvjHJpmKvN1+NDQ01kbu4qCn8iS
 MX8XAB3fUt9jixMlP4eqUON0XqGkujrjYI3CvqkLYUX5m2izVmf1r4NtbfMRTq6OgEHX
 3UJ51G8215QF4YN1SyBvjp4Q+KN1Hp8L/Zc5Nuwsyz+gcRH7MYAm3WFo9QaHIVX0lLLh
 2UjDMFCjvOmMWFrja6SS9WCdVt0OJrWAcVn17Upd7K3OHXAUbvoYgYNvJHI8qwm4E6wy
 gMowSjSRVE+56Rw5R6rEMmvWnRw6qMz03QmbWAvCQqdU8ukfS6CgX+eXBrpM2VvT0ajV
 MGcg==
X-Gm-Message-State: AFuF++l6ihFQdrNioxMWfova17fGqasRR7aaP2/zEkTe0WKtruToJGrA
 HYnAlcgBRo0zMuEJv9sefnfJV/4EE8/QdZfixbwDc68yWo8Tgec3i11kGJkLt2A1D5XITGA3agb
 2mgq1
X-Gm-Gg: AR+sD13G/nsU9iffmyXgc50t2LQpjOjB5v9Y3KfFJldPRcINBE42pRn28IR18cMxm2g
 wsgZKoTQ/WPjh9aM6MKqlOZpJQ0vb7/Jeu7pg2wSBlLAGSpUUSR+lA83yYNncmaDdJEmGw8Ia9o
 EGHT+BBIRT4gPGZKfhwq4Bl7Hc3QI/tJ+UN6olgWhqLIDuPuTVwe+28JAAC3kIcgHf2Sq9Es1Qa
 3pztq0YIQMXGpZP+fSGTV7V8FZrs3PnCM3mqt7QGXpBAxYqFiUU2gA/LKZfWEzjGsonb3Ev3FKJ
 CWvdkr9WqMXIn4G0gCsj0gj9exLfmKiehiBWOsTdJRcjQyEXoB/9Ey4Sks7a854CQNeWh6KAubJ
 G6ViCb+qfXzGeePzxXY21GAG0UfvrGxWYehQ3JY2BzHw4qCUKr61cYjF+651+K8d5Z6tfwmGdNp
 VVPnOjDYJCIUNarwGafOH5wSDz60n88dXOeoAfVoJN4aHJKdKfyJ+L3HazdA==
X-Received: by 2002:a05:600c:8518:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-499dc6e40acmr181040495e9.2.1787833881895; 
 Thu, 27 Aug 2026 05:31:21 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm51624635e9.1.2026.08.27.05.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:31:21 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 14:31:10 +0200
Subject: [PATCH] net: ti: cpsw: Skip disabled ports in switch binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-v1-1-764e97251ef9@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAA0ukGoC/yWNQQrCMBBFr1Jm7UBaTIxeRVzEcaIRmoRMWguld
 zfV3X98eG8F4RJY4NKtUHgOElJs0B86oJeLT8bwaAyDGoyywwnnfWGvMPJSsaYcCN141Jj8lKU
 WdiNSlg/6sGBOpQqSJauVMV6bMzRxLtzOX/R6+7NM9zdT3UuwbV+xJ94JlgAAAA==
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-c8c85066f569
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=msp@baylibre.com;
 h=from:subject:message-id; bh=N8IVt8hn6g9Zmshlb6RgiFNO4RaTatyqMweGQ1cBmSA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJeoKmnAn7Xy2dlHxB/O566aM/dvGbtfc9nVfRor7Af
 t6WX8WRHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjAR2zhGhvPdDnNvbEgx1gx6
 yGW9YMbiU4X/mg0Yw/UnWs6Iu20r28TIMGvF0i0OH22tdE/O6bjc8PCZkljynqB//l7Oikad/s4
 n2AE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

cpsw_eth_of_to_plat_switch() tries to parse ethernet-ports that are
marked disabled which breaks because phy-handle on some boards is not
set for disabled ports.

Skip disabled ports instead.

Fixes: 5bb7ae8921ee ("net: cpsw: Support new cpsw-switch DT bindings")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/ti/cpsw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 7a7cb83bd984..6b1f7764e0d3 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -1220,9 +1220,13 @@ static int cpsw_eth_of_to_plat_switch(struct udevice *dev,
 	data->mac_control = GMII_EN;
 
 	eth_ports_node = ofnode_find_subnode(dev_ofnode(dev), "ethernet-ports");
-	data->slaves = ofnode_get_child_count(eth_ports_node);
+
+	data->slaves = 0;
+	ofnode_for_each_subnode(subnode, eth_ports_node)
+		if (ofnode_is_enabled(subnode))
+			data->slaves++;
 	if (!data->slaves) {
-		pr_err("cpsw: No ethernet-ports defined\n");
+		pr_err("cpsw: No enabled ethernet-ports defined\n");
 		return -EINVAL;
 	}
 
@@ -1234,6 +1238,9 @@ static int cpsw_eth_of_to_plat_switch(struct udevice *dev,
 		struct ofnode_phandle_args args;
 		u32 port_id;
 
+		if (!ofnode_is_enabled(subnode))
+			continue;
+
 		ret = ofnode_read_u32(subnode, "reg", &port_id);
 		if (ret || !port_id || port_id > data->slaves) {
 			pr_err("cpsw: invalid or missing reg in port node\n");

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-c8c85066f569

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

