Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED979CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A64754060E;
	Wed,  7 Oct 2026 19:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDhlzr7-V_UK; Wed,  7 Oct 2026 19:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5C404405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401866;
	b=ZK9W8Thnhw+cHLlnHueJRsWGt/zy479vqJiyoekh5ovaEbLQ5E4Xj0xmFn5/mF4/EGSx
	 +rwV01Oy+ES/EvLa1q1wZ4tz/NfARQlXSWpl84XQyVEoNC9ejlJLXSIaw3d6ahAVVZANf
	 njIznGmY7ctOdoZpgIn3WKOyNuoXmXt8g+VexXN0YuWCQ9xfyDVC6Zi0OzRYdV8q096wT
	 7OVvSmaEq0ysxFIo7fC2sS8ST0HVozEsXmx6w1Y9t4/hCAE5mvV/Pa2kU/Mv43kX6pkXI
	 92pxo1LgC6gehhEkW7hKT+tNtsivcVsaGTTWmuoKJcee+n8+BJBlqDlqe1nK9eDFs3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TNVIhnFKbvjNsUhzvNMqxu0/vNHi6dNtkUifCvqA7R8=;
	b=jcSK5LAbpy57wt8bOvaPW3nwWqMKLxs9/kCrp2x61IaJ+PIExULTRUQcHEYfyF7jXZb7
	 IRMBN687d4iXFL9V4l78BWaJsmItNrm/wh1XsCSF/ifCpAcE6Sw37MHvB6Xpkf6kkG4of
	 A3eXPDDfZiYeyFYZp9yDRrYTW1WQf/ecuM0tVEVzrNzaQ/HoxchIy3x/f5aq2TrPw4HrT
	 PYLV6XJHfb+NyfomXOFS/DA+yfTh1gY2yAmc+OKnL1OGvZYZEZUeE7DMFcPuBqjAtJe4A
	 BrGOxUz/qotL07Au+E8eO/RvSGyXePOZEqOee14NPMcqj2lfpVvtziaELH1//vDJB+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401866;
	bh=TNVIhnFKbvjNsUhzvNMqxu0/vNHi6dNtkUifCvqA7R8=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=duOeaaXvI3V6CvzRi7aWcLEYcq8sGIKeoGQoytLk/sjJlQYNkH7z+4GjaeDrnJ+eW
	 2yhCMc9MxR6r8nXdioll0zxEucaOAZlo0won7wwulvepztjY2qdJX0SI0ECzJiLJM3
	 +QONugTqonqrsuP2qhOlicW0ucPo60mG+EktlNhdAxqMKmTN4PefcBhbB2iNJdFB9S
	 NlZuURx6L6ynxEmc7Xh8lZtyD6meobe0Eozuc2RGnp1G0Gq0etJmFStch1be4Bl5Mg
	 Hi2zf3RjPp/vq9WGUDk6IkT6QPJshf7DA4d/XnnC0y4prDy2AMqKijUF1tBXfdmmLv
	 HvROSOJs5sIDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C404405F9;
	Wed,  7 Oct 2026 19:37:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 745C175
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A0E240062
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f--l5L64nkp0 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9AB444004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791399846;
 b=C1qEzVRI5u3h5MSJPIGyH0sVsbwktcAM04/1/oDo0dlvLUVdseOIJQWhDNnQ5+kzIuoT
 npzWpzJkLFyHveespz7jRWR/BG6Xx/w4I71gxLskJMRcuUgEcsZ6iHyGI57nKwG9Ak/44
 RzMex4Vki5btGbJX5ub8QOEPlIFuh5mMqn+F9SV091P7F3gdD7+vx4XmEgGWYGDyzrOyp
 fwz1AziptfzOiuIW+SzsCe3uetmWxY6rdrxgy21c93a9h5b5FzhFIvWLLijyknIQAdhpr
 0nI0nx4aafHNm4TPl/8prbfFBx9TbfUu/zdGk3aRlH0cr1HkrDs4Kzb0UWId+EohSxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791399846;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=TNVIhnFKbvjNsUhzvNMqxu0/vNHi6dNtkUifCvqA7R8=;
 b=Zxdv/49F9J3UaCT8CxR1cC9/PBNLJkEdDjMyLTogTqxAEUkC5wRULUko1Ag0WS5VJEsH
 3WKLhft0e6EggpqaWPdafFIQv74CZRZAjdN7p1e3B4z9/vdMbfobPqgPHISFC0hnscBok
 4+ZJLRQUcTtsvXiOGsTLkp210iOvLT5EJQ8zH2ce1rxInXSDt/+M9u9nT8UF3mRcoFxSE
 RsjnVrsGVkkPPESVUcWuT+eHBdeKZzEcdpX089DVDBsiOIWQiaSsmeTyNhe4lor0AY6S+
 14/EtmJDteZkBEFJ7NIfPXoexfaj8dvLirHsR0aWM2twE7FSAyqR6KIh077gk6HlRmw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=2ew5gbggxfebtebe7yuqlkhkde.protonmail2 header.b=bzAu+rD5; 
 arc=none smtp.remote-ip=79.135.106.121
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.121;
 helo=mail-106121.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=2ew5gbggxfebtebe7yuqlkhkde.protonmail2 header.b=bzAu+rD5
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch
 [79.135.106.121])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AB444004A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=2ew5gbggxfebtebe7yuqlkhkde.protonmail2; t=1791399840;
 x=1791659040; bh=TNVIhnFKbvjNsUhzvNMqxu0/vNHi6dNtkUifCvqA7R8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bzAu+rD5jHWNVxwtVls1CuaV5jUFCUrlv0/OlMm6/Y8/5KtZ9pFU14lN3LNAIolZP
 qNyJ2yj05CblBqJBsvL0v6Lgw7m1tsG4Jz+0GSay+L5T/o5y7aJJP7q4jAwBJ8aVoY
 hDRqARB/lP1X4Kjfwx0I5spsgco+xFi3pJdoCMFMiC9y/4wk5mh6RnfwKkEO6uaEx3
 PeMnnyzGNgM5wn1dMSC/iNqXhjbb4+GLudaLOTYJzvD9uCHvCyAAYpwpGX0SSaRAT3
 rv0rtWN7IaxmjElLmg70LPTUBsqGXghqFk/yhNRjUUfnDj9H3ZepdfehaCpelvG/gw
 z3n0eQXDuDEEw==
Date: Wed, 07 Oct 2026 19:03:56 +0000
To: Tom Rini <trini@konsulko.com>
From: Cole Munz <Munzzyy1@proton.me>
Cc: Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Francesco Valla <francesco@valla.it>,
 Anton Ivanov <anton@binarly.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 09/11] sandbox: spl: Enable zstd
Message-ID: <20261007190342.309166-1-Munzzyy1@proton.me>
In-Reply-To: <20261007182547.GC3079290@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-9-28e946f57357@flipper.net>
 <CAFLszTjYA8J4V1mEOAe9_0Wdv66y4iawoZWfbaOPMPteNXooyw@mail.gmail.com>
 <20261007171551.279289-1-Munzzyy1@proton.me>
 <20261007182547.GC3079290@bill-the-cat>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: e9711cf79ce57a9d25e9c5460952e3c1ecdf5c53
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Wed, 7 Oct 2026 at 12:25, Tom Rini <trini@konsulko.com> wrote:
> I'm not sure if there's value in repeating these tests on other
> load-froms.

Fine by me. I will keep them NOR only and resend on top of v3.

Cole

