Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05682606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mq5LJm0d;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sBhsSa+z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE58D80DF3;
	Sun, 25 Oct 2026 14:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tN-CjkeQESy5; Sun, 25 Oct 2026 14:15:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 039D280DE5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792937738;
	b=GoED+NzVy2HumUtTpnOV62Z3wySjtIvsdbnX2cP3EkyXmrhRIzfW6eVdHfBjygzA3Djo
	 c0sqH7r3g2OLeX4LR0wpiPSVLQ/pdZDU8W7KTnbr6TqqCb+kAz1KlrzKsY//EiDAZd579
	 PS6QX+MEyFRCPcYK7aVjmY55UL/RMm/H4BtM2zQA//Bh4rPNjszOgpIoqUE/FW0BLwxfE
	 IuIXdtsQ3oBmNvUV+7slqVXm3+Dcgiolwr4tAomkAmL7u41R71bcj3hnmiy8JgPniO9is
	 Q4A4LlwTFR/eks/px13PJoPY8O2+XvGn5uWvTudVdx/MbgeaRXJrrUXJkAH3P/Ndsiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792937738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mB8maVGYECwwBakDPSYSotqf8HtCOaNA8mY9/nWSiC4=;
	b=a1wsPR6OK3BZZzIOugTUIyXNJhZRGYbW1wRYbDXSpbJUSxKFrFreAVbkxvQ/oEGSLf9U
	 GnBbrJU0aaHnhcF7j5D6anM/fQ92sFOXMrN+VxLR1itoq9GOc7rkUP/S/NUMnvhYwJm60
	 E3bISL8qXuFTQJM3CnOTUTYjr9R1jaf3CRsOTNZ/af/FJ9VmsBYAYXFL9F7jY8u3EXrEG
	 HFG2lmefb5opFiXdCnFpjpBVb854aKNlB0/p/ynyYJx/oAP+J4OQzAiXeKiaF8FclrdVU
	 Jme+PFquOnZniBnGg/wgLWUtVJLQ+3zTwQtXa32r8HQyJDKDP2OeWxMU0pMDCrPdpQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792937738;
	bh=mB8maVGYECwwBakDPSYSotqf8HtCOaNA8mY9/nWSiC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mq5LJm0d7qYzxZwDDtwPzclWW9qpRiH0RileSsID7XRB4MSmS6KpKlwgDcaLgr9VS
	 5v6UZBHos24z8hrNd5LiTVctp+/4l7JPpSXb4OeuGQ0BSPOC9auCT37jrhgid6W8Zt
	 v5lBwmsTlkAfMzuCJS4/pMvUsVBKdFuGf6YD4xBwYL7W6fuVtnI1Xo+wG0jGM6RB57
	 cg+yfwsnvG3igUORBNx3CxllqGt+xfN8y+daZ764jtGTk2cgX+FKqCGubgKaOBYAqz
	 hI7pryowiHhmnpk/xFGWph97mjHwKevXsPDoq+KVK1XIfBwN8F9E8UgTyIj5U8GEf5
	 GKnLFgpGtUTzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 039D280DE5;
	Sun, 25 Oct 2026 14:15:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 308DEA32
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1719E40A15
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 968mH-DJZQ-j for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 10:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3907C40A0C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792924014;
 b=Fo5cF8AYXzaXNzRiipRZRTn58cmzHqwj5ab5oSFoK77K9PDPdBCKJF1dfpKNR8gN77mL
 gwCoTwAR2wvRCTgqf7OVRSwzZLfM767VFERIi0gtIlM3VSc66a5iOm8HMxM9PiiyG3qD8
 4VgOEg7rR0FV76cYKFM9Jl+JKqX+ivh7zPZx8FBYvTkX6JyTQYjZKguSh+MlDnoN+qdUi
 bCsrij2meBb1a3GTxypfHR+94aD4eT5H+bEWR8KeQN/g9f/WQpnld51qsSRHnSZ5h7Xlu
 6pHIAsaY3LMRJA1RrCFFTnTEiO0hVmV3S75NekofSSj9QLOFlaSSpgltN0VkHTDLboA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792924014;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=mB8maVGYECwwBakDPSYSotqf8HtCOaNA8mY9/nWSiC4=;
 b=TYUp/bmoGu5ffjEt5AH7WteL5jjDiFaJ5b/jCWiiUv4Me2Nva9QR60ymNle98Ea7UDd1
 HOJtK2p8CkEHOk/s13uXwnEsKmXf1I2iKEs3efVJG+KAEw5rWIzn4Z6LTeYjqNRC0dd2I
 6fm6TYcNqWGXQvf99N4T7Ox+APCSJE/Yxr17Qo39SJ0V3R7YVtHLeuELbSxtxSHxssxzw
 j4K2IwDuujOx2J0oaetKevl8YZ0V9nxqr4NyUIhgEMvT4o4f9MQf6MwL0rfvA8sfdlnRs
 B/G12+EC9kyuXJLt+slsRc0YUUD1wZf99+dkcM48h2mglgug+l3zqBMZ6yN9CfixV5w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sBhsSa+z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=vikrantyadav4802@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sBhsSa+z
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3907C40A0C
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:53 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-14394530ec6so2765980c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792924013; x=1793528813;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mB8maVGYECwwBakDPSYSotqf8HtCOaNA8mY9/nWSiC4=;
 b=sBhsSa+zGbZSpEbrTZzC975eio0RE+yfN72SL9r8O5s/zcrpCTqHUFtr9jjCClWcT6
 mBoyGxYLUgitnvzqg1lnuOB0f8AT9I2VW8OF6TfiLeruWyeHPUWqLlZPxt3ZFqKC3mK7
 LgfYDMWd81WFwoH9E1L7/OWzRre6DUn9Jrc+AhNxL+NcXcEHIm2ZZa5MIMhJtMFCpqkI
 ugmfq6LA0zRI+q8QnX6N/xAFisA1gZLHcomrnofBsHCh9W9DNXmWMcDWVH6b6ouhf1qM
 3lsLfAPQI2r/AzBWaetm7D9kIRHyx6uN+v6XHgLW0DUbKABMgPT8sSjDy6OSjmHLD0jP
 Ls1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792924013; x=1793528813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mB8maVGYECwwBakDPSYSotqf8HtCOaNA8mY9/nWSiC4=;
 b=mk4D639BQM0CW/x5VNjcmjQ1gsca6MsdeedF8+0d68xl8LwAbNmNgAM+GCTASuu1+R
 qU2ogjRwEXAjj7Wzkd4BaraceTs9SAUafHY5YWQCiB3yvI1WU3/g95ENcJU6p7Q6aRe4
 HPS36/00r4xiu8YInFSFBZQVmMtSAGPXMsc/of1TaazZOrg4zTYPO5+G9IKcOZhBu60M
 bgnhXYta6b88LVFKYkYMa64rO5WZCWjDb47ghgRC3SV75G+3+kZ1N0EHJP0/v9xN1tuX
 UFFS7+cDdtlUQVE7Sl9f9MNNiOsSvqouU3LPMO96xz6k9LIiUmIbj4ypV8bi+IT2a8h+
 70Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIh/F+szVG0jdquV2TJVIAcJ5JHjkIbGMG5eBnRRdel77uAG9ggA9Rk0NoqD8290tNrASghT0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKrQuq6p8cqQTNeudVsXYrHwtdaUrSgnrOIfUUqP5yD5Coj2w1f
 m4a+CD4h/UeEMXrBCRs9uMBK9yyMW670b4SZTkAbD4YF7hEet/Rq18C+
X-Gm-Gg: AYBFou339wRvqixE7W1ovwEHTrkTxpECyk+nVRLRraRkoI5laorIvObWXZ61cLsr90s
 1PNH4a8YjdyNkETep60ipcNjZlX/YYjm3ktVXZ+5w818Cav523LemcuEvrouiRvOx0DWokBSL5k
 sTcXwMJGwhcZK2wR4+m4Khv4rWTPHXiMGtyYWoKm7MmFzesps6iHcqu0Iope2nNqDo4Tkx9bSzk
 hchujeAihleffIS+3uhFPOP8L7LIELCoJkmEwQC0xZhxtk4+eRs8GKLzk6FBwMyx4zsYjThXyy0
 kmXgYKafBiZ0Zji0FjufMYpOLcUhwyuje+qHE9//RLP+Q7s8Kbm/98vP/3ACBtW+oRvdk/5/5SJ
 oaZK47euOk32RCkdN0nwAO+E01D4j5wPRyIliCrA9Egau0A2x3qfhk8FPTkYvmCv++7iCMT2kOP
 CuaRFwN5a4rtg5R8wqL6lrYAe6B4OiRZBcU+tQcsNI9n5KA2KwmZkG5AB/v78aatDdiLKIcp909
 82DO9rn7+cKCOmKTATuv2zQb5lHgYu7TGi/TpefIyCULjXh+2dYPY0QneaVYCRQkjBLu0iWOYOv
 VXPt
X-Received: by 2002:a05:701b:4549:20b0:144:fdf0:9d91 with SMTP id
 a92af1059eb24-1993552f1d4mr5545150c88.24.1792924012712; 
 Sun, 25 Oct 2026 03:26:52 -0700 (PDT)
Received: from localhost.localdomain ([110.235.239.152])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm18923825c88.13.2026.10.25.03.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 03:26:52 -0700 (PDT)
From: Vikrant Yadav <vikrantyadav4802@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 u-boot@lists.u-boot-project.org, Vikrant Yadav <vikrantyadav4802@gmail.com>
Subject: [PATCH 2/2] pinctrl: airoha: fix pin lookup in airoha_pinmux_set()
Date: Sun, 25 Oct 2026 15:56:34 +0530
Message-Id: <20261025102634.53851-3-vikrantyadav4802@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
References: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 14:15:31 +0000
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

airoha_pinmux_set() matched the pin name against pingroup names. The
common code has no pin or group tables of its own; they come from the
SoC driver. pinctrl-an7581.c is used as the example for the names
below. In those tables pin names and group names are unrelated
namespaces, and nothing checks that the matched group belongs to the
requested function. For example, with the old code:

  function = "gpio"; pins = "pcie_reset0";

picks the group "pcie_reset0", which is not part of the "gpio"
function, so it fails with -EINVAL instead of selecting "gpio47".

Resolve the pin number from the pins table, then look for a single-pin
group that contains it and is listed by the requested function.

Only single-pin groups are accepted through "pins". For example, pin
"gpio13" (pin 26) is part of the two-pin group "hsuart_cts_rts" (pins
26 and 27) of the "uart" function. Selecting that group through "pins"
would also mux "gpio14" without it being named, so such groups must be
selected with "groups" instead.

Return -EINVAL if more than one group matches the pin (tod_1pps on pin
46 and pcm_spi on pin 40 in the AN7581 tables), because the DT author
must then use "groups" to choose.

Found by code inspection. Compile-tested only, with an7581_evb_defconfig.

Signed-off-by: Vikrant Yadav <vikrantyadav4802@gmail.com>
---
 drivers/pinctrl/airoha/pinctrl-airoha.c | 44 ++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
index 093a6c05f65..df05eba7fc8 100644
--- a/drivers/pinctrl/airoha/pinctrl-airoha.c
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -135,6 +135,17 @@ static int pin_to_gpio(struct airoha_pinctrl *pinctrl, unsigned int pin)
 	return pin - data->gpio_offs;
 }
 
+static int func_has_group(const struct airoha_pinctrl_func *func,
+			  const char *name)
+{
+	for (unsigned int i = 0; i < func->group_size; i++) {
+		if (!strcmp(func->groups[i].name, name))
+			return 1;
+	}
+
+	return 0;
+}
+
 /* gpio callbacks */
 static int airoha_gpio_set(struct airoha_pinctrl *pinctrl, unsigned int gpio,
 			   int value)
@@ -749,19 +760,34 @@ static int airoha_pinmux_set(struct udevice *dev,
 {
 	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
 	const struct airoha_pinctrl_match_data *data = pinctrl->data;
-	const char *pin_name;
-	unsigned int selector;
+	const struct airoha_pinctrl_func *func = &data->funcs[func_selector];
+	unsigned int pin = data->pins[pin_selector].number;
+	int found = -1;
+
+	/*
+	 * A pin can only be muxed on its own if there is exactly one
+	 * single-pin group of the requested function that contains it.
+	 * Multi-pin groups must be selected with "groups" in DT.
+	 */
+	for (unsigned int g = 0; g < data->num_grps; g++) {
+		const struct pingroup *grp = &data->grps[g];
+
+		if (grp->npins != 1 || grp->pins[0] != pin)
+			continue;
 
-	pin_name = data->pins[pin_selector].name;
+		if (!func_has_group(func, grp->name))
+			continue;
+
+		if (found >= 0)
+			return -EINVAL; /* ambiguous, use "groups" */
 
-	/* find group matching the pin_name */
-	for (selector = 0; selector < data->num_grps; selector++) {
-		if (!strcmp(pin_name, data->grps[selector].name))
-			return airoha_pinmux_group_set(dev, selector,
-						       func_selector);
+		found = g;
 	}
 
-	return -ENOENT;
+	if (found < 0)
+		return -ENOENT;
+
+	return airoha_pinmux_group_set(dev, found, func_selector);
 }
 
 static const struct pinconf_param airoha_pinconf_params[] = {
-- 
2.34.1

