Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB6CA9ECF
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3957B80CCC;
	Mon, 12 Oct 2026 02:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdFBvWG8ignX; Mon, 12 Oct 2026 02:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DD3380CB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791770502;
	b=YmbxYdsY54Y2pKWiL82aZuexxVnOye8cSpUFAZG8rvTaZxwgnWcDYyMkcWJrjKF8Mk3k
	 KiHBaNn3+WO6pGDcLS2n/cLPx8u24yb+gTflTBbfajnh2+Mf1lkPF2ESljPAsqCGLrT6x
	 ly1P0oK1zuR5C8CouNy7qi9kh2Ivdva8xRS7fnfJ2ejT79GzvVU3V1r62oZS3ECLuJVFn
	 c66Ep/czAFcy3aaoxMNqU1tg61Lu5+5voviWlvtbzk3XY9Seew8I+DNfOPXWZ+VPcpaOA
	 scskCjFrn8962cU5G6GRpaCd96hV9CgpDROInP4myqLXWc6z7uFEGHhUVnWCs/rtFHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791770502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=69fUYdF9nxilkDD5utQYg51y3BUWKqhKWzIDs/RT/LM=;
	b=MW+tnAOE57TzykeqyeP5COCqlzAlegnw3UKFbe1+tynnaQoAYK39yN3DX5WYYrTYLjkf
	 C+3jy6md1FXza2rCZmOS6rmzJEAshOaiSpX7Y1WRsH/oOGm/0o/VHws6XNdh3CQsVRaT7
	 x2HljUBYvtUyifs1LxiKHGU6PR4ZvVINlZ8f9mK5WwI8yoX5PImEWbuka8WhNJ3i0/KlA
	 Nfm4RvR0QMhyKg98HLMXJontFb1lgv9NhOG0wbKlC0s5y/D/MOpBZaYlBiUeQYL+7IC2j
	 Ws4aZ3aVD1sLt0viJuikwEzK08Uei+h+qDuc+LO7jE+HrVTaN7UIAPWC7PgVi96YDNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791770502;
	bh=69fUYdF9nxilkDD5utQYg51y3BUWKqhKWzIDs/RT/LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/TKvXsMIBC+cBxubGZXGuOY3qker28ejb+0GqxBj4/z4Kf3TimZOCSTQeTE+Cxzi
	 o3fXqqy0RFSzVLICb7hb+ZXgv1WL8yAFukC+r94zz0B+JbvBOHHYJ3nF8dX078Z+Eo
	 ta/tm3qWx1/LDnDHTK9S9XfA+ak5sbl7e3AaFbVeGxZeaf3z1Zrmuthday2zRsO+Bg
	 yqiEqWQ93F8zOTIJAEYyGNo87oviHoijn3T/prE/sgBQJ8VgX0iZEkpdAY+Zmd/7RB
	 qnzglGfRAWmyaAw/vY/kNuo9BDuqSi5Oc+mgeEnF3DwVWXT0gngmnzCge2Ak2Wsxhw
	 H7Y66SyLekQFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DD3380CB2;
	Mon, 12 Oct 2026 02:01:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24F1D111
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15089405E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TZYd5X95Ccl for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D6E640573
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::664"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770498;
 b=TRHV+s8yljFw+jaUUiX1wkT+G6g7NIcUjHhHY4vbUpORu9RcNIozCx9aWccWqg6dYaPk
 iSdWQtL03gNTfyAbSkHhJFNe21+6JvPKdsEeHsCMpei4JV5QHnYdoKLjrnc0ybeOttOqw
 OC8AB9MenAHGYzpVDB1YPNdDftUI6ahfNTPOtXCV51HakowTHXpOf7gJCcaXRhAKZv+Dn
 SmlSDUBEGWZrzCCWO3YZX5mItlhUo9ZFF7IgVfm1aGnPVjaTpbycF0DwUDGBGlQ26/yF6
 3atoLKuYTLzbblEcL6pzfi9pU5QypjJllLduIKsEtLTKSsGw/a1U2iGj4m/+c/s1ldw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770498;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=69fUYdF9nxilkDD5utQYg51y3BUWKqhKWzIDs/RT/LM=;
 b=MpAKBZNtyzaE/NNLVFOERM2DB51BbHANEL+4S/D2EERJqXVtzOi3oqyanUPN9otUodPc
 VJtsc0jaxGKUd4CJ5TVzQ9cCIzOS2Ih30Nt/t7dy8Uu01/zLlDDFnPl1UoL/SmKuH0Stj
 7vFwhj4hZ4KzStcvmo5abjZgOXiViW38nWfUJtxaijQtL5jarHRXewG9+ZeE+64Db8W9J
 oDjRWbQVJzAr/0XlsmZtNkvtzbpQ+3Qta6YD45ciL5ZInnNoE5QX84yqmHwoC1Zce75Eo
 CEDquxm21bHR8xBox0Ftt0nuVTLR4YL+/KcoJuR0FpgQTcyjpSW/3G2xMsFW1OFlrow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=BaDyBXzX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::664"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::664; helo=mail-pl1-x664.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ausil.us
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=BaDyBXzX
Received: from mail-pl1-x664.google.com (mail-pl1-x664.google.com
 [IPv6:2607:f8b0:4864:20::664])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D6E640573
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:37 +0000 (UTC)
Received: by mail-pl1-x664.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so6397985ad.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1791770497; x=1792375297; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=69fUYdF9nxilkDD5utQYg51y3BUWKqhKWzIDs/RT/LM=;
 b=BaDyBXzXWwXW7jkkKm8N9e4OsMbP2PO/USk6ul1k/MYtkwu0trQHFLWnaqv2TaG2Y0
 xcRkklccy3OV0HiLjrjczgkJ4kM7CAetjDsYRqZqSN0PhnMY8DsolWs0pg0hplhid1Ei
 SUdWT4UEqnNQTpw4xxKFiPqA05aE/8h5cw3UqHBT4gVJfs9sVfs/N3oNTeCM666U6dWB
 IGMc45k/njjtlaToXaVyPiDeGRmDdORqrgrO4tsnQLPVZRJN8jKRuxuxvE9fKkMyz8Z6
 dPWBA6fgjViqDViPuFf9+o44B7mNJiCC6J40IJvUhxQy0u3OhP7jGnw3w2b7DtV2bT9h
 +IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770497; x=1792375297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=69fUYdF9nxilkDD5utQYg51y3BUWKqhKWzIDs/RT/LM=;
 b=nqvsdoJEJmufYjB1H6lrHrmQOSOXiPu2/QNVt0l0fc7hXtD8FuPD2pXDM9SxswkeGG
 MFolfsSUUFdH45VWjF3sbjuC9HJrC+93SzvZmxiqqpHKPlDQnPV3fEQOa9GTMa9C79O7
 A+LggSFXzqAqDklZpfjQkvyxmJJ/nV3rNJhIoigArVFtvRKtwONgRASdPo5ZpowkZ2AY
 mjwjNoZFTMV066+vOyIitHmZMK9nYwOIOCm4D/Z5TwQjinJ1FdPTft3n8ai++nIRNtdu
 sZ81yuxFoKFM8xaPQfdJmAvwkSp8ee6oy/pQtgs+nH1vagAoDl/nihdeAbStEyev7RYm
 D4TA==
X-Gm-Message-State: AFq9FYJtyOyBy2ZMxFktSA6dtIfBt4YmeRF5xW/MpxB6SZwnBd0Soa7/
 BuwDYSPAvnmvBDyMiBAmUbJTdaXWEzBJuuvxr+kfK6YKg+IvQC59z26rFEHCtd9D14BLm0W9a2P
 qPrhG8+AS8J+AS21YP9HrkCjpiLjL2VTEEKPZ2GqX18FJ
X-Gm-Gg: AYBFou2hJAugY7vS15WibYOHpAPI/4pU6Nv+zESl8iqfNPtUoovgtKEnEb3fRWs9T9D
 LxBq1T2NfKsnKX+ViOBkZzE4Odr5CX1ea4861ZGynMojPItp2kP2s8SNLNqa2OtgK6FXk9nn5yM
 ut2nbLOZrO1eLdYdOLETteXXwM22uGfBmUOB9gANbwTqKrPhmmK7Sy2kAzUafZO52pEMYFiwRce
 SwwS2kJLtjqkCNVTbIChaZXm+jQquLd+xDBRlg9iCwdK6hvM7Xi2cmbzJse0uYXMZoZEIOISJap
 y3cUiHwa1bA1ix+XRaCBWpKREkJReau5I8Wz8HxSqUG+X5MtyF4R+lganUy5gqmt2+8HltEI3ZO
 KkZdQAtf2n0clXjLIV1jHSc38
X-Received: by 2002:a17:903:4b24:b0:2e8:3b2d:c0e1 with SMTP id
 d9443c01a7336-2e840564388mr45731075ad.41.1791770497252; 
 Sun, 11 Oct 2026 19:01:37 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e84131a272sm3254325ad.0.2026.10.11.19.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:01:37 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/5] dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
Date: Sun, 11 Oct 2026 21:01:30 -0500
Message-ID: <20261012020134.621305-2-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012020134.621305-1-dennis@ausil.us>
References: <20261012020134.621305-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add compatible string for the Orange Pi 5 Pro.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Link: https://patch.msgid.link/20260511025352.106126-2-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 03b1c32f54bae3a4e73f82e1ccb322cfead24a2c ]

(cherry picked from commit 77c77cf4f0f1a9387720d9052673cdb9a01645ed)
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Add Reviewed-by from Quentin

 dts/upstream/Bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/Bindings/arm/rockchip.yaml b/dts/upstream/Bindings/arm/rockchip.yaml
index 1a9dde18626..ec130314060 100644
--- a/dts/upstream/Bindings/arm/rockchip.yaml
+++ b/dts/upstream/Bindings/arm/rockchip.yaml
@@ -1338,6 +1338,7 @@ properties:
         items:
           - enum:
               - xunlong,orangepi-5
+              - xunlong,orangepi-5-pro
               - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
-- 
2.56.0

