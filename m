Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66788D6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA79896C2;
	Fri, 15 Nov 2024 05:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ApSSfm3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B3B9896C2; Fri, 15 Nov 2024 05:28:11 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43DFA8969A
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5144e15aa69so567904e0c.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644888; x=1732249688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cY37h0jzzalyF4Fm0nFPY3FH+Gql78DBrg3ULfzZdcs=;
 b=ApSSfm3zQeMLXaOVd5JK38lwn27VuRAbd/7uUoKpUnU2rQdtqIHlfUgazaioxpLa7+
 a1SjNPaUcrM0oYkMIgfYMkv/ywhaY8uFGLhxk8PNerDcAjONA3Htg6+6qbJSF2sbzzZa
 JnfD4PiYy/8SLRSp+yGWUqDvJvXgi52j9/K/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644888; x=1732249688;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cY37h0jzzalyF4Fm0nFPY3FH+Gql78DBrg3ULfzZdcs=;
 b=a+nsgWh0vu/Ayf1ckwRhAyQgoaP2il5p70JBb/ovVJUpZoAA3eVgC7S3eYCycepxNP
 SQqCBjvEpOskDBM4H29m/K2bgYdCIJYNh1bsVyV3qBgtjH1jITWVqkxUcWxwykSmolxf
 ZBchV2DfmHmdG29wQ/IMqRLKwzo/oZquw/1i7evjU9P+xmgcazc+1qV7fbpb7kMl95Gp
 a6j0yRMe+1sdjodqPyCpJq1351XSXQEQl/YvFssNXrcFXWEEbiUy2upqixHftgUyRuV2
 Y83VEQc4CWq59WuEuono80HoeSy2aWRyODn3FrEuEKj1O4EtjsST4vnK4HcCNAb61LDA
 WPGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpctwTdNZ7vqoyYxxG5lufyIMpQ+Z8ze3NOfP6mmZ+V133DtCGkwHfgLWFJkwwKqiK8iyixA8=@lists.denx.de
X-Gm-Message-State: AOJu0YxK1hbKHeJpwuzCrI5p3XHFi/P2G7kr3yngQ7eII3SCs/FsVkdl
 sqX1Z+0e2HbfQ3E956LDOna7BiVDiRaKfm/ae0N4nLcvXuTuFIC6L+9SFeWyttA=
X-Google-Smtp-Source: AGHT+IG1quoxv7FPZt3+8rt8w1uanKnBnj+qGFQJLtLdBXXEkPa/LGktP6Eqn6OnTT78QPvNpIpRWQ==
X-Received: by 2002:a05:6122:1e0d:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-514781ac2e6mr1865215e0c.10.1731644888213; 
 Thu, 14 Nov 2024 20:28:08 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:28:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
In-Reply-To: <20241107103922.46907-1-heinrich.schuchardt@canonical.com>
References: <20241107103922.46907-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: fix regular expression in
 test_spi_negative()
Message-Id: <173164488626.1205089.14471132366703559891.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:28:06 -0600
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

On Thu, 07 Nov 2024 11:39:22 +0100, Heinrich Schuchardt wrote:

> Escape sequence \s is only allowable in raw strings.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


