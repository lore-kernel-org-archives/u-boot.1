Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA443C9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 881BB80DE3;
	Mon, 28 Sep 2026 09:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p7h0ulW7gevE; Mon, 28 Sep 2026 09:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A59B780C80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587078;
	b=NgsAPlfG8eOGYpNzEyy+DUoKYwlZGYdf6DSOk/VubfOW/4+YTqOgjCHhJ9tgn+AyIdBl
	 5/jqt8rDzKQKLOsFhOLxF8eza72DxyhNbAypIf5p1gIoDBcNBfyflebXHiVmP/+856MIe
	 mkmNj+0Dr34SRK9bmuaXqUAPzx40uW0h05M5scSCPeftkufuHJH8lyV9d88kfsmLNX1zL
	 VB9As5p2UV9RI6Rs2W85e/RwroUy7gIfI4F86pJzaAgiq9HE90h9seaIxI/1J89HwIl4D
	 pYfKuDPNeueFt9v2syqvJPNezClaBi5h+Mohy8V3Q3aVX0IVH2Fl0z/Nr6rLjhO8XMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
	b=chtgR5k3flK102nhGpokOsS3ppNFN22jI7YjUeyh+9g+F1KwuhL7hV85EjgreCV2Da5y
	 E9yzcZBGxYWBnb0Xj0QDL54Yy2CsTE6E/SYCentm7KXbjceHYtDYLrGMqCGCZA2i1w17E
	 D440shYa8MQGRri3KMXwDNNNdhVF6OT0YbyQy2hGsJqG+2Q/8wfO2DLwHk+akuqz2AvpH
	 P0K5TvEBg5zjdINZHkhuFdvCY2ZEFOng4LASyVcHR1Nn2IOtiMGrusTHFQzLBTu9M7I6P
	 SUEgTdAjA0BJ2eevadwjMFlhNnk09BbINED9+8yNIm+LRFreDfuHodYNWwt1Gq3ksng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kXcZJ22O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587078;
	bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QbR9wWbAxP4Lo9gcVK/6h/kxK9xPnFDOp5hyhvomumk12HsGy6qVS+ncNQj5PSHUC
	 zLExSD0i/9V5OjTtdngIWDoe6OXsAjPRS4MD2ELKnIsA+ytDr2US6+k5qUQ+RfKOMF
	 NWlaq09mSmQhyAsBmq/KHU18Ng5+Z5km5VpJiWbGKh3cqelGxo4frnb0l981go7zDe
	 PpPATp5XmYEdtJRlepmLJWs53dLZqSTAFOzdNSlxEHTulIA4joXZ+5cQ8AAcE0CM+o
	 jIxqUvvIJupf3kkNApRr/7bWXXSX/Xxkwnpy7dGuw7sBvBD/eMac0mFGM+vB+s5zLD
	 evttWBcMXHHYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A59B780C80;
	Mon, 28 Sep 2026 09:17:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3F6F3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B59FC80DE6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nBdkl4ovXbNL for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A483880B9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587068;
 b=ms89oM7xVZryXXEa+yo8rUQpstn555FRTMrB3pNkp0eB7Gk90Odwnpl5FC/yHqT1XTGp
 S0UTCaJAId5fiJBAuaDRSbUJkZdDsfKDidafr9kM1G/oZzGv+am5p94dvqFRKSRyfwxkU
 qD/2LAxqvHFvRfHOX/ELeeUerSF9qzs9pAL2ai7nCvugAC+iUAIHfk7PN3BFAYUsMgDl/
 mnoLMGNOWfCtYfYqbszZL72o6Eucr/lSPTzhsQbF80/DXZVbkh6pFlK5BJ0V06ouV2Z1U
 5ZFIvRIUjkUGCjai3R2j7msyitiSSRGpKiL1RQ2ydpCrls2SVyi+bMivkdtn6onvdQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587068;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=V7n7Z+sBbRjPY8xnTd77PmClWfktRRwSJ4NbdYxfDOa3MmNmMndCDQLmmhjYdHkb6iVU
 UO33FkJLmsPlVXdATbqrXnGUTekioQR2GNT6kuOhtik/dtV2tu38oLPmqIzV3xQZmaGac
 nq55kJ3rnHIz8/B0R4BMMtaE0PN0K9Tm2poRiEMZ5NXG7lmRJtEgBwRCOzlMxCxUzMQhf
 gOjUbggWGbgLR774905OFSj9ksHZ/rvwWlbVuSbSRAPkNH3WWe8Ylih/J63BXWgekrtk4
 J3rd7IZhb5M5Sd6XQVmUWC8+8fdA06I2lGiyeIbeIOwGbfbrtja1FuvjN830UiQ1o4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kXcZJ22O; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kXcZJ22O
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A483880B9D
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffa15f67fso8762575e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587065; x=1791191865;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=kXcZJ22OIppqjxXtVnOF7WNDXA6AiVBUOryjXaLIUht4CDcdg/XZOu4NlYqPBSjpI2
 UPsjf2c6dpdZlLffat7zrF64Z3TjCrGRVRCLiESVn1TVV5k1N0rDA7tYb9E07iKZoqmV
 1hevAiPeK46Ub/Hb5CBH2tNQABePfi0x9tGwimqqlDZoD6ScZG2cMqXFMIwtSGIeYoL7
 9WN888w+ls391OHMWiOPXWnOjj00CrQR6BruHZZCXnknvsOPP5+mmPjC7e4YinAVgJbA
 uJJU3MMe6zLYUtJU3s+hdnlCcHHs1jcTgUQyaLaSf9socjB51nQKZUUocFzwKxi80ZMf
 4pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587065; x=1791191865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=P3xbgCWJggwEhjWUj7FroyX9sx2lZaZ8DJ/WM+60OEUuyAGxx/tA1ySd9o36+cbG2N
 HzAMqUsez1ALMZQqzmfNF1AF+4zjq+2soRksYVM0/9T7mWAu1Tkd8BeK9ZDE2daiNuOP
 1m7xIFQhmfuTVXEWKZNV75bnVV8qiTZYUGHdEbKvAmnjEC7r96YOYd4arhOE04elXnyY
 E+J4c+xAVdQ5dlffEzQ2ehxs+j2biV+DCzUtapwv7O2Yiefz6ZL5uecTx4hGS7s166ux
 6cN8npVF8GOIcRfzG7qvaY19pND21yMsSWEiFa8jEH2NylczLwcYLe0n6+t8ni/hHiJa
 K3TA==
X-Gm-Message-State: AFuF++n0l5J1MmrDgGukbd//A4NcFiwYglwPsI7KE59o/rqkIBCKEeVo
 0NoetI44/LUh+DmQnbhMhtBN8/YbWmqElWxFPWExVfMvnxmbWC9/yv0mMdfvC4PuAXU=
X-Gm-Gg: AYBFou1pyifppLG9h9GoPox3auf8/rZMNWzmxY8DhWQ6j8LilCOsm2382kZ17oL5GXC
 1cWZdVaGbWh/+FIh0/qJ8ddd2yUdhQ/8H3/qZrUUmHFPK6QNPWPREtf2DcYki6sMwPaVObr/RgT
 Q6LinvineJSSHOKxd1bqkLqnZd4lF3zVpVS8iMmWYfvcaDSrraWIlhAII1XHI13KFt1bKN18Qxb
 990RdVDfJxydLHIfPUJsGbnbPusTmKyIlw/LLwzJNkH4YGmKHYKt68EjkqyM+UG8gJH2spDCNAR
 AB45Q81vSnIeKFPSwfUPFAThFj95Ik5KI4JrqMzAa2Yq16Z2zgjNWU5blqn5SzPbKcfGvE5Dd0d
 iOqm8xgEiAiPMf03euGBzisADxNDAIRS2d28nfTR9PQ5iR8IglIR+B/ADc0CCRSDyWjyALinExu
 SgXTTAFjwvSYiL0EzpHQgu6QqfgvmOoXEuQETdBiVotY2emuUmHPX2h/oZmG+ljpcWU98tkHye3
 3tf0TjTExFRuhVVBOKbmsU10z6dnxIBhr5aBkjdibuAC/R9ny0zjWSRTP7XaCNVAHdC7GuJhLhV
 eZSb8MiqkmXHmfYD2jR+HObWmKtqthyu2z1ENT4oYbR/N/sjomXf9Es=
X-Received: by 2002:a05:600c:4505:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49fe66d069dmr196078415e9.8.1790587065000; 
 Mon, 28 Sep 2026 02:17:45 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:44 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:45 +0200
Subject: [PATCH v7 10/12] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-10-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

Add get_unaligned_le24(), mirroring the helper of the same name in
Linux, to read a 24-bit little-endian value from a possibly unaligned
buffer. The MediaTek HDMI driver uses it to pack InfoFrame bytes into
the 24-bit little-endian controller register fields.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/asm-generic/unaligned.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 9e5d93ec304..a68bd8f1991 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -22,6 +22,16 @@ static inline u16 get_unaligned_le16(const void *p)
 	return le16_to_cpu(__get_unaligned_t(__le16, p));
 }
 
+static inline u32 __get_unaligned_le24(const u8 *p)
+{
+	return p[0] | p[1] << 8 | p[2] << 16;
+}
+
+static inline u32 get_unaligned_le24(const void *p)
+{
+	return __get_unaligned_le24(p);
+}
+
 static inline u32 get_unaligned_le32(const void *p)
 {
 	return le32_to_cpu(__get_unaligned_t(__le32, p));

-- 
2.55.0

