Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA029CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 17:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059D783C13;
	Thu,  6 Nov 2025 17:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y1IR0qBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E5F83C0C; Thu,  6 Nov 2025 17:59:53 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E545483C11
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so688540a34.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448390; x=1763053190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7qDYV3BztUg1I3OpOdk7F1ffJCXuER7Kd1CJneu0pRA=;
 b=Y1IR0qBILq3dGt3l6v8pLH13wQ+i4ZhirsEpHKTXz+QURnghloBY8n7nnHHwEB0rZH
 Wx6IqizoQ8EyqPU4P7KQbd+n8EeVq3LqOUg7JI2Buc6VziQ1v9CNmFIi0S3P99ewHHur
 McvQqhldomoJ2fSUPvwNXe/UtCsNuY1jBi/L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448390; x=1763053190;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7qDYV3BztUg1I3OpOdk7F1ffJCXuER7Kd1CJneu0pRA=;
 b=PmcvKD33YTMlWA1Fp9GBs77R2GfMDppS5hW3wzCtF1rjSuhfNm+1ELD/lYjHye6Ijj
 ejYUWlGs688X2fP2MABGSFh2ihVN+ofojN7amnZCu8Q8n9DOuPrjxtAh8ZozWOBavKTX
 WWlzYGqAm5cbWZqovOY+CPC5raQRe6uH7MEMJH1/v84g8KGp3fuSwThH/EgDQUlyhmmf
 +BI8gY34hyjhlvOMgUP9eAQ9uv1YEmM5l3ZQF2dIMosOJ9UQcZ3FPtsAIbFEtv5mgCcp
 yINKgrBF6U4e4VgJ5ym7C1B7l5fFPpyvpnMYB1rxcTzt5eRoYNcfZi1Gizi0S7BL8iuE
 qakQ==
X-Gm-Message-State: AOJu0YzoIfULUt6e0uCWYkICEBDpeL4EmnnlOMQanPqc2QDhaIBvEt0t
 ql5mHKdtUjFRSQnVKdabnCTAXorzoU4K4+7MKIAX4Y2ySbzr04eacdpPlUlrQR9XJHbPzWMSj6P
 xwzqMCiKCyQ==
X-Gm-Gg: ASbGncviHyTE7Yv9zOLgEwIY76CwwgJN7qZ8P78jn2iLkXfRJG59GGsWKz1nFFJXNim
 a6GsgvkfqjY9sakLW0n8UC/oL8atlRGgWiWyS7agOAhEIZ5tWGXqrqsbel2od9ObfHlVCndSosn
 xE9++x9OB3ycOGrCrXwv7UAeiY3JXWuSs+/vrRfVjPsMdbaWvxUwg6+qjpC/Nft63OWjRnkdxHf
 RkQA8/uVhzWoqPDfsCPBfZ2fhIDXy+It+zgqiwvkm9i9UGowqg8FGKBqxuBOsUmWDgTXIR6SWRV
 CDF6kl3dDEcsy5cH/8KUY0bktuiR5CTP16VzTuWprQph1rvaysdHL0D/bGTpzefCfe0Sb7o/xOV
 bNYdCw0ThAwfSiCOMYdKBNDpun0iykU8jqRm0tCrjucbLhHbIJWCzka8L7sxeFQiyjAatnHEsX7
 eT+OF2etKPDc/h1dGupGyhs2e5YzUfKsMXO2ICbg==
X-Google-Smtp-Source: AGHT+IHqZMo/pLYIRluW0EdluYOAEeCO0uBa4522NJJZcQXlPMCDIMYdROHivzto0wUiSnMFRrmOnQ==
X-Received: by 2002:a05:6830:2685:b0:7c5:34f5:1d33 with SMTP id
 46e09a7af769-7c6efe20707mr228281a34.8.1762448389672; 
 Thu, 06 Nov 2025 08:59:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 "Hans Gfirtner (Nokia)" <hans.gfirtner@nokia.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f7068c43-db26-434a-b039-9a70e210e395@siemens.com>
References: <f7068c43-db26-434a-b039-9a70e210e395@siemens.com>
Subject: Re: [PATCH] tools: key2dtsi: Write out modulus and r-squared with
 the correct length
Message-Id: <176244838889.3056677.199439804412593821.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:48 -0600
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

On Fri, 31 Oct 2025 10:35:16 +0100, Jan Kiszka wrote:

> Align the implementation to rsa_add_verify_data() by writing the modulus
> and r-squared properties with the same length as the key itself. This
> fixes signature verification issues when one of the parameters has
> leading zeros.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tools: key2dtsi: Write out modulus and r-squared with the correct length
      commit: 77905c333e4fa1093154984cc65575b5cb7cc97d
-- 
Tom


