Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696FDC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1426F4055C;
	Wed, 26 Aug 2026 16:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pQHwGeF7iu2; Wed, 26 Aug 2026 16:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787760803;
	bh=J9Mcvb5LScdOkDe3lMdePO/W36C8kG7UTYf3dAyyDXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jB9JcdrFun3GBektQLLyx+/7O+xvkRdBDlHCheKGpXpILkPcaVR0xUELlQbG53TFY
	 J/Mpxx0lZ401LuMJtbL8ZZKV7y2Mi7BUUsa+R2QVoUXx6lSdBeajTPdcAe9KBbSicG
	 qoTibrS79/oxEwf8ms9Y70xzD94KaGNW67RqjlKSKEEVC0vUgIqsiIrZspjRoeqByB
	 62qVo8YhJA3pxqbCVc+pdAVQRMBjuMH6XjoNyExYJoxYXvkMvqRY3vJZsr/fjUyNn4
	 0qWSQeZlw1MAE79PROjw2uuPiseb1HTllcS/kIicisO8XHLrU8OTqJaD5l5ZVAwQlh
	 hzXvjaMR/jDJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C2F340434;
	Wed, 26 Aug 2026 16:13:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D305B323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1C6D40118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaLIO5zNTVwk for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:13:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=ee6a=gu=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=TPJ+2BE4
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61822400C2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787760798;
 bh=J9Mcvb5LScdOkDe3lMdePO/W36C8kG7UTYf3dAyyDXw=;
 b=TPJ+2BE4IFssbZ2AkRy7uDn0TdhpwlU2U3CVibLRz2VbmxG0aNunOmKwxNIa83k9kFhb4sIzV
 VRp+64ZIbEEIzSuXpotPoNG2TMQVb8LSPpYoudujTOvP7BNluLm4wl0vSvjwZfGSaw+x5kfjYI1
 j3JKBoKLK1r6+uvZYUeKO/OTFtCWrbEl1xxcdy0oIYZKC9BLmZPmbxLcEaVsi2YsR5EldPk1Qin
 AYNoXHClNHM3cAs8QCzmE+ASY84YqDr/qQHJEzNDBnGu57mZh2RiqhYVzjFszeUW6h8mBELTRGC
 fMkjJOBFUysA/ucsmsfUrKr9khx25xd6QZzZiMZyWDGg==
X-Forward-Email-ID: 6a8f1099d777921155b48807
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <44dbc75b-13e6-4242-a1a9-43264f379391@kwiboo.se>
Date: Wed, 26 Aug 2026 18:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] image-fit-sig: Optionally require signatures
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260813061009.26344-1-ludwig.nussel@siemens.com>
 <20260813080943.v8.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
 <66a3267d-1980-4b86-be3a-791707373554@kwiboo.se>
 <0ddc21e0-7511-4f54-b32a-8a0163ccff79@siemens.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0ddc21e0-7511-4f54-b32a-8a0163ccff79@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Ludwig,

On 8/26/2026 3:52 PM, Ludwig Nussel wrote:
> On 8/22/26 00:48, Jonas Karlman wrote:
>> Hi Ludwig,
>>
>> On 8/13/2026 8:09 AM, Ludwig Nussel via U-Boot wrote:
>>> If U-Boot is built with signature verification but no keys are
>>> included in the device tree, the boot would still continue.
>>> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
>>> Defaults to off so existing setups are not affected; boards wanting
>>> fail-closed behaviour must enable it explicitly.
>>>
>>> Consistently use log_err for errors in fit_config_verify_required_keys()
>>> while at it
> [...]
>>>
>>>   	/* Work out what we need to verify */
>>>   	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>>>   	if (key_node < 0) {
>>> -		debug("%s: No signature node found: %s\n", __func__,
>>> -		      fdt_strerror(key_node));
>>> +		log_err("No signature node found: %s\n", fdt_strerror(key_node));
>>
>> This change is causing a verbose error messages on Rockchip where the
>> FIT_SIGNATURE feature it used to check image integrity during boot. The
>> config nodes is not expected to contain any signature, only hash(es) of
>> images.
> 
> Is the message a problem? The intention was to at least leave some clue 
> about the potential fail-open behavior.

Yes, printing a verbose error message for something that should not
always be treated as an error is an issue.

> Looks like you are also not using signed configurations with is even 
> more suspicious:
> https://docs.u-boot.org/en/latest/usage/fit/signature.html#signed-configurations

It is not, as mentioned, Rockchip platform only use FIT_SIGNATURE for
image integrity checks, and not for signed configuration validation.

This series seem to make an assumption that signed configurations always
is desired, and for the Rockchip platform that is not the case.

On Rockchip we enable the FIT_SIGNATURE feature and only ensures image
hash nodes are populated. At runtime SPL checksum validates the images
and are able to fallback to load FIT from a different media in case the
image have been corrupted, possible due to bit-rot, user failing a
firmware upgrade or accidentally overwriting part of the FIT.

Regards,
Jonas

> 
> cu
> Ludwig
> 

