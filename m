Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DAAC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2B48497A;
	Tue,  7 Jul 2026 21:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Mc64OUOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2837F8499C; Tue,  7 Jul 2026 21:35:58 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0938380433
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e9dd333d37so1547079a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783452955; x=1784057755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBZttinOSVvturGHcknvcBH+gTavNaRv4ilRlxpkEx0=;
 b=Mc64OUORSEAejeEKrsnG02eK0lJGVqo3r/MgzaATj85En4Y0u45rJ0Afov1oyICACx
 ipIyrEdceNbgy3Fz6x66J/B0OHR3ZXBzX6CLEdnBVKBp1Mb5FQECTKy4oCC+5gQkChpw
 r97uZ+6GSERFpItTPWqbGXZ9F+QUjmdExsuzxc3WQEMzE2gsbtsgMC7V/sSy6sfxnZVx
 7R65Nf8Em/EGay6Ka7wmr2x8n96HYXgN8sWrS7VdmwUHLtBCrSAhVgEjC+b+Sscy/WpC
 UqNz9ZClSUIttqajrkEoKjhxu8hTnPnsPHbEBpn2GO4Ls18yFqIUFxEUBPi8LQr1v3Vg
 D3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783452955; x=1784057755;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lBZttinOSVvturGHcknvcBH+gTavNaRv4ilRlxpkEx0=;
 b=rudYy99uH3EfWN7DJBq/4m5Aqtwjh6RyGdcl9nSgu+Nu2Fr459LRkXyZQXLupQmPMW
 pC6hdc56drTBawKadFiD0ZKZa3y6Bon5xv6qKf5QYgur8adsn8H16zqZj9HLJENxJ1/Y
 ig6WvfojfQf2wlEFBCIz5ea6g4rytCIj5z9yLUKt3jvoN5nXK9CTT6ufemyxyQ6WayXc
 ryelioFIuf3WoKt94xFJUyMZa51pFcnLpzD+Gfbf8814zIu7z2Mrnu79fRxLjvcVBB0d
 zqd4dRVO1YniwCqxtXFcFuZNakb5rRObIBzP9obxGl0Cnnbt3j+jFZbKVMOBkSzUCCh9
 pSIw==
X-Gm-Message-State: AOJu0Yz5jAKF2xw6wt1JC89ljtzRTBIN1W3bJV/OznhGNO9Tv2kRdWKu
 cGnJlzwxCziSBas2B6XqS6Q4IP+kFS6T31/NNhxiDFxTwPl5eODKzvaRK0su7Btx8TM=
X-Gm-Gg: AfdE7cke47YFC8Ph7iuakWHiA/0tKVVKSUNrJDEXzHGARvLnK1I1AJXT74MrmCvCCxM
 PJXsd6W2QXhnnb/zL0xdPf2cptHVSnG923Q7eurpkWyM8D6e/mC3y7fGJluES/AfwY9VGquP6AV
 gIabfvO/dTfTvh5pkt9dOTsDdkuwD3uAzlR6X4hcFmX8HlVnIOlzdtWeX+S5uzcR6jA8T8+lkIP
 ilzwy08lWgsMDYpS5iUmksIgZpX9mhuJfIegIzgSII22khJDgxt8I1u7woQSmn1ZmeYY+I0UIx5
 RuJp5yYwrf5nupa2HaVcxchWB1kx74HbsZyBQ54BNJ5vAe7dntJXN6IfqahjPFhireDknqmKKiT
 QeMrLsLLf9wrlHjXwvU5+z5/Lpn1hC/82zD1yA9g6ZAQFKgQ6A86/1VY8g4O5kvzhQBv3BVvwYJ
 FA3zhkTektmhxEW5iBMw==
X-Received: by 2002:a05:6830:211b:b0:7d7:c985:3a30 with SMTP id
 46e09a7af769-7ebb22cf6a8mr5019593a34.11.1783452954512; 
 Tue, 07 Jul 2026 12:35:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae1ddb8sm208508a34.6.2026.07.07.12.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:35:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20260617024105.152655-1-marek.vasut+renesas@mailbox.org>
References: <20260617024105.152655-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] MAINTAINERS: Replace Mediatek with N:
Message-Id: <178345293961.745447.4727684849141112722.b4-ty@b4>
Date: Tue, 07 Jul 2026 14:35:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=304; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=SOsiyKxZaiqaPRJeTNaDK/4twoWV6v5XZVGeod2AEqg=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpNVRLIWQK406FAsZVhHFvKVBeUZyXDnhVDAoOCuf2KKeZGB
 okBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqTVUSFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8Al7wf/abjXUZ7XGDmnUjLNYE9QFSPybjy9fbwLhvaA7DTY7byCpHT
 082JV6QVktqENsxVcDQN6tKGI5yVRIjNT4QCcUPtsJpDXl/ArPktqz3Fx+DxBAIXRnh2Gv0r4jQ
 Zw8x37lsakf/kpoPo4ULxT3z5ox+IyMu885KwKF7cAvtj5yHZFm4OVBn4gTgJ/PR0pUvLMsFEoJ
 h10zdWorvAcQJKospLs1IcsVBOxCqT1dQLejMYpdEpCjuaFbTOOgbR5mHgTvC6uIujYXtJN2BsC
 H8RXILoQgFeDKSPakozZwgsVPcll1shUeL5t0W9nRPiVdtIHxBANJIsi1rBmVVCTqOPy2Q==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Wed, 17 Jun 2026 04:40:53 +0200, Marek Vasut wrote:
> MAINTAINERS: Replace Mediatek with N:

Applied to mediatek-for-master, thanks!

[1/1] MAINTAINERS: Replace Mediatek with N:
      commit: ef6693efc4ee5da9306487dec29a7269546f4ef4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

