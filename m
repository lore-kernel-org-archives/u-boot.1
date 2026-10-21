Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71F606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WKaMTLgT;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oEiRnZ3o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC4D260885;
	Wed, 21 Oct 2026 13:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YkxVxWSaI2nr; Wed, 21 Oct 2026 13:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 470B260848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588184;
	b=LyU8iqLq0Iu+bSnn0itooKqgt62tdmABsxHn6fM2ebabFltocxzqso9vlrkQlCFChLk4
	 U+gNiMG8/kMzYifU9IrkldA0mWfiqaXZ71Jso+ctyiZHB2uKHyyEiLFRC54G+luKmYFRh
	 4tQgdulcBRy7yzGDE119lu17JKVVYOunUnQ0zX8p6VmP0PfyQP77ZnSRcTXWaE4ylDzl3
	 FQzt/+G9lBBiydet16Rn11y9Z/9Twlo7tr+z6C0eFyjolOA4XYas/nAnzeHEJIaTptgf5
	 AwvjGhcJ5YgPGVug0KiIYQnELxKIEQ5xz4QfCiWEQJraocAkdyA3zPihbFpaAp1psFw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=38tB8txbv/TMCFTTJMSbw5Re7xhtSJ8hXtj8XqT/OJw=;
	b=CJTC9viUgYwPQwyeaZguK7H/SOOwytdUiMP05iarhZzk8X7Mt27Id2cekd7a9jOvmo9Z
	 VWJdg58zeQfLsGnmr8AY+Y3CWv4HJgNI3Y6WmcT41Ajq6DHrlbgGB42rJzsiXAZj3oZBT
	 ESbxE8yeXj7s27G8B2nn/jknF1CAC55iQ/+4oZxcgY0/+z2tADs1fL81Yhth3JXqhlG4H
	 bAYTg4Flos712CME/7fwv/ydtT/X+4XcyFeAUaTc3pR7otZmBcOj46VTLnaoDxwbICbR3
	 /LUqOHOAMMPa+6I5Mx/wLzrrsCSqvaRG6Zg6RUFxyAwxD8EEfjCP89NMlv0KstAU8TA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588184;
	bh=38tB8txbv/TMCFTTJMSbw5Re7xhtSJ8hXtj8XqT/OJw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WKaMTLgTQT9QiQv3B9OduPrvz894WTYCc/iPlNEQq0xB8JGoKu6EBSoZqddSCMCh2
	 NcFz7pxvBMN326mJkg/sIf/geeDjTqfExMBIp7gxMvz5BeJUh9cdcTeZ37h3CXjk03
	 z1rfOLOzoqGxqp95NQEgzt6iMUKkIwwOcjwgY5CZqpFJ+uYROqofEFq4OHkaXduzv5
	 1nfJgLTuD2+PpYu+0k2MX0mXUkecl6Ymr0VmtkHnLDpza8rJ5nJI2q1bNfP+FqDIri
	 Khq1cJ1la/JClVELipRePh87ptsfBbhCGU+B6aCRsmRiI/z7k7jNRNWgfSXwP7KfgP
	 fnV0QL0583Tww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 470B260848;
	Wed, 21 Oct 2026 13:09:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0C1323A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2A10407FC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VF_f5LFJ-K-P for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 178BB407D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588182;
 b=B0mKs5DrkBGnf8tBY5SOBg1EgLilJlF+hDIzCaMY9m8rfwp7SPZylD+zqCFT+X+cJP77
 tuIp7cG+VmNg39XZrt6ym6wpsIvnMDmn/nuIyN9/88liA+g/ID/OBPxXtrsHQaZcC2yeQ
 AAW7uHx46EuG6/B+InjYWew086pS+5X4rcF43ETKsHS7BmFms7jt0PUxlG6dCnU4l3elt
 IoVWlQe2W3/CfRv2RRzsfFuO6XvaNqsuHCdaeyL/Gf4luTI+B5xBGd3XIhYLxMlUSXJwk
 gGmB2prW88bVa08FS2o+mJnzH3PDgoupJSUbYfJubEswviolxZrMyUExG7wVJMKoIhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588182;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=38tB8txbv/TMCFTTJMSbw5Re7xhtSJ8hXtj8XqT/OJw=;
 b=WnAXUjaTDNr/cbqP6/4hG0T5witSHNbk5iAEpyOu/6Bl0RUJa77c0Xy/P4Wu5RxYP22u
 YXGl/yAx7+revZztzU9Y2nVWfg1+MlyeLl1QrpvLLvB93No8sczGDR062TFb2iY/019P1
 4IJlWiyd+geF7mc6TF9XXpZMf5qQ+rltE1UtoD/ZOtNqcSQ/t+XkE28M5YaP3U/+V+nRj
 loDTS2CI4pW2rReMp0eCq2tpU6qvusv39lJ/vTU+RkNUiu30IoQjKX1xhnJdBM2T+o7wv
 lZjRcFpBWH/nkGXRI0J66Ct/IcmlN8vKFu9bxVpnKgROYbGGv13xlGusm/Zz0l1nRmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oEiRnZ3o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=oEiRnZ3o
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 178BB407D0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:09:41 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso3785695ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588181; cv=none;
 d=google.com; s=arc-20260327;
 b=BhpjfESvr66iAM5TxC2Syg3K25gYEH2c1DVsXRdalsVcoEsluqB14DyKAjokaK0F9H
 sSpvmdSkIG/t7ZziJy3VW5coCIGaWoCpddGe5nZlCsz7rdEF4ZUtbaT7Y+FjiO31cgDH
 TU7n1PK0wvRQWsi8wXAh1OcG2d2RrgduPnCjS4vOYYWP4d8jNdfKa9uA6qrDjmE25MlN
 dLOWT5IC75dFpwbzIktxiI0EqwVFQLCKkBQ1PfCSguisibl9+gSu2Uno3QYlE7PayPSt
 qor7fqkHTY6vHkpTDGY+MxTeDDcir+/UpiECYhBzZsrFzCjTVlrRcMje6pD4VQaOZlKx
 /D1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=38tB8txbv/TMCFTTJMSbw5Re7xhtSJ8hXtj8XqT/OJw=;
 fh=UcfSsF1JFfKTZpvDcHg8guiyrH9I9JI3OEZOq7iYxV0=;
 b=JD2b2ir+OQuuAhi3+YiwK9CqSy19bt0mcesU1cFFW53VuVVOXmVDKFTLn5glXJVxpc
 YKluqDXMJwYHnq8drJKHTow/xQfbSVEAKWm9n+97yZZHSdieT/wb9e8wkGC5lVI6hQM0
 iWcRkbAXnv9akdh647g5vC2u6YDAJ8PD+ykgr4sUgCiLjk9iOnZ1caBZaX1ZOuf++8DP
 eg9YGwJPyUsXBJv4nxLZJKJFLcb9nOcr9i7tEFA3DgmkJq7qXvn0flyY28bIEcd2J7Dy
 QaOoup3Mejt6j/yHoMomaxsrE4QXXBoa8gULMt+PxnV015Ov7KfVRXQT/69mruBfvJOY
 U91Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588181; x=1793192981;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=38tB8txbv/TMCFTTJMSbw5Re7xhtSJ8hXtj8XqT/OJw=;
 b=oEiRnZ3oGoA552R1nlCaNW+uZQ/eHDMIEUG06GKi9LV0TmiYps9hq/C7OfOXRqBHTB
 tEXgIkuCs8yJuJ+iiPtTKIPAGnwzQrKsZ4nOaI6R5UYZzM7Icl21erlkha6KlmsbE+SH
 Sd9uhBMpJO4E12j+vHP5LP0Ge6S06G6skoMxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588181; x=1793192981;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=38tB8txbv/TMCFTTJMSbw5Re7xhtSJ8hXtj8XqT/OJw=;
 b=SDqIVKRvcymHd6zFW0bUY5fYs+gOWCjz5X337A9DsPPtZCiBvUAr2uEMDRsDzZCL5D
 7ZHngz1YKlEVAmZtqYEznKmQ1MEjluLFeHkPwQ1fup4pjj5GX9GooNAMvTESmave2DBG
 VpVnHh14V+7DLwqy5NmAW/vcZmGEl1pXzt2vFaGg/0WG94c8GuKtK3V0xq8cJndibh+k
 v/uwTJcbvzWECAB/D9nlSQFqYAfYY1SlSM7Qfk4wtaG/AaW1Ihkfbxm7/PhAe9Fnsld1
 H/CKvobYqnNM1RbDEBDrD7wbDyIIbAq5wbANznFKmMpPVjBD6CcOkA6FIyL5W32JG1L/
 ZUgA==
X-Gm-Message-State: AFq9FYIcwa4Gt3QmeQAkLVf0bex2KyuNrqHqbT+zUGyefgier5rqDN/J
 Xf9ceZgZ/0e1YqqMDNcF7CvpSrtIkJ8IGloLpQbyuPP4FAslWfmug9G2kDtPD6dAV4pJMP/jPEu
 imc2vVBplqm9gwSy4PPDyR9A+FE0lZfjpai48TLZf+BpSc0EiB1ahcw==
X-Gm-Gg: AYBFou1jy7bPwBNn/rYt6JFuShgE+4vfQvEPDogOmmai48MfWFHX9PxTHiOhtwdBU+O
 pNLspGceoLawQXvp4ciEz7l1E+INewD+9NYdJzxU5pywBu7GGo901IIKoa9eV2+N48aAoTx50Ho
 XPhGPTwbBMooDVqrpjehFcVs9+RKA+lxRyUPL/RjAHZrgA0JiW2yHtvBsWVoxf1NfqWOnz5YFvl
 C6k+3JR04QsYdH4DzJWIHh+ygG3NYX6lTtUILHjDzxVfa9ll3w76AmouJr7/UHP9J3FJ7LFcp+j
 X+fqmu7AEg6hQC4y4esjVc0PxVOKr2VMFVr2mSq7qfc7a+U8lONqF6WgFh05GcA67d1VyEP745K
 ixNS3ETM6o9GantXML3O0lFLGwQGmOljLP1U=
X-Received: by 2002:a17:902:e745:b0:2e2:d02d:a173 with SMTP id
 d9443c01a7336-2ea4402c253mr15588175ad.49.1792588180875; Wed, 21 Oct 2026
 06:09:40 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 15:09:38 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:40:41 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <OSCPR01MB15019C116B8EF0F0F25638E80BC9E2@OSCPR01MB15019.jpnprd01.prod.outlook.com>
References: <OSCPR01MB15019C116B8EF0F0F25638E80BC9E2@OSCPR01MB15019.jpnprd01.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 15:09:38 +0200
X-Gm-Features: AclHuK-ILloIjmnabAmgyBQ-h1tpPusxer6SbYYpyPa3spjdLakgS6fFjp_9YYg
Message-ID: <CAFLszThu2P1u85BA0Jgr4FGRQgHmtncxnxK1rwfr9gWAUKuvMA@mail.gmail.com>
Subject: Re: [PATCH] cmd/meminfo: fix top lmb information
To: yangshiji66@outlook.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shiji,

On 2026-10-13T15:04:41, Shiji Yang <yangshiji66@outlook.com> wrote:
> cmd/meminfo: fix top lmb information
>
> Always assume that the top lmb is the u-boot region. Set *uptop to
> 0 to avoid printing meaningless Gap size, as it ends at the end of
> memory, just like the `code` region.

Please can you show the 'meminfo' output before and after, so it is
clear what is being fixed. Also please add a Fixes: tag for
9252b7f867f ("meminfo: Show the lmb records"), which is where the
broken condition comes from.

>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>
>  cmd/meminfo.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> @@ -40,15 +40,14 @@ static void show_lmb(const struct lmb *lmb, ulong *uptop)
> -		/*
> -		 * Assume that the top lmb region is the U-Boot region, so just
> -		 * take account of the memory not already reported
> -		 */
> -		if (lmb->used_mem.count - 1)
> +		/* Assume that the top lmb region is the U-Boot region */
> +		if (i == lmb->used_mem.count - 1) {
> +			*uptop = 0;
> +			print_region("lmb", rgn->base, rgn->size, uptop);
> +		} else {
>  			print_region("lmb", rgn->base, *uptop - rgn->base,
>  				     uptop);
> -		else
> -			print_region("lmb", rgn->base, rgn->size, uptop);
> +		}

You are right that the condition is wrong, but I think the two
branches are now the wrong way round. lmb_reserve_uboot_region()
reserves from the stack bottom up to initial_relocaddr, so the top lmb
region covers everything already printed (stack, bloblist, ..., code,
video). The intent of the comment you removed is that only the part of
that region below what is already reported gets shown, i.e. '*uptop -
rgn->base' for the top region and 'rgn->size' for all the others.

With this patch the top region shows its full size, overlapping all
the lines above it, and its gap is hidden. Every other lmb region gets
a size that runs up to the base of the region above it, so its gap is
always 0 and any real holes between reservations disappear.

I think the fix is just:

   if (i == lmb->used_mem.count - 1)
           print_region('lmb', rgn->base, *uptop - rgn->base,
                        uptop);
   else
           print_region('lmb', rgn->base, rgn->size, uptop);

and you can keep the original comment. What do you think?

BTW the '*uptop = rgn->base' after this is redundant, since
print_region() already does it. It would be worth dropping it while
you are here.

Regards,
Simon
