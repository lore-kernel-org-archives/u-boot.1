Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749E7CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3476480D1F;
	Wed,  7 Oct 2026 16:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fH7KNockeISu; Wed,  7 Oct 2026 16:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3973380E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389251;
	b=jBjKzKW9awMroBB+s4eT78PtYEfyUzgJgE2eP+DaA0kjP9I643fdiYySVtaNg9BTD+cH
	 gXYorc5A+eB0tHX/Ui7OaHM3fp2ey8z2npp+OOhVQ54/2Ss6mPFG87Z7tN/fQB8n+eIMN
	 a+ZpU1gLUJ04jFV/xpG1sSIhbLl0164cWpHy3SEpZpmXo6MruZnbBHgYkcQ62967j7aXi
	 bMCseHf5X5Y0DJgaJAsrJWEgrw475zyc7Ug09uLqnChY26wkZLUekMd7e2gSlJmeHojPu
	 lA9Af3F1bPRbgfpGv0/buf4C3teFk+/L4E5eIHMv91YTzfNiiizAI5GGY2v3xB5WHOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vT9CLDBrUxEypFuVr7QOyCBkIYtrvKGtSei4bgqXytg=;
	b=e+zb0jfYQ2aVNkItLMutSt6ED+IFvkR3chV1RXjcq7U6X6eXtf+ouw2qbFRvfeGiwDQJ
	 gnkXvwv5kEv2USWFRY10SgvhrKClJlBdN3ey8jArZ2+9bsR4DWTHG5iAxWHKjpVAJj37V
	 Pmj514dwe6WulPRus2eIEz3zcpQHnZN2JZ/wQnLQMUa7fIWCcFxdS/j8lYgFDoYW44ohr
	 /K2ybnzkk0gYgPq5qWlL4VqNIs2ynK9b1sf2K0QacpReXYjpV/U6MIOBGJY5B9InlsQmI
	 XYouwfM0Q20JRDVLWdXwxTEWFRzx8vICv58jt0arUvV3kZi4smmzgNSipWd9Xxm1/lQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389251;
	bh=vT9CLDBrUxEypFuVr7QOyCBkIYtrvKGtSei4bgqXytg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rV++kbR8hKB8JLFKK8ksuOVHLCp/VhCn4WJ5ATb8PH2sWN1WNHcoQxlL/+3LfFpWR
	 RoxZgXU7c85vFuM9ANnEQ4SPmq6mCAmAHyl7ixXCVsJ7PFv4T63PvNORf56U4vGXze
	 IrYtUv2i0nIG6zyedVoKc2V+/ujzXxAAXv7nIR2FIpqap3/SQprQZiVaMHK27nF5Qt
	 OYzIX0HFXZExq2GcvmAlaMJdRpk1C3xto5voU3U56I0lmyrMQAW0CL9FTsrmnidSI1
	 yARJVMymvoYEhL6Xti8LAATdrXB9mOeu0kDfnbZIzh3BFWWjmYiBKIhOs/8IHa9Yd4
	 r8GTumOsAXknA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3973380E9C;
	Wed,  7 Oct 2026 16:07:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A38335
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1544C4021E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-sx0ichXhsK for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:49:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C070400B8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384547;
 b=k6xMMgkrkIDNl+/LVFP/Dl0HBSu6Jjp68X9I+4kvbRScSuLOHDK2NKGgW+nBKBvtlm5j
 dYY24quX5dYR9OzggxP2w0OhdT5G9OLAv1+osIdvtoNOtE7Ine7e//ekkcqm5QvVWaAuV
 itVJ2Rcl3YRSBV8TQo27WfJUTz9gNTDWBAhX3QlL4sSbtVd2qdgnkwy2Kvou3myFoKGh0
 Btyg5BWyRQ76fwr83BOnvrZHCf6v26vC5HZzEZNLWLUI+n+xyESOlVFGAWm8why90t60Q
 l44UOJdczIla0lE3QAbHCFGDIf/JXnvRwAcUALPh27AauuRJWlp8ShVs4mv3VFHb56w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384547;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=vT9CLDBrUxEypFuVr7QOyCBkIYtrvKGtSei4bgqXytg=;
 b=ZL2UBtDJkZBYJ/8f0mxrhlXcVOk7zsxkmg6XJS2GF9jvu4cP1xFnAw26QXLYBg/fWtgR
 8Fisqvpxiwz3XlxourqCNqWWjTXehm0yHRfmzj5Qx0TNVCxleO1Ger6u66EG12VjHYUgC
 vQiWX/oaDPScm5eN7yMn0mSbPD6GlaVMooHVIPJpcdcpGCdBwIN8wvhTwAKzhCgNkgOxD
 w3x4ce5u+qijp60KnKfR5RvfJaNNVp8KBmKAPcMANpRh6WrttcuaPsU6X2Qo1OtSeP2Gw
 AkAOtRKIGZzggFWeP1I1utkUMofWaMfoMWtayBZw9gzc85WE98GX5Ded9qeeGuj/KUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a2VTJBUW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a2VTJBUW
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C070400B8
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:49:06 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso1081389a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791384545; x=1791989345;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vT9CLDBrUxEypFuVr7QOyCBkIYtrvKGtSei4bgqXytg=;
 b=a2VTJBUWmhAbjc00++MtZhaOJeDBxYHpNKxGWtjmgswmoBzfQvKfUMZTI3JednfKYv
 I4QACKvTgfrb4cMOUZ6Rb0TjJi1nt8DPE7tRnYrzgP62rVJCfHJ9PkADc8oXngBAIjxG
 X/S51jmtOJA5BS8Veuxof0dhqUGAPPKc4ifYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384545; x=1791989345;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vT9CLDBrUxEypFuVr7QOyCBkIYtrvKGtSei4bgqXytg=;
 b=VMLr0au0TidZJ9l2QGM8QqD4nvtdr5VRwGHC/yWcY2mbT/3XE4o/qerByXYHfMEXGW
 ssrx51yzggT/PJ/uKFlo91yiav9C6ZZPh/SGr4n7LudPDsxN42BdhJrBo47A9m6/bmSy
 8yofpVt/m7iAo4xWZAarQWvDj2FFJ737VFXY3fJY6gfVc/NcE9WA1vJRlvc2NJzH2G8z
 CyiZ6pTzOrn8Id0Tzki8a3egemfqVeRtqTHx+pRuz6DlNC+ZmShwzp7Pkq0L7Kwp7ctA
 tdvjMDqvisLZqP9zQ/W9g3IfA83ybh1oqQFwl0RQqvf1v7qF5HoT4WRfuURlfx7D5wCD
 wFqQ==
X-Gm-Message-State: AFuF++lD2q2RJmLawg2dHZI7pes92XLTBiJbOjA4Lg+gj7ReytA5nefR
 pTsqgtWPNLeosG9zNEYkXPg8GrQn+uE7bjgWvCHb9His0VlFxsH6KMx/LcRcSbCGQSls4E7bW+2
 EbkSyTwItc60SZe0=
X-Gm-Gg: AYBFou0f3HDekqc/ga4Aka7nOxOaVfJBgR2RZx0lQTWyxfslsoDFcclTBfUlt63DOrr
 fwz76M58gcH2VyruEjjkvbQBDT4EYJZ40GmscOv/4DKLh1rR4fcWmQFcwH/XiTPbEsn+hrzuVpb
 +Po6B1Ma4fK3X8MbN9eVc4wLha2tmQJHCln1rq6pULlIDKrMuATk7P9CPAkS8Ghd1eJLLX7hbI4
 o4+eiclHEb7GV1DTj9CtalDwIXt67moe3KNRq9YXOLM+LVBtWVTXuUOuQ1STx5C/wGzhDOyAcAJ
 Ej0F2GS62b/48u8YfaUisTSB5d14G9RZj0RFSoBZsOncqPijhDC1V8XjzkX9ZvLd+CxYjWnW5lW
 +ZBIRxi4nxoBA7M5OLnElfYqPr16bdunTwybhG5a4O1lQx6qLJfZ8DbnW/MoC/Wj+tCNH3yS3r8
 MMk1whC12JCZFzK/DAkHbZhBvYvHNo07GyGWeIpyfWW51dK8st+L6Vrnsu/ERqtTij9MR1sqoj/
 /9gnh8pObBojlMIXZmqxFa3r2KKZM0jcEFM4404koJ3LEFF73q4eqsPPQ7v9MiSKHkMhyjXVV59
 ZL095G75299roz2+lw==
X-Received: by 2002:a05:6830:7004:b0:805:6a93:d9ba with SMTP id
 46e09a7af769-82acfbb6cddmr3526248a34.15.1791384545209; 
 Wed, 07 Oct 2026 07:49:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82adbdf42a1sm3151871a34.9.2026.10.07.07.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:49:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Anton Ivanov <anton@binarly.io>
In-Reply-To: <20260922123630.608961-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] tools: mkimage: support shared image data
 through the image-data property
Message-Id: <179138454393.3115289.216832496680065392.b4-ty@konsulko.com>
Date: Wed, 07 Oct 2026 08:49:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 22 Sep 2026 12:36:20 +0000, Aristo Chen wrote:

> Link to v1:
> https://lore.kernel.org/u-boot/20260912124454.13578-1-aristo.chen@canonical.com/
> 
> Changes in v2 (from Simon's review of v1, plus one cleanup noticed while
> addressing it):
> 
> - new patch 1: drop the duplicate FIT_ALGO_PROP definition in the
>   cipher node block of include/image.h, noticed while adding the cipher
>   property defines requested in review.
> - patch 2 (was 1): add FIT_IV_HINT and FIT_IV_PROP to include/image.h
>   and use them in fit_image_setup_cipher(). Non-functional cleanup, so
>   the Reviewed-by is kept.
> - patch 3 (was 2): fit_resolve_image_data() skips its own pack and
>   rewrite when re-processing a FIT that needs nothing resolved, while
>   still validating every reference; reject image-data combined with a
>   complete external data reference before the import when compiling a
>   source file, where the combination cannot be legitimate, while
>   re-processing keeps import-then-compare for the resolved form;
>   complete the kernel-doc of the three new helpers, with the cipher
>   check describing the source-file and re-processed cases separately;
>   explain in the kernel-doc and at the remaining check why it runs
>   after the import; add FIT_DATA_SIZE_UNCIPHERED_PROP and use the
>   property defines.
> - patch 5 (was 4): the commit message now states that it completes the
>   validation for the new property rather than fixing a pre-existing
>   problem, and the kernel-doc of fit_image_effective_data() gains its
>   parameter and return descriptions. Comment-only, so the Reviewed-by
>   is kept; still a separate patch to stay reviewable on its own.
> - patch 6: new, user documentation with a worked example under
>   doc/usage/fit/.
> - patch 7 (was 5): two cases for the complete offset and position forms
>   of the mixing check; the Reviewed-by is dropped because of the added
>   cases.
> - patch 4 (was 3): unchanged.
> 
> [...]

Applied to u-boot/main, thanks!

[1/7] include: image: drop the duplicate FIT_ALGO_PROP definition
      commit: 15b4b73766f9eb9c42e67c81b6585cf68e4699e5
[2/7] tools: mkimage: use an explicit iv from the cipher node when encrypting
      commit: d0215d8718dab91a964d3989f143156f121211c5
[3/7] tools: mkimage: resolve image-data references between FIT images
      commit: 195f273b6c86a42af6bca8c830f9ac0c9bb920dd
[4/7] tools: mkimage: share the external-data region between image-data images
      commit: 4436d98341a6a8862ac73e121cd56b7031b38030
[5/7] tools: mkimage: include image-data sharers in the load overlap check
      commit: d510292811e352f21ec358647305fabc53d14e06
[6/7] doc: fit: document shared image data through the image-data property
      commit: 3272136ca701ac37402df2d34e6093cb53a9a6ba
[7/7] test: py: add tests for the FIT image-data property
      commit: baf80458c7fe3d3bf67cd6d3ec11800bbe4003be
-- 
Tom


