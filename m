Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0E8E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144A08973A;
	Fri,  6 Dec 2024 19:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BdH3Sj2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9603C89735; Fri,  6 Dec 2024 19:58:53 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74E589613
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b15467f383so201633385a.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511529; x=1734116329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1F9A/bWCJeT5QBt+VswCHOc8hthCn91TBSf7ODI6WM=;
 b=BdH3Sj2sIGTQl+nvoFTottYxXI/bpAdnRrj/Ocze++0BSjXXLrpml356MFfi+G7Vrx
 3EqvEV8O6FyfXnz0XnDFS4VStyvhn1UzHmJPx2w6jGPQa+yU1zOsp1ukch8J9nvhAbOl
 JE8fFsXyFjwju3IXDnzflUc6nIHGtbtswwqVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511529; x=1734116329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1F9A/bWCJeT5QBt+VswCHOc8hthCn91TBSf7ODI6WM=;
 b=V2v4U/klBfdxkOPTIYrDdMqf/LcmV1P/VIjFHRuJdyooocxAfLnzj5p0fiYw3BBfL0
 F0occ6TPLCLIARhxUQw4YOCo+DFU+owkcHbdTs5PmE95t5wUSqNMW2XYF5Kz9O508yjE
 Cm2C5mz810yT5Z8FZvz/9thCVB0knXvtkTzDl4E3QGTRmXTPHVj8+5jPrfVEpu97XjPv
 qO/eJZsxeUlPSkSxTXMtZ3d0/yN+EUiVUW04eF0tS03YizufQm8tEH5t/baLjDD/DbIz
 l+TjqAaRxAFTEa8UkXfg1IbY9L6Esp0GJiyyhCo+LChaPnEe5GM2phqPoHQd7UmcWbEY
 YnoA==
X-Gm-Message-State: AOJu0YyqvEUDunFlyGu5pzWkhVRWoSXtnYDVoqVg61b61OYjyfU/VQaA
 b9ODe9s3YgFY2shSUOlRZmx2jfXIMd6HH46aZuPHmuJwTFppehhfl13W4Aa8w5UZZrj12r8R1xq
 JPxs=
X-Gm-Gg: ASbGncvDn/ub/QQ2zV/bE6PS+8zuQrQ25QOKVMccHB9XM0WY4PyHPy7PQYhgpeAue8P
 95EEGSHJzlltqZL0hb2McUAgl5pzuHRdoCIRt/2vgb4AN0Xi+T6RjLFCpbssrgzzOBAT/krtHx4
 /4QTJXrHzcj8q/Qc7wV2jPJF1uhOnNSlwlSgHgZq7PcXLBOCkz654pnJSV7EZ1ujrdl/PAhuTat
 C6olUKuF0jYZ3GqJFDILM4HrpaH8rbVPgZowU4LUf3aHfd7
X-Google-Smtp-Source: AGHT+IFtEnKl8VKhTQra1gTUKJJE819leTVgHfM3t0lVG9ABIQzpMdreLFFCk1vMXVFjJ4zqo5cahA==
X-Received: by 2002:a05:620a:4104:b0:7b6:72ef:972e with SMTP id
 af79cd13be357-7b6bcb6572dmr554851485a.58.1733511529596; 
 Fri, 06 Dec 2024 10:58:49 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 u-boot@dh-electronics.com
In-Reply-To: <20241108185302.139487-1-marex@denx.de>
References: <20241108185302.139487-1-marex@denx.de>
Subject: Re: [PATCH] eeprom: at24: add ST M24256E Additional Write lockable
 page support
Message-Id: <173351152854.2516797.10121059744016022885.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:48 -0600
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

On Fri, 08 Nov 2024 19:52:26 +0100, Marek Vasut wrote:

> The ST M24256E behaves as a regular M24C256, except for the E variant
> which uses up another I2C address for Additional Write lockable page.
> This page is 64 Bytes long and can contain additional data. Add entry
> for it, so users can describe that page in DT. Note that users still
> have to describe the main M24C256 area separately as that is on separate
> I2C address from this page.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


