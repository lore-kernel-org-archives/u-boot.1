Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E3C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 17:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B2988089;
	Wed, 28 Feb 2024 18:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G4glxHF2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OjS8B6UD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BB188070; Wed, 28 Feb 2024 18:41:48 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A73788089
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 18:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TlM9Q12Kxz9t2Z;
 Wed, 28 Feb 2024 18:41:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709142106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=La1myNq4CanCCZ67Z99JcSL2hFs1DkG1L/lTkFdhuMw=;
 b=G4glxHF2AC+T8tQ2oevcQn7GT7fnysDiFFeMpg8Lk6h4QOgQjF1AZW7cHcyXof3IY1nIx2
 XaBKYgyP2mJDelYvZ1Ml4zp87thHbKZcTPF2uHAmsdcuQMgZY8jwWpWPz4OyZBLO1oeiYr
 AGHyJLOIujtqKLLc7DVqGSXNL4IzGNfgZ1m0BXHHk5wUsLdZItKu/zy8EckcmjyS4dcs5k
 dr+jitW+upEhpg6KwpWshP5DixyOdlrp6ssr3wbNj3gXpj/vRNww55TsYo9MPilHn2JQRV
 FYcSke2Y5uRKq2LnJQ6opZZC9dHbOlttwLhCJuvptP3N7YubT9jME0jTflFirQ==
Message-ID: <09733ae6-7f23-47a0-ad37-5d805d83db96@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709142104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=La1myNq4CanCCZ67Z99JcSL2hFs1DkG1L/lTkFdhuMw=;
 b=OjS8B6UDJEs78ZEqfp2UlpWLLTKCtZkUtWZnG7BAOI0VbOG8c4T2nbDTO30xZdT1LJsj78
 ehwAlR+LhKtnNC/6bOVH0GGSq16vC6ze24AWglYnsSf7Zo5HmkxXaE1BCUIXFp9Q8t7+4h
 94KHxBDNTe8joLLdEyTIIx1cW13gCtsiSvhU/TpEbGHv/aIJcJ+NuF8KG61s3JIe9z450S
 vqIks4En2MJxBM7rPqFx/uTE/48+ieWKPKqh03cmXTJV3RtKRNDDidrJySWehjkuov9oL8
 N6AUNEekOAufKc42WM1DoBhhgS8QwbE7yBoG794rMdItVTJhtGUIQXf/cORV9Q==
Date: Wed, 28 Feb 2024 18:41:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/8] board: rzg2l: Enable access to Renesas RAA215300
 PMIC
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
 <20240227204035.3761-6-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240227204035.3761-6-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 14e3d5571514dbfca1c
X-MBO-RS-META: dwh5n1fcrrubcdw3dd6u1x8u98unj7f3
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

On 2/27/24 9:40 PM, Paul Barker wrote:
> Enable the appropriate PMIC driver as well as the `pmic` command.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
