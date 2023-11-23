Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CCBC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF86F86EF1;
	Thu, 23 Nov 2023 18:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A2986F34; Thu, 23 Nov 2023 18:48:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6064186EEE
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 18:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=robert.catherall@foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2337D1042
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 09:49:26 -0800 (PST)
Received: from [10.57.3.74] (unknown [10.57.3.74])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ABAA3F7A6
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 09:48:39 -0800 (PST)
Message-ID: <68c90de9-75ca-a812-ceb5-28a3a5370d18@foss.arm.com>
Date: Thu, 23 Nov 2023 17:48:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm: afs: Set the filesize env. var. on load
Content-Language: en-GB
From: Robert Catherall <robert.catherall@foss.arm.com>
To: u-boot@lists.denx.de
References: <20231123171522.7302-1-robert.catherall@foss.arm.com>
In-Reply-To: <20231123171522.7302-1-robert.catherall@foss.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/11/2023 17:15, robert.catherall@foss.arm.com wrote:
> From: Robert Catherall <robert.catherall@arm.com>
> 
> The `afs load` command copies data to RAM. Set the filesize
> environment variable to record how much data was 'loaded'
> 
> Signed-off-by: Robert Catherall <robert.catherall@arm.com>

Apologies for the duplicate patch; I had issues with getting mail server 
set up correctly. Please disregard this copy and refer instead to the 
earlier message with the slightly different subject

[PATCH 1/1] arm: afs: Set the filesize env. var. on load

(the actual code is identical)

Kind regards
Robert
