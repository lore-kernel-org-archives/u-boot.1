Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BF606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UAWp68QJ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nsFFMkqk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D67180FB1;
	Wed,  4 Nov 2026 08:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_7nc9_OmF_F; Wed,  4 Nov 2026 08:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B878780E7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782470;
	b=CuGjKJ7MGsLgmgfzE264drkZkYXY0PlThJtd3DfvHis6gj4XrWk5UBuLda0lj7tUbk+L
	 0J0shoXnIJsRFw5oLG7Iy59sc4wUhSU4CnwqV5UIg4KnP0sbonr+ptr6g1g2mHeIjvETD
	 VyM1nfwsmayjl0lrLQZigEz6UoHl+Ev6UE1w+hMYREMeKDOEl9mxJuMcQjSWyC9kATkPe
	 fw8bLf4jQUvry0iuwV1pKTsDOfOqFCXc8Bi++h+pg87t8A+Za2o0umYMoKEI1O2XpQ0il
	 yIKhkBS0cQRydPeLXco6KHu1oAPGoynvea4Au4LiOn5C0u+yv5mYq5aZp7VwXpvq4uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Fzh9CnjFAEbM7av06RBmXOOmUjo+TTFAL5JqY28IqQk=;
	b=q6ODUBB+v1SE8Lm8pX9xu5WnDUJ5pfH5wDtyLECaAAv0ywbZ3Wf0EzGcd9qEHNI8iIqm
	 QuNKU1pwNfe7KNfkIRgfDy0VPOKkDe/pEG3vlssr+xsD87keqvcupNrfwfbRU7GkPs6ZJ
	 Zn4eOLwQdbfAB60nLmCiCPNm5+KNKTWd4ULDpforMf8FXArdhAwLTmO2HZ2A5j5vzOidc
	 HwV05VHcr9yC5tkVab3W+sWt/hxlbXhM/d/PpN2pNbvnFkZJXjOUzLCG22KLVoTZET6PF
	 gqRWGZdA1et2WebDFnHajEUOEQ8qZ9ReeupFA6Eqxi3GMftyEKfypbubkT3XxI/UG/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782470;
	bh=Fzh9CnjFAEbM7av06RBmXOOmUjo+TTFAL5JqY28IqQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UAWp68QJJV9M6cc1YacRC5FE6JD6u/k8kcWfzGiE/58/iE5ofeRoayLgvxUTAANCp
	 vXzTcfjk7aqnSF71L0To7Kks+24I2zC+JrmWGSeBZf68Dfv70EHcneuagYRb+B/CBw
	 jzJ3wxssbjUb7+h6UqlTJqQ5HqTc0YMu4hwMZ17bxAOyXd/SmD9VtYyGI1p8hPwCyp
	 WTa2Q7GQZ4rWSG5LvF9snd8SGfKvz5c/cCsT1f4jHGQSSoC4Ce3yB3NQsxyvsoE7/B
	 MUxRqsjb6TrYZX8gpQzxPer4C47P13NnCDBtxOnrhlbhHp4JdqOVGAxnLNwXdnBCNN
	 ODeiYMnvArEkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B878780E7F;
	Wed,  4 Nov 2026 08:54:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE2ED2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A32EB403B3
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfD4gp31VERv for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:54:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AECCD403B1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782468;
 b=H+jzOQYaxGpRCbNvQxyimjHGlh+CwORTT+C3cZNTpa8C1xPFEhfcq/qUcPZIBm6RoLDl
 wen5I0Nwc7/6DxttejDmhyIzE+zW4f3dvqVOMiup+M+zcEXT5h52sFyiD3R/2p7Vu4N+e
 ekmL4qIG8ObTfsFtb3mBkmMui7pBVGKM2hBlDtQZm6QAe0kW4fAmVhiK7C2yqHRkrVgax
 0qZSTsVksa8juY7b/YZsN82K6MX4krzBJxOZVJF/QpOpGOtvadJ0rU4/u917Upeznwh8C
 9die0Anm72Vi3YbdlDnY1u7cnr5CTq3mgwQ6QQYIqMyK+mDEqbzmiEZMjZ5b0wtjVHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782468;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Fzh9CnjFAEbM7av06RBmXOOmUjo+TTFAL5JqY28IqQk=;
 b=iJu9HeQJIf39gpUt9BZcdUnxTuoIJiKR2mkUrFZz6AF1zK3XC+YyKeHdi3BqmAoFHYVc
 HNA6IrHLesGGzPhOo3p8aPTROdN7bVEW5fLzo5moaoHyvkuQhlmso3Rqe8O8Qi59blleg
 gTHKcX1QBZ7y5++eDiKHLM9nU41gb1hgH+/DqR/KJNxa56UiIrAlx4+iC2na0XHFmi4J9
 jtQOKg2kAhjCMjJHyG6vYCfTvVUFgOgMXu+cmfl7vXSohZAndOWpoTeZDakcj3Ax48W6p
 siPtG/bboVUac3RddnBWE/8/NPlA2/Gk0AqfutQNknEXCELpVONg59VjFKI3KKS7trA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nsFFMkqk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nsFFMkqk
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AECCD403B1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so4637645e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793782465; x=1794387265;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fzh9CnjFAEbM7av06RBmXOOmUjo+TTFAL5JqY28IqQk=;
 b=nsFFMkqksaSzSncq6Tiz0KMgV/My695LBOQWlRMn1kSSuiN5MgXn5CQ/8PKmhmSpch
 Cwo9B0mFB00r+F7uA4Lg+Z6bKg/vWGeQTc528AZRWDBcj//F+84yBsIYadzJA/Dhy8l5
 z+7ubRzAM4MDcDarmn3WcBKOQiuRSiTepW7Bw/nT8o8ukRkWBDqVN8YYzaxwanH2twuS
 gHuYg2iZPRSo7ghM16MPZvf8plYXwRG5IiLw7CS5FuJ9wD2a7SEn5pjb7U/i3Mxxc94V
 neQ/RGWNqSj4nNtoNuUVUVKM/vZXjqp7GjgwMkwwT5vDIFOZCyQ0/SyTCIgOnW+nRZXW
 To3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782465; x=1794387265;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fzh9CnjFAEbM7av06RBmXOOmUjo+TTFAL5JqY28IqQk=;
 b=nMZvRqMbxm9ySo/CfDoj5e7Kl+PM45y+uFljqBYeeFlETgw0UYjbIacl5vJ9XiQxGX
 9+9vz1Uh1zdz+8sP3lhxCN+xUfOkhOp3/5ZaeR51uLLqEbzqnkXqyfDbNR/aPqoVzwp8
 //XcMssAv5oWUTQIDZuHfiQCK6qWZe5jjZCiW+x1H7zEnHmYBLpZHmoQvb68GZTz/0Vn
 SdomLLLATtAf7ldbQXFY7QnrMb5SwIu05NEtCUZzHOaBn8GUFE772C0OmvAHO0N8IAvr
 TS973oIsnlPG1d/dsEPxtNMpqkmzBFuMQO+V194ZfSuhMSF8AvBWtGAiEc1yv29K9rtU
 72HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcra+oGuKgpnFuImiVGMvFMhm9eUrakbVyemcKI5cmJ74Zj7L2lm2auIWWCGq5SrYI/zQwHgU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+VQygAw0vrBTOsSgFRyjEEev+JqrhbDYcsR5nYUoY5qmjxaojT
 sV/ibI1HbFfPUM1jDUCtnWyFVToJRsjDw81r3vxACOtsK+bkDUGQ71gJIdA5p2sl92k=
X-Gm-Gg: AYBFou1xlE+ycEL+HckPn+PTNaZiMXQrG42WCkD2/cPWPqy6+jRkIwYyCJJzEodU0RU
 TuiKsH6m3Fr9TCGZhXKYE5WSrtpLSM3bnqY1yOlPS1wNau6DNvGNL48asii6gOinPuZ6EyaiE87
 E6IvTqx5OiM0QvUVNcEneAx0uZMK11EWeVRmki/v4/JSq4nqtw5qjyGN43MUIpcwipe8pIeSND9
 VajziitcRvVp/TfqywgcIKrhE/NGeR8JnJLz0APr/SToUa661+XDmoxdovq2X08MgpNh6ST5hJl
 rMc/flyXOQzxtYnaaGZG5Dm8IlV/J29DzRuFjqTEM6b0xqZ42gXV5ToOrWrr9DSza9HvfCpPR+t
 pJ0BuitP5ju0qpXoThCfl1VtyBte72HcvjVrRpBlxJkyq76E/Ee3a+KK4LdmeZKZCIJeYEXlo9C
 R61MRZNVbKykxSlB8KDjtBD4//d62V0+h/fUAfVO8ynmprAzf28gz5foXra9B3F+bb8UVRQ7pCv
 QKrJ9FY6dX7IFnrjAzEVEyfEQG6c/4kaT+QqkhbLLH6KKgq+zFycRthcRljhJqJFS5stgVMLxR4
 RSzptWHOsLH5O1wU0yZZE0v5MoRzscDB7P31CpwvYEKIvOTKl+7Lb45juaLBKkKEXyphEbkvii4
 zUm/4wEo2PFJFeBD+51UcG8+hdI9ehXYbpCVSWUwRPMVU1A==
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4ac17ffaf95mr358246135e9.18.1793782465357; 
 Wed, 04 Nov 2026 00:54:25 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm20656245e9.0.2026.11.04.00.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:54:24 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 09:50:29 +0100
Subject: [PATCH v2 1/4] power: pmic: mtk-pwrap: honor fallback compatible
 strings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-mtk-g700-usb-v2-1-b8dc65b47373@baylibre.com>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.16.0
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

The MT6365 device tree lists mediatek,mt6359 as a fallback, but slave
selection compares only the first compatible string. Consequently the
wrapper reports that no PMIC slave was found even though its existing
MT6359 support matches the node.

Use ofnode_device_is_compatible() to consider the full compatible list,
as the regulator-binding path already does. This allows the Genio 510
and 700 USB supplies to be resolved without changing the device tree's
PMIC identity.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 468af1fba04..75dd9f743ec 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -672,9 +672,8 @@ static const struct udevice_id mtk_pmic_ids[] = {
 	{ .compatible = "mediatek,mt6357", .data = (ulong)&pmic_mt6357 },
 	{ .compatible = "mediatek,mt6359", .data = (ulong)&pmic_mt6359 },
 	/*
-	 * REVISIT: Cooresponding regulator driver only supports MT6366 for
-	 * now. We can change this to mediatek,mt6358 when the regulator driver
-	 * is updated, but will also have to change ofnode_get_property() below.
+	 * REVISIT: The regulator driver only supports MT6366 for now.
+	 * Change this to mediatek,mt6358 when MT6358 support is added.
 	 */
 	{ .compatible = "mediatek,mt6366", .data = (ulong)&pmic_mt6358 },
 	{ }
@@ -683,16 +682,9 @@ static const struct udevice_id mtk_pmic_ids[] = {
 static int mtk_pwrap_find_slave(const struct pwrap_slv_type **slave, ofnode pmic_node)
 {
 	const struct udevice_id *of_match = mtk_pmic_ids;
-	const char *pmic_name;
-
-	pmic_name = ofnode_get_property(pmic_node, "compatible", NULL);
-	if (!pmic_name) {
-		log_err("%s: missing compatible property\n", __func__);
-		return -EINVAL;
-	}
 
 	while (of_match->compatible) {
-		if (!strcmp(of_match->compatible, pmic_name)) {
+		if (ofnode_device_is_compatible(pmic_node, of_match->compatible)) {
 			*slave = (struct pwrap_slv_type *)of_match->data;
 			return 0;
 		}

-- 
2.56.0

