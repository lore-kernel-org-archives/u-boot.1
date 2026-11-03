Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B19606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xBrs4T2i;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CKit4vCV;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=sVcUEoY+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26E1880E21;
	Tue,  3 Nov 2026 11:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwrxFgLZPKbg; Tue,  3 Nov 2026 11:47:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AFD480D5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793706457;
	b=T1WFNi0JGagAdc94ax1DQ4kswrxNd/DbmmqFD/nxyekewWqAgkZUKiqcW0Zk+94kZdNn
	 LiU6yoSKFpLQFOr0NS29xrckEIp39v+Zuol4+R/6U+Gw6X/XZLfoTtB0n8ScMLkACdROx
	 WEJqEv2px9odFKc8nYt8238HEOB8iSUXwifET115IWjah+3kTL3A9rp4JLno+542eZOyR
	 gPt/tKZfBXtyIpRoQweAYtyisbVaQyvb6gj8INsiNrbAGSnfrb2VCXKm50iYcFrJe2yc1
	 ECMUr4TROsiTtGD7taOWcmPgYLFbA//ipO1z54VGy6FO/Tq5z6d/NS0d9TjLkkilbfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793706457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jaM68yBg11EYE76Mkkq+48Sz25DMfss/yX1txgxYEQU=;
	b=DK2rbmtKqC/lasbN8yQ4TxFzbnwO5ZyE5nYY3OsMHZ3XW0OGUi3RZ06DU9YlLOQ6cMs/
	 fhgafckuPdRdeDDKqmlfdZW9d5GKoYobLhLLHn3KKq2YYbplxF/I8UMoAtq/GxtQ79/+f
	 pzrU0FZmzirRwxmciFbrAiZTZqR7xZ0pA1kVCWxfwfctUVA85QaZiIBgkzGCVQPFVZ/s1
	 X5r902eCLKx9+N09tvl6nefjRnzb+kqkjELa7f6O41LokWJr78bvaPljvZKoLeCPU/irJ
	 z9vEt0PBlJpQh6zoC0WaetM9KCH029yXfqKj5ui5QK75E3PpOEabgBKg5uTIVuSNThA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CKit4vCV;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=sVcUEoY+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793706457;
	bh=jaM68yBg11EYE76Mkkq+48Sz25DMfss/yX1txgxYEQU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBrs4T2iJlqr8VmQwKavlENVtjtIvdZyx4WGksbTfYqwDyidvZ6uwX5XZy/FY251E
	 XLDqW1gHsNv+d0/iDO0uUkqqP8NMtUCcYhmFnugicp8du6o8S98DoVDuiEJZSKy7Ng
	 ocQEqhj+J0HLv/7rN4U0tA1q6pPHT35B/jOXIa9wGki45XUf2j9BWxpUKQwJb3StyJ
	 gHuZpAlsZeAo5hffcp46skajgEP9yFiLM6fG380OXnnsz/mJP2bpES23nLzvaD/t/S
	 vlzHXmpKkhlKPxyX6LCoMPp/ib5ZVAS082AXwotl4LrN8eIoGSczM9xdRFcSsbSuyj
	 mksVIYymDBlPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AFD480D5E;
	Tue,  3 Nov 2026 11:47:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFD45235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 923D080D5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wnSTlq9y2wN for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 11:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41FDD80BE9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793706454;
 b=IyJnTX7YYUKUT6pxJqjEBEnVigI4Q1vGNKlFMM1O8+kvsrAWvdcBs/TTB/bt9twELAJ7
 JIe0lhsY/TRTZs21oS7O8rZCdbQqhl7dhhGBcVz782iukszwDmNlKH+veQS7J//GrPkSk
 kZ+1DyYGLO3tk+5lyxMqIeZkaMhwTZcddc3drIPuDAuUlhBp3q6t/z/YTqXxghSBG3XF+
 HTwR1TJr958vqaGgoqZHkPPksVfaIROGcIdiYAA+X+VN8bXvjZZUqMHcUrPMwCBo1hv3d
 S/4BcNSMa+ufIpWo5KnQA/JFW4zhynStoON5ZotE+FnhPmmxRcEfILBP06PtITz6fZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793706454;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=jaM68yBg11EYE76Mkkq+48Sz25DMfss/yX1txgxYEQU=;
 b=tGRcfSdFUgKwnzjIOs+oe2SVNvBXBXM2a85LphMeFasGlsnNzz+K/2RrA5vNKE16HUQv
 L4HwH2XuJkKU9+XoGL9qZug31w+mcu9vOW2dFp6/jNIVpEE4yng3aTmJ4EAYeGmYmkbTx
 uZU5fHvrqiQ5dtOWF8BYqiVcTJ8vijYLaDWIe/IeS9EJOkjERmr/2XDTDuKo5Y3wP7iG7
 9w22KVjtVyDUD4sPcU2zfUl6GHjHXXUgf3G2E7nHwHFQMwbaq02Du7ed67vNdA7hxnmBu
 +a7N2Vrjc/KtyiSTeOu6UO4u4wz/zuJCF5wbLqUqZOMYE4K9irBRODketY7TiqYnDdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=CKit4vCV; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=sVcUEoY+; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=CKit4vCV; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=sVcUEoY+
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41FDD80BE9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793706436; bh=jaM68yBg11EYE76Mkkq+48S
 z25DMfss/yX1txgxYEQU=; b=CKit4vCV3jWqhpWnoQpX/RFQpipcd/KVe5+gktnQlF/BnEeuJt
 DWhvvnbV4sew31070B6KGxK9u8MlK+DLxid1j9NfFXbMfS1S5Lsiy0XW931jKk+m8/kOvGF6/c0
 D/D+WKQvqYoj02nHWifiV15p+tR84nt0QHp8m6aahadvK23Yl8QGKy1Fs1aaBzL8tTCvJJRHXe3
 VJ5fgB/lqDNcDOI7aWZEfQx2xyfsFLu3rgnewg3Nv4ju5YxY0wvByjyx2GikyaEhcY5zSw1kAfL
 NWVi4moMTYYDrf1mZffU96hn6KXUSjc3UuiE5Dcw17Tf8gJ/w3RMkbSZ8ksbYIYTPzg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793706436; bh=jaM68yBg11EYE76Mkkq+48S
 z25DMfss/yX1txgxYEQU=; b=sVcUEoY+RxjGlAGncL9QSNA5nux7yyHTVH3LKniTWcLVb1mJB8
 UVJlIABWhDkBb2LrDVFf3uWT8Otvg/V0N3DQ==;
Date: Tue, 03 Nov 2026 11:47:18 +0000
From: Bradley Morgan <brads@mainlining.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
CC: =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_00/26=5D_powerpc=3A_drop_unmainta?=
 =?US-ASCII?Q?ined_boards_and_SoCs=2C_take_over_maintenance?=
In-Reply-To: <811302be-3815-48de-b5c0-141be2ec3bd6@kernel.org>
References: <20261021160145.10430-1-brads@mainlining.org>
 <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
 <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
 <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
 <811302be-3815-48de-b5c0-141be2ec3bd6@kernel.org>
Message-ID: <51F2E8AC-939F-4927-922C-CC42E347D9D6@mainlining.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3 November 2026 07:15:42 GMT, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> wrote:
>Hi Heiko,
>
>Le 01/11/2026 à 07:18, Heiko Schocher a écrit :
>> [Vous ne recevez pas souvent de courriers de hs@nabladev.com. Découvrez
>pourquoi ceci est important à https://aka.ms/
>LearnAboutSenderIdentification ]
>> 
>> Hi Bradley,
>> 
>> On 27.10.26 00:50, Bradley Morgan wrote:
>>> On 26 October 2026 23:47:58 GMT, Bradley Morgan <brads@mainlining.org>
>>> wrote:
>>>> On Wed, 21 Oct 2026 16:00:56 +0000, Bradley Morgan wrote:
>>>>> PowerPC in U-Boot has been orphaned since October 2022. Several
>boards
>>>>> and SoC targets in arch/powerpc appear to have had no active
>community
>>>>> maintenance or testing for some time.
>>>>> 
>>>>> This series proposes removing the targets that are currently
>>>> unmaintained,
>>>>> to help reduce maintenance overhead and ease treewide work. If any
>board
>>>>> maintainers or users are still actively testing or relying on a
>specific
>>>>> board, those removals can easily be skipped.
>>>>> 
>>>>> [...]
>>>> 
>>>> Applied to next at u-boot-ppc, Thanks!
>>>> 
>>> 
>>> Pretty confusing, hmm? Sorry for the confusion, B4 stuff. Heh.
>>> 
>>> So I would be more than gracious to rebase if anyone was to NAK any
>patch
>>> in this series, I'll wait about one more week then send the PR, maybe
>two.
>>> :)
>> 
>> Thanks!
>> 
>> Please give people time to react, as most of powerpc hardware is old,
>and main
>> business is not anymore powerpc...
>> 
>> I can speak only for the socrates mpc85xx board and it is still in
>production use.
>> (Luckily not in this series!)
>> 
>> I try to convince customer to give me some time for updating to mainline
>and may to
>> setup gitlab CI (I have a setup for this including a BDI2000 for
>recovering board,
>> but need some time to get it up and running... hope I get some).
>> 
>> BTW: Do you have any powerpc hardware (as you volunteer for custodian of
>*all* powerpc?
>> I do not see much commits from your side in tree...
>> 
>> Also, just finished work on mpc855 board (port to 2026.10, linux 6.18
>and yocto wrynose)
>
>Don't worry about this one, I'm still maintaining mpc8xx.
>
>Being a bit surprised however. You dropped 8xx support in 2017 without
>notice with commit 5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx")
>and I had a hard time bringing it back.
>
>By the way I only partially brought 8xx back, only for last generation 8xx
>like 866 and 885 which are the ones we have on our boards. See commit
>907208c45299 ("powerpc: Partialy restore core of mpc8xx") for details.
>
>I don't think 855 is supported anymore, at least register PLPRCR comes
>into my mind.

Hi, thanks for your work!

Your maintainers entry email is stale, would you like me to change your
email to your k.o email?

>
>Christophe
>

--- Thanks!
