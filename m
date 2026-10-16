Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47FCCF2C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 394F8409C8;
	Fri, 16 Oct 2026 21:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uc85NFAMUa8v; Fri, 16 Oct 2026 21:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FF6D409D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184496;
	b=nZi70YXYmYCESGix7ymEa6qO9O+GMcYiTXHF07O0F42TrMle37vjE7YgcqQtfkET21+v
	 rclCFpT5Y43FfTVO/awj5YfV+vGCTHFRi0disNpUcsf3dAam03I1gcnOSeZzJsmaebP1+
	 78iW7ermxhaV/Xy3FYmzjpLa72p9n0T9A278FXmihYaFKw7NdiudVhmAclCwmQ9pPe0Mt
	 AD6uOQhq0uyHmVftVFh8t36rFb24wZ0J6fWxMoc0BMRjQ+NJXqYGUIIDFVF808l9d3szI
	 L09E+mm3L9liow5yfwxkGmHzK5YNeOQmYrKHEbGBe4swH65MVNbi2sPXZWCjGYDEIUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CrWpw2vXSMxL0u1orqB/1ivuxri56TOFUtzaR+aCPOE=;
	b=qUi+v7ZckK+Pzd/C94Taea2etBzI2CRwl1W1maUvzzTf2k3Y56PxJNTAxUPorSS7Fwq8
	 JAPjz4Jfdg9maqN22MZtXXH3n2/JgtrWckAWN4TWvNP3T0+6e/nDbzVncimIWTYuaFD1f
	 u+kirnpGvY0HaHFeZlXWdky8RPSKx54DDmlxL1Ud7KBzLp27Hbd51HZSOB88eBi+Vgvih
	 XXcdYdbJQFp4/gmOSA5M3GXSEQry6TNXXDtW0hC+I35A4BwsQt80mJO3GUK22/+IUrzt9
	 EmzNyaU49qTL4gLkDW0QZX6CkJxBHoNLiiIf7JcvhypK8w7RyDBGM7BXY7dayASTeeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184496;
	bh=CrWpw2vXSMxL0u1orqB/1ivuxri56TOFUtzaR+aCPOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jmYVCNjSFc6go/pADHV6RN0NcjAbRVUaoE/ql8w3djlZdT5fU8Xp9dCzlC0AoCwXR
	 /SQ1mi3wQQpw6pOgvZxXhIs9UAIhi0y5+K7cMnDqZrLJDwtVqPhh0Mx73rM0X4X7IB
	 OwWQlQnP0M2+VCijVDEIkeqPfiumsyHuGXkjOlwy1v3gM1C6lOBFy5NZT5rMlCVWBw
	 NPsInQSjfhilcWbzYvg45aZE/W7dW+qWoF72NC/1VxRjnQnfJCYcDq7mG05fmipI7m
	 XTFXlfAip1wx8MotZJmCxmSfqhTVL4jdUfyowCkbKE3rS281rI5AXJU60Y354EOniO
	 EPo7W8BSe359Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FF6D409D0;
	Fri, 16 Oct 2026 21:01:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9597D1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86F7960AB2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sg_57ppJq-ix for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 20:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A603A60A4B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792181644;
 b=DmZteNe8kmq11o6VTZ6+MBOW8jLN75QtC6i8w1Oht5GDrBENRTtEkmRGkhs9F6r65dep
 OQ/xS/cj+a4N+BfPXbyW/4bcge5F4aAdcn44BaD6BeeeKEn7GBLd4f3JiLQ1D7B/Ef8UP
 9V/TJkk633NVwM6YTcGS7k77dc6UL8wv0Q4mlSzvRgsnK7Bx0ijr6KSoVbPbUrJ17MRJR
 jVaa0ABgIzURmjN8z5rkvEj5YEJkSHVvs7bDAoTkuxXq/Xokkx2Dci/AT3zisAmJJBipy
 immWdp8CRfqReln83gESLAqzCbd7kfXAFNsWcoTLTw4+65mYCG4MdB4wacZPeKG8kuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792181644;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=CrWpw2vXSMxL0u1orqB/1ivuxri56TOFUtzaR+aCPOE=;
 b=ggky4tGwE3TztEeZcFoIouoHRsBxXJo7kViqdXmBGDbQFRnyLqvss+uqm9xsyumZBVVB
 GeKahUA/Xs6oau02G3XECNL4a9jQzi0MEF8P3i5BzEP7OthPCr17YhU80TzQaXT3MWYsA
 KLbf9TnFobeFCi/YgO67VDBfbnNxseR3foeiADjmJi18/L4A/XGxFWPTWkfMMqPn8RbmJ
 dCkgE1k5wyQj3q3kWA8JG30pWWtcGFamCenijLaPsFh83Se9L/UndVK7KK1N/Mvbw9Xkv
 Z15do762gr7eU6NzwlJsyuSLYNdqzWhr/kcSSn8QVuJ/fgStSuxeYFRYrRTkqJrFH7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bH9l+b15; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bH9l+b15
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A603A60A4B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 96AFA60230;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4385EC2BCFB;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792181642;
 bh=oNIQSUBAoo07PlP+FiTlwa1Qv2xbTZkec5rBbKcrJDk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bH9l+b15V+S52z21kGhAVWRd4nu3YBNu10BD7BEueWl1Nbh6KR2ssHVamT8tSSCpX
 gRIK4GOd9qqz/q731+KqrLLJyljHARVqZqBWncm5XTT+myZw6ishvql3wCk7uhmrrE
 v50Ud1SRZUNKf9imtpUOtnnjkiePpbWfcFuUUF3i06h2Iut+9w0tQGssddbJ+ChmX0
 86IlFiUknFqF+lN4EF4pKfs7MpUKa9OTm+8btPcGUq2r69sR0oyTa6+ojWz6ACu2gP
 DWvcj24SMyskzXvBIA3rpMgVdUAmPoQxcB3WvwLhZ7A8KB+1/HnTYzjcAXexVapuvQ
 +SzDDeiutCKrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1619ECCF2C4;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 16 Oct 2026 22:13:50 +0200
Subject: [PATCH 1/2] pinctrl: qcom: sdm845: select the mux value per pin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-sdm845-qupv3-s4-v1-1-672e9be21fd2@protonmail.com>
References: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
In-Reply-To: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, David Wronek <david.wronek@mainlining.org>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792181640; l=2300;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=znIksOWrudNsp9MkPQ32uJ1zn0y6AypLxS2RN7WHhMc=;
 b=CJkvxcQ/ibNPMHY2cM5RN+tECGn8eLSm6TtHncTSb15Wo+jcep6AhfCAB11F+6agBwpRqWUsq
 XNcj74tmonDCbgAclepDhETPZImxdk+pfiYI2boGHMO/IkB3oIX8kDp
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:33 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

The raw TLMM function value of an alternate function is not the same on
every pin.

On GPIO 89 "qup4" sits behind tsif1_clk (value 2), on GPIO 90..92 behind
two other functions (value 3).

Add a per-pin table for the functions in use and register the "qup4"
function for the QUP0 SE4 SPI pins (GPIO 89..92) next to "qup9".

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 45 +++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 24b42e94c7a..bfd412d8e34 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -18,9 +18,31 @@
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 
+enum {
+	FUNC_QUP9,
+	FUNC_QUP4,
+	FUNC_GPIO,
+};
+
 static const struct pinctrl_function msm_pinctrl_functions[] = {
-	{"qup9", 1},
-	{"gpio", 0},
+	[FUNC_QUP9] = {"qup9", -1},
+	[FUNC_QUP4] = {"qup4", -1},
+	[FUNC_GPIO] = {"gpio", 0},
+};
+
+static const struct {
+	u8 pin;
+	u8 function;
+	u8 mux;
+} sdm845_pin_muxes[] = {
+	/* GPIO 4..5: UART9 debug console */
+	{ 4, FUNC_QUP9, 1 },
+	{ 5, FUNC_QUP9, 1 },
+	/* GPIO 89..92: GENI QUP0 SE4 SPI */
+	{ 89, FUNC_QUP4, 2 },
+	{ 90, FUNC_QUP4, 3 },
+	{ 91, FUNC_QUP4, 3 },
+	{ 92, FUNC_QUP4, 3 },
 };
 
 static const unsigned int sdm845_pin_offsets[] = {
@@ -80,10 +102,23 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static int sdm845_get_function_mux(__maybe_unused unsigned int pin,
-				   unsigned int selector)
+static int sdm845_get_function_mux(unsigned int pin, unsigned int selector)
 {
-	return msm_pinctrl_functions[selector].val;
+	int i;
+
+	if (selector >= ARRAY_SIZE(msm_pinctrl_functions))
+		return -EINVAL;
+
+	if (selector == FUNC_GPIO)
+		return msm_pinctrl_functions[selector].val;
+
+	for (i = 0; i < ARRAY_SIZE(sdm845_pin_muxes); i++) {
+		if (sdm845_pin_muxes[i].pin == pin &&
+		    sdm845_pin_muxes[i].function == selector)
+			return sdm845_pin_muxes[i].mux;
+	}
+
+	return -EINVAL;
 }
 
 static const struct msm_pinctrl_data sdm845_data = {

-- 
2.55.0


