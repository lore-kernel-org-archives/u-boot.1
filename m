Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC044C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 14:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE68F82AE1;
	Sat, 31 May 2025 16:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QvWfRhLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10AFD82AF6; Sat, 31 May 2025 16:22:40 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BA382103
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 16:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so3132703a34.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748701356; x=1749306156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kngBgX7HRoKAbgKwoPfxJfNZ/HoqrK8OnBmsOe0arzY=;
 b=QvWfRhLAvMLiG2bDMKuV/QTYYDhK0cmfX90NPUPRsXIUMEZREXjp8jn2NcdTZSn1TR
 Y1PFzefmvfzJOu5drzq2dsD79i8vWQG4OojFM2l/6+JHJp8DB2xt/76AbJQ8LFkJJfPc
 UEFKzHZkRg5LwD79olvPbnSF5GWKBAtEj+vLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748701356; x=1749306156;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kngBgX7HRoKAbgKwoPfxJfNZ/HoqrK8OnBmsOe0arzY=;
 b=CPTan6oy9EQ7xz3jrlqY4/jAjQTl0UHWjrI65VZFN0OCH6Axvlr9raqn6ouHCZx4KN
 iPrAxDstdJ5HF+fVAvM+dL1PIzRYxV/QiwbK1x3L7jNFxeXA6Euc62h5Ei6Ty9eNMzWH
 rJbVH9anKEx+jTu/hAcdG3hd9g/ruCYbt/8njQbxv53oJdlaUoNd8cm0hHRwfZHer85K
 ITDcaV0gCM0aCg4idxcwPDCs/oOT7AxgZkv/woQrzVoNW2HQ0k4fhnmsYgTjpjHl/hzR
 g2zZwpF/5+SanntS7PUNzzlVqJnoe5SXemHzwBQLjLe9JOdyVnQrtgPrGiBPR0JoXWVl
 BdHA==
X-Gm-Message-State: AOJu0YzfhMFUyZOtrS9imlfy6WcCIIrBdo5TsHPK0fPZhXlvGc1Z0t+d
 GDihUn5aAzDqjZDc08uFYLAqRkdHWiMKWneeiCUsQlpeObjoTvRVtpfHIPWTP2y5QhejrDCbG2+
 BheNAuUw=
X-Gm-Gg: ASbGnctRRHQEGyxAvsZmERIX74l1DQjQdR0HGRpgnRQJEwesuCpqLjRAmAHzH7EqBpb
 8kQPwaDeP8iHXI+QCVmk5ochNSoHO0ouLEU+9eGNa6oeorXsiflxuWNvqJJZXRxvhqSoNexrFKR
 dHux6yaid3rOIgB3QB8ebw3RlQv89zYWU+fQnt5xsn2d2XkJ+TrfWnwm84Eq7cRHhebCeV1I8ZI
 Aq7weCnaDNNZYVu4ASyYcvEEjlnaBSjYDkBzLcAgeDSU4Vzrkd9ElQCEHPr7WDL2Ru6SJQ5JBtV
 LMHyG03n6zyhAgheQNUEGOeDn27ae3w9XZY9dijt47Zcw3ErzAaLEqqn28/7q5TqT7uNrtPuQ4d
 hUqKPQPvX8fw=
X-Google-Smtp-Source: AGHT+IFq1wYld+EbxaUjhI8BDD0h6jtn4cX+ngGQhqAj74CWg5NrPVMaVvsJZgCNRMYgUg0Bx+RWwQ==
X-Received: by 2002:a05:6830:6f4c:b0:72a:449e:2b6e with SMTP id
 46e09a7af769-7367097b305mr4603436a34.5.1748701356427; 
 Sat, 31 May 2025 07:22:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af855ce7sm938083a34.21.2025.05.31.07.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 07:22:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Benjamin ROBIN <dev@benjarobin.fr>
Cc: jerome.forissier@linaro.org, joe.hershberger@ni.com
In-Reply-To: <20250517200930.78975-1-dev@benjarobin.fr>
References: <20250517200930.78975-1-dev@benjarobin.fr>
Subject: Re: [PATCH] env: Fix network support when CONFIG_NET_LWIP is set
Message-Id: <174870135536.979488.12934490672518107141.b4-ty@konsulko.com>
Date: Sat, 31 May 2025 08:22:35 -0600
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

On Sat, 17 May 2025 22:09:30 +0200, Benjamin ROBIN wrote:

> When lwIP (CONFIG_NET_LWIP) is used instead of legacy stack (CONFIG_NET),
> environment flags support associated with network was not built: restore
> support of "i" and "m" environment flags.
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: Fix network support when CONFIG_NET_LWIP is set
      commit: 6aa9c0f453cf920762e0b90d56d80f7cb36d5e6d
-- 
Tom


