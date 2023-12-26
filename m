Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BE8C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 21:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05BD87823;
	Tue, 26 Dec 2023 22:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZAWY2aF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC3286F87; Tue, 26 Dec 2023 22:48:58 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BAD8753C
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 22:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbd99c08cd6so3053540276.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703627335; x=1704232135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11F8CWOLyiZhLys2PsXvJlKnvFAh5OrO4bJzdY1SJLY=;
 b=ZAWY2aF/84+OAfYGq06EFWIpZwNe4SOKnA9o1Vax/tcOCmM8RSErikg59iAhyXvQEi
 CI58udf7ArOUvjpAQS3oSgTXeNNNO61OkftXvh08M0SIaKgnoZk+VGw/0IrWJ5moioAu
 fOsSLVU/VAOG0RaCUwKE6XvSQyV2KXts6wpww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703627335; x=1704232135;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11F8CWOLyiZhLys2PsXvJlKnvFAh5OrO4bJzdY1SJLY=;
 b=jFBBDTH+ngoR2AfbW+iylX0pS5uMxwWct0MfW/e3ije3TnG6w/F7nQiw++QpFBoF/+
 BaAvbe90kE8RnhqE6v2WDcCRQ2TZcY5lGV0vjymclA4VVa33HIRIibXVBnffKevB9zrP
 Gw4coSuxJKGwRz04Ajv+X8k7U6NKZnmv9ZmDs7n0wm2cYmrn8M5Rt2P2JQTTiCJsintH
 S+kpoBIcPEs5qgZL7UHV5queL9YWCXjxrIErT/cu3inbDzjMcdfO20GoioJMtWr1wbU6
 NH2WLMjAmZs5RHr745IyU3F004RVGSLCpmBQZOgZgGXXglmc/xbqFACRH4zXLj9D/19i
 7nSA==
X-Gm-Message-State: AOJu0YxmsvzKXjL+qBuC16r0Vc9NEO1qAVmWG8A+d3yP/UegNU2Lr9Nl
 xXx9riPxYgknz/40pUOCeoup4zGLqsM9LNAc0B2dRVQapns=
X-Google-Smtp-Source: AGHT+IEWPSithn9jxDy1AwIY3vI/vLs+CSqjWGO6mc/DIoe0M4HXxtilGWIMX8gT6sCnZdeNRMxawQ==
X-Received: by 2002:a25:dc50:0:b0:dbc:dced:c022 with SMTP id
 y77-20020a25dc50000000b00dbcdcedc022mr3087050ybe.75.1703627335002; 
 Tue, 26 Dec 2023 13:48:55 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 p139-20020a25d891000000b00d9cbf2aabc6sm4788164ybg.14.2023.12.26.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 13:48:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, xypron.glpk@gmx.de
In-Reply-To: <20231224181255.4954-1-kettenis@openbsd.org>
References: <20231224181255.4954-1-kettenis@openbsd.org>
Subject: Re: [PATCH] arm: apple: Disable SMBIOS again
Message-Id: <170362733427.442931.13548598969665433419.b4-ty@konsulko.com>
Date: Tue, 26 Dec 2023 16:48:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sun, 24 Dec 2023 19:12:55 +0100, Mark Kettenis wrote:

> Apple machines do not have memory below 4G.  Since U-Boot does
> not support the SMBIOS 3 header structures this means we can't
> support SMBIOS on these machines.  Unfortunately the refactoring
> of the SMBIOS code this cycle accidentally enabled it again.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


