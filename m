Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60245C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 15:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA7188022;
	Tue,  5 Mar 2024 16:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g1m2sosj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C929E88058; Tue,  5 Mar 2024 16:13:42 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F81588002
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 16:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d27184197cso79824931fa.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 07:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709651616; x=1710256416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mkUUASbIGDUFRStRG2JOIixPUtJSEC1NLICdFRuVbaM=;
 b=g1m2sosjyyt7JPGMDp3tP4HdKBZOAMCjARoggIxANL9rArUhmRLjji3UagvsAUcQey
 4pA17v7qdLuKdjIIzUeqXoCOOnim5n6iHnyM2qL1iKNqLoLTENU0Q2+Z6k4slIgpLaTp
 g1KMqMg+f1ALGHKjBoJTYszKANiBsQS+8wpr/v3Gmn8sxxiG1CCGgLNJBYdLUw/kQQq9
 lZQBXaJqhZcKZc9UFlUKo3woXW8UkMdxi8bIERpHnI65hQpGfH9VHvQvDXfgc0YmiG1E
 zGQGvRsrr/RagBXKxcdNyOF8m6/LRkNFzPdjlVxGq+yLgbgsaVfAbkUQTVZarg//LdVu
 69ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709651616; x=1710256416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkUUASbIGDUFRStRG2JOIixPUtJSEC1NLICdFRuVbaM=;
 b=ZFMHvWYWDC9EZwWOdgKK3+jB76ZsH8FMGWPdanBhTtDt8Jz/rFs6WdCej+G3mx/9UZ
 /HP+kLIK1hLtPEeLJxZOHRkUkFbKR1Wq3qv+Yn88+ocNG4NNXljvlCSwsOo/O1Q+hpen
 fNHcKlrkEUhImOHt8wknakVV5h76mh3HU9K0o72Y8WhwZ/YYEeg8xfPkxpK3vYYCcUDl
 7auxkSGAiCHgI43HOMpWKY/KhTabP70w/Lao73CnD6vfakueAMzSvqrDTT4gktg/fga2
 QDw+v93X5X04XVDeaGYmZnbULn7Mv2z9ZGg2KG7+Kd3HEEOcTc8ux3UtKf71dkvSxocZ
 EqeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqVDBu8Gwndqu/QQFA3WB7MFJiH7FK227m/OMtaCe22ydGTrZ7y+vEtfewFoxYMMsOzeEt2iDTL4DYglvxPDBpMkvxwQ==
X-Gm-Message-State: AOJu0Yz20jFcCWP/AtxzYvh/bHxC/mYj8M5Ka+0ILu+DFB9yPTQrltaS
 XjmpasP7ZzSpIkH/3/HaK5I/XFYvMalN8vCSjQSAytwPJhCKw5P+e9uOyysO76o=
X-Google-Smtp-Source: AGHT+IEVY2Vvx43S5gyIHZwcJ9kGpTNX86asymj6Dqh7Yz1gZrVqoWqmhjtc/AlHg9wWPfYlXLF1sw==
X-Received: by 2002:a2e:8946:0:b0:2d2:a3c4:4f with SMTP id
 b6-20020a2e8946000000b002d2a3c4004fmr1727211ljk.35.1709651615914; 
 Tue, 05 Mar 2024 07:13:35 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 d15-20020a5d644f000000b0033e052be14fsm15125752wrw.98.2024.03.05.07.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 07:13:35 -0800 (PST)
Date: Tue, 5 Mar 2024 18:13:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] initcall: break loop immediately on failure
Message-ID: <d272cffc-12e3-45db-ac40-595fedd7d9dd@moroto.mountain>
References: <20240305145525.1397253-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305145525.1397253-1-caleb.connolly@linaro.org>
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

On Tue, Mar 05, 2024 at 02:55:13PM +0000, Caleb Connolly wrote:
> The current ordering always results in func pointing to the next
> function in the init_sequence. e.g. if fdtdec_setup() fails, ret will
> be set to the error code, then func will be updated to point to
> initf_malloc(), only then is ret checked and the loop broken. The end
> result of this is that the "initcall failed at ..." error will point you
> to initf_malloc(), when the error actually occured in fdtdec_setup()!
> 
> This can be quite confusing and result in a lot of time wasted debugging
> code that has nothing to do with the failure (ask me how I know :P).
> 
> Adjust the for loop to check ret immediately after the call and break
> early so that func will correctly reference the failed function.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v2:
> - Don't drop the initialisation of ret (thanks Dan!).
> - Link to v1: https://lore.kernel.org/u-boot/20240219183519.2183405-1-caleb.connolly@linaro.org/
> 
> Cc: Dan Carpenter <dan.carpenter@linaro.org>

Awesome.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

