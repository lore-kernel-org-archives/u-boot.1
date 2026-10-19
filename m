Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2F607249D
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rCvQOSBQ;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Kq8t6a5N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C07F6063F;
	Mon, 19 Oct 2026 15:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vq-lFu5-hRem; Mon, 19 Oct 2026 15:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C619605D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792425468;
	b=deVPFmN0LvgetbrfKOrItB04X+j2LXGRv4XCZ4WCzfCyf/OBhj0wSDJxzAa2XP0YtEAN
	 8yTfqd5DQGT09zxmAgcrudtkFbQzGFJisPAiUc/9VrmzFuThyoCZu0jWUOHthUFK2TS8X
	 N1qKm0nUri3UnqUQ2NJ/eUiRT6TsPLCx04F3pmu9ZA4ALQ5+02/kWiLUS6T3NX/bRoSGR
	 06KH8tVmbt0BrjpHQpBYncQ00puVFHi4U0OtbmqMIpObKdAFWB6KjTZ83XSDtxl7Gv5XH
	 sD56ie9EFijbrNr6rpLkKSh1fRuQ5BXlAh1uv0JTAn/5CjMQ+WJeSoaPhAYMvlPNqZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792425468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=//VDCjwu0H605uhU7378SzXVS2P2746bwl/ankVBDrA=;
	b=d9ELoGT3pga4m5stpal/od1KmDbNitYYLFjsgiE42J2p3w0GTMmPPXzcseaMLrWq5wn9
	 UIXZUPJ89J/GBovthfSCHnBwJcC7Z4ni8AR8t2Er+IrEyLKzGCPOcqt0mbCES/I58s+bX
	 kKuUQqvIrc7SNw+Cp+5XiACawMQl6v+CB+3hyr8pNjAGIBh7FdAw7+q5bL8rOmYUcxN33
	 IZLYhncNfPfhCFYPOUsT0PwcRquhEy39kK/QfWG4hBpkrsFX8fuMoIyaAN0VfUMlZHkfh
	 o9nD97c70GK1lHHs/yXiP8tPRssa3VVNR0iyxSeUhI4XvvAYcdIx2dJmpnSgXOyPQgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Kq8t6a5N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792425468;
	bh=//VDCjwu0H605uhU7378SzXVS2P2746bwl/ankVBDrA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCvQOSBQyUAHNAPa7FauWDgsIyrQQMgIUuJUMLoNBquySXz0fM0ytAGRQxM2cxpJN
	 XkbDIsJOdp8psHHiRIWInO+TUXzq7Vmmdf+hCr60bQqe/7nJKjMwaUVixRqAhaFD8/
	 oWnAiiBtxSjHw/Ssj9geoCSre+dQwny9SwBUn8MAqOwwwwURMZ79koRgW3KuTLgr3L
	 Vx3TWRjbukxad7/aQ5cKia7j7pjXZxy7AHTcuAZLYnv+nMa9Qs8ZS080pK4UspOI73
	 2S9gB0lpwxCw0/XZY2FT/Bt+N6YlbBQ5Zjmkc5nyhkb/2BDvJr9BguMRvm1vY1HObG
	 jw+uqqI2HEc8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C619605D9;
	Mon, 19 Oct 2026 15:57:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 84A461E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 812A8605D9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7zZ8EulBJyH for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 62944605D1
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792425466;
 b=Tn0XmV26RZF/TqQuE4D+rkIRXGuWbX1eR2RScbSa1M3mMrZzT5HI4VBevVUIHRn1zp74
 G0TChIACjhWKjSFcnW7VuzKU5ez8rsjOJ2mBEYpRhPIPAeGEyc9F5B1eS9/vJpgXvVDHf
 PwFAhOKvhktrCY6675T+ZUPJpErpBMgoKeMezsYcGntI3Vq6otW0s3Q3rrQ7BAEQi11o0
 xaofR46ENWY0nEjwRVgg9DtqtREd/UhL7zlEqsMBup1meUFc/0tlP0mF41m3686p08zqd
 tYgcQYBqNdwhVuAGtULnHCEvpt3+Nif6F8X1+s2Ncf/vTY03j+vzS3P2H//Ws12nOZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792425466;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=//VDCjwu0H605uhU7378SzXVS2P2746bwl/ankVBDrA=;
 b=lYzVjb2LVAfGdd7Pa/h9PHL6lStfUvPmJCCuDbe7LE7j28j4y3Yo1irnrhfR2+jvIKvf
 m25Ch6a0D/qd+Go1zKem2/m24vST/B2qbF1iClw6NXTsFKrR7fYTipFUpx8CPe0a4DZaG
 Vqd5MDIaUmla3Q3+cJXbO4crtJugjKY3iDNUl/8Znsek2X0EuZxLMf39+UDGpAPZX0ytd
 z6EgeY0bwosQitn3zhiCtCMK2jKw0H3rD5/QlnLdsltxOECm9FuTDB1/x/VsFFqRtSgHA
 fZOPXfm/YQyZk/uUm1yNsOAAMBVeBXVjN46B3hOXFA5bfnL9NzB3/iiwJkLm2owu4eA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Kq8t6a5N; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Kq8t6a5N
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62944605D1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:57:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 71E5B1050A9; Mon, 19 Oct 2026 17:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792425459;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=//VDCjwu0H605uhU7378SzXVS2P2746bwl/ankVBDrA=;
 b=Kq8t6a5NThaNJtog0OIt8/riGyZBE+mhvhutHxK7ueD6e1Ch9DMKIZY7InVmGbAjm8/jGw
 J2OYiJ/HwP6c6AIs51TRaFI9OoV5omOoZDMt+Js5mr2+AtkXIsh+mvL86G52Kplz79OSSh
 2roX+2IwZMmoTZis4MbmEDp8gGZ/5G5j6tgqF77ItxEpcIvTz8wdJAJ0+Jka14iNYX0OrF
 kNRFoWNS/WG6msehKGun/PosDwg6oivhBOT0UqMZlj0E+mNNuvAx6c/RQZzfNKpzU/K0Ge
 C4aoLBzLA559y/ui6SDLUAWRhY4aontJNVXmF46r30WgFDXSw/Gy2q4MF1+qtQ==
Message-ID: <a3ece217-3d96-409b-ad60-623a5cab07f2@nabladev.com>
Date: Mon, 19 Oct 2026 17:57:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security: "Permit write access only to listed variables"
 restricts only environment loading
To: Fiona Klute <fiona.klute@gmx.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
References: <f23265e6-5dff-414e-94ec-ab7312a0e1dd@gmx.de>
 <542b5753-9c28-4565-b03f-f7b300351821@nabladev.com>
 <0fea15c6-edd3-4f55-a347-d799aa86ad4d@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <0fea15c6-edd3-4f55-a347-d799aa86ad4d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 3:37 PM, Fiona Klute wrote:

Hello Fiona,

>>> The kconfig description of CONFIG_ENV_WRITEABLE_LIST says:
>>>
>>>> If defined, only environment variables which explicitly set the 'w'
>>>> writeable flag can be written and modified at runtime. No variables
>>>> can be otherwise created, written or imported into the environment.
>>>
>>> This does not match actual behavior, "env set" and "env import" can 
>>> modify variables as usual.
>>
>> Right, and if the attacker has access to these commands, that means 
>> the attacker has shell access to U-Boot, at which point they can do 
>> pretty much anything with the system. If the attacker has shell access 
>> to U- Boot, it is game over. For CONFIG_ENV_WRITEABLE_LIST to be 
>> usable, the U-Boot shell access must be blocked (bootdelay set to -2).
>>
>>> The only thing that is blocked is loading variables without the 
>>> "writable" flag from stored environment on boot (and "env load" based 
>>> on what I see in the code, but I didn't test it).
>>>
>>> As far as I can see, the issue has existed since the option was added 
>>> in commit d045cbacf2529266bb312add023e12c0d400bf67 ("env: Add support 
>>> for explicit write access list"), where the commit message explicitly 
>>> states
>>> "env import" and "env set" would be blocked.
>>>
>>> I consider this a security issue because preventing modifications 
>>> that would circumvent security measures seems to be the whole point 
>>> of CONFIG_ENV_WRITEABLE_LIST, and it only does a small part of what 
>>> it's documented as doing. For my current setup restricting what can 
>>> be changed in stored environment is enough, so I don't have a strong 
>>> opinion on whether description or code need to be fixed.
>> Please see above, does the security concern persist if U-Boot shell 
>> access is not available ?
> 
> As I wrote, for my setup the loading restriction is sufficient, 
> precisely because I'd block shell access in production.
> 
> But that doesn't change that the fact that the description promises 
> security restrictions that don't exist, and if someone relies on those 
> without checking they'll likely get into trouble. That why I consider 
> this a security issue.
> 
> And for someone who does check (like I did) it's rather concerning if a 
> write access the documentation says will be blocked actually works, and 
> it wastes time figuring out what's actually going on, even if the end 
> result is "what I really need works, the documentation is wrong".
> 
> It's fair to say there's no point in having environment restrictions if 
> someone has shell access, but having documentation describing such 
> restrictions suggests otherwise (U-Boot does a lot of things, I don't 
> know everything other people might get up to!). Again, I think fixing 
> the documentation would be an appropriate way to handle this, but that's 
> not my call.
Would you be willing to send a patch which updates/improves the 
documentation ?

Thank you for your help!
