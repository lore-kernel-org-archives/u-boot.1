Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A9DC83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 09:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9665835EA;
	Fri, 18 Jul 2025 11:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dx7MqOCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B8AB835EA; Fri, 18 Jul 2025 11:17:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C8183096
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 11:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so2681735e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752830252; x=1753435052; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bkmATo9H4YEoncaw7pvt7IljWm0JU+5ul9HPWnhTk5k=;
 b=dx7MqOCS9WmeAbTsA+3N+Xd5dtSncgKgwc/1lUwxpi0QTPblcnmVSccMEMI5OTo4CN
 F79E5jaZHK+oLyvyzNA9CTS5CCRrKaG33lqprZW2gG7koH/AVXrvndQO/mdFLdGMQpgF
 C5FE4d3KKF3muGpDDJ3VigUazOLr0/8RcYHflXSdKb5nlkA4RR4M0vxLNfmbnvdzEfVe
 1fEJr5r1cH/coR+sfKOuayOYsvqu24o+cVssJrOEw5exjk1Q+iSXUqt9uILCyK5tDhU8
 xtHvZW3myvlEAypnRB0aH7l88xpxNhUh7f3IXgSEuggkGMrSAlemC6kOkUjd1rIHIrm5
 uaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752830252; x=1753435052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bkmATo9H4YEoncaw7pvt7IljWm0JU+5ul9HPWnhTk5k=;
 b=UbhOTEhi9YhzRGcTXyeP40DglATpsPjShJa5SYUMyO0IQE5pag314aOJgGD+uVH40V
 eq8SND8ep0XmuWXKx+G0XaVq2/qbX4lpH2YXIHNECce9iHZbg2PpP2Pd/EktvIBjrb5I
 zkxyAaHPQDMijFJ6BjhO2J7HTfE8YpSU7RQeDA95t4LvJun7jWUmpL9Q434Zru85TQaR
 fuQPmAp194uqv+XH8LeyMmwZ3Or7FhKjZgDsUAFhhbTyd4bVjaK1wZGLSgtJy+2JgMPi
 aaL+aMl5tzHXLcRhGo/8pQ7ni0ikPyYMigfs1qwHbtvga0Kh7BLpd0/DcFA1CTmmiRs6
 Kocg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVgNqtcrOzpyLOfSNiL0AdjanNkrF7jlQff9wWxVbO1quhqfzTu2hTbgeXShqN6iqbPJjKVss=@lists.denx.de
X-Gm-Message-State: AOJu0YyEFpBKkfp+kKPhpTevUo4+KHk8IT60T3iFl9faOF0OONEGkGt8
 RkDOO7g56zqHTNECGmJoSaU7klCFe1bg1vywggah6Q44BN/WgfqN6ib6VS1QA3jY45c=
X-Gm-Gg: ASbGncuRByBlDCbkua4rkTNfoaH7gacLdKqDD8W14S89YrPIrHxIeCf9ygGyweFE6TV
 HLrBAkLPEaLvAxfVDRJLSwl32RW4rRD/94JNIujxikJ2wNjifHz1P68fUc4OW1zJsIDM8MuovQ/
 NPIZ4GC87FFV9cTgIaW/5rR3dxhPbX6J/mh6oUvbTPFHxVWE7ViEEBWefJOjXKAru2DnZ1TR/V9
 RsOXd/QP80AtRCcLXX//z0pveb+HTb4WANCfwgZtTjeAVn0gWt2r0Y/T1z0QAxl+A/wGfYBtANL
 PAJJtzGQf/wkm8Sh9A+xSdPQdIPCOpcStdUYUzCn2bgU2+u3Buo4/NmBv+RPsWLkTgW+TW27rY4
 STZFsJMNTmX8EyGajIupPEUMnhszcPjd0LRd+ogjWlJSmY9v2ZCRfneV/SHHizkOJ5LoqOXZbvi
 q8+A==
X-Google-Smtp-Source: AGHT+IEO0fXEHli+bYdwnY2C5P9U8I3mMuSydl0Q4qScRZfpAfSh6/eUU4AXdjRgWN9OFIq8+FCcLA==
X-Received: by 2002:a05:600c:4746:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-4563477d59amr59419755e9.3.1752830251996; 
 Fri, 18 Jul 2025 02:17:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb9:1701:ef2b:6c47:de09:6843?
 ([2a0a:ef40:eb9:1701:ef2b:6c47:de09:6843])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d475sm1252760f8f.65.2025.07.18.02.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 02:17:31 -0700 (PDT)
Message-ID: <9d326f07-6eca-4b7c-8dd4-73b74ac4b8e4@linaro.org>
Date: Fri, 18 Jul 2025 10:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fat: Prevent possible buffer overflow
To: Martin Husemann <martin@NetBSD.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250717-fsfat-v1-1-4cfb1d1a77ca@linaro.org>
 <20250717145858.GB20410@mail.duskware.de>
 <1e80ff96-48a5-4a17-85df-59c8459b3083@linaro.org>
 <20250717165749.GE20410@mail.duskware.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250717165749.GE20410@mail.duskware.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 17/07/2025 17:57, Martin Husemann wrote:
> On Thu, Jul 17, 2025 at 04:38:50PM +0100, Andrew Goodbody wrote:
>> The original use of strcpy suggests that the string must be \0 terminated. I
>> will admit that I do not know the code well, is dir->itr.name guaranteed to
>> be a known fixed size?
> 
> You are right, the iterator's name pointer always points to a \0 terminated
> string, but also always points to one shorter than FS_DIRENT_NAME_LEN.
> 
> The on-disk fields are not \0 terminated, but the code extracting them
> deals with it properly. If the length would overflow, a NULL instead
> of a dir_entry * is returned, so while it is not obvious, AFAICT the
> original code is fine.
> 
> Martin

Thanks Martin, we can drop this patch.

Andrew
