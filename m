Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CF7C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83BCB40737;
	Mon, 24 Aug 2026 08:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJGAaAYh842H; Mon, 24 Aug 2026 08:52:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561521;
	bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=modUUQhwXbwgOd/9H1GljCN68mjzgnGb60/SQqYs53nkWnqc3OhhZfIFiQa6F8OGV
	 0SUIPYZ26QvyTm+7eVywKanPz/bhzZtFUKZRXkzNvp24HwlHVMEG1hQMGeaYqyjdcD
	 UNCDEF32jXhCO/xjnQ77HHNumWmtJQRIMUPdRpicDwDRqbIDptt9EJEv3AB7yCAXwF
	 i62umTB8IRa/JFzT+JhbYTb8Up1yTnfnbsynVnqHHVijujLsV84elHj40j7AbH79Yb
	 P0S1C49ehroFX3f0/8Mz8JJihy2tVevaUye4KYLroWur0Mj9te72AM77ecq29PJvU7
	 80PKcvUfkC6nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E86406C5;
	Mon, 24 Aug 2026 08:52:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F68542B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FA01400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2A6dn4e96_o for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LKE3G8TI
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DE884005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:59 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso2315946a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561518; x=1788166318;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=LKE3G8TI8tit39ytQ3vkxh4C5Stbgb+/BAbbOSdJ6i2xyNKqFesZ+JAmUFeZ5c6yLD
 MiwYk3Hb5h4GSQLf3Vf83V8Wt/73VWlhmyqtosGvxougQNNr0Rez1S+vIMSo8tQvIJvP
 daR3sEgrZyF6M576EjQQKAHeonJhhWuzOn0CWKKLPP6dUdBITiEHSs/S30s8WvPSbG8s
 /pnWph2FXyEScTvqFkcMI74U0g3gqlIGRthiKtyXXok2VH7mQXkgSuK37tZ5zVyj0bzT
 1z3VrvW3OgXDnrjYckgJ3gv05ZLod+ein8P9UQJ3s1w5UWgsVwUwFfcbmKVI9HiK1Dz6
 C5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561518; x=1788166318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=nJRdvh4vjl0hAoDcK7n05yGqJTJXZIxA24LlL91kfCdQ4XHWnHIpoSaf//FER6irlS
 gQretFoZMoxVSYQ66ACaWYuLtcA7CzaYvAA270VWuoQbI3aKKRofJOajinpP7BOhWRux
 fMkFXKq9wKgfXGf81ovDBsvY9zTlcbtz/y6UkD6O+tMDq9F6eTMGxbGCfjlyFYjxXSYq
 6pWoXsayJrcqumMooq5cTM30F7a0ZA6akqpV7Yt/y6/6WNrvmD66JeS47IhmYkZsrVw7
 lZakjxD5wbXNUNIOIEPZLXieegHkqobt5yVuPOyKyhrT3mNUK9NQriX5fj86S+ZvkUkO
 Oisg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGeKFEuLRjEF7uJo/iSUaHeVf4yIPUyJjcxJahUpbjflwszyB3l/RQ+dUEXt7uhlfhS6bZq68=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lxp8JKNH36yiu2Wfev1u+RRcdX+cMLCDV783XXHijBt93G7u0C
 z9yOYFCtNDppJ60XnEgqEUgSz2XXZJdArqwv7swZuEGBFe420wP5dCYcBkONhUzEECI=
X-Gm-Gg: AR+sD12pl/N3Re2y+R1C0ronk8tgDsDZ+FwX/crSpgNbwud0UakgG0X4zo/ERIgLsJp
 FNX/VPrsc8nnkF9IDOF1CnDsHe5VNcd9HR3TFZpwmjws+EYeamBKtd9KD5IYEbxIZbQVslftWd9
 Wu8tkh7XtxZpWoh4YLcSziljvuq+dJ3Z6kU6iDF39gLolOp2SgnJy+DIJyOonTO5QxxLWvSynbc
 sHSxkFADu3BA74A7ApSMaMdFvRMnsq0nIatPz4ZTmfAxH2UhJmNs6fciHhErfo9ZWPhGffEjtUQ
 F1aXmCztjrQKIflvvBgjj8EkTpRRDwQo1+OhHxTnwDeOXT0Sd1XAsU9ZbGnoHTl9oYcZ5QUI2R+
 ylr3ZA6rxpvYBOjroQuGkwU0emDwcEK7sxfSw4/72nsEC+QbzqXnLxUxDQA7gKztBmZpLKcxNjr
 HZQNoHyOX7a+MHE/bWedcVXiYY0Bd79JmxJvQ9H9NNimLzwi+GQ7PpJYAHJ6wDOeFtfeUnDxCJo
 a6wh690IiUF2S71KVj1X0oEgnEoBg1zPlPZLw3B+uN1DHgbA8ugg+E6pVYcRegVGc5aQfJOhzf2
 fdHSz5SKhBqJU+mK1GifsZMLwg==
X-Received: by 2002:a05:6a21:2290:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3cd4b6850a3mr27082710637.0.1787561518562; 
 Mon, 24 Aug 2026 01:51:58 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:58 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:46 +0800
Subject: [PATCH v10 11/17] riscv: dts: spacemit: k1-musepi-pro: set default
 console baud rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-11-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
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

From: Andre Heider <a.heider@gmail.com>

Allow serial output with the same uboot/opensbi settings so the
console works without providing a cmdline.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260513071958.29574-7-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: f125c6085fd775f09a316f61cc89a0ae86826895 ]

(cherry picked from commit 5a2fd40a11e3de8b4308b739971ab1dd4ed9ae5d)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 898b537ba0bc..4aef287353ca 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		stdout-path = "serial0";
+		stdout-path = "serial0:115200n8";
 	};
 
 	leds {

-- 
2.51.0

