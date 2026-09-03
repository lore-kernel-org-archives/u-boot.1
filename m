Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BDC79F81
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52B52810CE;
	Thu,  3 Sep 2026 13:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NTZR6po8Miku; Thu,  3 Sep 2026 13:44:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7DB3B810D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788443061;
	b=UifusSU/vjE5fhBMr3xgoQxxyXEOjgpi9FLKsOaR3LIe6QjJYrLHzyTmzsYEnEQzRruk
	 0Fn0jOoyUEGqWJyl+4ov+zEP0ART4GH/RKcn2FnbsITCnVkr22NnbmnSLPIfIASYIpKHy
	 LIMniJ5H9INOnpu25oTUZ6jLoRBbjLiJgiSlZkZbVe5TdqJmiUHt+oWES7rI+uf+zAvmJ
	 tzauc6L21UhxVelQrQI+ISQkKWkxRhBsF6dajgF7Mvb5viNJMYPm5caw9Yf0vb20j3KDe
	 76ZzWyDyHyZIW/sMEWJP/wan/Lk+PGbyLcuMWQhYb9C0eJYODpAt9iH4GLNrL0n0RCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788443061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vuuKvEYNF1bmbEDwPY+yQMkhNr0aAZZDU0RK9nqzJSg=;
	b=HkirGEhiahJYSCUBJ6zCoKsqiCYIezpg1UxfgioG9pU+kMzei7cvzaSZaqwtpIW1wnnX
	 upvltcMZKaY2rKKbcIJicBqVmV0GgT3CXw2gKjQVJDKzobhpkMR6wQlqraAgj6Mflo0qD
	 qcBO5AEKtMnaatbLI+9Zi9bw0rKLFdKyg8a1nj3qhv2Lv+n117TzzVqOH9KDnB8d+T5tA
	 kD95qrsUKFQA1S1ylhEl+tXZYM348wdASe+xllSpkjKQCF8R7F6gM+eNOlJqfFTEeXggu
	 FOR5EgBSUlK+O4os5I0rYvtynE+tlQXHBkPpLLyYCsczEbMbzI/CI+MGPXSLX6RzQxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AUWGoDLu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788443061;
	bh=vuuKvEYNF1bmbEDwPY+yQMkhNr0aAZZDU0RK9nqzJSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ens0ba5IXip3JUOd6mDtb1I5mFdz4lEAb0BWUnDDNwxAqIKsVIWJNU5+cwkZ5Ht9E
	 D28YkB1GpMPNeID5940DT0UMUVUbyAd2hxYmaJOUJWLvTtv5FEsTDgEusVBh9KvhTR
	 63tbPrP5+6ESgJ/kdE+idkReazvZaBxuDQmZgXEoYJIfGaAomMpPFy4K6o9s7hosaB
	 DB85L/u4OYA+8cP01CuIRFITeoGit9g57P2xr1sIqIfJXRxdq3Ce7GWAoAiPl+9CBB
	 Y9vOVNIx8w3TkoPjilrQhDC1qYW2ZhqaZbGbPL2lFyOdcRhI8xPGu45Xt4RNQX2Ze/
	 y09hRhNkHZqXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DB3B810D8;
	Thu,  3 Sep 2026 13:44:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEDE422F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0A8880FB0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aeskCNzWK1CJ for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F063A80F72
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788443056;
 b=E8qcIIsNX2vEJv/BjIQlOiLqVzOqC6+by7BmWxPupeYNlTWSAEDK1Z1MwqcbbxjPJd44
 CGHtEf99Z08ejPNiqgO3mp+u1jkD0UTTTXX1/kdCRMu0XdjFXPXaJO2geOE4odjmocDI9
 xcajjgQi/Z9Rt4ps04myB8XWGtvdJtQ/U2UWZu0THU3HcrfT7HFbzfPyOTptegpZM4p0d
 uRi+W1xhF7pZi3EfiXpTaUH6QIfLO+Fwo6HAhHMsHL+tjBk/P1Gb0xVv7nmdRzugMo2cB
 wcEjEFgUwUhefJ4igJTcgiutsnMLMAKuHFhFtJuiGEzRAjI9J0+uEPCg77lZMtqRTCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788443056;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=vuuKvEYNF1bmbEDwPY+yQMkhNr0aAZZDU0RK9nqzJSg=;
 b=sG8iHvXQVwqcsla5uZeQcxida6lA1/dUn92PWsUSz8T7yQjdQPAZdWhbtStg/iFM3c6u
 T1v0n9GMltyfEcHIP28S3XOaxzMEf/+BEg4RyA0XDsktPLl0o4nDI/nPLv8TuiKgRGCOq
 2H6Yh3kK1c6v8u45eE6UGrVVR0s8QyVYkgBXf3ju5s35mt5z9uAkJB0bWbtFgvfUDDa5j
 ZJXyfZ1DWWwQKVU7ZjTSvzlfZFVyQlELlb1NGHXxKa3nYsrdot+2Iuqo7OlhYwQpcTSdQ
 AQepQ+gN4tWQgyChukb6xJEDp7ryUsj8ejUnvboGRqTukqy7TjwcoXucS13SNjW+qZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AUWGoDLu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AUWGoDLu
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F063A80F72
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so1615498f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443053; x=1789047853;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vuuKvEYNF1bmbEDwPY+yQMkhNr0aAZZDU0RK9nqzJSg=;
 b=AUWGoDLuAZR+F9F+Xnd1dgyzXwofplsiTYTp/leXQGz22hVwHH4qDtwWPtRJc47WaI
 b7nKWTE7F7New/zqz0TyPp4iLjPZ5S7o4gA55Es+mPqMVt/aYWLf6rk/5DvIJbM6Boyd
 7HrA+eZWnzGJohCrEWuaLX1Y2MKYZc6O+CV3NN/Cu1mZhJMEOfYdnRZq+L+br+KHzw8M
 c6Ej1guhwDzaqrkX9zgDiP92eLKZkHwC1BUz4v4XYJW75LdVeex2ZW61LrNOHO2Tlotw
 TCnj4F1mKI+zwJ7JEajSPKHntdYjE1IsPguwiLARS5rBEzARjIfswnnBKxP1BaiB86iU
 v13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443053; x=1789047853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vuuKvEYNF1bmbEDwPY+yQMkhNr0aAZZDU0RK9nqzJSg=;
 b=qiYEua9be/IA9QiwnWplzEcK9VAgRDU/yvgz1S5Bo8utd1NZ7ilfOLEDPiOibGABZq
 YBH3aIMZu4KUuVLJTWLzSjlk8IlJ1vwAvRMLbUSHj78RzoDd+b0H9tiOFGaKbxBCL+hs
 nL57ZjRdsS3GNcTQ0CkTCaqQqJ42KvfAucHXgU+H1VycB4+EHJ9sWqavlX83piV4iVxa
 5cc2sH8glZ6yYI3NOopQjEZgfwPeJ7DXs5g5JFAv6cgmQzsywqTU8s7KnwuNpNxvMWYy
 F0Yhygs+CRtYHfRaH5opqIT/Hw3o2N9aIJWJSX/luybG2P1sdSpaORqHDXPuyLlzJUr3
 8Lvg==
X-Gm-Message-State: AFuF++nX93XP9HA4eOWk8HG+/Gx1PllugJl0SRHRJ9SL1pSxxn2M+sfV
 wmK2nD/mTRC+23WHjMOci4D7WwbDqScdBKcyP8PL/FDtj4WqKzUzUhhB2jbgLu8Njio=
X-Gm-Gg: AYBFou1tSRrkR3o0rsStvyVuGOlD9anAUH2p5dsIHOZzgbAgvJOmMXY1cM1UN1R+L0H
 AULQjN64WnkyIjTtcrrdG4ZF6fHJSS5movQuCa8vyyIJofjJ19A9NZKiRuYc+hjiBvUnmd8dgAg
 GvKPIcN5L0epSmrxtZuRyemjEIS1xgxGe6cR/ydzrsECh+P88YC0PV17+ZFquOlI4+nuL/IYkHR
 og8/ie7fIrg8CjRRZR57n6f4JC1HwYLk59/IRvx3+On+EcLqLGa+Urvwts2Q2QCrIHDZ+flCgB6
 4I7X4DL3jWOT2S+kGQetoj6qfdhSi3IO2n+IjuRGxoDk/mKB+odakQ+CRU0kLuKRImmH1T+D5h1
 jPUoxMnkdgzg6uGphf3nXcDGkmMfAyVqbyiy2HsGH3EJ4My4YsnurB22iI5hv6ti0w2DcghC3Y6
 EvxvlDv/IfkgC/0IrwIbXqKBBB7EDu051YPyCjFF1Pyl7UFFXOmBr+wwSNiw==
X-Received: by 2002:a05:6000:4b19:b0:482:e4bc:51a8 with SMTP id
 ffacd0b85a97d-48488f07a87mr23668012f8f.7.1788443053374; 
 Thu, 03 Sep 2026 06:44:13 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm14191494f8f.18.2026.09.03.06.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:12 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 03 Sep 2026 15:43:13 +0200
Subject: [PATCH 2/4] arm: dts: am4372-u-boot.dtsi: Add tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-2-47e1c63d188c@baylibre.com>
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
In-Reply-To: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=565; i=msp@baylibre.com;
 h=from:subject:message-id; bh=YdcFoozMlDpxvQlwerGC4qaB4nN1MeGArlv1/Kyg/3g=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyZlTN+9T+RqrjFXcgcsifbsjDlg0PKlJffbr58/Scnd
 GHMpvNnO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiczcw/JWvbFV4f9Zt6/EP
 vw0VEpZWLfsrEGC1TXROiJpmbJ34hxhGhmftJzY+9SrqaFNQuv94W9rbzi+tvF7nHjJ3q8u8zBO
 t4AAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Add a tick-timer definition for am4372 in preparation of OF_UPSTREAM.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am4372-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 0c498bcf085c..989249ca2878 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -4,6 +4,10 @@
  */
 
 /{
+	chosen {
+		tick-timer = &timer2;
+	};
+
 	aliases {
 		usb0 = &usb1;
 		usb1 = &usb2;

-- 
2.55.0

