Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AACBD78798
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 16:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED2D89752;
	Thu, 21 Nov 2024 17:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ItS/nJbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD7F89669; Thu, 21 Nov 2024 16:57:05 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7E6894A7
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=john.olenski@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7181c0730ddso369645a34.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732204622; x=1732809422; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1vptKxE6R06Lp56m20LORYpDkao6w8qdPyTNpBjo9mo=;
 b=ItS/nJbiNPVKwym/zSLsQAd3r0+UTgmUWYMoHgCJtE6MgeYjxfF8fbocdBsHjdJN8F
 yzqZglybgsZKSN9JXHpe+vCt5fjd7/axJiw3mioT5eXIqycBvVyRevrgtRsxeejnY253
 7hNWfX+dbcVW8bTF3mXMvCp7jLHtKvzkWoi6I91BWme5OGT80mJqMGVCLCSvUT7an3bU
 0GZiDmmlI7hFqpdjy7oGOTTkz9yE0rqEaC5eRqxGnhy590AR5e95apr1DrYUV9NaNCiO
 M/hu0f1L9qpfKj1y31IvYm6pPNjpODmaEr0rd0ih5YfgOaSP4oFDPlbgqe4TC0m7GB9g
 7KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732204622; x=1732809422;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1vptKxE6R06Lp56m20LORYpDkao6w8qdPyTNpBjo9mo=;
 b=QX9ukE62+xPi8Y8FJfG7smw4U/nRn11xni4NVU4kt8KBRHV1LDWOlPVSVycCKEKqk+
 Atd9abKHljwOIKjNtX/UkkqBAw4N4S+2sAKinteFBn24gC3lgH2QLBKHef2NC5Zp6rAE
 8FLWqW9e0VVWSqZ69fUg1gzmh9JN/nYl6Ra7EFgaXYCbD9xW/+T124cB8iLaZx1KsFJ6
 RMzgmqXlUCxCv+mIs94yRWApNjjpdBrSgwLMlQu64o0ZNQg6Rl5p/2tqHKMwtRay8G8v
 KPiTlyxqahEwlmESUoGyBqEtVOBD5uBHomdZWbnKDrtmMFOlSepxq++PYXL3KOCfuD+M
 02Gg==
X-Gm-Message-State: AOJu0Yy9egqTjnTt4XOqD5j0fTHPTx+AvZ8G+96WcnFNCIBhmua7ZFLv
 4QUjnD8UZf6cNJaLlS8jHqkV/xi8NlzLgLb/Jqb4AcyhGe7j+cjZn7bgHZy+8Bd9scGy/t7Dc/t
 1Z0hs9Mn7fkG5xLG2me1N3OSjlx5A9g==
X-Gm-Gg: ASbGncvxOSt0ClR6oHgeU7p40qYnDYsNPjNxuL75lpaYAwMMrjdKa9/Oqy4A1UfTE1B
 fvQareiV6aIVxxkJEt99HaUt7YbRP+sEGObAxyAKGAo2EgJ/WdhS4YMF7RZQZiFWN
X-Google-Smtp-Source: AGHT+IEfgGNNfPvWy7BhWW7FIF/RvJCJzu4nc6Y4UZRHpyvWxZe4nps5Uhd8LjNPcX4g6/I+JR2gA+ZoJ/fQMkLLr04=
X-Received: by 2002:a05:6358:6915:b0:1ba:4c2a:7675 with SMTP id
 e5c5f4694b2df-1ca663c31dcmr515135855d.0.1732204621733; Thu, 21 Nov 2024
 07:57:01 -0800 (PST)
MIME-Version: 1.0
From: John Olenski <john.olenski@gmail.com>
Date: Thu, 21 Nov 2024 10:56:49 -0500
Message-ID: <CA+7aR6GBh7_SQ=pZYYaVjM0yS+=08fU_DwAhbLmZ9=LXH6gKtA@mail.gmail.com>
Subject: Request for U-Boot Support for Allwinner A133 Device
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 21 Nov 2024 17:57:36 +0100
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

Subject: Request for U-Boot Support for Allwinner A133 Device

Dear U-Boot Maintainers,

I am working on recovering a soft-bricked Android 10 tablet with the
Allwinner A133 SoC. The bootloader is unlocked, and I have backups of key
partitions (super.img, boot.img, vbmeta.img, recovery.img). However, I am
unable to locate a suitable U-Boot configuration or prebuilt binary for
this board.

I have attempted to build U-Boot using the official repository but
encountered difficulties in finding the correct defconfig and board support
for this device. If there are any existing U-Boot configurations, binaries,
or guidance for the Allwinner A133 (or similar boards like the A100), I
would greatly appreciate your help.

Thank you for your time and assistance.

Best regards,
Johnohhh1
