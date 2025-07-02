Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AFFC77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E423780E9A;
	Wed,  2 Jul 2025 15:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pqsqyark";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A7A81FEE; Wed,  2 Jul 2025 15:45:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411A5800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453634d8609so49051125e9.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751463950; x=1752068750; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RghEcE1LitXXxRFPaq5AaVqHIC7kWqvv4+JqXpzgC0=;
 b=Pqsqyark5V2HIRtBQbbxrDStdiPC/lvq2uUkV6Zp3/fu4RX2up5fSL+859sCm26139
 nNJ8u7WF/OkW6wG6U+eIh1v4guXPcTyFCGOBtJDHtRQZKZibyyB+IgQhVJe/syssVNrx
 bRcHKnKb3cJ6QQ6vy2S8vTJ5+n2JDtOzMWV3Yx3eude08cecaobXZNsDZqTBln82pHX7
 xh5BvaYFGk6Ta0TAjRcAaqqQ2djV1zW8o0PlvL1RcZYYM5Y+7tON9EU6bmhl5GtpPPUs
 Q6C+nViFIs02HIgBLbfA2YCuqn3gAJW9PV5o8Qzv0OrRqwzYbF7vRL/Q+njXlC0BJOAm
 4+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463950; x=1752068750;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+RghEcE1LitXXxRFPaq5AaVqHIC7kWqvv4+JqXpzgC0=;
 b=rSgxmD4V6yyR+ymjVqzE79jyJPbh6CTLZpkklpMxn1WssBq+w8ex074vPfqMDrnjNo
 DCbIDfJ1uMR0ANF5jW71sodxyoNf3AVESo3CpPw2rUIcfcJ+HtaB/PmJe5KZdQxupzIl
 8yk6eTNixSaXiDnUiz2fsAmikgxkwd63jKBOP667VnkqbjItNJtisx18mRlpyDLtA77g
 0yJwrcMoWufd7852nzafNvrvX6xV/Nfd/okUC2gXWCHZ8A5K9ztfILUb0WpJRrUmJ2ox
 8IH5tEvBkyfFVqvVRGOF2blKerKT2gKWWGcif5zfIv6Cx4AKEzWrqRkwre57v2TPI+wg
 RsJA==
X-Gm-Message-State: AOJu0YwrnDH2Z0aYS7kMKtTjAblLwHWb6VdnkYtrgx4GWqRuNvhBeUlh
 16QdS8XatlYxwIv6yn/wbDt3h8kUDxFSSspheeSkqYNsE3NIw2GBXQP7edLZnWv0+vo=
X-Gm-Gg: ASbGncsfVZFdl6tGkf1S7fp+WgjCEO2B4icIN37d2mio6EEd6q/Et727h44m9ZjtWMl
 bjo4MeREMrMHM+UnCOCU1CBEOr/SvpijxQKlvYWNwLQJFdAGhSywKsbghbFL3xvnyRNokmcNUUR
 dnpbJ76JUQbgN0SMyIvSHHkN5rBIDsoFaPoheVOR04TtmusWp2zaIQj/Hxp/fdMkTmHcNJsAu6z
 x7WzWhS7fIEne23ZnVQWUwug9B6nP4vX57A9Ug4rERcBitPkcEG9yalEypu621hK+2glWPFc4fz
 wXumasJtC8HrvIhASNPZaEpGkF5Z4sUl1usgoljNPGt+IJjSCYwHgmOzPtWeyTETMl56TkUpwjV
 97iRdAytgheLnRZeJ3exYpHp1+F85qApXdCKLu3bwPidhtOzN0A==
X-Google-Smtp-Source: AGHT+IHOJXMEoi1umfR9SVNUp0mT7pY3IqjUCqpMrKbn3GqHvtfuNe4L6HaEyGzEZQmbXntESnHsEA==
X-Received: by 2002:a05:600c:638e:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-454a36dc78fmr36606375e9.6.1751463949580; 
 Wed, 02 Jul 2025 06:45:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30?
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a406489sm203042905e9.27.2025.07.02.06.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 06:45:48 -0700 (PDT)
Message-ID: <047489d8-c453-4eb2-8a10-ef736da556b9@linaro.org>
Date: Wed, 2 Jul 2025 14:45:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Julius Lehmann <lehmanju@devpi.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch reports for drivers/scsi/scsi.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Smatch reports the following for drivers/scsi/scsi.c

drivers/scsi/scsi.c:165 scsi_setup_erase_ext() warn: right shifting more 
than type allows 16 vs 24
drivers/scsi/scsi.c:166 scsi_setup_erase_ext() warn: right shifting more 
than type allows 16 vs 16

I just wanted some ideas on the best way to resolve this. There are 
differing patterns even within this file about how the number of blocks 
parameter should be handled in calls to static functions. In all cases 
the value starts as a lbaint_t which can be a long or a 64 bit type.

1) in scsi_read there are calls to scsi_setup_read_ext whose third 
parameter is an unsigned short. The lbaint_t variable is assigned to an 
unsigned short (smallblks), which will simply truncate the value, before 
smallblks is passed as the 3rd parameter to scsi_setup_read_ext.
In scsi_setup_read_ext the third parameter (blocks) is split into 2 
bytes. A third byte is set to 0 and I am guessing that if appropriate 
this could have taken a higher order byte if that had made sense.

2) scsi_write is similar to scsi_read

3) scsi_erase calls scsi_setup_erase_ext with lbaint_t as the third 
parameter. scsi_setup_erase_ext takes unsigned short so there is an 
implicit truncation here. Here is where Smatch complains as this 
unsigned short is shifted 16 or 24 bits to the right, both of which 
exceed the size of this type.

So possible fixes are to make all three functions consistent and take an 
lbaint_t as the third parameter. Or to make scsi_setup_erase_ext like 
the other two and just hard code those bytes with excessive shifts to be 
0. Can probably remove the use of the smallblks variable at the same time.

Suggestions?

Andrew
