Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF1606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YB5idyBB;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Gn7rf5yk;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=SqOdlcxC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1832D6089F;
	Wed, 21 Oct 2026 16:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u1tXTJcelfs3; Wed, 21 Oct 2026 16:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 419D46083B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599368;
	b=ZeAQOIxovrA3CcClJxKVeT0SVWbVAVSG3YZL/RaDEDgrq4S7gKtjB9k6EEQkZBshgEfZ
	 r77hUaiNzxX7ooa1im+o9o/L0sS1ssz4HGM3GLlHJKugSsnxVpomAZu5B0WL7CQZocLa4
	 rKrRA4HbHkPEPb+dv0tclqLTXe/QqE210suMN+K0zwO59YaIfvHKSRPDa7UjWLLKH173N
	 OtPGmOms2zuevgelVkKgerK+6F1ddBObH3+d4kMbbvcESjXZCImH4SLXvCw4eq0/+NYeR
	 EFPeFrQi40EbI+a6PscRIUMaWd4PoFMlZda81ueebKVgpCPvgUDe/q2V6mCzcoZ/dYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=II42TubdqGOm5oRfKyCA5AxxhLM8m4ZY85n1oPfUbSk=;
	b=e1R12LznZahYFUMxVGXHS4yHJw2OKSwSfTlUI0gWMTmvVV8Ro/UKbmFNLFa4TjD4/MeY
	 2wTQHzWJNC7hm2SjKsXl12Zz6Se8Nv4+cEkFsw0pyeqq0QA7pKDH/FUU/ElH0FT4ZPpVb
	 qHNk0qaQxdEYKl3aUgT8erx8ppxc2BAb+c32EKLmSdEb2CTbqe6fDhbgtNoJP/gqBqDgo
	 GmVdHK2CXzpllzNb1qY/JCBY8uCIJXfFkkzhuXb4Tb4qCglVQd22AVoXSEpQASIvs65KD
	 rUQvC4sbjdLOI1VCwxKe8eauD/U2RfIHsCM9t1E1B3FxWmSuWRuU7AjJJXGhB6ytybQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599368;
	bh=II42TubdqGOm5oRfKyCA5AxxhLM8m4ZY85n1oPfUbSk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YB5idyBB6jHPhiKf6Qfe5BxTDc9SjC2EXxIKg6tY5CYmo5twnxj6Eo+ua6dDq+rDs
	 vsOlkJiCJdYSbczNBpSvC2EvNi05dOr53eFTHmAAjoYfcQhd4u+tJPUPPcTpWr7SUY
	 tYaMYdw8ubsq3dH3543f0/oUqsGB27q92o+xvOxZ7kyDBCPGNUXpSt3qXDTpARfnxj
	 2eG0kdJr6ebGpvSoYfA7v3VisLNH3zEGbidfcnnZ4dSpqE8z4lTR4U++pedJVNpXXm
	 sGwztfNOO8Ilchlv8pZmuwcj1CgE2Hh9ZATOfZN+WRX/NY0dAE2h/iI55XBF06UYRY
	 COTFUSGdxX2Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 419D46083B;
	Wed, 21 Oct 2026 16:16:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AA25930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C3EB8117D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gOmdFGZBNQz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:03:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DA0E810AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792594984;
 b=F9glxZhFrmi8gGuSCgXfR+umyQFcoeyMb7tEvVpLPcjYvTmSQgBhnTXIfHoxvd/HdpKk
 6D0BGB1nhSklvtuW1PB1lipxanRdsmCgGHE3gO/7lRQE1NTpt+VmD5/3R2STbb999hIEw
 ke9Er+0a4eanNIpSUACjIeh1l3yzk3v+M3V+9tatMEbE2XE7MLx9c6fdwu4orN2BulEJ2
 uazC/4Tmre1TDcKcOuQCBq+0UZvhWsjIN/zyeiT+PRofWmEs/XrJZ3jnloJO1JyOKnn/W
 Nh9ZKIzQUkB8W9aguWNOseH8F8h5Nc3BL8mu9duQ7jj0qYM1ri3JFAPRPku9idfYDtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792594984;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=II42TubdqGOm5oRfKyCA5AxxhLM8m4ZY85n1oPfUbSk=;
 b=PHQRhtPhLQNJ55qvlvIFF+kvHoVdbkchPYLF7ZJkYpepga2d50FV8m/qPMQBSNgkJ0KK
 A5rzUp5NqqrbvFH7aGwIO2ZjkhYo0AfShuJYRV5i9gjPe6gebwDYPAb0suOGrLW2pw+9T
 YuqMCDl800Gq6xypmGlvGaLywa+0l7ynMT+tn/nEHaHAOV4AlcByqK14KdjYFsVMnYKwr
 gbWblSZPhFD4C/5rKmBFvaLKtVDyp8/lLBu6ytJ1lbshN2ecw/s13U1KIi8fwNpXJCroA
 17EyPR2A2vRBmK4Dp1PjLmFnwoEcfsCgxFRkfHlJniMyagjj8GhuLet0kOsiPFvvZ+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=Gn7rf5yk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=SqOdlcxC; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=Gn7rf5yk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=SqOdlcxC
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DA0E810AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792594970; bh=II42TubdqGOm5oRfKyCA5Ax
 xhLM8m4ZY85n1oPfUbSk=; b=Gn7rf5ykXsIR79MhaGurB2Ksl8WbkDedaPtW8sWy/qEWxIMjB4
 CpES1xoXlypi5TG1CIeZJIo55cePvmjv289szUnAGfRZ5pZTHvUDstijgECZaDquu8qa1WJQaNV
 ICnAqeJt/YinYN0TRcb6Y2S7ePfzis1PXVwjjuSineJLmG8hJ9rq4QGv2kl5KRvvvANQ0jRxLZr
 5w5PPOkH6hu5xJtgKt46caJXRLT1nrYVHP/d7Mye7Nuibb1rLqNC9Z5eonA68AmM/Jiohqyugei
 4KgIoQk7hnqkbyvt0+qSSUvtqQWLCRjhbclpt45XyhOyut8GguChWSfbwev8OrmatDQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792594970; bh=II42TubdqGOm5oRfKyCA5Ax
 xhLM8m4ZY85n1oPfUbSk=; b=SqOdlcxC0wzRDtHzG8guVrG2otAD7kLEfXNZ3BdhVFEh1pKmT+
 j9VareITTnBMGFO8nWjkCwnWNTDgQlxj4PCQ==;
Date: Wed, 21 Oct 2026 16:02:50 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Beh??n <kabel@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/26=5D_powerpc=3A_drop_unmainta?=
 =?US-ASCII?Q?ined_boards_and_SoCs=2C_take_over_maintenance?=
In-Reply-To: <3682B813-95DF-46F2-BFD6-982899BD1A4A@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
 <athE5KyKe3No2qz_@nxa18884-linux-1.ap.freescale.net>
 <3682B813-95DF-46F2-BFD6-982899BD1A4A@mainlining.org>
Message-ID: <178C7BD3-E83B-40A6-A0EC-6CCE3F5C3569@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21 October 2026 15:47:05 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>On 21 October 2026 05:51:48 BST, Peng Fan <peng.fan@oss.nxp.com> wrote:
>>Hi Bradley,
>>
>>There is a build break, would you please give a look?
>>
>>Building current source for 1 boards (1 thread, 32 jobs per thread)
>>   powerpc:  +   qemu-ppce500
>>+In file included from arch/powerpc/include/asm/ppc.h:36,
>>+                 from arch/powerpc/include/asm/u-boot.h:23,
>>+                 from arch/powerpc/include/asm/global_data.h:89,
>>+                 from include/init.h:30,
>>+                 from arch/powerpc/cpu/mpc8xxx/cpu.c:11:
>>+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C291'
>undeclared here (not in a function); did you mean 'SVR_T2081'?
>>+ 1129 |         { .name = #n, .soc_ver = SVR_##v, .num_cores = (nc), \
>>+      |                                  ^~~~
>>+arch/powerpc/cpu/mpc8xxx/cpu.c:79:9: note: in expansion of macro
>'CPU_TYPE_ENTRY'
>>+   79 |         CPU_TYPE_ENTRY(C291, C291, 1),
>>+      |         ^~~~~~~~~~~~~~
>>+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C292'
>undeclared here (not in a function); did you mean 'SVR_9232'?
>>+arch/powerpc/cpu/mpc8xxx/cpu.c:80:9: note: in expansion of macro
>'CPU_TYPE_ENTRY'
>>+   80 |         CPU_TYPE_ENTRY(C292, C292, 1),
>>+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C293'
>undeclared here (not in a function)
>>+arch/powerpc/cpu/mpc8xxx/cpu.c:81:9: note: in expansion of macro
>'CPU_TYPE_ENTRY'
>>+   81 |         CPU_TYPE_ENTRY(C293, C293, 1),
>>+make[3]: *** [scripts/Makefile.build:272:
>arch/powerpc/cpu/mpc8xxx/cpu.o] Error 1
>>+make[2]: *** [scripts/Makefile.build:497: arch/powerpc/cpu/mpc8xxx]
>Error 2
>>+make[1]: *** [Makefile:2228: arch/powerpc/cpu] Error 2
>>+make: *** [Makefile:189: __sub-make] Error 2
>>    0    0    1 /1              qemu-ppce500
>>Completed: 1 total built, 1 newly), duration 0:00:19, rate 0.05
>
>Nice catch! Thanks for reviewing! There may be other errors, or are they
>all of them?

I fixed the one at hand, V3 coming, thanks. 

Let me test the rest of the boards


>
>>
>>Thanks
>>Peng
>>
>
>--- Thanks!
>"I'm not a very positive person" - Linus torvalds

--- Thanks!
"I'm not a very positive person" - Linus torvalds
