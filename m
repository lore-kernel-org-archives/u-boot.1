Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708D606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wmHlh3IZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ttgg+jRI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A579C40799;
	Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQMSkJNoj_f9; Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05C33408EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794945789;
	b=DlvU3t2vPtTOm3gib1yFyaa7LChaXeuliDUFNkdmSXqteICmVFRZsniiBZ/yuROEl8xA
	 Es9eSoJrWCJWUyXXRwXt3WDtpKx4VmGV+r/N2fOcForuUq/uVTjevWKNsW7OLuEhe13hE
	 4iIB+66ro1rKW+I4AknT5kveYWe+UPklZMbSRNuFtcP9c+zGUX9QVMNxkR//H3n7oUKvF
	 4VW+e7uDTCycHg4ThumaLlFuaxIhDbkIhPw8neFQdlzqqDNypryLgDF5tAve6OkDfSY/5
	 c5+2w3fa1I31vWZ+eAMCeYTZ+0Cw9WbwmQwH7ac0HYDu8tygL710xEz6oDkoLghFKiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794945789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1j73Hv2IrBpPxE/bWnMD4xwU7jrFkItt2Y87eHXa9NM=;
	b=V1sxwvKGt3v4H1k9NsRJBVB+chkKMJwSpZAUq8DZ6A6T4RFdiTEfMLos9lixwP8Uxe64
	 eZb3nL6nqHKEh+shQve/tSCyvjobZbFBKchh9+ZZFT5RciV7AeBH5oZTv7slz+i7W2j3i
	 Yv5AQpx4voLffHFVQZroMD+oVWXomZUacRi2gRl3/es4u+X06wKmiA3XM8Q4jXI1bZl/w
	 FwPY42bJoEeIZzC/3tFSZbFk/n9STuoD9e8s8zxt1nPL/Yke4E9dDNTQpOG/oscesh2sD
	 i4h7p4fk+kwC2DrXruDbGB71ptjnvUzgbaqGeTL6C1QDjAUB7vInPq2xW5bqKej+O+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ttgg+jRI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794945789;
	bh=1j73Hv2IrBpPxE/bWnMD4xwU7jrFkItt2Y87eHXa9NM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wmHlh3IZhFV8tGTSH1BUyq4kM7gCYvOHlZEr4ERHv0Je41ANe9HIugx/3eP/kXuM7
	 M83xd/gHqlN1+mKsXFi6M1vMY5E29wuA7r/1yuFnXfRyHy3ysSdU1yiN4Egqj5erf5
	 AoK1ywhg+RvhFN/F9CBgynmrO3/L+LKz2MjradUBkygcpeh6ozmAbDKU/eIwwxLnXO
	 8nm/Z4aFfcOkVeUoKDB+IoFCe2S15lVN78sTx0nkuCUiPSDjOR0Y95JJX5i35P7DW6
	 Jm9pZQfXG5ZOf6MzEQZL9pXBAkk8U5SCJF/nSpr5pGqGlpthdz7F50M+9noBKcWvq6
	 +cBmXLovSUItA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05C33408EE;
	Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C10A9F8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F15C340799
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxH38SdT43d3 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 20:03:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5180D40785
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ttgg+jRI
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5180D40785
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:05 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-5641f26ce05so45157b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794945785; x=1795550585;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1j73Hv2IrBpPxE/bWnMD4xwU7jrFkItt2Y87eHXa9NM=;
 b=ttgg+jRIo2MskPnh2i0BzGEmK+w10M3i79vi2DPvuCkPG9/JqDxknOxCqHJD4ehLoY
 vzRVs8dEN9bFOabqmExtf0FJp6i+VYIyZqhnAMl8J4zOIS8s1xwlAWQ4WBx195qrsESO
 Pa8RAOPjHHGYBIEz1MsGwEmgbKQnJk6tJCJ6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945785; x=1795550585;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1j73Hv2IrBpPxE/bWnMD4xwU7jrFkItt2Y87eHXa9NM=;
 b=k6G458LXPCzSX5dknIHjZxQ1O28jFujWEzHfzzLAnNL+N9284p/fQ5oE1y3IktOR8b
 VaPS7B9N/EZdK32lTCfibVFHky5v9fLaBDCxR1e8/OIGgpiW7+CyYCY9HZFQW213BfHE
 LQ8nqItzGh5XSqM6mCW4hrJHXR8y5/RyJNVyoUer94xeM2y7NYt4f4QXHqoICNVTZ5y9
 71ekmQTUZZd+3i6ExbkOfnEcxDBife/D0NjH8BkFlzizgGEgFSAk8BEgWGuI71meORJg
 f1PlrxtmqUct0U+0G62X0tnzgNBvGd4ac891N3sclluH95NdD2OCE44SFlaK6kPlFaCl
 FHFg==
X-Gm-Message-State: APuU4Z8yIa/e7jsC/Fc51lUEil7es2Qx+r7T+sUn0cmqb9UYXb4Mz0+B
 vjKQzwEWlmB2LqT3GdEphHTYvE/jCTKHLVhCS6l3jUu+5S/oRJu41sXXhzCS42e9nVBba5EVwWb
 H5vCXHf0UQg==
X-Gm-Gg: AYBFou3zAmTa10fIi9Fk1fuY+1dw52ISeWNLHSgqU7TuYbV0EofQaQYrPkWIM8Rv7NZ
 k5zpmXC8P5Q696L/FtT7/YbcOlug6+M3mT7FZvhegYoPfze59KHVMpVVr02H5NstfFFXGos568U
 6jpvN3qgyx+dRSgO/zaSbFAOJrmV1VsocvF3ki4S/kymNVCZazUJL1dsLHl6OcArzZVIdgo0dOl
 48j9PqbPBKS2Xi+CF07QqjH+6r20YrtnKiNtsS++RzUoC+cacc+HjpqIWBsq1ZQYtLAeFWhB2GK
 pdPnjc4RhRn5FaWKyBtnk+dAO8hqU66PxNfB/QbWvtsuPWhz5xNOE/qVoko17+Xuqmn8HZ/apIJ
 CNCwgOPXDFxxmhX5i1QTWO4+kzY3vyBb0H+NDQSFxawAKwANm6V3Zf7m88W0nc6N8xAOQ68Afz9
 dKNDjmSGFAj/vC5fDI8MrYTThyUC86gZEfjxvr1jIB43FTFfrwpeJMpGwgmOnwGCaWYXM+9536J
 pH/mlm/wCRIGFKIwJR788tr7D48PUJd1EInsfv4NExM0mH0z0COTtYwH9tFWlV/ow9U0bMhvlVM
 cwuqdVDZEJGamwyFYtAg/TYqdy6PKDIvcQIjs/GQfGvTGi+EiDMOMrjhkLaH7FWvI7ZxQr1Cw6i
 QjaM4NUvPXQ/vEFi7WdHpWG5uLiKRotuKDCFMyO922foOxQNDD5I6FFHg9+ZOeN/v/0xmu95rN3
 M3U48JJgXIg3DGsHDtSL9ZWZCU1WZ8nA==
X-Received: by 2002:a05:6808:f07:b0:572:f8ec:5334 with SMTP id
 5614622812f47-57742712fd9mr797070b6e.50.1794945784701; 
 Tue, 17 Nov 2026 12:03:04 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm248119fac.3.2026.11.17.12.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:03:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: igor.opaniuk@oss.qualcomm.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261117064225.797584-1-ilias.apalodimas@linaro.org>
References: <20261117064225.797584-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] Revert "optee: rpmb: select the RPMB partition per
 request"
Message-Id: <179494578352.2846501.4038258306596027607.b4-ty@konsulko.com>
Date: Tue, 17 Nov 2026 14:03:03 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 08:42:24 +0200, Ilias Apalodimas wrote:

> This reverts commit f473480c43a85961b62a45436a7e095e16c2cdab.
> We discussed in the thread that this isn't need but was inadvertently
> picked during the merge. Revert it
> 
> 

Applied to u-boot/main, thanks!

[1/1] Revert "optee: rpmb: select the RPMB partition per request"
      commit: 89c37e22cf57083e4f6b85c21df407e008bb89e8
-- 
Tom


