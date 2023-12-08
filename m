Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D1C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 00:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1F786EEC;
	Fri,  8 Dec 2023 01:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="kQ9Hj+mf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC1087250; Fri,  8 Dec 2023 01:11:03 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DF186EEE
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 01:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so1414181f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701994259; x=1702599059;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HymEYPd71e04cbBfSMcRRFXfKl0zDXZ2fPQOR3AIyqk=;
 b=kQ9Hj+mf0Pme3eSRiFCbivQ+L/IEg7wvin2UyiOOdrrseSpVYaA6hjj3zJbitt8tkB
 cD38yEkOsHHuwTO09+m7u7YqBXA40h5uwc5faGjSP24cYcdJQLPcgauFagtPMz8MbffQ
 2YcuMSvjEQpkjkzjbUOrpHiqLxuVWez93+ny37a+QubQqOY9Kl8S05XpvBEFbGafjHlR
 d+Q4GcUmK9L+5SzHqw8bd4Fc++aUf/Lszr57Fg9WXozZBQodznM4z7hyRj/fMtbv1HTW
 sSz2duUWrrho68deBr1kPRTA9x9AvmuhqYHbzFsu0f+zymghApesBx1yEoNmbwpNP054
 JYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701994259; x=1702599059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HymEYPd71e04cbBfSMcRRFXfKl0zDXZ2fPQOR3AIyqk=;
 b=DZkXK2ZXt+LScBGl56JUZxMfuggZdwQurseU5IhBFiqiOKVmMbbCrJPjIa3QJ8HzYk
 ODl6x9oaHk7HN6QK9dWnyUIvmap0RAvqB8+R/H1KdM/CD7bRVj1tnWTOlatWiLbBiMDR
 JQ0eFPyYagVmYrnCVXAuTacCS1UJCEQ3HSJlIh0Avu7AuV3i7VAhu0c/GvK3MppYVoM4
 eYlk+FG0AA2wML+FO/8TIn7/08duRBuEp1rx9JuAAKUrNuBcsEQOtlgXcWHJRvN14wyD
 DDLYtafoXkmSTiQ6/g4KVMzUMT40bpE4B1cHrvCPiMgZzLWsizTNLJS+6KENfkE6+OUp
 RElw==
X-Gm-Message-State: AOJu0Yy6g2lPlhbKsXO73932IQpBWPBRI/TgnhxksRemaiiHTUz7RIW5
 NjX4Ijao8Esu3Eebi6gcukgXJg==
X-Google-Smtp-Source: AGHT+IHTCjahIbLVfXH5OeBqkH/Z2socS7a6CduNYRLLzht9F9WrroUa9kI81afaP2JwFR7KjpjIgg==
X-Received: by 2002:a05:600c:19cc:b0:40c:eb7:d62d with SMTP id
 u12-20020a05600c19cc00b0040c0eb7d62dmr967040wmq.64.1701994258841; 
 Thu, 07 Dec 2023 16:10:58 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b0040b30be6244sm1074464wmq.24.2023.12.07.16.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 16:10:58 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Shantur Rathore <i@shantur.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
Date: Fri,  8 Dec 2023 00:09:47 +0000
Message-Id: <20231208000947.248849-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208000947.248849-1-i@shantur.com>
References: <20231208000947.248849-1-i@shantur.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

USB port regulators should be controlled by phys
so we remove always-on property and let phy manage the
regulator.

Typec port has misconfugred phy-supply in upstream and
now that we are removing always-on, we need to fix the
phy-supply until its fixed upstream.

Signed-off-by: Shantur Rathore <i@shantur.com>

---

Changes in v2:
- As requested, added fix for regulator-always-on in RockPro64

 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 732727d9b0..638d567357 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -22,6 +22,18 @@
 	};
 };
 
+&u2phy0_host {
+	phy-supply = <&vcc5v0_typec>;
+};
+
+&vcc5v0_host {
+	/delete-property/ regulator-always-on;
+};
+
+&vcc5v0_typec {
+	/delete-property/ regulator-always-on;
+};
+
 &vdd_center {
 	regulator-min-microvolt = <950000>;
 	regulator-max-microvolt = <950000>;
-- 
2.40.1

