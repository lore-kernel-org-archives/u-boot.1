Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515AAD6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06BFF896B3;
	Fri, 15 Nov 2024 05:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sIoiUTpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5994B89693; Fri, 15 Nov 2024 05:27:41 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459E889326
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-460c1ba306bso9208801cf.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644858; x=1732249658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pU77EBCj0m3Yc4eAD52lhQ0tTlnrkuBABsWxiVlg8VM=;
 b=sIoiUTprE2Lzv1ZRSfpHkEbaNa+ZoDg5c2v2hmjEb3YXFoHLy19KNVtDmpkK1Lesql
 peIubhXyg49KjLGzhSF009VAC46pGSj3+cEOCSKkJkBjE2xnoE6clX4IkmuEAmpLgs/D
 od+emaVnCazne45y/Cglpqr8D5OGF90JuPGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644858; x=1732249658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pU77EBCj0m3Yc4eAD52lhQ0tTlnrkuBABsWxiVlg8VM=;
 b=UaSP79x0QQ6IwpffUBzvNYB8deyOgCRonXmhq++AI88XrbPXJlCFRsZypLtKySZl/8
 BejHloFG9vlrqTMtFGkNHmv7qYJMpwqG405LMMfbaQKqIuOuaxBx555buAhNcd0njWaZ
 V7oaAwZ8Yn9BF1TFwd58WM+IMI12xwaiFqU8bQNnxRmfv0xkdY5Tu4NzMFwOtEmKA9ds
 whgP7nk2yYtDcx21FPxd/HRoe75SV4Y4trDjNtTmnfh0YqSsmqOOPFBSylOIYyaCXNx6
 gzOwgGduq882+gS/wzDDkrJ3TdLwnREwaH2T9bgpNYn71lTbfBcAkQlRYVP+UBXxrOxU
 sHjw==
X-Gm-Message-State: AOJu0Ywc/CzP4uMHwd8BD1twhcP62ANsE+QKnWaMh+etIV7rqBi2YZhs
 QfjiWKvA6YDBu0eFtIWGfzlYHmWDa1uxmSBA+xKTnrxzbmltsdlTXyC+cRWPToM=
X-Google-Smtp-Source: AGHT+IFL+czO5yhJCqqBRJuOpNNGts/5gr0P5+WgfK92OyHkZuuXU3LxC45KNPBvoIq22TWWf9E4QA==
X-Received: by 2002:a05:622a:5787:b0:463:5c65:156a with SMTP id
 d75a77b69052e-46363e021e4mr16285091cf.14.1731644858116; 
 Thu, 14 Nov 2024 20:27:38 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241107112801.543992-1-jerome.forissier@linaro.org>
References: <20241107112801.543992-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] lwip: fix code style issues
Message-Id: <173164485534.1205089.12128593944444806059.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:35 -0600
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

On Thu, 07 Nov 2024 12:27:57 +0100, Jerome Forissier wrote:

> Fix various code style issues in the lwIP code.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


