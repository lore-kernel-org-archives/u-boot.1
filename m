Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5414C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20BAC405B7;
	Mon, 20 Jul 2026 08:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bOjodl0Sf4Jf; Mon, 20 Jul 2026 08:23:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0109B405A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784535825;
	bh=9MDlPZED3jHAcqD8bKnGWT+4fhedRFJDTkKzhwHFfgo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GCcb8VsALTkegQMChzfTKrzVmAdsPt4uePiM83POjbzgu9PFBzCHNvZcOFyz1Ufvm
	 HQiwKB09W43OM1ayq5XFGnzADSkzWmXOMYp+PZkWgnBeOh8cS/N8pTudToppX4+7F0
	 mtz5ZZ/xS4XmgL+AzVKq8biW8+M1RPqd7p39QLOK5GeBfo97vfhExml9ewHUCTwx3f
	 LN39foO0C6U/YKawGJcm2KqrLr38Z6A8dyZcA3Y/0qErK9lLHNfBGCObHZWTv3bk7z
	 mp5DaulCF9yk8RoouMeurBx5eU6NNTO1FseDXVMEPu5GE+OSn3m76vIyU03AGxDwQG
	 ATPMoEWw6v3Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0109B405A7;
	Mon, 20 Jul 2026 08:23:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3A83206
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0FE540597
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPgnExoPKo2F for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 08:23:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 118F340594
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 118F340594
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 118F340594
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:40 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso23590865e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 01:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535819; x=1785140619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MDlPZED3jHAcqD8bKnGWT+4fhedRFJDTkKzhwHFfgo=;
 b=VhRrYedyFKcCm37eLqF7wV3UGioiAUfssMIklvj620KApJUsxT7695qFn2X96ChRR4
 gzt/5WBtlpAy1qoHsahis/dcBvDOfi6Aj/3sTdIjw4SwWTxyrUdkWDd7N4qxq0Pbc+eg
 IqaDTqaFXWc97j9zZVx3QK1h55SdBFdU7LG3WiAo5SSKX38tgNQnmn/A/8xXKKjfxHEm
 9p7HUlGfLTJuwivh2bMrJBeZ4HfDtB2DNn6GaVzOwDMRfTPHpYNppTkxExHqHAsd0isC
 kpqvqg8G+oYeCTMO1KthWAujVtgomOLfU+LBqijpHqFRRJXaVJYZf0GzZc4G0WZa97OS
 iCAA==
X-Gm-Message-State: AOJu0YyutEBXJ0oE1a3vHrJ/UQuDN3UyzMMuzonHWnepcOZHGtpE2JZo
 IL4yXxOOa77Y1vZkBcBBhR1W/A9Fpr1E44tqFDJkOOtdhzhAzrWcjAqXegEcF99qlk0=
X-Gm-Gg: AfdE7ckR/3FXPE6HdzEsXtiydFDBswDFqjlXHLhVA28qWU9v11H7ktHBBDwhJhi7z9F
 4k3KeRAjjO6LeDjGUteFNBMyr7QYD9NYGYouvO2N9dvY+MtrmDHCAbl3Rl7dVOvhOTLSL4elzac
 8LDDajmh9id+d+EhQ93WKQCzTp9PK04kJntEWp21PWAE8h8fZd4p2qXUWnSDb/xEion8NjXPnhP
 Mdywa4fcPTTiBmnP4+NfAkP+DWTl57Xu1h278VqXonRsOTHKzM+ULxFkiY/uEcEH49OeycOGP+T
 om94P7ihb4SfnQdibOGXtFt7AIlTCa6MID29jw9JYedKHNcdL4gmG+S3v94P8Vydb7tHa7AvBH5
 bhzJ+T4tRhY2m57KSdzZ3+xnHkXJM8knMKI7hKQJxLiSxSeR3y81IvhKC3ZczM6v7nz7WkfPvWE
 560gXckwP+uClnauIxsUyixPc=
X-Received: by 2002:a05:600c:3512:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-4954a3ef7dbmr136301305e9.9.1784535818837; 
 Mon, 20 Jul 2026 01:23:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:38 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:23:31 +0200
Subject: [PATCH v4 3/3] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9Mw4bjjARb8IU+h1qKxNAa8MD97n8e0w03TNpZEhGLU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqXdsF9+xs2JQuBf22kiPHQibGmOZd4nZ3Y9llsoVJ
 n+6yvpGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCal3bBQAKCRB33NvayMhJ0Z9UEA
 DJ0WRbSiRFiWIoMzRFXOC5U60y8OJRR7IFf03WGv6WhZCKXMB8YJtYEOiXkUhnSQ94mCoY74Dc+cWU
 KkdcJpIGBjnDHAlVDAjp6BXW6bfMnAhvESQ0ix5sQYJaOULXkQbN7qMZK+lbSUGZoakMJqix6/8gcN
 WGd85rdBByO41wDq1vCkqoMtGqIauo7qr3obXak/b0hp7keHgrLkSEERtz7NId8gAb5dO57+mrxfRE
 vqE74pz9FYeJkgLwaE72a/EcrOgWXFCWNP8uRzVrlpEcdduIKUo5KW98lppVumysmfjrbhx6TY6aDp
 krSYsePQq/9AMCFgNmTC7mAlFo7qDW0xjf/O3nxeZWF9OrrHcsvhVKDAOIsfXBVZoIZbPUDcEIHAyC
 3Bh/96VmyFfWXv0nL1Q+5wtduhr31Y5SVXyygcmksGDO0vNLHm6Fsxn/3t6kjGkMBqZE13FEfq7tzt
 nrGn3+kZNiprITUGwpW3lNKh3aLguQkt6Ac5bswDY5ZnFJMPGdWtTU3zc9pkqZ8+/hkgJa79RvEMbj
 ULhEiuxUGgR3pLzvm+6//oFB40D/NJCptWZGGlLFK0RYbygcKlrY9IkHCTYeG22fJ4JwWgDm4gdfxR
 VoVGy8qXyNo0ng8EsIMOuECqnQaCAQyFbaQsugdpfHbDmpnXRvsKs+M0TS2w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535819; x=1785140619;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9MDlPZED3jHAcqD8bKnGWT+4fhedRFJDTkKzhwHFfgo=;
 b=vCNYGbVqhaMFsx3K+hHSv3EI8j2FJ4V+yD4JMVEphFfcvklYvBMpcBfUlZnF8Tn8Df
 kks+7iXHqyqWHNi06nnO322sVUhw9/8KCTr+SwK/o4M1j8UGb96WeH1QnhgfkMov7zpZ
 jXJDs2n8p41XI8O9Ma54z0qzYUwcRb8/+/CEAT0OSEN9ODfZj4hrj0kQnFqVMBrVM5qT
 5bzwT+OcLUvfuJwpe0gNwms2IqWA2DAR9EJLoAcJTvDan1xHR82d438mQqybgJqrJS+E
 TiZDrD5eMKM9TJyto2QalN5MpppM7dYiv3i83G0lkHcztk+AgU2uqHUuube980yh/0I2
 GOOA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vCNYGbVq
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720082331.r0nqDxc0A_jlSYKdK4EgOCpoO7O9Hj2wNxQ5mBRXCKM@z>

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of list.denx.de to the new
domain in the main README and MAINTAINERS files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS                   | 2 +-
 README                        | 4 ++--
 tools/u_boot_pylib/gitutil.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373c..177bc1fdc07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2022,7 +2022,7 @@ F:	test/py/tests/test_xxd/
 
 THE REST
 M:	Tom Rini <trini@konsulko.com>
-L:	u-boot@lists.denx.de
+L:	u-boot@lists.u-boot-project.org
 Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git
diff --git a/README b/README
index 472cf37d9cc..51e98d0f4cf 100644
--- a/README
+++ b/README
@@ -45,9 +45,9 @@ Where to get help:
 
 In case you have questions about, problems with or contributions for
 U-Boot, you should send a message to the U-Boot mailing list at
-<u-boot@lists.denx.de>. There is also an archive of previous traffic
+<u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
 on the mailing list - please search the archive before asking FAQ's.
-Please see https://lists.denx.de/pipermail/u-boot and
+Please see https://lists.u-boot-project.org/pipermail/u-boot and
 https://marc.info/?l=u-boot
 
 Where to get source code:
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 34b4dbb4839..59688aa7147 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "Please add something like this to a commit\n"
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
                   "Or do something like this\n"
-                  "git config sendemail.to u-boot@lists.denx.de")
+                  "git config sendemail.to u-boot@lists.u-boot-project.org")
             return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
                           alias, '--cc', warn_on_error)

-- 
2.34.1

