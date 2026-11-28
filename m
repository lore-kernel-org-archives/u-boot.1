Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E91606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qywnbqb1;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=lcyRNS0K
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8E9A810A4;
	Sat, 28 Nov 2026 13:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZMTwWjKMWgm; Sat, 28 Nov 2026 13:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CEB55810A8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871519;
	b=qZLLACO8+Ep5N1cLM07+Q8P3I+DAWrTHxD7gEQhrV1SEqHOE3eXeCimsMafTKPPeDl7F
	 CLSEtcfX7htJOMe/LXuDZhg2HMjuwQRf/G0p1g5CQJu0YmvL2ih/t57PR+RP7tognoHzR
	 kgI6RTt0wFJTIRp2bPEEOqh3a/Lq6LOk4RtQhmjfnRW1bE0i3OKhzwM3bMKBrWMXk5ITb
	 +IRRJ2nHojEP5TP0AhgEQc5LbLLR2hW7cF5KNB+qW7h7OfW2lCVKFSUC9e4BsuBCk8nWZ
	 oHUrNlERWrmJJFbxRPE2zuftDG7m4ZAv4eDb+SsSh62lyWEIhBLf/o1e984+Zj4Mv8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
	b=rBCKo3NfkrBRAWtjhIiuEELtBp7HEKYEgSZp0TTt9fI0tC6DQYAAEIKwhi48UgCme8pa
	 KqVmSOg1Ni8vDH0TySP50d43Uzwn+BALheEoX1fu0f/9e5CrmILuK4tAhcazAgNN+Sxq9
	 R9vI0bfir6w5a/tcPka1VmGlv5FSRmiB/NZl+W5icYSJTeYupvBROvcvb5uBSQxjwwODH
	 GTUL5XwjoD6/DrQJvkcFsGSm07rkAXRbQA3+5Yvo12Nw48B0HdX6+hC7nhvAycvndJcIL
	 1Pe8o95U7HGtGcCQpbtnGr+o0CaDr9fXoQuJf8frmXrt2kppeoF3SBtb6rD+dXIgo4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871518;
	bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qywnbqb1mZImmNEwHxCoKp9fLJT/F9Z6Y5YsgT3A0LEiDlsm24qpIZXGLWdPj8oYa
	 jR6zJ8/azqeKcs9Ap3SijSU/mr1vwFGppgiyn4/Fgs1BQxRcgUsBkkZtmQPl5u6mWA
	 wwiJ5FLzc2S79ON1M1L5zcjm1hoEUUTLX0rTqIKAmLJJa0kdyaKj9nD7o4D4sWjPzt
	 pOdLVWJblhu6IJjEExhnJelM0NE7DKsqxDdZIDj/Zk1fhnxNp7gIBahHTd7kySIFxb
	 d2qETnQ17Yve0NERH+TxNSkVfLVJzb1nposeiH4jNH2FcQXjr8XjgNqpJ4pkifFQZC
	 oE+wL73HMaN9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEB55810A8;
	Sat, 28 Nov 2026 13:11:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1A5A3C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF3E04005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g7cZMqBJ_ME8 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 90AF4400E0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=lcyRNS0K
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90AF4400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:48 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so91646105e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871506; x=1796476306;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
 b=lcyRNS0KV0Sirh1vRGRjLT35pHuAnudz25LUIOexwHYeUQ90Fij/ThHgAa01Y0RV0z
 aSMnnbxaFitqvQpV6OUt0WfY98THNgOXwbWQI3e/mdaWa5mdnXcV25GWACYMeM9dbXqa
 Fs/apcp8z9N7NCNhat50GmK/oa/Qtb0PPdsLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871506; x=1796476306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FUdSv3RxlH36yKMiiAby8OEqtkPZHXBnKMkOE9MiMyY=;
 b=J5TI1fO4eA36V7vUGtFGKpW1F+ABumcRZx6Yn4IXLVCQ5zzG/LfxEHg8+d3EXW9C1n
 ZHhd0jyluoB07+KWHEgyeJeOjTUrisvDY6Urt5xLWWsvh/z7v/AqnZUbdgZFqRzqEOBh
 58+lI8iKtMGNAPVFJ0A7uI//sz8io+Gzd1RYhKmEZox/qcJ8I6wremGKghpJrWxUnHIu
 lJBN7+flb6zp4KNJ13iGMaM5MIAafOtOb//tLuUVl+m1wO85Pk9Igvg5KmFQpvnWwKoi
 Vot5F+xHFqxYvJuC3SybCOGW9dF5IpHteg0xMG5OaBRthfXuWCi6ixFlGWB7mfUtnTfg
 YcMw==
X-Forwarded-Encrypted: i=1;
 AL+hErF+qu4ebIxRr6LonPen0Q9tUISeWyY93cdB750zf3iv45GrajBs+SfkE8a0j19UoY1QG4sh5lU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Y69DcCrScMq3e45AXvf52NxvwUQraS7irB+0Zj/y/6IFukxcC
 IROH8u+kWVN6iDHF4/mTK3hMCUqJ+oQ/NCqL/YMf4PiXP1tAKyDX9VHSDC7L3SXd/6g=
X-Gm-Gg: AZFdTZdmu214B99oZD11iNjQX708Ob9m0HEKG3wAsydeDyUJtBkylJEzrbt6ZYx2rR6
 MJsvqFcQk8YWwh9+GnJebIFJwy4+bKJUZTrBhzDRUS4r6ur5JpWgCzanhK5MtMlc9IVDEf3TniA
 h0RN6QpopBArTrrfTwMlmP8IndU17Fxt5IwyirxU55v0hca8cY/R/BhFjBt9BRlKuUK2pz2CLP9
 iO/TX2ZUPFHXCioev1cJmhrG5JV8nIbqXoyySe62YD7TVIxLcN6RjvBJQ6xjjzyTPSwYLfGblwo
 tY0yqynsLUZtSqr6GbrAbbJceRMkH0ui/uSd0I4S214+qMqwyx+PpWJqmn+RcCbDrkNLVvyN1RV
 9PAZ+4m/oBHUDlfJ5qX6AswfuqNb9r0gJq+rbVvpVUZ44s7egK+x2dGgJZVssagwwKWwlOQXI8k
 +olxDrn7PDSNK48/z764TDI4a0/1BTOEzfhig1FxAen5g1aOliZAHF8G1aiyE05B5QU6TPUltON
 jJ/S+phuIxcfeKK++NajCDDIk9xOPe0l4/xZdicn3fEQAt8YMlD/SVQkTzKyM3RaAKo4w0j9mjL
 lprC3WKIaZFP6jk6G3m7LBPimhT0HSHuOaND2yzyHKCcHrZUHjbdWtxySqqX7AWE0ZmgC4NuuuZ
 HKtI1Yl5cVueG6r20QgjjlvCVm3g56iESjgy1i2BwssNitF5nm6CP9mjwkGZFq/YHGQvWMDd3tE
 cvsD2rj75qFzC9RpIKU8P/J9iixg==
X-Received: by 2002:a05:600c:1547:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4bb8880974amr611060355e9.8.1795871506479; 
 Sat, 28 Nov 2026 05:11:46 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:45 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 09/29] arm64: dts: st: add pwm2/pwm4 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:26 +0100
Message-ID: <20261128131125.2141352-10-dario.binacchi@amarulasolutions.com>
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

Add the pwm2 and pwm4 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-10-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 3c7876c003f01223e111444a93d5861d86d8022c ]

(cherry picked from commit 1d936c8ac7bcd3a7d8aa42ca88f8fbaaf3e63194)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 6482dd47e977..695c9d771853 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -433,6 +433,23 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm2_pins_a: pwm2-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 7, AF7)>; /* TIM2_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm2_sleep_pins_a: pwm2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 7, ANALOG)>; /* TIM2_CH1 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm3_pins_a: pwm3-0 {
 		pins {
@@ -450,6 +467,23 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm4_pins_a: pwm4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 12, AF7)>; /* TIM4_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm4_sleep_pins_a: pwm4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 12, ANALOG)>; /* TIM4_CH1 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm8_pins_a: pwm8-0 {
 		pins {
-- 
2.43.0

