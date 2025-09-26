Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD217CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6672B83796;
	Fri, 26 Sep 2025 17:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lOf1iRkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E257B837B6; Fri, 26 Sep 2025 17:57:00 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5B48373B
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-425715aeccdso11953505ab.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758902217; x=1759507017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ITWQITaXwiHHrZU7HnPdli6psshRHtApRlO1XEYUzGo=;
 b=lOf1iRkLQzTuQwcL4EGShmwzVN8m3iUJg6P3bxWnosEN7RlBnvbEEpMH/X64aypuDs
 OF2rRMOpLxNXHE8QHXpTLJtUjfpnRjHXMTqNURdizC3NsTVTvNOKI+SeOdmzvcu7QNkN
 tzWqU2WaU3EyyJSNz1wJlFCYszp9gDcPOF9JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902217; x=1759507017;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITWQITaXwiHHrZU7HnPdli6psshRHtApRlO1XEYUzGo=;
 b=tAC9eamuk/8sSX0qH4+P5PrqsnHkZ7/J1t11HzSr1OtBP/5qrgNm7uIZj9CWUxwkw6
 WT1yJWsr72hUYxNkh11buoonkQuGwCMY7WIVlCu1m32onkXIc9knhyF8CcK92GZ+UM8C
 o2b2TgY17HJ7eFlHJF+OueMNt2qt+VFhgHu2ZAlbcOZ6S0LQ8xidaTKYGexc8gx+fvqN
 dwUS/pwj6WsDdb83H8iv6aaAxHsHrexSl21Xi6xt+6qMV0Vtv02MOxsnW0Ade3aDCgjQ
 4JKSOehqlkdfZJ5Eao3rs4r7yzbEuK4f2Zf2DSR83DcJVJDziONoQl83fXPoL/diflOm
 24Ng==
X-Gm-Message-State: AOJu0YzbEUh7C83HUTgCzg/x4e4o/g+idiblJALMRDzRCegjzsE50c6R
 tq8e/atz5OnaRf2NKmFXxqVA0JPk06z00GudpGWxN78Ip5wsQ3p8MUk14TTZ97Py+U0=
X-Gm-Gg: ASbGncvV7GZkWL+cxMWkVbNupW9zNnqr/VMej8pRghVCrGz9vA+x6Uz8Ptvs2wjUd+s
 lySvRv5tmhPYvCtke0NTxQuWyV7xDxptK/EX0rwJGtS6ooeJC4M+6T/lDwPp0gIa4r+nEzNjz6m
 V/CBJ8NDaisIubMQk+cGA8G6sx7fsVrD9TY2UWWVk3eODkG1NOOqMhTgvwJnvOm+RnieAP5tA05
 VaK6HyzZCHT2ivKY7HpVBvwvW6ZMOk93v5LB05GBLf4IkBXut9WxFPoy6R7QDd0EXKuGvD6NLUk
 Gi5/PuFiJpW5N2oLnh/k5ug+yI5+2a7HGJ5Ul4owaSJEFsZW6UhImIB/2oKkZlPDt3Mvq90rePn
 2jSYKHtbE4D6dQ34+lRq7Pko8f7HLWUiqpOZkA89m+PQC7yVG5U16MlQ=
X-Google-Smtp-Source: AGHT+IFdAXMSy2iK3x/3DqA2TymoGCGEjdCd5MfJ4lLIRWB+yfgs6GRHKNJZE0v7BH4/gzGqTKUqeQ==
X-Received: by 2002:a92:cd82:0:b0:427:70e7:ea09 with SMTP id
 e9e14a558f8ab-42770e7eb0dmr40193325ab.14.1758902216998; 
 Fri, 26 Sep 2025 08:56:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a647d9805sm1239609173.2.2025.09.26.08.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:56:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
In-Reply-To: <20250925230847.183416-1-marek.vasut+usb@mailbox.org>
References: <20250925230847.183416-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/next
Message-Id: <175890221601.3683453.4229536291714881343.b4-ty@konsulko.com>
Date: Fri, 26 Sep 2025 09:56:56 -0600
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

On Fri, 26 Sep 2025 01:08:33 +0200, Marek Vasut wrote:

> The following changes since commit 44c4919e9dd6c162b237633ba689441eca9a149c:
> 
>   test: Fix optee unit test (2025-09-24 11:04:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


