Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543A0C982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 08:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94338405DD;
	Wed, 23 Sep 2026 08:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOlAF3X_TaUJ; Wed, 23 Sep 2026 08:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE466405D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790150560;
	b=AlpV8SFvPplCIhTamtfDQPncXiih99z5C0t0VMt9PSi82tCIiaOQtHZxOKqJfpGdNqCu
	 yQ/ZPBpau3vgmWv/Az8w599H2oQJmVoMTw6vm1YJ5wca8Oao/jqq2asFtXku7aLBFPDtt
	 ur6CbU96a6Bk7Zuz2x7LQgkYnQBIKnB0DPpJUrWFJcraumotk/rsnLFv2lEh3EJbJkBHa
	 fiGIgxCltqSzEKo3hrO2aTVBOl4RcxHqZsU4eFDB/UwolALeBqAcRAJh43v6X7apZOsaz
	 xdYs/kDyzoPt0XrZnit50qFgBwxkgwQJVBKcFkYgM1Bxu7FtfBhls4eYEfu2sOdor8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790150560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x1TsMr1/ncEgRRm2LwLJFAQnnflejAA2MZPsKjjM/64=;
	b=crx8tkUn35am0t+eEWaGk+N45xmGM8jGp6lavg/wRq4gXoGSy/XqKiis4LFQyaQ3jev4
	 oopcOgovWIKfgyVfyFsveIYlVCTs3QfAWStzKKQz48vekRnepDZOCYR6I1IJknsi8yOu+
	 vrGs3aUdikFpxXFiV8o5BZGK90PuYh8s1Vb2bLbXs2bvTUYrinvfc+rz1tZfP3JStZe1a
	 CsL233KNb/16SbC8gtdA09nr7ahMaEYk6zqQ9RgWvUwi35KZWwQc4CGafOwlbPqUqwQUx
	 86cKWRHu4SkiD+sWAHhMBHFsV0xIPQOBRUDAtUfWVrmpBmpEvOD3H8oRuBRilWVk6jw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIksx580;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790150559;
	bh=x1TsMr1/ncEgRRm2LwLJFAQnnflejAA2MZPsKjjM/64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJLSzUNc5SqPAEsdj4boooyHWI1OLBdkcXQwsVgaVVlw7lnfNU4tfdzfpwwCkLc8u
	 W4yF9dF4uz2K/lW1Q2iKMFCtwMZP5BkgXRy8dNnShd0fH1f7KdQnrLGHLSxWAfLsJl
	 icWLEeAQNwwZtGIRzX+s2Md57WkBla+39qKXyTKFIr0y+2fe4S6NBT64ECItO6RAAT
	 2d1QkBDlHV7cpOkum3t0okyEKcKq9xZSYdO3XUvWJhm1VIauwRkRgG7jqSW65t74T0
	 6R5Hf2S+m5m21Y8FedcaYjKX7R6Ksb0Ofko7QVqyelnjM/8p5vz3miwL++rN8Btyq+
	 1lW/HwhuNSFCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE466405D0;
	Wed, 23 Sep 2026 08:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A39B498
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57CFA405D0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wP3_z7_3u_Lt for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 08:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC073405C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790150557;
 b=SJ9CtbPgIn7dcoS+0tYLvrl0eXNxiv8yEYSVKxN+/R2gEQZ3buWqy5SYieK2v1DpY9MH
 QJo7n7OFmyDMXUCcpOd4E865KqT5R6M8l+7hy56bFSlD+zXkw5ZE7XmzwEgksKTaMvzVH
 3+afGEkLObS/qxtb5pbL5DzOYIDnYL5qfA3U18hsJWXvBfNe9ALa5P5mNIGQiyB8mIwZZ
 fk2oJ+Qc/IRUNIG6j8M2GPdEzHpnh6PNkhSKnEAbIzKd+HmukPFeokiZjLsukHQCKtzWU
 RCghaPHQ0SFVDs8IR4XeFuLlySTT/W+EHi4DaTreAju9UuvZK5uM8UaL8uUArOVFKbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790150557;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=x1TsMr1/ncEgRRm2LwLJFAQnnflejAA2MZPsKjjM/64=;
 b=T3brNZMI6EFPI+OoMLBkJvtrylwHFvE2RvjO9gKXt4PvZC8KTqYms3lLJ7QC918Fx679
 VQMZxvkR6PfPr28StsGRjWrCn+T/uwraeyo5d4nlhfrXwqpk5fqMY1iFZ4yLSii67BZ7j
 0MPPmL6vP43zViDf406TnoEWFDcxZaGrPv7Hr8axn+2dNMeoLLkky6qX4jOn7PE1hvYlB
 OWh5Yv+GRq+I1+y5RL4XmhdZlLMNg/LSDx0b0FhlyZ+ZkzEqyM89eIL7gMBGtdOMkykm2
 wcbY9HRFRyFUjdJb3g0so4EkxhIgKkay8Vxdv7Ks7aU7wIBwnH7TflfqfaqAMFFIrxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jIksx580; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jIksx580
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC073405C4
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:02:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4448E601F0;
 Wed, 23 Sep 2026 08:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E18F1F000FF;
 Wed, 23 Sep 2026 08:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790150556;
 bh=x1TsMr1/ncEgRRm2LwLJFAQnnflejAA2MZPsKjjM/64=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=jIksx580tTS7D+KWUmaYBpwbImOnrtADcyh2OzjNlGItMQ6rk5tNnnbJBZzbt4xcS
 n7Xy7Rk8xmBgddltn8t7S0CxiUQvFNAZLQRcNcduOYPkYKTd4GVC5OZob1AvTTg79z
 y3ce0cQmrNpc2FibtGGa69Y3LWw0wPnxXJ6oCtbIFC0KqTUJ2cJOzO0+Voj35BUvJh
 wnrh+5FiHUuTmjL4NthjEq0jS8QAy+QweMJb1opr1JqahzLKuvhY+D5/utNtP1PoeH
 VHCGeEIcVshE/RBuU+4BRBq7zyc35r96SxEuIoz+aaMf2AJXAmUjQ079Qclv409kFF
 /uiq7KffnRXXg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, David Lechner
 <dlechner@baylibre.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 0/5] Add fastboot to SPL
In-Reply-To: <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
 <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
Date: Wed, 23 Sep 2026 10:02:34 +0200
Message-ID: <xhkdb5wzws8dh.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Sep 21, 2026 at 22:18, Carlo Caione <ccaione@baylibre.com> wrote:

> On Sun, Sep 13, 2026 at 09:28:42 +0100, Carlo Caione wrote:
>> Some recovery and initial-provisioning flows need a standard host protocol
>> before usable firmware is available in persistent storage. U-Boot already
>> provides fastboot, but the implementation can currently be started only
>> from the U-Boot-proper command line.
>> 
>> This series makes USB fastboot available as an opt-in SPL service,
>> including MMC partition flashing and Android sparse images. The interface
>> is kept deliberately narrower in SPL: it does not support the boot command
>> or filesystem probing, and reboot support remains platform-dependent.
> [...]
>
> Hi Mattijs,
> are you happy with the current version or is there anything else I
> should address / fix?
>
> Thank you!

I've just applied the series. This means that they will go through CI.

If everything goes well, it will be send to Tom for inclusion in next
when I send my next PR.

If there are some issues with CI, I'll let you know.

Thanks again for contributing to U-Boot

Mattijs

>
> --
> Carlo Caione
