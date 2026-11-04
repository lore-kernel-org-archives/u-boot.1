Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD557606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VcZfZwOZ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=F5Xh/73i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A934A80E95;
	Wed,  4 Nov 2026 09:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mES0zcNd-5HX; Wed,  4 Nov 2026 09:48:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 132B380F3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785726;
	b=l97btKnz0BAxTNlvQf7IkCWbaPX3g0dZFJCWCGvQS3haiM7pAJi0daCUnizyO6nJ1o2n
	 4ZMZnVnBcUWQWX/tot5h0xYEJ6kmKNmhtfymqkHWKePTUDo86aBf2FX2etIRwSnWJ5Gq3
	 y/ZDg1PZNJItxQVoqGHaUBaLtsusMU6fKVWLuJ8bXSHB5llkP/RYGyrTDrhv1S0yJi8Lf
	 tuDAe+Tf6U2WH5VwWsyKkgXpSiri0RuS+RKikwm0MUIhjdHfohzisVPePjSKSh2F9Eslj
	 KDWzCYj5dZUDolJE7cu4Ar8iIVxnxgdodEYb5IYtL4v8cMjIurqra8kXXHi6vzgXUjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dWWJJfDYR8XqhYhcUz/tYar49ZSVOcrKXJx6Hx1kvxs=;
	b=ryHPn85gl4Fk/qXX5GmDK55Fv97CBRYWV2aU3SLQxTWu1W5Ae3XwA0XmRbjc45kECM4E
	 giDravlNM/dcYGbO615nJSuOZ03KSCKFtOgErIigNG+/EMKSb7Yu8Y2RRn4Oz1xeRoO25
	 TbPb5XkJMBpOwqQCivigJ3Q6zBpVVKZVU6DNMkjXSjCra/vLySbIDyNiP+vy0BA+IRjov
	 X3GccLPc5dETkSSkUXU0YtX11w2G1Ic6pB+7r0STl9Wilc4ehGWh9ZSnSazHkZf16cFfz
	 FUibIyFhAB2/aX+1XmBVSnNsvSF4q65faljQyd59ajyaT+M3b5wPDUJvEQ8gCnwoIgQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785726;
	bh=dWWJJfDYR8XqhYhcUz/tYar49ZSVOcrKXJx6Hx1kvxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VcZfZwOZ3sNAjbopmh1nR5Vac8NpVCySGaeHiQUQbIJC73Y0ErFEo56ULxxVYfDN7
	 7fTBA98bLDdi3UpAm1yFcTiLuVF+REwyPhGV3PRLjv1/Wz0GSGf4KE7NK/Ozuy6D7j
	 B4a9p1Sux3v7fmOSG3I41kvizCw0H6zf53+qagUP5RNwa0FnCOl49utO1nW1Fuv/nD
	 Eo5YaPOexca2FsSpRcNNjYm0YsqWsK74UrmbHMeyHRo4bp99Tull1icS8B1fSLQfmr
	 6goYyVAUiTzbA11Cp/t8tHH2Q0QmHonA6YpkUqB8SctHIEcK9NtVlxCRn2Styw1nim
	 tpCQ6+2xU8o4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 132B380F3E;
	Wed,  4 Nov 2026 09:48:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16AC12B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0DE460759
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2YrHNdNQeJp for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 139AB606FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785719;
 b=hoummnpz5Voa51w8WuddksafOMJwXXMM4+1wFTSxiBXFAoQWRF4y6TSte4wD4sjUu/XX
 s9qTJcz8jtzDRg4kRKlVIiry4JShVyerrpdhv5As5pv9NeDTmnl/3yGhzmtBTZ2+XEC4P
 2p46P5mZbGxzLB/GDrEziMWSV5rKlgeltSgVF4+54O2YDGA2BEsEcGuYK+TQ2LPqvGLYl
 vRA8bjnT8SgsCDdNgPkbjukXyYu8x3Svgx4VsL+7pFJKx5wZf755Anx9JA6mAxFDxe4Qj
 dh6rgf+S3W0e6OSbVneXwisuUK+huaKOTSMtm4eF6MWo3d+6Vv7w2oYelt28NcphKzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785719;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=dWWJJfDYR8XqhYhcUz/tYar49ZSVOcrKXJx6Hx1kvxs=;
 b=D/njsu56Aiyhdp+wMI2QIcTNHvPaoUKi4T4Ep4bPOG+34uXMOCnsDv8p5yciXPT+QXMr
 zHGpiklT9ie8exU3Ovus/8iQWI/PyjskYLjoDrCGRHXFhZfXEUvvTr1Umh3Np1YIRd7K+
 Fyw/dPazBHXhsjvEi4+6oLjFOI79QVw12Y4ODS62EFklfyvE45UIzlr2TZcypzq/YnOI9
 ZRBMoNSXCtnQ1avxanpTU7KskHENZUaLfJfLA5DfArpB9SplOvD/Q8xZRcr70zmgTn3Ew
 grtpJpwb8mu9sanNd5RI0pVj+M4wMLg5fXhgiVtHjq9LoZR4xn53KV0VenjJ7ZyftIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="F5Xh/73i"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=F5Xh/73i
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 139AB606FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so354338f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785717; x=1794390517;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dWWJJfDYR8XqhYhcUz/tYar49ZSVOcrKXJx6Hx1kvxs=;
 b=F5Xh/73iVx7ZcndRQ0SQW0Xggm1/N0uA+2zPz+UMWuyXwKdiBsRg6RQ57z8O88HLl5
 dENFV3re2byJdImvnoUsfZ8qzc/cwE7Ki05N3+lOOsZw6JNaZFrP5bpmf5hwqk+raFnD
 gDmSXIIhXd1Js+h4SvGLHIEWguMJHUkKci2IU28YgjMISDcQ/m5I3tuB//eyVClll1bN
 iBbe2GBBlTqbC6QkN+TS7nDX/O7M2yUXsJA/VN/WuyyzVRPiwRP6KGql7pYheRe5kSix
 vpRVi8zYw+KKo2BrA+1OX0u8Pv/XxZ31Y/qf0uN2hvpw6Ju0xNRvbt6g2f+tylApZ/1w
 HKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785717; x=1794390517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dWWJJfDYR8XqhYhcUz/tYar49ZSVOcrKXJx6Hx1kvxs=;
 b=OJyhHV0/+AjWkreBTNeYWHWdam22UkYx9CjU0uuHx1Wf8e1QPxq9/dhMu8GfgFysH2
 LiiDrCkqZDbuAhT82AT2scl+qFZ7lUbxJvnmIBkTITOBMavl4UBTUDVPXBPfo0jzAweu
 +MLWCYNVZRcqbhAAvVzroDFB4l2XSCYps/EUBj4HIeyYJQpRw6EJnPxFzMk/PAkJrXC0
 VR8+nNOX+SaNwUbGmVL6ap6Edl/3rQ/BIGJDvY3feDLT+UTYwJSvMjolmj55g1Xp3nWm
 YrYJEN5075DomzKIub5TXJ1IgTSu/1sXw9asggYu5c9kCQ6n/vrAd5dVeUbhuZo8o1z2
 q6ug==
X-Gm-Message-State: APuU4Z+mTmB3fUrnI9dqFUt/cG18xM34CvfYMCBuigo+wLxbciqobN3x
 Gd3zqwSlgxr5tFxAKch1/EiZ17Vt2DNA30Y5YAhzT2UycKd6ndysGsUPFE7+lA18I9s=
X-Gm-Gg: AYBFou2XZRMDLmDui9+oYVL4lnItOza/Yo23K92kPRwYucIyOff1ChvZOhyekpnYKp5
 fouXjzpZ+gB57iEq1d3dW4gnvj/Eg09VYgdu/Rplgc6DeqDYVxpAsNx5JFsR7n1jDR2I3kdvSRR
 Hk7Uft8Y2xMhVhrhveJpAqLTPQH5Hoe2KY7WuCE9CQMZOgi1Z3oWuZfDQD/VPdoslkHS7cVBNX/
 YV1qenEgOP1urhkPqVXoFArxEzRdgdaghTmYpuV8FbW9LPdWYsLzEH1HJm14GqFsXshAtFolPI7
 FELKrUgz3jHc5os4QziYWCyIEF7oygBdYoUS6N9z51ejfZM+Qvhp5/++1uo5TtzTLcyBcHWm8Cl
 CDLOEU9yPf/2qNHqxzYWAyM7U4B+zNNjo06K1oM90ldSCcW1ZSkCB0QMVIx1CGX+WxEZtf5jf0w
 aafVGr4Xl4DG3+FBjJcOanmYWXJWLDGjATLaGsZcRy/mCK7pSzwoCYsrJFZ6x8jmJSu0AcgTniC
 Nd1+tBUOJ4pePcTU2yTB9wM9rQR7C9XyVjf4eZK6dhlhlsAJxbFnsLSGb/puZq17rLmBbyxYnC8
 nsTFPGQRGLjEyp18bnHrNyKRKQ==
X-Received: by 2002:a05:6000:47ca:b0:48e:7508:bbf8 with SMTP id
 ffacd0b85a97d-48e7508bd71mr19647237f8f.27.1793785716814; 
 Wed, 04 Nov 2026 01:48:36 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08536dsm2610909f8f.32.2026.11.04.01.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:36 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 04 Nov 2026 10:47:50 +0100
Subject: [PATCH v2 3/7] arm: dts: am4372-u-boot.dtsi: Add tick-timer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-3-6091edbb51fa@baylibre.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=537; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zETtJ8ybxcGAKhOAxh3HGcGBfj6qm9ouEuMXsB4KDTw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/8O25/0MebgooCF1ubJ1yqdna63OcT06PTXmr2vuB
 v7TJ+L1OkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi/L8Y/qdZSc8rOn835JS+
 2aZ9nMzzy/mPCjmueWvY56HLtNU0W53hn/7OgvZLPknznpQpHBMUTLjilrwis2ZpYmPUuV/zUo/
 mcgAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Add the tick-timer for all am4372 boards.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am4372-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 06e7380adf64..67a1b5ebd6e2 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -4,6 +4,10 @@
  */
 
 /{
+	chosen {
+		tick-timer = &timer2;
+	};
+
 	aliases {
 		usb0 = &usb1;
 		usb1 = &usb2;

-- 
2.55.0

