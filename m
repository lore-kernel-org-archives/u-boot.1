Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D24ECD8C90
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 04:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D921E84841;
	Wed, 10 Jun 2026 06:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AxE6jeWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8953E807C4; Wed, 10 Jun 2026 06:00:49 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6837846A7
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZsWd6dJtz9trf;
 Wed, 10 Jun 2026 06:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781064046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seF/UL17SGrMTTsOL3MBxgyL1/VMOXUDqxFRyGyGRuI=;
 b=AxE6jeWcuqn3XQO7d4rHU/g/iSZJlkvfpLSPPlVtjhCT57TjU4ttg4H4DQ6/c+iB1mDdVN
 008UHZpUmVq9kEPpe9urJB2eCXK9xb4JEbX/jMigM/PLgckPLX9f6LIC3p0xY76Ub7sJUu
 zOlh68cwQkrZroxVGrxtXeEqA0VnUzVAYUgLTgXt+gKUzrvlY94LheoVNAf7SSaL7jQkNp
 NZjFSDfKDjrfNI6KjydAc7GwKBZ+lQQrIG4fVHh5HhjjDMXnZNqEk7hU2XXnTAe90E+rx+
 HXrrb09IPBHeXRwmn+mfV79j+dCWBwNCB5Onlx3hy7L+Zv9LxmXSFzY8ZoouVw==
Message-ID: <1aa19619-ed5e-4e5a-9f6d-56b5a7824a0a@mailbox.org>
Date: Wed, 10 Jun 2026 02:58:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 6/7] configs: Enable RELOC_ADDR_TOP on arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: jonas@kwiboo.se, anshuld@ti.com, sjg@chromium.org,
 christophe.leroy@csgroup.eu, u-boot@lists.denx.de
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
 <20260609131611.46399-7-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260609131611.46399-7-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: anfziycc8c93fnjcubai5i6tbrr8baie
X-MBO-RS-ID: a639d73f53c67a02999
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

On 6/9/26 3:15 PM, Ilias Apalodimas wrote:
> Since we added an option for relocating U-Boot to the last memory bank,
> enable it for QEMU to get some coverage
Subject should contain at least a mention of "qemu" , otherwise it is 
very confusing.
