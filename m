Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57240C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAC0F80C06;
	Mon, 21 Sep 2026 13:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9z7Xrkw4Nob; Mon, 21 Sep 2026 13:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4293680C3D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789998908;
	b=peCpW92zgdnQIMvFnz5jmhRD7GxZwRpaXuDnRvGbK+efPz/rz7CwFpZd302EYP3HsGnk
	 IPDWQhE42fH14vLA6+QYDeXz+J49CLAb3skebuU7tSapTUQhO6T1Nl2tXYbPYEIHhSftK
	 YymRSfbX5Sfx1RS78xmwHBOXWHtP1R7ji0qtXTwxnJMxb/7jG9D5x0bd3yhcGdACjM+D4
	 2csLY1WV3zMqrJoJZ1SjFy9t5uKzgD1vTJMdQmFaYcQLWiJK9sjl1jWGse1plhb4O3JUq
	 Vq4pV9VpYGYcXE3uNDzScM6FmEYMLIDmhTlLAqazqcX4lWkO9tcz6TtxUevHbsXsIdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789998908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g6ZF5bI8rZQAF6rQVVrl9IFJpXe3JgkKTa0979tOz4E=;
	b=KiOCIU+HX+xrYhY9OyqQH52WCm1d5rORdZtupp43tUKDyIiIVxlgUxCBUIeyvAGaPPC5
	 Kpi4PSb91qvZIfG/JC2h1SHuAp3d+8Kzev+xLNxrUT9I50+UH4TtdiKmhZ95vlnIoYmeZ
	 W59hJUsXTm8jTQK7EhgEl79tmwed1EzzlGt9INKXi6WvcNPFd+mbgvYqij4/FPaQwsroL
	 ygMaWS6ednAabxUN+O6usyhwjb5TbJG+LnnSldSqqpbe0fuDU1N7xvvOLi/H5gS9Shgsv
	 ODPye3sC/lqSl2Y5Wa0jRDcs7CgkiytyFPzzEQPV1v240rU0a3h6WdslnIN716jNxiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=UznWTdLV;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=X+1VoW8L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789998908;
	bh=g6ZF5bI8rZQAF6rQVVrl9IFJpXe3JgkKTa0979tOz4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nK5EK0vpyoawHpm42rGZXhY9OHEYkUNZmabLAzSYONgl6A2O3+FC1+cb2NxghKCyN
	 /s8eV7nACmzcnj1niYNttEc5zzDanmmUdQCmPQQKcaf6cVXzXX5LNPBvQY/SVJ/1uU
	 H6IedeutD1mr69TQTpGQnVF17sIE07U8xmW1K7kpfMJzSOOgnrgbHKNOFcWdnOfiIA
	 HsAKO4z07/tzADs7A+U3VdvacMjXGXcpu/i5vvZxgXPZQ8qEB7LoQbu/ne8+TLvQsz
	 JFst9ON3ZKGk2B8jkhENtHaX2zfUibL+RbyQqiDNuuUhooiPTZ9ZPcSwmK/da2RV3i
	 NyLez0blkm3UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4293680C3D;
	Mon, 21 Sep 2026 13:55:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B87713D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5044980C3D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vziqS_H1ZzOV for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CEA0B80C06
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789998906;
 b=Q+dgORlk5EMT0hy5bTlEskxewdzqD2eshgXaN0X+kMsZLS7lUb/90VMZ+cf0TUpMPBbP
 fiHq/8B/G6BIYkYiop2JuuBHHj/cgEIZXYG9g+4oQ2UI3/UV7FPqayXEXr2TGNCLNS+2P
 GpD4beQoJH3YzZ1WsN3xKN70G+GTlTInXOHb9bGJR4gq7ZI1ZamUp3jpdc51ybRXTl1Lv
 2py2jnkfAx2xKPqsP+lpCOajADfIq/LYZBcuBMz0Q/em68/9UDsO0HFc2sDMBVXW36adq
 nijCJZyb9U+yC3oghSbs5Bom3rV6PrnCSpZ9Ggcejcy4Ai5oozeEJdXNZwzmoDf868A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789998906;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META:X-Rspamd-Queue-Id;
 bh=g6ZF5bI8rZQAF6rQVVrl9IFJpXe3JgkKTa0979tOz4E=;
 b=KzJGzq8/ADqcudU6UYj4fOO56OMtllLLA3ajaMZiqzsOVYnizmyHo6dWZntaAWGXnneZ
 jmnTaHoBgZCTSqrM12ARD7RwVyU/+HZZ84Ir12JLXcqvN0lYRX2eGEpBlGWCvasRONn12
 1yjNr4Hz2FHg8+ocini/BA2vh4d37Q1h77a+PHThAPNxq3++NrF3izMjxdDgu/gulQOFO
 xp6yKaebzwDh9YGRLKRL7LgsHeT4myXJiSsTsy7TRup9SCIVZMQVJXM7Kl283EQ+mJ270
 EuSvP2UTjhsJokKWHAGYyE+dPByPLZCRlLsdgIxObigXZCR6LK+H+uXVT2g8BYq5SyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UznWTdLV; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=X+1VoW8L; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=UznWTdLV; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=X+1VoW8L
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEA0B80C06
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:55:05 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpPqp3WnXzMlGh;
 Mon, 21 Sep 2026 15:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789998902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6ZF5bI8rZQAF6rQVVrl9IFJpXe3JgkKTa0979tOz4E=;
 b=UznWTdLVbQGjSJJeV/Hw3Ns2MoXaT05lKaZggRGbi7oXm+br6Rx6vF5epWESQI2FsNKUMj
 4fmpqBNuf7A2J/aljuLXrEeyFm4iMdH376RMZEYAajffRDXquGhYH9savOlDEgXbINY+Fz
 pQO5Choxh5aZKghriC2IBaWX4mZGpIRIvavDHSR7mt9B7ce5O+yAbmm/7hgKsoylYKxJSB
 mpn93JijpGh/C541e2Ro2fw3tzHGDKgxFgNpJ/hCXJKa3fQbMspFktbhffsj3Fm7vJVO5P
 k2HL1Oas3i2GwEBd9ihyRR/ot6kz4dCxm9QQW4mxBqBFXoMoCMHeY1BPB0qSFw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=X+1VoW8L;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bcb231e1-3ec2-49a9-b1fb-b9a499d13fcb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789998900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6ZF5bI8rZQAF6rQVVrl9IFJpXe3JgkKTa0979tOz4E=;
 b=X+1VoW8LFs55DrNcwfAYbJFOeMTSO/Jgu+aYObFy79opfQ+7zxQQNFxdWMR0POvyYzhzeb
 NVUsFroHVJp21MYV09xiMqz8RoruTm0zQ0KAD0lv3iqs/aufrM0Ap0yRgbcVhQKe6UpnFl
 DytK5hmlY/p84B9tbkQjstpYgn+Kl3oQacmTtXJrO5dFcOaPO3GYgdamX6QQZv0N8NCRu+
 UK61yDqAp3Bcz3DwegLNRXUy2x/Y/CIjcyVtpy9osCDwKiLMnvFirRE6K5mJNYqrVfhSjs
 xTWnyFGXDbQIvT78viQjmi2W6JEPDfMZfdv3VaMgDdn0KGc3RnqkjNNGazWrJQ==
Date: Mon, 21 Sep 2026 15:54:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] phy: phy-imx8mq-usb: add USB PHY tuning support
To: Francesco Dolcini <francesco@dolcini.it>, Tom Hsieh <hungen3108@gmail.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, festevam@nabladev.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, trini@konsulko.com,
 tharvey@gateworks.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org, Tom Hsieh <Tom.Hsieh@advantech.com>
References: <20260921054505.2978948-1-hungen3108@gmail.com>
 <20260921133040.GA265796@francesco-nb>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260921133040.GA265796@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ed6a25d83e51f208b19
X-MBO-RS-META: 3djw33ssny1zonw6m9hrwpprijfo9pxp
X-Rspamd-Queue-Id: 4hpPqp3WnXzMlGh
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

On 9/21/26 3:30 PM, Francesco Dolcini wrote:
> Hello,
> 
> On Mon, Sep 21, 2026 at 01:45:05PM +0800, Tom Hsieh wrote:
>> From: Tom Hsieh <Tom.Hsieh@advantech.com>
>>
>> The driver defines PHY_CTRL3_TXVREF_TUNE_MASK,
>> PHY_CTRL3_TXRISE_TUNE_MASK, PHY_CTRL3_TXPREEMP_TUNE_MASK,
>> PHY_CTRL3_COMPDISTUNE_MASK, PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
>> PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK and
> 
> [...]
> 
>> Assisted-by: Claude:claude-opus-5
> 
> What is the policy on this in U-Boot? If we re-use the Linux kernel one
> it should be just LLM.
The author of the patch has to understand the code, and more 
importantly, be legally responsible for the code they added. Therefore 
the author cannot be purely the AI.

For example if the AI generated the code based on some problematic or 
closed-source content (do we surely know it did not?), the author has to 
be legally responsible for any damages.
