Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549A9C98306
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 05:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0FE9811FB;
	Fri, 25 Sep 2026 05:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h591Kl89-__C; Fri, 25 Sep 2026 05:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 16FBC811F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790312960;
	b=oYhkK3lvgsYpzrHnVHp0irY/Wlk3/56wlhZin375fyLMe90FX+7+zuGVmPawfa995L9r
	 QxFq3hHb6ZGluIGFZdV8EDLBiX+ysATLe2zuNmIa8y1fLp4NKMaDp3g/eueeqoyVpW0+W
	 7FcJZBEh5iAfhfEpjhbUrAXbqy3t1EkRRZ1DYVzfZzJ8udNtyH6p+whJMsHvdFW7Hv6da
	 XsMfp0ucj5iv9fM6Kb/nv57OVNGUoAD2nd3T5XkH/kkIdOtqB6JoSEA0bYV8Bhj7/O+5/
	 qefhI1NPKiANxyIAIvwjhfgWQnO/aBDgyb3hyuDv4zyFNRblNGzJhy1siTgFEdBwRag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790312960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6jgyeAys73Pq3rWyf3kOK8E3tX33TiQqegPEnRbFXc0=;
	b=LPyqWKqJE72srxdDAQ7a8EOHKegnXTbEpJugAFK33X7VkahO455EA2yWjDvFd4oDJEbL
	 LYdqqfgTdugd4UHmjkiwmyDbpcXUAjNPGtI4o+v9eBnjSUmd+oqpx9dld3vFQESSdNu0/
	 WKtbyvPuKizVFuhmeMp8Im1AhsJwumfUlJx8s5xz8dfrEy/FOJ4515lkdArzTCVoA7A2f
	 qgnBvyI69y14KUUMvzWoQ2TsdRor998ffQtYTQzfXMG9sZ4r4VqIwHrKOmwm1vMTAt7Pp
	 Ql6N2BPyaoxPvdVf+F4mIWb2hlnsbtnnNnjB+3bnAgK7TbZ7OioOkOSm06spjN1GfFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790312960;
	bh=6jgyeAys73Pq3rWyf3kOK8E3tX33TiQqegPEnRbFXc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YiNYyGPTvfia/ljuPV/tL7sL7Hs1w/P7Hmd+Kl4m9dk1iWW5hix+Fv2iQa//LMyom
	 pFxAVjq/iLuMBJNs/kNrxBHzzCzYjveyaYAUHOeUsAz1r+1nMJa6eXQEy3TR3jpSig
	 RJoyS7PErsxAAyT5a0Om2QJ8W2sy/xK1izRJB0FdCgsnWKnYyxlhDy7X5PB779KVHV
	 VvU6mXcL1L87FB+eHIRnrSf29QEwbh+0mk2hlumPb32nzEMlp4ddOtrSXL1+9mPDm9
	 hKuOaJQJLqoGaLuVNa8kX6BX7TyJtdFHuHeRaRSW76kWEiFuJ0p4PhiMhlNF0rzcxe
	 5LqngIOA7rXBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16FBC811F8;
	Fri, 25 Sep 2026 05:09:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E95F9329
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFA5540520
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:09:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbPXPt0rhN_O for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 05:09:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 982F940515
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790312956;
 b=VXWJ3UDY0vyKbYCWz/AukFMzkAeKhrZj6hxMi5I9lyUcjWLIKO/88Ww7cVfd2i4AK37C
 gfK2JkB6pBypViZzaKmrrLTuU93pUhsSUKpQ+gtrzZYt9/XZ63PpvA2tLh/VKE2N1dQ0h
 gPN7xkd8eMWoS9k4ctH2/rSX/AKHmvnI1/3xv/j20/bj0LcAqnFdM0ZvGXly2oJow9gEX
 mfjYnX6sHl1TYJnWuY1NGQ8w/uvXqSmlijBiNmb4huRv6J0lRw+7h8chTFor5Kz9wTObd
 9VlYn6VD3vN9xbiDKzLpnrH/s1t49AH1zbAzmhsbmy0m4oOsMT8XgCiGd/kN/3d94rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790312956;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=6jgyeAys73Pq3rWyf3kOK8E3tX33TiQqegPEnRbFXc0=;
 b=Dxy3+nO1cRi2v+T15a5sjE7Pt/LBxg3fFRbwtgEuzQWizOVTzeH5vNtbN9KVvywxC15l
 xNH0T+HhxnSqW/iI4vlQVKdQ4VRmYM6nWBGLHmufQT8eMYcGdQtzOb06fWeX3CWgYC29J
 wpqWu1qLrKUgGpFZu1Ph18mosUYsZtkGwQUc5DUwdpYmPWYq6xRFQXsl2kZdCwWT/cHqr
 R+MufZ2kSUzP9H7MwtnYfJR91fDaQhDVvx4S1uFDlzL1GyWeA0gSCLdCvD59uOmsjKFny
 R080o+rb6UYfIADIYu62u/P0Y9EeHWijQ1Fc4v87/N6SZhJrmsR2z3swrAXvm/XZy5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=IRrxDQtB; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=wlY19mge; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=IRrxDQtB; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=wlY19mge
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 982F940515
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:09:13 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hrdz96xGmzMlFV;
 Fri, 25 Sep 2026 07:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790312949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jgyeAys73Pq3rWyf3kOK8E3tX33TiQqegPEnRbFXc0=;
 b=IRrxDQtB9Fwj8zVSiSSLI5o0sx0AB0XQAeOZeRFelqGEdhoqFgsUpMb/9oBxHtQUM1BYG3
 5CYPH4DE3lUU0/kmzuDHwqnr0jhMwkZjbWHvxXCfWv0DVFNVxAa0djzm+4BQhb3SJmRXUx
 SzP/nAj+Kfu3cuK5olgbDKmFcmDN/QtSSZTT5GqEq70n3FlYa/BTab5K9dIbFqV0BTeYmj
 gdJqBRzO7wkl+PvWhfS4cYu8vCgCnBhp/n+/UX3uBrKetMou8RiZSnV0auWfgFF/Nh/VGD
 YC64tesZIoxkFdU5BGHUrK+k5jKEq9SyGBCGJp/psD1PM5QSf8nrpspwv3La5w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wlY19mge;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <eef0e4e5-398c-48f3-ad93-4c8f58861c4d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790312948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jgyeAys73Pq3rWyf3kOK8E3tX33TiQqegPEnRbFXc0=;
 b=wlY19mgeogMjGJwe3luURs9PtERQEG9UFo/m9h2rj2UzAPoYVizURJOIni5AhQloy2uoDe
 38fInET8qFpX/jLx6uSuD+/hSpBdmrkzhzgDJ0VdHMpIlATG7CQg7Ym8ElamEvD8D8tm4J
 zL6j1Xe8Ke2Wo7g+Ed94xc7P9poTHByUX80YSivsducQPDtfloOdmwo9Ci6zsJVbrWV3PK
 nOGvw02eRwqVN4Jkh2SZyFnc7GOoO7troT0qS/8EjCbcjV2GHYGPZ7ojg6B5zBTjv0K9Ep
 KdC31OpTjBJido/oTqVTYgpqAoN8SBTQVVB0+gPOiCj834rs1MM7A2kZHcO1vQ==
Date: Thu, 24 Sep 2026 15:34:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>
Cc: marek.vasut+usb@mailbox.org, trini@konsulko.com, mkorpershoek@kernel.org, 
 stefan.eichenberger@toradex.com, hayashi.kunihiko@socionext.com,
 Tom.Hsieh@advantech.com, u-boot@lists.u-boot-project.org
References: <20260922204329.311571-1-eichest@gmail.com>
 <65e822e4-5edd-4d48-8bdd-f7a614925a73@mailbox.org>
 <arUc4cNrKbx71ms7@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <arUc4cNrKbx71ms7@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fn6tk7q8dja1gztn3k3hygnbx3pd713q
X-MBO-RS-ID: dbfee4a0f251c1a7d29
X-Rspamd-Queue-Id: 4hrdz96xGmzMlFV
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

On 9/24/26 2:51 PM, Stefan Eichenberger wrote:

Hello Stefan,

> On Wed, Sep 23, 2026 at 03:30:44PM +0200, Marek Vasut wrote:
>> On 9/22/26 10:42 PM, Stefan Eichenberger wrote:
>>
>> Hello Stefan,
>>
>>> +	rc = clk_get_by_name(dev, "ref", &clk);
>>> +	if (rc)
>>> +		rc = clk_get_by_name(dev, "ref_clk", &clk);
>>> +	/*
>>> +	 * Only fall back to the parent node's clocks if the parent is a
>>> +	 * dwc3 glue wrapper. When the generic node is a top level node,
>>> +	 * the parent is not the glue device but a bus or the root device,
>>> +	 * and its clocks are unrelated to the controller.
>>> +	 */
>>> +	if (rc && dev->parent && strstr(dev->parent->driver->name, "dwc3")) {
>>
>> Could dev->parent->driver be NULL ?
>>
> 
> It should never be NULL. This could only happen when we define it in the
> root node but then it should never bind. However, I guess it's better to
> be safe and check for NULL anyways in case something is really wrong. I
> will add the check in the next version.
> 
>>> +		rc = clk_get_by_name(dev->parent, "ref", &clk);
>>> +		if (rc)
>>> +			rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
>>> +	}
>>> +	if (!rc) {
>>> +		priv->ref_clk = clk;
>>> +
>>> +		rc = clk_enable(&priv->ref_clk);
>>> +		if (rc && rc != -ENOSYS)
>>> +			dev_warn(dev, "failed to enable ref clock: %d\n", rc);
>>
>> Shouldn't the driver fail to probe if clock cannot be enabled ?
> 
> Yes that makes sense, I will change that in the next version.

Thank you!

-- 
Best regards,
Marek Vasut
