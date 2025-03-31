Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7EFC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785E8819D2;
	Mon, 31 Mar 2025 15:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MT9O3nkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2752381DE3; Mon, 31 Mar 2025 15:46:19 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F36B81DE3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72bb97260ceso974106a34.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428775; x=1744033575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuQmmh/PHp/sOT8ayj2s/BotypZXEq3wS0P5TpaNB+o=;
 b=MT9O3nkBvGlKwdpJswB5oxqXNPD4YS4KRpxkVdXs8tXxrRogODBe4Y6u4bW+5klA5z
 RZDQePbu6XE+9jIznuHsBPR5za05Q39AvtDg7VqI+hQ0be5PwsKkK00HGgPo181KXv98
 UWjeSbnodC1Vf2qdTzpts96cZ3y1/+4dozwRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428775; x=1744033575;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuQmmh/PHp/sOT8ayj2s/BotypZXEq3wS0P5TpaNB+o=;
 b=v1GTPtS4DSvQkLljC6X9BX+njvCCl04DaVdWjH+LDWksEnplHlrrlvbQCrtKfUlt+C
 twkjmHgF+FLjDEwLrmEXS120o64P/4qFAU8oNHJBJpxPgddjBjU3r6hht4cZC1P07SEx
 5gKlnNmdkyLXGmpJlQWXoMPOnfk66KTzi3Un7/617BiVcnrppFB6NGHMauEKBWzZgb/e
 1RnsZ1iCvBPO6Oral/VM9RHUd88cGgDRHGC2MmG45Cv8WnREFXLhbDf/akadDAWmXG6f
 yijSOhC0VAholOntg4+TfuUFFd+O7VOSwvJ64Og6oTnr3OaxZbWIUjfYp0zIp1s8dt9n
 Sy0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVovXqlDV2XwSQSmL3yGkB5hbkFLOqpjU5L3f8UQeXA3eDVW61fdFt1B7exUZQP3Qbal1JAQ+4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2GkQbJnuW2lDETY4gCMWyi5oxNffF0BJke0H1eQ5sbr8+r8+h
 Ng9VMaW8xNF+8UIlmciFGiqDXMwrMIGxa97XmJWWKdnVc6qUS2TMGG5bh6QIpyg=
X-Gm-Gg: ASbGncvm0YfwLSSqLpu0qkeC3gINgxIqtRHE0LF/B4NIpG//zEc3AJ0BkcsPBSd6bo6
 mIejtzNKiZRMDF5LhESSKSWzlybYyx3RfZ6+TjZdpAGzAtGMpa0qMR8jo0jqvOtP7I03DLy9UzZ
 0Vikc7Yo6DZ42QV0Lp2dOG5YI0Xcbm7mZW4FaARUSKE2i30plgaTLfc5C5fzffUmwC/0HcGKVmo
 BMvmdNn/uV2VO6myNGlljPEJLmpnzTPEozqAm6OEl07F8ltC+1e1LZSQ00ZiDVXZAtEVFEJH0rW
 2FnvNC0SVpYHGGsgtJSDU2k3HCBnliYrf/jaeosBmiIGAM8QDzmPYutPUCDOLmNPlpxzXOQtqjJ
 Euo8U
X-Google-Smtp-Source: AGHT+IEkegaGB+LpdSV0SiY1YrKFySbMNi+PMFipuOfqXVLSYZpAbTND8/LGS0X4kH1ho5eygcbtZw==
X-Received: by 2002:a05:6830:3103:b0:727:3111:1416 with SMTP id
 46e09a7af769-72c63831c10mr4737672a34.24.1743428774755; 
 Mon, 31 Mar 2025 06:46:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Richard Weinberger <richard@nod.at>, 
 u-boot@lists.denx.de
In-Reply-To: <20250306174659.904457-1-heinrich.schuchardt@canonical.com>
References: <20250306174659.904457-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: use truncate in mk_fs()
Message-Id: <174342877363.1318045.16987135164643067995.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:13 -0600
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

On Thu, 06 Mar 2025 18:46:59 +0100, Heinrich Schuchardt wrote:

> While the dd command actually writes to the block device the truncate
> command only updates the metadata (at least on ext4). This is faster and
> reduces wear on the block device.
> 
> 

Applied to u-boot/next, thanks!

[1/1] test: use truncate in mk_fs()
      commit: f94a05d1c4191c587f3abd259dceb4bb99b1b639
-- 
Tom


