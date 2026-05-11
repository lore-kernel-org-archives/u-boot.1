Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ED6CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0185B8394E;
	Mon, 11 May 2026 16:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ppJUOz0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78FE983A91; Mon, 11 May 2026 16:14:45 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E07838D7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 16:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=MuXQaiwPL84v4FjpVdNLWffBoPwh+jU5MfND8ZL8feU=; b=ppJUOz0dWwqch6fOOXK7PbnqvK
 c/8wIzQeCKsgta9RLIwf8hUhhBXOh7HmhxBBtvR8Ok8OA+S2SRDiCXUWCsj4c/9R2tSWhEq+U3GiT
 w3V7GRLOfakZOEN1orhf4DcCGOHZ8yvYdgi0ke25UaGp0/Es81l88JV6a4ID7Z+EVhLMmq+7pTZPn
 vIUmexMNB5YJIUxgnlv3Fzck8ReN7vSYprUFgvj91CZPK7mGLt0y3Qx0y28weLyhj7Ot1yuMxjdpn
 CGin+Xv3MX+PnTXmnGiDKy2v4lMP13QaVVsfe1b9/x7WNZmCji6SjQTUtSP2ycSqskwmkLeqOM10v
 zot2zOfg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wMRP5-000Fnl-2P; Mon, 11 May 2026 16:14:39 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wMRP5-0004qb-2L; Mon, 11 May 2026 16:14:39 +0200
Message-ID: <620059e0-fa8b-4fab-9683-c3216e3dd10f@ew.tq-group.com>
Date: Mon, 11 May 2026 16:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] board: tq: common: add sysinfo helpers
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-6-Alexander.Feilke@ew.tq-group.com>
 <CAFLszTiYQQYY21drfSaHfaNq4bzuS-0=pBEA-qU_8L3RE41JAg@mail.gmail.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <CAFLszTiYQQYY21drfSaHfaNq4bzuS-0=pBEA-qU_8L3RE41JAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 08/05/2026 20:03, Simon Glass wrote:
>> diff --git a/board/tq/common/Makefile b/board/tq/common/Makefile
>> @@ -8,3 +8,7 @@
>> +ifneq ($(CONFIG_XPL_BUILD),y)
>> +obj-$(CONFIG_TQ_COMMON_SYSINFO) += tq_sysinfo.o
>> +endif
> Can you use the standard obj-$(CONFIG_$(PHASE_)FOO) pattern here? Then
> just ensure that TQ_COMMON_SYSINFO is not selected in SPL - that is
> the convention elsewhere and avoids the matching #ifndef
> CONFIG_XPL_BUILD in the header.
Can I configure TQ_COMMON_SYSINFO to throw an error in some other way
when being selected in SPL? I can append `depends on !SPL_BUILD` to
`config TQ_COMMON_SYSINFO` - but I'm not sure if thats what you had in mind.
It looks like it can only be silently disabled this way.
