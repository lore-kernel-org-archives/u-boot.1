Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C317606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=01UvN2sg;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yqfWMCq+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FCCD606DB;
	Sat, 21 Nov 2026 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEeqB_B7AIOF; Sat, 21 Nov 2026 13:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63EAE60717
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266856;
	b=PlABTccr3DA9cR2VyswTh5KAhjKAQDYYOqMdmNCUGqFGklIMzkBdP58XTd7REtEWMklJ
	 lGiZa2VWfVXXo8MjVCsvKaDH5Xcd4DyFu8iez0EB1ihzYW2zPIHcAYBATx0jfQHKe6JL1
	 zNl4aoMWbugKJZZJxkftNvF+4rGCmfyJwZuQ+DU8fiuuOUu6s62PMqb1Bg6t6F/0s679m
	 rS3alFV5n6pXvHza04V+l5NSj+SDR1XK9VeVDF+6Bp7p32UibWyz0cJxEU7yjtZti0Z45
	 WzXKA7P1Ykovfn7tjGdeCr2nrq3JuUuemM/G6MqH2B0zgGqgSg2R/HC8EBGTwEeHRKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VUBPW7ig7aM4pWG0tEvtQ1s3wh9wRiYMNQPoCOpp3lg=;
	b=Iidd75TxXAy9/8BL1KsoLJ/9UADCck6pKWSbE9pGiJA+ynKdXE0MusztbFpKECd47DaT
	 Zdf/kt7IPGKC2RBCEArN5VozXjK6/32VPvvrl7SoRB1belKRKWIM4bPHhWZ15FvaJ8q7Q
	 gFV9cROYjZLWH6i6r9E83DIVMcNloZgfc0NT2jn2T/FOGgrLYJDYJ2kyWrI92UYDtLAyi
	 pvRWtmB9DBjlcjaP437P5aqkInP7VMlPaHuIlqq/wBHfUJaxyIOS/M0P2KmfjgSmdoKLY
	 9R7Tu2D4pMKKe9RB/rU8sSE8J865yr1i1gUwxy3D02S+2j61u9u8eyoGGfEZUegxsLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266856;
	bh=VUBPW7ig7aM4pWG0tEvtQ1s3wh9wRiYMNQPoCOpp3lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=01UvN2sgaUOgaQ21NybhalWX5G5x5uOsgPUxTk74Qk+LYxoSIb2VZPBLpUjI2mhCa
	 E/2CqKGzEPQyJB5dbdVCyPg/rnzQ7aBUd9OKPw6UuoTUux/TEVNkVO9pK9UZob/4XY
	 8hUR/UFIbKqf+nHALQG8ZvNkPqy9uE/i6S0gRSStAnq2Wtco1aNn+JmTE29YpwT+sn
	 i/BtaV6fg5++paaTL/9D5QlNCxegvLIJwts4kAx0iMkduTFr+GsSQ3MlWsapdZ9/su
	 VccFOvIPXuoBrGwRy3r5V2q7I8BnsksnLT6R47jz772XxdoP+p4a+3XoYhSmY7jhrv
	 cN9HmxP4hCQMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63EAE60717;
	Sat, 21 Nov 2026 13:14:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9446C465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 862F6409D2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1qeQzIYKBnP for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B85B4068E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yqfWMCq+
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B85B4068E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:53 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c504d4cc6b7so17008566b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262032; x=1795866832;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VUBPW7ig7aM4pWG0tEvtQ1s3wh9wRiYMNQPoCOpp3lg=;
 b=yqfWMCq+F3qaz//A5yVU03wgsroT2VQ7TWVeoFFpzfVupuT5MyUo3aLFGa3HRWk5JH
 VD6C6bklb4Si60omWKqn2CKuCS5OFR6uuyHcGEJav+Cq9Ytcy4NTb/qfaneRc9sOiWWR
 iOjW5Z9fIZXnHTg9lNed4Y8rdNGIr9HJ20t3xoA5hKgKg+7tmX02UbXoJVZFaO9tpkhG
 yBF2TtsamrkekhR151Pn5lIfoz6yj/o5142i0XGkV0K2l9qhiK0mJKh1K2Qp6UbHUuuJ
 q0VJ9+NY7tgOgpwTxWWNrkxfHfQtBn8pnNWI3HDuFGwfRmdMH2x9bBFTWL1ntW6voqRi
 0n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262032; x=1795866832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VUBPW7ig7aM4pWG0tEvtQ1s3wh9wRiYMNQPoCOpp3lg=;
 b=gcx8h5JPSxznV4o0nR+xKXSIkE0KRaWih7jVSZ+7dF6+gkw9QuuBfKUjhpmo3PzcGD
 8x8S/vHpk1OlTys99MFU+HQOJ7C7VOqAnIwpUYe3vpmDJoyDWgsunozfioK2YX8evADB
 nvIOjaAgzx9KYVVWka00Lqq3oEXo7cLtywKtOjOnOs2RFXDG2qdiLpJ7YM5dAdvoAqHu
 xhPqVGmjxaSf8gjd1O0sdxuLXXerc3v2o47ZJ3hjW0NACG8rY+CLuaUsZe6tpIV5//u+
 dW9KdYycEarNy0G0yt72WSxqUBgWlz6H9g2f394J6ZV7lOd6VOnuhKFcNAmvbHi4eSPc
 YhrA==
X-Gm-Message-State: APuU4Z+QJ10N+ZFArvAkAJO7Ry2KuCyEDD7+pTBqszZCUGiEVN1lBjm4
 G7Vx5bNME7IfpEO1IJtf0+VLEaHrLma2lgLFIZgMukYnwGgHCsxah87WBGsXUwPI/QF62vCvNc8
 sNR7s
X-Gm-Gg: AZFdTZd8dfsCel+59vkWld3Hj/w0iO7Xp77x4dsW/Om7f0doDsQrLDkgdRnjziSKO4E
 oo1B0Xkaebt0IVNbTl1kT6YcwODqmq4Ct7t+Uzt+iC7IeINU1guMJXwC7E9L/fz3/AJzFP/P/P4
 nqJVRLkk5Z28s2e1ufYWRSlLhm48tFDUVdTrztwX0daK5ewNPznELX1zyUSRW+WYJO3E3eNOBA3
 RL41UPCXxuT8bReFQHo4jA87geHnENcQ2sUxkREvbRltHTdlf8aGhvVuWqTnVSchf4DN+MxxGwY
 HXJgJYsL7J9yJdjqdGbdPeCiqspvga3Zl43y6fNNDJlwnkuF/hluWojiczT3eBOBYCc6/nDsu9V
 QNU6Eu0t5vkJY1V3dH/9JBcGwp3RWo+VuKlW7pNygIPwgRzC/hZwvtnsPm4Yo0dnBY7rezl0/29
 bJXuScgXzBFCQdWESvplPAgA8D50tBtkRlS1S60p1TolYMsJi+T8Day+e2Gb59Z9rmPhyLZbP2G
 XjJx1htIKS1oFstx2v8eHQ1Z1Rsyevc29Z/sD1Fi5B8UMU73Yz7KCA6g9amvRMQVKk4Nal2LG3n
 QVBJQ8/D8A/H3l1zyj8A56SgKWbLS8oIgHF/OKeieecsZW/IOaIyAgrnoZSuHhchgTFR/+Z1Q4n
 LYCF410ZAZw==
X-Received: by 2002:a05:6402:2714:b0:6b1:b5b8:b695 with SMTP id
 4fb4d7f45d1cf-6ba37acb287mr5905245a12.0.1795262031915; 
 Sat, 21 Nov 2026 03:53:51 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:51 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v12 03/31] reset: add reset_control_assert() and
 reset_control_deassert()
Date: Sat, 21 Nov 2026 12:53:07 +0100
Message-ID: <20261121115335.548142-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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

The cadence PHY drivers and the resynced DWC3 code use
reset_control_assert() and reset_control_deassert() from Linux. Add
them to include/reset.h. They call reset_assert() and reset_deassert().

They return 0 for a NULL reset, like Linux does, where NULL is an
optional reset. The DWC3 core calls reset_control_assert(dwc->reset) in
dwc3_core_exit(), and dwc->reset is NULL in U-Boot, since the glue
driver handles the reset.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 include/reset.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/reset.h b/include/reset.h
index 58574b983f66..0e25fc60d445 100644
--- a/include/reset.h
+++ b/include/reset.h
@@ -519,4 +519,36 @@ static inline bool reset_valid(struct reset_ctl *reset_ctl)
 	return !!reset_ctl->dev;
 }
 
+/**
+ * reset_control_assert() - assert an optional reset signal
+ *
+ * Linux compatible wrapper around reset_assert().
+ *
+ * @rstc:	the reset to assert, or NULL
+ * Return: 0 if OK or if @rstc is NULL, or a negative error code.
+ */
+static inline int reset_control_assert(struct reset_ctl *rstc)
+{
+	if (!rstc)
+		return 0;
+
+	return reset_assert(rstc);
+}
+
+/**
+ * reset_control_deassert() - deassert an optional reset signal
+ *
+ * Linux compatible wrapper around reset_deassert().
+ *
+ * @rstc:	the reset to deassert, or NULL
+ * Return: 0 if OK or if @rstc is NULL, or a negative error code.
+ */
+static inline int reset_control_deassert(struct reset_ctl *rstc)
+{
+	if (!rstc)
+		return 0;
+
+	return reset_deassert(rstc);
+}
+
 #endif
-- 
2.53.0

