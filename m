Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1555606A334
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mjsH4Scw;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=aSslb3Ko
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96D1F6076F;
	Wed,  4 Nov 2026 08:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPPn9hl7d_Ux; Wed,  4 Nov 2026 08:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A971760709
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782273;
	b=hziVKEYUzRn8OCGrG1JVfblku5R3n9PhXseMdAnPnu83PclhZw6OS+rF1vj86ZeNcDWF
	 Bn54Uq7OGpmP44bnuXtXhD+1sMEahnYMRaYVMptaJIaCRhbhbs4EyTZApZNj9yKnPeRbf
	 yCK6nvhehaI7Di5Df8aWCJ7Fb0yqtDDCYe+oi6NedZ4W1PqGsbaGHoDtW6YY/gbBBa+TI
	 ASU8VfnPGVgw4azQR/g6YTTVbZpW0QThxGPN79iJtALmF9o4c7cuSaQgcjELJb4yPfHdN
	 G1VYTnI7FI6s1qS/wfov+ZDtiqFblAKX7AOdrd2Iv7Pgc+DXwIulfRoWZ3yq9fOxJXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gkeZpie0bH7lg+QbpCu9pm2wsREczV65i4ZL9JNAfuw=;
	b=ht8WbBgv/LdZhn6Mm9X7n7ABaEkGDD5D0TgZTMdwhVeoxHDyfLEHZLP1QleRRNrPZVnF
	 KxFUO0oxpxDL2Fw1zdWfv7XlJHSIhoqNvn+U0BoygdK+IulD6Db3NXKieV6V95IT+oDuO
	 lIJrl+8HZRBslWQbetlgGV85r/20LkHGyB2VhfvcCcfFZu/4Mtp8YMQFkghKzEm3sI1eF
	 NxHymBgUtxyWe7OKEDOY9eB+ZUKuJqIGeJ9fr9c2rIEMdiGKQRrY7Jzj8S6A3iwh4NowW
	 5gKg4KhJYVgiz+ycL6I9oCP0kIl2sSpgYkKbgNYTQWfWKws5YOQLMr+NjICSf5JSEDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782273;
	bh=gkeZpie0bH7lg+QbpCu9pm2wsREczV65i4ZL9JNAfuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjsH4ScwIXI/Y50vwAsbtXObNzMofqBf1OepVAcK3EvdxmmZdEsGWWuwLQTE4hUgr
	 gD+CjEUDBVeBVeDaSaoR1yY/mGN2xB2Q63SpJkY4zFySIZZtqBrqxnYJ8epcYcUCsE
	 35NuO16MKzpADu95z6rrrvV5rfbJ6kKXnzQWsu0JybhGqJ756GRo2klylikvaYcMFQ
	 5ho5P9DaH6FsurctFdMYd55WhEl4reLMV6lhDjT4t8dubu2JbUDRl8FrzyP3A0BVnT
	 hrDACH/UXtotamxBg2FxaPdxs36R5vdt+WM2IzZKNozR+ugxUPWYoJldBWNFYwt4F+
	 4n/9Ci7Vd3W6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A971760709;
	Wed,  4 Nov 2026 08:51:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E9FD932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F99380F50
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kXfUvBUtBLm for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AA3280E95
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782270;
 b=bLCvXY058DKsLGtCi2OAP5lARYGZqhwlP8j4I9IudJ+XqKUaaeniz7JSDcD98B6irCrZ
 23myv8i8EdbmA7aD3snHKNLL0cocKKix5qcxZ3ugad3nMMHVabxsIUiF6wxJRhn/TSxKT
 E82+ynWCw8rUBhMM3AdPUi5h53AUlFdxHbjBJqYRx9oTDE6GzcpciK6kKg3Haaly5FJ8r
 IXwd8U5/yYYZMP0XaiDuJj7qSEz4mR6Y6LN0ogJ8nhOrXtJKkwy8xCmH81BkxzB+H98LI
 xumhPDhCrWxSnS7YcapOd1ii5LLC/xy6lHXiLwGO+vcTTV8+ikxK7KyiwJkOxxj12bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782270;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=gkeZpie0bH7lg+QbpCu9pm2wsREczV65i4ZL9JNAfuw=;
 b=QKwEUXbu4Ds1x5J+jBK89EgaZKYdHRrkxynPAjiJmivTAn24IZ7wvAUWrN6DUVqsSEBA
 0AZIyF5NE6hbc6t82eKR/OcHsm0moH/sFtS4lHEQkXQV056Bi6POVUKFX6qqQru9HBf9F
 LFkdhM8+AR4OnfPiIf/YPBpmo2P+dlM0dsqG9gw6Yb5KXVoWJiTDI5qzs0jhBfc49/K7Z
 eYjVoafp+CECMrF6Ecp8uv0JkxKngvmT58Ta1zpVAL+jDdf9CH149S/vfl56I1i8nOHvC
 gXTiIUDJqripVSBbUpOtjw5kK0R+I92W/CBFBWUu4410TDGQH9Ig7praFp3ajwEHeAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=aSslb3Ko; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=aSslb3Ko
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AA3280E95
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:09 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so1850005e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782268; x=1794387068;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gkeZpie0bH7lg+QbpCu9pm2wsREczV65i4ZL9JNAfuw=;
 b=aSslb3KoVzPCNokiSBU6fel91N4hwCpE/pV+befZcr2rbchflqUxElrDOwqYXtUk9+
 2Sfy17pjNdl3NCtIBoT1iK4GwO+5fgQO3Oi6je34699jU6EwomkEfwwyWSM7uTSNJ0V8
 le+pUZtBE742/cTSQXp/u/MsroBZ2lNego87M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782268; x=1794387068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gkeZpie0bH7lg+QbpCu9pm2wsREczV65i4ZL9JNAfuw=;
 b=0H+gTFotwKte00e2Gw/AWXpniRDSG1Rq0GLrz8U7tbsDMcLRt9N31KURLrTBHdxBAP
 F9I++4VKguREd+6jdEz4iA0jqO0AWCix0aUSQQSsPWZrlhWU1P44Zu2byZWQy/tivwNd
 sMvIab/TvAKEnL7IXezWuOUySUp3C4xixiLa2Qi8XzG2xPZKmdL1Wr1orbgPR3fqCTOd
 mIYkuCe6krgq1QZzeZCsp4lb0+yeADoVhXgi9TDYY2qcB82ZvYKeVJqMPRgM+PS6VHpz
 xeW5wde21G9ijPsaojmcdunBE+y9owmhGcJ+WOZn9NiM44+fWRLGXMFFYGI74mtMUPAl
 4yHg==
X-Forwarded-Encrypted: i=1;
 AKwUvByi1i6Q44QldNxqT51NdgUVtQKin1RElBTgB7gyzL5+9zhaIv8WvFFTyIY/vYN9IOPfAFkvyg0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9QJLphu+oa9in389N95P/KYEaiTJgcoV+3dwC/GIV+Pr9ELGEG
 Qo25iYPFOxOWvDb1uZIWvO/m8oTGLP3/9v/29E9cymYZwQkFpWFj25vBcHfRWictW5M=
X-Gm-Gg: AYBFou2gIW2Jpih+VNKwms3nYFUTT82cT626DQ54/lwMv0TvI671xKytifpKllXMpSU
 jjViCVZFJQXsdIgcXXao692t/r6zyPISv+pbN6EihVu+gkikF5HCtgUeLziQsK+C4fRnxmqmLxO
 fJDoQ88blEQDGX4/36etABJqgHgwjIooOOjex/DZreZiIFulLe3jdyeSroXMKhHPrkAMERHP2Kk
 1LMrfz5gyP9RtXlR9vPws9ZtmHVe5udMHbLpGO4uU28GIFkvqfOtYob0Wuk6Tkyo/YGEtXwjIQT
 3diS0z0T4bvKKKhnijG2qNApJ1FQ+CaUejV3P3By6l4JV1LvetOz4hexPNNWszhv5GNyJmDqdvg
 dsOwWw1EcB+JjefK7ck9eYblrKwD5WA2NaO5wEKgPbPlG+m75TKRBTSSR5zUtHTcbe1kXXkkOSe
 XkLCbovHrBTtQc+wcFfP/YX5Yo/VKgbDhLe4LgHxUSQF7kKuOwldb1yUqm2t7dvaS1KmqmPhBUy
 Zy4xPmK4sFFJbjLxZvcLDzPkUDbCu0e8UPGNbVDNojY5r3bmpn/OJT9yP3NPMYO94Us7QLuCwYy
 r7DhHuit2C2Po1usJQOrxcRqw8M2eOUFWQPr88Qx5KWbRhw+xw/SCQ/IyLCPgEzH5eFzUOjJ1Jy
 mub2kPTYJ3q3ZWFDU55yutjKDkTM=
X-Received: by 2002:a05:600c:83c5:b0:4a1:f377:5c75 with SMTP id
 5b1f17b1804b1-4ac19329ea4mr313645275e9.33.1793782267866; 
 Wed, 04 Nov 2026 00:51:07 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:07 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 06/33] arm64: dts: st: add i2c1 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:39 +0100
Message-ID: <20261104085036.4012238-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

Add the i2c1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-7-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 650d83cab19ea1acd3c1a17583d91efcd1688a7c ]

(cherry picked from commit 7cac3c4a9f9b57c8e7d4c1430991f0df3b0883b9)
---

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

