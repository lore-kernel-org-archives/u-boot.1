Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3C6CCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACB9838D5;
	Wed, 29 Oct 2025 00:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WQiFqp9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643F683849; Wed, 29 Oct 2025 00:57:40 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 346E7838C7
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c0e8367d4eso2256915a34.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695856; x=1762300656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZTgOVLqLeQeDcVsnwONuT061jTLZBx7+rsWhc6+XrTE=;
 b=WQiFqp9J7V6grE4p4ke644oV9qzgZcD0TSX9meYXoyN5Ml+FHT69LAJd3Tmgoy+Hc/
 xsAnZJZErXI/CoqrFE7C2ewTv1187nFYCjIT8LcBxmcxt7UJMbGk5ysVEy4WeWk6toA5
 jWy5m8LNAB08FiNso1NtVVoeBV36Rn875AYR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695856; x=1762300656;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTgOVLqLeQeDcVsnwONuT061jTLZBx7+rsWhc6+XrTE=;
 b=YOVb19bqhSVVac2Tlj8X3gMem3u2H5gYPXNU8JQ0EirUI8I0BXlRSTyWQX0x2c5Knh
 7aQVRg+tnAKvxwstVwJvFXItvHj6/8AhIvNKJriTr6RZu1QUGQza9pLPzeQUpXaN89qb
 3K1HCyeMRSjR6e/VUP6SUfr1TKnQEoQYaiMGt2gnqLGy5JePezEMDGac0STA+uzB/zpJ
 BCZGjx1C91cMdcmG4YD8S1NZVnCmd0T/amTMi2taTUDcnNnS8AQyXG/5QFNEpVX+r89S
 qf9YfVXEtDHj46t2lSGtXxikYHv4cIejmmpehiYAfQIJMD+T8Am4x1k22EUOFUtLAaCH
 /zVA==
X-Gm-Message-State: AOJu0YzZ6NIVkslBH7WPB79PvAwu6boUXMMzwAeIUiQXc6WHJlaVFY9K
 Z6qmdOGl+zak+t/uBmJuEZD5dBIUPgTwKrJFThmANDtV8EeQywffQdn6UGWR/f8VtI4=
X-Gm-Gg: ASbGnctaspw+EbISYXEZGID04vgQhEmGP0vKRyLVAkMo3YYLRjsbwM61gKMIVAj4yP1
 wbhzmOQpg+jIB6bTiU4eVl3euOexQxzNsOMShwttBMr+jdOlfWYBYm2YpHAIB+RsERtjR41duS1
 Y6eSuxyr1UPB8Z0kSAjmQWJJhsjJKF9ls4089Q9AAg9U6WFJiiw0z2gv83cVgJA7DOEdabFtOuP
 ekVHdaLenD/F4T9kthTGqh8t9ZEXMtyrXswMYTDOoF8GhPgXiq60C3AgZNYOANRG0ax+Gu8dNCR
 zv4d5oq9xQbRmp6wagkuh3oOYayl8gUx96/xanomYEG9sKusMlDW8ltOp8OtUwbMol6DzxNu/JW
 i1R9mRU4m60lFgZGYEor1N27U+alh7QOoJjxNHpnvmkr8IpKUUJv/yGxcSP7GyNOsQ6XdMRjzEV
 J0TFIz6aNIQwVFyCylT+7Ej2TkZFpTg/4zNYxFuQ==
X-Google-Smtp-Source: AGHT+IFHNAEM0ozOmRneI09MTBcQp9PRlCic+u7eGgxPk8U5aRZcqYp2uB5pc2L3w3lwTt72CsuzNQ==
X-Received: by 2002:a05:6830:6009:b0:7b8:f2a2:46b8 with SMTP id
 46e09a7af769-7c683103d1emr705111a34.17.1761695855938; 
 Tue, 28 Oct 2025 16:57:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711151601.2224226-1-trini@konsulko.com>
References: <20250711151601.2224226-1-trini@konsulko.com>
Subject: Re: [PATCH] mtd: nvmxip: Make use of LBAF for printing lbaint_t
Message-Id: <176169585489.2287207.14493434780331687776.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:34 -0600
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

On Fri, 11 Jul 2025 09:16:01 -0600, Tom Rini wrote:

> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: nvmxip: Make use of LBAF for printing lbaint_t
      commit: ddc28ad0f2a23097a95fd897e9a3db95e3f20034
-- 
Tom


