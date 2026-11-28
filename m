Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36749606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rabynmO8;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=NFgKauur
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FFC9810A3;
	Sat, 28 Nov 2026 13:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zK0E9RDg481b; Sat, 28 Nov 2026 13:11:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16DEE80E3F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871513;
	b=Hp+PWOCLB5GLK80flLJEA7e6vNol/wDIW0LESTottMkmm7FyWFw8cR7IeWh8eN9U0/rB
	 tewjWQVPLUWNy4nm9IJxnnbYNpxEGpAdPbm9cZ3rcXrHt/yVcilklBg5zf9bg5TGm4O6G
	 T8WYBP+4XDuXVws/UEe/0zX66/nehAiEgM9LEHw3HHynOQSjx5xIz+eDE1zFfIGFpQM/x
	 kmvcp6XpNNAubPC0Np5vy1yTtvAaBFfWBsPzgw9BV2/WNyZ7Nh3IF5Wq2g6/QDGrVlTLb
	 ZDbt2wg3lXHPgPCEtxGDuSQajLTr5J6pok4BOSw3DH6vk7xnQDT1jNqXk8wQ1cWLDCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
	b=O3LSK+CLsCiFNCZ8ruuLSZdpkKeyMcRNQEjZG3kdH18rSIu2+xogbZSIDywdB2ssTYKP
	 +6l0I3OQ24zOWrZl1yxhalWO7fdgT8FBQluZKx13TaYdQCj4ICf4eNASWAiGH5HvaBycI
	 3TObuqotdaVCtEVmoNI3UXGXgJ9zqs66PJBjYiMnxYQ1dBWn5YMI0Mnc+L5639RRSQCLn
	 YoV2S+XNnE/5TbJw6nwpH1WseKrTBj6sMGEw9RXcqMReSu/WeXu+8e7SdHFus6bDm9nw6
	 iUlhuQ6MAaJF2SlqriWcGXzBOiqh9UpVbAabtITIQJfpotdeEoxFecPmXixUBNHIZnA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871513;
	bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rabynmO8I9yhA8jndgUHjraxDteLPJ62fL1+UuhVgcGLgGw5vDTZc7YCXWuhKsykY
	 wRaNyz1ghxeDu2r2Fyb2c5HWAKRgXv2MVO7++uMHkWg76aVFgsxyQ4e9yDcFZzMKMs
	 ExHFMOKC6cRc3t2C2VNtJqvZV0W7umNk9gkWP+KQ7dFPq01+gexN5q+VXPmZg/Li+e
	 vODlArTCq8rgzdhBYC1SJWyIjh3m5ic6sLjdg9rEIvtX19OS/HzQKD7V3SDOUa0gdA
	 zhroflhmtPsfKzF2aJAdTBhMoLMDCSbVPwAUuA9BBmVwZKijNF2sMuFk2LAYOpJsZW
	 hKblO1U/Zg0UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16DEE80E3F;
	Sat, 28 Nov 2026 13:11:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFB3F26D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3E7760623
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sc7waMDpOzSc for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F3EC60621
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=NFgKauur
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F3EC60621
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso6876798f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871502; x=1796476302;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
 b=NFgKauurRfkrOozVW+luUp2u5RYpgOIWs93C410myY0x8R3icOFDBtOyiN3WP4w+CD
 BezWuAmz5eFnlRIn48wDzgK8kgCTg7iUWL1WRbgn42dHsmFjLHDTE3qsg54f8aQEDijG
 fd+MrfV2eSs1CdG10p5l678qCrnct4GZxjXTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871502; x=1796476302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
 b=YfsgHqCiscQ+Zi1MSKDq+TeNLwKOcvpVm/SJ+jxK1evaOm11SodCeY8twp0b3URyz2
 Lu8TM5qBZ3Dd2KRbn7SyJwymdTV4PiYgF7fv2GI0jJpidNUehl+lm/63111bm6Ilw853
 AtYe5vRkwyzb7YzKd6m1FjUCvEk/qmHpR5iH41J4+YeOSodN0yb+lyhh300wxtsR9q30
 9qvO1NLV5lkePnNmvuQUXABF0sN2K3X5R7SqmYmEuHiKi/K5jSR6w4OGXNw8zz3Qm6i6
 XyWbm8Xor0nwIQlJdRfg/RZullU+PK0LmG7t8PNNw0BvVvJKGqjtBkdkLn996y/n4682
 kRYw==
X-Forwarded-Encrypted: i=1;
 AL+hErE1DY9eqjWEgqEd0/b3OwBh2H2lBlPDjpbYvYy3cDX4R3q/l1pINq9Xv24Kmjlt2FVLNKXpMro=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z89wtVapkNPGZ0K9dAqjXC7xCoYb0HAHwr73jMY2LXi1lROHTZI
 En01mR9GNwy5CzhgG5wmXWaKmzuUSvuMyJowKJywow7YTxqrM47pmkK72kZGsEvNmeQ=
X-Gm-Gg: AZFdTZfeuqGLGFDowDmjKGPaWbpHWReBG0jj1jrd7NC3TIHNSp7/V0wPZWUHm1xeb6i
 jlDbZQgxr2fgkquY7Db2P2G8tL0LuPwh4aibuDd6l6O/xhJsf50fPlWyQbOJr0BisankC5ALs8+
 isb4l086fHU+JwaI3uNhtYmTBCH6tHiH/r4vqBAXIwVTv528jbFQT9DHnSrG1h60lZLiCDNwSGP
 GL0GsvM5QkhxK5TzmuKEtN/xjgzsnW87ftf0ZygcZuZPL3J2s3yR9qTNcEgTJEcszwmlJJNMtAB
 jQA1J1rut3nZyJq2PImzHGn1UCydeq6zj+xJjsyN8LDfruMEQRydSgUgtSGVZ+o+hAorNF/WzRY
 efiQhLXLfK350QK84Akztj+ABq5heYEYDefx/YP41+u/w+237VgOvgH9z1lV0Sz5rOEIGHURAXN
 ki6keenPyFo1N2DTpOXLCLN8HXCgZKgZMSQIkVhFc3z+6l1kaebiPfBWYcpUNIQSGiOD9jGZg7D
 WkfwyhH4DXHeKOt2YQ1npC1KgRZRgEDsS/SKcN/0TwVQwvMGYv7glXD9/olVF0nTGPPtjzKvztu
 dMCTo093LcegZ6/wakA03ZvcFke2+0mXjHL+FciHq/c2tA/NfM670luK4KyZ7ERkYrCg2V78WtV
 tEGnaCvcbPExO0FwkNsF54SLsMJG9jjSznbkZk59PvDaWCVQWTEWPu4S1JEgi+FuvXrfJri4iOr
 nwFlfWxPAhKajqmK19Sdx6GNNjwA==
X-Received: by 2002:a05:600c:1c08:b0:4bb:7757:fe6d with SMTP id
 5b1f17b1804b1-4bb88804c5fmr694523485e9.11.1795871501815; 
 Sat, 28 Nov 2026 05:11:41 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:41 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 06/29] arm64: dts: st: add i2c1 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:23 +0100
Message-ID: <20261128131125.2141352-7-dario.binacchi@amarulasolutions.com>
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

Add the i2c1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-7-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 650d83cab19ea1acd3c1a17583d91efcd1688a7c ]

(cherry picked from commit 7cac3c4a9f9b57c8e7d4c1430991f0df3b0883b9)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 456ece7f8ebc..db485b9ed904 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -203,6 +203,25 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	i2c1_pins_a: i2c1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 13, AF9)>, /* I2C1_SCL */
+				 <STM32_PINMUX('A', 2, AF10)>; /* I2C1_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	i2c1_sleep_pins_a: i2c1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* I2C1_SCL */
+				 <STM32_PINMUX('A', 2, ANALOG)>; /* I2C1_SDA */
+		};
+	};
+
 	/omit-if-no-ref/
 	i2c2_pins_a: i2c2-0 {
 		pins {
-- 
2.43.0

