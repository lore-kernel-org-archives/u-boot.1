Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD77BCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8025813DC;
	Sat,  3 Oct 2026 13:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86meStZMmleV; Sat,  3 Oct 2026 13:41:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C671F813FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034891;
	b=ZRYqUf350xHMfiZ26d+We2S5wjE2UyjjQucbdZeg0yPhUweSmMO3Zr0vg/gTxU2U7OqZ
	 Kts5v+SXhp+jDWF3RsdTY/J8iDm56FBNctnxJ7tDh9+lN0HrXuaR/gMSW/W+FDfvCeYQJ
	 /HHpnxKyKrIbRRWqPigxl2L2+lxUtpY3YQNm5ZuSXJwgOrlOf6EFXQ8ingEXWWTfiXeDs
	 5l4e8fLc3RU9wKJ1M+WKifezd3roh4sQ7ddLKIzyofOsntWAiTlu1LLo+N4p2CJHtyaws
	 jF7lJTjxwYZVjnpf14NkOr2BBdU8kVIioIJ7LwNxjbjgr4ACoFWWv2xhHiWej/NFTPQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pNNfV1k6WAisey7/9oVGheLGekhn3gAFcnAJ+rqdvb0=;
	b=HVJPtg3fIbB4OQsoyrNmFRwTn3BI7DQgjhc0OHhh33PM1xmU4Jr1uZpZypnamivb2OUY
	 3qzq4osvFOTOnUxwc1MSrU/AP6ws92t7PfiHqJFSfQ1yIyuAWflA+jARFROU5KP2YgjHN
	 FXagY9Fgf/7ZuJB3muGYRG/lRdASEflcpkMNmjBBCQ+yzUTRMwzLLJeEUSOdtXJsKyYOi
	 7gdzdPqaIlqNCFGjtxx5NOoI3UK5GqI1JVYEjLplQ3+OWZ3ndTfNa3d48cALidSQKUOhX
	 V5XGt7zDUX5A/aLB++SC1JJJ83K1SLnH9PTAdDbIy+3wCcOoH3NarFq+Qh/6OSJk4+g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034890;
	bh=pNNfV1k6WAisey7/9oVGheLGekhn3gAFcnAJ+rqdvb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTrxk94T4div4gMxgD5u7a/c7J1DWf2p2VbaImQxJoxJtk1a9XrZ15FrUTRy2Wnsu
	 y5peqKcOnjg0DyPamUqTZ/+7vN27XsILkpChDzfwN3Y0T2TGOzq48sS3AM6D8y1KPQ
	 muPIfPst8hTRAPRCYdg4Ihl7Z69YXg5S9hRVJE+5aALwozI4hYRfN69MuldyxVAjgr
	 sstJqf2vVxi5K8e+Lio0zbrs8Tobl2F9smd8hXNK909ckush7CqpocZ0wYsDPHQln0
	 yijvi+ufH21468FW8DYWoWyFcmVl/HLwha1/kDf7tETxl58svT+pT0JaZUKBTHMhQm
	 H6d1hc5c4+Oxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C671F813FF;
	Sat,  3 Oct 2026 13:41:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F34335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5ABE8414BB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQcF-xcUA6fa for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6447C414B6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034888;
 b=NO3N5n8Ov8JHLtGxNwQas9t5j1elpTx8BPFiUMOaNbj3YnmHVg6jXsySNwaQH675bflR
 piwcteaTa5iYEwGcbWVJ8wYg8C0fXmPkcOOrkSHv5fJRdEsRz/CCP00KFP4R6XirsVf6R
 BRu+gW8fMsLJ2obWEZCb/xt7wsDK1xDxyeDS965DEpQQAHPeHSza7XRDKLR+hfi2u7MEo
 dtvPg2NhPW4a5hinyUjnRLivMI2x9OQKeHGbpa9z+JN6hp1w29EOlfq+Ck5MX8/gBrlKe
 rSQTKJdPA0GQPD8nEdNXcB6uGyk4iIS5K69Ei8Xb37Hzt234cYiwjdZ82ucDS4/mvjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034888;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=pNNfV1k6WAisey7/9oVGheLGekhn3gAFcnAJ+rqdvb0=;
 b=kZGkDcH5LYYN4qJSfhG5tyW8hKmQvYZhQsHJ3NmNdNqk7KL1jh7iAmomVpOoExCTzysc
 RhuYnV6lEubBxbaMLGrqPFPRiMMTojF6oBh9T3cEgQQlhEmmHyK0nlWNTLk8F+RljsrGI
 vs8jWR1+E0hnrtZhFepdK3y/TNWlqvajxtg2uM2sGvEcRurQj96qnFwfYZmLbFq7BhWke
 +tXqeuBDO3C+UpBZvCDpl585+xHHZMnth3QFomgqDMy6zvUvkGHQLEb28qm26twB4RPBt
 SqkM1hrMBh/SyMMaMdwDtjgTClYJoJ13esBJlnmLPo1DDphoEUnvjJWtNDwQ/KYydMw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=J8SAXg2q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=J8SAXg2q
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6447C414B6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:28 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6af7d702c76so506166a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034886; cv=none;
 d=google.com; s=arc-20260327;
 b=NfEKEactfqdaREQVgS6rZNwjwjoFeM9WV749SqtpsydUWsEYWqkR4lBFYvTbcYP774
 29sPa2AhrNXA2JZYwLbC1rnexeaf7ZWJzhZpbmXaQcx0wt/upAFifpHB2bXc8RwYUTR7
 PlYLr8Gv1tY4fJ5rluB3fUTW9i6m8AXHimPrPm8NlDdauAmgc9mDWLMeEeq0m5opno+e
 /GKyN4AYy+AE/zBZJN+dekiEMkXR8bNRihsRpF4BKOatchuqorA9SpDVVU5GWW64+Im3
 NNUezJg7FKII5b9k7oarAMB+Gfy2acl90UU7g/qBvldx2IA8Ppro2yU9DVEJCosYcmWo
 Bnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pNNfV1k6WAisey7/9oVGheLGekhn3gAFcnAJ+rqdvb0=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=R2sN4AbxYVQIRNgYhzEUWR6KRtjTloJMoRN6nIB3Xm/LoG+hT9mZ/p16iL/AsECmn5
 L4T8tIjhhBoKMshSn8dMjEMoChyb4uJpCAaoaDVZQjPN6IL34htj0/01R943o9IR9Nsz
 GwPDMYNqNWrqf119lWqjIV2xSmEURKcTC2rfU/X69WwGvb5erz8Iv05CnGbkbJ2rEqqI
 86mg3dKoO3W6qwZ8QRaMQ1kYhUeGts4pIki0cb0hxswKUhd0PnKKCP1hHjlzeQNhnO8k
 T+6jF9aPsqBrQgp7V4CEyaRrGOXtE6gNf1x2r3gAejS6A5MeBjqRtkdqt/T33EvpTGze
 klew==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034886; x=1791639686;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pNNfV1k6WAisey7/9oVGheLGekhn3gAFcnAJ+rqdvb0=;
 b=J8SAXg2qKb4HfmQMwghcKpbclUSFYW/9nltTJ0MlUiWtlz8zdQO0znysXAwelRSI0d
 TsBJc2It8BHsvi7xiJfCriqQv2BdTXCrqY0o6QM6AjweyASMIth/MOOfSRR0OoIeDlij
 DZsgonGCAi1YqXNBewyrZFFn4RyXkTYbWgaBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034886; x=1791639686;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pNNfV1k6WAisey7/9oVGheLGekhn3gAFcnAJ+rqdvb0=;
 b=B19k+CNPIIVATqUvB6l0JQIQkgA57HPBjm/EI/5yja3uz598mA78KhWHbPjgdZqqIL
 jgeY4ml8EW9TlrWvMLISGlNxbJwNzjFXXPl7k9JfdHEhFQU9fDZ81w46yRKMtuyyme7j
 ar/mEG+EwF5tSaajqZjBRv/0vpBqkqRBh1p/ow6uXFp6BPAcKTSiWGph0wMC0xmS7aC3
 FtmV+mvWeGOyM3ZMGFT6oesRzB3gNPV6YOsXMVOSMXJcmZC2d5eE733XabkEs32BeWiD
 LVV+bhhmO6HFdWFln/V1I1hwPwlWO4cPwFKmc5GQ92krXqKyWeZy52yiIThnRPU+hydu
 7qFg==
X-Gm-Message-State: AFq9FYKWpySGxL9EAGhHEN0gUJCN88Wk46EzEzO6nHvQPA7pvDblgw5J
 jCTSOvZMn/R50/88MDfGQkYgBVQQToIoxdffeS5U2W3JCIc4MjV0HvbgWYJF0/Y68QSqYex6N/l
 xpT3Uopw0CZU0LVLUSttJjWVZV439RCpXBOWJUjga
X-Gm-Gg: AYBFou2TCNPKRDtAHKnvKoMpHXGTBjJ5KEmUTIdR8zu0kIeMP8XdC2yVlt23yCIR74w
 LFhlGxE6PYG3EFcGxatUX34aXWAfXw9KLEasoQjcNrVzyGn3onyukitEMrztZ+Qjogetglt+91q
 Nw6OtZ5oXnONvAUUkFGSjS2uOV9mN3DkzWWUP/b0sm6xV09zFnk2EMoeURr5ZiyjwvS6i5IeTGw
 +hqHqDXPmfClBjEBYW+XopUi4DHH2yYMG2HYVluOiFSbdJY77xw/uxN2I/AzaF6K93/PaAfuiUE
 7AqWpsJq0C0kSFCdQv55hhmXN+/zjwkgFcMdBphKDXPwZ684z2xmrR8=
X-Received: by 2002:a05:6402:1950:b0:6af:82a0:d3b2 with SMTP id
 4fb4d7f45d1cf-6af9e2f9281mr4490529a12.29.1791034886178; Sat, 03 Oct 2026
 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-8-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-8-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:41:07 +0100
X-Gm-Features: AclHuK8lCnIIpf9Emnp-zSe-7Jfksvd8GboPGzcN5nP1UHZjxKOoYBnt2lL4-e4
Message-ID: <CAFLszThdFcAB1EnCRfpA=EpWBUdF0Ai6wVb-oNO0+cztv0_95Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] test: spl: Cover FIT image decompression
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Cover FIT image decompression
>
> Nothing exercises the decompression in load_simple_fit(): create_fit()
> only ever writes compression = "none", and the canned LZMA blob is only
> used on the legacy uImage path.
>
> Let create_fit() take a compression, and load a compressed FIT both ways:
> with the data inside the FIT and beside it, since only the latter stages
> it through CONFIG_SYS_LOAD_ADDR. Point that address at the same offset
> sandbox_noinst uses, since otherwise the staging corrupts what's currently
> at 0x0.

Please can you say what gets corrupted? I believe it is the bloblist,
since CONFIG_BLOBLIST_ADDR is 0x100 and the LZMA blob is about 2.8K.
With the address left at 0x0, running spl_test_nor_FIT_EXTERNAL_LZMA
on its own passes, but then I see:

    SPL: SPL hand-off write failed (err=-2)

Since this also changes loadaddr for U-Boot proper on sandbox_spl,
please can you put the defconfig change in its own patch, before this
one?

BTW sandbox_vpl still has CONFIG_SYS_LOAD_ADDR=0x0 and enables
SPL_UNIT_TEST. It skips these tests only because it lacks SPL_LZMA, so
it is probably worth changing that one too.

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> configs/sandbox_spl_defconfig |  2 +-
>  include/test/spl.h            |  8 +++++++
>  test/image/spl_load.c         | 52 ++++++++++++++++++++++++++++++-------------
>  test/image/spl_load_nor.c     |  2 ++
>  4 files changed, 48 insertions(+), 16 deletions(-)

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -40,7 +40,25 @@ void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> +static const char *image_compression(enum spl_test_image type)
> +{
> +     switch (type) {
> +     case LEGACY_LZMA:
> +     case FIT_INTERNAL_LZMA:
> +     case FIT_EXTERNAL_LZMA:
> +             return "lzma";

LZMA in a FIT already worked before patch 5, so as far as I can tell
these tests would pass without it. See my comment on patch 9 about
adding zstd cases.

This helper is only half general. It returns a name, but
create_legacy() still turns SPL_COMPRESSED into IH_COMP_LZMA and
do_spl_test_load() always copies in lzma_compressed with the 'lzma'
seed. I suspect it would be cleaner to return an IH_COMP_... value,
pass that to image_set_comp() for legacy and use
genimg_get_comp_short_name() in create_fit(). Then IH_COMP_NONE gives
you 'none' without the special case in create_image(). What do you
think?

> diff --git a/test/image/spl_load_nor.c b/test/image/spl_load_nor.c
> @@ -35,6 +35,8 @@ SPL_IMG_TEST(spl_test_nor, LEGACY, 0);
> +SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL_LZMA, 0);
>  #if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
>  SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL, 0);
> +SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL_LZMA, 0);

Why only NOR? It reads with a bl_len of 1, so the external case never
has a non-zero get_aligned_image_overhead() when staging through
CONFIG_SYS_LOAD_ADDR. The SPI, NAND and net tests already go through
do_spl_test_load() so they should just need the extra lines.

The MMC test would cover the block-aligned read, but spl_load_fs.c has
its own copy of the type == LEGACY_LZMA checks. Please can you export
image_compression() in test/spl.h and use it there too?

Regards,
Simon
