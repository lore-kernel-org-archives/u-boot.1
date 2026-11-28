Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A146606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MrgHH9QU;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=XLZFUGuG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A299606AE;
	Sat, 28 Nov 2026 13:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D___utGqFqwN; Sat, 28 Nov 2026 13:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D62D6069D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871517;
	b=UbnUZwkBT+meZIqwkRx15crhcQpBbsdQwMX1drWKWAJ2GWP713pS/e7BDorDF1TTzfmP
	 tY5fYe/7LOBWZ/hshL1ApLPZ3XEP5Op/SGQqL4a7iNGfo6+B72X/jhKy2rlu/QdNHrpVl
	 JyVj7kkaDIY/kq3HcA15A3uTsd4yU18ixbdudP24VtDPMhM6cwxWJjLuRJZgOZQ8KTrdU
	 ehBua7B1otghVApzd+DKaNXPEtU/F0gtbmhjlYsRadDAjrKLC1F+ARx6HZklmgzNR8ooe
	 tghPTP5hZq8JfUSUQqgXX2+LXi2oRWlIhO4FquZZ8XMVDMpLXwKzz7gxJOMPCXTV+tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
	b=KElb61pbpjgmP3gLlmqkIldTjpoWceMDPEPl8X8jWm5C23/FfFHgkfWvtikFk8YR33T0
	 ApuxbZ+bs8nISGPSgp0miPmjtrZkaine3kXqrr1eznu8X/K3dZVQA/OyZ670ZjIFDQ920
	 2Zeb0/2OXcigO6/hJdF3+PEmilHXOeKoVugn7UxXW+GFciiqAUHoDmtymYwJQbpbpEG1I
	 /7BySc93AaShRERMDi+XnwIrUbVVmA3bsNPbjBoLcpTZZo4iO+i6keX6uq3t2omO5Z1Hv
	 AC5BbCM4u5EX+2YD6Mppr6qXN8VBywQ9FL66o2lmzFpn8mYfkv8TrO/Us0Ws4meUfGw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871517;
	bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MrgHH9QUs0RtZkgzTnWVyxDJRA342Gkz9tmRHGgPq4V6ud3oUOOUwDrVXjn1ITPgq
	 KaFQKaP6VYWK447o95IbQkHzUBNTcEasbpj5mK7aUHvVo4DkIq2Dvd+ggTJoMmMt8n
	 Q+tIqDGgS/7PHuedarsvYK8LAbnyVt/S/HGq7fby88p/qw99QvpcHxvREitBKZa1c6
	 HbFAy81AtB+a6yxxp6WjQhHW45yqKjOjzzdiTeUq4nVNJeCKjVGdJCiB3Ooj0QRCsn
	 YEzJPOeMZCfAw1b+sCNOnVI/S1PP6U8vLhhvN93HbjcH71E6meWRGUjt1KAuimbu1d
	 wucrqjD5cNBQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D62D6069D;
	Sat, 28 Nov 2026 13:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE8953D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACC1A40659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZKjp89lUN7y for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B015140645
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=XLZFUGuG
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B015140645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:46 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so85052795e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871504; x=1796476304;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
 b=XLZFUGuG1UTOrQkdj/hMK5KgX2pEdDJfDZhN17DouUTc27xie4cq1IDfNweOjp27zR
 YOrQCyD3DgqnVLR/+FAnmp2ebMk3MqKGsFtHSg+YAP3B87RXQg8lmysPeozjKg68kiJJ
 QxaqWc/CsBcVu2EYu4agHwWL+vZ9bcZZUtNp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871504; x=1796476304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpsp+aDk+l55C7UYy2EgSxKC6ZlreU8gWU4e/FApncQ=;
 b=pakXEKHoKwEDjuu/0JiHNd6Vx1xN909x/wD/KlpdVmZI746cN4fTIE5CkTgACXR0zP
 l1dfKxeUryoNqW+GCU9dWC5OTldmBH4MGVGYtSSdzzJcW46FDxc913LVZwU2vVO1lpEY
 dw9ZrktUNnajcF/jqUc3dkX0PaUcWfvR37LxAyEPnrjLvafh7REUf3M9qcX+zjKOwAA1
 zNFbEjOp36l7sG4QjJ6u+Zs/r4jhyz1urp/ggWNBgaIc7Ab1FSUfxHwSSe67rSKo1U3h
 HL2Nio5QdGMcTNqMDhdcMWvdZZ+4RliP7GDlECiyaZD9peKwNkN/8a2A0ydLN/Fci85G
 OzIA==
X-Forwarded-Encrypted: i=1;
 AL+hErGahBFt4OgmPt71SMA3vVy1etGZ2ixB+2h47wp+mckHwCHAbHEjVP/ENqhwf+5l/Qg2NzU8Hms=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9jADl0DBZeTrd2a6LjGwbI21CU8Ka0fb7ON68vpHXh70+LqlxQ
 upXDxxb66MLyaIKzGzkCmcvwgBQhMp7aIYE8YRnHizoTHv2RGAsa4g5JLrVfPSZ4YYuVPloaTjd
 ak/0z
X-Gm-Gg: AZFdTZdK852wkGjSWVNx97bvjwrtPTAxg2rwC7acbKtr8YbWqpBrktEhwnCqGCMuuvt
 iJlJndGGoogtjcr3MDDPJOFrn8m9EqLXjUP+DUsq3YBKR9oSk8DRUAuTPbNKuFHMVdfEj1l6mSK
 TLz2nTYyrDTUS0amJ4T5pCrp16CXMVIziSqVsR38qg5rxHvAbXRlz0PC1J+/1HZ25s+AuqwtFph
 FC1UKyNTdR5q2u9apOqdo8W3vJw+74gFFRg4Ndb/lNV0ysMsUHjxlM/7Y/SUgaeVM/lUzJ1Y5La
 U7W7lshs6jenVImy0MjX2+yZ8Pp0/MMh9b99KzbENSVXLr4qGCFDAOIxH+InDjSQOdSDBHuEnoe
 pX/m4PnVXzYlUUCttWrEiBEZG9rAxBKyqTZTN0EzQUT6Qd3VUVdLQsLtocdncc41ANiQ4pI4oPD
 bnbsFQosMIiNX2/iZvkPUHPuXVK1PSUJ8+EzcVC1fQS6nVMIGDbg1o+v7lUFXXQUDVJVzqHAXnY
 QHLWEssEoK3Ecu534V8ywfPAh/5fW4Eus+EZPSVxKjwwDPyykNKJx/Syh1JuayoA8HtAI5Ns2UO
 2jFUHprp8IMu6dpl6CJ2YEO9oL71stgk2gMTXkxH03DcaWW7MRds7rm0nSC2cfzHKZt3ItnkPy+
 hi7JL6GTJqjlCZidw4Fm88Ag3PspZzraLKPEVhWCGZkV3480UIxTZs53hIbx9N+NYZ+peUVeX6X
 QNQMbv8Oy2HTIYNDiD/69RIXpceQ==
X-Received: by 2002:a05:600c:848d:b0:4bb:52d8:73ef with SMTP id
 5b1f17b1804b1-4bb88940f1bmr553455915e9.34.1795871504586; 
 Sat, 28 Nov 2026 05:11:44 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 08/29] arm64: dts: st: add can1 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:25 +0100
Message-ID: <20261128131125.2141352-9-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the can1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-9-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: b9efa6d3c580feeb4af6204457ce3ebf351b2af4 ]

(cherry picked from commit e9b8701fc994a04a4dcd15598de7bbd9d81ecfe9)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 50f454630cf2..6482dd47e977 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -331,6 +331,28 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	m_can1_pins_a: m-can1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 9, AF7)>; /* CAN1_TX */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 11, AF7)>; /* CAN1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	m_can1_sleep_pins_a: m-can1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, ANALOG)>, /* CAN1_TX */
+				 <STM32_PINMUX('B', 11, ANALOG)>; /* CAN1_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	ospi_port1_clk_pins_a: ospi-port1-clk-0 {
 		pins {
-- 
2.43.0

