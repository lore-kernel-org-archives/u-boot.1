Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97506CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 08:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613A4849BB;
	Wed, 24 Jun 2026 10:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SYZWgiuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CECF849C5; Wed, 24 Jun 2026 10:31:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D0C6984995
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 647431756;
 Wed, 24 Jun 2026 01:30:52 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.Arm.com [10.34.111.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF0A3F62B;
 Wed, 24 Jun 2026 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782289857; bh=SSRZ6LmONsb7mpizn9R76Aj9AcDyVUNeSSz7/NBq9Fw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SYZWgiuRSM87f3QN+tddHNuDSkys4V4o89bXS9SFbBbylr70Cw8vPo5Hjwc8edLh1
 +ZhHzXG2OR97ZhLSqOCFItXagXNpNXA5dhgPysh0UqtKVqnHHrFH//rqPeY+RXnUyp
 1Xmol7yrxs3429kpp6N1SjM7ULBq6n+a+dSPBMqQ=
Date: Wed, 24 Jun 2026 10:30:53 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] lib/efi_selftest: test block io revision
Message-ID: <ajuVvZ9-tUWbOrh3@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
 <20260609-rev-v1-2-0ccae5bf0fc5@arm.com>
 <95af39e2-2f7a-4886-b0dc-2aded14b46c3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95af39e2-2f7a-4886-b0dc-2aded14b46c3@gmx.de>
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

Hi Heinrich,

Thank you for your review.
I agree with your two remarks and I will send a v2.

Best regards,
Vincent.
