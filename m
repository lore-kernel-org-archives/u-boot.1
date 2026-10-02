Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074F0CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0D5840B5C;
	Fri,  2 Oct 2026 13:23:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dv18GZjGJdrw; Fri,  2 Oct 2026 13:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12BA240DB1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947392;
	b=XfIYg1rNU9xyLXsR+pGiBB5Pg9pwR7b2KOjU5Te1yxFTzIRITVbI63798w2R6fBOOf7D
	 KJQtUTzTMq0dMPJ/u8VUhev/ogU3A6BS5VyBUHIe7r4P79QO3L3YOZt7vUj8BK5e24eM/
	 Yu5iTYo8Le7hj2X7Xl4TbDD97RWi8S2OJAR06X8tQFGWCIzgrmdjwzAW3gUvA2GiyqJhT
	 MERXMLjPOrP/nq/xAJ+UQoWr1R2xjejsFnxu9Z/dFQxasEgnQjUWqXS29epshm0zjGTKs
	 OQUaeecxWwfTe7i37JfJdJNlCnXZvTcS6Epk19QJW97Y/TlYdVJAOJmIiaQa2l3m5lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mTxVPlEaiZWVzR2HlYrYQFlUcusGa5jS4cO/gudgyUo=;
	b=T/JuGoKjwZoJ92QQzLkrhh/2zLoR5geDsf19v95STdta+Ioi3Oy2bPhJGvz9mjpfsx7S
	 0MJj0OedXZ9pEKKOx/7ohaSWqmQ+BJ+edyqKaASETOj8Qo7s+sGd/EY9zjWTcRGhMPvMl
	 FadJhknh7UeylrCSSCSsBGZfsQMAJ8OJsGS/0Belu/FvwbGHQEBuRB2wnQgQvKw/EFS/K
	 qNAwnSGCUEyFCTKJjtgoS40bnJOxvV00FVkUsLPjK4/T2+sQsfz7OTcEXSlIVEqUrrA5F
	 M/IfSbFBMUJJ19dbivawrnYeYuJEO+T7GPALmFxqxZ8I1sHCT5aAgSaUvn2f/7klhFg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947392;
	bh=mTxVPlEaiZWVzR2HlYrYQFlUcusGa5jS4cO/gudgyUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gw8e5VNVyyTGFsT2b1HegoFIgV2yxQQv43yQi42BzAExDfR7eO5wfaJ4l/tqwMPTQ
	 c0xvrr7p7cqscwdCg8f8AH+vGmwLgsW1H6mUjUFxIy0wu8ZFO5mv6K+8migrpq4+yV
	 4mgeQXVTtWeGPGGYod/JOcIsPlFOb+gAi3XVfQD6XF1+6IE/pbIcgF3p39eH79xb4/
	 RZhB8I5ShRj6HqHdXyRHKEONWYZdvLRINXm+gbD9LqvMszqp3mqpaGb5e/74JlU+Kc
	 cprZR+GQpiUB4DnXSCBrjMhQ7977DAT3gZyZuy4QHTnYIHIInljV6Et1UxCH+7Oidx
	 b0B2oLfttcQbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12BA240DB1;
	Fri,  2 Oct 2026 13:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D02F634D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1A0C812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Eh2b3pqgjIQ for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7DC3680F5C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947384;
 b=jAGveDIbF1qX5ZhkuvpWTzeOecVMEBWuC1mAeZyl2wqnv41uPeX04ErqA7ExdIwCeFVP
 o3UlVHE8y1k+goO7ZQVdvtQZQtPbR8orp2eiE9v1c+JdxadYr1YT9nr5HXHHbaCp90ET/
 aOx2bkqoCd1z7ZOhraY6CF4hPjvmHWWpfR6gdciNIQDFD7Do4JN3Qx15wKqlBEAsiWdqx
 6+i/zNtyNyhl9sGiPe1j46dRnTgYyY5soQIGYTaibzwp9s0QlgqvoAlOuC4eCRVg/z/lL
 ny4pVSCQDRFEK9DZ529zQ8nD7FNiNQ8FWGOCznP/cqM8y4XUhwnDWthNItKC/uND/JQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947384;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=mTxVPlEaiZWVzR2HlYrYQFlUcusGa5jS4cO/gudgyUo=;
 b=PwNl6Dt409C+nvmPFrr/djqjHRNPpDO/lhxnpi0iR+6dtR5GHOCsUofUTDk3Dsra1463
 3Jdl7RZc7A1O0P9wA4sHeD/Zgw1XQ3gOOqY38ILSFOw1ATPQrbxUVkYWo1H2MtSWD1InP
 dTLDiksS/B395R16W8zoP8l0uap+jk8YBNw3lBt3bZ+Ttl2DjVWwOXUaQhgV7JbAMSIAV
 jaNN1PwFWApAH62TigJSvV7rN3WAK0iHHba4hcYk6Uil+qlePALfTICBwD2T1YJdfLfoF
 GnTIANrt4lNKv61LT1h6UfraFC/3w3tRY10K1WuCdS/bXnHV+nyarzo8PQw0EZNoTnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ixosfU9E; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::c;
 helo=mail-wr2-x0c.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ixosfU9E
Received: from mail-wr2-x0c.google.com (mail-wr2-x0c.google.com
 [IPv6:2a00:1450:4864:30::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DC3680F5C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:03 +0000 (UTC)
Received: by mail-wr2-x0c.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so4462660f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947381; x=1791552181;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTxVPlEaiZWVzR2HlYrYQFlUcusGa5jS4cO/gudgyUo=;
 b=ixosfU9Et0vW0/ODy+rkjbSiGCFwoNs024BkeHTy29KwWFHb2tWjUTqbbt1i1YqTc2
 mLBOJWa/e5NYcHKeA5l9lCxpQWVNoowOlJ/ru1yc8II2QW5sprOSpFSjgGpVOvo6Bca8
 dPV/rxQ+t4CSTfeDRhwuapFbhlLN4rDdloLV3m2gUohFsbgnx9zldOR2FzXsYUBwDpSj
 xAiF2a4UcbifCRwsTEMJIRMCA0ycqkteIjXkhJN2pdNDBUZdw/A8cP/EXt3Q/fHRz083
 /K+52Y7rqWUQpljHyi+EpYIKmiHf9aPKhUF1xM7itVFlOel1sLVEDD49teIYAqxcEyQL
 9XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947381; x=1791552181;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mTxVPlEaiZWVzR2HlYrYQFlUcusGa5jS4cO/gudgyUo=;
 b=XjsxUPc5/HVwrLAmKIWHbZUfS8TEGkTfrVHXu+2QBC8PEiCJVb8qmOKrsD5aKkg5Ra
 rMXfC3dodlvmWhljSzdyOIoveYeX+0b7Q84yd1VhrLeZFlYjI+a3IORfrErZgzPNhLJx
 ovSvOEtnYTGwxTFD81H8Nja2QcQky0v9X3gk0FKOjax87aGwfxlaTyww3hqOJGnb1sZj
 rMIkDzKGHPj/oNz/e50mdUKDNbWEmSreT+xU44KhJmzwAkchD0DX0ug2FQH+leww/Ouv
 v1UkZFkjvIITN7lKiT2Vl7qyN33bnSGzu4m6iFs9b1436EcdeYUE8211LEGmQ8VY5MrE
 yaeA==
X-Gm-Message-State: AFq9FYLbkGBKt6Kdlsz7w6XNMcaWOkTMn+G1Ejl8bqj+v2CamSQyVDbp
 kBl479QDFtTIHkmUVxwuNewVoLFzS/bajO6VfA8ClRdmZ5gH33tNxNxsS6iYWwPcfpM=
X-Gm-Gg: AYBFou0OI9cN0oRkIzsAZ/a2Il7whKE5tOQs8L1vDaSXf4RXhtHs824PEz2Fl6j6SUx
 Acu7T9P7eWNv4ATYNxx4WE9EgI/8MM0zD3qJd3sNjJ28H26NjLf/n1QyKaOPKSfzD8VlSt4KSKg
 nTAPa/IgJol08OfgVXfnUhUZNA9QY/uI47DbmDCs5BaOm3cR8tdlerG1f25sVd2PwM3uKzqlbop
 Dyexnl3bXz9YEeAfNBox1w56wyaKyrph6UW+5CPH1EdHGY0bvSoUwIEEQJiYIQWqa0YetpiBZMz
 s8NWpwZqCy3jWsvQmgpyzRIU7LEqm/y616zzCu39oAyEZoNMwovzMMe8n15f9JyMnO0kZ8HxsPp
 45zC+35aC93GNtoFKANsVuiOfVJ6jYtP3S/SUWjxrYYUHJSPzNSikupnam/eVaRJzUY1PskzgnC
 2c6kopqUVZ2E+5ZeEkNEIYLEh9vMfBrP0p4Fq/3jv5tWxs+ag1/eGsu3vdqzRcVMoSN3vX48o6F
 rNhtRK2U2mq8l4ZYlGbZcCipIwYtwNMH0r94Uh2WXkMUR9goSEZdFZn19zxZNiWcUY/wJJBWz6I
 MiOgtssi9ehR28d0fH8+w680UWcNQkZ5eYrpz8KQt69ZS6XLhtBM0G0=
X-Received: by 2002:a5d:5d87:0:b0:48c:4553:790b with SMTP id
 ffacd0b85a97d-48c45537989mr925961f8f.48.1790947381420; 
 Fri, 02 Oct 2026 06:23:01 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:23:01 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:44 +0200
Subject: [PATCH v8 10/12] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-10-2a6de7cf2a88@baylibre.com>
References: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
In-Reply-To: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
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
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=1135;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=kQYtQZ5uvL0uZtVN64ZwedKTExuDlfkVauAHFadfeqI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE27QnunJ77F9WBBIhIEsJFH8u8bdQu5YY1E4zR7/g55ynUN/NdprRwcLoe4m3eMoKyle7QfCl1
 ESoMHpMmYJgo=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

