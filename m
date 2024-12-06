Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6BBE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694FD8974A;
	Fri,  6 Dec 2024 19:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pjWU6wQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1918973F; Fri,  6 Dec 2024 19:58:55 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 817D18962F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d89a727a19so31760436d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511532; x=1734116332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oizTQsIxRdDmRd7aKjX6ASLYuLAdZtnUcQMorRJKegc=;
 b=pjWU6wQBkxvtXrG+RR9gi73xQRjvZwQBk77RQw903udlt+MvWJGXkv7RZ37r3jt17q
 IMfj1GcS+6QGqMVKrIGxExbfpK5OuGs+U5sLluqjSddLmzDJOzDGK8Dqiqqr+im3mZ/o
 OD1w+GLDyaZOdYWaJB4ylDEZK1r9S3gaInJqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511532; x=1734116332;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oizTQsIxRdDmRd7aKjX6ASLYuLAdZtnUcQMorRJKegc=;
 b=oC6kcS+xN/8HKEILxxFjjOPOWo/qNoO85axkWc9QR9GeKoSqBPcRqJBnZzQ65ERozU
 tFcciEyzGKMG6VgRwmavfkvg4EifqFxN4NdF59ctHuKxOcEYCRcwMaIqWRs7RgeNs4ma
 Oirl/mEuPQqrURCgVSZaKml0s49wRmqePKm93iRYMvLvZByJgUGOCDEf5Hg2BpA/Pqae
 W25sMMPgwIo7JkmQ4WOr2IRxsIYjh8+umI6nrrnqnt1TwX7EDEQ54UIbQgunKLD/Ease
 becbfqY7kgC9yxabD098lgC3oCIZb4Dcz1/1ldyPLjU+kgVLq2EEphjshl2dKozdn/1i
 e2kg==
X-Gm-Message-State: AOJu0YwTRpVajKYC/8NA+vEOOQEf03qrQUm+lIw2cK40H3gEQ/ItEE4x
 X9+iBFedoQ3cDCS8X2OYeUos1oWzgSPpccGrU8HgzxTc0rzFOJheFxuZ2kK4cBbIyXMsQiyrYFX
 QWpg=
X-Gm-Gg: ASbGncsROmx52Uf0j85IBcYnqtffZ7KNY410hx7LdxYY0pQXuuaQz1jXsgWPWXaQjCh
 9xGsveoPk7W0gtoQvwqFUWkl5+VMK0MuEqVcJ3DDnpCOD6XhwgiWheMLtAKS/iw+qAxluMwV2/Y
 eRMUiMaG5/Y862P/o1ljJuUq6XYJmSP4zB74nMgPX1LXTZyIZyMhs+gM/UYz0DWWlMvtD+cFg7I
 27UAriIRgu7k1VGmUVmO9EkyKo5LW4HmQDmGOiX0u0qBiW3
X-Google-Smtp-Source: AGHT+IEMQweAnvo/VNsc5/2KRZM24mgEuqCFMNazWKnmlf5KEcsM6EaONsjTtiQC1DAFLyKOAj8cnw==
X-Received: by 2002:ad4:5c41:0:b0:6d4:287d:b8d9 with SMTP id
 6a1803df08f44-6d8e645f21fmr83507026d6.2.1733511532482; 
 Fri, 06 Dec 2024 10:58:52 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241113045936.1844271-1-caleb.connolly@linaro.org>
References: <20241113045936.1844271-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] button: gpio: handle broken controller
Message-Id: <173351153170.2516797.4242843487892194505.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:51 -0600
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

On Wed, 13 Nov 2024 05:59:24 +0100, Caleb Connolly wrote:

> Avoid crashing U-Boot when the GPIO controller for a button is disabled
> or failed to probe. We also need to check the priv data for each button
> since even if a button fails to probe it will still be polled by the
> core code.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


