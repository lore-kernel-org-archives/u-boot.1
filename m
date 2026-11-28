Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEEE606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oC8g1A3T;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=NZVcYSBx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FAD080E55;
	Sat, 28 Nov 2026 13:12:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyzxk_MxFc5L; Sat, 28 Nov 2026 13:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B007810AF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871522;
	b=sU5X4YRbWz8s1+gz22jnhCYmYVER4DZ3d3V9vyVd9tePNxrWzTmZmQaIq6EipM/lWyi8
	 dIzEXUCV+dH/oxFAHnOAoJ8jhcB1h95cas78ILdbsXDZyI3h/64J57o307Lghmda55QnP
	 U+WUgmY6YPfqqEQ4jbVHBrQlFfcRefHtoR5a1THNLBfbBep+lQJmIBG0k1yFFa7gAwlzx
	 krQ8+42r/O1AHtFhSYYskxWwA9VNGtxXvspWAQ2enKUq+dFGxrZqEbSC9Q7hI0PLjsjtX
	 2lsYZ3/3akkW+DE8FGqWFunkZo83soysebdsrjpjQk7a0PLvhgu35KvzE/ywqgwhYpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871522;
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
	b=DFZj1FCAE6G089Lo83zcjy86kp0W1Cl9mrQXcEtbZ9/79/BRr3lBT3CfeEFer2HShrfq
	 cO1E1ZZ5Y8er+zVdT1E62Bmru0p4gljktRGXZpzn3qiurt883YDFLWtMGjyhLw5VvEvO3
	 SQgXtSFGBx7j1Xuvj3vKcIvyURPrvAH/p2DPiDkCmFX7HR6IC3criLI9njaaHv3tWb4pT
	 4jePHh1FXlkUV6HrADPI7BbCHbjzWzAYSh9c3GjQqc73S9eH2rPFSkQLoGQle0jRxPjfL
	 yk7POJ9t2zBcOfJj65GWJNWqoNACY0OJaytoy0OP8H/WeeOS5taZKhr5mIm6g4coi7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871522;
	bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oC8g1A3TcInoFAAGJHXLTJaDcQSmtJi9hRwnIWl44q2QIdhuxRlz4AC/i3OnCwqM8
	 7Z8Q5zSPjkHz1TgfmdHMrs+Zk3su3ws+PPxbmdTxFB6hRDL43VpTsiG6+/GMffOzVE
	 M9r+y4V4LldHK/VcPBLBZ9tqnV78aGc/F2z0mK5gBSzPlnenlwH2+vc+7TxOMis0y5
	 26KL9BJbK8a2xnv+7lHnXYfqTOD2PRsQKiuqaLUMwABKOOhhMDUAK0rAiXCRaob6DR
	 /pUGIaKn6fV82/k/JPINtNwtpubxbR7bVHhjOsM7xtOYHm5kEtLI/ZztzdsgLQ4oFh
	 HVQWc2yzOFgvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B007810AF;
	Sat, 28 Nov 2026 13:12:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29BB926D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C193400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CBzdCrKRTDmx for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF4454005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=NZVcYSBx
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF4454005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:49 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so77864465e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871508; x=1796476308;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
 b=NZVcYSBxF+IA6Q8E5TOhSfmqJ1UFsfYALy1LlXUpy4er87F+c+/taqRY2n5jlECoUy
 RUopA0KUn92PzXJnoMJrR34TJlhhiGY9sue7WPQAzADyNByZr0F1AQhG07rqqw1F9yua
 iHl1o+Jw/BuZs0FobDJPyhSOrNxA9lUlmdrT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871508; x=1796476308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=72gFFNA9O72GCJCG6jamFKvdwtrqMmj5CPGCEeRAw3I=;
 b=SuFAklktgtl3npTNlZZNunV3GbJmMLv5dkuUMn5gorZTnt9KWt2agL9cYi47D+x4av
 +hez1W681G6UHptkXvq+BPQDRYwXBgSnFhaA/Wmq37zU5Qrb2n0Jbda1blQj+k8Ik1AW
 Shzuo1kuFn1cdPAlkzQZ95XniapSv2ZRdzMEDRd8/cTahapDDi2k9Mmnp+JHkDe6qZfb
 +bzPwn5IcvBU151nfETMdoNE4IJcRboFM5Qhbb3w0gX+VLemHyK8K+1zQjAx1vZTCOUp
 31y69j37K6ze182m512Y6xbPzNU2nFM3eWWqo0Lu5/Ybt56gpTttd4L5nzxgUy0hKeBc
 0EpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGhLU2UanWg4pTZzpx3MeQZqmqp72IRdUcQ+KzkTApc35qu7GYs8rKICSZmyLsKIDYR/AGu8sg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lO3bADjGosb1FwfL2nPl5yawTwscqUmZmekIwMm58rbsnLjeN
 DLjNA1lH4BitlvlyneGBJ5AALYxogUROTQ43QTltYYPDm3rAGeNDYBp/4CdRTISO0Ru3QIdlOzU
 iczPF
X-Gm-Gg: AZFdTZeYet2pfdLJGmvL0USXmnngwk2I39z5Gesl6ZFw3LPFBM45B/eVRFAXGvkmqKt
 QfPbTqQmBCPJ/jJQ+MhGM3rY8IRHsM39/z9gkylTOnQX7U0WadfU/QXzkg7q3YbdU88IEgAB7EK
 ZP7ScjJwg/QE0IM+Zp+095EdNO+/yd0V/eHfTyH65CX0SDvUnbLjK9GzdjVKH4Juk90ivWYsKjw
 4h9uIiDmDnEqRUj3nmLHJ+/+NKgTGt3fjICGw6hUJAwJvrbr43J+xYM7XsqKpsXWAe3r1hPVyyq
 ZT3aOP1AYWFxU9aVhW0vzZKTKXBBKH5TeQjbGDlKJgQZ3T0nVPxLas2RGuwiFv0tzZcJSSR4U8Z
 TBJfx1wLonSgePtjawpeU4SuowDTYum1d6EM0yOLyIx9GOslB+p9UJbbQwGX20DAU05BJ5bgaGS
 A22xp7ILpJczlkGJTnLBo2fMSLLRqTutIWCvTTL7ycwfVOEMJJ9tsqbSwlCzJDV0kpds7DW9gRb
 5NO++fAafnLHNtJsGqONBWJEmo8CjZsImUAvHsSEwHabI26fQ6HQxdVBTW9+AqY+XrLA/WLM8Yy
 3NIiqS0UwbAa2rBsoyO9HV24WvCLVhvitEhOjQaVj0JdxUZv4tWQoGqvTfW1TJRAF88qzSfoMwS
 KghFieqswmcBDOz0O5d+gCRQzEfdlJ4wJqOogH0LnMooUkAbPGXA10oq6LRmN3yzvxrmBd3yZ/M
 i02g4krWLbdiCEslhy+/UT6m3h1g==
X-Received: by 2002:a05:600c:3b88:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4bb888078a8mr619597045e9.11.1795871507811; 
 Sat, 28 Nov 2026 05:11:47 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:47 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 10/29] arm64: dts: st: add sai1 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:27 +0100
Message-ID: <20261128131125.2141352-11-dario.binacchi@amarulasolutions.com>
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

