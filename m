Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2492FD5B845
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 23:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FCF8907E;
	Tue, 29 Oct 2024 00:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lHxNEagJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D4B8907E; Tue, 29 Oct 2024 00:27:22 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5939588278
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so310754885a.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730158035; x=1730762835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qWMZqGjYjGOFL35QIO2kdOiGXSk7CNsrNqZd5ukTi48=;
 b=lHxNEagJwm1Hqnt97lFbSYtKFmYtZcRqJ69SnFJJFu7TE6sIKjTiColUzwVGXf8V70
 PtUZ+iuI57ZcffctVRlDeTpbwRjtngdoIln4pa2hMb10d0pFso8nU/4sG5G7DHR+/tFo
 adbz5/elmzhqvEXBeLBbAHHRu7X5zSg3vYJoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730158035; x=1730762835;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWMZqGjYjGOFL35QIO2kdOiGXSk7CNsrNqZd5ukTi48=;
 b=jV4zh9GA1n8Swn3tew7QFwVjOLeCEQpDbQw++UDCnBMOnA6W9wSgZmya7IrHHHu2lf
 aZ5k8Ds1ocAw+mmv3j3Gtj1Nxjd+9088vJIU0WVRr8XsJqh6aCgwCi3/Ml6iRApv+Nl0
 cJhNkpMo3sRmsUuH5NEovg/RSvvSx0CJs/YqRmbL8++oaPFxLo+p+hTEuE36ew3cKgke
 issr7hL1pn+hr8U4VJR2pQmgfDsI1fSA5DeiIrFSVXX+UAyWTE34zlwN5Kde+HiCP4/p
 WhIbpYUYebF9xTGk9tog1/XY2w6gUduFOBTv07eSJkYG7GrUI8Q5dtm2O7xdiaBXi2r7
 pMJw==
X-Gm-Message-State: AOJu0YxRv1WBm1HT8fBYjsRvKKtxVEk/HntAhc9nvjOlBkF7XXDUjZGn
 O5HSIQ9SZFRjLXeN39RpJC3rdi1iwRJIRYhabRuT3gy5hs9vPP53HHAZ5kU0G3zr+JXkQzcSGxF
 qYRA=
X-Google-Smtp-Source: AGHT+IFUdwIHxOtI/mG/Qb4hPYIswi6ixtfOpZ2AvdqKkNpDzuIAj3pHBXm1HYB2G+mdKFLsIgzfJw==
X-Received: by 2002:a05:620a:17a2:b0:7ac:d6ea:b4eb with SMTP id
 af79cd13be357-7b193ed79b8mr1617643785a.4.1730158035226; 
 Mon, 28 Oct 2024 16:27:15 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d291ec0sm367545285a.34.2024.10.28.16.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 16:27:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
In-Reply-To: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
References: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH v1] acpi_table: Fix coverity defect in acpi_write_spcr
Message-Id: <173015803439.2338198.5277824884771902648.b4-ty@konsulko.com>
Date: Mon, 28 Oct 2024 17:27:14 -0600
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

On Mon, 28 Oct 2024 09:08:35 +0100, Patrick Rudolph wrote:

> Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
> Cast serial_info.reg_offset to u64 to prevent an integer overflow when
> shifted too many bits to the left. Currently this never happens as the
> shift is supposed to be less than 4.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


