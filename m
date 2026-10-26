Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F7606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VSDX2Fnt;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=I8rstjL4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=rR2zVVo1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F5D2606CF;
	Mon, 26 Oct 2026 21:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpHdXI15i4g5; Mon, 26 Oct 2026 21:27:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B6C160607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050034;
	b=Z3MaZSPzHgYdw86QaqYK1b552wm3TYSgBWFJCmVQdGGDQ1fEGW+nm4MWnlvwkeqH9OQu
	 Ax29WaUJFqk/jlLurkHRyJlGcPnf4WZuHmL/6IJuObk8mkv2FT2i9QhxxwkvDSCwjo/Y3
	 7+eaHXPn7Q7hWBAmzQFQpWi+cxKaaqVqRh8Bp1bGLZO8Rr5Qz+KrmzwOGTbWYSo63lQTd
	 dXk2B8WxD/4u3muE2vzhdc2vTusNBqVCOGR1YRTVZiCA2qtq0ciKGKYZlKrDKk5k9ffmx
	 MAdVfN0xT9NR/+kwV2QgAQmhGVlmDrgzdLa9T35u9RrIb4I7FmJhid/mC/Sk3VEybug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zwGmMgyZkuFzWMNYXfLJ6TKsmUpxzDXw780LzNsjuGA=;
	b=ZXeoJ7Z3f7fqKKVY/oGgz2cEvss4+OnwLSMYGgmBHZQr5TK6Cd1ZpjcicMK7ahl2MaOf
	 o7m9qFswV9sqVR60QnPdQaESsyyzzyfgSI6lNWwPBGyF7Q2tFQyZ8J2BwO8libeXcfwYl
	 qG9xj1mOsG000RjoAqwndiXg21QCBypHROXEL1gIs9zX545fGl2lFufbdhnvkjqHEkKEz
	 ahuNAzDlQDUIIRwY9/fiFc865AlXnWkiJeMrzj6FtlILTW3oCdlrTC3gvxXbg3IwOVtCy
	 gUiV30LHOCB1JN5ZTRU5piW/JciEyI4Mh+LExe+1gCpIIg4gCfWs4zPDrYgP/osNsww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=I8rstjL4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=rR2zVVo1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050034;
	bh=zwGmMgyZkuFzWMNYXfLJ6TKsmUpxzDXw780LzNsjuGA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VSDX2Fntv/1rXHUDhKGQiv8IqTSrJmZq8hbOoCFZ65aWHtKdJcMhG6tcNLhGSmd7g
	 xI1v/WE1uKEeSNIxQyMz9UJ1YYp3ZN1LXIAN7JXBscFLNmi/eqms76wcxSdyh3hFsJ
	 KMUzGDpe2ehz2StviF5yQWuK3cmCkJJzS1GObS9/hBnvyKWzygDiYN9coobyBWZlIl
	 6V7YDLubhEWqwmOhWeRiw6v0ICCG7NX0D8I1rmgQis+2+A7hD/t9R4UZ9qLfF8CQf7
	 RGMs8nUENhAcIl5kgfZU0Qrl56yKbFtv62Xg8yy5tKG65jB8rqJFPC4mgnd3p4Pp2t
	 xCsJPrN04K4ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B6C160607;
	Mon, 26 Oct 2026 21:27:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46E972F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38C3A60607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XRgy2tgMvP2 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:27:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02BBA605EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050031;
 b=SE7fVPMxTOmGBHIU8JeHCET3tA5o+fAs+MzBQxJ3v02K7UH3D6QtfjTZbM0PAoVsbJo6
 PLgSLqQREQ3hsl2iL67S5pYHQSA20Q8cVo90Hd1oUivKsz6n/Zljmfe4ZBRVJsK4v87ju
 LzgJYFoTwEorPl3qW9OKg9FalZuDPPhDPCPUJ7TnvrDZ7C5UCyQyP1cqBh0y+GXk1tqda
 sWNa9shTTausf9HJhBAw3HQNnvK73a44eKg3dwjg0xnG1hDpGeoyYcf1O1GeOwZtImPRc
 laCQMaFjd5TgvjRSrIUQkPUx6WX4YM6qPD0Mz5MY2II4QxuUtEggMqlb2GsG7ID8zsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050031;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=zwGmMgyZkuFzWMNYXfLJ6TKsmUpxzDXw780LzNsjuGA=;
 b=ZYBr19yqsYfB9wPK55bH7YjlpgTbLw++JSI0XsXAG1veX/h8Rd6oVGDcLiBBbLYbFUwy
 HRPv2+oMQ0epUGFUPTrEsYD0QVXpeyUHU7yH6uyKz7ATh1/z8++8AnCuE2mE0ClrjNKiC
 DdRmsF/hTixYfZYi5sUTtuCol5fH5OoT6iNwLHKyoAxUfPkAJh7B3Lqu4M5U3IS37u22Y
 QsLUb0ld1yHTf/5q5cXEKb7WHCaTmBVBu8eInp9N8v/zdXuDuv7sxn+GqS7zfawJPAgR8
 Ss3ZcBj2D9HwoTMrU5qc/NrsbkJGbAQx9XEu6Htnzq/VphuE4KMyvVuhHXlgXyfj8sA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=I8rstjL4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=rR2zVVo1; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=I8rstjL4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=rR2zVVo1
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02BBA605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793050024; bh=zwGmMgyZkuFzWMNYXfLJ6TK
 smUpxzDXw780LzNsjuGA=; b=I8rstjL4rhYf0taktWGnjh8jkTUgjLlYJfAQLqb5rhYKqIn76z
 lcVpT6HZovSExi8fV4oiWQbAs88DvupbNexJSH2EtQgL/vyTWebF7AHsLQ3IE52bReoJ4DYFgxE
 1J/ZfwnXPwvmGMdJS6lNYdBpU5IYEzxSaA9huXtTW7b3A5IgbnJnHycBN+VL0ziJ/mi30DN/QN3
 r1AH6GaciGdSGqhTw+QyJE18rOJ4PBi3zkc9uLe3iX5nrvc+03suaDFguyH5UH+3TXV56DlbQrl
 ulJ+Lrh8/DUmhK9qGpMSMEC8vZVjydwVdOshooOwdvE55++Ki4BycbSLpaE09AxPtlw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793050024; bh=zwGmMgyZkuFzWMNYXfLJ6TK
 smUpxzDXw780LzNsjuGA=; b=rR2zVVo1eenjxWUvh15dNeuwJHMvezj3kBn5Ggo/8AUSUik8NC
 ps3XAHx1xsmh1iIhFw9QAfAOh1o8+5GudNDw==;
Date: Mon, 26 Oct 2026 21:27:05 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <20261026211952.GL646438@bill-the-cat>
References: <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
 <20261026183010.GI646438@bill-the-cat>
 <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
 <20261026211952.GL646438@bill-the-cat>
Message-ID: <49FFC097-8DAD-4424-BAED-823C55BA3524@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26 October 2026 21:19:52 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Mon, Oct 26, 2026 at 09:14:37PM +0000, Bradley Morgan wrote:
>> On 26 October 2026 18:30:10 GMT, Tom Rini <trini@konsulko.com> wrote:
>> >On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
>> >> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com> wrote:
>> >> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
>> >> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan
>> ><brads@mainlining.org>
>> >> >> wrote:
>> >> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
>> >> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
>> >> >> >>>>
>> >> >> >>>>Hi all,
>> >> >> >>>>
>> >> >> >>>>Just a data point from a user: we are using U-Boot on a T1040
>> >(QorIQ
>> >> >/
>> >> >> >>>>mpc85xx) in a product, and we intend to keep up with mainline
>as
>> >> >much
>> >> >> >as
>> >> >> >>>>we can. We'd appreciate PowerPC support staying in tree, and
>> >we're
>> >> >> >happy
>> >> >> >>>>to test patches on T1040 hardware and report back.
>> >> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible to
>use
>> >> >64-bit)
>> >> >> >>>>and
>> >> >> >>>>linux in 64-bit.
>> >> >> >>>>I am in the process of bringing it up to our 2025.07 branch
>and
>> >> >> >>>>potentially
>> >> >> >>>>mainlining as much as possible. We have some remnants of it
>under
>> >> >> >>>>`board/keymile/kmcent2`.
>> >> >> >>>
>> >> >> >>>Would T1042D4RDB affect you?
>> >> >> >>
>> >> >> >>Not directly from what I see in the code, as long as the shared
>> >code
>> >> >with
>> >> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to
>> >report
>> >> >that
>> >> >> >>there are dozens of us using powerpc :)
>> >> >> >
>> >> >> >What you could do if you would like is to test the whole series
>to
>> >see
>> >> >if
>> >> >> >it unaffected you.
>> >> >> >
>> >> >> >
>> >> >> >Btw tom I had a idea: you merge Vincent's bug fix and my
>maintainers
>> >> >> >patch,you make a PowerPC custodian tree, and I handle the series
>and
>> >> >the
>> >> >> >naks and stuff and the comments.
>> >> >> 
>> >> >> and btw yes I'll make the pr with the finished patches so you can
>> >merge
>> >> >> them cleanly
>> >> >
>> >> >Trees are relatively cheap, but I'm not sure we need another one
>either
>> >> >for the subset of formerly-Freescale and not-QorIQ PowerPC parts.
>Since
>> >> >I added you to the fsl-qoriq tree, you can also just pick up the
>> >> >outstanding fixes and your maintainer patches (and leave dropping
>stuff
>> >> >for now, as this series shows today we're just getting people having
>a
>> >> >chance to see and reply to this stuff) and send me a PR. Thanks.
>> >> 
>> >> Hi, sorry, I didn't clarify enough, so I had a chat for some people
>from
>> >> the open src firmware slack, yes?
>> >> 
>> >> And here is their answer 
>> >> 
>> >> "Ah, Peng Fan maintains the FSL QoriQ tree:
>> >> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
>> >> 
>> >> That is the vendor one though.
>> >> So yea, I'd go with a general PowerPC tree.
>> >> 
>> >> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
>> >> 
>> >> And even my slopper suggests the tree, for sanity purposes :D
>> >
>> >Fine, trees are still cheap. There's u-boot-ppc now. But please keep in
>> >mind everything else I said, thanks.
>> 
>> Thx. 
>> 
>> Question: will you merge the maintainers patch on this PR, so I can
>focus on my add-on maintainers patch and the removals?
>
>Lets hold off on the removals a bit more, as I was saying.

That's not what I meant

I meant, you'd merge ONLY the maintainers patch in this PR

Then, I'll go and take up the removals, and give it say, a couple weeks to
let it marinade, and give it responses THEN submit a PR with the removals
in it. Then happy days.


Or I could also take the maintainers patch with me too...


>
>

--- Thanks!
