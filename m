Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A60DC83F16
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 07:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578F2864E1;
	Tue, 29 Aug 2023 09:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1dVyKF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437E9864C3; Tue, 29 Aug 2023 08:24:18 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B42D80275
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 08:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=huangya90@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2311047a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693290253; x=1693895053;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GxADX4aCp3nyajlU6kRJRLZXvAra2zQlzoTyESlAr+k=;
 b=Y1dVyKF1wN2evc3+jvlNKuoMlhPkmsg5g+yPBDLBXh5H403h/YoxM2G5VQfoi9ldmU
 /GOm2H6NApRc9bSz6EDucvGRS9fl+vGhBmmdq6HBe4TbBeJoHTysSJivpIGq2yF8jkCd
 FU0Y8nL2uOIjuLd3o66FaCE1JwlrpNAafr72u3Da1KalEPJ4Kj0VpN4Ydxu3g+TiHqXc
 2r+U2y2ZM4oba4GyM2QzJaoL9rX1QtCskQ+mATUk+1Wb2OuQFG+y56Ehkv73FfY5Ia8+
 ZUYEWy54lyv1vhxy8zneOu0BBT5YM8fpd6c5kPrp11n8K/gBPF9nrtRd9jRFuxlA1TTc
 Fpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693290253; x=1693895053;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GxADX4aCp3nyajlU6kRJRLZXvAra2zQlzoTyESlAr+k=;
 b=XfuH1j01384KWJ8GM6Q83wzlxUAUAhIm3Ud1WdiUsbYvd666ERYuNLckLmkCDOH2c/
 PPS7kkEsCpQNOVM9zcD80kFlyhEJ4OfWpqFs4Hcm8D69kQE300GGDrKP+7rIAySJJrbP
 hY7w0IV4f7lcr5j7+Ozyq5YpPOzF4wnZ/PI1RumK5NxfrdNlpHjkZYwvI4pglefZtCUW
 RR0OfdE7iUaAFyyU16JTCTUFW5rPLlNuz1t/Ua3IK7L3GgDTu3dx60zEdbDhQ6vJAdiE
 99Fo4YYrzusuGddO2uMYFGLm23YKyc+yNmsuwLhI5pPL72nYNERRnmb0MNu9GqsQ81UR
 xlXA==
X-Gm-Message-State: AOJu0YzQDazfqwnGOhdUTLvKr75uwcHEYL9PBlp9roSXnbSM11Jn5H9V
 jtKVEgqAIBm1lbb/7NdQFMOz1V71LqTyZylgpvMzh1vt8SC1hw==
X-Google-Smtp-Source: AGHT+IH8dpouD7eh7fLjiiB/ho6M07sTSWubtAdSpTuYGRWTy7MTGT8QQ7km/wtTVEz1EHOtiWRGMwWTNe9s0f1wIMg=
X-Received: by 2002:a17:90a:ce0a:b0:26b:3751:652a with SMTP id
 f10-20020a17090ace0a00b0026b3751652amr26711265pju.38.1693290253376; Mon, 28
 Aug 2023 23:24:13 -0700 (PDT)
MIME-Version: 1.0
From: Tony He <huangya90@gmail.com>
Date: Tue, 29 Aug 2023 14:24:02 +0800
Message-ID: <CAAUX2SV60DBX0LriEcDpxXE-gRV0uxhcsrLpMYM2cFLpjaRM5w@mail.gmail.com>
Subject: Does u-boot support env for spi nand flash?
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Aug 2023 09:32:06 +0200
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

Hi,

According to env/Kconfig file, seems like below env interfaces are
supported. In my understanding,
ENV_IS_IN_NAND is used by parallel nand flash while
ENV_IS_IN_SPI_FLASH is used by spi nor
flash. There is no direct support/interface for spi nand flash.
However, we can use ENV_IS_IN_UBI
for spi nand flash, which means we can put env into one volume of UBI.
Is this correct? If yes, any
reason why no direct support/interface for spi nand flash? Thanks=EF=BC=81

   def_bool y if !ENV_IS_IN_EEPROM && !ENV_IS_IN_EXT4 && \
                     !ENV_IS_IN_FAT && !ENV_IS_IN_FLASH && \
                     !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
                     !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
                     !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
                     !ENV_IS_IN_UBI

Tony
