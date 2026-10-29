Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF4606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=suLnj31E;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aVsSJNxY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47EF5808AC;
	Thu, 29 Oct 2026 16:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GzvH9CNuC92; Thu, 29 Oct 2026 16:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E11F808AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291576;
	b=UzFtmRE7BTkr8xaMR35fDjGHwmOldCA0MPUCMp2+5knNiuvxEH6ZaDxNe1s8/8SYuC9U
	 /HGn1TWGKeALcqIAoVFPF2ADIakwXHJuB1JKNMn2CFW7+ql68nx9k3AGi5i4ieguclOph
	 Mg2WV+qa2hE79QcBhqseFmmFZZnzR/zd5oFvRUpCOIqhZmVWOI+MvXp6r4CSLBbZt//Ec
	 BW6t5jLuXaUZjFvTaaBgbZg0uWDc4pbRhV9LAKq/FTR6JjMPB9zSDM0hBiLPaYrpRoBoV
	 k1AxIoiH2OFcUoICaDkCQflXNiLb+XumMIGI+ndn/mbG/eva3/Bei03WSoX5N2YB0xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KUgxXitW+ERqSWvxxg+O919S3/27h3iMaTmyHam/5wc=;
	b=KR/06y7IZe6H1RYj4YKoEhKztXsKcf+iR+dzsRBSICt5t5+jitfRLcvRWSS4uVKb7EZY
	 zxV0PGAB2yicC8/CwFJmbf+7Up4kE6EQqvlDIc2O2oskprH5I4GrS1lLltuRRhdTHMU5+
	 g6hSRBGh7YX6vVJoUeX6MLSYb7pFyewW3lemBtt+aRZoHGQEgOD3Z5FgO+pQWi2sjs9UO
	 lYz9vzbva/mkwmaScbNcI3vIl6mgf6vRPI8rPs1XOMcszBsiCV+T/kogZ5IcRjVddTrBX
	 j6DoNpdSMYy9jx0HLlMZ/QShWHnXr2hmB5jONjjGcSxE7ddRx01Swzgc2sSU/Y+tQqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291576;
	bh=KUgxXitW+ERqSWvxxg+O919S3/27h3iMaTmyHam/5wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=suLnj31Edn8DhssFbePRhjbnFcJqRLNxqKEAqYM2iuD6gsGsAiVsD7S5UX1o5AI/K
	 EUKP2uzeNyMhxm8sVAbjAKmrGiFciU9uw7NQTMf3KzNUCmWtXpghFznkqCkGIRZsD3
	 YITR5h066NXS18ITUXtYwtOVLIIqsKXXpruG3u/TTQ/wUwr3Ng56tUB1JQLVmR9rgW
	 fLvpFoh6HwmbXcQNMohmPGlZAfuYhS1ieJRkAdOkqrJ5JPcn8Y1PXbvZb2NeGoFQUh
	 /giIWnUhKM1mS/IDMnOvoala5XRH5mr8m7dp04qqk7H2zDfVYkXTTxoXMANXH7jUfF
	 ptq7NRZw+dt1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E11F808AF;
	Thu, 29 Oct 2026 16:32:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D3FB380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6140540269
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAamtlgWl7yB for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:32:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6913840243
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::733"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291570;
 b=o5qVCSn/SXUlddMTC3ixnLNVQnjxSqpLqAM/GIWD8ICYNv1SOzUr6kTw/eWhJJ4j6RDL
 fIJch25v307Gph2Hh1/Aq04Vv5h105blO6n3Y4luCjXBfbkrd9E1lRbUoai7W88YC5eBZ
 cQRcUJwroLcl2if5Bp5R82H+gwcdx0HWaojk+nu4bLv+1gmYt4j+xvk0tgjqBkzoTlQNz
 YIea/+08z4xMgQL5QcqSj0SPZGW3+arDbRMq2UA5hhm4MVYNQsoGt1bpfibniuyGUcVYL
 55X/EKex5hXJQUkTFrG37JqjdfIFUltW0w1nLNIJE+68OyU6Rk8Wcrk3BARrQybNehg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291570;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=KUgxXitW+ERqSWvxxg+O919S3/27h3iMaTmyHam/5wc=;
 b=I6gJEMuFyLHh9Q2GaVbcEGINhp4KAE4YoLVvAOkH9ojn9YDvRjV0/Zt837GcFL7EZ0Tf
 TLxwv4CxVSILbOQElZoWDmao3dEHIcOOn+jsMvtmzyWW6sHCC1G+Qw91v8w9otL8LJdRT
 v1GoApyfKWvz+Uetghfjb1XSWwSMfmlM8jkRWNpd3KTC4GXN5uoBoUBk75/Sb1iFUT8tF
 bF3xmBtFS8mU+JDvXgeLZzvDigcbuuR9t9WdEeTEYu2tW7Mw3GFQr8vcHt+hkqqIdi3QN
 vbEZfXB8eIkgk1o+AGfZ97tMDeueeuMGLt7TsAd1jngKCqJVb4AE6hR5rFGPNyVqFUA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=aVsSJNxY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::733"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=aVsSJNxY
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6913840243
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:32:49 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-93e64d52949so185632585a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793291569; x=1793896369;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KUgxXitW+ERqSWvxxg+O919S3/27h3iMaTmyHam/5wc=;
 b=aVsSJNxYZ7x+igqRstFcD+hMZxya5k+ExdhD2LQzZxhOSlfiS9c0CFQrt4xzw9aUgO
 02LAIo9pmwYJA4Yxf4JARzjOV9yBYK0+eSIy4xmEpIYcPG7xRq6P24I8H3pCAGZggl7T
 I0GkuhzjqiJZ3Ie2MZ9y4+4VWeDheX6PgwjA5+vfJRCTsJ33d3cirk0WPsc3/ASgWbql
 6TR4+8ugXahz4aqduL5U9Gj8fqkQCYM6QeFvgksbZUeNjxarrjOekQx9O6KP5yQSFkdc
 gr8f8oLAXd8AxiuK/ucZapYfVq9qH2rnUXiFxy11Iw7V1jErm4u3f1ei6Xo/f8D3RMK8
 dr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793291569; x=1793896369;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KUgxXitW+ERqSWvxxg+O919S3/27h3iMaTmyHam/5wc=;
 b=mJ1MtZxxT+buEcp8jiYPCL+vz6nnNu5LspmWnOY/FXQIHV7wJcrh904TqUYekxU9qQ
 tgHvvFe/Y3pOg5Roypjtg+S96x0MZjcmZW2RKUczVTti5e2epP3mI0XMlX+lfjaItU4m
 WOCO5GqjeVavXTvCoQlIjz+vgWelV+od9VArveOv9JxztYoTEq2gTL13UTtjRxAUX4fZ
 JJSRMeVQKgWjPoo91qaymTBypcIKsqci5u6PmWN7Z9te88S+TawhQZX2QLh3jmVoF/bH
 4/+jRc8BPs+OlNZHpycmcOFvddXPe+BcCc6QI6chGDW1reyzS7hRpyg9h4he1UVnQpAJ
 wsZQ==
X-Gm-Message-State: AFq9FYKD3AA6MkBJ5VcpWVj+UPQXCVA52ZbbN1Y2hBK8wbDX2Q5K8x4V
 RwIpHpVgSzBw9HN78EVbWlwI+/tq/4ksILfNYkvL5QjSgT1lscFiYWRFYXceKIB3Xlk=
X-Gm-Gg: AYBFou2yDedm2hfGrY/xUuIXkfbOD94ZmjXWVLNOaD38vsgxDFgm+glSDmox4TIpsjx
 Orkud3cs6ug96XOAOi3JF0OMQz880+VRwKVx8h4tM61YlKvdCJRwjvBhxSwgNpEUTVfUUuKApUx
 KwwPPveJhJOrpRbZDyAW+BE/+EsZgJ6c23DGftOvPsiIIn6VTR7SjqdH6W196uNIKGCdvoarx4E
 fw1yY21eSwaW4e6X7yH9ylh78zqGXMwRBz7RHUVto/2azQozWM1+nbeWV52p/Gy77g5JlgVub6h
 ElHPNGDa9rGW2ugvo0iPkwM9+oEPl3bItYgMEofIVr6NG2wVvkm7bvDIeycwQ6MvjuvpU5O4QBH
 Hiq0qNHHaL6RVAKiJsv11c/NRI1BQM26ldfuAwNS9/hKR3F/CSWrAM0GjRJxDzm53D7U72h8CMI
 3SYDc+GWOIJTZYJJbBRImcFAMQKZCQqOTkUgp67Mm9WsDhr/DnmAeP70T/kpPzBX7KlK6bsxgz7
 w5OWZXIFOmLEHBYpGGztmlNqcbyDy+W8Td703IwMXve/PP4NnaDzm/1QNv33UF3SUHUGF/7M61w
 0pxlvfPcvg/deZQZNhRQPc/OxPrN3ugtP+3uwIc4PPNL01RP/jgTYUIsnoVd7n2PysJjQZJlOxc
 u36wEEqXxhpJFjvHO0nL/RdU27SUPtF0h
X-Received: by 2002:a05:620a:2849:b0:93e:5821:2c5c with SMTP id
 af79cd13be357-94408cf1bf6mr909795185a.60.1793291568571; 
 Thu, 29 Oct 2026 09:32:48 -0700 (PDT)
Received: from localhost ([204.244.107.52]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca3174985sm279376d6.41.2026.10.29.09.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:32:48 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:32:47 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] doc: develop/sending_patches: add tips for series
Message-ID: <auN1LxHZJsTupScu@maple.netwinder.org>
References: <20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org>
 <bbb802bf-3569-4555-a323-fdcd30dc927c@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bbb802bf-3569-4555-a323-fdcd30dc927c@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 03:50:04PM -0700, E Shattow wrote:
>
>I would substitute "nutshell" and "squeezed in" with something less
>likely to confuse non-native English language contributors; ("In
>summary, the goal...") ("reviews of a focused feature or concepts
>supporting one idea is less demanding of a busy maintainer than a
>collection of many smaller unrelated changes with no common idea").

Thanks, I have adjusted the wording slightly. I'll give it another few 
days to see if anyone else has feedback.

Cheers,
Ralph
