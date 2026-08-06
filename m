Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A30C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31E4480DD2;
	Thu,  6 Aug 2026 11:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syrGJCgwxqk9; Thu,  6 Aug 2026 11:12:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3521D80A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014748;
	bh=NS4/98DsGKxYWtYv/FpA2t2bE99wKaN28rFzBJmI+bs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=imeHNswa5njaROQ5W/tsDPipzhJn+PWsqtfpugHmAkv0WdJSu34Pv8RErsraKiuPv
	 BeCl0mXnd7Qs0HnGohzGeKt7D4N+d5vKlqijeG9Qe80Lv5hzmLWwOQOg4IzJlyK6d8
	 giq8P1b6rKCL2TBu1g4vEWIG8ikrnIMdTkiN2qWRwPixzTjp9WX2JWRL8GnbeDTl6+
	 feCCawEsatJt/gcL0JY+uqBGMR0bnGO+2+OIQjknpq7/gDGY3FsPiQoucIwpk5Cfuj
	 3uy1Ezpx6ThR1mdSfTMfTJwyTQr3TTXIvPW7hMN5KK/wYFN7qnzoRIFFaR+DxEJ2Vz
	 NqTxZBqrG6jjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3521D80A87;
	Thu,  6 Aug 2026 11:12:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 326E52B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 302D8607FE
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAKhAtdglEpv for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:12:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F201860759
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F201860759
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F201860759
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:12:25 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a18af264f9so269302a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014744; x=1786619544;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NS4/98DsGKxYWtYv/FpA2t2bE99wKaN28rFzBJmI+bs=;
 b=J894dxUm5veswwfHP+sx3bXD1nzn46oBYFlGP4KEzoCnd5itnHq/ma1d/A2SQQ/YVm
 OAFXyXpbzF6Hl6e8Gx5Ze+0Ews8qgidE3XSM5v1jBosJBA8FHLiKG5fLRRMITTdue2yC
 B8NwPl20RUfDgsq89zKsSxsEpnChutf/uQyvEAu8ndCo2cnewJeitw9EAG+/3onxwrnC
 eclBsg17VwbI1PqKHjCkxYSaDwyIUpA1Z2u2hFk4vfnU3pfJN5TwCouRoY3ZjN0QDJpK
 EWUvKBs8qghkdxjX1NcV5GeXRmmyNGgCDSZwSdrp5Gd+JF6Bp+AH7iuTUnRApIH1YDQZ
 jQfg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0rZbdzYELifi1tkNiRaojvSc+mpWvgNnmHUDgJPceAlBc3KZsv8U5BbkTExFk8OTjvWuYhNU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyF7yDJdFQ1J6ggmwkDQJJtmPlIepb/4t+sNG7hD8hJHc49kevb
 /I6NaFxZocjzuOuz3HoikoH4Xgho0CukwserBOWqiLxz9RMCeDIBbugO
X-Gm-Gg: AR+sD10lS5ncmeFh3GKccmML48gDdEvWz6/8c/LwVpWQKnplZDZmpXTjMlXiosKF1V0
 hdbhbq8o2+24jdHyrJ+AbajU0CSeMzu3CDRW6cnsdIEurK08JvtYww2q2cDHecKLmvgxzvp2OEQ
 xFamfaN33Oo5rMAZqJGHKLWPDdyIdpOahYE0gAUpO4zJGSQiH9N+TxXrzKXhHvG69p7+fgCW/bj
 FHG+SzxztfQZbbHprH5V5ML30bCakDe/06fcnNRF4a6xmoL2kzxmGwwBkiDx66Z7I6nXtWqfs8c
 AsyYhesotofOPFj1Anjq43/S8v8ZzFZMKJUkjPUJiROo+cpdVePXEK0uRKm1wSpbOgFIltZtGNc
 UyBMaXg2eAljCPnQy9jb5k2zQtQPGbbF1oa4Gc0fuZqmm46wkhriG5zMQmPdGXTaFTkLzCQ31vG
 mc3LjAU5NFZGoRgoVro1XQPZw2exnBKqq8WQEW8nrhmC7mFVXLv8m9u62ope759t+yjjfDOxv+s
 imjfKoS2uBk4BleLp3ZUY0gCbI=
X-Received: by 2002:a05:6402:1909:b0:698:81d7:b812 with SMTP id
 4fb4d7f45d1cf-6a14f2719b2mr4170733a12.3.1786014743775; 
 Thu, 06 Aug 2026 04:12:23 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a1947d2a21sm777144a12.8.2026.08.06.04.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:12:22 -0700 (PDT)
Message-ID: <2bef25d9-771e-4841-8d6d-590a8dca4844@gmail.com>
Date: Thu, 6 Aug 2026 13:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 8/9] rockchip: doc: rockusb: remove reference to
 README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014744; x=1786619544;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NS4/98DsGKxYWtYv/FpA2t2bE99wKaN28rFzBJmI+bs=;
 b=HhajsRVASsOMhQ4n3l6uwPKyPz5duEOWCT2yc6le49uoUXZxIdi4qBBqNExTceLcgC
 egVoU5s5zBeedG1hy+MwIjHp8VnyBLAZ68W2UCz9QeDC/y8S+VeRIgVCKQYEfSdJbUUK
 TeqGittifKJBp7he4sNoZIA2RZ23H6xhO9ljAYMQ+etLi/gU3tEr4YO+KWSl70I3JIra
 OkBTfFusXZGg5k30BeEgJsXSqZwj3zRF8VkgCcNi7DADTD7YGBu1ALecy8OVplh4nJSg
 6WKDL0CouzL/jk0TF4gKXEk1W64oW12DbCSvAbxgiq8o4bVrXYmKzQK/28esMuS80vaT
 ZXaw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HhajsRVA
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

README.rockchip must be removed.
Remove the reference to README.rockchip in README.rockusb

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/README.rockusb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/README.rockusb b/doc/README.rockusb
index 66437e17e46b..5b96467689b7 100644
--- a/doc/README.rockusb
+++ b/doc/README.rockusb
@@ -38,7 +38,6 @@ you want to write.
 sudo rkdeveloptool wl  <BeginSec> <File>
 
 to flash U-Boot image use below command. U-Boot binary is made by mkimage.
-see doc/README.rockchip for more detail about how to get U-Boot binary.
 
 sudo rkdeveloptool wl  64 <U-Boot binary>
 
-- 
2.39.5

