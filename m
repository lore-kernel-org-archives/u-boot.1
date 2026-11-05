Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60629606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dOfVjyla;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tRpG4sfH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 865BD408E0;
	Thu,  5 Nov 2026 21:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ll_2U5hMfQvq; Thu,  5 Nov 2026 21:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C7B2408D4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793914252;
	b=PfSQds3lw9K3Ot3fSx3PXWgEVVP+0D9yKcckrdN4nqTXZ6LFL4LwnjzbTu0Vgt68Ubrr
	 7NKIoP3FJzxgkLs6xhPJMlmwhMXC8rO//OmzamA1KCmxU84gB3Vb7v+r5bTBhB43eP038
	 9D9fHhxQfKi9K4sYfjV37NyuzAahjOH+BB4DwC4yZWHLAl4wdGN++xk5uYtalcxuCnBw2
	 3ADV4A55VvfZRkrBr7Aye0RrPSXN19oaIQP+HazbAMSfno7GqlKgSL3H6Ki5LCWIe8sib
	 l81N/GvhvJYc6hU8N2IAfvY09wxxKMvEyDzhMXMbkDbePc5FBx6JEqhKBkN287oIrDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793914252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C9fAS3/K9iwKs92qgim+XdLFEs5W0ZcHtDQPV6Glf4A=;
	b=F6vsd+PKiGhNZbV9fLpFNl8SpdJKGalG5PjAaDA3Q2DsXNSGGcq38RuHlr9R0KnJAMAM
	 NhzxexwK3cz/Irn9AhAdEQOgRVgiSSoeMZqq6/HCHJBKEBr5GO1A/nPtWIvU/tJfGC16w
	 zN8Krx1CBgmBDisDcEIwTFHgJcSOcZus0/yc+avglHRJ2PAAK68xcGEfRBTuaYX6fJefL
	 pehI7XYwyXqKP/q/QWV1bQL9/xm0WaWIm16xdk7d6xicAd4Z749VBfEXLYZ3h0p7kc53W
	 S+/bor0cejrPOR0yW+voioz4uKksTtP9zMWD7IHs0rxqC03JcreSWAvi/rurq0IyUXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tRpG4sfH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793914252;
	bh=C9fAS3/K9iwKs92qgim+XdLFEs5W0ZcHtDQPV6Glf4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOfVjylaCL6Ct868piCM12sKs6sQngRuzw6SOyRMk42lH2PqI7OJQBbCE+UE93nUs
	 9YNpblWxI4YVLSokZI9NWPJiN1k0tJI0+9fr1h4lxewdyr0PyRcpMmqLbBZ28G71IF
	 Dx3GMvmCpLbNgP1rOVF+8DR1mEPHcI3TA/PR9ERIbWkjor3K59mZipyBOK2mUTJDKM
	 avWW0btlUzqLOBTGGKwTmlh9t+wKUccXl0DopZOv5ikXjCMaxPC4w2DDtNCzfxzKla
	 Kq9AXCPpAg2GsO4JJF2eWR3PQs+zJ/3PLZRJ74dFxivm+JCLMYvEqX/rPeUor10CmS
	 0q+ERv8k7WN2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C7B2408D4;
	Thu,  5 Nov 2026 21:30:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35348137A
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 21:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26302408D4
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 21:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqxehb9YgUpB for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 21:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE6734089D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=tRpG4sfH
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE6734089D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 21:30:49 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jLFpr1mZ1zKmDg;
 Thu, 05 Nov 2026 22:30:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793914244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9fAS3/K9iwKs92qgim+XdLFEs5W0ZcHtDQPV6Glf4A=;
 b=tRpG4sfHqwtxH0syqjqYYYln9spn36GKzDtggvLsms+LKb+dWThq+6YOR/hFWG0A4Mad2Q
 RcvBNLHvKzYW52g+h823UcDrV9Eqw/fC/92mla2ZpgxMAQAA3pNe3q6rX6vGtr45u0W14/
 MCqK3IXIXoh+4ivF8WlrUreFcfGelyGnt91XpNRV1WlslImLw0svI0RoA+d8yzlbMKhmsq
 z1GW6XU+jR1T97acuJ6b7x8y9V5NgFAX9O1l/Wv5PUd6Sl8WiSF3dIICzefeu9OGCXtJu1
 wrGwhDuIQKHzy31baZvKmKGqoMSuG+iN+fYh2LAJqdTDOnEDpS88hxrsMWKLaA==
Message-ID: <137d1afb-e65d-4d33-825d-c02fdde637b1@mailbox.org>
Date: Thu, 5 Nov 2026 22:30:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
 <20261105194153.GP1164024@bill-the-cat>
 <05e08b26-3dcb-4491-bdbb-77c6fcd5e847@mailbox.org>
 <20261105212346.GS1164024@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261105212346.GS1164024@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b9e6891682197494ea4
X-MBO-RS-META: 819omjc18m7nhsgbi1co94amwf91rzad
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 10:23 PM, Tom Rini wrote:
> On Thu, Nov 05, 2026 at 09:03:55PM +0100, Marek Vasut wrote:
>> On 11/5/26 8:41 PM, Tom Rini wrote:
>>> On Thu, Nov 05, 2026 at 08:10:26PM +0100, Marek Vasut wrote:
>>>> On 11/5/26 7:51 PM, Massimo Pegorer wrote:
>>>>> Hi,
>>>>>
>>>>> Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
>>>>> ha scritto:
>>>>>>
>>>>>> On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
>>>>>>> On 11/4/26 3:29 PM, Tom Rini wrote:
>>>>>>>> On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
>>>>>>>>
>>>>>>>>> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
>>>>>>>>> configurable boolean, and update all defconfigs and Kconfigs which
>>>>>>>>> previously only selected REMOTEPROC driver to also select REMOTEPROC
>>>>>>>>> itself.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>>>> ---
>>>>>>>>> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>>>>>>>> Cc: MD Danish Anwar <danishanwar@ti.com>
>>>>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>>>>> Cc: u-boot@lists.u-boot-project.org
>>>>>>>>
>>>>>>>> Unfortunately this misses some handful of at least TI K3 platforms. I
>>>>>>>> think using qconfig.py to confirm which configs have REMOTEPROC set
>>>>>>>> before / after, and that they match would make sorting that part of the
>>>>>>>> problem out easier. Do you have time to do that, or should I pick it up
>>>>>>>> and do a v2? Thanks.
>>>>>>> I can respin this, but do you know which platforms got missed ?
>>>>>>
>>>>>> I lost the list, sorry. It was a number of the r5 builds. Perhaps some
>>>>>> fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
>>>>>> and without the patch will quickly show which oens it is.
>>>>>
>>>>> This is the result of comparing the two qoconfig.py outputs:
>>>>
>>>> u-boot$ git log --oneline HEAD~4..
>>>> 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC options in
>>>> REMOTEPROC conditional"
>>>> 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
>>>> df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
>>>> d1d45c926a5 (origin/main) Merge branch 'main' of
>>>> https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv
>>>
>>> Wait, your new patch didn't just replace the old patch?
>> Nope, it is two patches now, simple clean up one, and more extensive change
>> one.
> 
> Alright. I can't reproduce my failure either. That said, should I just
> squash these two patches together, along with adding the fix for the
> newly added TI rproc option and post v2, or do you want to? Thanks.
Nope, keep them separate please, they were intended as a simple fix and 
larger rework. In case the later breaks something, it could be reverted 
separately too. Thank you.
