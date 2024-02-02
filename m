Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3CDC47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95EB87CF6;
	Fri,  2 Feb 2024 14:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NtqUXtld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4739487CF6; Fri,  2 Feb 2024 14:07:22 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFAB87D2E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d932f6ccfaso16510665ad.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879238; x=1707484038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uOqA2o+JoYPimkWZdK+MDHHE0G6ZoGW+csrPHpPpJA=;
 b=NtqUXtldKt/UIHRSCPxgHzbnvO0aiub04+agyGQoHhucHnZEuL8iHkCTpKCpZu6Wli
 OIgx+gCIEyA3jvvB5HjmBCQE7psbUUE8XqcuXNfI+4ewlx+31Tg1npLhUiHZ9KeviUGm
 AHSazwc8K9qbabGoJs5Ln1Yl8DLm7IX8unOeW6y0iRC6e6wr6eUsONNwI0e6aMcfHpiF
 W6ZFsVA03C5+whggRggLLR13y+wrQOUGPFw+SmUEfvveqQVt3sCo77XtRw5EcBKkZrLO
 5oCffBxBmB+8exViVpNSryF+PNTlenE5NJ2yKx2t9S5TQfyq2Ai7kfOE5IP5NrQXFenS
 0LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879238; x=1707484038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uOqA2o+JoYPimkWZdK+MDHHE0G6ZoGW+csrPHpPpJA=;
 b=WojLmnlSYpzKfmVYighiMQ5EOSK5rcGVSVvQD+tiUrQgeYe1TrBFtefRSr0gRezz7F
 QAB83FyVIQt3FPZn2XQNyF2vnaUXDOH4bkDLQnA+h5wadZeNDVvXje7WL+2nfHw8SuET
 JUGDPeQ9M8E+98YtFxD/N7XohXNPvmuYQY+cK4hGf8Nm3c2BxSOkQ+0AzIjKAlYHbv5q
 EieG2jJqim4iAaeBGO7B1EvFnbdXhcO9/dozYW08SvNJuB6ecx9Qsad/NCgzDhHbarxJ
 VnvVkB6HnwllbQFqONKYoJCiaTHfzHygWjJMxcEe07V1REDCcZWVqkMBd5RADCBbuSuC
 53rA==
X-Gm-Message-State: AOJu0Yxb1pe+eTI8Lc6HKqAuCm21pg4gqpYEc8gf48TRIv9MSi0hxi82
 OY8ttMhRLTLg6rn91qjePgXqDixgj2YQYRi+6A6TUUYMUYLctjUc0k1iQ5rBFJ0vAKvT58ieNgk
 jPEk=
X-Google-Smtp-Source: AGHT+IGAUzsjLIgDoP3S6NkALQIVzL953iZHkV8ajjPEldZEnKjg3E3cnAdJ7vAZzoXIeGhw2BcUug==
X-Received: by 2002:a17:902:f7c9:b0:1d9:4ee9:4d8c with SMTP id
 h9-20020a170902f7c900b001d94ee94d8cmr5014589plw.18.1706879237858; 
 Fri, 02 Feb 2024 05:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXFocORMJix+4USu3VDgUDJuoi6JqDH54U/ZJ4FDIIGeLhxJlRYm66CAhCf41+TXsBqTWRYE8EA68F56WN8YVmN3hZX2OTH/L+sc1U2WMIlJQQfkD5Q45P2z0gkqm6UM8vq5xb4nvmWX/O2QrydCq7FhxL/Dy6dK3fBMXrHKAK6F8UTymlOZkCGX0pv8nC3cLr/tbujnwt0rJkrDnPsr34AIVrDyvj6rOqllH1cj04Pbtd3/skJ3ib72FtQoMDf0H6bp/SktdnkC8boXJQsyxsQXKVIA6zkvO4XZS+k8aPp1n8CDk2w7iCQw3yU9snXKZkKrT9KsSQHlv90KQ+vaismLoDiUzkqsXwLWQe6pz4zu8qXxIzR7onBOu61O9SbzBxFxdCJT8VoFJgmb+4L69fF5JcbFvbWgcLVNNgoAtm/T89UUmn/BhlakEZzex7/JYLMUzfcYbrFM81PUYgFo0XRO1KNGQ8d1cf/alfp4DrtBtcTr83MN3k4n5BGOlaCeiR+gA7BB6B1IX1tVuCwvmDl7OhoTkvJ0iZKEmqfiMd7JGIt8a2/rB4HOIhqWymPHF0aCdSqGNOln/nNnoGlG71HaOIfhcJLqGg1Z9LoMjmmFCtTMl0M8CVO2CGJah3Ckuyww7mPOSB3KTUHBolLjS6Ex1RoAwLENsoc+kLahoBzXzhan1jvUJ7vpJUf5QFxEFx9aaAt65f4yzaveMx80bG1auqCINVvrtKyyD6dQ7gRGH/Too7DTly6zIW9+lOMMjNC8UKuLNBi8SqVN0NU0bUTjIe46xvduRWtQtnrHxIkHz0ABdT/4JKCDOsnq9V1a0IMNevCt8GEDMM8yoZzDMpxRrVOM0UNEAffTBiyDl8z0SsvymA6esrvJfI2dcXPpwusSqwvD8hRJbsUCPUuftAX3W7Uevs5sHtP
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:07:17 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 09/11] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
Date: Fri,  2 Feb 2024 18:35:32 +0530
Message-Id: <20240202130534.1051438-10-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add myself as devicetree-rebasing maintainer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- None

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added commit description.

Changes in v3:
- Picked up review tags

Changes in v2:
- Picked up review tags

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da477a4e6add..af05c42e5e42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -960,6 +960,11 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	dts/upstream/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1

