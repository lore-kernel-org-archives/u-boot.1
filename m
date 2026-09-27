Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134BFC9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D18B46067B;
	Sun, 27 Sep 2026 13:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4v8qT4Sb-U0n; Sun, 27 Sep 2026 13:17:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CF0FB6064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515046;
	b=fxVIDlOCek3MUfEKhhnBuKQvoYuAIUPacsS3TwIwApJ0Nc+4owMKS6bV/QXwNjzSSdyl
	 CD6WuAiNwFwbcJyz5Ycuh/m+dMfmN3Id5KmQXX3g2xjC8NdDoXrsoc1/c/sSv4j/Wutuw
	 VHULjEGTMV/kO48E+0EFI3dJqJClax9u7+7zkEjkvBRKoPLRyHFSH9hTlGE9fe3xN1s4G
	 lc6B+Iz0Ju4wU4JTK7Ep7YHCWrAhRrb8o6bA2vKWtBVsqF0dKR74a6HFI0u3iT8oM7Vwr
	 LdMeOMpRDbNUkxZYTV8zg9LveKbLpAMu8iMaUcw007A9BkOxsD35NCEDattdPPLZQ5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
	b=WuAS1j1tac3i1DZrtELnTRldy7qsjFLD71vj6jdE7ABOzhCf2JhQAf2pgcwETVC6wuSx
	 jILcbESegrP/7HA4q9riUQIFs3fFbojwk+DgdBPE2ToA4pE0KXC1OcURTKeWLBh8iEjFC
	 Rjf0bhW7deRtFe0J7RStBPYFQ9Gyiep4pGDF+2DNk4jXEbfMYRfupXi2ov2PJdKj7KSoD
	 NYe6ulXHPsQK9oeP8/4eZ99XdB8i2O1vRaMhL7FqlEEhmDdO005fq2Wn0Yv7E6W69TtSP
	 RI6M4gGK2ffJ5zX1ZcCJiFKQz7bCegDG8DNCuUtHl1FLwCiFM3/9Q02RuNL0xJCWsoQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515045;
	bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z/7kUcCm0ms53ZK5zu4Z5UGETJ7+M4g4bARazieQ3Y59kTw5jLlVgz5Kti52RN3zY
	 wYMx7I6oOQVPBgBKPYr6SXKVBWD1bXptil3tvVuGKISAYUVVfaNp8nAXXRs7hJfv9R
	 ySn4kqt7Qjn+1gtpmAokSKaV6DlonXjJZ7Pc5xbRw6jEbO2pfwBTeJL9y8Wm8bHcLS
	 NByegIru80zqWXmVvPYgDaR2Vtbt/f9KdiQL3SmM9qJ78JI3LnEr81BdxR+hsOKZKs
	 1Cdx0+HVgC/l8x5IQpehzRZeNfFPniLMuTYBRv0y7HyKjmHWOaT+kEzl05sgm7hMY7
	 Se0wRTeTdMhnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF0FB6064B;
	Sun, 27 Sep 2026 13:17:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 978CD3D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CF7E80FB5
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c8mCRIChaJiw for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7EA3480FB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511301;
 b=sE8gtbg86N+ER3HxDdRHuhk8Yb1PQzrFmk7a/uRwin6z8yeU1hEUoFfzpnwLlq22OD2s
 5zHskaYCttJDQKJ0bkw/YKY5kChvYIUuSWN9POyBWqPlqYGg7Q8IekcuHeLDzm9Ll2CBz
 3QgTmbaeiuVUKo9njUCswu64ResUdje1VVTQsC7Vroau5T2cTfcZbtMstcyEW3UGUPzsr
 woxpUxTHhGJxi03qYUSmnXIuGaM4oG05cZ/bY8MG0ameEzJ6bfZ0Ub1hu0+ohC9iSoi0U
 t6mKobueQqH045n+V8cmodgR2feOXQK5G9+YV5SgH5u5j5ykaOK8CDd4A1dp8wJr1vA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511301;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
 b=CLdg4O72UeNRlSqu6peFOtB5r+KqyzpYt0BQQi/DxEbZSGLY8gcqP2uD2wAUOOiJ20Zx
 mq+kIvlSWgSTfMkdEjrOArd7UPFiNDiusG4dPfA2A0pAjNIIh+nOzUeGLd1Reoj+0EtYo
 G9Kj6IfXD3BIM2kTstXWpYaAFMXaMrA6HsPgeyi7GiPq2cGOEEh83o9NmcsFqjjyWxW6O
 kvVK7xERFriogLvgHt6dqHwwhps81hpgPrGuB+l9ny6EIJYZ84zm8Fxl3DectuYeNyn8P
 f0yptagLvfkkx5sq+Q+QwHhF3RIIrNa/fF3hfswT7lVMcaWX5piErR03vspMT2VEG6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=YmjdQbB6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=YmjdQbB6
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EA3480FB4
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790511003; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YRVipF5DoGoSzTvJXOUkCE0jNiZ7YSNRLNTgu0KXiLS894L58MstBh+d/5UMOlJMb7xKhLLiICfGE6FzWrGpDI69mXjW70TUMAO3MgG64KWq5dVhwpp4EMft9Wvc0yuYB4MAj/SlzsFOzfT7FmiJF+mjsjNoM2AOtIYN4Ip5/zk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790511003;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=; 
 b=dEF4bdXBZmCukOKpR/rCXv2iFf0kAR9yl85+dyxr50dmcFh2d19mjdT6f2zGdWC+kMHylLXGANENtYMEu0mGFmp5/cVjd4aXkGyyxrTsFery3aCROxAY/ouc0B3+T0cRfv+vKPW3cCapjZsqQ+6lYQf9KM/rKJxL+MFr2ksqBqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790511003; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
 b=YmjdQbB62VmhYrNUXg8dM0IGFlJnkrI8kRIp9HyDAqwL8/wDSKHQzz4u7fWxCawz
 ox2MDkRJGpI+PhIh3bc0v1EaoOUKXyJLEp3bn3iYi0ABsLh+z+1W/PLS8QKRxdtCF8c
 PwZ2vTagAIoLgo5ikbcX2kdIMByWkJX9VdO31iV8=
Received: by smtp.zohomail.com with SMTPS id 179051100335733.05175860561042;
 Sun, 27 Sep 2026 05:10:03 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 20:08:59 +0800
Subject: [PATCH v5 04/10] riscv: dts: sophgo: cv180x: Add PWR_GPIO controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-4-7f64983e59e1@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112277ca26fa1e249dd69ce690e0000006d30a56977aad9bb46b9666d7f76b556568620923f645b496f:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:17:14 +0000
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

From: Chen-Yu Yeh <chenyou910331@gmail.com>

The CV180x/CV181x family has an additional DesignWare APB GPIO
controller (PWR_GPIO) located in the always-on power domain at
0x5021000. Add the node so that boards can reference GPIOs in this
bank, such as status LEDs.

Signed-off-by: Chen-Yu Yeh <chenyou910331@gmail.com>
Link: https://patch.msgid.link/20260725175346.139173-3-chenyou910331@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 76237a509a0e91665c4d9c96b72a78ec66ea3fe4 ]

(cherry picked from commit dc28678310443c294191632f6ec175a62d53e767)
---
 dts/upstream/src/riscv/sophgo/cv180x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dts/upstream/src/riscv/sophgo/cv180x.dtsi b/dts/upstream/src/riscv/sophgo/cv180x.dtsi
index 06b0ce5a2db..8bf67ee4eca 100644
--- a/dts/upstream/src/riscv/sophgo/cv180x.dtsi
+++ b/dts/upstream/src/riscv/sophgo/cv180x.dtsi
@@ -448,6 +448,24 @@
 			status = "disabled";
 		};
 
+		gpio4: gpio@5021000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x5021000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porte: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <SOC_PERIPHERAL_IRQ(54) IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		rtc@5025000 {
 			compatible = "sophgo,cv1800b-rtc", "syscon";
 			reg = <0x5025000 0x2000>;

-- 
2.55.0

