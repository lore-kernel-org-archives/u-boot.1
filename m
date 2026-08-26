Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631C0C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 09:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 279114074F;
	Thu, 27 Aug 2026 09:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjuFxEvPT-u5; Thu, 27 Aug 2026 09:50:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787824256;
	bh=S7KI8XYZVyyOT/8U0Xjk3FLC8ignkeagMMZuZ56SNWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nYZf0CXeM8uWL8pD+IwQA+1fUhcIFQv8k4WbW7PO55sRcFIoGRvXWgRQoPAw9e35A
	 n8NSx51uPPcLCnpKBMRRmqCT0kgbTarusDQ3G3zRcj69VSDQB2siDG8sB1QSSJ9+ik
	 FCvg8aWNEfaV+ul3uIndIJCNEhWteiTopa+RkSY9wBWwNlLUgb6Om1A/sL+HrjAPNh
	 VglNU7xD1/eYo0AQ0mD8poew2KZrRzcnrtnepR0549PKrrzmGwJ9Ijp433mmUmV/yc
	 Cf/NQ65ZtMxq8+f6jprUfRSPsWWdcRqMQ0QUNDd9nv36SEHv80POFEj0w+wsIIZZF+
	 7XgAUjELW//7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8ED4406FC;
	Thu, 27 Aug 2026 09:50:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB2083AD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1760406E5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CWMld3EvtPz for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 09:50:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=ufnQoeWu; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=wS9/ip9R
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD3ED406FA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:53 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hVxbb4G5mz8t3F;
 Thu, 27 Aug 2026 11:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787824251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7KI8XYZVyyOT/8U0Xjk3FLC8ignkeagMMZuZ56SNWY=;
 b=ufnQoeWuY8FcZ1702jwEYJsaIaXi4BBBJAnk55ofEtDaKptVcgqMU2G2Yd84Js38NlM2ci
 Pwzj8Wt1e87/RgYJ5KBTf3AZOrP99Pvb2X97J0u/6mAdEM/rnfTqbF00bKQ4ikChklSBkn
 yr+GO4GOrFpa7kSvppY3Ws20KqkrYY53nrUDN7Rv8ETDLhWIGnxh1QWrqdZusu/WNfKi7Z
 jakjEM82cXYufSDUAp9QtqOp3z8jd4XWMWuJE3iq7QprmZcp3lKdG1tBYLa84cV1WC6zQI
 rsUHOkcqcwbFCu2kk/woF8UDXr33p8NyD05DpiuvEqloNXVyjp8gOY7iE/piFQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="wS9/ip9R";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d387d3ff-d0a4-460c-8967-3aa412c5400d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787824249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7KI8XYZVyyOT/8U0Xjk3FLC8ignkeagMMZuZ56SNWY=;
 b=wS9/ip9RDzcH8qLlBMQpa8yyHsGYPuTaId8Wz4M+a0WuZ30AUvov0OB2NNMOTpZFqsaDQL
 XkFEgbi3n7dKIj+SRgqZln7OYmbH0A/8TCvnB5XLlBTzx3WePOFvoaRbDWaDc0Bewx5BiF
 abvw41r4Rfi9FuajM3QkD6SfSahbi8UhDPlA/hx6VC2KQU8xQcxvdgzVBrZUtDbWUfFd8j
 09j7mQEJ56+rwbdh1psj5auwK9cIxg7K422juu0zVdZ/26VTx7/e5DP9RmkBXt3E0gEOPa
 StJFkrUNIeWJWnZhW0js+eV2rlfdr45Z8lLnuawY6HlsMRdfi4WFG+qSH0tMHw==
Date: Wed, 26 Aug 2026 14:28:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/6] usb: skip host-only devices when picking the ehci
 gadget controller
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com, u-boot@lists.u-boot-project.org
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-4-eichest@gmail.com>
 <36d72877-ab8c-4338-b34a-dc85c82c039f@mailbox.org>
 <ao6SwTIr876ifB8l@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ao6SwTIr876ifB8l@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: szu5t8pofs3tak37ibtupyfanzmhrp8b
X-MBO-RS-ID: 5537929eefa03bb99da
X-Rspamd-Queue-Id: 4hVxbb4G5mz8t3F
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

On 8/26/26 9:16 AM, Stefan Eichenberger wrote:
> On Tue, Aug 25, 2026 at 01:45:08AM +0200, Marek Vasut wrote:
>> On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>
>>> The i.MX95 SoC has two USB controllers, a DWC3 host-only controller and
>>> a ChipIdea OTG controller. The latter is the one that can be used for
>>> USB gadget functionality.
>>
>> Both DWC3 and CI HDRC controllers are dual-role on MX95, are they not ?
> 
> That's correct we only use the DWC3 controller in host mode. I will
> update the commit message in the next version to make that clear.
Thank you.
