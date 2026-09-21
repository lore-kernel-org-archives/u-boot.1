Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8404AC982FD
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AE666069C;
	Tue, 22 Sep 2026 02:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKIRsHomyHHo; Tue, 22 Sep 2026 02:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9AD606066A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790045093;
	b=GwdC/gDFLrPs3wgkg5giiSVlLT0EttcCmP9xniuqfDz5v/QA4Uu5PAxGzCILQ09Sgo32
	 8fL+3x075PnbdNBZ+XvskapMRGp63a/sqUr4rmF2tiHfZ37Evo1fCvAx3AlOvH/dzb8vZ
	 cGB5a02lwO+bNrF9+vVboWoztoFqtrztL3WwuwhxdmIQfgsL6mH4BShmjXGrdgyOCyuJP
	 vAxTbPQ/Rs6iXSKQA/fZsN7SEPt5DUp6+MGDjk69i7/3/ZRnvm+Hyg6zp7GByZ4Aw+5Nn
	 EjlRs2jwCfOAl2WfzqNNaqCUZ7zi/8nU5KCXefqnL42oiyySAq7ADazmT+BuroRilEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790045093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=muHHefj6jJMlhNVVv3+fR/5I/WfIVsEcdXkGPzEyLvg=;
	b=Vxm6IMGtEtQZrYGCtbQXlFsN3hZAhwPMUqLoQy1zt+KMM+RA8j3G6JGimrXnh/U4N/a9
	 q3/3KFrwkVS/IhjOi/MV4RPMOG4mGp57LfUOH1TBqkDmU+Giy8QlNWwV3GJFTiuJUzbyu
	 9DBpcTDKEv/cH4OuMstafcxEZFeABmJ/I6rZAekpauiO45zk8GCx9jyilb6MRWNiMiGMr
	 9D8VO7nef7xE4vLxen6BXuaSo3vDFo6syjHJxh388CozUiZe5qXTJ0q+G1wvphYR6LpKT
	 +gBOMg3hDQ5EIRFqo0UK21rMnfOrkNtfYDjwTFfPqzEzbqjYf3H6vpSWaoMBVjKmQyA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790045093;
	bh=muHHefj6jJMlhNVVv3+fR/5I/WfIVsEcdXkGPzEyLvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AuHoCifQ5/fC2HZeetatEyTEe7mm6U/6Vkfc5wsgAEkYViVJ6AXbH7wzFd8AWP6kB
	 cGkH6/W4IXD6LH7tqgdK/65uEOKliz2hiJig84/BKSIU2K91iLOLiBx50SoC6l+ci4
	 Q43rUzCzUJcrsOSKbThW8vGtnRz65x7QXfvyRL/f0NvUu9Pq01hmg5RPiMpoZynB7N
	 hbt9j0gpiRKVb/RYmSSsmnqdrLEzHYBeH/gexHTn/9KVLAogkpFIDqK/tAr3lt9cqm
	 bg+nq9EUl0XMKAlD/3IuvxnVD/HkI1ZD6upWtqV/XHOAD3zokPniMQXRJf50LiFwRV
	 hUTV9/8DN1xjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD606066A;
	Tue, 22 Sep 2026 02:44:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAB1F352
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0BB280DCC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7uEkiKIBShWK for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B087180D92
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790045089;
 b=CTkZyTvoJF/73C3CrfkpL603LWnVZ6KXftAZWbJK/HnEsyBrnONKvilF+xyzXrIbB0rx
 gm8z7pDUVLfIyB3EuTG6ff2WscY9FVTgHTZhTzA9WEFQjxtfPTEySnw5fZ8vUBxnV+i6T
 8xFlYIZf5ujHRnuN3LK0l8s51nb7WlmORE6Dxvb/Yzq768h3XFUzmOHWLABI+VxUZJCbb
 wl/0qa4bYE8pOJRxdDUkx5ESQdi2u36GrWpjhbEbYiv2MdALkCH72uVfhhK/kcUNWdtOh
 hLWDdWHN/EYpl05I4fVKs9TEYljzEZnMDAS+yBLjClO1VfekI+HceIC9Pd/uIYndhmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790045089;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=muHHefj6jJMlhNVVv3+fR/5I/WfIVsEcdXkGPzEyLvg=;
 b=i+yi9YiitJmGtaPNAywZTiXjY9OOAKtLD+FCdrRsJYZ+w1jHoK869aSPKWWUUFzBLagY
 KPMyEP73XD0tYfTHw9vFOOajJvnK0vMr4Wsb2YppIHiSNut12cgDt7nGUuEdHpp+OwdFG
 hsiEiOD3k0KoPFa1iL2zB5RhKV5O+880RRjjPn2FeQboCqogOiEDx7BjDBLUs1SYr7Dae
 eJHt0DuoaBpx++++LRfT8MqQRP5hUOlf8pOV+xgN8KztlvjqznJHI7YpNM2fyTPXA3/t9
 KWGGLH+KQtS6TnJHcr7E679tXd+jaHh0DqNcRGLIDG9cRGrDYrjEySkI74J+C6jxacA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=FvIyE5K8; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=FvIyE5K8
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B087180D92
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:48 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hpkvt5CsvzMlK6;
 Tue, 22 Sep 2026 04:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790045082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muHHefj6jJMlhNVVv3+fR/5I/WfIVsEcdXkGPzEyLvg=;
 b=FvIyE5K8fqObOZy7Vl6Oe8dHoNKSXGs9i4Wm1fo9WhMT99TWEVhnxfNxOq23XV9VvwHX/w
 xZq83BRyIXkkxmzyvm8uWbMcGVO3IQ1rncY7ZFSOQsbGXbwtYR1Ffr0HKqOn3fNgEUwhY+
 iLkYXYQBdd54rK9RIz+wcAMcvg/3Xym3FR6tc29jb6g6bw7ZsZcHIVdO6hBAA557Afp+yG
 SL7uRSuT9Nyx8LIlUG9o5cII6z32BahtW1od35M5+Sf84/ZlfmrkgmYih8V8B2NuMGCSEj
 mFBxiFABXk1haUB/0ZSIsESm8ISWtJxpkRD+HUIAbX+ciNq1v6ZJ9My3rj7YlA==
Message-ID: <5cabc7b3-7342-4f06-b577-860583eac6b1@mailbox.org>
Date: Tue, 22 Sep 2026 00:00:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
To: stevenjoezhang@gmail.com, Simon Glass <sjg@chromium.org>,
 Eddie Cai <eddie.cai.linux@gmail.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fe0f6cd35e548d091b6
X-MBO-RS-META: gww8iw49dxuk8iecjdyyyt6g5h6p1pc1
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

On 9/18/26 12:11 PM, Shuqiao Zhang via B4 Relay wrote:
> From: Shuqiao Zhang <stevenjoezhang@gmail.com>
> 
> usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
> The high-speed RockUSB array does, but the full-speed array does not.
> Full-speed enumeration therefore reads beyond the array and treats
> adjacent data as another descriptor pointer.
> 
> On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
> started with bytes 09 04 00 00. They were interpreted as pointer
> 0x00000409, causing a data abort in usb_descriptor_fillbuf().
> 
> Add the missing NULL terminator, matching the high-speed descriptor
> array. After this change, RockUSB enumerates at full speed and
> upgrade_tool can successfully read the eMMC.
> 
> Fixes: bf2b72bef14b ("usb: rockchip: add the rockusb gadget")
> Signed-off-by: Shuqiao Zhang <stevenjoezhang@gmail.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
