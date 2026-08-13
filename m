Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F69EC5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 08:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACC4C81140;
	Thu, 13 Aug 2026 08:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6LpC9qWQjt5; Thu, 13 Aug 2026 08:05:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0206A80EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786608321;
	bh=yem9dbV9t362llD3g6a1XVEgXlu5Loz+6+4NXQ4sRQQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VpP9EWvNvLKO+GHXnWuhyoX9hH8Y00aY6tztnq+gvvLGY9fw5680yWg39Nb4hzrdB
	 AC6wWdMeFZwAoe2/KPskS+4KfxKJcO9HB/70XmcyQ7YVhZvUr4+bmKYDbspt6xrrw/
	 cJ10q4pef0YO3dWOq1Zb/Odj+Dcbt2VbwncU8ttFWfzwjAE9MdifBDoQNbd1MYi8kV
	 io6rG52sg0oUPMjX1R6z6XX8Naxl53GEAVT1vRopeeJi8KhgJYWa4qkRQn8vfHFxYE
	 uLsThKPTvCyXIH5/YbtkSqPL1fqNbJpcOxAKZXiUCZ5u60rX5nxnzjlWJ4iHV0ER9z
	 sSMoDFhr2/npQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0206A80EF2;
	Thu, 13 Aug 2026 08:05:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43174282
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34CC66085D
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vZoiWSzuJIc for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 08:05:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::bc08; helo=smtp-bc08.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 58D4E607F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58D4E607F5
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::bc08])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58D4E607F5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:05:17 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLHwB5bHKz177H;
 Thu, 13 Aug 2026 10:05:14 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLHw94l6bzwJ; Thu, 13 Aug 2026 10:05:13 +0200 (CEST)
Message-ID: <665c81ce-ab08-45e2-8f94-453caa321d3f@0leil.net>
Date: Thu, 13 Aug 2026 10:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-3-festevam@gmail.com>
 <d4d49e17-e125-4121-b0be-e486e1be5393@0leil.net>
 <CAOMZO5DULY0wE_U-4aX9sfrnum++J9iJ02_H8L+g3qdY156KCA@mail.gmail.com>
 <e5aaed12-ec8c-4c8b-8cf8-1c4f9bdc2174@0leil.net>
 <CAOMZO5DHz4z+VmfjRyTxPsepXC7kFMPr+29F1yD-CZ5miwCUXg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5DHz4z+VmfjRyTxPsepXC7kFMPr+29F1yD-CZ5miwCUXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786608314;
 bh=yem9dbV9t362llD3g6a1XVEgXlu5Loz+6+4NXQ4sRQQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YD3/PEyrGiNoRHxDEo0LOHqDeJ90HDrl4+w9Su1t4XnkV8uqkZN+q7kbCMcvYpYTh
 NlidDiBxZ7LJR5GFDS+xNZBS2/v43AiVEDimz50DBFXasRkSDWF6gnq/JrhAAVdkK4
 DpJLGLBi+9YPAwwiBcx7vXLGnSQmrSVTWMHuUao18SiAnaOY36bCHdB6ijTg8DMfBH
 /huVc0rbwzGXjMiU0dfCzo3g2wm75TQZkUEiWq5ASYKUUdcbdlthnj+q9yMeejEI3j
 6YGcbMjSvASvWEpE3ogHfhQiZ67d+DDT3o0WLRkJqtWqIU25TNIRCpJF7iTR9B5vIS
 8gfV2z+/myvoA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=YD3/PEyr
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 8/12/26 11:48 PM, Fabio Estevam wrote:
> Hi Quentin,
> 
> On Wed, Aug 12, 2026 at 5:05 AM Quentin Schulz <u-boot@0leil.net> wrote:
> 
>> It should be !CONFIG_IS_ENABLED(DM_I2C) as CONFIG_IS_ENABLED is going to
>> add the appropriate prefix based on the current stage being built (so
>> definitely no SPL/TPL/VPL to be added manually) and CONFIG_SPL_I2C is
>> not enough to build the dm_i2c_probe implementation, we need
>> CONFIG_SPL_DM_I2C (well, and CONFIG_SPL_I2C because otherwise the
>> drivers/i2c directory isn't traversed and because SPL_DM_I2C is missing
>> a dependency on it).
> 
> I tested !CONFIG_IS_ENABLED(DM_I2C) alone, but the mezzanine SPL still
> fails to link because SPL_DM_I2C is enabled while SPL_I2C is not.
> 

Yes, because SPL_DM_I2C (and TPL_DM_I2C) do not depend on 
SPL_I2C/TPL_I2C but should. Something else to fix :)

> Checking both works:
> 
> if (!(CONFIG_IS_ENABLED(I2C) && CONFIG_IS_ENABLED(DM_I2C)))
>      return false;
> 
> I tested the mezzanine build successfully with this change.
> 
> I'll use this in v5 unless you see an issue.
> 

Works for me!

Cheers,
Quentin
