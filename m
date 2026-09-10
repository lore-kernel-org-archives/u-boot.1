Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1C3C88E40
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 03:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E0E540A61;
	Fri, 11 Sep 2026 03:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atzBcIpD1IG3; Fri, 11 Sep 2026 03:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7DC6B40A67
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789095619;
	b=ZvJCLSyXRr7F9VBa9RKV8bpfekhH0ZKDLGqGh+RoAxFoNkfR9ZgEXXCj/3Vlnq0gQnQF
	 Asue/EcQKIHWh2yEfvID9kLcHxj6BXbz4GOHL7/ZJ1rDPM1L2gyt7K2/zjRVbPcPKaTI9
	 Tw2EgcwGmGgw/iV/NbZIWbt1vZJnfDKpS8ULDoOltitYQLUs1Ji93+o8QMYI1+giBL+6Z
	 x9KjFLCXU2AIrFjrvn1NG6Ghqnq5gWZ7w6NolcE5KZqZ1sArcvicgxZa7vp4X6recryim
	 Ovd7VUSnehtTt55d1SBkifjWlduEYOoY8OT+vhbTYQvn3hiKeQa3/s37QYqg0zw0jiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789095619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
	 MIME-Version:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-Rspamd-Queue-Id:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rjgx2XkNogtGtBECWmlgfmP5xadX+LIm+r9XjAmo7us=;
	b=nKlAFB7pFQajjMAyxyQVbc/qXczKMV2AGAOE7tlethYFNz42MVfJy8qvzIyNJnmaZ2X4
	 8gKYuI8/VIDa7Um47aDrfjstRA6R43ue4RnU/treyY4oRu2XWMqq7cEh3kanyblz3oQiz
	 OqnZ4Bt941/3u+zz48POI+MfmFkMv6+/psLXJYB7O3Z24MsAOuwoMQ+T8SitqJeV0A4U5
	 w24/3msCH/seePRAPHDPpeL7mWlmViGyFFu+F1NAdUp8fWhp8OeZf3H6yb2WVjhakrVWl
	 iq60CpJLe2UxyMiMGwrtv85si0vyefVo91QBbb7RcpIr3tRWQA+1mirTjb9WEikiJ9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789095619;
	bh=rjgx2XkNogtGtBECWmlgfmP5xadX+LIm+r9XjAmo7us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lzdm19BZMdxEPyHCH1gp2A4GbmFiyb4sctaAkU9cvyMjxgBG3tdlh5KFFy+iV9VAW
	 RevdJw9+ewSirPJnh6Y2YMeFTC0D7P2zWOgFztz3/M84bbTM+xftIHdD0v/2o6FW7A
	 bM0aGnw0dao1FD0PlFVfdewI/JhK8ie0511WzxSyz9HZ4uSYC8PUQlN1r0iWch28Kn
	 9dDKy8wnEDrwSWZdOA16Pg1s2RzAIaEbClid437nm0CW1I3eoppTnM43Rg56Q7HOy/
	 OFyNKOm+XkcshwrCkPxToawcEOtgtTjqF7r5orhOSwRtJzG28IwNkgA1cFJyp3/ME+
	 +YOjlZkhN9VJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DC6B40A67;
	Fri, 11 Sep 2026 03:00:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE26614D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 03:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C412C607ED
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 03:00:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-X_gMSqwsvU for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 03:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A7274607C4
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789095617;
 b=ohpNrGHOKNyMhp5qCD3no/Wj6rX3+dUAbja7QhpjbTfAG0PO9pKqCq/Rfc/r6quNwHKq
 Ai5ERyUCSGyPKhLhSlYSWCXPzZO0tEZ0u4BFU8Vc7zgLgF9YNk5b21J1b653XGNOuRZJf
 KR3eMBEH1ReMkOahplq1QhNZMWxtVMSjOGBA56ELBr8q+k+2opaXFZIGpPgyyH/e1Uf5t
 YfJ3TuL0tHE/O9h3qgFpMGzgPGhUrvnG+vJi0Lzwe7+3Vw9+maTro3gOzHXpSWc9+b5dH
 MiP/bBP883SbKruQBul2hLDFNknAxNvdffQ5YA10Tif5NW5wJRpPWIGBrl6mupOykyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789095617;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id:X-Virus-Scanned:X-Virus-Status;
 bh=rjgx2XkNogtGtBECWmlgfmP5xadX+LIm+r9XjAmo7us=;
 b=Vg68rVbC5myYQ2FjOOCUbewvtWudtM0TxVW+RaALFJCfXbB7DKxAZVEK0X1d8AYWzRnw
 sk4c1zPlXoR7kySrMoJQmqkYwT2THacK4ZnU5yX7x0K0rsFFLiyUI/d90T0+FIZlbkVsP
 ECPL2W8Mc/MraoMn9tYeL+/bpFVKhfLca/z3wHKippuCF3WgL40V2p+DBhMUlAuK4sqHM
 M/VTrjY8JVqA9y5L6zbEa38CBxPzr3YFDwXp045hTd3LR17dqg9UkOmmhOkYF7lbGF46L
 kCL0tk96LXqnJtvGTQkRQ61rc2JhKxSntcn83m5UrQaQlrEpx5Y7KyT0M2LAJxSX7qw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 spf=fail smtp.mailfrom=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=CorbLBoa; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="sJH/A46M"; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=CorbLBoa; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=sJH/A46M
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7274607C4
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 03:00:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FF1847D2; Fri, 11 Sep 2026 05:00:14 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA4B841F2
 for <u-boot@lists.denx.de>; Fri, 11 Sep 2026 05:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="CorbLBoa"; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="sJH/A46M"; dkim-atps=neutral
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hgzmr2wF1zKw1x;
 Fri, 11 Sep 2026 05:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789095612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjgx2XkNogtGtBECWmlgfmP5xadX+LIm+r9XjAmo7us=;
 b=CorbLBoa7DQVgWVoZP/9NUWbALPB+q9AGr3EV723vusfRkCMuZWZfK3mlaTj7fc57pTMX6
 bsZd5gChR9/oCllgtyYFJFyn1smUM2vCNn5rz/FNB2tz05JjndthmGpWsE+78nAGFnio5y
 TgQPwXOlyrxM0VbfKhV1DDPKvAK6DqFKwZeVYLsmO2cNPcOoSpYzbP7WfHz7ls1sOr7cMk
 XUphP0mmjktuu6LXOamqIU7uGTsxzl/61E/OQdjw5vPfdS7OGDN4OhQeXHo+h/WjwhOgil
 B43DT6809aWEcQjoZzIFMX+GheW3S+WBJiqoMCI3EhhDsVoZGbbOfg+gjYf1OA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="sJH/A46M";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <9236964a-d424-46ca-869d-9034d61f08ba@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789095610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjgx2XkNogtGtBECWmlgfmP5xadX+LIm+r9XjAmo7us=;
 b=sJH/A46MgMFETcqJKGasHh51umZkoW+cYiCgbFdzPAm9/oZSV2yIf7wA93NBHJOR8WsZHP
 Lgj5izsQoKxhhjFKePaJmh8Z1rZf+Yy2m8D/l4iTKTKUVPvluX8B1IeZK8oOPOG7XiwerY
 kCmw1mNVgeAscP73WHBFoW3zMidhBmD+gVmAj8b9UiPO3M7iO1ObbGnaHAZKWc4TVX2j0Q
 MZ/psjf9+J45ceYaon3cYL0Tu76eqYaemqld/il/AMwlhAlXjJbJ/BG08ptmA4ltRVFGeZ
 rJk8SsxDrvEqNfophZjsSv7O+1fFtdtIGrvQeZ6+hPC7Q/uA2/fUAKLeudP+YQ==
Date: Thu, 10 Sep 2026 16:32:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] pci: pcie-rcar-gen4: Avoid repeated link attempts
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
 <20260809013431.444164-2-marek.vasut+renesas@mailbox.org>
 <ee1107a5-700c-4479-bb4c-0fc0d56b4f3a@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ee1107a5-700c-4479-bb4c-0fc0d56b4f3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xxhfcomnzu4muzrae9r4y1qzqdz5tu37
X-MBO-RS-ID: db14f17e00339173b1e
X-Rspamd-Queue-Id: 4hgzmr2wF1zKw1x
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

On 9/10/26 2:50 PM, neil.armstrong@linaro.org wrote:
> On 8/9/26 03:32, Marek Vasut via U-Boot wrote:
>> Avoid repeated link attempts for these controllers. In case the
>> controller link is up, this is a noop since the probe() already
>> finished. In case the controller link is down, a repeated link
>> up attempt seems to require reset of both PCIe controllers, which
>> is not desired. It is also unlikely that a repeated link attempt
>> would bring the link up, as U-Boot does not support hotplug anyway.
>> Therefore, prevent repeated link attempts.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/pci/pci-rcar-gen4.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
>> index 34561406641..044bceee6c7 100644
>> --- a/drivers/pci/pci-rcar-gen4.c
>> +++ b/drivers/pci/pci-rcar-gen4.c
>> @@ -112,6 +112,15 @@ struct rcar_gen4_pcie {
>>       size_t            firmware_size;
>>   };
>> +/**
>> + * struct rcar_gen4_pcie_plat - Renesas R-Car Gen4 DW PCIe controller 
>> platform data
>> + *
>> + * @probed: Controller was started
> 
> This commit is not sufficient, please explain that only a single probe off
> all compatible controllers on the system can only be done once due to 
> complex
> reset reasons.
That is already in the commit message, this here is only an abbreviated 
description of the field in platdata. Would you like to have lengthy 
descriptions for structure fields ?
