Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462D5D3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C408883A79;
	Sat,  6 Dec 2025 15:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gtrnePN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AC183979; Sat,  6 Dec 2025 15:11:15 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2207983A83
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7533dbd87so2753298a34.2
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030257; x=1765635057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h90DkOKSEstZZqGZgCK5/+A8/KRqi7SjJTsGieJlfNA=;
 b=gtrnePN5cBGi0ZYaKwzJvfl2C+4Oumk2+Jzy5qR7DNWBKC1wWoxCW8Ec6wvAMFy5Og
 XmQnlAunrUhOiXuFijbOilDKhMFe87SEpxB6+QFNaVVesEVD/NH07C1JM0ZDiOgVN/19
 oEC+Djx+aAW6xnN+HLL43xJ9LIehwukZrrdvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030257; x=1765635057;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h90DkOKSEstZZqGZgCK5/+A8/KRqi7SjJTsGieJlfNA=;
 b=Al/n/y1gjRQZJD/PCLDYyx7KsXbzbsZJBBtAZgfDMPKbkFX2SJqYRTn721zgol5uqQ
 hucYvgeL9RwU8v7EH7L9e4cf9HBB16kXHItr8hcUyPUC+wG45V0CGtQs/cV8BqSqLrbh
 Q0YeC35e8IRlR/k8eErpHhqmE5tDzI0KxXDphSyoFN5rXZKjPhGI6Wocs9NBoN4V14kC
 w3XgcVjQn+3/0QoEtwxBD17vOssiQnrfZJ0zBol91+BzgbP8oCYtgjF24cfTISpT8oGy
 6E424j8M+lKNavQRKhE2hF7Fl4WfuDj8KBgNwmquzsMaPieFhh19vFCk48uXpvxjcHfu
 qNAA==
X-Gm-Message-State: AOJu0YyQgI0jEdtGkGIapvRHl28PTy9hcg+jFTMoAkBsSadGg5C8/ER2
 Lvc7M2EbX0TRCCO1QomUb8s2EdVfTWee5hHkOO80VjgjMZCrssAhsRs9fdSweWI3F3lRt1VYMt3
 msdrvfS4=
X-Gm-Gg: ASbGncs4yNBjDl27MhRcz4DDC4t/d/KDTIq/UrlaIygWAxWlPqsRHhZWMzhS5Q1eb2i
 pvekZTu/syOeNEKazp5sZ3Qlp7T8h76SZHqv3sMH/F9WYjueQOgyR40SZejptdzy3ixA1En6+jg
 Jvu9UvCDhYzhXnkx56i/lBorIDdADooVpWOqPELqKQRrmIOFuol4TGEgOthwE/F+EmzmEVgJKj5
 jiuqGhn/8tQs8z42Yc1FK5+yskOwbSqS+Z0jB1Zm+TQIdVmbT/1UaGkNOUQB3kXHoCBXItWsjC+
 dWpv8MsSJjqFvq/1JPwYduylUzgVunCUkjBwQ1OFVCJ10aBNyPfSYwX3tD6mFC7TG8xjgqvUtEj
 L1okqmaAkZdRfMoMiUageWDLRc7/xJwaUnVPn/uwB9JLs+qGledxLT0X7EayyQ0dYao18Sf9byf
 tQhC8863wstr+YU6lKBHatr/IjdurtYIAMIZISUVkwuzV0KRKnITfAwjd14jo=
X-Google-Smtp-Source: AGHT+IF74iCV2yZiedVX2ocOINmIzfRxI4KZDwvd/StIrdZynxN5Dkm0qS3+6cEUt+Lzlc/qvYd8Bw==
X-Received: by 2002:a05:6830:2e13:b0:7c7:6626:b595 with SMTP id
 46e09a7af769-7c97076f85emr1480057a34.3.1765030256890; 
 Sat, 06 Dec 2025 06:10:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marian Cingel <cingel.marian@gmail.com>
In-Reply-To: <1762644205-58930-1-git-send-email-cingel.marian@gmail.com>
References: <1762644205-58930-1-git-send-email-cingel.marian@gmail.com>
Subject: Re: [PATCH] board: ti: CAT24C256WI-GT3 require min. 5ms delay
 (tWR) between write/read
Message-Id: <176503025615.2523567.7867811684948095999.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 08 Nov 2025 23:23:25 +0000, Marian Cingel wrote:

>  Otherwise the custom-cape eeprom (at adress 57) reports NACK which results into
>  "i2c_write: error waiting for data ACK (status=0x116)"
>  and terminates further scanning.
> 
> 

Applied to u-boot/next, thanks!

[1/1] board: ti: CAT24C256WI-GT3 require min. 5ms delay (tWR) between write/read
      commit: 1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc
-- 
Tom


