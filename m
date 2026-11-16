Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A1606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VOIpi31g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29D8680FB4;
	Mon, 16 Nov 2026 16:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUaMMU-Nv2BQ; Mon, 16 Nov 2026 16:30:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2904480D58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846642;
	b=XjbrClMfdQ+E2MAjxZhe9r5MUBuwYEHRUFXZkmmlpCfAZJ8GEFP4Mznx8YGlxWcgBMrI
	 CMhBQrzssn050EO84m10Q2t5KlbIIOJqZYR/GUETdmDZ5vt2aHKjdQfJQfQo2ZXOoj6F4
	 GLVh72VC5LPizVNvl0qYwLuw4cliyjeb+gBGhXEBdz2yF+pftksYbeAe2kHVfZYTQYjX9
	 uF5Sx82ilkI0ObbjmaQdwrRweSH2+kQ2AxpVNKfMMsohHRZcKlx3xu7bpNLXo5hL6WsFW
	 PP/H6re9yVfeDlYLvK5P9TGWWv45QvBMMng1zSiNsT+qRlRED0ByjgHrupsBuuVduzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:
	 X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1OyM/TEJ7BQLnMhHP3lhtLOgBtwKzFGkW9Kf+kAmf14=;
	b=V6iGHrrbz54iKUDHNcaOq8Rpn56wehU5LfrkuWcybpz/eO3aff5PWzS/+DWBZ5Y4AH3f
	 WAW/cex9RNeYxeiJkDdtAWg9lO1aVg1OXYu+KDSmOQfwTyQrPYRhhqyAj4kYXP5uEOcWq
	 ibHfVXDf1BPTKYXV05BLK77sRJH4y9R/vf6KlDs1G4RX+v9XGzuJK6RXWz0x/54wddNcB
	 9XGIucXzupO6ouINfy9KgHy2YyvDvKSZWv9S0tkP0ByBnRvV8Rlc5upRgJNmpFFbdNEwl
	 tEMQ4ZhJPggOSYpNTOFgoFCpwwffWBY2iixPHvv0imh5oFi/dEFo66PIhagpovo1UmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846642;
	bh=1OyM/TEJ7BQLnMhHP3lhtLOgBtwKzFGkW9Kf+kAmf14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VOIpi31gQgKQE5gSmdJxs+JZVQ7OXR8jVNKgWknr2i73qGrltT0IGmF9Aypc3huko
	 RFm/0c/NetenS+U5dS6i8BHRwhgHfs0uqh0Z1s8LSpFg56Qgw6/x8mSxb0EfbBHT/u
	 3DX6jxNQ+lgHJSw13UA3BnYxP5webAZmzZuGlzVHo07tFA5yToWTlqIIbUTVwGD1eq
	 m/5i5nw9H6p3sVT6HprAX94y8Y5v7/r9CoWA+vzeoYIh3gJ3Bx2LbEW6d462eNPsm/
	 JtMJbvriZGvegos1ytyz2bbfelZMm+LtZgW9dAJVoN8wXIrkOGubEaIsnAUeXvya3i
	 lpfWFdHJ66YIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2904480D58;
	Mon, 16 Nov 2026 16:30:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1A6728C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB51C4029F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1r0_X9MUA_xn for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D87BB40282
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=114.132.58.223
X-Greylist: delayed 88722 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 16 Nov 2026 15:17:03 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=114.132.58.223;
 helo=bg1.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D87BB40282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:17:02 +0000 (UTC)
X-QQ-mid: zesmtpsz3t1794842170tf38f629b
X-QQ-Originating-IP: 4iY39/wHN1pt7Hg831TPcaqdFE5lTHpphBAQuMo1VBo=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 16 Nov 2026 23:15:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12708299994360651735
EX-QQ-RecipientCnt: 9
From: Zhouqi Jiang <luojia@rustsbi.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, tim609@andestech.com,
 leo.liang@sifive.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Date: Mon, 16 Nov 2026 23:15:56 +0800
Message-ID: <1388F640AFD6F7C7+20261116151554.2375371-3-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avr-_7CNcFit18nw@pie>
References: <avr-_7CNcFit18nw@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRLj+a+1JRyJMGQ85fSnLO/bKcBNupu2ujmHz+WHLu2fYzDUk+QcLiZ7
 xJMfAJo54OLqk5q/0cKL0aGnekVzXNCCfyNlnUBLt05pvHdsAUqMZ4MSh0BKwNjX87M1MZv
 nLsTmoOy9G6sqv6l2S49ha108oU560lcTQkssNm5BRD2abtvh/ua90Pnnv5eVyAScG3fFXa
 3OwD531QiJ/LHHpezt7cQnK5e6pVsF23tl516j0YyORd54Hg0Nz15kziRIZLkb+R/jrWVx2
 6x4psV9V8NqrCfmiZifU4ufM4RceyZgmNN4hUd8uEp/uH2rvNRxlmr7jPTwn9v7HuUkzJrc
 IhlFII1Yfi1QO0vNqkFhRDTgGR1+RzHCSfEN+BiQD6x/JoH8T1qI6OmU5aPxk9QhH9W9Aqx
 COFG8ZCMDnXKuaGGmnxsxUlVhc+xRHOopzngYBFPTM72LcZOCcMF3rq4NEoREZaetvs2PGa
 6ywvfnGQy0HJA0slOCHh06wKM+RkcQ4N/Owb4Tn0QdwaSStqnthE7QaP0Tf5kvzPWutql+9
 hRBwDV5sTtPJEt62Hk0D4k0/P3rkrJ08slWYaZKdujY4l0CWGPI9C0yFomLpYT7+HI2VIQI
 uep7f4wyv6nJ3xB25w4c+yKp9cVUlXdH+Oq8332Ry2RknSCqwphZl5ZsEbmokWKLGRr5oS+
 f6H2LOA/8FYpM74yaaUgwrnDFTRixMYRbBfcoQCFOFEC9w0Vnc7F6P1bWT4iuciNHVe64XZ
 fsACIziNmhl5xLDsB8KZR/t87xP+qJqEhrqlI5T70tNK0wIjz8JIJ4LpgZ8uvcsEJBDaxDh
 9Cx2GQ+mnsI6gJ4DiYWfE7EvqwHyi+aa1QICTGY7UXorIyxP2kBH5nNjhie351Oc/ZgQCC4
 rSu035epVfLTcMPrbNAX8efEq8F+J8VhrgQB6109nQs8kg1Xo0MrhaA2n/P21eJbRkQ8aMV
 jPlzmXSZk5rrCcWR6BkkOrk3riZkXk2F/7RPkWTboZz901luQXMr8m14fFwsX9vqziSWGwU
 OOnVDgUvN1Bb66TOQCBlxszLZxyikqCPNj23yIcQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:30:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ziyao,=0D
=0D
> Please quote the context on reply, so the mail is easier to read. I'm=0D
> adding Tom's comment back here.=0D
=0D
Thanks, and sorry I omitted the context in my previous reply.=0D
=0D
> > > To be clear, I think all of the changes to make things more clearly=0D
> > > generic here are good. At first read, it looks like aside from displa=
y=0D
> > > strings and a different scratch options value, RustSBI and OpenSBI ar=
e=0D
> > > interchangeable as far as U-Boot is concerned? If so, I'd like to=0D
> > > explore continuing down that path more.=0D
>=0D
> On Mon, Nov 16, 2026 at 01:42:33PM +0800, Zhouqi Jiang wrote:=0D
> > Thanks. You are right: RustSBI and OpenSBI are interchangeable here bec=
ause=0D
> > RustSBI implements OpenSBI's FW_DYNAMIC handoff protocol. This reflects=
=0D
> > ecosystem compatibility rather than a formal RISC-V standard for=0D
> > inter-firmware handoff.=0D
>=0D
> So if RustSBI could be supported through OpenSBI's handoff protocol, why=
=0D
> not simply keep the current OpenSBI stuff as-is, only replace the=0D
> fw_dynamic.bin with RustSBI's binary?=0D
>=0D
> From the view of this patch, I don't see any improvements by separating=0D
> RustSBI stuff out for the current situation.=0D
=0D
I agree. For v2, I will remove the separate SPL_RUSTSBI option and use the=
=0D
existing FW_DYNAMIC handoff. The current draft keeps RUSTSBI=3D as an alias=
=0D
for OPENSBI=3D; both use the same FIT entry and handoff. Would that alias b=
e=0D
useful, or would you prefer using OPENSBI=3D for both?=0D
=0D
> > I initially considered merging the tags, but I now prefer to keep=0D
> > SPL_OPENSBI and SPL_RUSTSBI separate while moving the shared handoff co=
de into=0D
> > a common path. This keeps firmware-specific details, such as scratch op=
tions,=0D
> > explicit and leaves room for other SBI implementations.=0D
>=0D
> However, scratch options could be modified through Kconfig options=0D
> easily. Even with a separate Kconfig option introduced, others still=0D
> need to alternate it to use RustSBI-compatible scratch options.=0D
>=0D
> So I think, like what I have said before, a documentation to explain=0D
> support status of different SBI implementations, and=0D
> SPL_OPENSBI_SCRATCH_OPTIONS' effects on them, might be more appropriate.=
=0D
=0D
Agreed. I have documented the supported implementations, firmware input and=
=0D
scratch options in the RISC-V architecture documentation.=0D
=0D
In your earlier review of the original patch [1], you also wrote:=0D
=0D
> These changes should be defnitely split into separate commits, since=0D
> they're related to too many different components (riscv, boot flow, spl=0D
> loaders, binman, and doc).=0D
=0D
> > @@ -476,8 +476,7 @@ config SBI_V02=0D
> > -	  Choose this option if OpenSBI release v0.7 or above is used togethe=
r=0D
> > -	  with U-Boot.=0D
> > +	  Choose this option if the SBI firmware implements SBI v0.2 or later=
.=0D
>=0D
> This change itself looks like a good clean-up, and could be accepted=0D
> independently with RustSBI support. Please split it into a separate=0D
> commit.=0D
=0D
I plan to split v2 into three patches:=0D
=0D
1. Make the SBI_V02 Kconfig help text generic.=0D
2. Add the RUSTSBI=3D firmware input alias, binman test and missing-blob he=
lp.=0D
3. Document SBI firmware support and scratch options in the RISC-V=0D
   architecture documentation and SPL Kconfig help.=0D
=0D
> We should probably not cover every possible SBI implementations in a=0D
> board-specific documentation. A better option might be explaining the=0D
> support status of different SBI implementations in RISC-V-specific doc=0D
> doc/arch/riscv.rst, and keep all the board-level ones as-is.=0D
=0D
Agreed. I have kept the board documentation unchanged and moved the=0D
firmware information to doc/arch/riscv.rst.=0D
=0D
One point I'd appreciate your and Tom's thoughts on: the existing FIT=0D
description and SPL debug message say OpenSBI even when the binary is=0D
RustSBI, although the U-Boot "sbi" command can identify the implementation=
=0D
at runtime. Would carrying a firmware name for display be useful, or should=
=0D
the existing labels remain as they are?=0D
=0D
[1] https://lore.kernel.org/all/avr68Io04mE4YFs-@pie/=0D
=0D
Thanks,=0D
Zhouqi=0D
