Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE01ECCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA1583DCA;
	Fri,  7 Nov 2025 17:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tYY2gDjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B4483DCA; Fri,  7 Nov 2025 17:44:43 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A9583D2E
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 17:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d34fH5tJ7z9t7g;
 Fri,  7 Nov 2025 17:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762533879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XE43dNvm6qSNrcv0JhKqqibNtLg3pf75E2sUtztyrw=;
 b=tYY2gDjtO+8wbIk1t9+4hylCP7HVeXMe6l7rZ4tUQrlCjTKrIKd770cMY96AO+Xaa7D6RT
 Qe5+iO36KaIO6NkNDEQgZGLezHJpF+yvZkev+fb0OGT+fD2qxVeV51klGjQU65nvaZT+c9
 4vqNyCWkQvQBKmkF/GRPQ/05QHvZqj5ERKveaSUMX9Wmp8L7vHzghswd38F9a0xBkxErYj
 r9Y3FRjQ6kcwxaboSJfapkKJtCBWMgHkw8PkHsoTckb82HsXu1APyR3dATN74mkWD7XB6o
 FrUnfKRBdg/EdpaOkHD3R2d0triVyzlvMDn6EhFhdsnVs2/h+3IgZET25INE1w==
Message-ID: <4b14ce54-6ba0-4e35-abad-6787b2d994fb@mailbox.org>
Date: Fri, 7 Nov 2025 17:44:37 +0100
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
 <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
 <20251107155650.GE6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251107155650.GE6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e0b8f22ef7bb890b09d
X-MBO-RS-META: 51hf3sm4j1zcdpuc9nq19339nidgq95d
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

On 11/7/25 4:56 PM, Tom Rini wrote:
> On Fri, Nov 07, 2025 at 03:06:47PM +0100, Marek Vasut wrote:
>> On 11/7/25 10:12 AM, Heinrich Schuchardt wrote:
>>> On 11/6/25 22:08, Marek Vasut wrote:
>>>> In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
>>>> DT with U-Boot extras, to show how much does the U-Boot DT differ from
>>>> the base DT. This is particularly useful together with OF_UPSTREAM, to
>>>> minimize the diff between upstream DTs and U-Boot DTs.
>>>>
>>>> Example usage:
>>>> $ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=1
>>>> $ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff
>>>>
>>>> This still has a downside. Even 'dtc -I dts -O dts ...' applied on
>>>> base DT and U-Boot augmented DT can produce different phandle IDs
>>>> for the same node in those two DTs, which results in a lot of noise
>>>> in the resulting diff. The only way I can think of is to patch DTC
>>>> to emit full paths in those phandles instead, something like a
>>>> phandle = <&{/full/path/to/remote/end} ...>;
>>
>> What bothers me is ^ this part.
>>
>> Hello Heinrich,
>>
>>> Without documentation developers will not know about the new feature.
>>> Could you, please, add a doc/build/ change in the next iteration.
>> Sure, although I am not convinced it should go in in its current form.
>> Please see my first line of comment.
> 
> Maybe we put it in the u-boot-extras repo for now as a standalone
> script, so people can be asked to run it and look at the output?
I'd say no, because the output is full of noise unless the phandle 
non-resolution gets somehow improved.
