Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F84CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71EDC808AF;
	Tue,  4 Nov 2025 12:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oFAmHvAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7BB8144A; Tue,  4 Nov 2025 12:56:45 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135558003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d16PP15V3z9tnR;
 Tue,  4 Nov 2025 12:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762257401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1jqJUFUGbuj4IqUMta/z4DTnDENkw6TL0GgxQzLLmQ=;
 b=oFAmHvAS4OmWTWW5jbPSnUn1JmwB023wysI+P69TUcI+DIoN0ugaU3B8eFtsBklQFXdAbp
 bLPP4x7uvOa0So4x7765S0kxSNibKWKKb2dMuEDqTe+q0S6f9+uWHRd4tzUM4Eyk4wt7/h
 RjAOhFwRXqaBqhUjCSzVUs7syeRWdCvPDAUWkHVw8ybZzjzOoJNyU4FLmuYOD8kggI4emN
 iNdwJzLGPdp6WVFw+7kcKh7YmvB77481t31mIieeivqvmC3c3yBE7Pg8BpjjFlHTkbIAAF
 2Rxz6l9FO8sDDQXxXpYC978SkORexIA2TYfvdNxiwetzUMM/fj8Jmo7RqlpQmA==
Message-ID: <74d44015-7482-40e5-a1ee-d0a1cb5725d6@mailbox.org>
Date: Tue, 4 Nov 2025 12:56:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] Harmonize image size checks
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
References: <20251015012320.2331007-1-pro@denx.de>
 <aQnjbE0nAG7AFJlG@aristophanes>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aQnjbE0nAG7AFJlG@aristophanes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: btg7dsk9yrk6rimhmyahghzms34ta4nj
X-MBO-RS-ID: 8c7e20970ac72fdd670
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

On 11/4/25 12:28 PM, Philip Oberfichtner wrote:
> 
> On Wed, Oct 15, 2025 at 03:23:17AM +0200, Philip Oberfichtner wrote:
>> This patch series aims at harmonizing image size checks, which are
>> currently represented by the following Kconfig symbols:
> 
> Hi Tom, Marek,
> 
> I think I've addressed all the points discussed in V3. Do you have any
> more comments?
Your change is under review. Reviewers are busy. Please be patient.
