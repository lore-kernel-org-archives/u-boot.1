Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE691CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441AB8486D;
	Wed,  3 Jun 2026 17:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D64C/v4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68BAD8486B; Wed,  3 Jun 2026 17:57:46 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E60A8005D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6db226e1fso1392818a34.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780502263; x=1781107063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/cxabpGR6zjvCeH9O1652xYngwFq0Qttf5nW7DfpIY=;
 b=D64C/v4ljMtT3o3twozd0I6MnUyYvpN4pIM8u9BqP71N3mZl4z8PTGZ4ESopjV4KG6
 A6cE6MeTnGS0xqs2aoDSIQvTOZDipVHIZ7aPXdVpeBINE2NC9BZRNqg0LbJ9dwWrD1N5
 fteRq3A5OrMTO6IZPJ0NMYFxA9ob3h8B/5hII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502263; x=1781107063;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F/cxabpGR6zjvCeH9O1652xYngwFq0Qttf5nW7DfpIY=;
 b=p17q1MfZX0ns26t1KxDsrHfoOdeLS32i4na4KOKhPAIzuiN1Va4wZ6g+2X0N1mtcfV
 0474UGE+n5R26cKV/yD134bS9pzcTNqPUVbPyDvs6iMPVICcFIOsv4Ja9nNJaBdfgQj2
 ereP57yC2XfvN2mODCLeDUAHp2CjvoUdsScATKRZEbnGJCnJgr28JzLPJqKXjZYni0VQ
 /+SWxbPlVSKJuoFGLt7nfvr7/LQqHSUo0hwg3CFiQwLp09lAeICx8vSjiH0Ic8v9Sos0
 38jFYAGCUs9AMVfmyqlglB3fn5o7N8TiO0RWXAEz8c8kzk5MxY+IYmPpJ/aM0dQs8Eu5
 PXJA==
X-Gm-Message-State: AOJu0YxRwO/CXKDiaNY2VjaBwLOyrglSPqJ+ncxG4tE6S6IQEUrMmC4i
 /k+l6lIx+KAOh2jVygNQHRpZxuPAWTytwXKn5tGUW708u6qU4cIBUvjutx/oCtFwb1e0/5BqOJL
 OfPVSN2E=
X-Gm-Gg: Acq92OGXOLo/OeOKG6hLrkG7M1n5mcuUx7wcZx1cdu4v4X9VWl9r8qLjI/Y6xhFXP0b
 8JccgiG/zaxC9IUcQcv+HX+s6SGIk1ZKmHhLKPo+d86W4a3hSs/4IVwsGcPytcMpWK7EJno4cun
 gY2q4DSs2dMxpUKuRB5Qjfx/Iac6omMovGcv02KusVlrzUu7XMgWRYE+oovbourp0xoXrc59klf
 2taGoC2L6PQEh+izt1zG0xSlgyyfINjRV5Uq/cwZD4dLY0uCZzTpj123w0vQRGoiW+yGvO7M1Ya
 z/7vTdUj5KLpWOUmzcy/EauR5pI+dW0cQ8e5VngZfijhM3BYMVoI8wrNR3kZGcrIrWb4PtYYAhk
 Eiyuehmuf4+1FJbyUXOICGhxUlD/XLmv/ccijMY/O3CzZPOTQsgXKtx+66+RiPbtCd2TxSi81cJ
 oE0H3469IPWy35klNrm+NzEg/KTPExQTYqEymWDV8lcUar/D+uhojBm4rxRNwY3BMHsAakfCVlD
 I4xEKy/fY3DT3U/US9wu0GZnWznx6U2KVVmxRieWABYdGzMrJ9P/nnH7sI6
X-Received: by 2002:a05:6830:6016:b0:7e6:50c0:87a6 with SMTP id
 46e09a7af769-7e6e95023a7mr2586407a34.8.1780502263006; 
 Wed, 03 Jun 2026 08:57:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm1970441a34.17.2026.06.03.08.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:57:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tony Dinh <mibodhi@gmail.com>
In-Reply-To: <20260602231715.113057-1-marek.vasut+usb@mailbox.org>
References: <20260602231715.113057-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <178050225892.2193579.5901129425576108723.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 09:57:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 3 Jun 2026 01:17:02 +0200, Marek Vasut wrote:

> The following changes since commit 30b77f6aa146c96b831cb4ece038130b655b6a41:
> 
>   CI: Sage: Drop rpi_arm64 lwIP variants (2026-05-29 11:03:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


