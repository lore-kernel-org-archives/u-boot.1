Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395F606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ot9/KjyU;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fgqVxeq2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B94060635;
	Sat, 28 Nov 2026 13:11:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbLifCM4-97K; Sat, 28 Nov 2026 13:11:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 647DE60658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871511;
	b=ou77h+zzbMIIjodhJCHLQ1+belV1Uw5pKMAKZ2SLSzLtiilDZtqEVPo5e3ppin2k5BSP
	 N1zOpei+G0VGTfYiH3FSMnliwQNpGKfkVlmAZc+8kOFkZUpjU7aQT0/IozLfLIN4Hcvyy
	 wK05PPzv6pi59Y2gECslkAZuLxjRTDowoJQ4kHI6EP+mGa9ooBfyCWiFjbJyK2wos8jRT
	 8fmnvZEH17JFz7ZCtYxB18n6AhKCBDuIjX3xbDh99lBuLSyW2FzOiz3FWH7z5Q9ASv3AC
	 QE8az/bMQeX+aKd8SxP4T6LeCnjcGdhMQ9InMTCu7bB8uebDDENSI9yLj1EYOGLCs8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
	b=SNvmSA8xMAbEVwAS1QZxgAWR+DunOcgIHByShAZGQrgPZkBUmvbpMrW4pOK0j6xJd0ci
	 kEAnOvfi+v8SHdLBHkIelOrSfyynJpEXBkzun9ynQIIP29NddF9egBXIIt5FUx/WHtKJ0
	 GdBDGu3MUqG8ARAkU6X3dZOm8fZ55wdtGchjA6Ovec+AGae7Y/TU4fzJ9H7vkmYSqY/K2
	 rwsptzwjYJp8jO/VFryHZpayiMWdPn8oar1MYJYqmaxYeTfQHsob66R0044KOIEY19ZiN
	 zQryKb/GAHkHAfUx7/le1hD/nYnj4/f7UsqmdtKcl65jC2iKpXayNzjjETcMNvhaP0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871511;
	bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ot9/KjyUtWSA4a3P45LQrD6ErV5wu8gT12ElJldeaNeCrR1QvjJzNoZAJgeyS+MZV
	 SAX3FpxRbp4MnlUfVRKFQCPcab706F+CxMl/mHhNsI8JApGeDq8o+bNH7Wx6RJ60KU
	 EWN9SBTGiyNb3VIT43n7Lt5lb+1fCmrTjcRdU63YsoHKrAbUtSqkGIR2u1djo4Ahqs
	 50LH+Ouwf4drKiTVMgPoEujBY0KyxsNqjokZ1lm8qrnilVG1uiNwuzJwW52YhdiPo3
	 ApCq4y5sB7HxtM9fWOdW5WijrChbd2Tv2rPNZ8jhNCWplONKmR0bwd5ZCRennqk1Nx
	 d8mAg+Dk6OTnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647DE60658;
	Sat, 28 Nov 2026 13:11:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C65EEBF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC83C40659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZJCJLRwdaLP for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 952F040645
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=fgqVxeq2
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 952F040645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:42 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso68818965e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871500; x=1796476300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
 b=fgqVxeq2CWuQwFXq8q1fH7y3Qh8R6gUm8DqMKCVw/pbNBN7pSQpFaJO9JGpRrZlwc9
 WL4vMAKifhR12vbMV4pPYbYuM/0pI9DqBrZw5RLUqktjPM9yxPd7qlQlFmpa5frTkqXj
 C65pbor2+ihJeEYuDXVw0+GsZa99JCMB9PaRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871500; x=1796476300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
 b=QR1L9QK85RgjjfpUU1Irr5HmvzLLeheTeeiz/6EqG5Llpg15O051i+bBIk5bfrL+d4
 QPE9bTFDXezHLAwC0G9rVk/SCU4TabwVU8+dsABdbF9xj0b0WaGeJA4jiCahXR+awlQc
 90T2tHQWpIWv3d2rb/9tqnAGuwZ0RXl9J7BaF2aw+ZpPgZGofKNvchD600fZ2DK0zayy
 k3see7zxJV13dz3Y+HxZgYa9pCw1rSj3H3Q+11FLYOEfDRx0ZL+y1n9gxI6L1lEVVCtS
 CLt2swgLUUNJwV+w/Xyp4qW+0x1RQkWhI3GMwrTGI5PsDDtriu1kdcDB3nruk42nKv5/
 l6Kg==
X-Forwarded-Encrypted: i=1;
 AL+hErH5hpOjKwuZ4diZJnAvB08jCOvExbkidADxuIo8nSgtk1v2XF9ZR4yYogZCLz+Xc7iCAEpImuU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9w4mJDpZae1jTNS1LKBUBSsl6sZjQEGz0wr4N5BqnKFz4q4u7Y
 nwk83nvjE6g2+78Kzabw1RYYenaIV2jqiayQR+Z4HFT5wNUVW7M4VVJHWZ+8nrpde28=
X-Gm-Gg: AZFdTZeIHNNzhX/u81wv5jbabU5cNjfxhgziusbgLy2apXDa8KWVy0NwZRssdB8496/
 aOBu26yqCH8+eZ8yMYvsvoI0HTtWgijdN9eXnqLBJsedUHcym3sD+emkpHC+JJtpNofF8Hbe/qP
 MR3tLj+YMXTWIbMvQe6qCAObbjlmScbfRXlx/FXegSgN/d7yD43pDngz1QrGQcvDJR4tOD3ae2B
 XqmLgzDlclXdyvVbzPClHIhS0qYl2h8pfVmsPKteisgiynsrXaQZE9EmiRaCftTbZ6dX8v1Gim4
 JwxKfK+cHfK3pvWCyU149ff1U13iu8jXriRQFqgTfhwrERn+qCpaZq+HLwugkWL3STrs4KkrcL0
 XFPfEFpevN+7JUksx3KrzpL+wDl16Db+VHJ5XDxe0PV83cLlSjzFInt7Bawag0WZS1/2WhnZ/9Q
 euft1abmHkm8CfZ2YGNil26K8QPG+QuVb3OJAT6jy4NfWYvgDTxtwf/gS/b7nIUfsahsrGGun0p
 wzNFNuTB+NJfAmLMY5p2cr0BG0Cf2wfQMOXPoCnP4dJXMdCpmRKgL9GUUeLO4vm57+7N23vI06S
 1PyNuagfXBlAdC4US16Xwww8txOVL7nJvSyiL84Fr8AyuwqNgdhq9UWZwjM0Eoe7WUiygMOGBnu
 JWAynCeu4Wss0BxDesFEok+xdg1gKN3GYZXnKO+hwKXZjjjPPUItg2q8s6K2b+Ub2I5+VGjiWAb
 fIdPxyGMhqUJAonhW0cutt412q8w==
X-Received: by 2002:a05:600d:1c:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb9de0d5ffmr300970525e9.25.1795871500502; 
 Sat, 28 Nov 2026 05:11:40 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:39 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 05/29] arm64: dts: st: add CAN1 support on stm32mp25
Date: Sat, 28 Nov 2026 14:10:22 +0100
Message-ID: <20261128131125.2141352-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The controller is compliant with ISO 11898-1: 2015 (CAN protocol
specification version 2.0 part A, B) and CAN FD protocol specification
version 1.0.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 7e62731fba26a58f975815add1e3146eaaaaa9c2 ]

(cherry picked from commit 3de3ce4cd1862224d78cc8da29550dab9feeb43f)
---

(no changes since v1)

 dts/upstream/src/arm64/st/stm32mp253.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp253.dtsi b/dts/upstream/src/arm64/st/stm32mp253.dtsi
index eeceb086252b..7e82f01fdc10 100644
--- a/dts/upstream/src/arm64/st/stm32mp253.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp253.dtsi
@@ -43,6 +43,22 @@
 };
 
 &rifsc {
+	m_can1: can@402d0000 {
+		compatible = "bosch,m_can";
+		reg = <0x402d0000 0x400>, <0x40310000 0xd50>;
+		reg-names = "m_can", "message_ram";
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		clocks = <&rcc CK_BUS_FDCAN>, <&rcc CK_KER_FDCAN>;
+		clock-names = "hclk", "cclk";
+		resets = <&rcc FDCAN_R>;
+		bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+		access-controllers = <&rifsc 56>;
+		power-domains = <&CLUSTER_PD>;
+		status = "disabled";
+	};
+
 	ethernet2: ethernet@482d0000 {
 		compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
 		reg = <0x482d0000 0x4000>;
-- 
2.43.0

