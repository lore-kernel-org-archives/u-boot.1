Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE08606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y3ruBmZ8;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DH/LiZ3v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D85BB40955;
	Fri, 13 Nov 2026 15:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sJ-2OF2i4gU; Fri, 13 Nov 2026 15:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17A734095B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794583565;
	b=YL+mHL5BSx3IUk83tIj1ToJ555+jFXGS+GoMOhsFqf18v4iMJp+e/3YcO6GIFt82Rv3v
	 QzZ7eTrOYJXJTMk6Z7zEM9QnfgKHimk6NMdx5vxZL0+6Ei6M/Z/TITg7RX0VFC9JyR6rQ
	 9DVSoaY3DKsNcODAGBY9tgh3LHCVJx6LKX6Xi76yqQomxvo02gIJVNnfSsx9YjDcvPoTh
	 Xuc3NPuVyI6UAfK+ymxde2/qJpCWTz0he3DWn7aF0+kjle5JjZXEjOSMrBzz3LiZstDde
	 dvMPv/MOghpfVn90YyA6HWYYfygwDehqYdWEhZZ9yltngONov93s43a/p0HsW2IkMzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
	b=K6FuA9MCIED9aKtQqMNwxu5HJls09X5cQH9tsOs9AA/qQ3opUo6N98m0tub+CzSTCxWL
	 lvn58+hYVqclVWYLbT/lJy9KF8Tm08Kn+wLH5EC+oEZfLaAUNP7DO92dhz/FNtv2fpaGv
	 /y9VoeTjXp0WkS9S052lNtIAmhGpV6MSdjCcOLZr3/vwOk4EKKC7pZVKlrQ6wMj5nhpJu
	 CNM4kepdtXFDJKLmbOamYgCNrxjvDHEbTjL+rMEfvELqT0x7FMcrsoHTUk34Ji/Mltf5D
	 MgoK5m3Tp1txdQ3++7TdWErlpqRjGfEXli85rVicVTtJsNyw18eKIDX2CZRzNpoPK1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794583565;
	bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3ruBmZ8fN0cx8oaKwH5Rch69aA5C6jLovbBI6OphIZXA4Z0GHY0wJtQiycW5ojIg
	 EeLRNocsUEO8F5w/dWEFb/SPsbwWXG/h4wpHXzcjTh9i8n+vEzM9Ljb+Rx5lTsZJUS
	 Ekx56Ym0iN1AIrgMcy3Rl2z4VxXpJdhQltnLrXsfg+jjSk2gZ5v9sJ+sejs2t8uuCV
	 If7dXM3c0wCtvzjUzSK1lWK7g2duIIH9Af9N6X1jJMDGN6yaN+ji11zazLwF1CHqUf
	 rmrjjKnGE+dPfe9UMT3iRjvYMQmRRlyTXRClOaOxAokq9u9Wy/gU6MtMSrsIYGs0jA
	 Ukdhj2KpYw0zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17A734095B;
	Fri, 13 Nov 2026 15:26:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E6232FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 143C58112A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFNC72rbT7y2 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:26:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23CE28115C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DH/LiZ3v
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23CE28115C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:00 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so16897875e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794583558; x=1795188358;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
 b=DH/LiZ3vgjMM8FDYJUHxECW9E7KcwiddRW/i35BZ5jNaeOqCd7QwxYBcEIAviaq51l
 INhzrok27uqt/kpl+Qwi5i+5xK0ZR2ybZskFKqriHr7Yr0TlXHFoxtG4nGelanwdaLCt
 huB1zQwhtanJMi/PC+QX1BWTMPzjw3HwGImWLFfX8BgqmO5+9HzTgCb+V324uFOTP0Xc
 Neuvz6iziPNO8QgqAbbJj1PTUi677igdVnVPJX207qt15sD83qcITveOsxbtHiJFm3AY
 b+YfL5ifnIf6MomXG02WPZH+MYXyiGsO8qew9o4sDdRFj4Wo9yGzSnr5fBZiVOwhoU6R
 zjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794583558; x=1795188358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SDX1RhfJKx1mNklf3U+vPdf1jd6gQ04OQDemYE2iVAs=;
 b=YiWWAn1yF6pv5DcvgC8fjHoiTjlUueWYQBtoe/kZVKxXfPNMc4rf6tLpG/TRwHH68h
 DjF7kU2+EOAA2kpbdCGAgaG5PvRL6qI8ViAjtq3oDvKmvL1XZEfE7fJGiAN2i4clTVkH
 fntV0pFe6l8YaemcZfpBUkditpybHjXxdNFZzAwec5GMZwCx0FZluPDRTwHyBREIN8hr
 JNSlmIzMmewI705F6/tESdeMpYVaCzRNlrAvK363dCvHnsTcgkIjoyyjgzijgLoTdsbT
 7MqOdAru+RQYR16cPnDytRecJV8MGkM+x/XzkkWC1aUtDmc1wV0cFSOseX+xWHqQNOkw
 PhuA==
X-Forwarded-Encrypted: i=1;
 AL+hErEOzO1qXjcn5wiuhzxab05hS4hLogRifZ9/9+aHYTUGLfT/zVQO46o2NWpEOPgDgmEOLXaDfac=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9VFb5MrMjZuML8XII29Vl6niusRWgFSuvnOSg6Vg9tOgvTEJI4
 uaWtKC+gr1f1CptsYGSWIqNPBRsR0YLklD10syMkcVzmSTTFGGROBtsx98obmiW8/LBl9bla+aO
 fPCHU
X-Gm-Gg: AYBFou0awCSRhR2ajnhSZlACPpzXyV2Bno/6YOTu2AZUoEF0ZPW2hG/KGDuhHyIaSVC
 /31ipCRBLYiHOKBxqDat6+B7gg9nOQon5kpTDnGnpjGSFCdGiheHTIltE1EImYR8JrOWxHYHfqp
 H37kxyhpSk7KQhOOyascQNLQgWuWXDmdusqEwQwSGmkOEQ2FWbAl+T6n+59JFiexgi1eUQ2egQf
 F1UckKQ9wo70JgCRQIMLP/WPqKyp7q55MNWgdATLnMPGRqUi+KqsRkEfksCndxPRqeWYJNkp5so
 BXtyfXHCEEgl5V/X7jhBntUABRVuWVV9BzZQxtF6w2j1dSH+SjetaVu1J8beS3TbJ85WLAevW51
 8lHaPhkqNCyf7CZzWuAjcQPKqU0q7ttCS6oc8nzdIjY3Dwq0QMpKN2RYY99rCtWx/JEQTxUePKO
 KsKZFFXCdMxKV4qIkDNJCvuFVd3aBADDJEGqcLmlYMtLaYa+HpLmgydbFwvvtP2kCTRokAbhNyj
 YzCSkjtvIHQUHBgyV9iNZejoJ5afYZQTbvKLqJKpzj0ivhTi2np1A27qYQmPAI8ecukzlP27SpV
 /aLJR2SNuYCF2w2W+1199NQOA7Fojzz4nXZWYT6YTSKLITaqB4bK8p8U1d/z/xAhpcXGXD7nafs
 /omjRGWT+dKw9VRKKI3fFONL8+ALdycbnh2eomLs5kzhapw==
X-Received: by 2002:a05:600c:6309:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4bb559f3bb9mr59318605e9.3.1794583558347; 
 Fri, 13 Nov 2026 07:25:58 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ace535sm70042255e9.6.2026.11.13.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:25:57 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 13 Nov 2026 16:25:37 +0100
Subject: [PATCH v3 1/5] power: pmic: mtk-pwrap: honor fallback compatible
 strings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ccaione-upstream-mtk-g700-usb-v3-1-78b554604bbb@baylibre.com>
References: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
In-Reply-To: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
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

