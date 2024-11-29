Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ED0D729FB
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 19:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866B789082;
	Fri, 29 Nov 2024 20:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/xep3bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB3D89263; Fri, 29 Nov 2024 20:27:38 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F5C89021
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 20:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d87f00f786so13026616d6.1
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732908455; x=1733513255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3431Av329Nu9UIWMgl4IrQDffgFPgFvnIUZcKcAOoS0=;
 b=s/xep3bbLWo6irU25AvcynmGgFY0pUVf0z4VDoPvq9iI1WmALgzXuYIaWLUdJi5SHs
 VavHwKPDscmRaYPCm99r3NJEQmBOvE+/vuZwV9dqMWkArxju9kBWQfOqdPYnAfHmH16e
 r2MnVvcL0Z5Uu+YG7hEun85SsOGFaWM4op/JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732908455; x=1733513255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3431Av329Nu9UIWMgl4IrQDffgFPgFvnIUZcKcAOoS0=;
 b=NfKn6CVsu0BOkw0nFMik4gSQE84sJIERHWV60v++vL/rIFkHiEDumraGODwEm+jqRj
 ovanbF0b2b2GcQHI+NXIRSSJ3NrRPpDqAo2FEJGqc/v+4XpAAFaob+k+RZ9rZTd7CVfw
 F3hjVIRg0DsVXBo9Ff7pBHJQ06Y8tztFTGOndbsYqwEu/dGffew3xasGtY2MybnrYAjX
 XxuNkNTRLzegQqeGn63SxQuNITc4pFE60yqWCDOoJM+xCgt8h5rC7mxBU9ldxakUOqil
 soH22FEH8UhQdgqSeZxJUduTjGBf0MR50UKEgkE6Di56QvXsuJsjVDnJckYg5qnYe4Qv
 BzfQ==
X-Gm-Message-State: AOJu0YxTiKxvNo5UJHy6looiaFi1/zWz63FdUBC5tc0UkWuiV2oDGas7
 I9VKC5qVEeG0TP64DR6FX+3UmpHXrC31mlCat0V3OX2Poqtl5sYyQQ1iUOH/dgo=
X-Gm-Gg: ASbGncs+mjzlICBU9ZJ+OVvWyGDngvGwG6qrYsM5WzbrSb/h7uwft/Lkt5l7wgfJSqb
 FQ+7+kukZciRdHzBqz/oAGokrKzTUIzmpBf4XCnvwN7N38Az/olbBjwF9DL0TU1XJITO21GjSGj
 +wqwjh7SNFoZ7/J9uZ9QYYIZfn3D3KWS9iResVqx47NCNOaOTcSbBY9wA5CUXdlEqZHrhT1Wa0h
 g1eVzDNXdcGdoRl86HZHZL/WdF8hkOGB/4+lMTs3ZK0aE0M
X-Google-Smtp-Source: AGHT+IHG7CY8W7HY7faLbXtU8EcAEAA+sLYL9DTYta9eQzrDE3lPBJiY/HU4dP6XfsnWgJ29NEWP0A==
X-Received: by 2002:a05:6214:21cb:b0:6d8:8b9d:1500 with SMTP id
 6a1803df08f44-6d88b9d16ccmr34091696d6.36.1732908455500; 
 Fri, 29 Nov 2024 11:27:35 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87eec1c61sm13619866d6.94.2024.11.29.11.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 11:27:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
In-Reply-To: <20241115164514.2186763-1-jerome.forissier@linaro.org>
References: <20241115164514.2186763-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v2] test/cmd/wget.c: move net_test_wget() to the cmd
 test suite
Message-Id: <173290845433.2163297.17932587805650620104.b4-ty@konsulko.com>
Date: Fri, 29 Nov 2024 13:27:34 -0600
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

On Fri, 15 Nov 2024 17:45:14 +0100, Jerome Forissier wrote:

> Since net_test_wget() is testing a command and is in test/cmd it should
> be in the 'cmd' test suite, not 'lib'.
> 
> Saving and restoring the values of the environment variables that the
> test manipulates is necessary to avoid a regression when running the
> whole ut test suite. A minimal reproducer is:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


