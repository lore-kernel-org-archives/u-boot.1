Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1113C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A0580F03;
	Wed, 23 Apr 2025 14:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jRxVGA3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE31C80F9C; Wed, 23 Apr 2025 14:32:37 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98E3809D4
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c5675dec99so607201685a.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745411554; x=1746016354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/7i9hPXeiuhvpDgaqy+amZ6GnoacnVbhAiRgfWOhhiA=;
 b=jRxVGA3BDmIweE/F+GJUuhaaWk21pzOOIRqNnZtdHBfZMMnwOTvHB8p+M/8A2qlZ7O
 VMbTuvflSdAv8Ajz+FKnIlBHwE2va4fjdvPOmArMvuClNVBz5ZRJ4e5FszNrR1I4C7Pn
 D69bGC12guVNA+fQv8lcCTE0so+UmbXRVWho53ZzWheNnJVeZbAZfdkfUZtd5HerxyP2
 14a3w3oakFFnbPayBvsl2KzLuc779veWY/d9uNjTEJdWU7+jBSI2p0coU0q6NLqM8WL/
 r/jsVyiUvhp3E7oOx8o4bJWfkdhIwCHNU3ywaHSJSqBZ/bpXQTrnpM9ag5if9+B/bOsb
 oikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411554; x=1746016354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/7i9hPXeiuhvpDgaqy+amZ6GnoacnVbhAiRgfWOhhiA=;
 b=t+pXHGYxjEzMA88atuJGncLHbqpa77Zzl9lkvOAWgVy39EHfKfqWcNcqZjEgmkT7jV
 DuhqL3k0A9ggy+iB7l4NppxnxiFLEDFDI3kZQUI6mFQgdUpto1PMhmWOc4ifxKKXpKZZ
 iKDSap6zbrN82Of1gzqDVl1EGNjYxrZRQR7X1KfUIrD5cQkolyE1hu5L5JjyHFK8eY1d
 S51A0hEEoBSCQ0ftss5yd3x0P0Dxd09NT043LIszB1Pr5DSUimjZ5v+r76e6gjNoQsW1
 DDrFUVaLVTKflxrUjp2E0mdeIJQsO9LxRwl78QfDZ699rEw6mMoWPtAy2PBv6WH4vKmY
 PEMg==
X-Gm-Message-State: AOJu0Ywk2dpJ+wkq9P5Pix0vX8lYLL2HC7cmRNxoaQvxUh6ykcLB9WK3
 MQZQhFRpAA1fyTEUSH1S6NESXyWEMZK4Lle7OY5Rydy/tSURgiDXsiPC9pQDbAbTZxGHLt+uPNn
 fE4dO/zDmlNFfntHMTJd5W3LUtRhKAMv7Ztl07gbl6zO1zMhatLE=
X-Gm-Gg: ASbGncuO/3TSJ+CckY3+bim/9OctmWCXzxRKL0HXSNcdre/6ldrvGZgwi4+mEYumq+l
 aHcDhM/bonC3W/bX5Y/BXZCohQnzfQvClqHVqaxYkZOdQ6FvTYreeRcp8J1gL5Dqu+en9ddIq6g
 dZ63blyi7hOXPQju67YjBE0qHFFCo+anTvfw==
X-Google-Smtp-Source: AGHT+IEmKH/Rdowzp2O3DqAfkvkhjUWPAKLSOO1KQ3Mf2XM226elQieOsPwAMutSYJSiB+AGJIBd6qZGymsTtm53YXc=
X-Received: by 2002:a05:620a:1a07:b0:7c5:5a51:d2d1 with SMTP id
 af79cd13be357-7c928065377mr3115030485a.55.1745411554403; Wed, 23 Apr 2025
 05:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250319112003.594938-1-sughosh.ganu@linaro.org>
In-Reply-To: <20250319112003.594938-1-sughosh.ganu@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 23 Apr 2025 18:02:23 +0530
X-Gm-Features: ATxdqUFjxt1JhTuG5D3U_Gf-ZvD3JAcumLn4yYwoPw8pfQGdvBghXazy9aYQPcE
Message-ID: <CADg8p95jRsvApDUTpBCMZYzkgO3cW_mz16rRz7-VWKCn1=7rbA@mail.gmail.com>
Subject: Re: [PATCH] cmd: cls: do not repeat clearing of console
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
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

On Wed, 19 Mar 2025 at 16:50, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> There is no need to repeat the command to clear the console. Remove
> it's repeat attribute.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

Can this be merged if there is no objection to the change? Thanks.

-sughosh

>  cmd/cls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/cls.c b/cmd/cls.c
> index 4bee8a18305..b1e0619334b 100644
> --- a/cmd/cls.c
> +++ b/cmd/cls.c
> @@ -18,4 +18,4 @@ static int do_video_clear(struct cmd_tbl *cmdtp, int flag, int argc,
>         return CMD_RET_SUCCESS;
>  }
>
> -U_BOOT_CMD(cls,        1, 1, do_video_clear, "clear screen", "");
> +U_BOOT_CMD(cls,        1, 0, do_video_clear, "clear screen", "");
> --
> 2.34.1
>
