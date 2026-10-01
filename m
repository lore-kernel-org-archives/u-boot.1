Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD76CA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 08:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B26E812C2;
	Thu,  1 Oct 2026 08:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4K1vevATJEbT; Thu,  1 Oct 2026 08:23:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C158D812AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790843009;
	b=eEvYzzd9UWUaVKrDBInC+3ST/9jZbb8nZMSOLevbRuNFJchgNA6F7u5RfEs48lGb0cse
	 hecDX90QpF35XPmJVUCkMNPEZUCxx+NE/0gha2xv0+b148khVLAMxbSJkLjyv0BkOzcxD
	 Cx+qQD7pPXBVexE3SmrE3qZgjQ6/XPifjCj8eW4TVZPo2X3gqObmR62DIGfyVRESzUgtD
	 AuePXUYkg1vUm7zaQj3ZpxD/4ADhGZSEQ46tDztg1+GvGw5Wy31ZN6MyMFzlq6ZhGYi5L
	 HJyyJWRKybzHkEbolJicHksytt+VYLov/kswo/MXK+MFDYXkOPMLZGfCzfV3HUXnrEg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790843009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m6cGfbBCKI7Fb8DXva035lXZ59iRgU0a1FO6ANIbMiM=;
	b=WkxrfGZFOpOg1o6UzvlPjcvWvZC5AsNrXjZzsMoalpXZvTEqNdy0+nrLvdnicIodCRGM
	 sf2LFMWoEfQGTgVu5M354Igq7gUab6wGjtFCGcc5H/LIUDIxBDvM8Tf2W0NZdnbr7rAKq
	 r7/QYCy/Sa4rNLz5WnJHP6YWO+HQe/wQt9uWks68lUXUsnLwnY8tLEBNcofYqG+uq34zS
	 sWR/8oKLoKtWHqClXzO0H4dr8lGi2Dtgv44/Uz8xh0fOkpSOhklDZArlsnZN+WAtXJjZ3
	 HfZy9cTJxdbq1r6EDcjx4JvEESp1rZqF7DFtIEa2FjVgqnmFIN3inI3piwYXCYJD5Yw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790843009;
	bh=m6cGfbBCKI7Fb8DXva035lXZ59iRgU0a1FO6ANIbMiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wgPk1Q+j9y5o429xAiD7Uclgt3Dteyy9sufKRGCvAqf4XfhxyxrO5WsyBHZfDdwMe
	 krG6OpmRWTYeb+j9BvKTL+ZmcPWeeXRnxHREHOo9QX5VovhdfCnvBBsjBKQxAhP81N
	 94NQwPk2LUjPACLlu7+P0wXieRnMhx0mcu6PoRmT8D9AWj54E22qe3QNj4eocLghlU
	 uiNN25VzKBdu54p3qyLR1K4f7yof1+ZVkZKzUVUIC64wbw76wquieZix4X0FEsiQEw
	 LFcpAoFSPlyx6eiW6enA6/zyk5NqotihQ1IWrpYRoGvAWnmuDBr04pgIvN75q7rPl9
	 2rEi1LbmANVBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C158D812AC;
	Thu,  1 Oct 2026 08:23:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A7A1263
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C36240D19
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tfh2XYsQukl5 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 08:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6F90C40D0C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790843007;
 b=slXvrzF8B2mp/uGG5Octyl9Hg5qbMi4rF2PBjZjgnaWGrZjmywW+o++lYrdCd6sFtyJx
 pel56qBeSwGOA+FdJ4wZuwxOT56T+LOs39Y08B8Vr35zqS5zuxalVwHLV7zeZ5CXWYQMk
 zgE4lRT1eaWanju8a5Hx/GV2NygJK6IFnEhVNvZ2KaNG69dRrR9U8sFaGUc0t/V4LR7b+
 3YsPaXfjyTfP08bgqCdQeTl+v53MOz9flkSWVY2pc98msLT8b1e76owtSwD3+y7+p+P1y
 tjJmKfKTpAKtrV1l51snGjvmepR6l0StfGVdc5X1O7gl+RHbNLJ9VvEsf31rhc6WLWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790843007;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=m6cGfbBCKI7Fb8DXva035lXZ59iRgU0a1FO6ANIbMiM=;
 b=M+T74q/oRDjOV0ZyHaDYleekC1zuOXOUn7pQPswCjWn041WnmT4Q72N0lUhdGHqpyOjg
 VT67jT2mDiTlCwELTYM5cmtnK48VrO6k0B4TM9Oo+szMHOInvqBSAxjs7hEcYgo3nT04D
 S01KusF0X7fbfgkpk5DDNmg39f2/9z8yla6QcyJSKYu/oReanPpp1QKJeGOcS1gMZ68He
 4knLRMidI3ObOfymie06ucLa/x2+Z6UCplolWcYdktVHyjcedaDpTzCZ/paanneGSz9ec
 GLXlt0n5HZnHVSMtL/Z4EBfzMkv+2F7XPQu+oKxZo0ZcXlj7kUneF+RKzhtiL2zFCag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DcOIEWU0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DcOIEWU0
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F90C40D0C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:23:27 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac768bda6aso7141872a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 01:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790843005; cv=none;
 d=google.com; s=arc-20260327;
 b=dFSjp6+SCcHuYNICQYdDxS0anmtQwM1W7+0PXhreJkdZ2eeEGXj0VW37GEnGbrmu4n
 SMBNBlCt/PrVMzlnkvQDtNY6bUpMThAH38uPRazj5ZuG2OKEh0qOAm5Mdth1jn53Ga4g
 ABTi0TBrmrajlOEVMmqTC9oESj/QsaHguhduk73GX8nOFtVKLNEr8RRH/dHHQmF/Wknw
 4zlhfA6AnVwN2uwzp1Q0qtYxpwtUkFclH0rAPv/NUZjyY0HIR11dC9AEjhxrCpwK5OdK
 pYjWKnNRsOGfaz1HXA/xs92z1wcvr2kIqhSufD8+ytS/PmqVrpGJPGcKGLqu9gq6PwPP
 plPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m6cGfbBCKI7Fb8DXva035lXZ59iRgU0a1FO6ANIbMiM=;
 fh=dTODIB8eOV8QmMXTO6NS9hJAq2JPVHLo51odT60wrm8=;
 b=AYL1gbSIyjrNazEOR78KkpTvT6scE4/mQMJsAk43sz2lZKAysylQIdHFYwAHk8WafC
 /OKMu1TnWJhCWZnCUMRXXSjYuRsI43nEQtJOq96+uWrYbpTwYo/27QHacprOumf7z3EV
 mlnos1XxUr6P91SzISn/nCKt1R5sBW9/nPevoxtZpT6QZtMEMrtDhhYBSfoCBwMV9rL9
 Gzp0PrrnOkjuK+VevFn9aib6tXsxodQD7G0kIail86E2PQOh0K4e7fbr7md5pt8uKAR5
 NKPTLAx0ilGa7vwib2/n7P1kiIj6ldqx067rabif/rBbjRpbI79AEoosdrLE/h3cFRes
 QYmg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790843005; x=1791447805;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m6cGfbBCKI7Fb8DXva035lXZ59iRgU0a1FO6ANIbMiM=;
 b=DcOIEWU0yt7NUbcKhWC1/dzmg/KfMsjvmlJQ/Z25Wh5h6P4QYY8yfczD8EVPJKxqwC
 Ck2NmvX5F9JGF05nPLCW2tw+GHQCxM9/Xpm12w3ARQRgazzcSZTNH/sCwNzlQ4c746XY
 NpvnxsH/2+X9PW1hSdMp0gwiVu8Yl0zGzp0+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790843005; x=1791447805;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m6cGfbBCKI7Fb8DXva035lXZ59iRgU0a1FO6ANIbMiM=;
 b=X3F2d401LeZTGESGD57CRoEA4NPUuP/zOcZ1EPIUYHSnDmH05sn8K795oQHCikXy8U
 n3Kylxmpkp3l+6eVewuP1hUXlKaSr8sM4RtHzABsUIkRjrnAlbdK3EaMV9nBFNuAEx9x
 0fss73qGmM7IWu3fR9PFx+WbDkbyBo4JJ/NERqRATjTw+8cKdH4TS+29ziBpH3dyiJRo
 icsC8tgRDMoKKittC23ShC7OHkoXdTMKQ16aBsHDVLyJAMbxlDl/Aosy38Dqt5eQEg63
 xlTHrYeG6RX6ITv1RPLNJtN/cFPnIWXNGpZQbZKDVsHxzVgfxhJ5wBw2t7S59FuY0IhF
 XJvA==
X-Gm-Message-State: AFq9FYLpgHMgY5UfYNzIdp3xCzzZGcz4JCVbX5xX2tRzvZ50ZHx9IFJA
 TIbSodT+HEIMCPFiOEvEvKi+lVAar9CzD/mEbJUI5/kZM9BZAKTHTWSIzZtJIUZIO5mOdbued+K
 X+Ud37XgfRpNgV6TeUMiCNsVz34uqd0x8mynlcHwu
X-Gm-Gg: AYBFou1ixvKUjB0V/2sx24W6Wb5+LTlURpHcRc3tqJoU4kM3kTJkNksT+br7k7OHFTO
 sX2N/2Oyagcd6hxItIUxDauEU7exVcOCQ9mQ3V4dEi5piWTSmP4Jw3JzxKaMwagMkCODEyeyW02
 BqwgaT55cMq1YFv6692zgxvvLEopF1aHnLDHqJrcrpWQgU4WZDs9hf9s1JR8vV/6uSH+9CxAQyo
 U6y0R4ocTJWFEztRDO7wVLa0b2SjOZGtw+GBen2Q3ejl35r5M4yby+Jy9J7dLD5nri2JYeQnQBs
 GcZ9sJ2GgHxRnCzXdba32zgpE9EsObJ62oB5J9RqF1lBB5HFkKN8Zoz9
X-Received: by 2002:a05:6402:3209:b0:6aa:a040:cbe1 with SMTP id
 4fb4d7f45d1cf-6ae198f3b57mr3261516a12.8.1790843005114; Thu, 01 Oct 2026
 01:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261001012043.570450-1-trini@konsulko.com>
In-Reply-To: <20261001012043.570450-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 09:23:12 +0100
X-Gm-Features: AclHuK-GW6F3Cp9mQeDm5HBL_kOWyZ97SOMjoOEVvtJeqcnnIYuPNEPCrGiPdMw
Message-ID: <CAFLszThA1NJcKwiRexuaSLUuY56oyhhg8No16JciBcP9mNEWJw@mail.gmail.com>
Subject: Re: [PATCH] Gitlab CI: Temporarily limit thread count on world builds
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
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

On Thu, 1 Oct 2026 at 02:20, Tom Rini <trini@konsulko.com> wrote:
>
> At present, our "fast" runners provided by OSU OSL have a CPU thread
> count limit of 28, which means that we don't run our jobs as quickly as
> we might expect given the number of threads that nproc sees here. On the
> OSU OSL side of things, they are aware and working on a set of overall
> improvements to everyone using the shared infrastructure. For the
> moment, we want to limit buildman to 28 threads when on an "osuosl"
> tagged runner, and whatever nproc sees on the rest.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .gitlab-ci.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e08068f1cbf5..c5ff5341a1ef 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -157,8 +157,9 @@ build all platforms in a single job:
>          -r board/qualcomm/requirements.txt
>          setuptools
>      - ret=0;
> +      THREADS=`echo ${CI_RUNNER_TAGS} | grep -q osuosl && echo 28 || nproc`;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
> -      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
> +      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa -T ${THREADS} || ret=$?;
>        if [[ $ret -ne 0 ]]; then
>          ./tools/buildman/buildman -o /tmp -seP;
>          exit $ret;
> --
> 2.43.0
>
