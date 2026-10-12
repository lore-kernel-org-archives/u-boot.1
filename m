Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0294CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68B8460680;
	Mon, 12 Oct 2026 20:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJRXO-mUoHc6; Mon, 12 Oct 2026 20:39:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 832F260600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791837595;
	b=FN3W1HnZFSTzMJk+4EfZxO3YLTGt1XYa7Wb9TYLTtYV93GyMyty5D7YjN2gDXRuDkTAb
	 EMcdUzBdiuuKgo2ymhqN/+BF2bUDkkR0UzUCFZH0vkrgnjq+mGVQxK8rU6f/WvRsRCjwS
	 V0cFSmB6WNrCYdqqmyPCBUxWBxOlhxCbxkSse5XAapcdmYSmrgMhXVvZdHnKC74ukv9ww
	 0W7ZPXIuo3MOwSRl4dy4U0TVSWaPnkQ9HytzHNb84eVw+YZf6uXIyMLiM6ve1uO2HfE/6
	 Oeyetqk5MO4e5NUpPqWb//Du2lOV09FZelx2ynYA8/WrEcpQPfQ22VglZdyRdzkFLqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791837595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=y5jVgTIhbAdnC/a5VvpgHT4ZwpToBGWGe5PVcZsRsOY=;
	b=YWzc6qV1VJdNGHZIovG5/uQafWMr/1gl7ImP741JzW98PpvnSzc8+DMvdzOY8drdlwc3
	 qz0kCRSYluGTxa+JwdLCpuEW+x0bqipFCRZRznGipQYYJ3XCowHpabR8IWmpeTpji6p9/
	 IuuDVzPMGU/ye8Z3njvUIVv87qdTHV920U3U+qmuxpyWmXpStWl/qHe1eeEXUvAQy835/
	 8BHbtnkAcNIRDiYlhqpXHYAU01EiOZ/FB21gWekJ4smsFEQY7kfLyWatCsSacsrCD5sQS
	 BuFUeCfsxNMxi6ZI0XCvIsLybEqP18fZsqvv5n+l9d/+OVwwnPU3qIdSUzFbn9CuYZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791837595;
	bh=y5jVgTIhbAdnC/a5VvpgHT4ZwpToBGWGe5PVcZsRsOY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bux7DU5E6Ki3wiO3JfRJbvNWzguoUjstMnTxW6R+0YtROGYnKMLMM8X3FtSmQH6G5
	 Jje5FjV6+eHjshZdwdDAeGzHJvhnI45HPqqZ61lGuStkA6dWzftFa/5rpjOzNe8eZU
	 X3n15FIXRTKyIVc9lc6ENmeoD3rUjK1aY8tQjnvJj2SZHVzGuVIhU1MPbmiz+bnQ7V
	 18bRPlktBK4FCOYZxYTqnLca/MsI0hIsIJsJyk2o6Ubyi5wnTMhfSPdMhj00LeVwL7
	 7T43n4ABN4CR4bv45AlpNxk34/wKj4+WlXCYXx/xK9uw9VttoKH8pxKX84uFtruarp
	 cWVIuQtv72d0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 832F260600;
	Mon, 12 Oct 2026 20:39:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A5A72E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37CF54002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9u6X9m2E_Hq for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:39:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 59818400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791837592;
 b=Zq6kQk/YanRwRCitGNMdUdf0TuaMcIe4WlHnP7vdsbHwa+XTqmSGglqCcgqeK3UQYsv1
 Iv0dR1cPPetXoZ7hmCSW104tE2DlTEBYuhVCKaKig6ylHLMQMVlVHrBa6YihxxqfAuToN
 L5yExTYewEJ3Zi72QzBt8d2qAEO6gl9Mx0ij6opoUBeAZXH6zn+P0QhLZXs7VRtOfhFc2
 B+6bUR5FqXB3LTZhwrF2CtSw1p7r16lT9I8IMcetg0vLOeDhypHwHjeAqV0dPZ0J2JkTL
 JIESXfr6Y5o+82VSoLdvZ26Yfe5AfSj2Sq4+nH7rByLMMPeYQGCzJ8xiwIsx+0QboQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791837592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=y5jVgTIhbAdnC/a5VvpgHT4ZwpToBGWGe5PVcZsRsOY=;
 b=f+k4TAv+W/Ee4gowG7gcIWDqc2eG8ztkLvb/DrxGgB3zPvNWAdpHMwnUvV83cjT3m2wG
 +FYj3o7bOe5voMrdZBWSEOyfFy1khlnbAkLOY7cfYJ2onkTkPFQaXq1OdNmunIhGAker9
 GqQBcyc14HL38GKNK/ZfCdMoh2KqqUgYMYs7vzeoFi55K2qaZA38xRphh57wEaPJux/g/
 0fpkejVh1Npx+G/w1WXFh9kQdws0w5/jELVPrIo9dlDqohC2197CgOS456nO3NgOVFvWQ
 Erw6dft4wyz3wvLYCqilZrDn+bNDxUfr9W378pIh2xhXZML/5NpLzlApqTyQSWeYdcA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aFuczVIA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aFuczVIA
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59818400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:39:51 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b19e291cc6so2306778eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791837591; x=1792442391;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y5jVgTIhbAdnC/a5VvpgHT4ZwpToBGWGe5PVcZsRsOY=;
 b=aFuczVIAcT/2k0tgKEdmXE2ywkcObwNPq9euvHNbWX6aesf8ZwWmI4nkKzglVVSHma
 bp695PguLtpkl0N2QOpo/cQCnxGsnjs6waHYorNAi+EWVZl/I3YRknr28h3XzVUXnfSe
 kXg5D3cxT7unZfBZmMAzkupxHzP4w3CXhSVx/IuX9Gt3DxCULNXrgpYyTSkijU1SfwKO
 xKRyCuof7Phy+1kfD4NSKg0IZ2DF1FZYB40JRwMBkKE0+K9Z8Z8/kjBAI8PcYpOuvpNs
 wIEb+fskQdjWUT2JgKOA0q5sN8NapFINI9vq+lDP938zxSMZwGdfoRzPmwUCrARhziAA
 4Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791837591; x=1792442391;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y5jVgTIhbAdnC/a5VvpgHT4ZwpToBGWGe5PVcZsRsOY=;
 b=maaNzFlhO3fMp79YITIIi1hWV3Qnw8Stp3dsp7Wg0PW2kmzNBswOoksvU4cLC++5Mx
 kunhcdvfeq02ePjMHwG7xb//NykWqlr3c69N7O6J5k3cPsP9OFFbCd6Jo6yevAYeLZEo
 bUBJ9eP09f2oDG6mcEuiIHLXDumF5ciUY00ltmoEu45JOTDW5O1IEs9D3Cd5mVYK78NB
 LrO/EZusxVcpsfGyNN4ramxAE96iUithIu8jEa7oZPMuGBcCfTWXwnp2JR1DY5ug68L0
 RjAyZHwa7/RmWA+VYlfZSM50hMktpzibnNCJQypB66o6xXjmUrfq2VqFwGk4Up3YKsbN
 r0fg==
X-Gm-Message-State: AFq9FYINkZPBiccL18L/mZUCo/GmXeXpT3Q6LlDHxeiLqMJfSTU1XUQY
 ugntcsx6ZCKPZgtd/v97DollnEIyodg8altRoP96cgBebxMduXyEQQyF
X-Gm-Gg: AYBFou2lNsNjxMWAjrYVXTF8ohgPs7dgMy+SCRQ2R5l33zmIOGTk8BnXO1A4jBcQsmT
 WxdnL6nfcWH5MPiX9/DCHFCFs08VEGpkejCHqR6Q16eeGz4kjPfv7ESz3MoZ1RE97gqUfaTicWB
 wCnJP/T7aV/P7O1fSz+9xud5MivqkxghfzKacuSB1zjjGs5L/FKn4qQzfmVqP5SjcHFJqc89Ldc
 Q8xTud/46756sSth7mv4zhya3E7yCSllQr7HKrqT3uepTILhP2PR+S+znGlkfusowftMdfBxqg6
 Sg/VstAMFlhYw4WM3iAxIVfXCIEN2iEdSpQJjyeEH6mL7oOE9z7PoBp6kJ5IMl8zqvRkdlKHcBs
 Tb9LY8pEeCHAaslehyXtT8KwU2fudatNthzMMa3VjlUryZi2NObklCO8wdTN2AhR3kfNmd+VRcR
 +9pRPAMPfU+g8RQdCXEO8BlN7pKI4XQqJdUOVVmDQa/L+VlAYTTkok2XivpM6iLsaeMkWoXqhly
 I835EfnF0na9cgweQoVRMF3omenUH220Rr/wEaHECsTc7cW+pYWU1q5RFT5syaT7eOLYz3zMLid
 T1WuEcszb9GPYvz4MpMStW3pclZ9/vMP07Yr+ZkE9UENcicvpLk2gJ/keBvPw5BhRqC9ak79dQf
 bbZtl18fwr1cC6XoY36/ukQ==
X-Received: by 2002:a4a:e847:0:b0:6ca:7a04:ee31 with SMTP id
 006d021491bc7-6ef10293009mr7705668eaf.64.1791837590923; 
 Mon, 12 Oct 2026 13:39:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6eef6e22b46sm10310084eaf.0.2026.10.12.13.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:39:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 14:39:48 -0600
Subject: [PATCH] net: ti: cpsw: return -EAGAIN when no RX packet is ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQrDIBCEXyXsuUvVg4W+SunBnzXZQjWoSYWQd
 6+2p+Eb5psDCmWmAvfpgEw7F06xg7xM4BYTZ0L2nUEJpaWQCstm31zRreWDuSGZ2XDEXaL13oi
 gb0ILAV1fMwVuv+vH88/dfZGr428srCmENpvollFtaFOqGKleQ8o9W4Xz/AIME2l7ogAAAA==
X-Change-ID: 20261012-submit-cpsw-rx-eagain-v1-bdda0f670600
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

DHCP exits without acquiring an address on BeagleBone Black with lwIP
enabled after DHCP started checking the return value of net_lwip_poll().

cpdma_process() returns -EBUSY while the receive descriptor is still owned
by DMA. _cpsw_recv() passes that value through, but net_lwip_rx() only
converts -EAGAIN to a non-fatal empty receive. DHCP therefore aborts on a
normal poll with no packet ready.

Translate -EBUSY to -EAGAIN in _cpsw_recv(), following the Ethernet receive
interface's no-packet convention. Leave other errors and the shared CPDMA
helper's transmit behavior unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Reported-by: Tom Rini <trini@konsulko.com>
Closes: https://lore.kernel.org/r/20261012200814.GA3799261@bill-the-cat
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ti/cpsw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 6b1f7764e0d..4d7869f405c 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -808,6 +808,8 @@ static int _cpsw_recv(struct cpsw_priv *priv, uchar **pkt)
 	int ret;
 
 	ret = cpdma_process(priv, &priv->rx_chan, &buffer, &len);
+	if (ret == -EBUSY)
+		return -EAGAIN;
 	if (ret < 0)
 		return ret;
 

---
base-commit: 28ddd369e2f7199539cdefe22ce014c592b890bd
change-id: 20261012-submit-cpsw-rx-eagain-v1-bdda0f670600

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

