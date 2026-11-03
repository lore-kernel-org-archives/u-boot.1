Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF4606A32E
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qaT/ZqXg;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=UU2Kb8Gl;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=vrDG5YDs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B5486077D;
	Tue,  3 Nov 2026 14:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J05D8ZJ7WBIM; Tue,  3 Nov 2026 14:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94F3B60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716528;
	b=L3As4Z7cri7DUbNGnrkN6F12JDPYr6dqdkZqR9981f38yS+XjJDM4cgvC0Mfl+nUiISv
	 /RxzB71BzF8qGJtPgBmSM5ZcBuIM1/d4ry/3IxgB7funum5v67KYwWlVMGv+KokQ4RFCU
	 3apps/PUCgdP+NZO+e4J2U5zgBUqui3qaGR86oP0+XsPHwEvShWVDzFWrYR54Pm1UtFc9
	 gEIakVFlCk9F3+n3CKjcbSHwradZehBJWpqLyRbD/advdyn3B0SiVnWg0Fzjfe4qzwgNR
	 7IazoqejrKfpbCIkp0Hyx+Zk3FgEiWcU4d1RPKfe9Zo2KZEPANoLCyKg7VVct3Ri6sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FJO8fME03smRWkcOB1qjWzpt9d2m3wLr+uUsLao1BqY=;
	b=DS7FocPmdEB1IxK2UZAaXNlEueHkZUkzYSvBzMFNh8BsFxryKD2p0JKXmm3cstBDgDor
	 wBFpiGSuKXUsn7YaSuEOb/zDRCa8r2yT4C1qa6Ivcqar0FXNXUnRRUwb5YFUuQwapSoTt
	 4elovXrfM9mcyII3keHhnLTzD4V4er+vkcR2a/Ul8c4cB5NC6Y00BL1vhjS7cC92GIxr5
	 /ok7Rh6JvxS0tEpFb4zFhya4qXD8DrK2YwKKkz4c6VM/2QfmUSW4hkp2+oUUErpTsr+5g
	 ALa5KfXFS6RwdpWoO5d8Y7MqxBvSINf0OFYXBZvESbtObCAHLj14kaIKv3J9JkGQ4xA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793716528;
	bh=FJO8fME03smRWkcOB1qjWzpt9d2m3wLr+uUsLao1BqY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qaT/ZqXgm/bYyviLh/gudeFgWeYGCwn80oSiAHoe2LZQt/vQUo5l3b8+g2AWm0Zdy
	 bWUNsDjRDs8Alfji4a/TQ4Q0xLE29O4EJPYM2EnrK9qjulKTzGNSxNSVMueG1NjTWf
	 PKprvjcxXUc+MWHuVf9a+O8JN/jTLZx6lCNVOcS6FatHfFzwYgvVKWiz2sek8uKnQN
	 al650HFU8kM6A5xdQ6V5eCspTYm9S6IG6M+h5H7wnXTEmu9ASjSeoJNmOnaTTfvwxl
	 pSXOAIxK8yArIxXcBbNBUXa3KhnhZzLNpJvqCvBylrd1BfbT2/ujhXbWVRFKdTx9cU
	 n4v8j9UJuw5TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94F3B60621;
	Tue,  3 Nov 2026 14:35:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1F40D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A335340070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmvzxUQ1KFvS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 38B0040068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716525;
 b=ePKJBV+W2T/tTWTUjWnYB/4c1NRo83i9UcEBGx3asX2hWlGooKM9lOX4dLUnjbimb1bs
 kFMRXQnIQIYwiYycIflzhIX4c0H5nhB2jdGsKevPsCg6fhvvt/NF8qY+Tm8IFyG5LpspR
 krtB9RMvEigFQTZ0Ewsua3ltNQa4k9amooNI3kaAhdC0k/qNmr9vLa/whHdQGZ6f4kGRx
 OCaDViLrxnw1tk8WZulrFRILburxaXMuX6OYSmc2ZxR+TkOzbtVk73oj1S8TPeBn1kZfc
 8jd12uX3t/YQVJhO8Asaih2hf1gaC1yRD0Y1rBlX6Zhj8ZGYlEVoqQtXg9JoGcY3Hqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716525;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=FJO8fME03smRWkcOB1qjWzpt9d2m3wLr+uUsLao1BqY=;
 b=RE8Ex50nAH79HroNSDAyR004jmhgdMPjQrb+hfDKQBhi1CY02DdKsxIXa1lM0GtKtK62
 SabKD5jhmMBRTD33s5wPC5juqEkxA0LfzhcoE0pqGMSpsh20ptSeQ3p8MYpugXUfo4zQi
 EEdWeBRiRT/WL3d+42X2p9a+t/iWtMT97aNzycpCPxsvDeCOJKKGYAuOr59T6/65fKntZ
 TYU2w1cv5hv8ahFGly5RbfWk+S1Y0ZWc/QhepJAJug3iS2DRmB+Osnqi2WE9sHjKVRELt
 aTJcEeP56VnXAwOtMsaVcCpY2hNZjWP+3QTB6FbvLwklIprI6V76Ci2+U4tSHZEWydQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=UU2Kb8Gl; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vrDG5YDs; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=UU2Kb8Gl; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vrDG5YDs
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38B0040068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793716519; bh=FJO8fME03smRWkcOB1qjWzp
 t9d2m3wLr+uUsLao1BqY=; b=UU2Kb8Glm3/GeUb611kEKIIyyIPWqyfAyPqdivebX41ZYvq4xl
 cq8G/jQifG2OJX/8Onjs0bgKoX6lnW8HMpCJPsR6fCjeIWje+74ZNReo8c9GZM7Vc9Jat6F3cL/
 HUAiEJ4FHGhS8HabiR9eljK09tXWotvT/UgnSMbNZZMfIZ7waJo3shn4JX+KOC3w1EXC3SpOwtK
 J453rdT7gImdEGW3wq9gPuiVYxL/p6eOS/MbNGsOQNxJa1OfHGgiGYPReSk6tV3H/T86adnRuJO
 iT6npMMYqQMO9mdc6hPN1aCokaTMzBE+kGkVKzN6iiALbywim6zl7Dr+KPhLnWTn55w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793716519; bh=FJO8fME03smRWkcOB1qjWzp
 t9d2m3wLr+uUsLao1BqY=; b=vrDG5YDs8S9o35nJITd90GHarhkQNsQXDNGH8aKZtmwFDgEM3Z
 yTAcWqhsIh/kqbtptFVBkzJM31Iscvx+XhDA==;
Date: Tue, 03 Nov 2026 14:35:17 +0000
From: Bradley Morgan <brads@mainlining.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
In-Reply-To: <AD60C4C9-70D5-4C31-B773-86FD9114C1A4@mainlining.org>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <AD60C4C9-70D5-4C31-B773-86FD9114C1A4@mainlining.org>
Message-ID: <9D4F1FC7-573E-41E6-96DD-02397083F21E@mainlining.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3 November 2026 14:27:50 GMT, Bradley Morgan <brads@mainlining.org>
wrote:
>On 3 November 2026 14:03:07 GMT, "Christophe Leroy (CS GROUP)"
><chleroy@kernel.org> wrote:
>>Some people have reported christophe.leroy@csgroup.eu being stale
>>from time to time.
>>
>>Change to use my Linux Kernel address chleroy@kernel.org
>
>Thanks a ton, I'll merge this in coming days to next.
>

Btw: if anyone else would like to merge this to their trees please tell me..

>>
>>Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>---
>> .mailmap               | 2 ++
>> MAINTAINERS            | 2 +-
>> board/cssi/MAINTAINERS | 2 +-
>> doc/git-mailrc         | 3 ++-
>> 4 files changed, 6 insertions(+), 3 deletions(-)
>>
>>diff --git a/.mailmap b/.mailmap
>>index 76ba0a7fea3..6685205a232 100644
>>--- a/.mailmap
>>+++ b/.mailmap
>>@@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org>
><boris.brezillon@free-electrons.com>
>> Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
>> Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
>> Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
>>+Christophe Leroy (CS GROUP) <chleroy@kernel.org>
><christophe.leroy@csgroup.eu>
>>+Christophe Leroy (CS GROUP) <chleroy@kernel.org>
><christophe.leroy@c-s.fr>
>> Christopher Obbard <christopher.obbard@linaro.org>
>> <chris.obbard@collabora.com>
>> Dirk Behme <dirk.behme@googlemail.com>
>> Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 45e9076de67..f0a6de9409e 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -1594,7 +1594,7 @@ S:	Orphan (Since 2022-10-21)
>> F:	arch/powerpc/
>> 
>> POWERPC MPC8XX
>>-M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>>+M:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> S:	Maintained
>> T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc8xx.git
>> F:	arch/powerpc/cpu/mpc8xx/
>>diff --git a/board/cssi/MAINTAINERS b/board/cssi/MAINTAINERS
>>index f82dd3b789b..8fbbb94b953 100644
>>--- a/board/cssi/MAINTAINERS
>>+++ b/board/cssi/MAINTAINERS
>>@@ -1,5 +1,5 @@
>> BOARDS from CS GROUP France
>>-M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>>+M:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> S:	Maintained
>> F:	board/cssi/
>> F:	include/configs/mcr3000.h
>>diff --git a/doc/git-mailrc b/doc/git-mailrc
>>index 65626d89eac..eb676b3ed85 100644
>>--- a/doc/git-mailrc
>>+++ b/doc/git-mailrc
>>@@ -20,6 +20,7 @@ alias alisonwang     Alison Wang <alison.wang@nxp.com>
>> alias angelo_ts      Angelo Dureghello <angelo@sysam.it>
>> alias apritzel       Andre Przywara <andre.przywara@arm.com>
>> alias bmeng          Bin Meng <bmeng.cn@gmail.com>
>>+alias chleroy        Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> alias danielschwierzeck Daniel Schwierzeck
><daniel.schwierzeck@gmail.com>
>> alias dinh           Dinh Nguyen <dinguyen@kernel.org>
>> alias ehristev       Eugen Hristev <eugen.hristev@linaro.org>
>>@@ -97,7 +98,7 @@ alias nios2          nios
>> 
>> alias powerpc        uboot, afleming, stroese, wd, priyankajain,
>mariosix
>> alias ppc            powerpc
>>-alias mpc8xx         uboot, wd, Christophe Leroy
><christophe.leroy@csgroup.eu>
>>+alias mpc8xx         uboot, wd, chleroy
>> alias mpc83xx        uboot, mariosix
>> alias mpc85xx        uboot, afleming, priyankajain
>> 
>>
>
>--- Thanks!
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
