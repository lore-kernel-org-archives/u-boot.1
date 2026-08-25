Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE640C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C531A80B56;
	Wed, 26 Aug 2026 05:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REIQaCNOyHXB; Wed, 26 Aug 2026 05:27:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722061;
	bh=jJ/WBzBDv7W5KnEPLg+dx9jcmAD9MWILOgOxGspL9VM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s8D4gi3SmxAxg7dgOEaKIdkJZUupu5+juUYUCPi+hXVDI6SOgi9QBunFHxRxTI/ib
	 7D82uMaOAZXeg5eK+R/m55ZZawYOsQvlVd1NlSUDRizMuEBQehtArDRy0vzLaEvpwZ
	 Fd7skBa2GpbIS9Olz9bsi5YW6PAVKuQo1o8e+okuuo/f/rQ0y+q5qj5HtVH2ePxM39
	 wC0GY2nWALPnt2id/8sx82d2cjqz4Z4dgJ/+Ni6TENKxwdFm+Ov8pMQ97FtGfmnmRw
	 nyBgOa85jVkJ3Ztaw70QPmzKCcyrcnF6RDnGOZgSrF7UVv8ctqmnsbr1Y08jq8/1On
	 WTtasQIh/BEcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3939B80B40;
	Wed, 26 Aug 2026 05:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEC8439E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCBD340073
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKMZPUZdj92s for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:27:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=XVHYhyKF; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=yZW3aRsN
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 130E64000B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:27:38 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hVCpJ4cmszKmY2;
 Wed, 26 Aug 2026 07:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787722056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJ/WBzBDv7W5KnEPLg+dx9jcmAD9MWILOgOxGspL9VM=;
 b=XVHYhyKFNDVEzgeu6PSg7ijCd+XeZdMLPBnreLfzqM3RYZN94zlWkjEwPT+f0alZP+3HtJ
 uge8HLzAQZ8XUWs83BBDRTxg+CdodKkButUkqhNIzMaBoUTehXYWUGGqlrpdHwuI7pNavy
 aqdEQWsl+zm+95cIVculeNKgRZQK52bqg94t91chQGZKt5HXuwzrH4s2uVocHs7uJIWb/K
 e8rM625r4baS5j+yellc0w4Xkq/EP4whPzXDXRlldeG7jzA2y00IcAFX/Cn8ukJI/e7Sbz
 EJ2HUefFumZxmjRGUeS/XvS8mUp+lHpNORL6QbcIz4jBn6HixeRiAGwo+nyN4A==
Message-ID: <e8c2cb8f-5750-4450-8eb2-46db7e8348b6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787722055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJ/WBzBDv7W5KnEPLg+dx9jcmAD9MWILOgOxGspL9VM=;
 b=yZW3aRsNcLrnxQjiMbGc7eNUU8csXJFWASwnxb8pkdrOKvTp8GLwH/wzjgYaYdrslJvoQy
 DDkg7wNwbMBQIkEBh4CF2mbE2Yqi35xrjwHHa0VcZmK55wT/1ge3gtIlRv8ZB2HDEBzmdK
 hamXGUPQQ7yK6TW2ec4va3lMJKLl/oeZXILWmL7XrLgWGyu7Fsh9dZ7+6oHBjHP+6naapJ
 Ulq601pisLiVWvATn0bPz2/vuELrYxHjYVoITpqf9h9AH1bJxw8ciq72JE01voVcKvUfXv
 9kgYhKXH+tDLo6rrtwlERRFQdSgHReEypbBqE+Pb8yfFpC7/hg9W0WNGjVPFXA==
Date: Tue, 25 Aug 2026 22:44:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: zynq_sdhci: support Renesas RZ/N1
To: Ralph Siemsen <ralph.siemsen@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
References: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
 <4e3a48d8-d971-402f-9542-820f254abc77@mailbox.org>
 <ao3xXc7dNbFmKEha@maple.netwinder.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ao3xXc7dNbFmKEha@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8miw6youcqxy3cro1neorxf1878n3dod
X-MBO-RS-ID: 42184f1d6c5de8da055
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/25/26 9:47 PM, Ralph Siemsen wrote:

Hi,

>>>          return ret;
>>>      }
>>> -    clock = clk_get_rate(&clk);
>>> +    clock = clk_get_rate(&clks.clks[0]);
>>
>> Can the clock ever be non-first clock , i.e. do you need to handle 
>> clock-names DT property somehow ?
> 
> It's not clear to me if the DT binding specifies the order. It says 
> there must be either 2 or 3 clocks, as well as clock-names properties.
> 
> Existing DTS files (rzn1 and zynqmp) have it as the first clock.
> 
> We could try using the name ("clk_xin") and if that fails, fall back on 
> using the first clock.
Sounds good.
