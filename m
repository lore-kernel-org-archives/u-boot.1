Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C617EC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC9B87FB1;
	Mon,  4 Mar 2024 16:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="t1+vFhui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA5087F72; Mon,  4 Mar 2024 16:38:25 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD28787FB1
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709566703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGVtTUGUTdIAmWotrLFYmw/z0lXD9L6L4MWXg6pmJi4=;
 b=t1+vFhuiheMCoVSZEvMr7BJwNmahM7Zc9B+An9e9EP4TaGyZxS9MUybB1FqvzsMkMMcL2O
 vSnqxIPT0kplBOTYPeR9/JV7Ng/jshDFCl8gQ6yWfTx9Kl0awHwdups86qpdYix+cS+qPb
 Pl51QnwtV8xpDawV+BHcb2hI5KNh2yBoVp9HN4PA0V/wBoZ6YbdwUXnDxEnbMA8S0dISUd
 kml9fO4uOIxepc1hLWfzFUFpVy2Caq+uWudLP3sKnCHh5sfdTehaPnGGdLFfCLBN5Aaqpd
 OFqMsapmROOlTeh4THLMNpv9N2mLvJn1fWtiZgr9WC1S57/RDrHHZNdzWhEpCw==
Date: Mon, 04 Mar 2024 16:38:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, martin@geanix.com, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2] scripts: dtc-version: Don't show error messages
In-Reply-To: <20240304152822.GB1523872@bill-the-cat>
References: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
 <20240304152822.GB1523872@bill-the-cat>
Message-ID: <4b3bf24e669e240def85d25096ad0c45@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-03-04 16:28, Tom Rini wrote:
> On Tue, Feb 06, 2024 at 12:00:04PM +0100, Dragan Simic wrote:
> 
>> Prevent the error messages produced by which(1), such as the one 
>> quoted
>> below, from being visible in the build outputs.
>> 
>>     which: no dtc in (./scripts/dtc)
>> 
>> This makes the build outputs look a tiny bit cleaner.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Applied to u-boot/next, thanks!

Great, thank you!
