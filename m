Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55405606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X5tQG43M;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XsE7qmx9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 317A040586;
	Mon, 26 Oct 2026 23:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R719xbks2oYl; Mon, 26 Oct 2026 23:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71E1D4056F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058412;
	b=EWtTXHa4AlrpWw3IbVQYClRxyF6NVwnUU5Wofxm27D1q/hod+FZk+ojP5THV16K6M84i
	 22hdZhSZ5vKcn3Nmj02hDM4fMA+9S7FZsIyZR1eXw7j6R0+hNkJ6FtGFPPc4KCXQ+MgkV
	 Y6+qczlrXxJkMoi8bH8yO1MWfi6f3f4hhV5kt9UoOqO7UKPzMpcQG1bSAV7xgDlvc8qYp
	 nIsXCKMKJTFoWcvwZBqP4VZd2sGXi1pbcx+q8lICFDpzKco/YmpU+GRUaa2hlbOKumovI
	 kcDyYWbk5bq4g4OMwK/vZ88PJUrUcD8Hd8I5mNIBla3ldA1U275kvgmlXRq7J0D50bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G+cl88VBZgduUV727lwkO+dx8BiHqldx/PlnES6o9LU=;
	b=puI71uG6PXkQh/VoShX3/eAJ0X+xEYAR+3As9i/9IKEqLvtUeOcrWL0h/IOVopkXbkvp
	 j/yT5EGJwNZ9YokUnpqc/g2w8NNuY4jEJLhG+Fjcs3H0Dysc3CCI7oSNZGtDwmA129l+a
	 nPB6Tn4imS65EyEGdNo46Tv6KeVpNiM0XNWyrDPa4UR9upc8aNohnDRRLvzE3eYDH7KWa
	 OdDtZJ/S/GbJWAJGdCspcdoOgHuOWvdxCZkYDnMgCW0rgu7L16xtoF5KqnOFg3EBrwhKK
	 b+Nvs43GJM2mbX/7u61BGK/WrfZ0QbvJmeT+05u6iBfjfY521lfLrvM1BPQglfJpXrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XsE7qmx9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058412;
	bh=G+cl88VBZgduUV727lwkO+dx8BiHqldx/PlnES6o9LU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X5tQG43M7e1BFSHMzYLYQBiv23g9LtCLQrkOfM79E2nCecS4eiDgHyZKSa1pEvEt+
	 xVeURkN4ZtoJAuDP903xxzu38YWIofN5HtU0qO+J19VIZPLX1+IOTNst8IJ9WcCvE/
	 /SwruiQJ/4v9B/aX1uAowdHE8uwxe+pvVy9x1zXpLpa5h1O9lMMB0KrTHWefwCTCN8
	 xrVxmtZb5HYBaV8whAriEGztClCo8Vv+p837dOMiGFQVB6XovwA7TLAJaifv1RVLhr
	 Vid0UWc974YU7d9Bd993/l4tWUU7iwwS6BlACXUC6Pp2ka32SgY1uPZO8SkIWjkXH2
	 93kTBaK1JeVCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71E1D4056F;
	Mon, 26 Oct 2026 23:46:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 387C9356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 367484050E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQHotT-1Gc0e for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7788F4050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058405;
 b=g40CFkpIOnP3Tswb+WFd8S4uaWdXNAt+dZ+KVjNkE+hCfpxVn8YLHoL5Nm1zqSjdony7
 MQrgMeLOBoGkW8X0obIuEkIA8w6fgeNRiw74+IoIqOCsW10MBuPl1stRGOgbS/ARfofwi
 SJBlyf5gkqZIKQukv8DlBPN+raioInNDtl50QbnLY1vTCDp4fDIr2G76D1afOr5djttG7
 vphKbX/pxMiK22MunwIvzN7WV084L07ZoR6r8/IkHgdvw3if/neJQRhZrhqCuuYNigo3R
 N7TwhBVtbk1II7mV9hTEX6fR4WEjJ127Ls/cZLpnKavM8KcE1mYb5PLGVNWdaXbdloA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058405;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=G+cl88VBZgduUV727lwkO+dx8BiHqldx/PlnES6o9LU=;
 b=qGT6FAm6BomnMcCbjiEOZi/squQCLgpKrhN4+YU2+zw9CvtvXcH97+9rZAI56d7curfy
 Tb8ysaJduek+8GlQDa9sap/Vwyx2o/txb/j1uFmR0SVB3H0QCZTbquPTkBkE454HJRaHn
 jxcC/FEH9f58T9RuK3MEsWb4gv6G5CtFgKMXQy43LaSrfb18vb8bTLO8wRhD+JtN54evL
 JhmDo3ME23A65RqN1Ny3NCMgNfroZrFGuAvkEJ1O0J/rmJ0wgO4T3jxVl5TA4PL9i2ty2
 W89uvy6n1ZXWE6d2HVFdNb/7wAUcT1MclaEkQTYxQoBsFR29oSoAZFpndYORekHznyQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XsE7qmx9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XsE7qmx9
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7788F4050C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:45 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7f84a55cc06so2182378a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058404; x=1793663204;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G+cl88VBZgduUV727lwkO+dx8BiHqldx/PlnES6o9LU=;
 b=XsE7qmx99qzvi9kvKFTsgsNc8rxsXkY10aAqKr4lvRAToRe4XvXkU9rrv16u3zF0N7
 rPkLV3YwLt7achZ0YNceq+GK2VFoVRE9YOTC4qFdEh8MUAtd7+Zce7nqEiQVkiHpMuTg
 FUMGkyjz5OAkn4AIFgh9BKeHL/pUI0UmtgD1onEPWbed+NevulBNDjzkvcnd7W57dhl5
 4mNkjIeQ3rA4aocYcRJcKLLH+9NqGGyZw5Sdq/NN2lotR3XYmrLtYEt8xkZW/JXROHfE
 g3J44yxt6wZqExzhqMQFpc2RdmNSQ5cLxzgrbiVMwJ3rZcoaxENAeYqCnPZ5O6tkyOEa
 70yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058404; x=1793663204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G+cl88VBZgduUV727lwkO+dx8BiHqldx/PlnES6o9LU=;
 b=QNV0/D3b3CQT0VDUDIwNxYixeNtEXxKgTttlvGALMS/+LuPksSPpAhLseSQzczsN7c
 p67LDkKgLXIwJ8opaRCM6SuMXdlwuAVoK0b8zoWvz0GUASJGBKUHvu1pJVphUG6xUHol
 nbVQe65rfG3eWjMOcJPzgYmoZfQCva4voEYG6vLFOJf9ECBTqqEzoRMBmx/hSeY682vp
 vePu0M8Z/wrBXLoQ9XRQjDX1yZEPOuZxju8X2Q8E/modgtRvrKUROas9d2Q7jPu7eh9R
 wMglz4gn5c5or1zbkyQO5TkYRPDU8AeNxKTplUwh3t1aBotFL0mtIhiHaYIOVCe5KbDw
 sTbw==
X-Gm-Message-State: AFq9FYJztwKr/41UHnl5Yi8A6iPiiNYmknKGrWJV2oBa83w1n096tc+J
 X0rM2fuQSW1Mjs3K85f5G5103P0pwjHYdTmOdUZ3OOP+RuQgwvJuAz//
X-Gm-Gg: AYBFou1rHoKDBXgRqBEDkz3DUSYR4YHUnJKRoOrxj1tUJZ+BBBkDhKh0gG9PI2FluHP
 J+QhTEWlyphRhgUMnXHOG4Eh1P4DK3vZXFk5qWnd+6g++/F6nSuezBVUZ9KAxGo7HIEdQ6KcePL
 KUwmEOud+qOJeeCKLzDVVoeVEA51Rg80o/RyTg/qDGqn3gRFUPH8HGQQDazkxN2aPu/ySMNawZV
 6f+EE37l+SjxKDydjX0+peMxfoSptRXlgAh8lKDNQQd6jpTYaY+cy8imoAabYtg6lhLKvDE9P0c
 8gEsXq7Z9j2dNzJ/2UISCgC6lLa4IqWZAQGpLo9p4qwR7hkwttFOtUGzruJOOml7/zU4Et0Gltk
 J5NE8dHmrajRfztEDLOOelx8hDf6WwvnXHYm1bp7bHtI49IQQdndITmuTT9QPocOKXGMz8Kh/vy
 S0xFc0h/ABKX05pSLzZMQ7JUrYoIr9p8SYgt8FiyCV1ucAN/JOMCz8D/Pi7uwcbbpfO+wLh/5jx
 lXp7sTesCddEhCQsmadbbr0wTd0iJFdlxbN8dVwGfYXYoBunP/FEf6Yfu+2FhNS9nTfycI083Of
 TpqGD53SZUA5voKz6z7DqONaUtIbIUNkQ1e82hTUNkzl3BvmKJDuDfqZimPFu5QrM2/Ndaqfh99
 XHxkM90tvKWKjn7gDmYkK+pClW/zG4tkqe67ZqBCzZhO2psIK4B/2KVQ+DIG9XA7ty2Y0WEoykK
 wuCe2jLkIrzmPZ2sLwumdq3xJi
X-Received: by 2002:a05:6830:4128:b0:81b:9d18:761 with SMTP id
 46e09a7af769-850fe01acedmr6415899a34.12.1793058404078; 
 Mon, 26 Oct 2026 16:46:44 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:36 -0600
Subject: [PATCH 4/9] pinctrl: sunxi: add H616 I2C3 function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-4-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The H616 routes I2C3 over PA10 and PA11 with mux function 2. Add the
function to the H616 pinctrl table so device trees can configure that
bus.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 099280ef76b..b1e64c3537e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -741,6 +741,7 @@ static const struct sunxi_pinctrl_function sun50i_h616_pinctrl_functions[] = {
 	{ "emac1",	2 },	/* PA0-PA9 */
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
+	{ "i2c3",	2 },	/* PA10-PA11 */
 	{ "mmc0",	2 },	/* PF0-PF5 */
 	{ "mmc1",	2 },	/* PG0-PG5 */
 	{ "mmc2",	3 },	/* PC0-PC16 */

-- 
2.53.0

