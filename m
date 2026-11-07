Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0F606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZSR/Ya9r;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=I26bM0Fv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70CB18167C;
	Sat,  7 Nov 2026 14:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KeIy9v9FlTTS; Sat,  7 Nov 2026 14:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BB8A815E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061996;
	b=LGcARj9yg4B9sevUYoce6IZZoWCR/BXFHh0NCUiuKol9mbyLA6GbIZYVS+YMlXv5+ZjO
	 sIkwic06bUHjVBH71xeJT2QFOGgKAPVxSub37DA9hoOPpqniuQLlwEVbdvFmj3Xczu+6b
	 4S/gOQh+LvRYFKP66V8ig84ZYIlR+ZfntG+S4elqyJ4e0wUC8Vg/BVII6PRlUYApZvQVD
	 ebuvUmwQUnG62odp0uHOzC+WOkZjlCt4pXfYqk4eLlAqeIN+KB33oct/XXbvvbDL2Bs6R
	 yvu6mDyqwsXSstv9le7DcH8uOBKYzBYX7j1YERAwDZEl1rj/c/jVH8rJjbIx6aaw8DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
	b=Tc8EJ3WtJ5HDWt/LXu5K3s+OP3yawNLl+5ouHRj3fsy7z6xmLqz+wOsplLqh2+DLNehb
	 uDenrj8IP4KQDWoxEmkWd3/r8mJ8UgQX9WER9UvwOd2di56aCXxWSdH6AOk1am6uJeL2L
	 swqWhpfeP0nNjTaABLb1dVv5otz2FMf+w6vVrGC6Cgxc93yi2PalklfG5Zmf6qyzyaFFQ
	 6tUTrZex7YXNhVRQXbxFTffuqKbvTRur4UUqlHUwVt8UBHoUCOieAMDi+2fhsvwMHp84J
	 uuFSqnof9C+kMosO9g1aqYZGkbqxDK4CHUThhNlCkMo1fe86stsSG1jilCa+HSbi9Eg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061996;
	bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZSR/Ya9rq+HcwlV66rm0IG4DXgyLmDKDfGab7JNuJmWZLFBU0zHlpLAKsQkyakgxJ
	 6c+esGdEhIGAUa1bSC4yPSRY55XIH5C8QY+Ns24i/LgpsMcSQu3nHpqwuSZPHYSCIv
	 ERzHiCUgFDSFkhjv3JEGKKjjxHpY0/O7Ysexboox9+cH5WwT/hVn64FD91Ni/IY1v+
	 tlAx2qg8fFOXZWu1cTWglD5dSzN6L6nfzkDZjiUpl0nQa6dVT5ctXZ0OEDpPNaBcwv
	 KWsOkU4R2jAmtpLYRgHV1HK9raVgZ95kgJL0OY+5C0aRX6XTjKq7+Z3gYVkdua8J/o
	 8E+c9kjK9jAcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BB8A815E7;
	Sat,  7 Nov 2026 14:33:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53B1D211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 515E54075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdLKppQ0UkZu for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A30440757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=I26bM0Fv
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A30440757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:06 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so337925f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061985; x=1794666785;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
 b=I26bM0FvE5juYrrsNHSWLHr1ZvY85HO967tJw6FWEC+AGc1LWmcxn0ZGO0GZvOa61S
 uNHJzF4sFuYMMd/UQbhlXeRT7CKZSqzqwzipSc1qk0IaL6k5szEfWJZk/Ged8YnN6GMd
 dhwn2LZmh/7cZJFap4zRYwanwOH8nWfV9+0z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061985; x=1794666785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
 b=PLBi1yMGhX/XdDPs1s4c4pCw0xTZ2kvaTFl8K1+wG97fDzVk5BYRCLB718lvzoHCSZ
 TlJtB32iLfLlK/vK9uCEqbS+iXMEOMujulY7TDRfqxVhj6aJVKuqLKZ2z5fdgQbwZwyh
 b8/7cDyUTrzip+38nQ13Y364dbFmEQ9is2c9jWqTFeVU86XNVgCZB+SyeqL5eghGwbgr
 TGuqIDxoSP/ACk+II9QuYt/7vCCnHcXT4crXez4pP7mF+s1fRQHK2Hhz2QoFt1AZvO2q
 KV2K+FIqj3vFse6tvgK27X+MsRvlL3ElAbyKFz/MGIv4VuOK/AXjFzeqGlEleNx4TGlc
 JjPg==
X-Forwarded-Encrypted: i=1;
 AL+hErFWybvIp1v5AjO5bBHoNNmBipmD9kBiklTgJe1oZ7hYCzFdwtbMbcNwe2/qThDwqKI9D06ZRjg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ySJW7gAkXVo76A/qp1Smkk8vRqvsMNTgyihbnI3vBEnlI5iO1
 3A5KSJx61v9loULDXAltCwxmB3A+PPuWTMZV6jbMJNJyLBt5vzLE0nEaOLhBXu3cpRs=
X-Gm-Gg: AYBFou1w24My5v6RPK9dEqQxiLCD/3iF58J59LH12SrEN/OKOZJWqA75dWZwSEfLI4Y
 wcC0LoglmumN3haAPKy+OuUYJunFt0Wx3txtUL/MgjTk+NavQrr2Stm3SrvzBleKbnV0dV6Nmxb
 9RDggZGK0Aa3gt0N2OufNGJpG5uLNVhc8Wxxdu7+BVi2Own79Fr5Hgy3OlOSDcWKeZ8t6kecWBt
 oUwv2Cb6QkA6ZLEKVsdmFbUaJN8qnKbeqVM94gIG28IeerlGk8nV3VJ2ip9hG+GotieTAOZZVHc
 DN8/JQ81mhLdEewU4aEuSkmYyxTtwqBuHlEKcni/ifxQypUTjlOyXfLwJwkFrKMb+HMIDNQK+OE
 l0GqwtUAfGhFAR5nY023RU8X6fWn+Fw+cgmEhFN9CJnidrtbK/UWroPxrd90TM5v0nxeCXMApjK
 k/Le9fpadbtKgx27K/noIv6F0mzhHhoOkb6ku9y9M/FXMgMYWfeYK51lFABNXDaYtXIe6mM0dZL
 IU3TwJkkALjMYRkrBaaFoTUF7U0mTXpAIcb+QKQPBAAiG0F+5iRGD85QdNSk7eoQte/J5fV/iR6
 N+Uh9FX47TJdIMLwDgZocUpSvnhjCs7NFLQoGD5XVB+pyfCFStVh0DpOXXkS5c/2YM5Pl4HrOPw
 ByDrJAMBvwpn+Yt79O/1ZOwMJU5efIAE4HzyA3x+23bU8AuUJqnq6VnSmTJdyOYgI7ym4R0xQnO
 bPbrZ7QFLzE+gdKW8dBvCDyu5pWHEqsexEPk1voiuD3bfu4tQ=
X-Received: by 2002:a05:6000:4808:b0:492:f82a:3c18 with SMTP id
 ffacd0b85a97d-49424bcec02mr3381041f8f.23.1794061984885; 
 Sat, 07 Nov 2026 06:33:04 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:04 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 10/35] arm64: dts: st: add sai1 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:32:00 +0100
Message-ID: <20261107143241.2236511-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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

Add the sai1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://lore.kernel.org/r/20260820091652.43541-11-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: ec9e6b832ff186db9fe4a8c9e57ed120669229d7 ]

(cherry picked from commit efe29427df55d919eb9bbb319e6f4acdfd14f4bf)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 695c9d771853..002fbc724b9d 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -520,6 +520,51 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	sai1a_pins_a: sai1a-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 9, AF3)>, /* SAI1_SD_A */
+				 <STM32_PINMUX('D', 8, AF3)>, /* SAI1_FS_A */
+				 <STM32_PINMUX('D', 10, AF3)>; /* SAI1_SCK_A */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 11, AF3)>; /* SAI1_MCLK_A */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+	};
+
+	/omit-if-no-ref/
+	sai1a_sleep_pins_a: sai1a-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 9, ANALOG)>, /* SAI1_SD_A */
+				 <STM32_PINMUX('D', 8, ANALOG)>, /* SAI1_FS_A */
+				 <STM32_PINMUX('D', 10, ANALOG)>, /* SAI1_SCK_A */
+				 <STM32_PINMUX('D', 11, ANALOG)>; /* SAI1_MCLK_A */
+		};
+	};
+
+	/omit-if-no-ref/
+	sai1b_pins_a: sai1b-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 4, AF4)>; /* SAI1_SD_B */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	sai1b_sleep_pins_a: sai1b-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 4, ANALOG)>; /* SAI1_SD_B */
+		};
+	};
+
 	/omit-if-no-ref/
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins1 {
-- 
2.43.0

