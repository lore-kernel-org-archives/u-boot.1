Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836ABC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43B2A60BCB;
	Thu,  3 Sep 2026 22:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6LkeCCM4twj; Thu,  3 Sep 2026 22:13:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7302360BC5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473630;
	b=WLkhDufZ3K8L6uzm/xdBHa3VrXq2fJmuq+JqlegVUuc26GqGkCFYQScvzBDw3cgkfYAW
	 l9WhsY+QRfvIdRO8fcgIkA4DGmJCbQ00KAjhGm6QdupK5NZbpz0PzQu4cAdmh7ZphWTTA
	 GOpqYJ4AIuZsZMdhS5xeIi4kJ2j7WF+yNaZIaSqGDeQGJ2SG2LH5ZrTk8wgl5nBKPv2lN
	 D+f3CGqIH+kLAF/XvzKW+qk9zn2jHzCSPCsWP/Iro1tLEltOk20NVZKF5JzXi1HOmYMv8
	 R+GlVfi7VMeU1SCqFG5HHqhXq2jpRP5fpRNqZOLox5xwnFxnYTn1yslvNmpi83wwQqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K0yBS9K69huxIMJf39nZPczo7zAoMB+KmES6bL8eDOg=;
	b=oYzNP4abnzaHgl8OCl3REdGzNQMw4YtCaxDL39AiCrAg274ajbQhN0oKcZCe9MW79dth
	 0IGeSFCLxKQZ0nS7rxnxczJPYPcOBfrmstGKipWMIVYuRUSp8m8lMja3cK6cPy9fIzHMC
	 /Dz+Ig+SipKccDLQ5wEutZnvfwzNBsX04NLhQRH8WfCxxv2vh3VTRB8JBMvXbe2bAcDwz
	 GPMh+plpFp50J1TZI4GMn3yMwO0sFfPmQ4O1ZkRWmu0rbdrH3FcL0HMorNqjPORGtfVee
	 hnrveycAe0uk/DFA+lyHekp3LBsU1F1QFpGprIHrrExFjLa1rw+gJHDt87YyUb3II4A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473630;
	bh=K0yBS9K69huxIMJf39nZPczo7zAoMB+KmES6bL8eDOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+KYseNS9K7mx3rs5nqqlUK2r1y4fPg0O4b8P7Jc2cBqfeaMyIvc8zsHW3RTBSNTh
	 rO4E+9OwiyJw79GPmYOH9tgnBhkyNEb1CcMd8T18CyWZXe2DZOZxWi+U63Brqz+dcN
	 WOs/FAmNti6KrdHBVETL8wkP85J0WTtoGROvgZ6T2E6M2D0x6AEY+eoj6rxIIZmgxL
	 V1S6Q+pzXNA+jClTyCkjHiVCqwxutMuA+MhAm/Ff4501Tx2C9CLgPsSVRI1S2NzLtW
	 mqEpBiV3J4TOggmwnjCA2Qgbjmh9sxx6LDI2qwVYxf+ocX7dR04S4sLvZkyPxbZM/X
	 UqvfMKiEjORwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7302360BC5;
	Thu,  3 Sep 2026 22:13:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BE172FC
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1207B400D0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5O8QRa1OhLM for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5203640029
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471499;
 b=n9X7NRWHhU8H+hIKms1oL9n0bZe/Fj9EkG1oS8NACDrBDoHVrvkdcwWK5Iw3QhVIIHTR
 aOoX9iSbc79g1r+antDIp3S4XklmIzX+cXi8F7y9mVLj6QmPcjLWy9PF6imGCW+H+C36f
 24/CImKs4kClP0pd4S2LrL3o0YwCAyNa2xml4EYDo18dXe+m7SokYJ6PWZfkaXqeRqCTI
 ZWttt4s2+KWFUtKhNBIhWCt1qOnDebMkzN6aXSYJf+Fx+2Yny6pDnSjTSLPYKDtwJlutr
 qlDaJXYnFSGmnSZ/KAkQfFQxxVqoE3sPKz8cUj8JUXWgn2H6gxBtBhXVIxcoRumr5hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471499;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=K0yBS9K69huxIMJf39nZPczo7zAoMB+KmES6bL8eDOg=;
 b=ABu/vThzUZqJumQCVfrjrVSzubmqBFCb+aOVvsIqm2vv2zFS9QCZgokxr+tXIVUDAkSp
 0g/kSyhWS4LSsaO1ARu4oJ+atq+M7kxVP5BZQcOI6csn2f7JkrXK6hruL+umlzVXSyZfb
 FF3qkmgcx81NHwmOFJ1mr/h3c3dJzcsugr8tsDk/waUmALvhY/7UA9DGSrBlaJHWM13Hu
 ITAlcrwHYkM5XO3kBYv01RNgfvBfC9LQd8Zvu8OW26yPG32b4uUBRvg2EwvJuZGyK39M5
 ZRwU2amHpROyizTRZnck0skVmev8HN61k43dGCFNBEFtZfOWs//0kgL49YzznfuGSkQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Zo9qCRTL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Zo9qCRTL
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5203640029
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:18 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-499f6e0bbabso271219b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471498; x=1789076298;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0yBS9K69huxIMJf39nZPczo7zAoMB+KmES6bL8eDOg=;
 b=Zo9qCRTLCXHZ3LHu2OWPRez+mg8OuMEo6ZfnALJ6Q/7bGWLo9jWnHjmgEdvRk47Jx5
 kzBGlvVqjxShnvD9IucNc/x3De2BNMFtzl8g71r+lStg7NQu9N6p6wQygnt5r1j8eXCA
 ua6BSqw45I86cRYbebP3101FyVdhZhgGUDlQJMN3EafT6PJJjc/lDOIPsb1qDhhHfnwr
 IrXPDkP/7exJmnnZKY0Z2A0AlRvnZfxLjDUBBVE0+VIqvpyOpNIRJq8JnkSNUxk/1mNk
 SrGwCAqJSp5ILV86NIAwHMR0MhOLPsY/iW+l75hxHU2Zo34HQY2CKv2nFdLDTwwv9eDm
 T0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471498; x=1789076298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K0yBS9K69huxIMJf39nZPczo7zAoMB+KmES6bL8eDOg=;
 b=AgZnAF0TUfBj0WjuhdDnW59/5w8fOMMhAF1LlIQiJzrBIatonTlvAO9cwkIDiz+P71
 rFel07a4tP8v9tUuQ5xUOFWYMKj5kmWMAOt6kxRRzUMCloQB+BhvuZbEnQO1choHyQgU
 3ZMP551YnX3QdYzy2LMYfieVekCd/iuCyCXDfU0eCqKG40PPvAbd3irJmh9/nn8MC7bJ
 NKmdopkcdHNc9v/2GCzk0QPAT3tlTchCkWWgUaJX+EJ9Tz44tB6k3wXzSC43HLegD0fs
 WTKScPcpL5Fq+QoYesfJoTodfi7XRPWiuuJnQWvJHTeVNu5FS0CF3fbXGew7BbcXbvuF
 SnAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxud3Z7aBvUUg6iZMg12E5CIMALWSpC59mlXpk4jzFWmkgAbhibeGU6c4KaOtF9q76FKFj2YiU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mcF6FsiGKUsc3EcDHdzBbQB7JBCyaUwR4XwyUqC1y4ZirQRAqK
 a/soQ5mVtf1zlg+xlzCfeMGq0WiLwm/ws8KvOyvWWQBzJkNYZW66E8uqIVm/LngvKUs=
X-Gm-Gg: AYBFou3SrNQRA0PVnOfd22B6Eawe/cjtDzx9rfdOt5AS8uMQWmsRXt8vtT4B85MF+Ye
 M4O7ielFnyc3TYbaBhzSu/PgHrqIgoIwGtniFX4NxU9RtMUJ9yrfSPWDvGED1lxqpgRzPV20UjM
 ttpmLGOKs7TuZcOx/S0NTIiHhcnaI3AY05QVdg1ckevUL7smd5u+kWVVKyBGuA6QZLY0fU8/Fkp
 qL+/tXJkS7V3ICfuwxMxbdcEQ7DyAGmKok3OIgdRNdGjrAYsgW/XgYU/w0nyTXKNa2MN76OZ/YN
 8SqIT357lwF5fnmiiEPUdwyblWFYLjCyDXscol8CFIqcWdjmYvSpNcEVOWFe8ODllf85HPcCbLu
 kn572m5ryw5hKGTvEvlK1FNzt2TBCIGkZMh5OxbjYL3DAclh4eV4urAuy5MiF28Rn1e2HClxqJV
 ZEQZheRbfSaR0tbKh8WgtlXiCddDYQ3X7YJAr0wZanNjGLDE6J6PmHk4+s/7tsX2VVpQ==
X-Received: by 2002:a05:6820:4b85:b0:6b1:5865:a95a with SMTP id
 006d021491bc7-6b6fb6d2138mr1734864eaf.15.1788471497826; 
 Thu, 03 Sep 2026 14:38:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:57 -0500
Subject: [PATCH 13/14] reset: ast2600: check dev_read_addr_ptr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-13-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fVkWuIjltc0ennkohXmIiwX385RiND8dlZqvtDMg+sw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmeiNGtEqSe/+3IH1nyLso65yETXnyltNCNk+i
 ZbGXYRHqcKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnojRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJzsH/A+hTwFe7iYb5G8xuv7JlNXV/tSM8GDGigQFX5A
 +HVo0Q3aH22Yj1sfLDOEZY8uuyU/TY0QU3wPA/13a/tCXHd30Du79b8isd8/g5rK7tGN1ZhKLya
 +ID9dG7kESjjk3v7tKEgr9eH93irHJ+jawGRy9rMLvvh1owS+yg7eUDF9A2H2f1uP5vuBQqODV2
 Amibd1pMmDpRTwkqMtF+M1s38lBUiAiF/uh5soJHwIwq+X1jhm0DKpCSkLIy+LvRpeQnvfV/CAY
 07qjsmZA9aOUt/m+uWWscjt2UAGynCiNry2HXHtjttbGQB+G+HbSl3LKQVEZxNw5fKGhBJ5jeIZ
 eJAk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_read_addr_ptr() for NULL instead of
IS_ERR_OR_NULL(). This function only ever returns NULL on failure.

Replace the now-unused <linux/err.h> include with <errno.h>, which
is what actually provides the error code this driver uses.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/reset/reset-ast2600.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-ast2600.c b/drivers/reset/reset-ast2600.c
index 71b6220225a..46aaaf54119 100644
--- a/drivers/reset/reset-ast2600.c
+++ b/drivers/reset/reset-ast2600.c
@@ -4,11 +4,11 @@
  */
 
 #include <dm.h>
+#include <errno.h>
 #include <log.h>
 #include <misc.h>
 #include <reset.h>
 #include <reset-uclass.h>
-#include <linux/err.h>
 #include <asm/io.h>
 #include <asm/arch/scu_ast2600.h>
 
@@ -77,7 +77,7 @@ static int ast2600_reset_probe(struct udevice *dev)
 	}
 
 	priv->scu = dev_read_addr_ptr(scu_dev);
-	if (IS_ERR_OR_NULL(priv->scu)) {
+	if (!priv->scu) {
 		debug("%s: invalid SCU base pointer\n", __func__);
 		return -EINVAL;
 	}

-- 
2.43.0

