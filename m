Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D40606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tXvr8wHr;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=QIP2/q9U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C53D88101D;
	Tue, 20 Oct 2026 10:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OT6c5o9JEj5; Tue, 20 Oct 2026 10:44:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1AF1080E8E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792493073;
	b=qNW8MB4aOto0Jr55anruNc+8dU0ejNfozqCTVnKbbp/7zCwDJpIb8d1joQzwjcDycQSM
	 9v3xUiA2gbsRlzACz6wsrMTcdRUdDwDzyUACvCufTfOXeSW9ZX4gfdZrAIZuxy5ypHfJX
	 kgSob4cP0wNzwxbu+/qqylvv6bRYDDk8Mki5dFCyNpNF6ghBXUOe+FszraDShfUhMSCbR
	 xGU+luVFh0lkK+KQRIp93ua9GhyHk/OD9tolrKpfW+dJt6qQk5bWxg2Ssud3EgljS0oyZ
	 u4YLjlWTxDtIzsCCSBmwitk58OYT8p55o5gAnAogyteU4UFHcM6LK+C24ctFd8O3GYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792493073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u7KmozUg5mfVXvlJZFeFG1AsEqrbuVptMGQGjqfiQvI=;
	b=F6VIjph5+JXpNnpzD6/TfOCfNmxGOzhftseJNpLh7okSXgjuVCwQO9OJJCVw1Hr5Jfp3
	 Pl8JppipogLxRPHOM3oWR97PXc1BjEwqfEP6tbfwsCqPPmq+IzgurelHjJNxoTgwhNMB3
	 KLN+RXZ9P1XeusAyXxvFAMKRyhD8daQGJVSDwKqCMgSrfsJeiyjYKrp6jTzMftdXQk9XR
	 z1ef3fXPU6nz29TiI8/DQgpkemYcQq3edk/FF4kgubXjrWMoUlNOCc+6uUWaCt/4t2rig
	 5lqHXBnU0xHTplTqhzJENj7Wq3wmf4ehGfBzGdmLNfUHmOBL3pUMNvNBQvmAv0DfeAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792493073;
	bh=u7KmozUg5mfVXvlJZFeFG1AsEqrbuVptMGQGjqfiQvI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXvr8wHrYE0zN556vg+04J81auywUmZxwNPP3bbzkrW5uWgedx0+Z6+Y3GE7IxK0R
	 C8NGM0rwdSglaBt0y9KidHKQ+H6r8uDWJCheleMVKw+ugRJSLh80byXBgk/TGYcO3N
	 7JCOecMBK2oXk9IlvH7xoULVRgwwU9EHVYThasrhxc9VEP6hzb0espF+PIycRqy1IZ
	 XFfHzOdZb1uu4CQypav1H6nQg+6lq58UzmXTA0BkjoJq3J15eppaYouQOKk2/J4fiN
	 pgU85YSUlbx/kS8+CMXI/Yv7GGl1qGvL3inY7cduCGRPtmGWzSkDdPFyyvhk7YKX3l
	 F6fnYkBtM5tEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AF1080E8E;
	Tue, 20 Oct 2026 10:44:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC2D91AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1C2B40119
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xX2RJZliYA_w for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:44:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 14776400FC
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792493070;
 b=pP64eqSz1W0RMOepjOrosneLslqQzt1OCkBnFeydeZI9Qx9Oy+mOuBzFTWrX4o0CyU6W
 ZgCp5ziNPaEQI6FsxLQ4piWRy59M6OWoOkDRe+750fZMysASmSnUovKz5wNsX2tjOMF5P
 Enzcr12/VPHZOJrfHgowZiGFTlrbkzUf4DFkCweu2TRAwRZ1VjFAEVCp9ZODcyDjQxKCh
 UDRphFj98cDT34dXzckSAsgftLzXtk77q7KynajvVHZ1MWKK7BaFz0yJzlzWsScYjgxJq
 UMchdp38v7Oyi0/yBxo1yCjc0RoC4wXFulXqoQviC1Sdw+uwhsckP6E3HmT08XecGXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792493070;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=u7KmozUg5mfVXvlJZFeFG1AsEqrbuVptMGQGjqfiQvI=;
 b=qGhGaiaZ5kG7GIY5Vs2paIBxwtF7482134UdppOYlFjjawMxdV6/n2cwHJbKN/Y98tyd
 7bLd4XnPdL6qNIulcPab1a8gNWs41X//8pAaaRpZehdYo3Pv4nebLFbyl+8I2ZNTWCoAy
 pkHfUV4nBxIlCgOj2gqrpJenu2wVbaDUHVqY2GoWnjuc5iLpl4cBAPJrySIARfe83gL4D
 Dhp1bwUeVtsvtX1oxGyX41Rsd0VFCPDszD9rNTVjWWA8IZDJxXGsmt9R4mW5yb//3+wM3
 IPQv5GHjL4f3cuL0LZ2wGhrnodqFZ/msba1eKCbdK8dXSFehfqG/jpu/6UtdNohDGTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="QIP2/q9U"; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=QIP2/q9U
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14776400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7AE9510A191; Tue, 20 Oct 2026 12:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792493063;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=u7KmozUg5mfVXvlJZFeFG1AsEqrbuVptMGQGjqfiQvI=;
 b=QIP2/q9U6OwilvL9tr7f6c6fQqdLjK561XhXpDjFlcRV0wnVhBJj0+a9fFTeDUyvfTc6My
 m/98xXDL0T2OJ+Lfo2le3Dw7QYJw1JmKnghxk70hBNEVjfcn/RcEeMrHjvtfhu/8fCpCoQ
 QiW6apXEXzVlkDrRF7tEB0SfVZgsARfYecyf1Lhq0fQUTwYIn78+49ls4iHFY3+BG4vf/C
 NungB1OlCqrgKYDYYjvmLWvrFaMz9MY3yEsbhaenHvrID7j4OWnv3LOuhD2xO9ef1fsesw
 4IXOugbffnfmr81/r4KOHIbCmFcv0wPIe7KGd4RUhV+KkbI3/myk19spJAuV/Q==
Message-ID: <b0bdb801-05a9-4526-abec-89f307b85cc0@nabladev.com>
Date: Tue, 20 Oct 2026 12:14:26 +0200
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
 <a3ece217-3d96-409b-ad60-623a5cab07f2@nabladev.com>
 <f27b3197-5655-45a2-9b2b-5101673516fd@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <f27b3197-5655-45a2-9b2b-5101673516fd@gmx.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:22 AM, Fiona Klute wrote:

Hello Fiona,

>>> As I wrote, for my setup the loading restriction is sufficient, 
>>> precisely because I'd block shell access in production.
>>>
>>> But that doesn't change that the fact that the description promises 
>>> security restrictions that don't exist, and if someone relies on 
>>> those without checking they'll likely get into trouble. That why I 
>>> consider this a security issue.
>>>
>>> And for someone who does check (like I did) it's rather concerning if 
>>> a write access the documentation says will be blocked actually works, 
>>> and it wastes time figuring out what's actually going on, even if the 
>>> end result is "what I really need works, the documentation is wrong".
>>>
>>> It's fair to say there's no point in having environment restrictions 
>>> if someone has shell access, but having documentation describing such 
>>> restrictions suggests otherwise (U-Boot does a lot of things, I don't 
>>> know everything other people might get up to!). Again, I think fixing 
>>> the documentation would be an appropriate way to handle this, but 
>>> that's not my call.
>> Would you be willing to send a patch which updates/improves the 
>> documentation ?
>>
>> Thank you for your help!
> 
> I've just sent a patch. :-)
Thank you !
