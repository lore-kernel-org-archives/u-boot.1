Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AE2CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BECF680BCD;
	Mon, 12 Oct 2026 07:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGwrhww_rrEF; Mon, 12 Oct 2026 07:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23A0880C7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791739;
	b=UBcCxiUjUtGlaVGSR8H+WqXpjE9ML1yQKkTMUyhY8Ms4K9Nwtpau13CHkPCytyT7u6zp
	 DtAcktlsFVRnrn0SOJQkvK5uF3dRzP/s/D1nEral9bxP4DvVWr73PGKybnl2QtTZBiWUc
	 mTCTHe68L7Kh7Zd+YflqSMWNuVM0EMC8uxBJ6IfYM+8WWPPnB4fI/u5FJN6ZQM7uWXrZ3
	 ulV8XReDRaleMgU5+2cRy8J/fmgBKT16SPZWrFytb9i4Qnv8umeWaPztfEjIAsihzUVqB
	 pplmmsZPRnTnPoA3X1j9b0i9MgXVnYiN05OObSfTtn1TMx3bzPV9maFJzLzCcZR9xwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e6h+P2X+Wbu1l2wtccbLIuBEhVHxjh4VwJUYgL6f9ts=;
	b=LZxZlwtNCqt915p6BCbwLJYjiJgdVe2facZx7RRwDGhD7px58p01+OU0O9IOAYIPMQL7
	 SYTu/MMNM3RkTcYtSR04d8JThh8HYBevo/TQhbZQO17ytQ+RwAX6Xn5bs+D89ZrLwS4yT
	 SY/XB0sb+SBFB1Qu+aICWviZmdQOTCUVadUA8/1BnQCYSLUL5xi/D6Sn3CpCNC75F2Z8y
	 Oq4EsOOe0zuOF8vGEaAaqkBLRiCBJ/cfqxbsmUNGUtdbnVBvNvGK0ZB9qI40DMGKo4j/u
	 ScDm5SqujsAr55u1YfVJ1vWky/rsme85CxE1TQYzroCixDqsOqomzxrsfgIPXqRo3Hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3Z64M+L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791739;
	bh=e6h+P2X+Wbu1l2wtccbLIuBEhVHxjh4VwJUYgL6f9ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CAQf6YDbaCQNEV3RXwxeLPfXgk3bJnQ6xewd0Q9l0IulHu/mKHxHXPDOK9WadKwW/
	 Fgg5uedoaWvLbWEaxuwxWOluj8XiIssE++1MAzQfKvX/qUo1lHhJn4XxtzJUDysqY0
	 guwwuUJmDKxWBvlnlA+EGcy9R6QIOYeKC2luMnGz04rmeFgGyE1uTM2Hwu7P02mEho
	 0eNT2XQXDr6YqbNW17f5TovUPEHB698xICMHmbdEf3r2L2Y0riQFxdgs15/qPt8PWy
	 0tQ9DGM4tjsF5ZMxgxwc1sDpcWwXZIm/ifVRu4QTWYQC6iXC6o7InuciyAIjKo5xUX
	 ge9yNPIYWjbyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23A0880C7E;
	Mon, 12 Oct 2026 07:55:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 208922E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12A0380C7E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 76Ww7XMURrLR for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CCB680BCD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791791736;
 b=f60yRoBReZWnTVLXqn4PjDzjOkNA4CIkqNMDzfYlJznXCN6pdK1k/RjRJhd2t2s7WdO/
 M+3S6/zWwYw6h20tqWJMvbOQ4qkJik0qK2JhzYO+p7NStsfMeSg5MhBD38Gu4teMrK+YY
 grycjaLoAEur/wDM4bsuKoKyQgg4HFVVSSQRkDNHnpjAJTTvarwY7Nk/RfyOoALGqgvVv
 LlOwRJhL/a6RmMHC0+NG9H1TCqLuHT8na4qVmtKpTtAp+bslaSTxI+i8PkYl9zqrC1WdR
 AMYLJ0rEB5/eub4GS60kB4xd9APNPsse5H/Q4tS7n2UUnZZueCP/JUMUGyNCDbk/Rsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791736;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=e6h+P2X+Wbu1l2wtccbLIuBEhVHxjh4VwJUYgL6f9ts=;
 b=CWvg1TUhW+AZZ2qbquTLyTa2YF4vvHw2YdlqVUPB/pHmoPTolSqZTsP4iPppmuHFgbW2
 uU/mXmZR5joMCDUsS0kz5BYjlsp1sw/dYzsWpIGI29qfmQaDCqzzqhSMaUtfAjwpSPjVX
 dIG45mtJitpnd3PRr6/i9TYoYLr/FksR1vDbuXieChY6yaIm4IdJoD53Fvf776vjXEB5d
 RPbMDqWAaFtOQ7HfIUn/Gq3ZYFjc+JYKcGph90TYcHgBm4C7eG1OyXiy2tYuGkqbY0Ulv
 XCRR9UHdHWyaWf982tLbwp5wMvFjAr5xhukEja3h0s1rQp0LkuoxUY9DYhI3PNA4D2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=C3Z64M+L; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=C3Z64M+L
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CCB680BCD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:55:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8826D403A7;
 Mon, 12 Oct 2026 07:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9471F0089B;
 Mon, 12 Oct 2026 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791791735;
 bh=e6h+P2X+Wbu1l2wtccbLIuBEhVHxjh4VwJUYgL6f9ts=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=C3Z64M+LGP3P/gpiSYMRQSdqbFMQcufHZ2dSXUawJdkr7thuY4JeXePST4mqGpjPP
 4jbdznb03VWqIXPp09JF2nBThLdnPwlE5Grs6zPm3cqAVd80EraMKdK99qcPOHJeVG
 G+04SM0e7iR/r6hxbfURYv/qjKaiuJTfgHYK+LrHFBIqzYMT2xhhGCfIYGNxhP+2dq
 v8cbog7CnS+qHc5msTvxiipHGi+CTbmWeLj2jhCUJr9KgXizOAlwQqRAYUTj95RA5w
 scvI0tqzsTURfWE7eHQmz2JopAUxnZ+49A6p2DEPDxXT+oRionZaL9h1cCMlFA9u/3
 KUeGuz1PlQ1pA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Suhrid Subramaniam
 <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZug==?=
 =?utf-8?B?5paMKQ==?=
 <Macpaul.Lin@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
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
In-Reply-To: <asnsgPaKy_Ri3H4E@macbook.tail959722.ts.net>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
 <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
 <xhkdb5wzws8dh.fsf@mkorpers-koolstof.csb>
 <asnsgPaKy_Ri3H4E@macbook.tail959722.ts.net>
Date: Mon, 12 Oct 2026 09:55:32 +0200
Message-ID: <xhkdbjynn8ia3.fsf@mkorpers-koolstof.csb>
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

Hi Carlo,

On Sat, Oct 10, 2026 at 09:44, Carlo Caione <ccaione@baylibre.com> wrote:

> On Wed, Sep 23, 2026 at 10:02:34 +0100, Mattijs Korpershoek wrote:
>> I've just applied the series. This means that they will go through CI.
>> 
>> If everything goes well, it will be send to Tom for inclusion in next
>> when I send my next PR.
>> 
>> If there are some issues with CI, I'll let you know.
>> 
>> Thanks again for contributing to U-Boot
>
> Hi Mattijs,
>
> Did CI uncover any issues with this series? With the v2027.01 merge
> window closing soon-ish, I wanted to check whether you plan to include
> it in an upcoming pull request.

There were no issues with the CI.
There were some issues with me. I got sidetracked and completely forgot
to send a PR to Tom.

I'm sorry about that.
I will send it shortly part of main to be included in the merge window.

Thanks for your patience.
Mattijs

>
> The MediaTek DA series depends on it so I'm trying to plan in advance :)
>
> Thanks!
>
> --
> Carlo Caione
