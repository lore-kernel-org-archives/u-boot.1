Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEF606D819
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZfQNkwBe;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Os+G8Q6S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BA5F80FC6;
	Thu,  5 Nov 2026 04:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xv118_uzxFd1; Thu,  5 Nov 2026 04:41:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B3E480FB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793853669;
	b=WDFbOQOb6TJBgZDlQt1PfoK+8K/5Vlx5lyGXAubcK9yioPP1hqQPmQYEHYbIzEmaFn1L
	 nA+3EAM1UrZwl+uTlq5803EPu+1Ie+qRMSOVLby4mVzI0aj+14LJZTXf7iN3Imkgq9SbU
	 oY0zjbdYjajjmX1MC4JQ4hdpCub8LDryMSLyyMs+W4xZrpxtneM61KLAOfSs+xYQtKJcE
	 up70Jc/qE1YePmVpoM7JrZGcU99wKdL59S0UiZPUDsLM65z/jwwWYnAQ3T8H0Aa8NT37W
	 YKQliGoBLu5ZzkFP2RbNkBvjxDFP2+FXnNWSoPv36NvlF7AXvddKKOlJs4gWbVeEUig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lEZJvc3bhTo7LLqlixFu7EX5xzQVZ+ofAydKWfPheGw=;
	b=bLDdPqNAAE7sLOxlEwmaSv2yTJQLXPkWGVcdaUmRqSLu/LylmYWlO0m02pDIz+1X01dz
	 EUO0hyFXA/nsyFDJEMczaGSxPXfrcemrWCTzBl4+qmRL/EjUGJKORwwiAzdvZEbG1oY6K
	 yvD6MfE5bL4+9ZRSySKFym0jv3EZT/4UaExYsEIKj9BlgIxRt9jQ6O+c0wBodvZQU4r+D
	 JSsTjHoaoFYQV5erSVTtIeuiNxQl6mgd3F6BgCS0ukJ0JnHcckS8NvDxHmwkp0Gv8oN1G
	 eujB7bEZwUNeoOgWLAxvDyxT8vKt7sNZ2rtkh2Qyezeh8CiXChl5VmzlkZI8pvtgOUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Os+G8Q6S;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793853669;
	bh=lEZJvc3bhTo7LLqlixFu7EX5xzQVZ+ofAydKWfPheGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfQNkwBeLDI+kzFl9afq5BoSgxJwxckAs4UmfTGq5oIPrTIc3S58bvx5k4oq/d1gr
	 hjjbTQPffLZt5XpFinakOIloA9XxTR8ET7K0X2nEV/ZIu3MUwXreFFiXDeIrVcZFqI
	 3q5swzOKkYefxq4iy4S8CPmMc14F6fbcQg28Hg5DEGJ4sbeivO50wZlXsEcPZIsQqB
	 mgeXDXknmaPHuPF2o1OxgYJeeZh/66szA8rJTd1iIxXXmUa9ehqO0ILTTOW2CMhfnf
	 YV2W9Ycp09JF5VsJYz852QmuE42DDURYW06ati4Iu+bzPihIOhZOUPtyRgrJIsOu86
	 s6pYjx/gnSx7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B3E480FB3;
	Thu,  5 Nov 2026 04:41:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 752FF1779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 669A380FB4
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JMCGwx6-uxw for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 04:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57D4280FB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Os+G8Q6S
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57D4280FB2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:05 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKqPp53smzKp3K;
 Thu, 05 Nov 2026 05:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793853662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEZJvc3bhTo7LLqlixFu7EX5xzQVZ+ofAydKWfPheGw=;
 b=Os+G8Q6SHw4jiqVunYqACFCceMDVOWnpL2FX9fIkQdTLwfLuUqKrCLZhHGxVOnIPJL2Dg8
 8ZEpOQhxeDet7YLatZfS3RM8a0JOkaZ7w2pYJ3fCu6OLsYlYvlFLnrmbheSavHrRxEylq0
 lNETw9tgxQ81QF37T+L+WW/dLeD+GycIglT+0dsUy4E1/b2j+O5fTvNq8P7WQlJ0bVoiJB
 +HnN0y4VDFCIt/lbFDWtmNH7N//Gcjy7F5vumTqysYf+LJkULnIrnhHlgvXobTphRb4t20
 nhe/kpjrtG9YCdcK8WHKgIohJiRJz3j2dmAvVB/ScLxVpkftIT4TUvRRGSfGyw==
Message-ID: <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
Date: Wed, 4 Nov 2026 18:33:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261104142958.GA1112376@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c86702f26d4e5c3500b
X-MBO-RS-META: jjk9fy9brk4wiqfmhyweqjzd76tpitad
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 3:29 PM, Tom Rini wrote:
> On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> 
>> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
>> configurable boolean, and update all defconfigs and Kconfigs which
>> previously only selected REMOTEPROC driver to also select REMOTEPROC
>> itself.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>> Cc: MD Danish Anwar <danishanwar@ti.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
> 
> Unfortunately this misses some handful of at least TI K3 platforms. I
> think using qconfig.py to confirm which configs have REMOTEPROC set
> before / after, and that they match would make sorting that part of the
> problem out easier. Do you have time to do that, or should I pick it up
> and do a v2? Thanks.
I can respin this, but do you know which platforms got missed ?
