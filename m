Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC2606A332
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hpYPFf/t;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HtPjfPfH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DB51606C4;
	Fri, 20 Nov 2026 23:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EUe4l56ViAW6; Fri, 20 Nov 2026 23:18:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5435760650
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795216708;
	b=SiaOrmJTzekRKbtkKTSZXrusDY+31ez/+mwgUcfkAEL3/k6tQO9/JqZzACYbrpkvsNJs
	 5+iCd7zb9XkTIbGU6q6zpUlzXMCZzgqz6fNvWd6bU9PqFdmi7N5+ZShpcHeZjbFumdDf5
	 qYSqQJXTW7q8Towov7h2jl45iSEC4guuHLmqJx5vQI108uKVNkPwEyNyMiXWDhbv/3V0q
	 2Sk5NqSwG+UxEE8clKoJUdJpFsOLVBttbdjTbyowjURLQw15LcvQDpyROctOK9XBeT454
	 MkasH2BlKkC/qSdjCUayxKJrRtch33P5f+f+cheq3gSo4nKxPaLpPZ8ppCVaZsIO6Vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795216708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vr/Sc29ZBweeDmCU6Uxzf99ex9TKnNLhUbFgt5iAm7E=;
	b=BkHrMakPIRrCAUt9GYN8FD7+pzPZvyXYcOOMU3a6vPhzy3Cle+4GojjVxhxVIIkChc9B
	 VGtFx441EA++ZUeXwv5NBQqM8BLjDcC3Jr/mPrnpmaZAD6WmRhLitFy90JxiMcGIYa4JP
	 XmeQX66LsA2ScOfwAvpfHXOWwZgofg24C9QqWY1HxmoCOinpn+2C/WzpXGXeqkkQQ7PZa
	 76yFolm2zNPK3JDvrTLAdbj6TaciXHb/DU8G7+JbnXVBplFYnKB5ap+JWDdkuBXgNiv3h
	 4FUhoql1jv03G0us5HyGDtxKinViks+uyXNZ73SumFFsh2lFb77EvYM0hQnh/Q2DxzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HtPjfPfH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795216708;
	bh=vr/Sc29ZBweeDmCU6Uxzf99ex9TKnNLhUbFgt5iAm7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpYPFf/toGhrCDA8l3f8bGK4nw2Ne+ayTBE+VL3djU0QMnoCLrnj4NxKMD/99NOji
	 hLp+/kQG//AimER5mjS5QCTQwumDo34z7sCKrvBWmUJJmPkHoIN4gECdvx26g4AEjU
	 IHKvdQ6lY09R347AbgNsFp+vqpQZ8CWHfJc2bdjEDuXSlql1uuG/wDPeCTcLrSkfUW
	 IpJQimZijo7ufR19vNihUVFqVTf6E2lwc7R08LsSvmH70Laf3uptBK5CxWLdijPLQJ
	 VXv7m7dTITbXMXMeiV6IrPO7/AwN69dJCJtxFPOCv+qXhIhleFSqZD2+mKVpIbJpnS
	 7QeUa5HYwCISA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5435760650;
	Fri, 20 Nov 2026 23:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C39F51C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 23:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B56D160650
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 23:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uW19rWv30M31 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 23:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 747006063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=HtPjfPfH
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 747006063E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 23:18:24 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jWWV468t7z8vJY;
 Sat, 21 Nov 2026 00:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795216700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vr/Sc29ZBweeDmCU6Uxzf99ex9TKnNLhUbFgt5iAm7E=;
 b=HtPjfPfHfTjSOwNhVCeFNc1ICJbw/+osYbJWAt92grISnvuPCOY/cnClhKiRSVhDicKPNh
 OBICxkWtVI5Yt4FY8g+eXt//7fLU6mlckWNn4FQhRj8Epyf4jf0nRV+YqBquNCARWQUhMf
 QoFQdstl3yNIj4h3YUIp3XbPBm/QTo6FjAf9gaw33VpBK0bGwlvrgrMdgaXE2UyvZF/b+m
 7K49OOxV5L/t3IKW0ajcyBCBWkEmuWow5cAmRaxUaaVrm60RGBcno5BpxJbHS5hJfzqJEZ
 vf5wBvyDhO4RvONpm53fmbo7h7q7Jx3fBSBnzpEOkMoBxUye1jm7KbLfmKImXQ==
Message-ID: <afce74bd-8bdb-457a-b2a8-31f5211b0a7e@mailbox.org>
Date: Fri, 20 Nov 2026 12:02:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
 <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
 <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
 <562c2c54-d943-477f-b9ab-2cbe6f1b34b3@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <562c2c54-d943-477f-b9ab-2cbe6f1b34b3@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nbhggpccdupg6erugqfpew3qk3kmeysi
X-MBO-RS-ID: 448f88249abec26e325
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 9:24 AM, Fabrice Gasnier wrote:
> On 11/19/26 13:14, Marek Vasut wrote:
>> On 11/19/26 11:59 AM, Fabrice Gasnier wrote:
>>> This hub is powered by digital and analog 3V3 power rails, so provide
>>> the possibility to use different regulators for digital (vdd) and analog
>>> (vdda) power rails.
>>> This is inspired by the Linux driver [1]
>>>
>>> [1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>>    drivers/usb/common/usb_onboard_hub.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
>>> index 0c84c1fede03..4b96defc2d93 100644
>>> --- a/drivers/usb/common/usb_onboard_hub.c
>>> +++ b/drivers/usb/common/usb_onboard_hub.c
>>> @@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
>>>    static const struct onboard_hub_data usb2514_data = {
>>>        .power_on_delay_us = 500,
>>>        .reset_us = 1,
>>> -    .num_supplies = 1,
>>> -    .supply_names = { "vdd-supply" },
>>> +    .num_supplies = 2,
>>> +    .supply_names = { "vdd-supply", "vdda-supply" },
>> Is this an ABI change and does this break existing users ?
> 
> Hi Marek,
> 
> I've tested with and without on stm32mp157c-ev1. There's no breakage on exiting DT.
What about other DTs that are in U-Boot and possibly not OF_UPSTREAM ?
