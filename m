Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1449310F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1348E83FAF;
	Fri, 27 Mar 2026 17:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N7cVfWO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623AA83C5E; Fri, 27 Mar 2026 16:48:57 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CA78394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483487335c2so24963875e9.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774626534; x=1775231334; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xq3lbzwnBRFrJS2rMugT8JMUZuQgObJGqc33EilU5XE=;
 b=N7cVfWO0w9QB+1LSpuDNiUWs+3Ht3n7mR8SMESdXu8iOmEa9Seb+X/qXAXQQWI4CY8
 OzD0ovlTie8eqqm+r5wR0bd/ID8SzFVgy3BMnTN+EVJxR5PujhYv7s3YStKy7AYa2NAO
 VmFRuyxaMpKZhT75LR06tn37cAVJbBwItJssnl0vMe1YH7ZThCBEIrVm9IOMmNcA2szv
 mWvZGOcyHhJPnhwzjia906EFKwnEGUj608B7WT+vzxVy1AVJsXJkGbzzasK+IdZIKWo0
 GuzEUH84b3BCZTUvgKHqoS/NpDLk8wh9UW7P+POUBqULJ+mBkQNiFHdudYVaLIRmZb0d
 vIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626534; x=1775231334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xq3lbzwnBRFrJS2rMugT8JMUZuQgObJGqc33EilU5XE=;
 b=XnIkpoTR4HkHA6YSrGkupD+LVZUJqvLX+d8lUfVjKbGLKJBxkWljBl//+d2CUoElKJ
 oRlDsDl1R9Jm2TjMF5YgKRhZ0Xc0aAhjpYi3U1mZ3WsX8d5jkOnxvs0sb4X+UB6N+AJ1
 OBz0Y2hk+drxN50/IRRcIwSuW6HCgllhX6lrcf7eBOcMC02WkbaLH/8pA0dxbJFxJltW
 /ISLrij0bHcLVL9ngSDRiYWklAHr/kimZaHsGsd+b91n2MMueGa0qHHbspxAiJhsevf/
 w2HgaX0PsBfyZRg6x0fmdcQb+wJsbrIz8t1jiFFtALj73IJ0/7CeY6YxN4PaANkOrzhU
 e0ow==
X-Gm-Message-State: AOJu0Yz8CGFA7GboauLmioeOxgUglw+kLVKb55d5lhSMfdDDMPwJ3Vaf
 YmYFK7qdY3nwHP25bD42Xaqb6bbPL1Q+iPJxxloVJH8Wzn6GT4/EphRiljv9RY76
X-Gm-Gg: ATEYQzyai+pJhEt9xbkIfxvHv2zs6x3B2xOi0YHz1uJ+ruIJivpju/0Kdd73Uv5hzsm
 kJ9W5rVyYGU0wozWC++8zOcetIR9SE7FXUPv4FVxNNYiVfODElS/VVzBDv0Ve5qC3W3ocqhXFue
 kyArsuc3qlVKXJlGi3Rac6mUoT7EbdtGfp5W0/kdaARgQMAoNgtX2e548QRqpGxYeVt/cRcIRIJ
 MZz31MHQbalHrWSRVi25LfotzzZffFwvq4NPsinnH4Iexh/EQ0M/gMJb5nxaSr+ABFc6sKhI2M6
 TYS/iw5YjTIG7RcQ8YrE3qjagbpcvuNVLf+MSs2aJ/0yPX2EWhp6Ib+RhtffZ9WBbzt0UaGgRld
 0uYjgGLdQcp3ReITyLVyAiMGeMT2w0Xiy334O+lhx+46bNvF2Z5D1FWA14krJcg6CITzg6LQskw
 DeDWr7JKAODulcYX8m4gVTa2m7/j2qEu1XnkQzIAznuK9z+WeJK1X/lT/h+a7Y9pa+9PhxHkq3r
 iYqv/RZHD2lL4TAD7UbURn6Hj3kTTSLX4/BkhF3Lc63HGA88xbfigs2NooNz+5LeSV/kkRytA==
X-Received: by 2002:a05:600c:c493:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48727ef163bmr48996765e9.4.1774626534264; 
 Fri, 27 Mar 2026 08:48:54 -0700 (PDT)
Received: from franzs-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487270f1943sm24080995e9.7.2026.03.27.08.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:48:53 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:48:52 +0100
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH v2 0/4] add [ as alias for test, fix 0/1 argument handling
Message-ID: <wkhnll7k5qq5jzjdhspaisvsoygscuhuqaqdz6sahrxwuhihk5@uedggycyvvwl>
References: <20260312100106.702368-1-ravi@prevas.dk>
 <177447995901.3508238.4236856739882459467.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177447995901.3508238.4236856739882459467.b4-ty@konsulko.com>
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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

On Wed, Mar 25, 2026 at 05:05:59PM -0600, Tom Rini wrote:
> On Thu, 12 Mar 2026 11:01:02 +0100, Rasmus Villemoes wrote:
> 
> > Make 'test' behave a little more like its cousins in other shells, by
> > allowing the [ ... ] spelling, and while here, fix up the handling of
> > a single, non-empty argument to comply with POSIX.
> > 
> > v2: update documentation, add a few more test cases.
> > 
> > CI is happy: https://github.com/u-boot/u-boot/pull/905
> > 
> > [...]
> 
> Applied to u-boot/next, thanks!
> 
> [1/4] cmd: test: allow using [ as alias for test
>       commit: fc8bf9a984c118d551b3f93c66f1ae2733b9b588
> [2/4] doc: test: document [ ] spelling of test
>       commit: d44f61582947564991cce7501f2e5db0b29ebad6
> [3/4] test: add tests for left-bracket alias for 'test' command
>       commit: 6f9cc3310a764aaae4478b5a8a0c0cae3b2be4a1
> [4/4] cmd: test: fix handling of single-argument form of test
>       commit: 8b0619579b2282050e7fb0d92fbc645b79d18bae
> -- 
> Tom
> 
> 
Hello,

While preparing a patch series based on u-boot/next, I realised that 
the bootflow on our module broke.
I discovered that the issue was introduced with 
commit 8b0619579b2 ("cmd: test: fix handling of single-argument form of test")

This change breaks our boot script as it relies on the behaviour of test
with unquoted empty expansions. For example:

```
test -n ${m4boot} || env set m4boot ';'
```
Is now `test -n`, as there are no quotation marks. It now returns 
true, so the fallback assignment is skipped and it breaks our boot flow.

Any ideas? I think that we will not be the only ones affected by 
this once it's merged into master.
                                                                        
Best regards                                                            
                                                                        
Franz Schnyder     
