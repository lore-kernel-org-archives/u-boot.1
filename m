Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A70FA3728
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 16:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DE283B55;
	Fri,  2 Jan 2026 17:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hIavFIc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D92A83C04; Fri,  2 Jan 2026 17:21:54 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CFDB83B49
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 17:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4djTV55bG8z9tDq;
 Fri,  2 Jan 2026 17:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767370909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbU+1yyxVtBOvBGZyJ101Za0e7LOf1ghDuL0W074nQs=;
 b=hIavFIc9jFKd4z47i0oPqmij7hRXXcxTnEmA1EAsNQY3kql8n326r6CYT3DtkU2RkaZFoU
 PSlnRv5FeBxzBXQk9qUbxbbLSj4M8UZ0kRg5CC4L5Szj9uY5qNBUKA73Eyq/c70oR7JJKh
 Q+8xInhiHgheym2aZhKzMcdd5UhgTHrlVPYoyUjzR7rvp50V33cbEOxqAoqobSxUGnBb2m
 18KDjIxF6jyd2TK7fj3pKA4z5azasRlVFBt5fiKeoDucJ2ZtL2M8swtfKmXPeTRO1MsMB7
 cY6ug7hXPwHLxGFSaL8H4zxViCgJ6Jtf7JxsL9UGRfUUrJDWRKvkS5vtqZSPFg==
Message-ID: <9368ca1e-f57b-403b-9d07-fc0e69d3e989@mailbox.org>
Date: Fri, 2 Jan 2026 17:21:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
 <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
 <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
 <67fefad5-ce05-486b-81f9-f28798195bc1@mailbox.org>
 <CALeDE9NVNR8pA5G6um7p0CTmuQqmK4LWLoxj--jRKnBWJ5+dhg@mail.gmail.com>
 <18a3fe38-c6dd-48e2-9273-c6862b99b7c9@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <18a3fe38-c6dd-48e2-9273-c6862b99b7c9@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 333c7702dba3e445dee
X-MBO-RS-META: zwiarzx17bn7de1ieugt377qjqa43zdp
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

On 1/2/26 4:15 PM, Heinrich Schuchardt wrote:

[...]

> Looking at https://gitlab.com/CalcProgrammer1/OpenRGB/ the protocols 
> used to control keyboard backlights vary a lot between vendors.

openrgb seems to be meant to control various fancy vendor LEDs and such, 
I'm talking about the boring 1-color keyboard backlight on laptop keyboards.

> But anyway the vendor ID and product ID is used to identify the USB 
> keyboard and to look up which protocol it uses. There is no need for a 
> device-tree description.

It is in fact the other way around -- if it is a HID keyboard device 
according to USB descriptor, it doesn't matter which VID/PID it has. The 
few keyboards described in the usb_kbd.c driver are there because they 
need quirks.

So, to move the discussion along. I can see why an USB keyboard might 
have to be described in DT. It seems the usb-keyboard DT compatible is 
not standard. If it should be removed, the commit message needs much 
better justification for doing so.
