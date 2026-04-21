Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C6BF8FA93
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1266839D5;
	Tue, 21 Apr 2026 17:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hwVBOJa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741C083B99; Tue, 21 Apr 2026 14:40:14 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB81E842CD
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50faeb8317bso11138931cf.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776775211; x=1777380011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNW/E/EXH1ZxGf/I7DWCkZRmhdypoYcS3YXXuXtkpds=;
 b=hwVBOJa0ODb7h621p/dZdtTCZPyUgdShbIgNEQkcRJvJ3u6AgtAt8QxuaIGb5Y1uBD
 1Cg39WBiveO2HLvzroKoHJnjpKplHfRxfTYSPqZQBpSyecg+dCB1HmThgrC+Ma5CVIp4
 J9ZbqrUYVdA5G4IkUI/ImiOBa8i+46RAoxF9X2hbxuT7mXvtqqc2sBjEbe6swgtraa0p
 SYhJCUAvWTro8fFHSeJma7kbcR9iecvgyR1XNmmPhaG3IB6C9v7GRWA+5dGE1QRBEee/
 VmVX0z24sG5GYNyIN2UW2rCsh3/bNjxBj+R+ZT3xWVCs46F5/AGFCv2aoPkBQWu3Meib
 GSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776775211; x=1777380011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNW/E/EXH1ZxGf/I7DWCkZRmhdypoYcS3YXXuXtkpds=;
 b=X8zVER5MPZgPmXBPQQPg5B4bSexROffmaIo2IEXKqhtNlflzfcec0g0epR5ERpM/xV
 so68fyHs2cxzYCzXJJZTD5K+aKmzjjkNe9pR5sEglboRujxhQ2n9JSAwHHwSpdFeF9oq
 p8SdMm7JaocD2qVwvXxU1nSAKYkP8lm+p4r09M0nvtonmQglN0taSFiP7tkjcH87uy7V
 cxqw133Zlrox1w6SQyu9tYHkKwXzXRSlMhQ5Mr2YMwGigmiZ85hBSTmdArR5CO2SaYhn
 IFNN7cRBzb/UX6NMBW+CtEDSSLUcoQmIRWHo7NlIN+qVy1cERBk2/2mxPS5rGucrsT4m
 N3yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/1dp6SuSfIT0bIavUVELVLXJA/xvTFsl+iPmjbNLcoQGhsVesGqEMGoqgmYP3RB9X98Cd8k8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzd8Y3j1Qdu6PlCUDzMIBtSks0ivz6R0Z4/e4FvnVrrjqVNF/r
 QA5yZ7LsDB2cJXk3HDQkV+YwGHzV6BofRFgi3Kl2V7N8Jxs32+RAcxC5
X-Gm-Gg: AeBDiev/uKCkFfSQCDPMycowvSv0v6fbzd0XAsTi+RYiWWms8+PFgvOOtkJ3LPrsOQh
 HoVuO7JxH6eNr/msYmcq0zvY9tlzgEKzmCurHFODBJgvh087bsZKy7hjJMfDyhLrSi755OrlY9i
 F84VJK8t0nT087nV1HuDhRIXf3adpI66aP5GH8Ejka/mC6tViiy/UMb1/hrqfJ6VgvusiqaObsN
 5LjwIizphHHCd+mD+WVybbVQ8iQP2CEtqvUSL4ZgCvZbO7lptlyeAnt4bptfW8BTy+o4iE+WtQN
 oTjr0O9cKGALtAYkPvBBUFKpu1KV2Gtvtimo3FtRm3NHUA03OJ0+VxAe1fdzNIjgtr1eoAK74FQ
 V91CCvrgSSvpRTYuydhW7YKW2Kbj0htFm+9B+XMVoGMeNtyTt6HTa9Mk44cBnHVUGiuVZt3ykYs
 7TLvdTGIuK98LzuImeDLM00pE/VJiED6eSFoDyARnS4Ro7
X-Received: by 2002:a05:622a:4ccc:b0:50f:b17d:7e53 with SMTP id
 d75a77b69052e-50fb17d809fmr45091411cf.47.1776775210746; 
 Tue, 21 Apr 2026 05:40:10 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e40aab60dsm96908511cf.18.2026.04.21.05.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:40:10 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RESEND v4 09/14] mach-sc5xx: Update image load address
Date: Tue, 21 Apr 2026 08:40:08 -0400
Message-Id: <20260421124008.5492-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszThBjowUW_CQJ9=_mGoo09sApZs-61CGiuoSn8Li+sPBmQ@mail.gmail.com>
References: <CAFLszThBjowUW_CQJ9=_mGoo09sApZs-61CGiuoSn8Li+sPBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

Hi Simon,

Yes, this does change the location of the fitImage in the SPI flash.
The U-boot environment before was stored right before the fitImage partition,
with it gone we are moving the start of the fitImage partition so there isn't an empty
hole in the middle of the SPI flash. I can reword the commit message to make it clear that
this is the fitImage, I believe that answers your question?

Thanks,

Caleb
