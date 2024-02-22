Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF9FC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 20:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D259B88021;
	Thu, 22 Feb 2024 21:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="aoXfMKua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24273880B5; Thu, 22 Feb 2024 21:05:22 +0100 (CET)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5294488021
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 21:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <1884100b-ff3b-467f-9b0e-1d717ae81e3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1708632316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SwlvT97jc98SdeAguNwazshRXObYInnU+swTTqcaw4=;
 b=aoXfMKuaLRMdZD1p+Xf60LWkQFqyj5+T1L8NE98H3HaZY1NofaQsTCJMM/9p7TFhbv247I
 f6AX0E/G9Cmf4NrFW+lQkkxQxWi0pGTdRjSvdMh0L2XDuapU4YcnwTRXjNboNzGQl11I1m
 Y729Mt6vzcdM8R7KtXmbYPFRDT5Ten0=
Date: Thu, 22 Feb 2024 15:05:05 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm64: zynqmp: Support semihosting boot method
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>
References: <20240222165230.2600974-1-sean.anderson@linux.dev>
 <CAOMZO5BDMqBZddF1S6mG4cNXxheXvSe59DfEmUQW_ECbKB5CHw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CAOMZO5BDMqBZddF1S6mG4cNXxheXvSe59DfEmUQW_ECbKB5CHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 22 Feb 2024 21:08:27 +0100
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

On 2/22/24 14:36, Fabio Estevam wrote:
> On Thu, Feb 22, 2024 at 1:53 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> From: Sean Anderson <sean.anderson@seco.com>
> ...
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> I'm resending this from my linux.dev email as my regular email is
>> mangling my patches.
> 
> That's OK, but you need to make sure that the From and Signed-off-by
> fields match.
> 
> Otherwise, checkpatch complains.

Yeah, I thought I had fixed the authors, but I guess not.

--Sean
