Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04854C3DA64
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 00:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF75688B68;
	Fri,  2 Aug 2024 02:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jyrStY/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AF988B81; Fri,  2 Aug 2024 02:24:14 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E260A88B6C
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 02:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7091558067eso3179538a34.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 17:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722558250; x=1723163050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbpMUTWtSgAuZMD6o4cbO7K26RhrkZ5QtyMQKRNqwBw=;
 b=jyrStY/ZBExR2Okp7F5JPWfNA6mVu0DqkYdxEc4GbhMxx1JxlSsWtHdWl5cn3wzcxr
 jO4SeK1BHiFIgQtb1xiBMtZFZV8hq8+ovT0BXmc3DCHWnNjI9I66AiWPXBgEb39IUfYe
 1gB7ONqZwjvYy25wTe4FUIKvcn5UsqtFN4tfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722558250; x=1723163050;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbpMUTWtSgAuZMD6o4cbO7K26RhrkZ5QtyMQKRNqwBw=;
 b=TRbi8vXOdZyA+Dko6IzyHAijKuyixG8xDcq+O75tKexG1qMKihCKbD75znFSqi0vmY
 vpRPdOMjSZjVB2HG6mE1YOB8AAHAqm2qFEs3+02Q00VzeJPDIo25Il4zInB0g6yodcmy
 P1puasM2j24L1NX4/1x2x1Pg56Pgbu0RUfKBYDefc6gGv8RphXfukZMdymb/b9jRu1Rz
 /k1x8zEXRuwSr+iS2VEsRc6sVVXXwsB2iHh0zIgZBvODPYlpD08SkVncQFCRtnetY71k
 Ok68pVBUk7E5vUZpYePkVsgFXUzHZXfP9RA0c9kUaTmpgvXcno7lPDyT0VPvwFPtbaDM
 OT8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFlR9zgrSjsZa8OyHVpz9pe9cPK6i+PrLdLz5pG/gk4iBYWIZCC6xmN3gGLL0ePWAh8l1xoyz4yyolrwtHqhHJ22H2CA==
X-Gm-Message-State: AOJu0YxCRiOL1+YkkFoLNJc4bw+g61WxBul149mZwhbNDkiEHRpl/G/v
 Cs2l7dfvu5hrXGke5aZwQjOvngHSb/Sn9svTeygEQxxF/sNFG2BoC9aNGPYTroE=
X-Google-Smtp-Source: AGHT+IHNQIcJdOg4kg4Mq73p+T4NG+8DTLSWbd7A+Mgw8LBJEzym2BramJQGm2akTRJH6WhBf2gPlQ==
X-Received: by 2002:a05:6830:d12:b0:709:64ab:70e2 with SMTP id
 46e09a7af769-709b320fbc9mr2608348a34.9.1722558250633; 
 Thu, 01 Aug 2024 17:24:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dcaesm232611a34.7.2024.08.01.17.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 17:24:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
References: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
Subject: Re: [PATCH] clk: Fix error message in clk_get_bulk
Message-Id: <172255824972.13067.3239600211810908074.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 18:24:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 09 Mar 2024 13:27:09 +0100, Jan Kiszka wrote:

> Fix a logical inversion of the printed text.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


