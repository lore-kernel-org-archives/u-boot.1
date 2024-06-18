Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2665C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 06:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2BC883DA;
	Tue, 18 Jun 2024 08:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5XxdvNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E43D883C2; Tue, 18 Jun 2024 08:41:47 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330B187F5C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-421d32fda86so54099235e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718692905; x=1719297705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hjhLMzTLsZyC5AOHWdmSp7e+rFg7WCkxZNjf0rg09DY=;
 b=E5XxdvNi75Y2N6tGI3tqpaYHRd4ckiT0g58Bbp4t7Frsh8ZegiqlXYQye8Tv86z8gD
 Bvhusdyi6F+D0tGc9WQqMKZLA/T9yZniDi3BWz0OiAZDV3fWSputgLk+WlpXHPz7xWNl
 nAtZBUtQvaMO4REX/EWf8wUhjyUEvcvwA6N96GboFwlZz6DUgltrootevuDdSHl1Ujm5
 uhfnwKEsOELTQLU66YyRbmFUWsC4hL59f42J4BWmq4eUXQ6rgqAdX83JPROPuv0i72JQ
 YBuJ/38+FHxv7zPi6xY5t+7K7llQpmojIPyciRdI1k7l2kzNUuKYHSfTI2EaVBvrBSZ5
 Z/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718692905; x=1719297705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjhLMzTLsZyC5AOHWdmSp7e+rFg7WCkxZNjf0rg09DY=;
 b=CgtHqt1Y3UhE/w5LyjKRzsYECMkfx9SkIkIl6lsDO2zwaWPlHGvPiB8E4soDHvk6JJ
 hWzvPJq8XoK8xk8p/jXO/ykVMOsjqbaqH8YtrGjwDx9KO54NixbMX23A0fME5zTqNhk8
 JrKvaK14qQRUqSQwFzV3wHrxlkcC+ZPEdrJjYCCAE8AsCZbFZ97W8cnNUBnAASFbtpAG
 E8mx41Bvhs0txvpUXCrECCnQkJOulK0G5rIx4w3Jir6g1jk6tTG72QglDjUDZ7gHCGov
 Yiwbxb0O6dnbDsXW33TqXimwNpEHcP8c8MZIbyXN7c1vTAkDUidPT/2T5x9Nsr9X+yUH
 wGHw==
X-Gm-Message-State: AOJu0YyYQAkqH+z+Od/NgcNTWVdaqD+pyplwz4pFv625HdqQx3twPkqu
 XvI+tNaqneFMI1dEyi99LML/PCQVw+vIi/ouaoAfBcHUC3yoeWQmjviAOJRyaU4=
X-Google-Smtp-Source: AGHT+IHvHWQfwaRBEke1qAKNFh2hIpH7TG/MeNOD3KCNqDbZeyCGFXF7rFT4EentVnyb89plwd8/jQ==
X-Received: by 2002:a5d:4bd0:0:b0:360:712e:3610 with SMTP id
 ffacd0b85a97d-3607a7687ccmr9956903f8f.38.1718692904516; 
 Mon, 17 Jun 2024 23:41:44 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750acd7csm13458244f8f.52.2024.06.17.23.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 23:41:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:41:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
Message-ID: <5898a17d-8fcf-47ae-bdb2-c647eca9997d@moroto.mountain>
References: <20240617194947.1928008-1-alexthreed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>
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

On Mon, Jun 17, 2024 at 10:49:47PM +0300, Alex Shumsky wrote:
> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>

Could you add a Fixes tag?

regards,
dan carpenter

