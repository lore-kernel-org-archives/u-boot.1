Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16ACCC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6786B607B7;
	Tue, 13 Oct 2026 16:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYZ8l9VhqOhI; Tue, 13 Oct 2026 16:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD0BA607C8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910117;
	b=EdqqTWPz2iVvUYeDLrYl9VmGAxchRhL9iXKgFZQoNk0ZkyflOPzbvXPkMqQiQE/2DdGe
	 zPP26J+ax+yRMDLQcuexECz7CMy5pbdbrDz1SkME5cyOcvHI1rwtiV6RWWHdM0PlGm1KS
	 reHe2Fyi34SHMl3+983CQTx9kZQgf2/EfgnKum+7b/v4KNJwuGGAOJXORPIFXQi5eMXrB
	 pa9o2UtO5IRe+OPZSmZdGJ8UJ6uNKIf+STkBwbCjOUyf1vAQhjNDjYcQ0sCiHtx22WeDQ
	 Wz+aRe3oOgLYy5Kg9OCbqhVU3myvhzH2oLu/G2s+v5hZ2Ks6iAfziXzydOTRcK3i2ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=OXCtHMyDrqO5I94M21EGtjf9Vk42tciHSCTisjvHhiE=;
	b=LfIafP05iuz491vivY4gy6rWq5mePc8KuKmCqTSwLWdZqddqG4RBmzTS4kXeoVgW55B5
	 leT7Mkfa3CjzFISTWgerZYTf30By4bRGxR6GDlYMPwz89CV8jxmEE9kOoMva6BmOko6ch
	 Q+EXVmRB/tUubcR41FIx6ZEXKRbr+HjwrHcqZ7dm60silvPTi5qA6Aetyne3AVWfcMzNW
	 hcAKCisVIB2ndjnd6YimeEItugzfPc+PXRYGHTLQK47M1YBXH+IwQyn3+Ky6HsOVMPcU5
	 noIP0CmkSUAZVPnAZKPbp8zLKAB9ZvkOHwHsugA0/Yhi3N0FvHc7eV2uNu3SHp5ymcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Csvbvcff;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910117;
	bh=OXCtHMyDrqO5I94M21EGtjf9Vk42tciHSCTisjvHhiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=otoTY6uPLBzXqTeDFI+NnAR3MbFu9Pl8ZuCW7b8+TogHkMDKWfO8jMy6g4f93vS+d
	 i8tWpeGVLNupcntBmaQO+6CZfVnT0dRVbbT0jxNsNacBEAzoIwjWFMNBKrI6kMW5qz
	 HE/rjwNQOiEHc3wX25+V86FytpqcOVQuxXWVO0CgTDlAaanyqFPCdAHRW4hBH+8/BV
	 IVTAxsCfi1S4n0MAmv4jTwyROZ4C4AWJWwviZWaUxEnhpe+Ux3g1G+8XvjPiMupok/
	 /7BW0YoQG0zdB5v2WoTw7X+CCCjxIzVyIaDl6U6rhPjOEPH6ISms0fXNiZECCaJ4Hd
	 yuyRaVRgeUmzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD0BA607C8;
	Tue, 13 Oct 2026 16:48:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6150A1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EE11605E5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FoACIBCU1zgn for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8CF47605D1
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791909218;
 b=iBubprotVTcUv5IRHAOdcaIzJ9B0uPIq0WYAjdHZMOJgS9g9J7paIsRLoq1OG03v/6Ti
 izSGnGtQ0N20VuMMP2YGVUUMuiEYPSbRI/cY6b3PmmUw06o4Az+Plse7w1pJfYTs0/7rI
 RrkF/VyFpKQvSElEZssX1dpAiRztk3tCzgWWpMemnH09KfGJDh8PuKkRPnhXjE9IiEJu0
 iZCJycKjJe8qMjLCP0MVfc7M3BuQyGHNS4FJt2eS878xE3ikC/fglTzwDJtqBRaWaU8ZV
 F1QULSNiKuRHf9DZUaJIGvbfb8En45/Q4CN2FwLcE/F654MgXbLQFfWBGx21wvVHEpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909218;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=OXCtHMyDrqO5I94M21EGtjf9Vk42tciHSCTisjvHhiE=;
 b=cRkzuqEPnQZFzs4thpav31I6ffH9wU7Z4TVhmyBkQOLOc33dc8FPkBx3I0giMlwTtBTs
 zB1wCbwuXbtoElMJg0ODPAMxXExMvOwmABkBf18zxDYhhnxFPTfcpR0Vr80LcmekMOMzS
 D8nppMlhpr3SsNo+WUkR/Uvs1Efyt0OxIzWMduzcxROLGITYeVJzwy5NdReX1vJLs3HZD
 LjKOdW8BXgDFC016NuJa2+VNROW4zpzibMnn2w/9yc274lpX7FyKlWLO61TKkFbLeJsoA
 pNeOwL6z0AY1/90ZIVtpRe1k1PYNh8IfUBdg7ldt8wj07QvxNjMDP8m4RfCcXkBaBPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Csvbvcff; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Csvbvcff
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CF47605D1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B8BF60A5A;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3DD0C2BCF4;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791909216;
 bh=2HtxpGkGwTHhn5Tiy5KpEtK3Qc7hN4w/f4jyBH/7vt8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=CsvbvcffHVRtUoi/Ow/rAUQiWi5tIicO6TEv7wzxuesLoUgFK0AChI7xqQQNRpNit
 zti4OnFPBzP7uTJkOW8sQGdSDeZtIcueMDwmNjffp3fIOCj1Y3n/0rDlI6Pr/HQtrH
 8WTlS1Lu7it7TeueMhx7Cv9bbSUqXnOR10UHw3gJK7Y3Lk2dN4Jwa3aYzTBPKfSkzc
 jpkXIgRmzsTQmhgFYCl7gHslFAhMiilUP+VtclxCV5qLsLuaT7kffzGdztCsNiQhUm
 aCslH4PzH3Bx7y+IDGa4Ujuv0gV+ctdZIv+sz0XfjwzrdaoPcGRa41bbhrhbOBifLG
 ysQTu6iIR3ypw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5ACC6B12;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Tue, 13 Oct 2026 18:33:31 +0200
Subject: [PATCH v3 1/4] cmd: button: factor out state printing from 'button
 list'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-button-live-monitor-v3-1-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
In-Reply-To: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791909215; l=1444;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=bn9LONCDG40YvlhDcsIDL12VyNjvg9ahKbXwl1FeHbY=;
 b=DjJYMdskvgUeuDEh9wsHrhBsk0JAdh8A1mdhPxRsFoYn3556q+qCdKHzLGdTvTTBi7InQafmH
 EvXXtoKkoPmAl1TSf+THBtLIkzQ48P3P8uJ4a2jypy9fQ33edwH5g9r
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:48:30 +0000
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

Move the per-button state printing out of list_buttons() into
show_button_status(). This prints on/off, <inactive> or Error N
without a trailing newline. 'button list' output is unchanged.

This is a preparation for a new subcommand.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/button.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/cmd/button.c b/cmd/button.c
index 3e6db3f5b8e..da1bf1f6e3b 100644
--- a/cmd/button.c
+++ b/cmd/button.c
@@ -28,10 +28,27 @@ static int show_button_state(struct udevice *dev)
 	return ret;
 }
 
+static void show_button_status(struct udevice *dev)
+{
+	int ret;
+
+	if (!device_active(dev)) {
+		puts("<inactive>");
+		return;
+	}
+
+	ret = button_get_state(dev);
+	if (ret >= BUTTON_COUNT)
+		ret = -EINVAL;
+	if (ret >= 0)
+		puts(state_label[ret]);
+	else
+		printf("Error %d", ret);
+}
+
 static int list_buttons(void)
 {
 	struct udevice *dev;
-	int ret;
 
 	for (uclass_find_first_device(UCLASS_BUTTON, &dev);
 	     dev;
@@ -41,13 +58,8 @@ static int list_buttons(void)
 		if (!plat->label)
 			continue;
 		printf("%-15s ", plat->label);
-		if (device_active(dev)) {
-			ret = show_button_state(dev);
-			if (ret < 0)
-				printf("Error %d\n", ret);
-		} else {
-			printf("<inactive>\n");
-		}
+		show_button_status(dev);
+		puts("\n");
 	}
 
 	return 0;

-- 
2.55.0


