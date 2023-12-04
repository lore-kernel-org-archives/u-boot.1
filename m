Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6BAC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D64878BF;
	Mon,  4 Dec 2023 09:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tGGXm6Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427518788D; Mon,  4 Dec 2023 09:28:19 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D9687916
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9eca5bbaeso20673051fa.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701678496; x=1702283296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EhCG3cPSruJMeImpnZtSgGsHaInvHLr90LkMwdZYzU4=;
 b=tGGXm6Mj/f3eod4N1rPxOzSp09K6avxmF8YbpiFt/kBIJCmBBUlYzholutOvAZCOy6
 8YF8Wrmgj1mWEb6Ag5GWtcg87mbi1fPErh0Y/4ZIL0PWAnqNV/TZKBYWAsofmBdsURKJ
 +mb/7Q9gi1T/W0bqtpbqNOBE6pJmcrvlhs/flWRxMEn9v44vv+OOjQXJRDneFOR/uF47
 mEJmDZ6jSLf5dOnFlcjJUY/Nei1AiNYCV5M+5HrJ2Swm5X2++3EMY9+HdgN9mtRSK/nf
 5qQl43pXrhKCuJMkdhLr119fU5qbddaJ8ms+f9syDgdZhj1A5iU/VVUJdcolK245BTRP
 lBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678496; x=1702283296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EhCG3cPSruJMeImpnZtSgGsHaInvHLr90LkMwdZYzU4=;
 b=BJA6Y84Rl5+Ti28mjpAPkswsQX+x8/car8DUGy4SJow0ChrxMIfNPae/aKa1eaoBIM
 uZJXHqb0cNHpKY/Qsevgb4IVv4z/1EGv46tFGrGb1uhn7FryxlwNLkMT4ZiltF3YGe8C
 in6czHm+ahAoyF7T86PURPwHu7htsRVQsD0WnTvwVwdYVlSdwOazc3dCJKCxvHK1/I6R
 ERYF6IPETpApWxFGuPXFlDa/ucLb6PNrlLaSRtiY0pqJ2C9vQM0JBuCGvWbtL4X7qqFg
 6Xjza4ycswfv5xiJqcUv2gLgGHGoVidxEWfw9FTKUv6i5a8gCkb0BBnNV2Kq9K55Q64S
 XUEA==
X-Gm-Message-State: AOJu0YypEkpTYE+4r16JesL/oUkGSB336v7BFy8YusB23qMBqaDPj2oU
 M5T7Arb8p1jKYpmf0JK8omgJsW/WD/irmoHffiKWMw==
X-Google-Smtp-Source: AGHT+IG4bowyaTeKGRLbGFJ8kB4o6KzY5L8w9HAE4lrZ8lgaFFhCJglpPxKP33BypqXlJ7KE2x+SRsNmjRLptUIq66k=
X-Received: by 2002:a2e:9cc3:0:b0:2c9:dae6:4433 with SMTP id
 g3-20020a2e9cc3000000b002c9dae64433mr934825ljj.181.1701678496326; Mon, 04 Dec
 2023 00:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-5-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 10:27:40 +0200
Message-ID: <CAC_iWjK4=zZqo6eKu-jjbr=soMKq3yQyKFG3wcy0UZ-TuwJDGQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] bloblist: Set version to 1
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 27 Nov 2023 at 21:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The new bloblist for v0.9 has version 1 so update this value.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the bloblist alignment to align to FW handoff spec v0.9.
>
>  include/bloblist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 30441f922b..d70a7bad2e 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -74,7 +74,7 @@
>  #include <mapmem.h>
>
>  enum {
> -       BLOBLIST_VERSION        = 0,
> +       BLOBLIST_VERSION        = 1,
>         BLOBLIST_MAGIC          = 0x6ed0ff,
>
>         BLOBLIST_ALIGN_LOG2     = 3,
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
