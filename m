Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6A9C54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 06:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA63B88094;
	Thu, 29 Feb 2024 07:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Win2b23d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCCC18809C; Thu, 29 Feb 2024 07:57:35 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D07287E03
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 07:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33de6da5565so315956f8f.2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 22:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709189853; x=1709794653; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/A06XTG1pDDs8S8dhY9UE8FWKMaF6x1FYQc21Ar1Uag=;
 b=Win2b23dZxxHH/XgT8Cg6+q/5O4EX1AatTD3mrLKSvziXihgSgkJ6t1b+idw+ADjt2
 FTG5JSIyOuoVfHAnLZrjsCtmwG2zOAHtnBJg0TqCs7nQceMsZHj5AK6OHgKwC5EFzr8Y
 IexWZaBATODzH67Ka1FswKTVZaBbaYovz9EJ10YHoIiafNwPuJS64IhMtXs1/rvcpetx
 VxXlqoBjEdBtSvht+dCWSLqXwERzybxWaA8GS0ZiAYvgLOTlB9TVeObxJhn5sL8KA3R7
 3SUXnHVVR+hpEM7mbpBSuYBh3de8FgoENZdEr4M6gXCfaYEcRf3wusOzqKAvI8wVkZuu
 N1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709189853; x=1709794653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A06XTG1pDDs8S8dhY9UE8FWKMaF6x1FYQc21Ar1Uag=;
 b=nQwUQ/aGOWwu5nIz3sytzbHze7GwMHH7Wi22BM+3RcfZxce0VDRQZrE7XNQRQwBhTN
 Qx/m4YK8yV01cPaNQPGyCRHdw84cHW0yV5qFBOJinP6kdPvVozgzmfHxaSL62rzzoE4E
 ZEtZd+qpo2y4oj0LHu+FhSXYvPCQTYYtR/1A3tgs0GIbF3fbnnaXOHU2jwiE0ANRPslI
 DBEfPacN96vfOvOnKkbpIcjOF1QTsEtxMxYZyvWOeDbJ6pRKtrJIbutU7yAV0ovDYjIm
 eeFu0s+1r1dzIyWSqVjEL4oxfInooxwiLnW3Wv3IHDyOvxDFFPm3D53zabgNFmER6Wzi
 F5iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXutmVKMhbvZkqNNsaTivUm7xR3uq6pzBGGteY4MiPs0nhpXZYfGqC5r05muKtEgTAuj9QXMXnHcjuRZtlaqYDbTPwAZQ==
X-Gm-Message-State: AOJu0Yy7lZR6vWrn1DLFbaX9NHwFcMPqIOyUY1TnD14S9pWwiLcdRJwc
 3fLxBBRuhrSJxw76wRsHCNnWOa7QZy7gGt4CzXm3DBzBfN9Tf7bu04fV/KHVaUkbqO8UXyyPPgI
 8
X-Google-Smtp-Source: AGHT+IF1rBNrEh2/aXUqWz8X/Ab+aCn8QoORMAbUfblc7J+8Pkde7Xp+zWZOfpBTmAYvErJWHyB+7Q==
X-Received: by 2002:a5d:5987:0:b0:33d:d358:19f6 with SMTP id
 n7-20020a5d5987000000b0033dd35819f6mr1100138wri.11.1709189852960; 
 Wed, 28 Feb 2024 22:57:32 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033daa63807fsm876139wrb.24.2024.02.28.22.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 22:57:32 -0800 (PST)
Date: Thu, 29 Feb 2024 09:57:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bob Wolff <bob.wolff68@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: ECDSA related PRs
Message-ID: <a7a99523-3e8d-4fde-adf4-3cb6fdc2e94c@moroto.mountain>
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
 <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
 <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
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

On Thu, Feb 22, 2024 at 03:07:01PM -0800, Bob Wolff wrote:
> Peter,
> Thanks for helping lead me down the right path here.
> 
> WRT tinycrypt, the license is quite permissive.
> https://github.com/intel/tinycrypt
> 
> Also, I'd like your advice - I was thinking for the larger patch that I'd
> do it in two commits. The first would be the addition of the tinycrypt
> files and the second is the actual changes and additions to support ecdsa
> verification. I doubt that's controversial. However when I run a trial
> `patman` against the tinycrypt commit, I geta huge number of issues:
>     *checkpatch.pl <http://checkpatch.pl> found 186 error(s), 380
> warning(s), 481 checks(s)*
> 
> What's your advice on this? I would tend to think we'd want to /not/ change
> the source files directly for such purposes so that updates could be
> brought in with greater ease.

Yeah.  For this kind of thing you wouldn't want to make a bunch of
checkpatch changes.  They sometimes pull crypto and compression
libraries into the Linux kernel pretty much unmodified as well for the
same reason.

Igor's proposal about pull this stuff from the Linux kernel instead
seems like a good idea though.

regards,
dan carpenter

