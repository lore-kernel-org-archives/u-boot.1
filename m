Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ACE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7048D806DD;
	Tue, 31 Dec 2024 05:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I0UgGXmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238E280657; Tue, 31 Dec 2024 05:05:37 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C9880657
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6eb531e13so485825885a.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735617934; x=1736222734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3mG1B7zBYYNDx/wRp/QrjiogQZRavd0pxnRzBBKFjE=;
 b=I0UgGXmXXd3Q0QvGputxGV066GsO72/ef8DSYN9IaERUOzZhf+3D3t9PgFUNN2yke/
 NSAZJpRU9ews/mSuFSPlVfsRzh8ZFNOi7dUkG9UfpXUDMsK8wvJ51uXTaqhCNHFIJTR7
 QbSJae4YxrnNgOGNt7cQW4EZ/10kPi6DqIJ2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735617934; x=1736222734;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3mG1B7zBYYNDx/wRp/QrjiogQZRavd0pxnRzBBKFjE=;
 b=P+98Uk3VdZEjne+qvk2tseVFZPwqvX0GQsD7WwMNJTUIQO5N/InaDzAkAj+aoJmak+
 LC6QUJq8tyarpRnfRfT8Y00UY27dmIcD8jUQ57lkkzB++j7dQ1bVqVg7vKJTcJtldjoL
 uhLiPw90a/wIACLLCwoRcAackN8iip9+ZA8MUFy6Qp4qRX7CqH0xBKtCL5q8mA8BT24H
 WPRxuT5v5mkUQS/6HWhjmmrxDWsrE7CW5rSMTMMpsMBLyk0ccPCpMBhadfCTcDFu3aNm
 fhe2jMEMfoUzU25Mzk7DNn87v1nWN3moCAQoK3PtSd5pl3iNVfrcEe4opjN8Rc8ELUTl
 XDEw==
X-Gm-Message-State: AOJu0YzPDtQMNV4MhOkkbXtcQZ89mQI2TmNn2EfU80Rnv4vTP5GVxPJy
 FcDqOUj4bE8I4NPak8q4SaCVPQwPWYWXWDzGNZf5ZexYAO5oswCOtDVtLZa5YXI=
X-Gm-Gg: ASbGncuEaSp80x61Dns2t+CZ6TpjLNHuU7lpraSL1L+mjZedTI2alyrKXo7vywlpVv7
 dDEfshjgl6NhWbv8Q+Q1VCGCQpRmnGDFCWXiD283hMdeJowC/rq1nm3gOFQYkqFPU7BbqQe2lFR
 9PdLh++k5bLbn33ni+CHjMb4Q+RTRRiXK3MGxpZDnLL45f2anNYGxdyOduM3UVPgt0QetMr7iDh
 Lgl5wU+rq3zn0vdIgdw+p9sMpvOElR5tnTC7RMpvHaQrC16PDi2lfFp
X-Google-Smtp-Source: AGHT+IEV0NQL4iFwKTqdLaj/gj+hCuu6BFva9geQ08FjEvFXXaix8DHM1peukpSUSQ88HPBb5GzLTw==
X-Received: by 2002:a05:620a:2492:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7b9ba6efae9mr5592270085a.2.1735617933973; 
 Mon, 30 Dec 2024 20:05:33 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480886sm976081485a.83.2024.12.30.20.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:05:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241212-gpr-checks-v1-0-8c084c5fc0b6@posteo.net>
References: <20241212-gpr-checks-v1-0-8c084c5fc0b6@posteo.net>
Subject: Re: [PATCH 0/2] powerpc: Fix and enforce distinction between
 immediates and registers
Message-Id: <173561793240.257558.13198158435335055491.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:05:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 12 Dec 2024 18:05:45 +0100, J. Neuschäfer wrote:

> This patchset changes the definition r0 etc. to %r0, so that the
> assembler can check that registers are only used where expected, and
> fixes the fallout.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


