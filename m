Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCABBD6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A9989696;
	Fri, 15 Nov 2024 05:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZID2T4cM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F5E896B6; Fri, 15 Nov 2024 05:27:43 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5985C89689
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4609beb631aso10019851cf.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644860; x=1732249660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiRA7oGGgEIAP5M/eDtFFc90seOkMx7MdAE8UDcJc5k=;
 b=ZID2T4cM/9yKJi2MZj1YAn3DSo6qArwWR60JYVVQAnsGGPtwJNyQBV4Se5h5nslsqq
 wBq2jOfbOj392QaBapYfL5KRo07ABKdGovCh0pvjh7tM/47bpGkj3S3EsvEM+VxUZ9wh
 Xdbwv6k9cnMGA5SIhtJK+z6U25dgmZugj89Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644860; x=1732249660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiRA7oGGgEIAP5M/eDtFFc90seOkMx7MdAE8UDcJc5k=;
 b=Ted2WEmAnDgWGOJBv3YB58ZJeHVqLdkItVFGTRel5AHLJISFY68D+NFP/n8rMEe3jF
 XLKI2s+0azgPmnL/ok7fegjYQBZe7OnjgU1cH1Ll5cN8OO0v71loCNn7pum8XoKbCgPV
 Z6ojqYpb2pCwW3rXfJQNm9CnBqzFj4kL64PuMv8efqoXFYuaBH+fTszb8evQ6NxAHZjt
 PeJGt0dq6i3826YeEPwPkH8NGvSiIzQhWOW9lEtNdBKMoH7wvEjLunF6DFqhQTviSBjI
 p7bVbd7wmfDMPVd4sCgF7nS5a1mmv0/PM1NT6anQgpEpiwzj3IZygZwTUt22ocG09Lut
 ksEw==
X-Gm-Message-State: AOJu0YxjS3e/sydBLzmHSWfoawNx5jGBoiFGxPoh+R9j6BIYbHnKilxq
 0z2BiYqZwIGXPMUpHthzYq1wrrfPvZxOxXzzT+GMSsscf79iudnlzY5IBaK1f8M=
X-Google-Smtp-Source: AGHT+IFXmZ3kvbA6PXNtTh45QfH8gCazNTJtiM4R6fkOk5a7vYbuQ95USqeJZ2Ybz07VjcW5GR8sEg==
X-Received: by 2002:a05:622a:191e:b0:460:e9d3:e989 with SMTP id
 d75a77b69052e-46363de85b1mr16778411cf.8.1731644860287; 
 Thu, 14 Nov 2024 20:27:40 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: u-boot@lists.denx.de, csokas.bence@prolan.hu
In-Reply-To: <20241031091531.761977-1-loic.poulain@linaro.org>
References: <20241031091531.761977-1-loic.poulain@linaro.org>
Subject: Re: [PATCH] lib: rsa: Set conventional salt length RSA-PSS parameter
Message-Id: <173164485830.1205089.7766535353522969374.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 31 Oct 2024 10:15:31 +0100, Loic Poulain wrote:

> RFC 3447 says that Typical salt length are either 0 or the length
> of the output of the digest algorithm, RFC 4055 also recommends
> hash value length as the salt length. Moreover, By convention,
> most of the signing infrastructures/libraries use the length of
> the digest algorithm (such as google cloud kms:
>                       https://cloud.google.com/kms/docs/algorithms).
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


