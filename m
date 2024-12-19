Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22264E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C3D80378;
	Thu, 19 Dec 2024 18:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KAu/LFQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE3D8021D; Thu, 19 Dec 2024 18:51:15 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39EF58021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b702c3c021so71572585a.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734630672; x=1735235472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IywGKSTj9+nCZixtRNy72ED0kE8mkaKBPO/TWXSi/pQ=;
 b=KAu/LFQ93qb5n9ALdPMdIBJgmNzK1z3HBYucpTqViFYyNwF6iUcm556BmM6y8sdmAm
 gaPVvFXPnkoBn3j532NhZiO6r3Y8L1UOncbuCL4LzJZTJ78VJZa4zNLMUdp1O5KwMz0Z
 qB9lUhxEaw4Msu+GYLhEyNOZSBwuKFqh5N32o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630672; x=1735235472;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IywGKSTj9+nCZixtRNy72ED0kE8mkaKBPO/TWXSi/pQ=;
 b=dwXbeNOKV49uWtVwkQFMCLPVepJhW/t4jTz8FWtP1ayCtq0tt9wUAb75G0wqGdDpK+
 PR3lYRZWAmU8GL8DPyabb5nKkiMAmfP1cb6P6iAqSnG8K2QpFYxkDq4Kj20g41yuT4uV
 pBj4X02+f91+zl42pNT6FXzO3AAdRrHOyMrSEwtXDwcUABEEs+i3WusAhS+n4lwS/YOg
 kLOIeSd+xU6rgCRb5qcKnn7ZLqiwVjsJkqqmYH6bd6yOWutF+SB9nAk63mZSA5ubcdlb
 eU0vnzVe868r9LdHFgnFKxTS8Ajr/B8SMDnDm7z9s74/UxJl2xfk7gnHcEISSfEtzTfZ
 NGlw==
X-Gm-Message-State: AOJu0YwCmlvg70bbnQQqu4O7rYTiXLUP1L7rEyx0/BM/XsCEPw2inYCF
 K4x4KepjBbngSNdvlG2IUDcFfu+YlY/MHLJ5tTMboA2MbgpMhoBMRrg4ZXYA78M=
X-Gm-Gg: ASbGncsfrn0mO+koT0H23/IZU5Yht80MEbA/VYMotIToQzcKvNM/5L98jbZzAm4WSi7
 k8zWDcFgq2+IsKd1mJaEptjd5JUGtGwuTtvPJrvKYlsQsYQc3gtk218dmX59aGUksX5c2KnutoR
 azivVErhvRwSlmsk7/TWkFwrpjDyMZjRcbsC0SbY0ad1JUJRwb8RxMqehCnoEsLlIxxbI3b6LM9
 V5EQCOFmOZ1k5rqU2KhAf5iyiHWaIMTVTySKhFBA9OpoIrM8BkLILM=
X-Google-Smtp-Source: AGHT+IFumghSfLrJlbkBQ0G6MuUGxomeZXBSZNByu5dEt5bFdj8D+Hr+ogJ6rJGFu+4QzdH4TBd9Qw==
X-Received: by 2002:a05:620a:1b83:b0:7b6:d643:599c with SMTP id
 af79cd13be357-7b9b96482c7mr75843185a.43.1734630672188; 
 Thu, 19 Dec 2024 09:51:12 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478e33sm67004685a.76.2024.12.19.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:51:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
In-Reply-To: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
References: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH 0/2] Allow to append a list of directories in
 u_boot_pylib/tools.py
Message-Id: <173463067127.3644953.9561466575197891243.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 11:51:11 -0600
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

On Mon, 25 Nov 2024 19:16:52 +0100, Paul HENRYS wrote:

> The idea here is not to have to pass twice the FDT directory, i.e. once with the
> 'fit,fdt-list-dir' property in the device tree passed to binman and in the input
> arguments of binman with '-I' option.
> The method append_input_dirs() can be used to append a list of directories to
> the existing list of input directories. The method avoids duplicates and the
> method ReadNode() of the class Entry_fit calls tools.append_input_dirs() to add
> the FDT directory to the list of input directories.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


