Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51426CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F1084879;
	Tue, 26 May 2026 15:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="gfUNiDpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6956F8487C; Tue, 26 May 2026 15:17:40 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006A884874
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B13A32692F;
 Tue, 26 May 2026 15:17:37 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKdbIAM_d7gH; Tue, 26 May 2026 15:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779801456; bh=pDQU8tfHcOTCxlFwBD8Z0by8rehyFtjBO8VeqTPL+MY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=gfUNiDpr6yxcsxM2ACNJ2yLnB0AgibCWcGEAqgiStZS91IBB9DY50V86edg/KT1I5
 tjeCyj9zNvauu/xLHkEeNp8ea454hrIB3vld24myQvde+I40BJ0WF+/vMnqUfapRMn
 4b3GPEqRCokFCuwF3yikNhkIp7MZYYlAYOw3q7UhxXE7LAmelvpVmqkxEWxnEEruzI
 1WYaFOkwkxBcgLsdsl4h5IoF271UutGriccF9YrhQynl8zHjW5mbyJP+T0b7Aj8BWx
 DPFVeijfSkC5wQ4fUwNIIyw9lolSG/J3J0U6rW7q3p8FJCOTlKVya/1Sa3gQUkaV2d
 345xqZ0y9ADNQ==
Date: Tue, 26 May 2026 14:17:37 +0100
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Javier Viguera <javier.viguera@digi.com>, trini@konsulko.com
Subject: Re: [PATCH 0/1] libavb: fix avb_replace() OOM handling
In-Reply-To: <87v7cafha2.fsf@kernel.org>
References: <20260521165122.17475-1-josh2@disroot.org>
 <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com> <87v7cafha2.fsf@kernel.org>
Message-ID: <6D3FE2A9-1BB0-48EE-B91A-F14C50FA6E22@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
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

On May 26, 2026 2:10:29 PM GMT+01:00, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>Hi Javier,
>
>On Tue, May 26, 2026 at 14:52, Javier Viguera <javier.viguera@digi.com>
>wrote:
>
>> On 5/21/26 18:51, Josh Law wrote:
>>> Hi folks,
>>> 
>>> Since I am a new contributor, I would like to introduce myself first. I
>>> am 15...
>> Wow, we have a "Benjamin Button" case here. I seem to remember he was 19
>> in the kernel mailing list ... :shrug:
>
>Thank you for emailing a about this. Your message made me curious so
>i've found:
>https://lore.kernel.org/lkml/cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local/
>
>I'm no longer sure now if I should spend time reviewing this patch or
>not (because of bot suspicion)

Hey Mattijs,

It's entirely your choice if you would like to review this!

If you have any questions, feel free to ask! :)

Any concerns also feel free to make known.

(P.S: Simon did some of the heavy lifting with his tag :) ) 


If you choose not to review this that's fine! 

Thanks for the polite comment, it's appreciated :)
>>
>> --
>> Javier Viguera
>> Digi International Inc.
>

Thanks!
