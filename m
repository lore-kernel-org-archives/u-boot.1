Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045DCC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 11:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC1388121;
	Fri,  1 Mar 2024 12:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oZ63jTRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9338812A; Fri,  1 Mar 2024 12:33:11 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A07188111
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 12:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so18769775e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 03:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709292787; x=1709897587; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nJgGot/IpNy0Eyjl8FX3h2kHXZ4Doht1po+ReCA2bZA=;
 b=oZ63jTRAXMiwEV1wmsPgl6f/qKuHad1ntALzi+h3oDoOWNcnLnFf1ClrhOABATl+Yq
 gkSQBSgnGtLPqgYnIo/SimYxGm/G0qStzkw0cWjzbmlU1eOxcmQ94QjVOCqKWqZs6DSq
 GaAoOcx0awfIfNDp2v7hSRmN8oEBiai03+6XyU+GmZQ4XQ7PmvQ3VNSfSsYvuc88oZBc
 Lar3KCl5ERz8DqMi6WNvnLB/d7u4+LVincpmZUakViKZhDoN0FD/LUQ+2ex3SDx5Yh5E
 aS9FNZnmhvdDQ14n+398dRjALk16Ct2eLIM1xDIqGaaQsomQakinkz6abL3b2gFtdhHw
 6QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709292787; x=1709897587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJgGot/IpNy0Eyjl8FX3h2kHXZ4Doht1po+ReCA2bZA=;
 b=XxBSLC5Xh2s6JjofdLj9EaSXfjLj+UFQ8Rg4h6nj3NzYE1O8pRre31lSy2bpb9760k
 U/16/yULopInE9MNwKS8OWXkxxrOYKi0ZSav2JaOvqExHQ3xUAlFXvvR3Wns35ywWktu
 N3mcCSVCLMLFAjKy5XJdDepcJhgBCJTS0ZssCvKN4GOLd/kca+YcqbdM9aO0x5qsrIay
 LnDVfduUGRxQsxxz8UzfYZYsVHCP8+gjchfKCFCB7rWFqW/HLOc9FBS5+DFr3Oc3eHGp
 +0e81tOwc6kU1PqypGnRjxcCyg79X87rcaaEYy74TUXcnh+NI0hzfA0Bu+vkEKgsQAlx
 2sbg==
X-Gm-Message-State: AOJu0YytqbzLuM9FYqS+4wxtA1qf2hSxe/pbhTPo5dXG2TTYQrKew3c4
 aphtAatvNwQhQh8hYHnPTSqeBzok4efXiNVBpgQJICjmpKZIb8dqEW6XCNn4Kvs=
X-Google-Smtp-Source: AGHT+IGv4/lmjNkh7mnJ+QWhQ1QT0Or9wduPS/EvMTKIjLJg0qb9fVPSojDIf9HBOr5/db2Pz9ACog==
X-Received: by 2002:a05:600c:1d23:b0:412:a3f2:d641 with SMTP id
 l35-20020a05600c1d2300b00412a3f2d641mr2011424wms.19.1709292786701; 
 Fri, 01 Mar 2024 03:33:06 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 jn3-20020a05600c6b0300b004128e903b2csm8085459wmb.39.2024.03.01.03.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 03:33:06 -0800 (PST)
Date: Fri, 1 Mar 2024 14:32:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, michal.simek@amd.com, git@amd.com,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [UBOOT PATCH v3] mtd: nand: arasan: Print warning for
 unsupported ecc modes
Message-ID: <8126f53a-b656-4cfb-9dab-d56e18735095@moroto.mountain>
References: <20240301111254.3588162-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301111254.3588162-1-venkatesh.abbarapu@amd.com>
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

On Fri, Mar 01, 2024 at 04:42:54PM +0530, Venkatesh Yadav Abbarapu wrote:
> @@ -1263,6 +1264,12 @@ static int arasan_probe(struct udevice *dev)
>  		goto fail;
>  	}
>  
> +	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
> +	if (strcmp(str, "hw")) {
> +		printf("%s ecc is not supported, switch to hw ecc\n", str);

I'm a newbie to device trees, but the two other callers assume that it's
possible for ofnode_read_string(nand->flash_node, "nand-ecc-mode") to
return NULL so probably we should add a NULL check here too.

	if (!str || strcmp(str, "hw") != 0) {

regards,
dan carpenter

