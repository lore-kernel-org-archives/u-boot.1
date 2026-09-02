Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305D8C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1CEB80F71;
	Wed,  2 Sep 2026 13:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPe6AYbgatLo; Wed,  2 Sep 2026 13:24:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788355487;
	bh=4APs6BojQUJr2sybFiShA+bJ4E0aC63bq8h9XHWOJRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8u84ZzyBhAYxn9EXzvmwHzqDMv7HlgVqudX2LS7WGlcjcn5L7yNPyvrStqY9v7dL
	 lmqQTGmAaFGIgY0jM/9YB16nox2nnXjHwOG5YDJ7G4dD1CMxbxzhVhUSdkTUYU6g/x
	 Hr5SBjoXTZy21zY9XGo+dAdYoYODLJnTOi/9ikiF7kRdxX9xDWLlWYE7iDhYB1iKhW
	 ZAuIV071ce81E/cfnELmitcTncBIdM8hEDQfYiRQkpFZyNCxXDnZAPt5E4FlEY92F3
	 O3I37sXDSCdh55LcjI+jk0xBLSofcoJkGWeEj6idKQBwq5sAyWMXon6tNvX6hr2E6t
	 +ncWUGVTkDWQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20BA880BB3;
	Wed,  2 Sep 2026 13:24:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F722127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CFB940A49
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1cyA2b2GnFKM for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:24:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XDIYqWLy
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D5734086E
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:24:43 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so192992766b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788355482; x=1788960282;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4APs6BojQUJr2sybFiShA+bJ4E0aC63bq8h9XHWOJRw=;
 b=XDIYqWLyWsviEdnU6+epnqPeL/76xDsm3y+Ysv+YE+udyys2EiESoYWPj4mxfrV73A
 g/pXHKH+xlaOhX3TozMwLEIOM3xw0uBo0ImkL5IB3iWjM8JB546WLq7iLiRSpG2l/xvK
 KO4oqsebB6natKAnATk2ex/DDPMcjKMledP8ye7qkP+2DMrelmqQjqvO0BnYekR5qEOn
 BBmTDuWEnl3O/UebIpzMyzUcZKqOtiqgtKKAZV0vp/h0rIzB1JqLDOibwCkQhiMQ0jWF
 50jJ2s7fhwuT2AM5om3mn1wSEvFL1UA/91Pjk7HKRc2M8cr1Iu7eO9ZZuEj5dzUjJLZ8
 mlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788355482; x=1788960282;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4APs6BojQUJr2sybFiShA+bJ4E0aC63bq8h9XHWOJRw=;
 b=K7f7Ko3Xu+fVlCYIn8fYgaEf7TaPa61sbmtpuVUHiDke2UZJWPy4PP3ZV1ZEQJ73hY
 4h48rfDdTuqaRqXepNbPpd9TInx0hwwgzqkMQ7BFDOcjb39193JhvkLVM7syGOaES0iI
 ZBKOsm0i/Cl98mUtfQMda9+5kqShVj+flP1eLLqFkFCK//PbozQSHAd62LIgM+OV1hNj
 CcxXdxskxdxDyFsLpCSFVFqRhB+KcGRYQClrSbbnfXAChTDqNCKCFF8XFr1n1WnzNm70
 f0U14GdCoHCwfmfG4WygiZnHs9cmDw4NJ6k1d3Z6wlz2N/bty9h+yIwiyPF4EikS1FCc
 RcDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjYz8lvFuPN4oGpYUS81NtVddxFTYnsmiFKB64ZvbYvT7/JS6BOUI5LQ384MORMHhKkMuPYYE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mtEP6lc2w8/SLjuGm6dvOvwUPKynCBM526DjbnyczG/B/UVWAj
 ILuKjyEHH8ClV7OMTTi2ye2sC7QFWOGTKBC/9akc1MNbUVj7rPY6pMYCebJV7Ak9b/c=
X-Gm-Gg: AYBFou3yhAaa+dPRfZKxbsRFc1btDDy6KaFh982OmmnSyJkQG5JcaFOasYA7EPWcl/Y
 Q5BaFVS7/nh9hFyERYsNUtOZByR2g0MZSUeXnlQDna6qp2adupU7uo/6TmWFlX3T2JtVe+md5Uf
 cyqBEeAD5WEi823Op5klleFnqmrtKtvnyO0n83AiKt5VUGI8Ib9LIrGYtGpWX4dwel2lGV9FELq
 1lJ8kvJYW2vhRxUY0fRA8lWgIU1MKSbbmeu6hYZ7OP8QajnOCOPDajB8Ieuz1Ayn2kYK/YeYVCQ
 udvsBoido9JLI+QwuxxuWiuu0tcj8zvX0zI/vdASx1NyP1GyDByQqMjL1AS3FzttUWhWD37h4Fz
 FmWnZ/5sIohDlk49M6A/qMqVJuRqTRLMkNyO1Vm5hIJK6Mhef0vM+VtBcr8T+dCOb8rqKgrCXuw
 EgNC8fuQTR3u1VrMxc6zlCXJWWOjg5BpOK6wktzQPknbIKKW+sxyo8nRcb5z4LYceiA/2d3bbKr
 8lZ3RJK4T3qhwbaRO6ShikxCog5JlC084yiSo238gr1H0Xd6n7sFbRosGeGsDz6QH8nwLyKZSZi
 a2Tf
X-Received: by 2002:a17:906:730e:b0:c25:c678:ff80 with SMTP id
 a640c23a62f3a-c25dc9c1306mr229344466b.2.1788355481865; 
 Wed, 02 Sep 2026 06:24:41 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d04152aesm131640566b.52.2026.09.02.06.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:24:40 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:24:38 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>, 
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] video: pwm_backlight: support num-interpolated-steps
Message-ID: <apgjdbRX1jxg5Ng6@macbook.homenet.telecomitalia.it>
References: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
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

On Fri, Aug 14, 2026 at 14:15:45 +0100, David Lechner wrote:
> Add support for the num-interpolated-steps devicetree property to the
> pwm_backlight driver. This is used in cases where there are many points
> and we don't want to list them all in brightness-levels.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
