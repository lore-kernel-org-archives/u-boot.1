Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402A0CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B90883DA;
	Fri,  5 Apr 2024 08:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V93le/Up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA9C883DA; Fri,  5 Apr 2024 08:16:26 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999FF882BC
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4155819f710so12817035e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712297784; x=1712902584;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CWFv8FE4OPEiQdoCkp9sayu0SJRI5Buxj0f+do/vcuc=;
 b=V93le/UptOWIRG+657myPwr9LLrEe92h1XBJmR5z2MkPnh/wtMY4i0/yzy0iYSnlpx
 eM74CL8/NqTiofggptpiA1iu7wAGnCQ7TahS1piMqN+/DeqC4Hsg6LID5srLUmOUavpy
 9PzX/HvDip+xH8aYMmGEYrlI/0bmacIpkQgwoF1E14dstSWJhgL2CADv/73G0/VqXHyb
 DJZmfrCAgqctICT8dpj2hQ7O5knhA1SLw8wZtHlkiMUIZZOYY//posRz0awg1qEdrgfz
 r0sfE1P/uuprRNiiKCtSkI7tC5ySdv5dqY+8VyxoxQWkkJMmj5ZLLjCud+TxsNX9m6wb
 YuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712297784; x=1712902584;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CWFv8FE4OPEiQdoCkp9sayu0SJRI5Buxj0f+do/vcuc=;
 b=QrBfYzdsCHTJ1xUaqIQRAN6cAvUTf3tB/A3IotzW7v1eoddBNf+iBt5keZa2iDBkRe
 8OnvF6Fa4hUKXHGDlGD2F7ymxBag1k3TiMufaAZXtXf8lbU2XJ510sGWAeS5dgJy6+UK
 TA2Fo6+yLjfpD57xakFiagNZNUhS+NXOj2yIRbxqHGZs81z11OWZym4bWv1TTuBrHdJj
 bzYN7J4R6mEl9W4bUdiSOAyBA/K1M8wYzos6JNhz5NuC0N2Za+fAnWLmOc0mnI5SutzV
 y/C6H7Br89HdLmOH1eqgHtRwh/QnM8hHfn29JeM5f1uRzfZ4JJLX6adN6G5ncoi1xU7L
 u3lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhUoaQWOA20d+qZsR0ND8vuEOJ6Vy3uC7DrAYOrcS+E4YjF7+hPYt/aLopTufPCrBDVGuS06eSWstlp65VDnj0iR7x+Q==
X-Gm-Message-State: AOJu0Yy+dKNanJT3cH5zNEsps2SuGE1+TpxTh6mVllBOLfMIN+m6zSqL
 W3laL4A/qQ/QEde12tGYQZEVs9JVaBlQ3bUmP85P6agZ9W5TwMYF0ruh80baxLQ=
X-Google-Smtp-Source: AGHT+IGzqS+l0kcqV9Ucz16LMvkJqdqt/GTKUHsAIa5/Qnigx4QK2PrXa1MS9MUlaQTn3wDnDBGCUw==
X-Received: by 2002:a5d:4b02:0:b0:341:b9dc:eb03 with SMTP id
 v2-20020a5d4b02000000b00341b9dceb03mr415575wrq.3.1712297783899; 
 Thu, 04 Apr 2024 23:16:23 -0700 (PDT)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a0560001a5400b003434c6d9916sm1144316wry.110.2024.04.04.23.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 23:16:23 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 05 Apr 2024 08:16:19 +0200
Subject: [PATCH] doc: build: update docker image to latest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-doc-container-img-v1-1-f1e0ec59f5d9@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADKXD2YC/x3MQQqAIBBA0avIrBuw0KCuEi1snGoWaWhEEN49a
 fkW/7+QOQlnGNULiW/JEkNF2yig3YWNUXw1dLoz2miLPhJSDJeTwAnl2HDQxtveW15pgdqdiVd
 5/uc0l/IB5WcZTGMAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

commit cacc0b2678c0 ("CI: Move to latest container image") updated the
docker container image.

Reflect the change in the documentation.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Note: maybe we can consider doing the doc change each time we update
.gitlab-ci.yml ?
---
 doc/build/docker.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 953d1b28a063..45659b3b89dc 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -11,4 +11,4 @@ Or to use an existing container
 
 .. code-block:: bash
 
-    sudo docker pull trini/u-boot-gitlab-ci-runner:bionic-20200807-02Sep2020
+    sudo docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024

---
base-commit: cdfcc37428e06f4730ab9a17cc084eeb7676ea1a
change-id: 20240405-doc-container-img-904d56d5efcb

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

