Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA16C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC7CE8133B;
	Fri, 25 Sep 2026 13:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIkAu2_YK-b5; Fri, 25 Sep 2026 13:40:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5034381340
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343656;
	b=gHrhxO84idNcZqohjuqgG4jl5eB44lsVvJn43MnDm9VZPi+gi3kTXilAXtNIY+aSleVG
	 3MMxszFVQpYyuyGOvjZH5c0CLY+Npv6iRfKND+dLAmNjAUJrkDO+ZtSbk4oFZUg5ocfK6
	 Yhl0n+UKI0WGs8MlDi3tQ48MAArCzHM8ZZZcSG2HMV5KhizSfRht2bV+YcMsLeQp9AFVs
	 eiJwjJHM94Cp/Cc7cQZOlrILvuLx2MZ+/CP3YQjJye0D5tOq3zrwPbHobx04O5IAjoaxQ
	 J/xvQmIBJcwLlGkXX6XwOeFkyG89cz6kCkRlYymRdxW5JJ7T6wjWnL4miY9wylsn/fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343656;
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
	b=jcEI+P+Zu57zv1vMBD+drYtCON1Jkwfa4IIYwGGG/U9Hl9nOkltakEtsUe/6sLgLGosQ
	 fkO5QZ9SuELSEr3ECdu2gA3AAOpCSrwQ9pRqXw+kUr385pazLOpbOFc+OuECykeXUqUJa
	 1guZ7wRCbAZ9jTN/F3qlh7z19OE6UOMhR4qASv70EuixzOvG6l//in9QkkiSscb4TOAgY
	 LIQwKsJQoTzYadehxMhDeRefJuNuwefgQKMlFDZDLFJlV3TQx30MAd1ZOlJgCWZvQVb2N
	 Y+lhONLGAIlBQ3ewb0Ud3iJOWgl3a/D7TA2GDv1sh7jIfGXPX3BtzjlWAaaXD+IWoGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343656;
	bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZLu93QSC67mHXr2vgUBk7nwp525YqAhXxr+zBl6ZbhV04AfQW3FvnQJIkJI359ug
	 Q6crBDPQnyeV6q9mCugtMSDEQEU7baETPT+Uh6dPxkRHS+uCgCZy63WlOP2ZZeOfF5
	 wRu8nzh9kD7Ph/TqDn9SYHrdHHhUIBskygrw5W8jNhRXN34PqlifDVXpIgBXSS2WYK
	 POY38VUI6CGKwKLX2lQdhco+yQTIezzwTjItYlRG/654ROOSk+V8dBL8FOcxZDExDB
	 XZkdZIwLqmA+JPNAxd4VzRtaycwo1PnoQbSxsPH9iksz3Vv59YiZIDYv/tP+UtPV+l
	 IKSE3skdOHIAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5034381340;
	Fri, 25 Sep 2026 13:40:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F21B332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74D1F60D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TzFrpxVNA8zO for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8A4E460B65
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343642;
 b=Bc3RIUjWSZHE5BhDDlsxzyii+8t0Z9g3mKWE2LwXZe8jGJElcreNEuWsi6Z55CT4sbCQ
 nFCL+IL/5mBhbj3Lb8K0RhOVFKJhWlSH4FcFnxWjL7vMhzF739X1bGKEvKyOEtQ29YtEC
 2DWJ7k24kbqOJgn9n9fSgfm67Z9I3tKQhJjtHFBspiRVhmDLoRvkMaZ5TLNmctb0o0KdX
 1WRoQWyBJg5pG8YWL5LfR9SmcwUF/hF/J/xWnR57AQuIa5NKgO++tBTTRlr+36p+6tRrB
 BtKb47PAwk5xPqEJGPnIfI/iVz/vr9pg8Ij2mKmsac7y/1uM42A7J/B1iy68vm0YAAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343642;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=lV0Heq2DwUoxbAur0PJT9WwDlwRXR6BMwOamNAU0qcX1uYQDA+T825yyhf1aJWS1mg3F
 43psAYoVAyKIC28Ahxmz1hJJGxyciovGs8XbgmhAyWVlpql3vIbrV6lbcGwUD4gsB7iGW
 wIq90Ok7fRfww5vMzuKmi71Y0CveCTWjDxcsQbgdqJD5BREDA2FRffUxFMANnTOfQUuFi
 Fb4kxeJdRCNOuoGObO1mxSvXqmdssT0bTg1KqGwKEDFvfbQIpj1lXHgVP7ZdunGdtmISr
 ya8wapj7kw3DBok42qxpVPECffGWNguS6jaqMe9ffsqQnyRfHHqKM0K5puQvxdKE0KA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SXW51rx4; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SXW51rx4
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A4E460B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso5276765e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343640; x=1790948440;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=SXW51rx4Xvvjd931gkL33h7VZO9nGgQfntwco+UMeLwMVrBSmP6M9W5+Ix1WgoySqU
 Fjqrz5pjp600l1Abvk4ZelpvpekXQU71obnHxWBqvC3ZhqSLV7KlStCjblL8qxiv6j2K
 wsXzjROVGzARY23+//4pXRIuZ09CgTFl4M89bPzeas/IdNZYJ+ScHb2bfWfm4CRB80HC
 i5cLjI35vKThBXYio5/XnH5XzUtna8AvgIHNAD9cIMkWQ5rH+9F1mVfffnRdGAdBMcLJ
 C4RvL+urLWYP/MXcfepUh2qUqQA1K4HAJjHSCFVRjdFofM9da5mNsIaWX+nXL7IDkXcm
 Lk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343640; x=1790948440;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=dz3AUj0PBZ7V6zDXCl94oXyAIjHn+3tjKde3r6EdLGRDCneXqI8E0y7kGmKG9qiiwI
 DUMEIb5v4WdT61pj6KGTUUjiICJka8UPpJMcVqxUIHlSM3aV7fJJA4vawvZR3Pg/Yeq/
 1RGpl8V5qFsYHnGPh/74hzdm5YYhvccphNeHV2IgiSxihMaqv0itzUFNxwMoy1Uzh/0I
 bKj2JkOP1OLWkeZFkoNC+a4/HTPRRhSw/qffDdqigXzvllXeeTY94WLsFmjsVXMgfLMg
 7ur/DOn6E3k0iilYnOFx5FxGM1zMq15YsA7kXCthVNp2kqQjPFYMM8A73EcQZCiRlr5e
 +AoA==
X-Gm-Message-State: AFuF++mZ4Oyt0k7IcJOOG7dFYJ1MTFA2YOBUO3yC7PE253kpvH96cBsQ
 4uqb+IBRfmApqkwRqKILN/W2KkueqHBGBcN+wgVDwRv/k9g7xM44fTPIzmJWZkBLYJc=
X-Gm-Gg: AYBFou06CPb+1JRt+1HJSbeF7k1+Ztjh+Mb79WK4+YW7atSB5H4yPsFoVMM75UAwSQS
 b6Iielt86jFivghA/Asfw6/rSg50fqlfFOe8ECDLLPw/iduEF3acromKtGj2ZrVJUKyOauK/npF
 dt0Ptygq2FqcXK9YE4kRhcdtX4QvfYdpNhV3+oo0nI1EZsHx49yLHbafACjZjzvC5nHkWjS1jcH
 T2OkBIzuhybb/Qq/ZMq5rbi3PLwisb9U5haG8Hjzqip0h/mQ7DcQeFqsitkpoq7ITC1W62ViuuJ
 T/mcQ8DDmK8Khx+dNBuki/aQ3VU8+aa6M8YcVoqRLGvJlReUBHZ6j3Kdet84hh7ilU1WN2LBaXJ
 VfE0ydpXTk53REn11f2DSQTnV0JrFVmQWTonO3Vi5J8cKfebqzjyupsCzK99qRfI4hIHprhLgQK
 Tfb0dhAKMS10Xy9V6jbg3Mq4G+HDDvkJtNna/C5ppNhyttxuZkeotMPKu0q5fatvTBxUOXZf7KE
 77xAZgIKsG7cU9AOcJOhxqgYIsCTetAj/N5FCmfjhs72xR/gn0CelNjiwR/xUzZiKdTDHrd0iQn
 AQz+olE0KvhkwZUT6NHJ7fB8R0wuHcT9SZLSvNqkPSXwMAOyk/RdSQB5
X-Received: by 2002:a05:600c:c492:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-49fe66c867fmr89722635e9.3.1790343640292; 
 Fri, 25 Sep 2026 06:40:40 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:08 +0200
Subject: [PATCH v6 10/12] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-10-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
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

