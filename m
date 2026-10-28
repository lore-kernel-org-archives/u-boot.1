Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A2WgrB9J;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w03a5R+4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 873A88083C;
	Wed, 28 Oct 2026 14:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuFVZ9hWZ4H2; Wed, 28 Oct 2026 14:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 584D481189
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198924;
	b=d2Yi/Qd9LkRrEleDHNI0Kvw6FFrAYST+IYzOcbmPKcwNg38v9kXZeXxxDYwAVhoIst5v
	 yA6jxN981C+NhPMY3UyaQyq7SPFOOYd6vq78QfI0e6A8WtMA4eHdXeQUU94xwTz1kea9i
	 jmlnNn+bgrGHoV5FQ7I9dTmiZigLxU0A4BKGWNlRPPxyDQ4faWS/nw/wywdc+mpwhHS+t
	 kcb+ZC58FJpBxKjeQmUsAyI0LnVwpJjfSG0AXdMm6pzjMenr88DPu3BNVDGwiCkyPEPy8
	 lOOkYe7AtXkXPJhwjrOAFIbl9d3hiiImgkwVitZa8Ye8pVC47gxao5Fve+Un7F+JX9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	b=TH1eVfOo+5M7ykW3rL2l9/uO+5AHZAXkcPMQgKwsYq3/5vME8JwF6YkD1KkmccfGMR0B
	 s1oAuU7dPzumx3eNbMk6nZuxYAEJYP9j50Sg14R9zFf/Fib1XFtl+u1p0OzgbVnMHbuoa
	 XU7nvJKtocu3ZWKdGgZI05mpe8Tr9miUhBQ41F/t11+PbfgBDBg/+OsRl6AbHzneP5mdZ
	 0S6Xxc60NJBZTHNkzU1PguVVL9GCTcde3QToBCdd3bqG9u2Ltd2Z2+LUv4gLPvpNQv7rm
	 gZya0dIGLZ6m5ShaGYbpDeX0Uf5nVSlIGmd0kS0Foq2kVaRpEkfnogj2Nh8HEeaAawA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198924;
	bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A2WgrB9JnVVnoMcTBj5FIsL/KROfsbv0E8KNKEMHnERhMkubnsIMZXmwGN8gMaiPJ
	 9OEworC4LKZLqHPEeMzhR1Zaqf4G6NXHxVj9eQoWzuUgbgzJjN3yZvOgFDsluHso5p
	 M2kmFE2fjUu7xltviobcaLJ4qfjVF730ktAg8TbepHPuQ0/E8Y1FIlDPBrYkfgtkW7
	 xP6Gwi6alArQ8Ko3YX2WEfBTnuMsUqTSL7vOUf85UaG/vu0AcDQ1aBQtnPgGJ8x5DK
	 TYzNsZMquRiEiymWe76OLBaPqHfjP6lsd4bv5RbrVVKw291ElQP8LdYLfxlJXqDSo/
	 wTaJGJwWWYHJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 584D481189;
	Wed, 28 Oct 2026 14:48:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E66C380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F41234009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3lbt5i_dcqI for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4A2DA4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197068;
 b=IIQdjwGyXQhmx/qV1+570GXzSzX3tYdN0m/OV3YyG3303Croh78EhK0tZ038bp8FQ8Pq
 HMDl20weLDEbKLadPVqIJh6R5QKr0uB3eHDqov50tdPMWYw4u2tzFoVfuqltLV0A+2OGn
 Dc5d1VcoImy+a+r32uRKojiy/McpjJGYxVD3OXO7NC/ev5uhPPQbpLaasa12EI3lNWxMH
 3UBLUbr6Hv0EjjpxB3QvqoOsvvMiBO3tEpxBu5ufGHJLcZ0NpIN880j8vh6maulq+bXBb
 eANDYs6+/2iKliqV1sb/p6hWhh1BOhm/pEuXBnUJC29+q2Cxz66AgQINRDtAXfe0anA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197068;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=RocUygv7wVo/Kgua9iuQofrbv/i4w2znV2Kg5QyBAgMg4VTbk7bbIh6vuAkbPH5wWLfs
 I3xYEIo0zIHn9ZB07NyLhdrOQ5IIlRRnBnhs1B6qqHbAi/+ShfCPr6f5J+GhiMglcrM1i
 nhacW5Hn+qOpRvOQbX7860iZlCEIFJodnTkU7oc2yIubi/nYvAIW846QgG35Oxb249/i0
 ShxYXXCv6Y8Bl7fkYos8/CkjdQFJSxr41r+XmKUCYilTi2lTJRVY1031dPlL7lo1uu31K
 I1SSlII/9WCBdHcS9iYibdChw/kUK/RBVFD2GkRx7XBXXkzpEjRmiKRrl/qIdX8pvuA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=w03a5R+4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=w03a5R+4
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A2DA4008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:48 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c38ac078440so11876266b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197066; x=1793801866;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=w03a5R+4tfIbg7LxoNF7AfNTbrPTPlyreDKm+bOCX3fS3iZ4RjSHrsY6VrGLlp/tcD
 /LJ/XHTK8wQ4Klfy+clMMoigxMUeK//SSAiPfOn+D0tGLEMPmlXWVkqPH4b7lps3Tf8W
 otRYrnxDiRE+fgRx1UJEmdWSx/GU08h9p7IVVrPWLsVWFM6va5WVYx+9K45ryRtdASk1
 ILGRQnQ6hWHoSsgIoDgdIyKjErL+oJqWk+/Ep+t+cUsLaUjMrxhDJOOsp6b8mi/nj3Df
 KdBAUqbutwwEKkjgr24y7l08c99b6RzpjhSDQQj4iabj/qbd+kwyPLk18rYgk2mJ/TfH
 vIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197066; x=1793801866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUCXB2Hh1KEVuBttkBHfzo9RbsDtI0CS3TqBKi/NtqI=;
 b=OOLsehh5jb0N3S45oMxXljJt1nOzv8z31Rz1NFrR5r7WNdVMzfYgshXa1bYjBC3KaM
 lQp8N+2uq1j6QYyTiTHz5rMpPTVGpA0dEraC5pkqLzC7S7y/LKNuivsQsMQMuYtcK3OL
 U1DXvGvtBGjiYHFnW4Jp9t/Eo6ZkZm7sQYqkR7xcy/Sg5rPTNRyuC4w07lvRvLqyS4jl
 ZZjRiqKo2ZXjv14x5Ah2fuiCYJxKTz06eDNOy4uVIZuqw9Svv4VZNd9NGth2KZycUSfX
 9AtjRnfnM43xFrJUe+cjo5hkYZJFuaTBIMVB+mopS3Q+Jd+WElUtPxKEDAFFt7DyhCoP
 OYVw==
X-Gm-Message-State: AFq9FYI7Py+lWQ0n8p9iw1OocKmnPjRJqNS38b9c6H5SU8hxyPiI9MM+
 WgjvBLG62Iepag12iRP48sWmNUVjmlhqzkrF95zObzWzC/EI2pzCfTiLtvO35HahPBZOtPieHyj
 xfx7W
X-Gm-Gg: AYBFou2wmihgHRDCGsxjPNTuXJwSMSZHnkV1Un0eZ/R+OQBTG8lVgV0hgJee+lrrhoQ
 bVbEx5UHnEJasJQFCyA77nkYvrl2ss0W2j49TGxr13uuH7qbE7TDAfCu2MCHQR/mdL/7vXFy3SG
 BeOm/REs2yLdafX8kTXViWIq4QJ049n+U0Rw7NhP1XiOleOQ9nWSjjJzL+z8UlnLOURrvISQ5bT
 PIeG6hYI1JPzGPFrxJwksTDUtjKVTcm8H2UX7ySCdxadJmrHF1lnIlWdr8jKW4qasLW/VFIURYv
 xHMiCyFZxV5FHe3H+xPdUXZizepRieT39BdM88ojFJEy2wd7yE+9m4hzgkgtQeS2m/FylcBhZ/A
 fnDJTsMyeTnmbjcFv1mr5EPhcj7TRbyJdB69U3zBW/0wLBrka4QtXPSJuU5Sl0s8qmIdrGBK5VV
 i/CndLc9HH05L77EnvbCPhYdfqK3SsqTwAPNgvG/Q71W2NHVVd5NHvgkSASxtfYTBbnTKCEPxR9
 9vqPoUk5NIaw0gzGHJ50o1GfqFYibzDCL41T40ToOA7Hfkb/ay/PGQZctmLRdFhhy6cHKhclSxF
 iad2b+LnZiwcvSSizzJg3peicltu10nJYpBE+5vr9Ym/pH3tpNmBofwRWqoNlCa8wDGeaHh3AGt
 sUMt8v8A9Vg==
X-Received: by 2002:a17:906:5154:20b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c49ce7c8bb6mr46829066b.2.1793197066287; 
 Wed, 28 Oct 2026 07:17:46 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 26/30] usb: mtu3: fix up after the resync
Date: Wed, 28 Oct 2026 15:15:50 +0100
Message-ID: <20261028141554.3073545-27-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

Adapt the mtu3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4b0bc5f02d10..07775d23d508 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -300,20 +300,20 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	u32 value = 0;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
-	case TEST_J:
-		dev_dbg(mtu->dev, "TEST_J\n");
+	case USB_TEST_J:
+		dev_dbg(mtu->dev, "USB_TEST_J\n");
 		mtu->test_mode_nr = TEST_J_MODE;
 		break;
-	case TEST_K:
-		dev_dbg(mtu->dev, "TEST_K\n");
+	case USB_TEST_K:
+		dev_dbg(mtu->dev, "USB_TEST_K\n");
 		mtu->test_mode_nr = TEST_K_MODE;
 		break;
-	case TEST_SE0_NAK:
-		dev_dbg(mtu->dev, "TEST_SE0_NAK\n");
+	case USB_TEST_SE0_NAK:
+		dev_dbg(mtu->dev, "USB_TEST_SE0_NAK\n");
 		mtu->test_mode_nr = TEST_SE0_NAK_MODE;
 		break;
-	case TEST_PACKET:
-		dev_dbg(mtu->dev, "TEST_PACKET\n");
+	case USB_TEST_PACKET:
+		dev_dbg(mtu->dev, "USB_TEST_PACKET\n");
 		mtu->test_mode_nr = TEST_PACKET_MODE;
 		break;
 	default:
-- 
2.53.0

