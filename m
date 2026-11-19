Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB0606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GWCKGY+G;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rq3uPaio
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0721E60E1C;
	Thu, 19 Nov 2026 22:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LxG61tsEo66; Thu, 19 Nov 2026 22:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6196060E22
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795127207;
	b=K4aXsrvk1edUctjh11TQ1EYEg3nooqMf12XvCIzc9dboRgriCOYLARaCfOptxDoYvQxg
	 oQbctqpaboDd7X4YI8MNElR/AMKlIytXzvkG4qf85hfje7iMOxB23B5SjUni605eGw9Xe
	 H9AA1kUrpamQg8bHHpLtMP/acs1L1bY1wf5kAHpuiFYxrG8QqIWtCMvI6MC238plkKE1R
	 HHm9MC3i73NBI5H5IZvhEzXDxNmQSBphg5Ljgtxy9JmyrC0nbnKefkEBdz2+BB+w9TwXH
	 3BSPm+xY3Eb0N9IuALp2tIyHz12TVoid275kOumfNZHpx5g3NPbO83Ds9dDFPYyCxPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795127207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=20XPRqUKB75/wW/z7U6fYu9lZYorTHq7wDOIIEgf5pQ=;
	b=soUEq1ZXnlWNgfl2TbbCaV6tWuT67/YxYcFUM2opHf7koJm5JUKELL6iZi8dSniqtwcP
	 qkacYFFGs2gZp44MSx07ZDIpgEsJHeb45+nPoDohjhAo5tL86LugmqkDXDhyUTgXnAxEh
	 Z2hVY3MlNfsv4P1R4sRQTCy5ng9pdthi1dlRt1IV9oFfvm/+td5Hev8YloyXcXk7ZpdOg
	 NMl15HN8RymWRXMc3pdXLD1F1aSDdsdnGH6zuP6wUjggUpA9AvqWZrLG/ivsH8o45lX2r
	 Yr96avn/rUbxPI0gtQRTmvmRxqhrfYlVF9mVs49RXEwk+WIgvcaTjKGWTcFfSNpGOJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rq3uPaio;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795127207;
	bh=20XPRqUKB75/wW/z7U6fYu9lZYorTHq7wDOIIEgf5pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GWCKGY+G57wXpoNmPrlO5hsyINigjguyqmkQx7YusD+wPkwYnnHQx0h5Chf8+vNRi
	 pOIm4BQ/JXXlWZTnAvf7NI+7ADmBLXbalo5V7AXpUd9mriFdGZRBxtdJg9m3JkIVat
	 ytqA81EZUsOla9aYs7OBbP4XPsI5W0ybd5igPHNb0NR+eRl9RSdQW6p5ajzjjrt7+R
	 W1Z2PnkBC1MQNbz4c9qrEv9ijUXMgP0KYG1iPS3jxDvVYeR6mMRxB3jsKo3lgBFtFg
	 P5nTq4K5tEjyZstb3tZvIvOoMsY+5VN/JgvSSMxRF5yi+Pc3AxVk3pExQO7/5HWlkt
	 BvLhm3YaeyEzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6196060E22;
	Thu, 19 Nov 2026 22:26:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 598352F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F23360E22
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vfwyqOq4_Wr for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 22:26:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F53960E1C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rq3uPaio
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F53960E1C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:41 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-7190d9bdb2cso202698eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795127200; x=1795732000;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20XPRqUKB75/wW/z7U6fYu9lZYorTHq7wDOIIEgf5pQ=;
 b=Rq3uPaioEhBInYgwLmq2xk8h2fLd2DjXi2g3dnJa/Xy05nIXZovHvKPQ+Nz4exkfGi
 +6J66sevqYK2Z3BKhUbRNgD/BqALQFAC9qmFnW0sRnetb8FXqqUh7XlCyxuwqEEnpELD
 6rKspxFxO2GDCK2v8KtLjtHHPaGlVAQfLNwm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127200; x=1795732000;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=20XPRqUKB75/wW/z7U6fYu9lZYorTHq7wDOIIEgf5pQ=;
 b=HQgefgrKASXm/XSNccAIgEd2c/tp89BA+JR0WdB8hETgMmOnoPV0Fy+/DoxF1oZfKV
 UqykYyUUsOziJL8jVISVQVAqCy/C7aP7SSFPsL1dwainVPJzHIOKd4fxSPkvVAOO6vWp
 3fxBBl2WHSAgZ+VUZbpThYi7uWnOVTlhJpUMKxrD8decgnXH9CZS7S1LCfYuy5oV8+1b
 W/a+ufiEg10f8gkEmwWkDmNetapC/TS3uawHOdqQaGXDk5ScMUWx09peR0jddSOmsyHL
 6/ZxLCxWVdnf6adHKEUM1g9iNKut0+jdKHkamfR/9RKqW1dbtDV56cWo+OZK1UXenASr
 7s3A==
X-Gm-Message-State: APuU4Z/CmUqo0/qM+Y+SPx/G/19/rhmg8qK6t1Pfpno6O+bxwmPOEZCk
 2e6eK0bQgimLzp0W7LSzajUOEBGLOzzxJoYlPiG1hEKEYMfdWpaIGsMVxhv+1dCRGHoMEvgVIv0
 ExeYTSlawvQ==
X-Gm-Gg: AYBFou3KZnPt+dagDEVpNzom66WY1XHnr+wFVHah7ejngRDbbMONU55nNyB/gnJUgrG
 gF+enAVgcShUbt8lAAfPTjlEgy5H3Be5fiOvgJl1xOvhMUe6bVzK33Lh82ffKBdrtxCeiWGHPY0
 AogrOrI918Utb9Mw8HFIg4+ys0TohTnMq9bw5FiwPvycH/U80g6ZMm/RATtu7Yji7Zy8SZy9Iyt
 Cf6vX8D870O/2a7C27xewZ47Z8abKASJIqseu98IksjFWjHL7xb0b8e/ROqlCTnf9Q61nRncMe0
 mOjTJm/Nqf9SrWOSlZBU/xybqTpusNG9zAPxlnu9WRJKOcoirf1v5Y4jKlPyOZNuXcVmfiQOD2s
 iChmVkBIaT3wWSog11Qike7JaY1FkWAoJWVDIskghBzu0VAzU6t29GdmWfeMznsFT1FXTkLoR78
 A86XgpVwoUPKBFED2YVCCd1D8TFDS1tSBtLNS4YMYS0/jUNS274Vv+b0ej8xmqfsqPw/OGSHz9O
 pUexToAu+66ng3pmTzd4SWRleWIohcklkZXcHtunJnGwL4687aNFNf6gvSvn5+MEmgoKWtQUu2o
 cNxA9YwYZJn5FT/Kq3u3Z4cEPYO0gv5Ls0JtvNRvMOMdjwIHWMl+E1+f6B1PexgokUBW4ribJGo
 B0NIzX0wqkgT9bn9Ak7FddEziP8qu3VgD63P+vLHdqJM98QUvtzhPqoFQS1SXbfgR1gK4VAyliU
 PK3j9VZZEkeG8WG9MT9cgbPAZeuxDaOVcuIn7EwAbr4Q2dLMfzmcQ=
X-Received: by 2002:a05:6820:c7c6:b0:71a:fcbf:246b with SMTP id
 006d021491bc7-71b39035f74mr877956eaf.0.1795127200117; 
 Thu, 19 Nov 2026 14:26:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm649069a34.6.2026.11.19.14.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 14:26:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tomas Paukrt <tomaspaukrt@email.cz>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <x3.ZqLG.6UGBtjSAs8i.1gxhi5@seznam.cz>
References: <x3.ZqLG.6UGBtjSAs8i.1gxhi5@seznam.cz>
Subject: Re: [PATCH] test: lib: ecdsa: Do not report skipped hash
 algorithms as failures
Message-Id: <179512719931.764313.15131665734142140518.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:26:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 06:45:41 +0100, Tomas Paukrt wrote:

> The test vectors using a hash algorithm which is not enabled are
> meant to be skipped, but ut_reportf() reports a test failure, so
> lib_ecdsa fails e.g. on sandbox built without SHA1.
> 
> Print the message with printf() instead, so that only real
> verification failures are reported.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: lib: ecdsa: Do not report skipped hash algorithms as failures
      commit: 2fb43e7206353e3bff41b19130070c94f65b3a4f
-- 
Tom


