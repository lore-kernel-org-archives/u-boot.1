Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE32FE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248B686EC3;
	Sat,  7 Oct 2023 22:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oOpozq5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA01786DE6; Sat,  7 Oct 2023 22:37:57 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B218986DE3
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso3631226a12.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711068; x=1697315868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K0mDI843zTwb/3+ygt9xNXieNsQT+kYSKf4OhdkkiKY=;
 b=oOpozq5AuM5rVjemGctMd64kvmzkttbhoEHJy1efUwXa/+7EUtoyL30yKJOfWpCSfo
 UIm4QSOLsliHMe7OqXSQCpIZ8kQYIFlE+Pl8RIyhpFpIuVVOP43BrW8FyVelBGPMyq3V
 4VIEZFCWsHaJmyeHRBmXiKA79V48b00jt8daE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711068; x=1697315868;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0mDI843zTwb/3+ygt9xNXieNsQT+kYSKf4OhdkkiKY=;
 b=tHMmjb4u7+xyfgd7wRN648QqcVkg482rI5nAL9IH64sIg+CeXBR67CO0HdmrXERnzD
 70bA1PvEWFl4MNnepKZImNScoYxQ0GqonRrfMo+FbBnYtb5kZO/Ao486XbtUqGsjkZzH
 G+4B/OwGdvvuGRHubAeuzesEZr/n/NtwEbRbvbLz1dsBZxj5DWRDOnYdvIzxvKk0Fz5R
 LDFV7jY1abi6NYfU5cyqVV+s1Nd0Y9ZrLU/fP44OLktdt5dBZaqGzHSr2eK2Q9zscIDB
 waaEUzrPATi7DILhRWfe9DxwNrfnET0rPsYvasDpmZXEk3yw6QcRRlbChqlfBMCnlvGv
 x0lQ==
X-Gm-Message-State: AOJu0Yw+PS7dS+2C3Khy/Z3nx96a5tM4cm4eZF6RdkfOiFZsTKGWo5zt
 Pnb7FXFLI28Kpd8UvZRIbmlsN/KcmvwRTQKVrt611QvoRbcNs0Vly9g=
X-Google-Smtp-Source: AGHT+IGUTh50KAsO47v9BEZ4ng4mrWCchOf5LgkPfFvv4oOcd+9+5cyU+VPdU36ntPEHfcWSUyvcwyCdB7Bx5NlsKBI=
X-Received: by 2002:a05:6402:350b:b0:529:d147:e9f3 with SMTP id
 b11-20020a056402350b00b00529d147e9f3mr6878620edd.5.1696711067933; Sat, 07 Oct
 2023 13:37:47 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:47 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ17Hy9cXNFGKKrvzJnmtQ7NKhjeh7Sw-6_RWdH6gpZKVw@mail.gmail.com>
References: <CAPnjgZ17Hy9cXNFGKKrvzJnmtQ7NKhjeh7Sw-6_RWdH6gpZKVw@mail.gmail.com>
 <20230923194424.1739224-19-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:47 -0700
X-Google-Sender-Auth: vwOxznXQ0FP0kWO1kHYNqA_Mzjw
Message-ID: <CAPnjgZ3AXyNDdtWo_3cRBAwPeABJVJDAB9u-9cN9rF7UvwXANw@mail.gmail.com>
Subject: Re: [PATCH v3 18/27] moveconfig: Reduce the amount of output
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Output a single line in the case where the defconfig only has one line
of output. Show the name without the _defconfig suffix, since that is the
same for all boards.

Use a list for the log so it is easier to process at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
