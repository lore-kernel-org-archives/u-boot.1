Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03506D6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF37D89697;
	Fri, 15 Nov 2024 05:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BcxjKltL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68898896C6; Fri, 15 Nov 2024 05:27:53 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3D6896C1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460b2e4c50fso8650011cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644870; x=1732249670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTxleWXmm3yVcj/3q9K34rZogqox25bIq+SqVosRsW8=;
 b=BcxjKltLJTnr5WkBu8KOyUoVjV7CVN9uxOTcIJ72Mcq+FJMMt2o+AGPdqlkv0cWZJd
 rMNxSjgR0MO9lhZHt997O26wDTXJb0mgSl+qTlAOqCh33y4fIWjq1C+SAsChiXjZeXTp
 iec5st0+QZUUBlKL8LCjW4QqG3j64qhBU/wcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644870; x=1732249670;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTxleWXmm3yVcj/3q9K34rZogqox25bIq+SqVosRsW8=;
 b=FZGHhC51GnZ8epTnPpDGw7H9FZYKDYi/3FQtm591IHktspuq2UZmYOb79aZ0MiwmDs
 Zg7I2rC7BSu7xfSfscfarFzI+R3R4bSyFSayVNew/6MfXUJTqYlN5nAzcmobLfCjhOEu
 yI+uHC4wubgqxUYgvG+dGi0XY79VIiiDSfAqDxhamVc7IzkiNgn8+R1JmITxsNRtazqR
 +5ut69jHX8kA5y5ZKf0OdVNRUF+XD40D/4qI5XUS2KhKMwzPFrACmAJYqK7CIR9FjfEU
 DeFoAxn1Cl54XNYoQVff2Oo9Fcfq3GX9XsqltA0KGYtSwbn1zhyXEDDFZNwD89FEg5RO
 VPCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNc2U3X2e6mUZrnP405Qs9A9yQWmO/9ejCHS+9kKy/+RU0Fr1+qNfe55rJkVavOJWnrtUEiOM=@lists.denx.de
X-Gm-Message-State: AOJu0YyKQsyQFLOUM4PSeAiihevyVUSPXytergVPkQiM8aZZSDtTsx2g
 eqykXz1tcOnjvCKk6S5oel2lfwTh2QGJZ0GNvyhMepTnnI2swnWf7yzou3bleVhPrD3p+nuK+iN
 Gj8U=
X-Google-Smtp-Source: AGHT+IHVXZXBC2a9/eooIMl19pA8/wfnm9tgyjdqmd3scxIrENntw6WIzailpc3bhMQEZZ5EPsYVSQ==
X-Received: by 2002:a05:622a:178c:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-46363ea7cc4mr17462341cf.44.1731644870066; 
 Thu, 14 Nov 2024 20:27:50 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20241102104112.110838-1-heinrich.schuchardt@canonical.com>
References: <20241102104112.110838-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] xyz-modem: Add missing fallthrough annotation
Message-Id: <173164486831.1205089.14145397587817886056.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:48 -0600
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

On Sat, 02 Nov 2024 11:41:12 +0100, Heinrich Schuchardt wrote:

> Falltroughs in switch statements should be explicit.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


