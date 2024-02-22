Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E44CC48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 00:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824C288022;
	Thu, 22 Feb 2024 01:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJQNRIUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7848802E; Thu, 22 Feb 2024 01:27:15 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5891888022
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso7786247a12.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708561631; x=1709166431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iDG45T1ntadBkRR699Oaxe0580xdJEHyKyHQ4jf5Eng=;
 b=kJQNRIUuwhHaznEXG0BB3b14PsiqaOEOZEi/0CnuV/lP5vOy1DW9fbZwL+iRaYTe/L
 ulPSoBmImt9PCbVydOyPdi4G4+AYKJXtSnN6baRTF8fG0jsNzIPsf8/SDRDY02IlVrWp
 3YPmFZFDEfoUxvB9u3eUKikiTAETjg8JKIPIjq0TWCRFXz0RleTVLCkh7FvXMf2oqNso
 VphEfbNixaJyYb3xFO3OI97Jni1iFg7FdBLQwIBxbbo7Y3PxhoEptzN1n9NbyuN0MyTY
 Pr57r6iY3HuNT370jzLgqby6VASJH2+AP+zwiK8ODDWcS+lNz94Jq4eOacXot+M3T0GZ
 PtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708561631; x=1709166431;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iDG45T1ntadBkRR699Oaxe0580xdJEHyKyHQ4jf5Eng=;
 b=gJ1w+sBUokoC2J8bLybItmsDg7iNresS3gJsztuqc/Er/3+uOJWQ668HyC6qA6rmqm
 8qnjxeBbdITrvgPbvC2OelcgG5npmxfzGl6tJk3K2llyrXOOydy5tR5YNv2Neen226oA
 AAgtnUVikofGaN87sUPVrsoN3cmbGSaFB5DAQdXytohoF/FGtl7ziY0eyGxwfp8GUC0O
 vQSFxTDul7DauF0DJxM+JiHfUFNyoJ3MvYoEiioPvvo1/I7ed7Nm2jCgWoRjZfOvnUn3
 Ytbs62QmjZRIsJHphehwKT1Gn6ukvaiQfjSN0kSfYWSDKjOzp5ItUILRDMoumLoThtk1
 rhMA==
X-Gm-Message-State: AOJu0YwbCLQxBAiqp/qUuXfyFnT2EQ3oSwvpRWt33/EhgwTH9rz7pIsx
 /wGkysmIlbfhhBa7uTI+tZC860fA9SbeK2iXcIsZCV5lzICxS3ezGj0E0rniTJP6h7KN2Fuxz58
 hmXNwqywKk6XvgbOcGGEgggZpEUKL+ZkU
X-Google-Smtp-Source: AGHT+IHS+84e0BWXts2YwgGQDXnKbHVwIWpkQCCZEujgk0EhxHjPMhBFwTE7ZVCUHYOW4K86y9r74J/pRrlaykxdgTg=
X-Received: by 2002:a17:906:3598:b0:a3f:33b2:5ce2 with SMTP id
 o24-20020a170906359800b00a3f33b25ce2mr2392386ejb.35.1708561631254; Wed, 21
 Feb 2024 16:27:11 -0800 (PST)
MIME-Version: 1.0
From: Bob Wolff <bob.wolff68@gmail.com>
Date: Wed, 21 Feb 2024 16:27:00 -0800
Message-ID: <CAF1iuRpqKhsDdkmC1jM7gK41JzhwVTKeh=a7Wtixp6Vz4M8Fqg@mail.gmail.com>
Subject: [PATCH] ecdsa: Avoid null pointer crash in ecdsa-verify due to absent
 property
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com
X-Mailman-Approved-At: Thu, 22 Feb 2024 01:53:51 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If mixed rsa and ecdsa keys are specified in
dtsi, an rsa key can be sent into the ecdsa
verify. Without the ecdsa,curve property, this
function will crash due to lack of checking
the null pointer return.

Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>
---

 lib/ecdsa/ecdsa-verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 0601700c4f..01ffc3477c 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -31,6 +31,11 @@ static int fdt_get_key(struct ecdsa_public_key *key,
const void *fdt, int node)
  int x_len, y_len;

  key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
+ if (!key->curve_name) {
+ printf("Error: ecdsa cannot get 'ecdsa,curve' property from key. Likely
not an ecdsa key.\n");
+ return -ENOMSG;
+ }
+
  key->size_bits = ecdsa_key_size(key->curve_name);
  if (key->size_bits == 0) {
  debug("Unknown ECDSA curve '%s'", key->curve_name);
--
2.39.3 (Apple Git-145)
