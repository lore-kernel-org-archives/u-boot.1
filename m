Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2CFCCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB4B1835FE;
	Fri, 24 Oct 2025 10:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2516083621; Fri, 24 Oct 2025 10:57:40 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1614E8331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [143.105.117.17])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B7128B221027;
 Fri, 24 Oct 2025 10:57:36 +0200 (CEST)
Message-ID: <52715b24-50c6-48b4-ab9d-747aa8dc685b@freeshell.de>
Date: Fri, 24 Oct 2025 01:57:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: starfive: update jh7110 common description
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251024083351.237033-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024083351.237033-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Postscript,

On 10/24/25 01:33, E Shattow wrote:
...
> -The board provides DIP switches to select the device for loading the boot
> -firmware.
> +* JH-7110 working frequency 1.5GHz
> +  operating temperature -40|degreecelsius| to +125|degreecelsius|
> +* JH-7110I working frequency 1.5GHz
> +  junction temperature -40|degreecelsius| to +85|degreecelsius| (max
> +  125|degreecelsius|)
> +* JH-7110S working frequency 1.25GHz

reST needs a space between the numeric and the substitution. i.e.
+  operating temperature -40 |degreecelsius| to +125 |degreecelsius|

This is in my tree but didn't make it into the patch, oops!

-E
