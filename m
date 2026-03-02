Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487E0EA4E06
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EC183F56;
	Mon,  2 Mar 2026 14:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CvFGHcQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3548183F54; Mon,  2 Mar 2026 14:53:52 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591CF83F2D
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 14:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fPgQ44LP6z9sbj;
 Mon,  2 Mar 2026 14:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772459628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9Q1A6RBYYXvtqY24LFpzy8N6Wejs6RAaFJVK0uL6I0=;
 b=CvFGHcQAE5fTbhwIBgD7XS1Ht4AlWgpsXyDILrOZ6AzkwRMK9mxu7rwp/P8Ts5jitB4+sV
 A4yW4IFtUVVYzoA0/phjqd0LQgPMERNUbv0aouApQIq4ERzAnR4cAbqlH0sFkK9mvJIsHz
 Mv2fqdq4fbsQ8jUWDIfxcErf9cXJzHOamne7mcoPhbJCpp7EazMXuKSofXxTtzoWlH2+y7
 w9ZcfXU0ccSJPkadF1xuiZwyKPXw5iItIUK/nLXjxnVRkUVMTZrp4r5B3mvDhhs4LfgUdT
 qV3Fg74XA/ID+rSPqj327qx1qYb9fzk3ugEYeGO05QVz7FbZ4lbjuAFaBVgu3A==
Message-ID: <49be65da-0d6f-4a5c-9819-c2bfdd8894c3@mailbox.org>
Date: Mon, 2 Mar 2026 13:54:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
 <20260302044532.2891813-4-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260302044532.2891813-4-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f85347d925768b2cced
X-MBO-RS-META: d3fbfdhwcdbdwerax65559sa9sfs3uot
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

On 3/2/26 5:45 AM, Ronan Dalton wrote:
> Wrap the timeout_us parameter in brackets and assign to a variable with
> two leading underscores to follow macro definition best-practices.
Is there a matching Linux kernel fix ?
